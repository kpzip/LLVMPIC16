//===- TrackerTest.cpp ----------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "llvm/AsmParser/Parser.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Instruction.h"
#include "llvm/IR/Module.h"
#include "llvm/SandboxIR/SandboxIR.h"
#include "llvm/Support/SourceMgr.h"
#include "gtest/gtest.h"

using namespace llvm;

struct TrackerTest : public testing::Test {
  LLVMContext C;
  std::unique_ptr<Module> M;

  void parseIR(LLVMContext &C, const char *IR) {
    SMDiagnostic Err;
    M = parseAssemblyString(IR, Err, C);
    if (!M)
      Err.print("TrackerTest", errs());
  }
  BasicBlock *getBasicBlockByName(Function &F, StringRef Name) {
    for (BasicBlock &BB : F)
      if (BB.getName() == Name)
        return &BB;
    llvm_unreachable("Expected to find basic block!");
  }
};

TEST_F(TrackerTest, SetOperand) {
  parseIR(C, R"IR(
define void @foo(ptr %ptr) {
  %gep0 = getelementptr float, ptr %ptr, i32 0
  %gep1 = getelementptr float, ptr %ptr, i32 1
  %ld0 = load float, ptr %gep0
  store float undef, ptr %gep0
  ret void
}
)IR");
  Function &LLVMF = *M->getFunction("foo");
  sandboxir::Context Ctx(C);
  auto *F = Ctx.createFunction(&LLVMF);
  auto *BB = &*F->begin();
  auto &Tracker = Ctx.getTracker();
  Tracker.save();
  auto It = BB->begin();
  auto *Gep0 = &*It++;
  auto *Gep1 = &*It++;
  auto *Ld = &*It++;
  auto *St = &*It++;
  St->setOperand(0, Ld);
  St->setOperand(1, Gep1);
  Ld->setOperand(0, Gep1);
  EXPECT_EQ(St->getOperand(0), Ld);
  EXPECT_EQ(St->getOperand(1), Gep1);
  EXPECT_EQ(Ld->getOperand(0), Gep1);

  Ctx.getTracker().revert();
  EXPECT_NE(St->getOperand(0), Ld);
  EXPECT_EQ(St->getOperand(1), Gep0);
  EXPECT_EQ(Ld->getOperand(0), Gep0);
}

TEST_F(TrackerTest, RUWIf_RAUW_RUOW) {
  parseIR(C, R"IR(
define void @foo(ptr %ptr) {
  %ld0 = load float, ptr %ptr
  %ld1 = load float, ptr %ptr
  store float %ld0, ptr %ptr
  store float %ld0, ptr %ptr
  ret void
}
)IR");
  llvm::Function &LLVMF = *M->getFunction("foo");
  sandboxir::Context Ctx(C);
  llvm::BasicBlock *LLVMBB = &*LLVMF.begin();
  Ctx.createFunction(&LLVMF);
  auto *BB = cast<sandboxir::BasicBlock>(Ctx.getValue(LLVMBB));
  auto It = BB->begin();
  sandboxir::Instruction *Ld0 = &*It++;
  sandboxir::Instruction *Ld1 = &*It++;
  sandboxir::Instruction *St0 = &*It++;
  sandboxir::Instruction *St1 = &*It++;
  Ctx.save();
  // Check RUWIf when the lambda returns false.
  Ld0->replaceUsesWithIf(Ld1, [](const sandboxir::Use &Use) { return false; });
  EXPECT_EQ(St0->getOperand(0), Ld0);
  EXPECT_EQ(St1->getOperand(0), Ld0);

  // Check RUWIf when the lambda returns true.
  Ld0->replaceUsesWithIf(Ld1, [](const sandboxir::Use &Use) { return true; });
  EXPECT_EQ(St0->getOperand(0), Ld1);
  EXPECT_EQ(St1->getOperand(0), Ld1);
  Ctx.revert();
  EXPECT_EQ(St0->getOperand(0), Ld0);
  EXPECT_EQ(St1->getOperand(0), Ld0);

  // Check RUWIf user == St0.
  Ctx.save();
  Ld0->replaceUsesWithIf(
      Ld1, [St0](const sandboxir::Use &Use) { return Use.getUser() == St0; });
  EXPECT_EQ(St0->getOperand(0), Ld1);
  EXPECT_EQ(St1->getOperand(0), Ld0);
  Ctx.revert();
  EXPECT_EQ(St0->getOperand(0), Ld0);
  EXPECT_EQ(St1->getOperand(0), Ld0);

  // Check RUWIf user == St1.
  Ctx.save();
  Ld0->replaceUsesWithIf(
      Ld1, [St1](const sandboxir::Use &Use) { return Use.getUser() == St1; });
  EXPECT_EQ(St0->getOperand(0), Ld0);
  EXPECT_EQ(St1->getOperand(0), Ld1);
  Ctx.revert();
  EXPECT_EQ(St0->getOperand(0), Ld0);
  EXPECT_EQ(St1->getOperand(0), Ld0);

  // Check RAUW.
  Ctx.save();
  Ld1->replaceAllUsesWith(Ld0);
  EXPECT_EQ(St0->getOperand(0), Ld0);
  EXPECT_EQ(St1->getOperand(0), Ld0);
  Ctx.revert();
  EXPECT_EQ(St0->getOperand(0), Ld0);
  EXPECT_EQ(St1->getOperand(0), Ld0);

  // Check RUOW.
  Ctx.save();
  St0->replaceUsesOfWith(Ld0, Ld1);
  EXPECT_EQ(St0->getOperand(0), Ld1);
  Ctx.revert();
  EXPECT_EQ(St0->getOperand(0), Ld0);

  // Check accept().
  Ctx.save();
  St0->replaceUsesOfWith(Ld0, Ld1);
  EXPECT_EQ(St0->getOperand(0), Ld1);
  Ctx.accept();
  EXPECT_EQ(St0->getOperand(0), Ld1);
}

