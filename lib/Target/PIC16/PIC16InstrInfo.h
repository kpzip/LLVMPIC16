//===- PIC16InstrInfo.h - PIC16 Instruction Information----------*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the niversity of Illinois Open Source 
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file contains the PIC16 implementation of the TargetInstrInfo class.
//
//===----------------------------------------------------------------------===//

#ifndef PIC16INSTRUCTIONINFO_H
#define PIC16INSTRUCTIONINFO_H

#include "PIC16.h"
#include "PIC16RegisterInfo.h"
#include "llvm/CodeGen/TargetInstrInfo.h"

#define GET_INSTRINFO_HEADER
#define GET_INSTRINFO_ENUM
#include "PIC16GenInstrInfo.inc"

namespace llvm {

class PIC16InstrInfo : public PIC16GenInstrInfo {
  PIC16TargetMachine &TM;
  const PIC16RegisterInfo RegInfo;
public:
  explicit PIC16InstrInfo(PIC16TargetMachine &TM);

  virtual const PIC16RegisterInfo &getRegisterInfo() const { return RegInfo; }

  /// isLoadFromStackSlot - If the specified machine instruction is a direct
  /// load from a stack slot, return the virtual or physical register number of
  /// the destination along with the FrameIndex of the loaded stack slot.  If
  /// not, return 0.  This predicate must return 0 if the instruction has
  /// any side effects other than loading from the stack slot.
  virtual unsigned isLoadFromStackSlot(const MachineInstr *MI, 
                                       int &FrameIndex) const;
                                                                               
  /// isStoreToStackSlot - If the specified machine instruction is a direct
  /// store to a stack slot, return the virtual or physical register number of
  /// the source reg along with the FrameIndex of the loaded stack slot.  If
  /// not, return 0.  This predicate must return 0 if the instruction has
  /// any side effects other than storing to the stack slot.
  virtual unsigned isStoreToStackSlot(const MachineInstr *MI, 
                                      int &FrameIndex) const;

  virtual void storeRegToStackSlot(MachineBasicBlock &MBB,
                                   MachineBasicBlock::iterator MBBI,
                                   unsigned SrcReg, bool isKill, int FrameIndex,
                                   const TargetRegisterClass *RC,
                                   const TargetRegisterInfo *TRI) const;
                                                                               
  virtual void loadRegFromStackSlot(MachineBasicBlock &MBB,
                                    MachineBasicBlock::iterator MBBI,
                                    unsigned DestReg, int FrameIndex,
                                    const TargetRegisterClass *RC,
                                    const TargetRegisterInfo *TRI) const;
  virtual void copyPhysReg(MachineBasicBlock &MBB,
                           MachineBasicBlock::iterator I, DebugLoc DL,
                           unsigned DestReg, unsigned SrcReg,
                           bool KillSrc) const;
  virtual 
  unsigned InsertBranch(MachineBasicBlock &MBB, MachineBasicBlock *TBB,
                        MachineBasicBlock *FBB,
                        const SmallVectorImpl<MachineOperand> &Cond,
                        DebugLoc DL) const; 
  virtual bool AnalyzeBranch(MachineBasicBlock &MBB, MachineBasicBlock *&TBB,
                             MachineBasicBlock *&FBB,
                             SmallVectorImpl<MachineOperand> &Cond,
                             bool AllowModify) const;
  };
} // namespace llvm

#endif
