; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc --mtriple=loongarch64 --mattr=+lsx < %s | FileCheck %s

declare i32 @llvm.loongarch.lsx.bz.v(<16 x i8>)

define i32 @lsx_bz_v(<16 x i8> %va) nounwind {
; CHECK-LABEL: lsx_bz_v:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vseteqz.v $fcc0, $vr0
; CHECK-NEXT:    bcnez $fcc0, .LBB0_2
; CHECK-NEXT:  # %bb.1: # %entry
; CHECK-NEXT:    addi.w $a0, $zero, 0
; CHECK-NEXT:    ret
; CHECK-NEXT:  .LBB0_2: # %entry
; CHECK-NEXT:    addi.w $a0, $zero, 1
; CHECK-NEXT:    ret
entry:
  %res = call i32 @llvm.loongarch.lsx.bz.v(<16 x i8> %va)
  ret i32 %res
}

declare i32 @llvm.loongarch.lsx.bnz.v(<16 x i8>)

define i32 @lsx_bnz_v(<16 x i8> %va) nounwind {
; CHECK-LABEL: lsx_bnz_v:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetnez.v $fcc0, $vr0
; CHECK-NEXT:    bcnez $fcc0, .LBB1_2
; CHECK-NEXT:  # %bb.1: # %entry
; CHECK-NEXT:    addi.w $a0, $zero, 0
; CHECK-NEXT:    ret
; CHECK-NEXT:  .LBB1_2: # %entry
; CHECK-NEXT:    addi.w $a0, $zero, 1
; CHECK-NEXT:    ret
entry:
  %res = call i32 @llvm.loongarch.lsx.bnz.v(<16 x i8> %va)
  ret i32 %res
}
