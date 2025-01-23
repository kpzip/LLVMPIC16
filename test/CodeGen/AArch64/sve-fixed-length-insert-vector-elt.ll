; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -aarch64-sve-vector-bits-min=256  < %s | FileCheck %s -check-prefixes=CHECK,VBITS_GE_256
; RUN: llc -aarch64-sve-vector-bits-min=512  < %s | FileCheck %s -check-prefixes=CHECK,VBITS_GE_512
; RUN: llc -aarch64-sve-vector-bits-min=2048 < %s | FileCheck %s -check-prefixes=CHECK,VBITS_GE_512

target triple = "aarch64-unknown-linux-gnu"

;
; insertelement
;

; Don't use SVE for 64-bit vectors.
define <4 x half> @insertelement_v4f16(<4 x half> %op1) vscale_range(2,0) #0 {
; CHECK-LABEL: insertelement_v4f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmov h1, #5.00000000
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-NEXT:    mov v0.h[3], v1.h[0]
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $q0
; CHECK-NEXT:    ret
  %r = insertelement <4 x half> %op1, half 5.0, i64 3
  ret <4 x half> %r
}

; Don't use SVE for 128-bit vectors.
define <8 x half> @insertelement_v8f16(<8 x half> %op1) vscale_range(2,0) #0 {
; CHECK-LABEL: insertelement_v8f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmov h1, #5.00000000
; CHECK-NEXT:    mov v0.h[7], v1.h[0]
; CHECK-NEXT:    ret
  %r = insertelement <8 x half> %op1, half 5.0, i64 7
  ret <8 x half> %r
}

define void @insertelement_v16f16(ptr %a, ptr %b) vscale_range(2,0) #0 {
; CHECK-LABEL: insertelement_v16f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #15 // =0xf
; CHECK-NEXT:    index z0.h, #0, #1
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    mov z1.h, w8
; CHECK-NEXT:    ptrue p1.h, vl16
; CHECK-NEXT:    cmpeq p0.h, p0/z, z0.h, z1.h
; CHECK-NEXT:    ld1h { z0.h }, p1/z, [x0]
; CHECK-NEXT:    fmov h1, #5.00000000
; CHECK-NEXT:    mov z0.h, p0/m, h1
; CHECK-NEXT:    st1h { z0.h }, p1, [x1]
; CHECK-NEXT:    ret
  %op1 = load <16 x half>, ptr %a
  %r = insertelement <16 x half> %op1, half 5.0, i64 15
  store <16 x half> %r, ptr %b
  ret void
}

