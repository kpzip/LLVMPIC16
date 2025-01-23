; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+zfh -verify-machineinstrs \
; RUN:   -target-abi ilp32f < %s \
; RUN:   | FileCheck -check-prefix=RV32IZFH %s
; RUN: llc -mtriple=riscv64 -mattr=+zfh -verify-machineinstrs \
; RUN:   -target-abi lp64f < %s \
; RUN:   | FileCheck -check-prefix=RV64IZFH %s
; RUN: llc -mtriple=riscv32 -mattr=+zhinx -verify-machineinstrs \
; RUN:   -target-abi ilp32 < %s \
; RUN:   | FileCheck -check-prefix=RV32IZHINX %s
; RUN: llc -mtriple=riscv64 -mattr=+zhinx -verify-machineinstrs \
; RUN:   -target-abi lp64 < %s \
; RUN:   | FileCheck -check-prefix=RV64IZHINX %s
; RUN: llc -mtriple=riscv32 -mattr=+zfhmin -verify-machineinstrs \
; RUN:   -target-abi ilp32f < %s \
; RUN:   | FileCheck -check-prefix=RV32IZFHMIN %s
; RUN: llc -mtriple=riscv64 -mattr=+zfhmin -verify-machineinstrs \
; RUN:   -target-abi lp64f < %s \
; RUN:   | FileCheck -check-prefix=RV64IZFHMIN %s
; RUN: llc -mtriple=riscv32 -mattr=+zhinxmin -verify-machineinstrs \
; RUN:   -target-abi ilp32 < %s \
; RUN:   | FileCheck -check-prefix=RV32IZHINXMIN %s
; RUN: llc -mtriple=riscv64 -mattr=+zhinxmin -verify-machineinstrs \
; RUN:   -target-abi lp64 < %s \
; RUN:   | FileCheck -check-prefix=RV64IZHINXMIN %s

define half @frem_f16(half %a, half %b) nounwind {
; RV32IZFH-LABEL: frem_f16:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    addi sp, sp, -16
; RV32IZFH-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IZFH-NEXT:    fcvt.s.h fa0, fa0
; RV32IZFH-NEXT:    fcvt.s.h fa1, fa1
; RV32IZFH-NEXT:    call fmodf
; RV32IZFH-NEXT:    fcvt.h.s fa0, fa0
; RV32IZFH-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IZFH-NEXT:    addi sp, sp, 16
; RV32IZFH-NEXT:    ret
;
; RV64IZFH-LABEL: frem_f16:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    addi sp, sp, -16
; RV64IZFH-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64IZFH-NEXT:    fcvt.s.h fa0, fa0
; RV64IZFH-NEXT:    fcvt.s.h fa1, fa1
; RV64IZFH-NEXT:    call fmodf
; RV64IZFH-NEXT:    fcvt.h.s fa0, fa0
; RV64IZFH-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64IZFH-NEXT:    addi sp, sp, 16
; RV64IZFH-NEXT:    ret
;
; RV32IZHINX-LABEL: frem_f16:
; RV32IZHINX:       # %bb.0:
; RV32IZHINX-NEXT:    addi sp, sp, -16
; RV32IZHINX-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IZHINX-NEXT:    fcvt.s.h a0, a0
; RV32IZHINX-NEXT:    fcvt.s.h a1, a1
; RV32IZHINX-NEXT:    call fmodf
; RV32IZHINX-NEXT:    fcvt.h.s a0, a0
; RV32IZHINX-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IZHINX-NEXT:    addi sp, sp, 16
; RV32IZHINX-NEXT:    ret
;
; RV64IZHINX-LABEL: frem_f16:
; RV64IZHINX:       # %bb.0:
; RV64IZHINX-NEXT:    addi sp, sp, -16
; RV64IZHINX-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64IZHINX-NEXT:    fcvt.s.h a0, a0
; RV64IZHINX-NEXT:    fcvt.s.h a1, a1
; RV64IZHINX-NEXT:    call fmodf
; RV64IZHINX-NEXT:    fcvt.h.s a0, a0
; RV64IZHINX-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64IZHINX-NEXT:    addi sp, sp, 16
; RV64IZHINX-NEXT:    ret
;
; RV32IZFHMIN-LABEL: frem_f16:
; RV32IZFHMIN:       # %bb.0:
; RV32IZFHMIN-NEXT:    addi sp, sp, -16
; RV32IZFHMIN-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IZFHMIN-NEXT:    fcvt.s.h fa0, fa0
; RV32IZFHMIN-NEXT:    fcvt.s.h fa1, fa1
; RV32IZFHMIN-NEXT:    call fmodf
; RV32IZFHMIN-NEXT:    fcvt.h.s fa0, fa0
; RV32IZFHMIN-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IZFHMIN-NEXT:    addi sp, sp, 16
; RV32IZFHMIN-NEXT:    ret
;
; RV64IZFHMIN-LABEL: frem_f16:
; RV64IZFHMIN:       # %bb.0:
; RV64IZFHMIN-NEXT:    addi sp, sp, -16
; RV64IZFHMIN-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64IZFHMIN-NEXT:    fcvt.s.h fa0, fa0
; RV64IZFHMIN-NEXT:    fcvt.s.h fa1, fa1
; RV64IZFHMIN-NEXT:    call fmodf
; RV64IZFHMIN-NEXT:    fcvt.h.s fa0, fa0
; RV64IZFHMIN-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64IZFHMIN-NEXT:    addi sp, sp, 16
; RV64IZFHMIN-NEXT:    ret
;
; RV32IZHINXMIN-LABEL: frem_f16:
; RV32IZHINXMIN:       # %bb.0:
; RV32IZHINXMIN-NEXT:    addi sp, sp, -16
; RV32IZHINXMIN-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IZHINXMIN-NEXT:    fcvt.s.h a0, a0
; RV32IZHINXMIN-NEXT:    fcvt.s.h a1, a1
; RV32IZHINXMIN-NEXT:    call fmodf
; RV32IZHINXMIN-NEXT:    fcvt.h.s a0, a0
; RV32IZHINXMIN-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IZHINXMIN-NEXT:    addi sp, sp, 16
; RV32IZHINXMIN-NEXT:    ret
;
; RV64IZHINXMIN-LABEL: frem_f16:
; RV64IZHINXMIN:       # %bb.0:
; RV64IZHINXMIN-NEXT:    addi sp, sp, -16
; RV64IZHINXMIN-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64IZHINXMIN-NEXT:    fcvt.s.h a0, a0
; RV64IZHINXMIN-NEXT:    fcvt.s.h a1, a1
; RV64IZHINXMIN-NEXT:    call fmodf
; RV64IZHINXMIN-NEXT:    fcvt.h.s a0, a0
; RV64IZHINXMIN-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64IZHINXMIN-NEXT:    addi sp, sp, 16
; RV64IZHINXMIN-NEXT:    ret
  %1 = frem half %a, %b
  ret half %1
}
