//===--- WebAssemblyExceptionInfo.cpp - Exception Infomation --------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
///
/// \file
/// \brief This file implements WebAssemblyException information analysis.
///
//===----------------------------------------------------------------------===//

#include "WebAssemblyExceptionInfo.h"
#include "MCTargetDesc/WebAssemblyMCTargetDesc.h"
#include "WebAssemblyUtilities.h"
#include "llvm/ADT/DepthFirstIterator.h"
#include "llvm/ADT/PostOrderIterator.h"
#include "llvm/CodeGen/MachineDominanceFrontier.h"
#include "llvm/CodeGen/MachineDominators.h"
#include "llvm/CodeGen/WasmEHFuncInfo.h"
#include "llvm/InitializePasses.h"
#include "llvm/IR/Function.h"
#include "llvm/MC/MCAsmInfo.h"
#include "llvm/Target/TargetMachine.h"

using namespace llvm;

#define DEBUG_TYPE "wasm-exception-info"

char WebAssemblyExceptionInfo::ID = 0;

INITIALIZE_PASS_BEGIN(WebAssemblyExceptionInfo, DEBUG_TYPE,
                      "WebAssembly Exception Information", true, true)
INITIALIZE_PASS_DEPENDENCY(MachineDominatorTreeWrapperPass)
INITIALIZE_PASS_DEPENDENCY(MachineDominanceFrontier)
INITIALIZE_PASS_END(WebAssemblyExceptionInfo, DEBUG_TYPE,
                    "WebAssembly Exception Information", true, true)

bool WebAssemblyExceptionInfo::runOnMachineFunction(MachineFunction &MF) {
  LLVM_DEBUG(dbgs() << "********** Exception Info Calculation **********\n"
                       "********** Function: "
                    << MF.getName() << '\n');
  releaseMemory();
  if (MF.getTarget().getMCAsmInfo()->getExceptionHandlingType() !=
          ExceptionHandling::Wasm ||
      !MF.getFunction().hasPersonalityFn())
    return false;
  auto &MDT = getAnalysis<MachineDominatorTreeWrapperPass>().getDomTree();
  auto &MDF = getAnalysis<MachineDominanceFrontier>();
  recalculate(MF, MDT, MDF);
  LLVM_DEBUG(dump());
  return false;
}

// Check if Dst is reachable from Src using BFS. Search only within BBs
// dominated by Header.
static bool isReachableAmongDominated(const MachineBasicBlock *Src,
                                      const MachineBasicBlock *Dst,
                                      const MachineBasicBlock *Header,
                                      const MachineDominatorTree &MDT) {
  assert(MDT.dominates(Header, Dst));
  SmallVector<const MachineBasicBlock *, 8> WL;
  SmallPtrSet<const MachineBasicBlock *, 8> Visited;
  WL.push_back(Src);

  while (!WL.empty()) {
    const auto *MBB = WL.pop_back_val();
    if (MBB == Dst)
      return true;
    Visited.insert(MBB);
    for (auto *Succ : MBB->successors())
      if (!Visited.count(Succ) && MDT.dominates(Header, Succ))
        WL.push_back(Succ);
  }
  return false;
}