define void @insertelement_v32f16(ptr %a, ptr %b) #0 {
; VBITS_GE_256-LABEL: insertelement_v32f16:
; VBITS_GE_256:       // %bb.0:
; VBITS_GE_256-NEXT:    mov w8, #15 // =0xf
; VBITS_GE_256-NEXT:    index z0.h, #0, #1
; VBITS_GE_256-NEXT:    ptrue p0.h
; VBITS_GE_256-NEXT:    mov z1.h, w8
; VBITS_GE_256-NEXT:    ptrue p1.h, vl16
; VBITS_GE_256-NEXT:    mov x8, #16 // =0x10
; VBITS_GE_256-NEXT:    cmpeq p0.h, p0/z, z0.h, z1.h
; VBITS_GE_256-NEXT:    fmov h0, #5.00000000
; VBITS_GE_256-NEXT:    ld1h { z1.h }, p1/z, [x0, x8, lsl #1]
; VBITS_GE_256-NEXT:    mov z1.h, p0/m, h0
; VBITS_GE_256-NEXT:    ld1h { z0.h }, p1/z, [x0]
; VBITS_GE_256-NEXT:    st1h { z1.h }, p1, [x1, x8, lsl #1]
; VBITS_GE_256-NEXT:    st1h { z0.h }, p1, [x1]
; VBITS_GE_256-NEXT:    ret
;
; VBITS_GE_512-LABEL: insertelement_v32f16:
; VBITS_GE_512:       // %bb.0:
; VBITS_GE_512-NEXT:    mov w8, #31 // =0x1f
; VBITS_GE_512-NEXT:    index z0.h, #0, #1
; VBITS_GE_512-NEXT:    ptrue p0.h
; VBITS_GE_512-NEXT:    mov z1.h, w8
; VBITS_GE_512-NEXT:    ptrue p1.h, vl32
; VBITS_GE_512-NEXT:    cmpeq p0.h, p0/z, z0.h, z1.h
; VBITS_GE_512-NEXT:    ld1h { z0.h }, p1/z, [x0]
; VBITS_GE_512-NEXT:    fmov h1, #5.00000000
; VBITS_GE_512-NEXT:    mov z0.h, p0/m, h1
; VBITS_GE_512-NEXT:    st1h { z0.h }, p1, [x1]
; VBITS_GE_512-NEXT:    ret
  %op1 = load <32 x half>, ptr %a
  %r = insertelement <32 x half> %op1, half 5.0, i64 31
  store <32 x half> %r, ptr %b
  ret void
}

define void @insertelement_v64f16(ptr %a, ptr %b) vscale_range(8,0) #0 {
; CHECK-LABEL: insertelement_v64f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #63 // =0x3f
; CHECK-NEXT:    index z0.h, #0, #1
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    mov z1.h, w8
; CHECK-NEXT:    ptrue p1.h, vl64
; CHECK-NEXT:    cmpeq p0.h, p0/z, z0.h, z1.h
; CHECK-NEXT:    ld1h { z0.h }, p1/z, [x0]
; CHECK-NEXT:    fmov h1, #5.00000000
; CHECK-NEXT:    mov z0.h, p0/m, h1
; CHECK-NEXT:    st1h { z0.h }, p1, [x1]
; CHECK-NEXT:    ret
  %op1 = load <64 x half>, ptr %a
  %r = insertelement <64 x half> %op1, half 5.0, i64 63
  store <64 x half> %r, ptr %b
  ret void
}

define void @insertelement_v128f16(ptr %a, ptr %b) vscale_range(16,0) #0 {
; CHECK-LABEL: insertelement_v128f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #127 // =0x7f
; CHECK-NEXT:    index z0.h, #0, #1
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    mov z1.h, w8
; CHECK-NEXT:    ptrue p1.h, vl128
; CHECK-NEXT:    cmpeq p0.h, p0/z, z0.h, z1.h
; CHECK-NEXT:    ld1h { z0.h }, p1/z, [x0]
; CHECK-NEXT:    fmov h1, #5.00000000
; CHECK-NEXT:    mov z0.h, p0/m, h1
; CHECK-NEXT:    st1h { z0.h }, p1, [x1]
; CHECK-NEXT:    ret
  %op1 = load <128 x half>, ptr %a
  %r = insertelement <128 x half> %op1, half 5.0, i64 127
  store <128 x half> %r, ptr %b
  ret void
}

; Don't use SVE for 64-bit vectors.
define <2 x float> @insertelement_v2f32(<2 x float> %op1) vscale_range(2,0) #0 {
; CHECK-LABEL: insertelement_v2f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmov s1, #5.00000000
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-NEXT:    mov v0.s[1], v1.s[0]
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $q0
; CHECK-NEXT:    ret
  %r = insertelement <2 x float> %op1, float 5.0, i64 1
  ret <2 x float> %r
}

; Don't use SVE for 128-bit vectors.
define <4 x float> @insertelement_v4f32(<4 x float> %op1) vscale_range(2,0) #0 {
; CHECK-LABEL: insertelement_v4f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmov s1, #5.00000000
; CHECK-NEXT:    mov v0.s[3], v1.s[0]
; CHECK-NEXT:    ret
  %r = insertelement <4 x float> %op1, float 5.0, i64 3
  ret <4 x float> %r
}

