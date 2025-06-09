//===-- PIC16InstPrinter.cpp - Convert PIC16 MCInst to assembly syntax --------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This class prints an PIC16 MCInst to a .s file.
//
//===----------------------------------------------------------------------===//

#include "PIC16InstPrinter.h"

//#include "MCTargetDesc/PIC16MCTargetDesc.h"

#include "llvm/MC/MCExpr.h"
#include "llvm/MC/MCInst.h"
#include "llvm/MC/MCInstrDesc.h"
#include "llvm/MC/MCInstrInfo.h"
#include "llvm/MC/MCRegisterInfo.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/FormattedStream.h"

#include <cstring>

#define DEBUG_TYPE "asm-printer"

namespace llvm {

// Include the auto-generated portion of the assembly writer.
#define PRINT_ALIAS_INSTR
#include "PIC16GenAsmWriter.inc"

void PIC16InstPrinter::printInst(const MCInst *MI, uint64_t Address,
                               StringRef Annot, const MCSubtargetInfo &STI,
                               raw_ostream &O) {
  unsigned Opcode = MI->getOpcode();

  // First handle load and store instructions with postinc or predec
  // of the form "ld reg, X+".
  // TODO: We should be able to rewrite this using TableGen data.


}

const char *PIC16InstPrinter::getPrettyRegisterName(unsigned RegNum,
                                                  MCRegisterInfo const &MRI) {
  // GCC prints register pairs by just printing the lower register
  // If the register contains a subregister, print it instead
  // if (MRI.getNumSubRegIndices() > 0) {
  //   unsigned RegLoNum = MRI.getSubReg(RegNum, PIC16::sub_lo);
  //   RegNum = (RegLoNum != PIC16::NoRegister) ? RegLoNum : RegNum;
  // }

  return getRegisterName(RegNum);
}

void PIC16InstPrinter::printCCOperand(const MCInst *MI, unsigned OpNo, raw_ostream &O) {
  // TODO no idea what this does
}

void PIC16InstPrinter::printOperand(const MCInst *MI, unsigned OpNo,
                                  raw_ostream &O) {
  // const MCOperandInfo &MOI = this->MII.get(MI->getOpcode()).operands()[OpNo];
  // if (MOI.RegClass == PIC16::ZREGRegClassID) {
  //   // Special case for the Z register, which sometimes doesn't have an operand
  //   // in the MCInst.
  //   O << "Z";
  //   return;
  // }
  //
  // if (OpNo >= MI->size()) {
  //   // Not all operands are correctly disassembled at the moment. This means
  //   // that some machine instructions won't have all the necessary operands
  //   // set.
  //   // To avoid asserting, print <unknown> instead until the necessary support
  //   // has been implemented.
  //   O << "<unknown>";
  //   return;
  // }
  //
  // const MCOperand &Op = MI->getOperand(OpNo);
  //
  // if (Op.isReg()) {
  //   bool isPtrReg = (MOI.RegClass == PIC16::PTRREGSRegClassID) ||
  //                   (MOI.RegClass == PIC16::PTRDISPREGSRegClassID) ||
  //                   (MOI.RegClass == PIC16::ZREGRegClassID);
  //
  //   if (isPtrReg) {
  //     O << getRegisterName(Op.getReg(), PIC16::ptr);
  //   } else {
  //     O << getPrettyRegisterName(Op.getReg(), MRI);
  //   }
  // } else if (Op.isImm()) {
  //   O << formatImm(Op.getImm());
  // } else {
  //   assert(Op.isExpr() && "Unknown operand kind in printOperand");
  //   O << *Op.getExpr();
  // }
}

/// This is used to print an immediate value that ends up
/// being encoded as a pc-relative value.
void PIC16InstPrinter::printPCRelImm(const MCInst *MI, unsigned OpNo,
                                   raw_ostream &O) {
  // if (OpNo >= MI->size()) {
  //   // Not all operands are correctly disassembled at the moment. This means
  //   // that some machine instructions won't have all the necessary operands
  //   // set.
  //   // To avoid asserting, print <unknown> instead until the necessary support
  //   // has been implemented.
  //   O << "<unknown>";
  //   return;
  // }
  //
  // const MCOperand &Op = MI->getOperand(OpNo);
  //
  // if (Op.isImm()) {
  //   int64_t Imm = Op.getImm();
  //   O << '.';
  //
  //   // Print a position sign if needed.
  //   // Negative values have their sign printed automatically.
  //   if (Imm >= 0)
  //     O << '+';
  //
  //   O << Imm;
  // } else {
  //   assert(Op.isExpr() && "Unknown pcrel immediate operand");
  //   O << *Op.getExpr();
  // }
}

void PIC16InstPrinter::printMemri(const MCInst *MI, unsigned OpNo,
                                raw_ostream &O) {
//   assert(MI->getOperand(OpNo).isReg() &&
//          "Expected a register for the first operand");
//
//   const MCOperand &OffsetOp = MI->getOperand(OpNo + 1);
//
//   // Print the register.
//   printOperand(MI, OpNo, O);
//
//   // Print the {+,-}offset.
//   if (OffsetOp.isImm()) {
//     int64_t Offset = OffsetOp.getImm();
//
//     if (Offset >= 0)
//       O << '+';
//
//     O << Offset;
//   } else if (OffsetOp.isExpr()) {
//     O << *OffsetOp.getExpr();
//   } else {
//     llvm_unreachable("unknown type for offset");
//   }
}

} // end of namespace llvm
