; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 4
; RUN: llc < %s -mtriple=aarch64 | FileCheck %s

define i32 @f(ptr %arg, i41 %arg1, ptr %arg2) {
; CHECK-LABEL: f:
; CHECK:       // %bb.0: // %bb
; CHECK-NEXT:    and w9, w1, #0x1
; CHECK-NEXT:    mov w10, #1 // =0x1
; CHECK-NEXT:    mov x8, x0
; CHECK-NEXT:    cmp w9, #1
; CHECK-NEXT:    mov w0, wzr
; CHECK-NEXT:    adc x9, xzr, x10
; CHECK-NEXT:    str x9, [x2]
; CHECK-NEXT:    str xzr, [x8]
; CHECK-NEXT:    ret
bb:
  %new0 = and i41 %arg1, 1
  %last = trunc i41 %new0 to i1
  %i = add i64 0, 1
  %i3 = zext i1 %last to i64
  %i4 = add i64 %i, %i3
  %i5 = icmp ult i64 %i, 0
  %i6 = icmp ult i64 %i4, %i
  %i7 = and i1 %i5, %i6
  %i8 = zext i1 %i7 to i64
  store i64 %i4, ptr %arg2, align 8
  store i64 %i8, ptr %arg, align 8
  ret i32 0
}