define void @insertelement_v8f32(ptr %a, ptr %b) vscale_range(2,0) #0 {
; CHECK-LABEL: insertelement_v8f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #7 // =0x7
; CHECK-NEXT:    index z0.s, #0, #1
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    mov z1.s, w8
; CHECK-NEXT:    ptrue p1.s, vl8
; CHECK-NEXT:    cmpeq p0.s, p0/z, z0.s, z1.s
; CHECK-NEXT:    ld1w { z0.s }, p1/z, [x0]
; CHECK-NEXT:    fmov s1, #5.00000000
; CHECK-NEXT:    mov z0.s, p0/m, s1
; CHECK-NEXT:    st1w { z0.s }, p1, [x1]
; CHECK-NEXT:    ret
  %op1 = load <8 x float>, ptr %a
  %r = insertelement <8 x float> %op1, float 5.0, i64 7
  store <8 x float> %r, ptr %b
  ret void
}

define void @insertelement_v16f32(ptr %a, ptr %b) #0 {
; VBITS_GE_256-LABEL: insertelement_v16f32:
; VBITS_GE_256:       // %bb.0:
; VBITS_GE_256-NEXT:    mov w8, #7 // =0x7
; VBITS_GE_256-NEXT:    index z0.s, #0, #1
; VBITS_GE_256-NEXT:    ptrue p0.s
; VBITS_GE_256-NEXT:    mov z1.s, w8
; VBITS_GE_256-NEXT:    ptrue p1.s, vl8
; VBITS_GE_256-NEXT:    mov x8, #8 // =0x8
; VBITS_GE_256-NEXT:    cmpeq p0.s, p0/z, z0.s, z1.s
; VBITS_GE_256-NEXT:    fmov s0, #5.00000000
; VBITS_GE_256-NEXT:    ld1w { z1.s }, p1/z, [x0, x8, lsl #2]
; VBITS_GE_256-NEXT:    mov z1.s, p0/m, s0
; VBITS_GE_256-NEXT:    ld1w { z0.s }, p1/z, [x0]
; VBITS_GE_256-NEXT:    st1w { z1.s }, p1, [x1, x8, lsl #2]
; VBITS_GE_256-NEXT:    st1w { z0.s }, p1, [x1]
; VBITS_GE_256-NEXT:    ret
;
; VBITS_GE_512-LABEL: insertelement_v16f32:
; VBITS_GE_512:       // %bb.0:
; VBITS_GE_512-NEXT:    mov w8, #15 // =0xf
; VBITS_GE_512-NEXT:    index z0.s, #0, #1
; VBITS_GE_512-NEXT:    ptrue p0.s
; VBITS_GE_512-NEXT:    mov z1.s, w8
; VBITS_GE_512-NEXT:    ptrue p1.s, vl16
; VBITS_GE_512-NEXT:    cmpeq p0.s, p0/z, z0.s, z1.s
; VBITS_GE_512-NEXT:    ld1w { z0.s }, p1/z, [x0]
; VBITS_GE_512-NEXT:    fmov s1, #5.00000000
; VBITS_GE_512-NEXT:    mov z0.s, p0/m, s1
; VBITS_GE_512-NEXT:    st1w { z0.s }, p1, [x1]
; VBITS_GE_512-NEXT:    ret
  %op1 = load <16 x float>, ptr %a
  %r = insertelement <16 x float> %op1, float 5.0, i64 15
  store <16 x float> %r, ptr %b
  ret void
}

define void @insertelement_v32f32(ptr %a, ptr %b) vscale_range(8,0) #0 {
; CHECK-LABEL: insertelement_v32f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #31 // =0x1f
; CHECK-NEXT:    index z0.s, #0, #1
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    mov z1.s, w8
; CHECK-NEXT:    ptrue p1.s, vl32
; CHECK-NEXT:    cmpeq p0.s, p0/z, z0.s, z1.s
; CHECK-NEXT:    ld1w { z0.s }, p1/z, [x0]
; CHECK-NEXT:    fmov s1, #5.00000000
; CHECK-NEXT:    mov z0.s, p0/m, s1
; CHECK-NEXT:    st1w { z0.s }, p1, [x1]
; CHECK-NEXT:    ret
  %op1 = load <32 x float>, ptr %a
  %r = insertelement <32 x float> %op1, float 5.0, i64 31
  store <32 x float> %r, ptr %b
  ret void
}

