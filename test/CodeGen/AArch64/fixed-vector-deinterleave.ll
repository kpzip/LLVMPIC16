; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-none-linux-gnu %s -o - | FileCheck %s --check-prefixes=CHECK,CHECK-SD
; RUN: llc -mtriple=aarch64-none-linux-gnu -global-isel -global-isel-abort=2 %s -o - 2>&1 | FileCheck %s --check-prefixes=CHECK,CHECK-GI

define {<2 x half>, <2 x half>} @vector_deinterleave_v2f16_v4f16(<4 x half> %vec) {
; CHECK-SD-LABEL: vector_deinterleave_v2f16_v4f16:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-SD-NEXT:    dup v2.2s, v0.s[1]
; CHECK-SD-NEXT:    mov v1.16b, v2.16b
; CHECK-SD-NEXT:    mov v1.h[0], v0.h[1]
; CHECK-SD-NEXT:    mov v0.h[1], v2.h[0]
; CHECK-SD-NEXT:    // kill: def $d0 killed $d0 killed $q0
; CHECK-SD-NEXT:    // kill: def $d1 killed $d1 killed $q1
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: vector_deinterleave_v2f16_v4f16:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    uzp1 v2.4h, v0.4h, v0.4h
; CHECK-GI-NEXT:    uzp2 v1.4h, v0.4h, v0.4h
; CHECK-GI-NEXT:    mov h0, v2.h[1]
; CHECK-GI-NEXT:    mov h3, v1.h[1]
; CHECK-GI-NEXT:    mov v2.h[1], v0.h[0]
; CHECK-GI-NEXT:    mov v1.h[1], v3.h[0]
; CHECK-GI-NEXT:    // kill: def $d1 killed $d1 killed $q1
; CHECK-GI-NEXT:    fmov d0, d2
; CHECK-GI-NEXT:    ret
  %retval = call {<2 x half>, <2 x half>} @llvm.vector.deinterleave2.v4f16(<4 x half> %vec)
  ret {<2 x half>, <2 x half>}   %retval
}

define {<4 x half>, <4 x half>} @vector_deinterleave_v4f16_v8f16(<8 x half> %vec) {
; CHECK-LABEL: vector_deinterleave_v4f16_v8f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    uzp1 v2.8h, v0.8h, v0.8h
; CHECK-NEXT:    uzp2 v1.8h, v0.8h, v0.8h
; CHECK-NEXT:    // kill: def $d1 killed $d1 killed $q1
; CHECK-NEXT:    fmov d0, d2
; CHECK-NEXT:    ret
  %retval = call {<4 x half>, <4 x half>} @llvm.vector.deinterleave2.v8f16(<8 x half> %vec)
  ret {<4 x half>, <4 x half>}   %retval
}

define {<8 x half>, <8 x half>} @vector_deinterleave_v8f16_v16f16(<16 x half> %vec) {
; CHECK-LABEL: vector_deinterleave_v8f16_v16f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    uzp1 v2.8h, v0.8h, v1.8h
; CHECK-NEXT:    uzp2 v1.8h, v0.8h, v1.8h
; CHECK-NEXT:    mov v0.16b, v2.16b
; CHECK-NEXT:    ret
  %retval = call {<8 x half>, <8 x half>} @llvm.vector.deinterleave2.v16f16(<16 x half> %vec)
  ret {<8 x half>, <8 x half>}   %retval
}

define {<2 x float>, <2 x float>} @vector_deinterleave_v2f32_v4f32(<4 x float> %vec) {
; CHECK-SD-LABEL: vector_deinterleave_v2f32_v4f32:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    ext v1.16b, v0.16b, v0.16b, #8
; CHECK-SD-NEXT:    zip1 v2.2s, v0.2s, v1.2s
; CHECK-SD-NEXT:    zip2 v1.2s, v0.2s, v1.2s
; CHECK-SD-NEXT:    fmov d0, d2
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: vector_deinterleave_v2f32_v4f32:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    uzp1 v2.4s, v0.4s, v0.4s
; CHECK-GI-NEXT:    uzp2 v1.4s, v0.4s, v0.4s
; CHECK-GI-NEXT:    // kill: def $d1 killed $d1 killed $q1
; CHECK-GI-NEXT:    fmov d0, d2
; CHECK-GI-NEXT:    ret
  %retval = call {<2 x float>, <2 x float>} @llvm.vector.deinterleave2.v4f32(<4 x float> %vec)
  ret {<2 x float>, <2 x float>}   %retval
}

