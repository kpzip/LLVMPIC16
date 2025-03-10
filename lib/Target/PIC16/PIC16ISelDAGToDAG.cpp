//===-- PIC16ISelDAGToDAG.cpp - A dag to dag inst selector for PIC16 ------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source 
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file defines an instruction selector for the PIC16 target.
//
//===----------------------------------------------------------------------===//

#define DEBUG_TYPE "pic16-isel"

#include "llvm/Support/ErrorHandling.h"
#include "PIC16ISelDAGToDAG.h"
using namespace llvm;

/// createPIC16ISelDag - This pass converts a legalized DAG into a
/// PIC16-specific DAG, ready for instruction scheduling.
FunctionPass *llvm::createPIC16ISelDag(PIC16TargetMachine &TM, CodeGenOptLevel OptLevel) {
  return new PIC16DAGToDAGISelLegacy(TM, OptLevel);
}


/// Select - Select instructions not customized! Used for
/// expanded, promoted and normal instructions.
void PIC16DAGToDAGISel::Select(SDNode *N) {

  // Select the default instruction.
  SelectCode(N);
}


// SelectDirectAddr - Match a direct address for DAG. 
// A direct address could be a globaladdress or externalsymbol.
bool PIC16DAGToDAGISel::SelectDirectAddr(SDValue &N,
                                      SDValue &Address) {
  // Return true if TGA or ES.
  if (N.getOpcode() == ISD::TargetGlobalAddress
      || N.getOpcode() == ISD::TargetExternalSymbol) {
    Address = N;
    return true;
  }

  return false;
}
