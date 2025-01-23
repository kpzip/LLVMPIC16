; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=aarch64-- | FileCheck %s

; PR48683 'Quadratic Reciprocity' - and(mul(x,x),2) -> 0

define i1 @PR48683(i32 %x) {
; CHECK-LABEL: PR48683:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w0, wzr
; CHECK-NEXT:    ret
  %a = mul i32 %x, %x
  %b = and i32 %a, 2
  %c = icmp ne i32 %b, 0
  ret i1 %c
}

define <4 x i1> @PR48683_vec(<4 x i32> %x) {
; CHECK-LABEL: PR48683_vec:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v0.2d, #0000000000000000
; CHECK-NEXT:    ret
  %a = mul <4 x i32> %x, %x
  %b = and <4 x i32> %a, <i32 2, i32 2, i32 2, i32 2>
  %c = icmp ne <4 x i32> %b, zeroinitializer
  ret <4 x i1> %c
}

define <4 x i1> @PR48683_vec_undef(<4 x i32> %x) {
; CHECK-LABEL: PR48683_vec_undef:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v1.4s, #2
; CHECK-NEXT:    mul v0.4s, v0.4s, v0.4s
; CHECK-NEXT:    cmtst v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    xtn v0.4h, v0.4s
; CHECK-NEXT:    ret
  %a = mul <4 x i32> %x, %x
  %b = and <4 x i32> %a, <i32 2, i32 2, i32 2, i32 undef>
  %c = icmp ne <4 x i32> %b, zeroinitializer
  ret <4 x i1> %c
}

; mul(x,x) - bit[1] is 0, but if demanding the other bits the source must not be undef

define i64 @combine_mul_self_demandedbits(i64 %x) {
; CHECK-LABEL: combine_mul_self_demandedbits:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mul x0, x0, x0
; CHECK-NEXT:    ret
  %1 = mul i64 %x, %x
  %2 = and i64 %1, -3
  ret i64 %2
}

define <4 x i32> @combine_mul_self_demandedbits_vector(<4 x i32> %x) {
; CHECK-LABEL: combine_mul_self_demandedbits_vector:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mul v0.4s, v0.4s, v0.4s
; CHECK-NEXT:    ret
  %1 = freeze <4 x i32> %x
  %2 = mul <4 x i32> %1, %1
  %3 = and <4 x i32> %2, <i32 -3, i32 -3, i32 -3, i32 -3>
  ret <4 x i32> %3
}

define i8 @one_demanded_bit(i8 %x) {
; CHECK-LABEL: one_demanded_bit:
; CHECK:       // %bb.0:
; CHECK-NEXT:    lsl w8, w0, #6
; CHECK-NEXT:    orr w0, w8, #0xffffffbf
; CHECK-NEXT:    ret
  %m = mul i8 %x, 192  ; 0b1100_0000
  %r = or i8 %m, 191   ; 0b1011_1111
  ret i8 %r
}

define <2 x i64> @one_demanded_bit_splat(<2 x i64> %x) {
; CHECK-LABEL: one_demanded_bit_splat:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #32 // =0x20
; CHECK-NEXT:    shl v0.2d, v0.2d, #5
; CHECK-NEXT:    dup v1.2d, x8
; CHECK-NEXT:    and v0.16b, v0.16b, v1.16b
; CHECK-NEXT:    ret
  %m = mul <2 x i64> %x, <i64 160, i64 160> ; 0b1010_0000
  %r = and <2 x i64> %m, <i64 32, i64 32>   ; 0b0010_0000
  ret <2 x i64> %r
}

define i32 @one_demanded_low_bit(i32 %x) {
; CHECK-LABEL: one_demanded_low_bit:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and w0, w0, #0x1
; CHECK-NEXT:    ret
  %m = mul i32 %x, -63 ; any odd number will do
  %r = and i32 %m, 1
  ret i32 %r
}

define i16 @squared_one_demanded_low_bit(i16 %x) {
; CHECK-LABEL: squared_one_demanded_low_bit:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and w0, w0, #0x1
; CHECK-NEXT:    ret
  %mul = mul i16 %x, %x
  %and = and i16 %mul, 1
  ret i16 %and
}

define <4 x i32> @squared_one_demanded_low_bit_splat(<4 x i32> %x) {
; CHECK-LABEL: squared_one_demanded_low_bit_splat:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mvni v1.4s, #1
; CHECK-NEXT:    orr v0.16b, v0.16b, v1.16b
; CHECK-NEXT:    ret
  %mul = mul <4 x i32> %x, %x
  %and = or <4 x i32> %mul, <i32 -2, i32 -2, i32 -2, i32 -2>
  ret <4 x i32> %and
}

define i32 @squared_demanded_2_low_bits(i32 %x) {
; CHECK-LABEL: squared_demanded_2_low_bits:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and w0, w0, #0x1
; CHECK-NEXT:    ret
  %mul = mul i32 %x, %x
  %and = and i32 %mul, 3
  ret i32 %and
}

define <2 x i64> @squared_demanded_2_low_bits_splat(<2 x i64> %x) {
; CHECK-LABEL: squared_demanded_2_low_bits_splat:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov x8, #-2 // =0xfffffffffffffffe
; CHECK-NEXT:    dup v1.2d, x8
; CHECK-NEXT:    orr v0.16b, v0.16b, v1.16b
; CHECK-NEXT:    ret
  %mul = mul <2 x i64> %x, %x
  %and = or <2 x i64> %mul, <i64 -2, i64 -2>
  ret <2 x i64> %and
}