define {<4 x float>, <4 x float>} @vector_deinterleave_v4f32_v8f32(<8 x float> %vec) {
; CHECK-LABEL: vector_deinterleave_v4f32_v8f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    uzp1 v2.4s, v0.4s, v1.4s
; CHECK-NEXT:    uzp2 v1.4s, v0.4s, v1.4s
; CHECK-NEXT:    mov v0.16b, v2.16b
; CHECK-NEXT:    ret
  %retval = call {<4 x float>, <4 x float>} @llvm.vector.deinterleave2.v8f32(<8 x float> %vec)
ret  {<4 x float>, <4 x float>}   %retval
}

define {<2 x double>, <2 x double>} @vector_deinterleave_v2f64_v4f64(<4 x double> %vec) {
; CHECK-LABEL: vector_deinterleave_v2f64_v4f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    zip1 v2.2d, v0.2d, v1.2d
; CHECK-NEXT:    zip2 v1.2d, v0.2d, v1.2d
; CHECK-NEXT:    mov v0.16b, v2.16b
; CHECK-NEXT:    ret
  %retval = call {<2 x double>, <2 x double>} @llvm.vector.deinterleave2.v4f64(<4 x double> %vec)
  ret {<2 x double>, <2 x double>}   %retval
}

; Integers

define {<16 x i8>, <16 x i8>} @vector_deinterleave_v16i8_v32i8(<32 x i8> %vec) {
; CHECK-LABEL: vector_deinterleave_v16i8_v32i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    uzp1 v2.16b, v0.16b, v1.16b
; CHECK-NEXT:    uzp2 v1.16b, v0.16b, v1.16b
; CHECK-NEXT:    mov v0.16b, v2.16b
; CHECK-NEXT:    ret
  %retval = call {<16 x i8>, <16 x i8>} @llvm.vector.deinterleave2.v32i8(<32 x i8> %vec)
  ret {<16 x i8>, <16 x i8>}   %retval
}

define {<8 x i16>, <8 x i16>} @vector_deinterleave_v8i16_v16i16(<16 x i16> %vec) {
; CHECK-LABEL: vector_deinterleave_v8i16_v16i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    uzp1 v2.8h, v0.8h, v1.8h
; CHECK-NEXT:    uzp2 v1.8h, v0.8h, v1.8h
; CHECK-NEXT:    mov v0.16b, v2.16b
; CHECK-NEXT:    ret
  %retval = call {<8 x i16>, <8 x i16>} @llvm.vector.deinterleave2.v16i16(<16 x i16> %vec)
  ret {<8 x i16>, <8 x i16>}   %retval
}

define {<4 x i32>, <4 x i32>} @vector_deinterleave_v4i32_v8i32(<8 x i32> %vec) {
; CHECK-LABEL: vector_deinterleave_v4i32_v8i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    uzp1 v2.4s, v0.4s, v1.4s
; CHECK-NEXT:    uzp2 v1.4s, v0.4s, v1.4s
; CHECK-NEXT:    mov v0.16b, v2.16b
; CHECK-NEXT:    ret
  %retval = call {<4 x i32>, <4 x i32>} @llvm.vector.deinterleave2.v8i32(<8 x i32> %vec)
  ret {<4 x i32>, <4 x i32>}   %retval
}

define {<2 x i64>, <2 x i64>} @vector_deinterleave_v2i64_v4i64(<4 x i64> %vec) {
; CHECK-LABEL: vector_deinterleave_v2i64_v4i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    zip1 v2.2d, v0.2d, v1.2d
; CHECK-NEXT:    zip2 v1.2d, v0.2d, v1.2d
; CHECK-NEXT:    mov v0.16b, v2.16b
; CHECK-NEXT:    ret
  %retval = call {<2 x i64>, <2 x i64>} @llvm.vector.deinterleave2.v4i64(<4 x i64> %vec)
  ret {<2 x i64>, <2 x i64>}   %retval
}


; Floating declarations
declare {<2 x half>,<2 x half>} @llvm.vector.deinterleave2.v4f16(<4 x half>)
declare {<4 x half>, <4 x half>} @llvm.vector.deinterleave2.v8f16(<8 x half>)
declare {<2 x float>, <2 x float>} @llvm.vector.deinterleave2.v4f32(<4 x float>)
declare {<8 x half>, <8 x half>} @llvm.vector.deinterleave2.v16f16(<16 x half>)
declare {<4 x float>, <4 x float>} @llvm.vector.deinterleave2.v8f32(<8 x float>)
declare {<2 x double>, <2 x double>} @llvm.vector.deinterleave2.v4f64(<4 x double>)

; Integer declarations
declare {<16 x i8>, <16 x i8>} @llvm.vector.deinterleave2.v32i8(<32 x i8>)
declare {<8 x i16>, <8 x i16>} @llvm.vector.deinterleave2.v16i16(<16 x i16>)
declare {<4 x i32>, <4 x i32>} @llvm.vector.deinterleave2.v8i32(<8 x i32>)
declare {<2 x i64>, <2 x i64>} @llvm.vector.deinterleave2.v4i64(<4 x i64>)

