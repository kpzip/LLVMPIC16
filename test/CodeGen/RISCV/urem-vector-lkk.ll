; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefixes=CHECK,RV32I %s
; RUN: llc -mtriple=riscv32 -mattr=+m -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefixes=CHECK,RV32IM %s
; RUN: llc -mtriple=riscv64 -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefixes=CHECK,RV64I %s
; RUN: llc -mtriple=riscv64 -mattr=+m -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefixes=CHECK,RV64IM %s


define <4 x i16> @fold_urem_vec_1(<4 x i16> %x) nounwind {
; RV32I-LABEL: fold_urem_vec_1:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -32
; RV32I-NEXT:    sw ra, 28(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s0, 24(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s1, 20(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s2, 16(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s3, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s4, 8(sp) # 4-byte Folded Spill
; RV32I-NEXT:    lhu s0, 12(a1)
; RV32I-NEXT:    lhu s1, 8(a1)
; RV32I-NEXT:    lhu s2, 4(a1)
; RV32I-NEXT:    lhu a2, 0(a1)
; RV32I-NEXT:    mv s3, a0
; RV32I-NEXT:    li a1, 95
; RV32I-NEXT:    mv a0, a2
; RV32I-NEXT:    call __umodsi3
; RV32I-NEXT:    mv s4, a0
; RV32I-NEXT:    li a1, 124
; RV32I-NEXT:    mv a0, s2
; RV32I-NEXT:    call __umodsi3
; RV32I-NEXT:    mv s2, a0
; RV32I-NEXT:    li a1, 98
; RV32I-NEXT:    mv a0, s1
; RV32I-NEXT:    call __umodsi3
; RV32I-NEXT:    mv s1, a0
; RV32I-NEXT:    li a1, 1003
; RV32I-NEXT:    mv a0, s0
; RV32I-NEXT:    call __umodsi3
; RV32I-NEXT:    sh a0, 6(s3)
; RV32I-NEXT:    sh s1, 4(s3)
; RV32I-NEXT:    sh s2, 2(s3)
; RV32I-NEXT:    sh s4, 0(s3)
; RV32I-NEXT:    lw ra, 28(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s0, 24(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s1, 20(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s2, 16(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s3, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s4, 8(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 32
; RV32I-NEXT:    ret
;
; RV32IM-LABEL: fold_urem_vec_1:
; RV32IM:       # %bb.0:
; RV32IM-NEXT:    lhu a2, 12(a1)
; RV32IM-NEXT:    lhu a3, 8(a1)
; RV32IM-NEXT:    lhu a4, 4(a1)
; RV32IM-NEXT:    lhu a1, 0(a1)
; RV32IM-NEXT:    lui a5, 8456
; RV32IM-NEXT:    addi a5, a5, 1058
; RV32IM-NEXT:    mulhu a5, a4, a5
; RV32IM-NEXT:    slli a6, a5, 7
; RV32IM-NEXT:    slli a5, a5, 2
; RV32IM-NEXT:    sub a5, a5, a6
; RV32IM-NEXT:    add a4, a4, a5
; RV32IM-NEXT:    lui a5, 11038
; RV32IM-NEXT:    addi a5, a5, -1465
; RV32IM-NEXT:    mulhu a5, a1, a5
; RV32IM-NEXT:    li a6, 95
; RV32IM-NEXT:    mul a5, a5, a6
; RV32IM-NEXT:    sub a1, a1, a5
; RV32IM-NEXT:    lui a5, 10700
; RV32IM-NEXT:    addi a5, a5, -1003
; RV32IM-NEXT:    mulhu a5, a3, a5
; RV32IM-NEXT:    li a6, 98
; RV32IM-NEXT:    mul a5, a5, a6
; RV32IM-NEXT:    sub a3, a3, a5
; RV32IM-NEXT:    lui a5, 1045
; RV32IM-NEXT:    addi a5, a5, 1801
; RV32IM-NEXT:    mulhu a5, a2, a5
; RV32IM-NEXT:    li a6, 1003
; RV32IM-NEXT:    mul a5, a5, a6
; RV32IM-NEXT:    sub a2, a2, a5
; RV32IM-NEXT:    sh a2, 6(a0)
; RV32IM-NEXT:    sh a3, 4(a0)
; RV32IM-NEXT:    sh a1, 0(a0)
; RV32IM-NEXT:    sh a4, 2(a0)
; RV32IM-NEXT:    ret
;
; RV64I-LABEL: fold_urem_vec_1:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -48
; RV64I-NEXT:    sd ra, 40(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s0, 32(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s1, 24(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s2, 16(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s3, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s4, 0(sp) # 8-byte Folded Spill
; RV64I-NEXT:    lhu s0, 24(a1)
; RV64I-NEXT:    lhu s1, 16(a1)
; RV64I-NEXT:    lhu s2, 8(a1)
; RV64I-NEXT:    lhu a2, 0(a1)
; RV64I-NEXT:    mv s3, a0
; RV64I-NEXT:    li a1, 95
; RV64I-NEXT:    mv a0, a2
; RV64I-NEXT:    call __umoddi3
; RV64I-NEXT:    mv s4, a0
; RV64I-NEXT:    li a1, 124
; RV64I-NEXT:    mv a0, s2
; RV64I-NEXT:    call __umoddi3
; RV64I-NEXT:    mv s2, a0
; RV64I-NEXT:    li a1, 98
; RV64I-NEXT:    mv a0, s1
; RV64I-NEXT:    call __umoddi3
; RV64I-NEXT:    mv s1, a0
; RV64I-NEXT:    li a1, 1003
; RV64I-NEXT:    mv a0, s0
; RV64I-NEXT:    call __umoddi3
; RV64I-NEXT:    sh a0, 6(s3)
; RV64I-NEXT:    sh s1, 4(s3)
; RV64I-NEXT:    sh s2, 2(s3)
; RV64I-NEXT:    sh s4, 0(s3)
; RV64I-NEXT:    ld ra, 40(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s0, 32(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s1, 24(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s2, 16(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s3, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s4, 0(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 48
; RV64I-NEXT:    ret
;
; RV64IM-LABEL: fold_urem_vec_1:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    lhu a2, 8(a1)
; RV64IM-NEXT:    lui a3, %hi(.LCPI0_0)
; RV64IM-NEXT:    ld a3, %lo(.LCPI0_0)(a3)
; RV64IM-NEXT:    lhu a4, 24(a1)
; RV64IM-NEXT:    lhu a5, 16(a1)
; RV64IM-NEXT:    lhu a1, 0(a1)
; RV64IM-NEXT:    mulhu a3, a2, a3
; RV64IM-NEXT:    slli a6, a3, 7
; RV64IM-NEXT:    lui a7, %hi(.LCPI0_1)
; RV64IM-NEXT:    ld a7, %lo(.LCPI0_1)(a7)
; RV64IM-NEXT:    slli a3, a3, 2
; RV64IM-NEXT:    subw a3, a3, a6
; RV64IM-NEXT:    add a2, a2, a3
; RV64IM-NEXT:    mulhu a3, a1, a7
; RV64IM-NEXT:    lui a6, %hi(.LCPI0_2)
; RV64IM-NEXT:    ld a6, %lo(.LCPI0_2)(a6)
; RV64IM-NEXT:    li a7, 95
; RV64IM-NEXT:    mul a3, a3, a7
; RV64IM-NEXT:    subw a1, a1, a3
; RV64IM-NEXT:    mulhu a3, a5, a6
; RV64IM-NEXT:    lui a6, %hi(.LCPI0_3)
; RV64IM-NEXT:    ld a6, %lo(.LCPI0_3)(a6)
; RV64IM-NEXT:    li a7, 98
; RV64IM-NEXT:    mul a3, a3, a7
; RV64IM-NEXT:    subw a5, a5, a3
; RV64IM-NEXT:    mulhu a3, a4, a6
; RV64IM-NEXT:    li a6, 1003
; RV64IM-NEXT:    mul a3, a3, a6
; RV64IM-NEXT:    subw a4, a4, a3
; RV64IM-NEXT:    sh a4, 6(a0)
; RV64IM-NEXT:    sh a5, 4(a0)
; RV64IM-NEXT:    sh a1, 0(a0)
; RV64IM-NEXT:    sh a2, 2(a0)
; RV64IM-NEXT:    ret
  %1 = urem <4 x i16> %x, <i16 95, i16 124, i16 98, i16 1003>
  ret <4 x i16> %1
}

define <4 x i16> @fold_urem_vec_2(<4 x i16> %x) nounwind {
; RV32I-LABEL: fold_urem_vec_2:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -32
; RV32I-NEXT:    sw ra, 28(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s0, 24(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s1, 20(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s2, 16(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s3, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s4, 8(sp) # 4-byte Folded Spill
; RV32I-NEXT:    lhu s0, 12(a1)
; RV32I-NEXT:    lhu s1, 8(a1)
; RV32I-NEXT:    lhu s2, 4(a1)
; RV32I-NEXT:    lhu a2, 0(a1)
; RV32I-NEXT:    mv s3, a0
; RV32I-NEXT:    li a1, 95
; RV32I-NEXT:    mv a0, a2
; RV32I-NEXT:    call __umodsi3
; RV32I-NEXT:    mv s4, a0
; RV32I-NEXT:    li a1, 95
; RV32I-NEXT:    mv a0, s2
; RV32I-NEXT:    call __umodsi3
; RV32I-NEXT:    mv s2, a0
; RV32I-NEXT:    li a1, 95
; RV32I-NEXT:    mv a0, s1
; RV32I-NEXT:    call __umodsi3
; RV32I-NEXT:    mv s1, a0
; RV32I-NEXT:    li a1, 95
; RV32I-NEXT:    mv a0, s0
; RV32I-NEXT:    call __umodsi3
; RV32I-NEXT:    sh a0, 6(s3)
; RV32I-NEXT:    sh s1, 4(s3)
; RV32I-NEXT:    sh s2, 2(s3)
; RV32I-NEXT:    sh s4, 0(s3)
; RV32I-NEXT:    lw ra, 28(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s0, 24(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s1, 20(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s2, 16(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s3, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s4, 8(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 32
; RV32I-NEXT:    ret
;
; RV32IM-LABEL: fold_urem_vec_2:
; RV32IM:       # %bb.0:
; RV32IM-NEXT:    lhu a2, 12(a1)
; RV32IM-NEXT:    lhu a3, 8(a1)
; RV32IM-NEXT:    lhu a4, 0(a1)
; RV32IM-NEXT:    lhu a1, 4(a1)
; RV32IM-NEXT:    lui a5, 11038
; RV32IM-NEXT:    addi a5, a5, -1465
; RV32IM-NEXT:    mulhu a6, a4, a5
; RV32IM-NEXT:    li a7, 95
; RV32IM-NEXT:    mul a6, a6, a7
; RV32IM-NEXT:    sub a4, a4, a6
; RV32IM-NEXT:    mulhu a6, a1, a5
; RV32IM-NEXT:    mul a6, a6, a7
; RV32IM-NEXT:    sub a1, a1, a6
; RV32IM-NEXT:    mulhu a6, a3, a5
; RV32IM-NEXT:    mul a6, a6, a7
; RV32IM-NEXT:    sub a3, a3, a6
; RV32IM-NEXT:    mulhu a5, a2, a5
; RV32IM-NEXT:    mul a5, a5, a7
; RV32IM-NEXT:    sub a2, a2, a5
; RV32IM-NEXT:    sh a2, 6(a0)
; RV32IM-NEXT:    sh a3, 4(a0)
; RV32IM-NEXT:    sh a1, 2(a0)
; RV32IM-NEXT:    sh a4, 0(a0)
; RV32IM-NEXT:    ret
;
; RV64I-LABEL: fold_urem_vec_2:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -48
; RV64I-NEXT:    sd ra, 40(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s0, 32(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s1, 24(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s2, 16(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s3, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s4, 0(sp) # 8-byte Folded Spill
; RV64I-NEXT:    lhu s0, 24(a1)
; RV64I-NEXT:    lhu s1, 16(a1)
; RV64I-NEXT:    lhu s2, 8(a1)
; RV64I-NEXT:    lhu a2, 0(a1)
; RV64I-NEXT:    mv s3, a0
; RV64I-NEXT:    li a1, 95
; RV64I-NEXT:    mv a0, a2
; RV64I-NEXT:    call __umoddi3
; RV64I-NEXT:    mv s4, a0
; RV64I-NEXT:    li a1, 95
; RV64I-NEXT:    mv a0, s2
; RV64I-NEXT:    call __umoddi3
; RV64I-NEXT:    mv s2, a0
; RV64I-NEXT:    li a1, 95
; RV64I-NEXT:    mv a0, s1
; RV64I-NEXT:    call __umoddi3
; RV64I-NEXT:    mv s1, a0
; RV64I-NEXT:    li a1, 95
; RV64I-NEXT:    mv a0, s0
; RV64I-NEXT:    call __umoddi3
; RV64I-NEXT:    sh a0, 6(s3)
; RV64I-NEXT:    sh s1, 4(s3)
; RV64I-NEXT:    sh s2, 2(s3)
; RV64I-NEXT:    sh s4, 0(s3)
; RV64I-NEXT:    ld ra, 40(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s0, 32(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s1, 24(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s2, 16(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s3, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s4, 0(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 48
; RV64I-NEXT:    ret
;
; RV64IM-LABEL: fold_urem_vec_2:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    lhu a2, 0(a1)
; RV64IM-NEXT:    lui a3, %hi(.LCPI1_0)
; RV64IM-NEXT:    ld a3, %lo(.LCPI1_0)(a3)
; RV64IM-NEXT:    lhu a4, 24(a1)
; RV64IM-NEXT:    lhu a5, 16(a1)
; RV64IM-NEXT:    lhu a1, 8(a1)
; RV64IM-NEXT:    mulhu a6, a2, a3
; RV64IM-NEXT:    li a7, 95
; RV64IM-NEXT:    mul a6, a6, a7
; RV64IM-NEXT:    subw a2, a2, a6
; RV64IM-NEXT:    mulhu a6, a1, a3
; RV64IM-NEXT:    mul a6, a6, a7
; RV64IM-NEXT:    subw a1, a1, a6
; RV64IM-NEXT:    mulhu a6, a5, a3
; RV64IM-NEXT:    mul a6, a6, a7
; RV64IM-NEXT:    subw a5, a5, a6
; RV64IM-NEXT:    mulhu a3, a4, a3
; RV64IM-NEXT:    mul a3, a3, a7
; RV64IM-NEXT:    subw a4, a4, a3
; RV64IM-NEXT:    sh a4, 6(a0)
; RV64IM-NEXT:    sh a5, 4(a0)
; RV64IM-NEXT:    sh a1, 2(a0)
; RV64IM-NEXT:    sh a2, 0(a0)
; RV64IM-NEXT:    ret
  %1 = urem <4 x i16> %x, <i16 95, i16 95, i16 95, i16 95>
  ret <4 x i16> %1
}


; Don't fold if we can combine urem with udiv.
define <4 x i16> @combine_urem_udiv(<4 x i16> %x) nounwind {
; RV32I-LABEL: combine_urem_udiv:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -48
; RV32I-NEXT:    sw ra, 44(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s0, 40(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s1, 36(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s2, 32(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s3, 28(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s4, 24(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s5, 20(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s6, 16(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s7, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s8, 8(sp) # 4-byte Folded Spill
; RV32I-NEXT:    lhu s1, 0(a1)
; RV32I-NEXT:    lhu s2, 4(a1)
; RV32I-NEXT:    lhu s3, 8(a1)
; RV32I-NEXT:    lhu s4, 12(a1)
; RV32I-NEXT:    mv s0, a0
; RV32I-NEXT:    li a1, 95
; RV32I-NEXT:    mv a0, s4
; RV32I-NEXT:    call __umodsi3
; RV32I-NEXT:    mv s5, a0
; RV32I-NEXT:    li a1, 95
; RV32I-NEXT:    mv a0, s3
; RV32I-NEXT:    call __umodsi3
; RV32I-NEXT:    mv s6, a0
; RV32I-NEXT:    li a1, 95
; RV32I-NEXT:    mv a0, s2
; RV32I-NEXT:    call __umodsi3
; RV32I-NEXT:    mv s7, a0
; RV32I-NEXT:    li a1, 95
; RV32I-NEXT:    mv a0, s1
; RV32I-NEXT:    call __umodsi3
; RV32I-NEXT:    mv s8, a0
; RV32I-NEXT:    li a1, 95
; RV32I-NEXT:    mv a0, s4
; RV32I-NEXT:    call __udivsi3
; RV32I-NEXT:    mv s4, a0
; RV32I-NEXT:    li a1, 95
; RV32I-NEXT:    mv a0, s3
; RV32I-NEXT:    call __udivsi3
; RV32I-NEXT:    mv s3, a0
; RV32I-NEXT:    li a1, 95
; RV32I-NEXT:    mv a0, s2
; RV32I-NEXT:    call __udivsi3
; RV32I-NEXT:    mv s2, a0
; RV32I-NEXT:    li a1, 95
; RV32I-NEXT:    mv a0, s1
; RV32I-NEXT:    call __udivsi3
; RV32I-NEXT:    add a0, s8, a0
; RV32I-NEXT:    add s2, s7, s2
; RV32I-NEXT:    add s3, s6, s3
; RV32I-NEXT:    add s4, s5, s4
; RV32I-NEXT:    sh s4, 6(s0)
; RV32I-NEXT:    sh s3, 4(s0)
; RV32I-NEXT:    sh s2, 2(s0)
; RV32I-NEXT:    sh a0, 0(s0)
; RV32I-NEXT:    lw ra, 44(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s0, 40(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s1, 36(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s2, 32(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s3, 28(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s4, 24(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s5, 20(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s6, 16(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s7, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s8, 8(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 48
; RV32I-NEXT:    ret
;
; RV32IM-LABEL: combine_urem_udiv:
; RV32IM:       # %bb.0:
; RV32IM-NEXT:    lhu a2, 0(a1)
; RV32IM-NEXT:    lhu a3, 4(a1)
; RV32IM-NEXT:    lhu a4, 12(a1)
; RV32IM-NEXT:    lhu a1, 8(a1)
; RV32IM-NEXT:    lui a5, 11038
; RV32IM-NEXT:    addi a5, a5, -1465
; RV32IM-NEXT:    mulhu a6, a4, a5
; RV32IM-NEXT:    li a7, 95
; RV32IM-NEXT:    mul t0, a6, a7
; RV32IM-NEXT:    mulhu t1, a1, a5
; RV32IM-NEXT:    mul t2, t1, a7
; RV32IM-NEXT:    mulhu t3, a3, a5
; RV32IM-NEXT:    mul t4, t3, a7
; RV32IM-NEXT:    mulhu a5, a2, a5
; RV32IM-NEXT:    mul a7, a5, a7
; RV32IM-NEXT:    add a2, a2, a5
; RV32IM-NEXT:    sub a2, a2, a7
; RV32IM-NEXT:    add a3, a3, t3
; RV32IM-NEXT:    sub a3, a3, t4
; RV32IM-NEXT:    add a1, a1, t1
; RV32IM-NEXT:    sub a1, a1, t2
; RV32IM-NEXT:    add a4, a4, a6
; RV32IM-NEXT:    sub a4, a4, t0
; RV32IM-NEXT:    sh a4, 6(a0)
; RV32IM-NEXT:    sh a1, 4(a0)
; RV32IM-NEXT:    sh a3, 2(a0)
; RV32IM-NEXT:    sh a2, 0(a0)
; RV32IM-NEXT:    ret
;
; RV64I-LABEL: combine_urem_udiv:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -80
; RV64I-NEXT:    sd ra, 72(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s0, 64(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s1, 56(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s2, 48(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s3, 40(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s4, 32(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s5, 24(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s6, 16(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s7, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s8, 0(sp) # 8-byte Folded Spill
; RV64I-NEXT:    lhu s1, 0(a1)
; RV64I-NEXT:    lhu s2, 8(a1)
; RV64I-NEXT:    lhu s3, 16(a1)
; RV64I-NEXT:    lhu s4, 24(a1)
; RV64I-NEXT:    mv s0, a0
; RV64I-NEXT:    li a1, 95
; RV64I-NEXT:    mv a0, s4
; RV64I-NEXT:    call __umoddi3
; RV64I-NEXT:    mv s5, a0
; RV64I-NEXT:    li a1, 95
; RV64I-NEXT:    mv a0, s3
; RV64I-NEXT:    call __umoddi3
; RV64I-NEXT:    mv s6, a0
; RV64I-NEXT:    li a1, 95
; RV64I-NEXT:    mv a0, s2
; RV64I-NEXT:    call __umoddi3
; RV64I-NEXT:    mv s7, a0
; RV64I-NEXT:    li a1, 95
; RV64I-NEXT:    mv a0, s1
; RV64I-NEXT:    call __umoddi3
; RV64I-NEXT:    mv s8, a0
; RV64I-NEXT:    li a1, 95
; RV64I-NEXT:    mv a0, s4
; RV64I-NEXT:    call __udivdi3
; RV64I-NEXT:    mv s4, a0
; RV64I-NEXT:    li a1, 95
; RV64I-NEXT:    mv a0, s3
; RV64I-NEXT:    call __udivdi3
; RV64I-NEXT:    mv s3, a0
; RV64I-NEXT:    li a1, 95
; RV64I-NEXT:    mv a0, s2
; RV64I-NEXT:    call __udivdi3
; RV64I-NEXT:    mv s2, a0
; RV64I-NEXT:    li a1, 95
; RV64I-NEXT:    mv a0, s1
; RV64I-NEXT:    call __udivdi3
; RV64I-NEXT:    add a0, s8, a0
; RV64I-NEXT:    add s2, s7, s2
; RV64I-NEXT:    add s3, s6, s3
; RV64I-NEXT:    add s4, s5, s4
; RV64I-NEXT:    sh s4, 6(s0)
; RV64I-NEXT:    sh s3, 4(s0)
; RV64I-NEXT:    sh s2, 2(s0)
; RV64I-NEXT:    sh a0, 0(s0)
; RV64I-NEXT:    ld ra, 72(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s0, 64(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s1, 56(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s2, 48(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s3, 40(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s4, 32(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s5, 24(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s6, 16(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s7, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s8, 0(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 80
; RV64I-NEXT:    ret
;
; RV64IM-LABEL: combine_urem_udiv:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    lhu a2, 24(a1)
; RV64IM-NEXT:    lui a3, %hi(.LCPI2_0)
; RV64IM-NEXT:    ld a3, %lo(.LCPI2_0)(a3)
; RV64IM-NEXT:    lhu a4, 0(a1)
; RV64IM-NEXT:    lhu a5, 8(a1)
; RV64IM-NEXT:    lhu a1, 16(a1)
; RV64IM-NEXT:    mulhu a6, a2, a3
; RV64IM-NEXT:    li a7, 95
; RV64IM-NEXT:    mul t0, a6, a7
; RV64IM-NEXT:    mulhu t1, a1, a3
; RV64IM-NEXT:    mul t2, t1, a7
; RV64IM-NEXT:    mulhu t3, a5, a3
; RV64IM-NEXT:    mul t4, t3, a7
; RV64IM-NEXT:    mulhu a3, a4, a3
; RV64IM-NEXT:    mul a7, a3, a7
; RV64IM-NEXT:    add a3, a4, a3
; RV64IM-NEXT:    subw a3, a3, a7
; RV64IM-NEXT:    add a5, a5, t3
; RV64IM-NEXT:    subw a4, a5, t4
; RV64IM-NEXT:    add a1, a1, t1
; RV64IM-NEXT:    subw a1, a1, t2
; RV64IM-NEXT:    add a2, a2, a6
; RV64IM-NEXT:    subw a2, a2, t0
; RV64IM-NEXT:    sh a2, 6(a0)
; RV64IM-NEXT:    sh a1, 4(a0)
; RV64IM-NEXT:    sh a4, 2(a0)
; RV64IM-NEXT:    sh a3, 0(a0)
; RV64IM-NEXT:    ret
  %1 = urem <4 x i16> %x, <i16 95, i16 95, i16 95, i16 95>
  %2 = udiv <4 x i16> %x, <i16 95, i16 95, i16 95, i16 95>
  %3 = add <4 x i16> %1, %2
  ret <4 x i16> %3
}

; Don't fold for divisors that are a power of two.
define <4 x i16> @dont_fold_urem_power_of_two(<4 x i16> %x) nounwind {
; RV32I-LABEL: dont_fold_urem_power_of_two:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -32
; RV32I-NEXT:    sw ra, 28(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s0, 24(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s1, 20(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s2, 16(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s3, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    lhu s1, 8(a1)
; RV32I-NEXT:    lhu s2, 4(a1)
; RV32I-NEXT:    lhu s3, 0(a1)
; RV32I-NEXT:    lhu a2, 12(a1)
; RV32I-NEXT:    mv s0, a0
; RV32I-NEXT:    li a1, 95
; RV32I-NEXT:    mv a0, a2
; RV32I-NEXT:    call __umodsi3
; RV32I-NEXT:    andi a1, s3, 63
; RV32I-NEXT:    andi a2, s2, 31
; RV32I-NEXT:    andi s1, s1, 7
; RV32I-NEXT:    sh a0, 6(s0)
; RV32I-NEXT:    sh s1, 4(s0)
; RV32I-NEXT:    sh a2, 2(s0)
; RV32I-NEXT:    sh a1, 0(s0)
; RV32I-NEXT:    lw ra, 28(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s0, 24(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s1, 20(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s2, 16(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s3, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 32
; RV32I-NEXT:    ret
;
; RV32IM-LABEL: dont_fold_urem_power_of_two:
; RV32IM:       # %bb.0:
; RV32IM-NEXT:    lhu a2, 8(a1)
; RV32IM-NEXT:    lhu a3, 4(a1)
; RV32IM-NEXT:    lhu a4, 12(a1)
; RV32IM-NEXT:    lhu a1, 0(a1)
; RV32IM-NEXT:    lui a5, 11038
; RV32IM-NEXT:    addi a5, a5, -1465
; RV32IM-NEXT:    mulhu a5, a4, a5
; RV32IM-NEXT:    li a6, 95
; RV32IM-NEXT:    mul a5, a5, a6
; RV32IM-NEXT:    sub a4, a4, a5
; RV32IM-NEXT:    andi a1, a1, 63
; RV32IM-NEXT:    andi a3, a3, 31
; RV32IM-NEXT:    andi a2, a2, 7
; RV32IM-NEXT:    sh a2, 4(a0)
; RV32IM-NEXT:    sh a3, 2(a0)
; RV32IM-NEXT:    sh a1, 0(a0)
; RV32IM-NEXT:    sh a4, 6(a0)
; RV32IM-NEXT:    ret
;
; RV64I-LABEL: dont_fold_urem_power_of_two:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -48
; RV64I-NEXT:    sd ra, 40(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s0, 32(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s1, 24(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s2, 16(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s3, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    lhu s1, 16(a1)
; RV64I-NEXT:    lhu s2, 8(a1)
; RV64I-NEXT:    lhu s3, 0(a1)
; RV64I-NEXT:    lhu a2, 24(a1)
; RV64I-NEXT:    mv s0, a0
; RV64I-NEXT:    li a1, 95
; RV64I-NEXT:    mv a0, a2
; RV64I-NEXT:    call __umoddi3
; RV64I-NEXT:    andi a1, s3, 63
; RV64I-NEXT:    andi a2, s2, 31
; RV64I-NEXT:    andi s1, s1, 7
; RV64I-NEXT:    sh a0, 6(s0)
; RV64I-NEXT:    sh s1, 4(s0)
; RV64I-NEXT:    sh a2, 2(s0)
; RV64I-NEXT:    sh a1, 0(s0)
; RV64I-NEXT:    ld ra, 40(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s0, 32(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s1, 24(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s2, 16(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s3, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 48
; RV64I-NEXT:    ret
;
; RV64IM-LABEL: dont_fold_urem_power_of_two:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    lhu a2, 24(a1)
; RV64IM-NEXT:    lui a3, %hi(.LCPI3_0)
; RV64IM-NEXT:    ld a3, %lo(.LCPI3_0)(a3)
; RV64IM-NEXT:    lhu a4, 16(a1)
; RV64IM-NEXT:    lhu a5, 8(a1)
; RV64IM-NEXT:    lhu a1, 0(a1)
; RV64IM-NEXT:    mulhu a3, a2, a3
; RV64IM-NEXT:    li a6, 95
; RV64IM-NEXT:    mul a3, a3, a6
; RV64IM-NEXT:    subw a2, a2, a3
; RV64IM-NEXT:    andi a1, a1, 63
; RV64IM-NEXT:    andi a5, a5, 31
; RV64IM-NEXT:    andi a4, a4, 7
; RV64IM-NEXT:    sh a4, 4(a0)
; RV64IM-NEXT:    sh a5, 2(a0)
; RV64IM-NEXT:    sh a1, 0(a0)
; RV64IM-NEXT:    sh a2, 6(a0)
; RV64IM-NEXT:    ret
  %1 = urem <4 x i16> %x, <i16 64, i16 32, i16 8, i16 95>
  ret <4 x i16> %1
}

; Don't fold if the divisor is one.
define <4 x i16> @dont_fold_urem_one(<4 x i16> %x) nounwind {
; RV32I-LABEL: dont_fold_urem_one:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -32
; RV32I-NEXT:    sw ra, 28(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s0, 24(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s1, 20(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s2, 16(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s3, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    lhu s0, 12(a1)
; RV32I-NEXT:    lhu s1, 8(a1)
; RV32I-NEXT:    lhu a2, 4(a1)
; RV32I-NEXT:    mv s2, a0
; RV32I-NEXT:    li a1, 654
; RV32I-NEXT:    mv a0, a2
; RV32I-NEXT:    call __umodsi3
; RV32I-NEXT:    mv s3, a0
; RV32I-NEXT:    li a1, 23
; RV32I-NEXT:    mv a0, s1
; RV32I-NEXT:    call __umodsi3
; RV32I-NEXT:    mv s1, a0
; RV32I-NEXT:    lui a0, 1
; RV32I-NEXT:    addi a1, a0, 1327
; RV32I-NEXT:    mv a0, s0
; RV32I-NEXT:    call __umodsi3
; RV32I-NEXT:    sh a0, 6(s2)
; RV32I-NEXT:    sh s1, 4(s2)
; RV32I-NEXT:    sh s3, 2(s2)
; RV32I-NEXT:    sh zero, 0(s2)
; RV32I-NEXT:    lw ra, 28(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s0, 24(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s1, 20(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s2, 16(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s3, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 32
; RV32I-NEXT:    ret
;
; RV32IM-LABEL: dont_fold_urem_one:
; RV32IM:       # %bb.0:
; RV32IM-NEXT:    lhu a2, 12(a1)
; RV32IM-NEXT:    lhu a3, 4(a1)
; RV32IM-NEXT:    lhu a1, 8(a1)
; RV32IM-NEXT:    lui a4, 1603
; RV32IM-NEXT:    addi a4, a4, 1341
; RV32IM-NEXT:    mulhu a4, a3, a4
; RV32IM-NEXT:    li a5, 654
; RV32IM-NEXT:    mul a4, a4, a5
; RV32IM-NEXT:    sub a3, a3, a4
; RV32IM-NEXT:    lui a4, 45590
; RV32IM-NEXT:    addi a4, a4, 1069
; RV32IM-NEXT:    mulhu a4, a1, a4
; RV32IM-NEXT:    li a5, 23
; RV32IM-NEXT:    mul a4, a4, a5
; RV32IM-NEXT:    sub a1, a1, a4
; RV32IM-NEXT:    lui a4, 193
; RV32IM-NEXT:    addi a4, a4, 1464
; RV32IM-NEXT:    mulhu a4, a2, a4
; RV32IM-NEXT:    lui a5, 1
; RV32IM-NEXT:    addi a5, a5, 1327
; RV32IM-NEXT:    mul a4, a4, a5
; RV32IM-NEXT:    sub a2, a2, a4
; RV32IM-NEXT:    sh zero, 0(a0)
; RV32IM-NEXT:    sh a2, 6(a0)
; RV32IM-NEXT:    sh a1, 4(a0)
; RV32IM-NEXT:    sh a3, 2(a0)
; RV32IM-NEXT:    ret
;
; RV64I-LABEL: dont_fold_urem_one:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -48
; RV64I-NEXT:    sd ra, 40(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s0, 32(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s1, 24(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s2, 16(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s3, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    lhu s0, 24(a1)
; RV64I-NEXT:    lhu s1, 16(a1)
; RV64I-NEXT:    lhu a2, 8(a1)
; RV64I-NEXT:    mv s2, a0
; RV64I-NEXT:    li a1, 654
; RV64I-NEXT:    mv a0, a2
; RV64I-NEXT:    call __umoddi3
; RV64I-NEXT:    mv s3, a0
; RV64I-NEXT:    li a1, 23
; RV64I-NEXT:    mv a0, s1
; RV64I-NEXT:    call __umoddi3
; RV64I-NEXT:    mv s1, a0
; RV64I-NEXT:    lui a0, 1
; RV64I-NEXT:    addiw a1, a0, 1327
; RV64I-NEXT:    mv a0, s0
; RV64I-NEXT:    call __umoddi3
; RV64I-NEXT:    sh a0, 6(s2)
; RV64I-NEXT:    sh s1, 4(s2)
; RV64I-NEXT:    sh s3, 2(s2)
; RV64I-NEXT:    sh zero, 0(s2)
; RV64I-NEXT:    ld ra, 40(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s0, 32(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s1, 24(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s2, 16(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s3, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 48
; RV64I-NEXT:    ret
;
; RV64IM-LABEL: dont_fold_urem_one:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    lhu a2, 8(a1)
; RV64IM-NEXT:    lui a3, %hi(.LCPI4_0)
; RV64IM-NEXT:    ld a3, %lo(.LCPI4_0)(a3)
; RV64IM-NEXT:    lhu a4, 24(a1)
; RV64IM-NEXT:    lhu a1, 16(a1)
; RV64IM-NEXT:    mulhu a3, a2, a3
; RV64IM-NEXT:    lui a5, %hi(.LCPI4_1)
; RV64IM-NEXT:    ld a5, %lo(.LCPI4_1)(a5)
; RV64IM-NEXT:    li a6, 654
; RV64IM-NEXT:    mul a3, a3, a6
; RV64IM-NEXT:    subw a2, a2, a3
; RV64IM-NEXT:    mulhu a3, a1, a5
; RV64IM-NEXT:    lui a5, %hi(.LCPI4_2)
; RV64IM-NEXT:    ld a5, %lo(.LCPI4_2)(a5)
; RV64IM-NEXT:    li a6, 23
; RV64IM-NEXT:    mul a3, a3, a6
; RV64IM-NEXT:    subw a1, a1, a3
; RV64IM-NEXT:    mulhu a3, a4, a5
; RV64IM-NEXT:    lui a5, 1
; RV64IM-NEXT:    addi a5, a5, 1327
; RV64IM-NEXT:    mul a3, a3, a5
; RV64IM-NEXT:    subw a4, a4, a3
; RV64IM-NEXT:    sh zero, 0(a0)
; RV64IM-NEXT:    sh a4, 6(a0)
; RV64IM-NEXT:    sh a1, 4(a0)
; RV64IM-NEXT:    sh a2, 2(a0)
; RV64IM-NEXT:    ret
  %1 = urem <4 x i16> %x, <i16 1, i16 654, i16 23, i16 5423>
  ret <4 x i16> %1
}

; Don't fold if the divisor is 2^16.
define <4 x i16> @dont_fold_urem_i16_smax(<4 x i16> %x) nounwind {
; CHECK-LABEL: dont_fold_urem_i16_smax:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %1 = urem <4 x i16> %x, <i16 1, i16 65536, i16 23, i16 5423>
  ret <4 x i16> %1
}

; Don't fold i64 urem.
define <4 x i64> @dont_fold_urem_i64(<4 x i64> %x) nounwind {
; RV32I-LABEL: dont_fold_urem_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -48
; RV32I-NEXT:    sw ra, 44(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s0, 40(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s1, 36(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s2, 32(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s3, 28(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s4, 24(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s5, 20(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s6, 16(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s7, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s8, 8(sp) # 4-byte Folded Spill
; RV32I-NEXT:    lw s0, 24(a1)
; RV32I-NEXT:    lw s1, 28(a1)
; RV32I-NEXT:    lw s2, 16(a1)
; RV32I-NEXT:    lw s3, 20(a1)
; RV32I-NEXT:    lw s4, 8(a1)
; RV32I-NEXT:    lw s5, 12(a1)
; RV32I-NEXT:    lw a3, 0(a1)
; RV32I-NEXT:    lw a1, 4(a1)
; RV32I-NEXT:    mv s6, a0
; RV32I-NEXT:    li a2, 1
; RV32I-NEXT:    mv a0, a3
; RV32I-NEXT:    li a3, 0
; RV32I-NEXT:    call __umoddi3
; RV32I-NEXT:    mv s7, a0
; RV32I-NEXT:    mv s8, a1
; RV32I-NEXT:    li a2, 654
; RV32I-NEXT:    mv a0, s4
; RV32I-NEXT:    mv a1, s5
; RV32I-NEXT:    li a3, 0
; RV32I-NEXT:    call __umoddi3
; RV32I-NEXT:    mv s4, a0
; RV32I-NEXT:    mv s5, a1
; RV32I-NEXT:    li a2, 23
; RV32I-NEXT:    mv a0, s2
; RV32I-NEXT:    mv a1, s3
; RV32I-NEXT:    li a3, 0
; RV32I-NEXT:    call __umoddi3
; RV32I-NEXT:    mv s2, a0
; RV32I-NEXT:    mv s3, a1
; RV32I-NEXT:    lui a0, 1
; RV32I-NEXT:    addi a2, a0, 1327
; RV32I-NEXT:    mv a0, s0
; RV32I-NEXT:    mv a1, s1
; RV32I-NEXT:    li a3, 0
; RV32I-NEXT:    call __umoddi3
; RV32I-NEXT:    sw a1, 28(s6)
; RV32I-NEXT:    sw a0, 24(s6)
; RV32I-NEXT:    sw s3, 20(s6)
; RV32I-NEXT:    sw s2, 16(s6)
; RV32I-NEXT:    sw s5, 12(s6)
; RV32I-NEXT:    sw s4, 8(s6)
; RV32I-NEXT:    sw s8, 4(s6)
; RV32I-NEXT:    sw s7, 0(s6)
; RV32I-NEXT:    lw ra, 44(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s0, 40(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s1, 36(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s2, 32(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s3, 28(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s4, 24(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s5, 20(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s6, 16(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s7, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s8, 8(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 48
; RV32I-NEXT:    ret
;
; RV32IM-LABEL: dont_fold_urem_i64:
; RV32IM:       # %bb.0:
; RV32IM-NEXT:    addi sp, sp, -48
; RV32IM-NEXT:    sw ra, 44(sp) # 4-byte Folded Spill
; RV32IM-NEXT:    sw s0, 40(sp) # 4-byte Folded Spill
; RV32IM-NEXT:    sw s1, 36(sp) # 4-byte Folded Spill
; RV32IM-NEXT:    sw s2, 32(sp) # 4-byte Folded Spill
; RV32IM-NEXT:    sw s3, 28(sp) # 4-byte Folded Spill
; RV32IM-NEXT:    sw s4, 24(sp) # 4-byte Folded Spill
; RV32IM-NEXT:    sw s5, 20(sp) # 4-byte Folded Spill
; RV32IM-NEXT:    sw s6, 16(sp) # 4-byte Folded Spill
; RV32IM-NEXT:    sw s7, 12(sp) # 4-byte Folded Spill
; RV32IM-NEXT:    sw s8, 8(sp) # 4-byte Folded Spill
; RV32IM-NEXT:    lw s0, 24(a1)
; RV32IM-NEXT:    lw s1, 28(a1)
; RV32IM-NEXT:    lw s2, 16(a1)
; RV32IM-NEXT:    lw s3, 20(a1)
; RV32IM-NEXT:    lw s4, 8(a1)
; RV32IM-NEXT:    lw s5, 12(a1)
; RV32IM-NEXT:    lw a3, 0(a1)
; RV32IM-NEXT:    lw a1, 4(a1)
; RV32IM-NEXT:    mv s6, a0
; RV32IM-NEXT:    li a2, 1
; RV32IM-NEXT:    mv a0, a3
; RV32IM-NEXT:    li a3, 0
; RV32IM-NEXT:    call __umoddi3
; RV32IM-NEXT:    mv s7, a0
; RV32IM-NEXT:    mv s8, a1
; RV32IM-NEXT:    li a2, 654
; RV32IM-NEXT:    mv a0, s4
; RV32IM-NEXT:    mv a1, s5
; RV32IM-NEXT:    li a3, 0
; RV32IM-NEXT:    call __umoddi3
; RV32IM-NEXT:    mv s4, a0
; RV32IM-NEXT:    mv s5, a1
; RV32IM-NEXT:    li a2, 23
; RV32IM-NEXT:    mv a0, s2
; RV32IM-NEXT:    mv a1, s3
; RV32IM-NEXT:    li a3, 0
; RV32IM-NEXT:    call __umoddi3
; RV32IM-NEXT:    mv s2, a0
; RV32IM-NEXT:    mv s3, a1
; RV32IM-NEXT:    lui a0, 1
; RV32IM-NEXT:    addi a2, a0, 1327
; RV32IM-NEXT:    mv a0, s0
; RV32IM-NEXT:    mv a1, s1
; RV32IM-NEXT:    li a3, 0
; RV32IM-NEXT:    call __umoddi3
; RV32IM-NEXT:    sw a1, 28(s6)
; RV32IM-NEXT:    sw a0, 24(s6)
; RV32IM-NEXT:    sw s3, 20(s6)
; RV32IM-NEXT:    sw s2, 16(s6)
; RV32IM-NEXT:    sw s5, 12(s6)
; RV32IM-NEXT:    sw s4, 8(s6)
; RV32IM-NEXT:    sw s8, 4(s6)
; RV32IM-NEXT:    sw s7, 0(s6)
; RV32IM-NEXT:    lw ra, 44(sp) # 4-byte Folded Reload
; RV32IM-NEXT:    lw s0, 40(sp) # 4-byte Folded Reload
; RV32IM-NEXT:    lw s1, 36(sp) # 4-byte Folded Reload
; RV32IM-NEXT:    lw s2, 32(sp) # 4-byte Folded Reload
; RV32IM-NEXT:    lw s3, 28(sp) # 4-byte Folded Reload
; RV32IM-NEXT:    lw s4, 24(sp) # 4-byte Folded Reload
; RV32IM-NEXT:    lw s5, 20(sp) # 4-byte Folded Reload
; RV32IM-NEXT:    lw s6, 16(sp) # 4-byte Folded Reload
; RV32IM-NEXT:    lw s7, 12(sp) # 4-byte Folded Reload
; RV32IM-NEXT:    lw s8, 8(sp) # 4-byte Folded Reload
; RV32IM-NEXT:    addi sp, sp, 48
; RV32IM-NEXT:    ret
;
; RV64I-LABEL: dont_fold_urem_i64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -48
; RV64I-NEXT:    sd ra, 40(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s0, 32(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s1, 24(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s2, 16(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s3, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    ld s0, 24(a1)
; RV64I-NEXT:    ld s1, 16(a1)
; RV64I-NEXT:    ld a2, 8(a1)
; RV64I-NEXT:    mv s2, a0
; RV64I-NEXT:    li a1, 654
; RV64I-NEXT:    mv a0, a2
; RV64I-NEXT:    call __umoddi3
; RV64I-NEXT:    mv s3, a0
; RV64I-NEXT:    li a1, 23
; RV64I-NEXT:    mv a0, s1
; RV64I-NEXT:    call __umoddi3
; RV64I-NEXT:    mv s1, a0
; RV64I-NEXT:    lui a0, 1
; RV64I-NEXT:    addiw a1, a0, 1327
; RV64I-NEXT:    mv a0, s0
; RV64I-NEXT:    call __umoddi3
; RV64I-NEXT:    sd a0, 24(s2)
; RV64I-NEXT:    sd s1, 16(s2)
; RV64I-NEXT:    sd s3, 8(s2)
; RV64I-NEXT:    sd zero, 0(s2)
; RV64I-NEXT:    ld ra, 40(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s0, 32(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s1, 24(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s2, 16(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s3, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 48
; RV64I-NEXT:    ret
;
; RV64IM-LABEL: dont_fold_urem_i64:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    ld a2, 16(a1)
; RV64IM-NEXT:    lui a3, %hi(.LCPI6_0)
; RV64IM-NEXT:    ld a3, %lo(.LCPI6_0)(a3)
; RV64IM-NEXT:    ld a4, 24(a1)
; RV64IM-NEXT:    ld a1, 8(a1)
; RV64IM-NEXT:    mulhu a3, a2, a3
; RV64IM-NEXT:    sub a5, a2, a3
; RV64IM-NEXT:    srli a5, a5, 1
; RV64IM-NEXT:    add a3, a5, a3
; RV64IM-NEXT:    srli a3, a3, 4
; RV64IM-NEXT:    li a5, 23
; RV64IM-NEXT:    lui a6, %hi(.LCPI6_1)
; RV64IM-NEXT:    ld a6, %lo(.LCPI6_1)(a6)
; RV64IM-NEXT:    mul a3, a3, a5
; RV64IM-NEXT:    sub a2, a2, a3
; RV64IM-NEXT:    srli a3, a1, 1
; RV64IM-NEXT:    mulhu a3, a3, a6
; RV64IM-NEXT:    srli a3, a3, 7
; RV64IM-NEXT:    lui a5, %hi(.LCPI6_2)
; RV64IM-NEXT:    ld a5, %lo(.LCPI6_2)(a5)
; RV64IM-NEXT:    li a6, 654
; RV64IM-NEXT:    mul a3, a3, a6
; RV64IM-NEXT:    sub a1, a1, a3
; RV64IM-NEXT:    mulhu a3, a4, a5
; RV64IM-NEXT:    srli a3, a3, 12
; RV64IM-NEXT:    lui a5, 1
; RV64IM-NEXT:    addiw a5, a5, 1327
; RV64IM-NEXT:    mul a3, a3, a5
; RV64IM-NEXT:    sub a4, a4, a3
; RV64IM-NEXT:    sd zero, 0(a0)
; RV64IM-NEXT:    sd a4, 24(a0)
; RV64IM-NEXT:    sd a1, 8(a0)
; RV64IM-NEXT:    sd a2, 16(a0)
; RV64IM-NEXT:    ret
  %1 = urem <4 x i64> %x, <i64 1, i64 654, i64 23, i64 5423>
  ret <4 x i64> %1
}