define void @insertelement_v64f32(ptr %a, ptr %b) vscale_range(16,0) #0 {
; CHECK-LABEL: insertelement_v64f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #63 // =0x3f
; CHECK-NEXT:    index z0.s, #0, #1
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    mov z1.s, w8
; CHECK-NEXT:    ptrue p1.s, vl64
; CHECK-NEXT:    cmpeq p0.s, p0/z, z0.s, z1.s
; CHECK-NEXT:    ld1w { z0.s }, p1/z, [x0]
; CHECK-NEXT:    fmov s1, #5.00000000
; CHECK-NEXT:    mov z0.s, p0/m, s1
; CHECK-NEXT:    st1w { z0.s }, p1, [x1]
; CHECK-NEXT:    ret
  %op1 = load <64 x float>, ptr %a
  %r = insertelement <64 x float> %op1, float 5.0, i64 63
  store <64 x float> %r, ptr %b
  ret void
}

; Don't use SVE for 64-bit vectors.
define <1 x double> @insertelement_v1f64(<1 x double> %op1) vscale_range(2,0) #0 {
; CHECK-LABEL: insertelement_v1f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov x8, #4617315517961601024 // =0x4014000000000000
; CHECK-NEXT:    fmov d0, x8
; CHECK-NEXT:    ret
  %r = insertelement <1 x double> %op1, double 5.0, i64 0
  ret <1 x double> %r
}

; Don't use SVE for 128-bit vectors.
define <2 x double> @insertelement_v2f64(<2 x double> %op1) vscale_range(2,0) #0 {
; CHECK-LABEL: insertelement_v2f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmov d1, #5.00000000
; CHECK-NEXT:    mov v0.d[1], v1.d[0]
; CHECK-NEXT:    ret
  %r = insertelement <2 x double> %op1, double 5.0, i64 1
  ret <2 x double> %r
}

define void @insertelement_v4f64(ptr %a, ptr %b) vscale_range(2,0) #0 {
; CHECK-LABEL: insertelement_v4f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #3 // =0x3
; CHECK-NEXT:    index z0.d, #0, #1
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    mov z1.d, x8
; CHECK-NEXT:    ptrue p1.d, vl4
; CHECK-NEXT:    cmpeq p0.d, p0/z, z0.d, z1.d
; CHECK-NEXT:    ld1d { z0.d }, p1/z, [x0]
; CHECK-NEXT:    fmov d1, #5.00000000
; CHECK-NEXT:    mov z0.d, p0/m, d1
; CHECK-NEXT:    st1d { z0.d }, p1, [x1]
; CHECK-NEXT:    ret
  %op1 = load <4 x double>, ptr %a
  %r = insertelement <4 x double> %op1, double 5.0, i64 3
  store <4 x double> %r, ptr %b
  ret void
}

