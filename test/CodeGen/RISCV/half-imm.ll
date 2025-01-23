; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+zfh -verify-machineinstrs \
; RUN:   -target-abi ilp32f < %s | FileCheck %s
; RUN: llc -mtriple=riscv64 -mattr=+zfh -verify-machineinstrs \
; RUN:   -target-abi lp64f < %s | FileCheck %s
; RUN: llc -mtriple=riscv32 -mattr=+zhinx -verify-machineinstrs \
; RUN:   -target-abi ilp32 < %s \
; RUN:   | FileCheck -check-prefix=RV32IZHINX %s
; RUN: llc -mtriple=riscv64 -mattr=+zhinx -verify-machineinstrs \
; RUN:   -target-abi lp64 < %s \
; RUN:   | FileCheck -check-prefix=RV64IZHINX %s
; RUN: llc -mtriple=riscv32 -mattr=+zfhmin -verify-machineinstrs \
; RUN:   -target-abi ilp32f < %s | FileCheck -check-prefixes=CHECKIZFHMIN %s
; RUN: llc -mtriple=riscv64 -mattr=+zfhmin -verify-machineinstrs \
; RUN:   -target-abi lp64f < %s | FileCheck -check-prefixes=CHECKIZFHMIN %s
; RUN: llc -mtriple=riscv32 -mattr=+zhinxmin -verify-machineinstrs \
; RUN:   -target-abi ilp32 < %s \
; RUN:   | FileCheck -check-prefixes=CHECKIZHINXMIN %s
; RUN: llc -mtriple=riscv64 -mattr=+zhinxmin -verify-machineinstrs \
; RUN:   -target-abi lp64 < %s \
; RUN:   | FileCheck -check-prefixes=CHECKIZHINXMIN %s

; TODO: constant pool shouldn't be necessary for RV32IZfh and RV64IZfh
define half @half_imm() nounwind {
; CHECK-LABEL: half_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, %hi(.LCPI0_0)
; CHECK-NEXT:    flh fa0, %lo(.LCPI0_0)(a0)
; CHECK-NEXT:    ret
;
; RV32IZHINX-LABEL: half_imm:
; RV32IZHINX:       # %bb.0:
; RV32IZHINX-NEXT:    lui a0, %hi(.LCPI0_0)
; RV32IZHINX-NEXT:    lh a0, %lo(.LCPI0_0)(a0)
; RV32IZHINX-NEXT:    ret
;
; RV64IZHINX-LABEL: half_imm:
; RV64IZHINX:       # %bb.0:
; RV64IZHINX-NEXT:    lui a0, %hi(.LCPI0_0)
; RV64IZHINX-NEXT:    lh a0, %lo(.LCPI0_0)(a0)
; RV64IZHINX-NEXT:    ret
;
; CHECKIZFHMIN-LABEL: half_imm:
; CHECKIZFHMIN:       # %bb.0:
; CHECKIZFHMIN-NEXT:    lui a0, %hi(.LCPI0_0)
; CHECKIZFHMIN-NEXT:    flh fa0, %lo(.LCPI0_0)(a0)
; CHECKIZFHMIN-NEXT:    ret
;
; CHECKIZHINXMIN-LABEL: half_imm:
; CHECKIZHINXMIN:       # %bb.0:
; CHECKIZHINXMIN-NEXT:    lui a0, %hi(.LCPI0_0)
; CHECKIZHINXMIN-NEXT:    lh a0, %lo(.LCPI0_0)(a0)
; CHECKIZHINXMIN-NEXT:    ret
  ret half 3.0
}