// TODO: Test multi-instruction patterns.
TEST_F(TrackerTest, EraseFromParent) {
  parseIR(C, R"IR(
define void @foo(i32 %v1) {
  %add0 = add i32 %v1, %v1
  %add1 = add i32 %add0, %v1
  ret void
}
)IR");
  Function &LLVMF = *M->getFunction("foo");
  sandboxir::Context Ctx(C);

  auto *F = Ctx.createFunction(&LLVMF);
  auto *BB = &*F->begin();
  auto It = BB->begin();
  sandboxir::Instruction *Add0 = &*It++;
  sandboxir::Instruction *Add1 = &*It++;
  sandboxir::Instruction *Ret = &*It++;

  Ctx.save();
  // Check erase.
  Add1->eraseFromParent();
  It = BB->begin();
  EXPECT_EQ(&*It++, Add0);
  EXPECT_EQ(&*It++, Ret);
  EXPECT_EQ(It, BB->end());
  EXPECT_EQ(Add0->getNumUses(), 0u);

  // Check revert().
  Ctx.revert();
  It = BB->begin();
  EXPECT_EQ(&*It++, Add0);
  EXPECT_EQ(&*It++, Add1);
  EXPECT_EQ(&*It++, Ret);
  EXPECT_EQ(It, BB->end());
  EXPECT_EQ(Add1->getOperand(0), Add0);

  // Same for the last instruction in the block.
  Ctx.save();
  Ret->eraseFromParent();
  It = BB->begin();
  EXPECT_EQ(&*It++, Add0);
  EXPECT_EQ(&*It++, Add1);
  EXPECT_EQ(It, BB->end());
  Ctx.revert();
  It = BB->begin();
  EXPECT_EQ(&*It++, Add0);
  EXPECT_EQ(&*It++, Add1);
  EXPECT_EQ(&*It++, Ret);
  EXPECT_EQ(It, BB->end());
}

// TODO: Test multi-instruction patterns.
TEST_F(TrackerTest, RemoveFromParent) {
  parseIR(C, R"IR(
define i32 @foo(i32 %arg) {
  %add0 = add i32 %arg, %arg
  %add1 = add i32 %add0, %arg
  ret i32 %add1
}
)IR");
  Function &LLVMF = *M->getFunction("foo");
  sandboxir::Context Ctx(C);

  auto *F = Ctx.createFunction(&LLVMF);
  auto *Arg = F->getArg(0);
  auto *BB = &*F->begin();
  auto It = BB->begin();
  sandboxir::Instruction *Add0 = &*It++;
  sandboxir::Instruction *Add1 = &*It++;
  sandboxir::Instruction *Ret = &*It++;

  Ctx.save();
  // Check removeFromParent().
  Add1->removeFromParent();
  It = BB->begin();
  EXPECT_EQ(&*It++, Add0);
  EXPECT_EQ(&*It++, Ret);
  EXPECT_EQ(It, BB->end());
  // Removed instruction still be connected to operands and users.
  EXPECT_EQ(Add1->getOperand(0), Add0);
  EXPECT_EQ(Add1->getOperand(1), Arg);
  EXPECT_EQ(Add0->getNumUses(), 1u);

  // Check revert().
  Ctx.revert();
  It = BB->begin();
  EXPECT_EQ(&*It++, Add0);
  EXPECT_EQ(&*It++, Add1);
  EXPECT_EQ(&*It++, Ret);
  EXPECT_EQ(It, BB->end());
  EXPECT_EQ(Add1->getOperand(0), Add0);

  // Same for the last instruction in the block.
  Ctx.save();
  Ret->removeFromParent();
  It = BB->begin();
  EXPECT_EQ(&*It++, Add0);
  EXPECT_EQ(&*It++, Add1);
  EXPECT_EQ(It, BB->end());
  EXPECT_EQ(Ret->getOperand(0), Add1);
  Ctx.revert();
  It = BB->begin();
  EXPECT_EQ(&*It++, Add0);
  EXPECT_EQ(&*It++, Add1);
  EXPECT_EQ(&*It++, Ret);
  EXPECT_EQ(It, BB->end());
}