define void @insertelement_v8f64(ptr %a, ptr %b) #0 {
; VBITS_GE_256-LABEL: insertelement_v8f64:
; VBITS_GE_256:       // %bb.0:
; VBITS_GE_256-NEXT:    mov w8, #3 // =0x3
; VBITS_GE_256-NEXT:    index z0.d, #0, #1
; VBITS_GE_256-NEXT:    ptrue p0.d
; VBITS_GE_256-NEXT:    mov z1.d, x8
; VBITS_GE_256-NEXT:    ptrue p1.d, vl4
; VBITS_GE_256-NEXT:    mov x8, #4 // =0x4
; VBITS_GE_256-NEXT:    cmpeq p0.d, p0/z, z0.d, z1.d
; VBITS_GE_256-NEXT:    fmov d0, #5.00000000
; VBITS_GE_256-NEXT:    ld1d { z1.d }, p1/z, [x0, x8, lsl #3]
; VBITS_GE_256-NEXT:    mov z1.d, p0/m, d0
; VBITS_GE_256-NEXT:    ld1d { z0.d }, p1/z, [x0]
; VBITS_GE_256-NEXT:    st1d { z1.d }, p1, [x1, x8, lsl #3]
; VBITS_GE_256-NEXT:    st1d { z0.d }, p1, [x1]
; VBITS_GE_256-NEXT:    ret
;
; VBITS_GE_512-LABEL: insertelement_v8f64:
; VBITS_GE_512:       // %bb.0:
; VBITS_GE_512-NEXT:    mov w8, #7 // =0x7
; VBITS_GE_512-NEXT:    index z0.d, #0, #1
; VBITS_GE_512-NEXT:    ptrue p0.d
; VBITS_GE_512-NEXT:    mov z1.d, x8
; VBITS_GE_512-NEXT:    ptrue p1.d, vl8
; VBITS_GE_512-NEXT:    cmpeq p0.d, p0/z, z0.d, z1.d
; VBITS_GE_512-NEXT:    ld1d { z0.d }, p1/z, [x0]
; VBITS_GE_512-NEXT:    fmov d1, #5.00000000
; VBITS_GE_512-NEXT:    mov z0.d, p0/m, d1
; VBITS_GE_512-NEXT:    st1d { z0.d }, p1, [x1]
; VBITS_GE_512-NEXT:    ret
  %op1 = load <8 x double>, ptr %a
  %r = insertelement <8 x double> %op1, double 5.0, i64 7
  store <8 x double> %r, ptr %b
  ret void
}

define void @insertelement_v16f64(ptr %a, ptr %b) vscale_range(8,0) #0 {
; CHECK-LABEL: insertelement_v16f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #15 // =0xf
; CHECK-NEXT:    index z0.d, #0, #1
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    mov z1.d, x8
; CHECK-NEXT:    ptrue p1.d, vl16
; CHECK-NEXT:    cmpeq p0.d, p0/z, z0.d, z1.d
; CHECK-NEXT:    ld1d { z0.d }, p1/z, [x0]
; CHECK-NEXT:    fmov d1, #5.00000000
; CHECK-NEXT:    mov z0.d, p0/m, d1
; CHECK-NEXT:    st1d { z0.d }, p1, [x1]
; CHECK-NEXT:    ret
  %op1 = load <16 x double>, ptr %a
  %r = insertelement <16 x double> %op1, double 5.0, i64 15
  store <16 x double> %r, ptr %b
  ret void
}

define void @insertelement_v32f64(ptr %a, ptr %b) vscale_range(16,0) #0 {
; CHECK-LABEL: insertelement_v32f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #31 // =0x1f
; CHECK-NEXT:    index z0.d, #0, #1
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    mov z1.d, x8
; CHECK-NEXT:    ptrue p1.d, vl32
; CHECK-NEXT:    cmpeq p0.d, p0/z, z0.d, z1.d
; CHECK-NEXT:    ld1d { z0.d }, p1/z, [x0]
; CHECK-NEXT:    fmov d1, #5.00000000
; CHECK-NEXT:    mov z0.d, p0/m, d1
; CHECK-NEXT:    st1d { z0.d }, p1, [x1]
; CHECK-NEXT:    ret
  %op1 = load <32 x double>, ptr %a
  %r = insertelement <32 x double> %op1, double 5.0, i64 31
  store <32 x double> %r, ptr %b
  ret void
}

attributes #0 = { "target-features"="+sve" }
