; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=riscv64 -mattr=+v | FileCheck %s

; This test checks a regression in the vsetvli insertion pass. We used to
; prserve the VL on the second vsetvli with ratio e32/m1, when the the last
; update of VL was the vsetvli with e64/m4. Changing VTYPE here changes VLMAX
; which may make the original VL invalid. Instead of preserving it we use 0.

define i32 @illegal_preserve_vl(<vscale x 2 x i32> %a, <vscale x 4 x i64> %x, ptr %y) {
; CHECK-LABEL: illegal_preserve_vl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e64, m4, ta, ma
; CHECK-NEXT:    vadd.vv v12, v12, v12
; CHECK-NEXT:    vsetvli zero, zero, e32, m2, ta, ma
; CHECK-NEXT:    vmv.x.s a1, v8
; CHECK-NEXT:    vs4r.v v12, (a0)
; CHECK-NEXT:    mv a0, a1
; CHECK-NEXT:    ret
  %index = add <vscale x 4 x i64> %x, %x
  store <vscale x 4 x i64> %index, ptr %y
  %elt = extractelement <vscale x 2 x i32> %a, i64 0
  ret i32 %elt
}