void WebAssemblyExceptionInfo::recalculate(
    MachineFunction &MF, MachineDominatorTree &MDT,
    const MachineDominanceFrontier &MDF) {
  // Postorder traversal of the dominator tree.
  SmallVector<std::unique_ptr<WebAssemblyException>, 8> Exceptions;
  for (auto *DomNode : post_order(&MDT)) {
    MachineBasicBlock *EHPad = DomNode->getBlock();
    if (!EHPad->isEHPad())
      continue;
    auto WE = std::make_unique<WebAssemblyException>(EHPad);
    discoverAndMapException(WE.get(), MDT, MDF);
    Exceptions.push_back(std::move(WE));
  }

  // WasmEHFuncInfo contains a map of <catchpad, its next unwind destination>,
  // which means, if an exception is not caught by the catchpad, it should end
  // up in the next unwind destination stored in this data structure. (It is
  // written as catchswitch's 'unwind' destination in ll files.) The below is an
  // intuitive example of their relationship in C++ code:
  // try {
  //   try {
  //   } catch (int) { // catchpad
  //      ...          // this catch (int) { ... } is grouped as an exception
  //   }
  // } catch (...) {   // next unwind destination
  // }
  // (The example is try-catches for illustration purpose, but the unwind
  // destination can be also a cleanuppad generated by destructor calls.) So the
  // unwind destination is in the outside of the catchpad's exception.
  //
  // We group exceptions in this analysis simply by including all BBs dominated
  // by an EH pad. But in case the EH pad's unwind destination does not have any
  // children outside of the exception, that unwind destination ends up also
  // being dominated by the EH pad and included in the exception, which is not
  // semantically correct, because it unwinds/rethrows into an inner scope.
  //
  // Here we extract those unwind destinations from their (incorrect) parent
  // exception. Note that the unwind destinations may not be an immediate
  // children of the parent exception, so we have to traverse the parent chain.
  //
  // We should traverse BBs in the preorder of the dominator tree, because
  // otherwise the result can be incorrect. For example, when there are three
  // exceptions A, B, and C and A > B > C (> is subexception relationship here),
  // and A's unwind destination is B and B's is C. When we visit B before A, we
  // end up extracting C only out of B but not out of A.
  const auto *EHInfo = MF.getWasmEHFuncInfo();
  assert(EHInfo);
  SmallVector<std::pair<WebAssemblyException *, WebAssemblyException *>>
      UnwindWEVec;
  for (auto *DomNode : depth_first(&MDT)) {
    MachineBasicBlock *EHPad = DomNode->getBlock();
    if (!EHPad->isEHPad())
      continue;
    if (!EHInfo->hasUnwindDest(EHPad))
      continue;
    auto *UnwindDest = EHInfo->getUnwindDest(EHPad);
    auto *SrcWE = getExceptionFor(EHPad);
    auto *DstWE = getExceptionFor(UnwindDest);
    if (SrcWE->contains(DstWE)) {
      UnwindWEVec.push_back(std::make_pair(SrcWE, DstWE));
      LLVM_DEBUG(dbgs() << "Unwind destination ExceptionInfo fix:\n  "
                        << DstWE->getEHPad()->getNumber() << "."
                        << DstWE->getEHPad()->getName()
                        << "'s exception is taken out of "
                        << SrcWE->getEHPad()->getNumber() << "."
                        << SrcWE->getEHPad()->getName() << "'s exception\n");
      DstWE->setParentException(SrcWE->getParentException());
    }
  }

  // After fixing subexception relationship between unwind destinations above,
  // there can still be remaining discrepancies.
  //
  // For example, suppose Exception A is dominated by EHPad A and Exception B is
  // dominated by EHPad B. EHPad A's unwind destination is EHPad B, but because
  // EHPad B is dominated by EHPad A, the initial grouping makes Exception B a
  // subexception of Exception A, and we fix it by taking Exception B out of
  // Exception A above. But there can still be remaining BBs within Exception A
  // that are reachable from Exception B. These BBs semantically don't belong
  // to Exception A and were not a part of this 'catch' clause or cleanup code
  // in the original code, but they just happened to be grouped within Exception
  // A because they were dominated by EHPad A. We fix this case by taking those
  // BBs out of the incorrect exception and all its subexceptions that it
  // belongs to.
  //
  // 1. First, we take out remaining incorrect subexceptions. This part is
  // easier, because we haven't added BBs to exceptions yet, we only need to
  // change parent exception pointer.
  for (auto *DomNode : depth_first(&MDT)) {
    MachineBasicBlock *EHPad = DomNode->getBlock();
    if (!EHPad->isEHPad())
      continue;
    auto *WE = getExceptionFor(EHPad);

    // For each source EHPad -> unwind destination EHPad
    for (auto &P : UnwindWEVec) {
      auto *SrcWE = P.first;
      auto *DstWE = P.second;
      // If WE (the current EH pad's exception) is still contained in SrcWE but
      // reachable from DstWE that was taken out of SrcWE above, we have to take
      // out WE out of SrcWE too.
      if (WE != SrcWE && SrcWE->contains(WE) && !DstWE->contains(WE) &&
          isReachableAmongDominated(DstWE->getEHPad(), EHPad, SrcWE->getEHPad(),
                                    MDT)) {
        LLVM_DEBUG(dbgs() << "Remaining reachable ExceptionInfo fix:\n  "
                          << WE->getEHPad()->getNumber() << "."
                          << WE->getEHPad()->getName()
                          << "'s exception is taken out of "
                          << SrcWE->getEHPad()->getNumber() << "."
                          << SrcWE->getEHPad()->getName() << "'s exception\n");
        WE->setParentException(SrcWE->getParentException());
      }
    }
  }

  // Add BBs to exceptions' block set. This is a preparation to take out
  // remaining incorect BBs from exceptions, because we need to iterate over BBs
  // for each exception.
  for (auto *DomNode : post_order(&MDT)) {
    MachineBasicBlock *MBB = DomNode->getBlock();
    WebAssemblyException *WE = getExceptionFor(MBB);
    for (; WE; WE = WE->getParentException())
      WE->addToBlocksSet(MBB);
  }

  // 2. We take out remaining individual BBs out. Now we have added BBs to each
  // exceptions' BlockSet, when we take a BB out of an exception, we need to fix
  // those sets too.
  for (auto &P : UnwindWEVec) {
    auto *SrcWE = P.first;
    auto *DstWE = P.second;

    SrcWE->getBlocksSet().remove_if([&](MachineBasicBlock *MBB){
      if (MBB->isEHPad()) {
        assert(!isReachableAmongDominated(DstWE->getEHPad(), MBB,
                                          SrcWE->getEHPad(), MDT) &&
               "We already handled EH pads above");
        return false;
      }
      if (isReachableAmongDominated(DstWE->getEHPad(), MBB, SrcWE->getEHPad(),
                                    MDT)) {
        LLVM_DEBUG(dbgs() << "Remainder BB: " << MBB->getNumber() << "."
                          << MBB->getName() << " is\n");
        WebAssemblyException *InnerWE = getExceptionFor(MBB);
        while (InnerWE != SrcWE) {
          LLVM_DEBUG(dbgs()
                     << "  removed from " << InnerWE->getEHPad()->getNumber()
                     << "." << InnerWE->getEHPad()->getName()
                     << "'s exception\n");
          InnerWE->removeFromBlocksSet(MBB);
          InnerWE = InnerWE->getParentException();
        }
        LLVM_DEBUG(dbgs() << "  removed from " << SrcWE->getEHPad()->getNumber()
                          << "." << SrcWE->getEHPad()->getName()
                          << "'s exception\n");
        changeExceptionFor(MBB, SrcWE->getParentException());
        if (SrcWE->getParentException())
          SrcWE->getParentException()->addToBlocksSet(MBB);
        return true;
      }
      return false;
    });
  }

  // Add BBs to exceptions' block vector
  for (auto *DomNode : post_order(&MDT)) {
    MachineBasicBlock *MBB = DomNode->getBlock();
    WebAssemblyException *WE = getExceptionFor(MBB);
    for (; WE; WE = WE->getParentException())
      WE->addToBlocksVector(MBB);
  }

  SmallVector<WebAssemblyException*, 8> ExceptionPointers;
  ExceptionPointers.reserve(Exceptions.size());

  // Add subexceptions to exceptions
  for (auto &WE : Exceptions) {
    ExceptionPointers.push_back(WE.get());
    if (WE->getParentException())
      WE->getParentException()->getSubExceptions().push_back(std::move(WE));
    else
      addTopLevelException(std::move(WE));
  }

  // For convenience, Blocks and SubExceptions are inserted in postorder.
  // Reverse the lists.
  for (auto *WE : ExceptionPointers) {
    WE->reverseBlock();
    std::reverse(WE->getSubExceptions().begin(), WE->getSubExceptions().end());
  }
}

