; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=aarch64-- | FileCheck %s

; With no-wrap:
; (X * Y) == 0 --> (X == 0) || (Y == 0)
; (X * Y) != 0 --> (X != 0) && (Y != 0)

define i1 @mul_nsw_eq0_i8(i8 %x, i8 %y) {
; CHECK-LABEL: mul_nsw_eq0_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    tst w0, #0xff
; CHECK-NEXT:    cset w8, eq
; CHECK-NEXT:    tst w1, #0xff
; CHECK-NEXT:    csinc w0, w8, wzr, ne
; CHECK-NEXT:    ret
  %m = mul nsw i8 %x, %y
  %r = icmp eq i8 %m, 0
  ret i1 %r
}

; negative test - not valid if mul can overflow

define i1 @mul_eq0_i8(i8 %x, i8 %y) {
; CHECK-LABEL: mul_eq0_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mul w8, w0, w1
; CHECK-NEXT:    tst w8, #0xff
; CHECK-NEXT:    cset w0, eq
; CHECK-NEXT:    ret
  %m = mul i8 %x, %y
  %r = icmp eq i8 %m, 0
  ret i1 %r
}

; negative test - don't try with minsize

define i1 @mul_nsw_eq0_i8_size(i8 %x, i8 %y) minsize {
; CHECK-LABEL: mul_nsw_eq0_i8_size:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mul w8, w0, w1
; CHECK-NEXT:    tst w8, #0xff
; CHECK-NEXT:    cset w0, eq
; CHECK-NEXT:    ret
  %m = mul nsw i8 %x, %y
  %r = icmp eq i8 %m, 0
  ret i1 %r
}

define i1 @mul_nsw_ne0_i16(i16 %x, i16 %y) {
; CHECK-LABEL: mul_nsw_ne0_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    tst w0, #0xffff
; CHECK-NEXT:    cset w8, ne
; CHECK-NEXT:    tst w1, #0xffff
; CHECK-NEXT:    csel w0, wzr, w8, eq
; CHECK-NEXT:    ret
  %m = mul nsw i16 %x, %y
  %r = icmp ne i16 %m, 0
  ret i1 %r
}

define i1 @mul_nuw_eq0_i32(i32 %x, i32 %y) {
; CHECK-LABEL: mul_nuw_eq0_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    cmp w0, #0
; CHECK-NEXT:    ccmp w1, #0, #4, ne
; CHECK-NEXT:    cset w0, eq
; CHECK-NEXT:    ret
  %m = mul nuw i32 %x, %y
  %r = icmp eq i32 %m, 0
  ret i1 %r
}

define i1 @mul_nsw_nuw_ne0_i64(i64 %x, i64 %y) {
; CHECK-LABEL: mul_nsw_nuw_ne0_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    cmp x0, #0
; CHECK-NEXT:    ccmp x1, #0, #4, ne
; CHECK-NEXT:    cset w0, ne
; CHECK-NEXT:    ret
  %m = mul nsw nuw i64 %x, %y
  %r = icmp ne i64 %m, 0
  ret i1 %r
}

define <16 x i1> @mul_nuw_eq0_v16i8(<16 x i8> %x, <16 x i8> %y) {
; CHECK-LABEL: mul_nuw_eq0_v16i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    cmeq v1.16b, v1.16b, #0
; CHECK-NEXT:    cmeq v0.16b, v0.16b, #0
; CHECK-NEXT:    orr v0.16b, v0.16b, v1.16b
; CHECK-NEXT:    ret
  %m = mul nuw <16 x i8> %x, %y
  %r = icmp eq <16 x i8> %m, zeroinitializer
  ret <16 x i1> %r
}

define <4 x i1> @mul_nsw_ne0_v4i32(<4 x i32> %x, <4 x i32> %y) {
; CHECK-LABEL: mul_nsw_ne0_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    cmtst v0.4s, v0.4s, v0.4s
; CHECK-NEXT:    cmeq v1.4s, v1.4s, #0
; CHECK-NEXT:    bic v0.16b, v0.16b, v1.16b
; CHECK-NEXT:    xtn v0.4h, v0.4s
; CHECK-NEXT:    ret
  %m = mul nsw <4 x i32> %x, %y
  %r = icmp ne <4 x i32> %m, zeroinitializer
  ret <4 x i1> %r
}

; negative test - don't try with minsize

define <4 x i1> @mul_nsw_ne0_v4i32_size(<4 x i32> %x, <4 x i32> %y) minsize {
; CHECK-LABEL: mul_nsw_ne0_v4i32_size:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mul v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    cmtst v0.4s, v0.4s, v0.4s
; CHECK-NEXT:    xtn v0.4h, v0.4s
; CHECK-NEXT:    ret
  %m = mul nsw <4 x i32> %x, %y
  %r = icmp ne <4 x i32> %m, zeroinitializer
  ret <4 x i1> %r
}