define half @half_imm_op(half %a) nounwind {
; CHECK-LABEL: half_imm_op:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, %hi(.LCPI1_0)
; CHECK-NEXT:    flh fa5, %lo(.LCPI1_0)(a0)
; CHECK-NEXT:    fadd.h fa0, fa0, fa5
; CHECK-NEXT:    ret
;
; RV32IZHINX-LABEL: half_imm_op:
; RV32IZHINX:       # %bb.0:
; RV32IZHINX-NEXT:    lui a1, %hi(.LCPI1_0)
; RV32IZHINX-NEXT:    lh a1, %lo(.LCPI1_0)(a1)
; RV32IZHINX-NEXT:    fadd.h a0, a0, a1
; RV32IZHINX-NEXT:    ret
;
; RV64IZHINX-LABEL: half_imm_op:
; RV64IZHINX:       # %bb.0:
; RV64IZHINX-NEXT:    lui a1, %hi(.LCPI1_0)
; RV64IZHINX-NEXT:    lh a1, %lo(.LCPI1_0)(a1)
; RV64IZHINX-NEXT:    fadd.h a0, a0, a1
; RV64IZHINX-NEXT:    ret
;
; CHECKIZFHMIN-LABEL: half_imm_op:
; CHECKIZFHMIN:       # %bb.0:
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa5, fa0
; CHECKIZFHMIN-NEXT:    lui a0, 260096
; CHECKIZFHMIN-NEXT:    fmv.w.x fa4, a0
; CHECKIZFHMIN-NEXT:    fadd.s fa5, fa5, fa4
; CHECKIZFHMIN-NEXT:    fcvt.h.s fa0, fa5
; CHECKIZFHMIN-NEXT:    ret
;
; CHECKIZHINXMIN-LABEL: half_imm_op:
; CHECKIZHINXMIN:       # %bb.0:
; CHECKIZHINXMIN-NEXT:    fcvt.s.h a0, a0
; CHECKIZHINXMIN-NEXT:    lui a1, 260096
; CHECKIZHINXMIN-NEXT:    fadd.s a0, a0, a1
; CHECKIZHINXMIN-NEXT:    fcvt.h.s a0, a0
; CHECKIZHINXMIN-NEXT:    ret
  %1 = fadd half %a, 1.0
  ret half %1
}

define half @half_positive_zero(ptr %pf) nounwind {
; CHECK-LABEL: half_positive_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fmv.h.x fa0, zero
; CHECK-NEXT:    ret
;
; RV32IZHINX-LABEL: half_positive_zero:
; RV32IZHINX:       # %bb.0:
; RV32IZHINX-NEXT:    li a0, 0
; RV32IZHINX-NEXT:    ret
;
; RV64IZHINX-LABEL: half_positive_zero:
; RV64IZHINX:       # %bb.0:
; RV64IZHINX-NEXT:    li a0, 0
; RV64IZHINX-NEXT:    ret
;
; CHECKIZFHMIN-LABEL: half_positive_zero:
; CHECKIZFHMIN:       # %bb.0:
; CHECKIZFHMIN-NEXT:    fmv.h.x fa0, zero
; CHECKIZFHMIN-NEXT:    ret
;
; CHECKIZHINXMIN-LABEL: half_positive_zero:
; CHECKIZHINXMIN:       # %bb.0:
; CHECKIZHINXMIN-NEXT:    li a0, 0
; CHECKIZHINXMIN-NEXT:    ret
  ret half 0.0
}

define half @half_negative_zero(ptr %pf) nounwind {
; CHECK-LABEL: half_negative_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 1048568
; CHECK-NEXT:    fmv.h.x fa0, a0
; CHECK-NEXT:    ret
;
; RV32IZHINX-LABEL: half_negative_zero:
; RV32IZHINX:       # %bb.0:
; RV32IZHINX-NEXT:    lui a0, 1048568
; RV32IZHINX-NEXT:    ret
;
; RV64IZHINX-LABEL: half_negative_zero:
; RV64IZHINX:       # %bb.0:
; RV64IZHINX-NEXT:    lui a0, 1048568
; RV64IZHINX-NEXT:    ret
;
; CHECKIZFHMIN-LABEL: half_negative_zero:
; CHECKIZFHMIN:       # %bb.0:
; CHECKIZFHMIN-NEXT:    lui a0, 1048568
; CHECKIZFHMIN-NEXT:    fmv.h.x fa0, a0
; CHECKIZFHMIN-NEXT:    ret
;
; CHECKIZHINXMIN-LABEL: half_negative_zero:
; CHECKIZHINXMIN:       # %bb.0:
; CHECKIZHINXMIN-NEXT:    lui a0, 1048568
; CHECKIZHINXMIN-NEXT:    ret
  ret half -0.0
}