void WebAssemblyExceptionInfo::releaseMemory() {
  BBMap.clear();
  TopLevelExceptions.clear();
}

void WebAssemblyExceptionInfo::getAnalysisUsage(AnalysisUsage &AU) const {
  AU.setPreservesAll();
  AU.addRequired<MachineDominatorTreeWrapperPass>();
  AU.addRequired<MachineDominanceFrontier>();
  MachineFunctionPass::getAnalysisUsage(AU);
}

void WebAssemblyExceptionInfo::discoverAndMapException(
    WebAssemblyException *WE, const MachineDominatorTree &MDT,
    const MachineDominanceFrontier &MDF) {
  unsigned NumBlocks = 0;
  unsigned NumSubExceptions = 0;

  // Map blocks that belong to a catchpad / cleanuppad
  MachineBasicBlock *EHPad = WE->getEHPad();
  SmallVector<MachineBasicBlock *, 8> WL;
  WL.push_back(EHPad);
  while (!WL.empty()) {
    MachineBasicBlock *MBB = WL.pop_back_val();

    // Find its outermost discovered exception. If this is a discovered block,
    // check if it is already discovered to be a subexception of this exception.
    WebAssemblyException *SubE = getOutermostException(MBB);
    if (SubE) {
      if (SubE != WE) {
        // Discover a subexception of this exception.
        SubE->setParentException(WE);
        ++NumSubExceptions;
        NumBlocks += SubE->getBlocksVector().capacity();
        // All blocks that belong to this subexception have been already
        // discovered. Skip all of them. Add the subexception's landing pad's
        // dominance frontier to the worklist.
        for (auto &Frontier : MDF.find(SubE->getEHPad())->second)
          if (MDT.dominates(EHPad, Frontier))
            WL.push_back(Frontier);
      }
      continue;
    }

    // This is an undiscovered block. Map it to the current exception.
    changeExceptionFor(MBB, WE);
    ++NumBlocks;

    // Add successors dominated by the current BB to the worklist.
    for (auto *Succ : MBB->successors())
      if (MDT.dominates(EHPad, Succ))
        WL.push_back(Succ);
  }

  WE->getSubExceptions().reserve(NumSubExceptions);
  WE->reserveBlocks(NumBlocks);
}

