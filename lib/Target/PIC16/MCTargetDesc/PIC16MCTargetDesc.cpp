/*
 * PIC16MCTargetDesc.cpp
 *
 *  Created on: Jan 28, 2025
 *      Author: Max Pastushkov
 */

#include "PIC16MCAsmInfo.h"
#include "PIC16Subtarget.h"
#include "TargetInfo/PIC16TargetInfo.h"

#include "llvm/MC/MCInstrInfo.h"
#include "llvm/MC/MCRegisterInfo.h"
#include "llvm/MC/TargetRegistry.h"
#include "llvm/MC/MCSubtargetInfo.h"

#define GET_REGINFO_MC_DESC
#define GET_REGINFO_ENUM
#include "PIC16GenRegisterInfo.h.inc"

#define GET_INSTRINFO_MC_DESC
#include "PIC16GenInstrInfo.inc"

#define GET_SUBTARGETINFO_MC_DESC
#include "PIC16GenSubtargetInfo.inc"

using namespace llvm;

static MCInstrInfo *createPIC16MCInstrInfo() {
  MCInstrInfo *X = new MCInstrInfo();
  InitPIC16MCInstrInfo(X);

  return X;
}

static MCRegisterInfo *createPIC16MCRegisterInfo(const Triple &TT) {
  MCRegisterInfo *X = new MCRegisterInfo();
  InitPIC16MCRegisterInfo(X, 0);

  return X;
}

static MCSubtargetInfo *createPIC16MCSubtargetInfo(const Triple &TT,
                                                 StringRef CPU, StringRef FS) {
  return createPIC16MCSubtargetInfoImpl(TT, CPU, /*TuneCPU*/ CPU, FS);
}

extern "C" LLVM_EXTERNAL_VISIBILITY void LLVMInitializePIC16TargetMC() {
  RegisterMCAsmInfo<PIC16MCAsmInfo> X(getThePIC16Target());

  // Register the MC instruction info.
  TargetRegistry::RegisterMCInstrInfo(getThePIC16Target(), createPIC16MCInstrInfo);

  // Register the MC register info.
  TargetRegistry::RegisterMCRegInfo(getThePIC16Target(), createPIC16MCRegisterInfo);

  // Register the MC subtarget info.
  TargetRegistry::RegisterMCSubtargetInfo(getThePIC16Target(),
                                          createPIC16MCSubtargetInfo);
}