// TODO: Test multi-instruction patterns.
TEST_F(TrackerTest, MoveInstr) {
  parseIR(C, R"IR(
define i32 @foo(i32 %arg) {
  %add0 = add i32 %arg, %arg
  %add1 = add i32 %add0, %arg
  ret i32 %add1
}
)IR");
  Function &LLVMF = *M->getFunction("foo");
  sandboxir::Context Ctx(C);

  auto *F = Ctx.createFunction(&LLVMF);
  auto *BB = &*F->begin();
  auto It = BB->begin();
  sandboxir::Instruction *Add0 = &*It++;
  sandboxir::Instruction *Add1 = &*It++;
  sandboxir::Instruction *Ret = &*It++;

  // Check moveBefore(Instruction *) with tracking enabled.
  Ctx.save();
  Add1->moveBefore(Add0);
  It = BB->begin();
  EXPECT_EQ(&*It++, Add1);
  EXPECT_EQ(&*It++, Add0);
  EXPECT_EQ(&*It++, Ret);
  EXPECT_EQ(It, BB->end());
  // Check revert().
  Ctx.revert();
  It = BB->begin();
  EXPECT_EQ(&*It++, Add0);
  EXPECT_EQ(&*It++, Add1);
  EXPECT_EQ(&*It++, Ret);
  EXPECT_EQ(It, BB->end());

  // Same for the last instruction in the block.
  Ctx.save();
  Ret->moveBefore(Add0);
  It = BB->begin();
  EXPECT_EQ(&*It++, Ret);
  EXPECT_EQ(&*It++, Add0);
  EXPECT_EQ(&*It++, Add1);
  EXPECT_EQ(It, BB->end());
  Ctx.revert();
  It = BB->begin();
  EXPECT_EQ(&*It++, Add0);
  EXPECT_EQ(&*It++, Add1);
  EXPECT_EQ(&*It++, Ret);
  EXPECT_EQ(It, BB->end());

  // Check moveBefore(BasicBlock &, BasicBlock::iterator) with tracking enabled.
  Ctx.save();
  Add1->moveBefore(*BB, Add0->getIterator());
  It = BB->begin();
  EXPECT_EQ(&*It++, Add1);
  EXPECT_EQ(&*It++, Add0);
  EXPECT_EQ(&*It++, Ret);
  EXPECT_EQ(It, BB->end());
  // Check revert().
  Ctx.revert();
  It = BB->begin();
  EXPECT_EQ(&*It++, Add0);
  EXPECT_EQ(&*It++, Add1);
  EXPECT_EQ(&*It++, Ret);
  EXPECT_EQ(It, BB->end());

  // Same for the last instruction in the block.
  Ctx.save();
  Ret->moveBefore(*BB, Add0->getIterator());
  It = BB->begin();
  EXPECT_EQ(&*It++, Ret);
  EXPECT_EQ(&*It++, Add0);
  EXPECT_EQ(&*It++, Add1);
  EXPECT_EQ(It, BB->end());
  // Check revert().
  Ctx.revert();
  It = BB->begin();
  EXPECT_EQ(&*It++, Add0);
  EXPECT_EQ(&*It++, Add1);
  EXPECT_EQ(&*It++, Ret);
  EXPECT_EQ(It, BB->end());

  // Check moveAfter(Instruction *) with tracking enabled.
  Ctx.save();
  Add0->moveAfter(Add1);
  It = BB->begin();
  EXPECT_EQ(&*It++, Add1);
  EXPECT_EQ(&*It++, Add0);
  EXPECT_EQ(&*It++, Ret);
  EXPECT_EQ(It, BB->end());
  // Check revert().
  Ctx.revert();
  It = BB->begin();
  EXPECT_EQ(&*It++, Add0);
  EXPECT_EQ(&*It++, Add1);
  EXPECT_EQ(&*It++, Ret);
  EXPECT_EQ(It, BB->end());

  // Same for the last instruction in the block.
  Ctx.save();
  Ret->moveAfter(Add0);
  It = BB->begin();
  EXPECT_EQ(&*It++, Add0);
  EXPECT_EQ(&*It++, Ret);
  EXPECT_EQ(&*It++, Add1);
  EXPECT_EQ(It, BB->end());
  // Check revert().
  Ctx.revert();
  It = BB->begin();
  EXPECT_EQ(&*It++, Add0);
  EXPECT_EQ(&*It++, Add1);
  EXPECT_EQ(&*It++, Ret);
  EXPECT_EQ(It, BB->end());
}