WebAssemblyException *
WebAssemblyExceptionInfo::getOutermostException(MachineBasicBlock *MBB) const {
  WebAssemblyException *WE = getExceptionFor(MBB);
  if (WE) {
    while (WebAssemblyException *Parent = WE->getParentException())
      WE = Parent;
  }
  return WE;
}

void WebAssemblyException::print(raw_ostream &OS, unsigned Depth) const {
  OS.indent(Depth * 2) << "Exception at depth " << getExceptionDepth()
                       << " containing: ";

  for (unsigned I = 0; I < getBlocks().size(); ++I) {
    MachineBasicBlock *MBB = getBlocks()[I];
    if (I)
      OS << ", ";
    OS << "%bb." << MBB->getNumber();
    if (const auto *BB = MBB->getBasicBlock())
      if (BB->hasName())
        OS << "." << BB->getName();

    if (getEHPad() == MBB)
      OS << " (landing-pad)";
  }
  OS << "\n";

  for (auto &SubE : SubExceptions)
    SubE->print(OS, Depth + 2);
}

#if !defined(NDEBUG) || defined(LLVM_ENABLE_DUMP)
LLVM_DUMP_METHOD void WebAssemblyException::dump() const { print(dbgs()); }
#endif

raw_ostream &operator<<(raw_ostream &OS, const WebAssemblyException &WE) {
  WE.print(OS);
  return OS;
}

void WebAssemblyExceptionInfo::print(raw_ostream &OS, const Module *) const {
  for (auto &WE : TopLevelExceptions)
    WE->print(OS);
}
