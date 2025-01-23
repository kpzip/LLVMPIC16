; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc -mtriple=aarch64 -verify-machineinstrs %s -o - | FileCheck %s --check-prefixes=CHECK,CHECK-SD,CHECK-SD-NOFP16
; RUN: llc -mtriple=aarch64 -mattr=+fullfp16 -verify-machineinstrs %s -o - | FileCheck %s --check-prefixes=CHECK,CHECK-SD,CHECK-SD-FP16
; RUN: llc -mtriple=aarch64 -global-isel -verify-machineinstrs %s -o - | FileCheck %s --check-prefixes=CHECK,CHECK-GI,CHECK-GI-NOFP16
; RUN: llc -mtriple=aarch64 -mattr=+fullfp16 -global-isel -verify-machineinstrs %s -o - | FileCheck %s --check-prefixes=CHECK,CHECK-GI,CHECK-GI-FP16

define double @fabs_f64(double %a) {
; CHECK-LABEL: fabs_f64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fabs d0, d0
; CHECK-NEXT:    ret
entry:
  %c = call double @llvm.fabs.f64(double %a)
  ret double %c
}

define float @fabs_f32(float %a) {
; CHECK-LABEL: fabs_f32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fabs s0, s0
; CHECK-NEXT:    ret
entry:
  %c = call float @llvm.fabs.f32(float %a)
  ret float %c
}

define half @fabs_f16(half %a) {
; CHECK-SD-NOFP16-LABEL: fabs_f16:
; CHECK-SD-NOFP16:       // %bb.0: // %entry
; CHECK-SD-NOFP16-NEXT:    // kill: def $h0 killed $h0 def $s0
; CHECK-SD-NOFP16-NEXT:    fmov w8, s0
; CHECK-SD-NOFP16-NEXT:    and w8, w8, #0x7fff
; CHECK-SD-NOFP16-NEXT:    fmov s0, w8
; CHECK-SD-NOFP16-NEXT:    // kill: def $h0 killed $h0 killed $s0
; CHECK-SD-NOFP16-NEXT:    ret
;
; CHECK-SD-FP16-LABEL: fabs_f16:
; CHECK-SD-FP16:       // %bb.0: // %entry
; CHECK-SD-FP16-NEXT:    fabs h0, h0
; CHECK-SD-FP16-NEXT:    ret
;
; CHECK-GI-NOFP16-LABEL: fabs_f16:
; CHECK-GI-NOFP16:       // %bb.0: // %entry
; CHECK-GI-NOFP16-NEXT:    fcvt s0, h0
; CHECK-GI-NOFP16-NEXT:    fabs s0, s0
; CHECK-GI-NOFP16-NEXT:    fcvt h0, s0
; CHECK-GI-NOFP16-NEXT:    ret
;
; CHECK-GI-FP16-LABEL: fabs_f16:
; CHECK-GI-FP16:       // %bb.0: // %entry
; CHECK-GI-FP16-NEXT:    fabs h0, h0
; CHECK-GI-FP16-NEXT:    ret
entry:
  %c = call half @llvm.fabs.f16(half %a)
  ret half %c
}

define <2 x double> @fabs_v2f64(<2 x double> %a) {
; CHECK-LABEL: fabs_v2f64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fabs v0.2d, v0.2d
; CHECK-NEXT:    ret
entry:
  %c = call <2 x double> @llvm.fabs.v2f64(<2 x double> %a)
  ret <2 x double> %c
}

define <3 x double> @fabs_v3f64(<3 x double> %a) {
; CHECK-SD-LABEL: fabs_v3f64:
; CHECK-SD:       // %bb.0: // %entry
; CHECK-SD-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-SD-NEXT:    // kill: def $d1 killed $d1 def $q1
; CHECK-SD-NEXT:    // kill: def $d2 killed $d2 def $q2
; CHECK-SD-NEXT:    mov v0.d[1], v1.d[0]
; CHECK-SD-NEXT:    fabs v2.2d, v2.2d
; CHECK-SD-NEXT:    // kill: def $d2 killed $d2 killed $q2
; CHECK-SD-NEXT:    fabs v0.2d, v0.2d
; CHECK-SD-NEXT:    ext v1.16b, v0.16b, v0.16b, #8
; CHECK-SD-NEXT:    // kill: def $d0 killed $d0 killed $q0
; CHECK-SD-NEXT:    // kill: def $d1 killed $d1 killed $q1
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: fabs_v3f64:
; CHECK-GI:       // %bb.0: // %entry
; CHECK-GI-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-GI-NEXT:    // kill: def $d1 killed $d1 def $q1
; CHECK-GI-NEXT:    fabs d2, d2
; CHECK-GI-NEXT:    mov v0.d[1], v1.d[0]
; CHECK-GI-NEXT:    fabs v0.2d, v0.2d
; CHECK-GI-NEXT:    mov d1, v0.d[1]
; CHECK-GI-NEXT:    // kill: def $d0 killed $d0 killed $q0
; CHECK-GI-NEXT:    ret
entry:
  %c = call <3 x double> @llvm.fabs.v3f64(<3 x double> %a)
  ret <3 x double> %c
}

define <4 x double> @fabs_v4f64(<4 x double> %a) {
; CHECK-LABEL: fabs_v4f64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fabs v0.2d, v0.2d
; CHECK-NEXT:    fabs v1.2d, v1.2d
; CHECK-NEXT:    ret
entry:
  %c = call <4 x double> @llvm.fabs.v4f64(<4 x double> %a)
  ret <4 x double> %c
}

define <2 x float> @fabs_v2f32(<2 x float> %a) {
; CHECK-LABEL: fabs_v2f32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fabs v0.2s, v0.2s
; CHECK-NEXT:    ret
entry:
  %c = call <2 x float> @llvm.fabs.v2f32(<2 x float> %a)
  ret <2 x float> %c
}

define <3 x float> @fabs_v3f32(<3 x float> %a) {
; CHECK-LABEL: fabs_v3f32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fabs v0.4s, v0.4s
; CHECK-NEXT:    ret
entry:
  %c = call <3 x float> @llvm.fabs.v3f32(<3 x float> %a)
  ret <3 x float> %c
}

define <4 x float> @fabs_v4f32(<4 x float> %a) {
; CHECK-LABEL: fabs_v4f32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fabs v0.4s, v0.4s
; CHECK-NEXT:    ret
entry:
  %c = call <4 x float> @llvm.fabs.v4f32(<4 x float> %a)
  ret <4 x float> %c
}

define <8 x float> @fabs_v8f32(<8 x float> %a) {
; CHECK-LABEL: fabs_v8f32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fabs v0.4s, v0.4s
; CHECK-NEXT:    fabs v1.4s, v1.4s
; CHECK-NEXT:    ret
entry:
  %c = call <8 x float> @llvm.fabs.v8f32(<8 x float> %a)
  ret <8 x float> %c
}

define <7 x half> @fabs_v7f16(<7 x half> %a) {
; CHECK-SD-NOFP16-LABEL: fabs_v7f16:
; CHECK-SD-NOFP16:       // %bb.0: // %entry
; CHECK-SD-NOFP16-NEXT:    bic v0.8h, #128, lsl #8
; CHECK-SD-NOFP16-NEXT:    ret
;
; CHECK-SD-FP16-LABEL: fabs_v7f16:
; CHECK-SD-FP16:       // %bb.0: // %entry
; CHECK-SD-FP16-NEXT:    fabs v0.8h, v0.8h
; CHECK-SD-FP16-NEXT:    ret
;
; CHECK-GI-NOFP16-LABEL: fabs_v7f16:
; CHECK-GI-NOFP16:       // %bb.0: // %entry
; CHECK-GI-NOFP16-NEXT:    fcvtl v1.4s, v0.4h
; CHECK-GI-NOFP16-NEXT:    mov h2, v0.h[4]
; CHECK-GI-NOFP16-NEXT:    mov h3, v0.h[5]
; CHECK-GI-NOFP16-NEXT:    mov h4, v0.h[6]
; CHECK-GI-NOFP16-NEXT:    fabs v1.4s, v1.4s
; CHECK-GI-NOFP16-NEXT:    mov v2.h[1], v3.h[0]
; CHECK-GI-NOFP16-NEXT:    fcvtn v0.4h, v1.4s
; CHECK-GI-NOFP16-NEXT:    mov v2.h[2], v4.h[0]
; CHECK-GI-NOFP16-NEXT:    mov h1, v0.h[1]
; CHECK-GI-NOFP16-NEXT:    fcvtl v2.4s, v2.4h
; CHECK-GI-NOFP16-NEXT:    mov h3, v0.h[2]
; CHECK-GI-NOFP16-NEXT:    mov h4, v0.h[3]
; CHECK-GI-NOFP16-NEXT:    mov v0.h[1], v1.h[0]
; CHECK-GI-NOFP16-NEXT:    fabs v1.4s, v2.4s
; CHECK-GI-NOFP16-NEXT:    mov v0.h[2], v3.h[0]
; CHECK-GI-NOFP16-NEXT:    fcvtn v1.4h, v1.4s
; CHECK-GI-NOFP16-NEXT:    mov v0.h[3], v4.h[0]
; CHECK-GI-NOFP16-NEXT:    mov h2, v1.h[1]
; CHECK-GI-NOFP16-NEXT:    mov v0.h[4], v1.h[0]
; CHECK-GI-NOFP16-NEXT:    mov h1, v1.h[2]
; CHECK-GI-NOFP16-NEXT:    mov v0.h[5], v2.h[0]
; CHECK-GI-NOFP16-NEXT:    mov v0.h[6], v1.h[0]
; CHECK-GI-NOFP16-NEXT:    ret
;
; CHECK-GI-FP16-LABEL: fabs_v7f16:
; CHECK-GI-FP16:       // %bb.0: // %entry
; CHECK-GI-FP16-NEXT:    fabs v0.8h, v0.8h
; CHECK-GI-FP16-NEXT:    ret
entry:
  %c = call <7 x half> @llvm.fabs.v7f16(<7 x half> %a)
  ret <7 x half> %c
}

define <4 x half> @fabs_v4f16(<4 x half> %a) {
; CHECK-SD-NOFP16-LABEL: fabs_v4f16:
; CHECK-SD-NOFP16:       // %bb.0: // %entry
; CHECK-SD-NOFP16-NEXT:    bic v0.4h, #128, lsl #8
; CHECK-SD-NOFP16-NEXT:    ret
;
; CHECK-SD-FP16-LABEL: fabs_v4f16:
; CHECK-SD-FP16:       // %bb.0: // %entry
; CHECK-SD-FP16-NEXT:    fabs v0.4h, v0.4h
; CHECK-SD-FP16-NEXT:    ret
;
; CHECK-GI-NOFP16-LABEL: fabs_v4f16:
; CHECK-GI-NOFP16:       // %bb.0: // %entry
; CHECK-GI-NOFP16-NEXT:    fcvtl v0.4s, v0.4h
; CHECK-GI-NOFP16-NEXT:    fabs v0.4s, v0.4s
; CHECK-GI-NOFP16-NEXT:    fcvtn v0.4h, v0.4s
; CHECK-GI-NOFP16-NEXT:    ret
;
; CHECK-GI-FP16-LABEL: fabs_v4f16:
; CHECK-GI-FP16:       // %bb.0: // %entry
; CHECK-GI-FP16-NEXT:    fabs v0.4h, v0.4h
; CHECK-GI-FP16-NEXT:    ret
entry:
  %c = call <4 x half> @llvm.fabs.v4f16(<4 x half> %a)
  ret <4 x half> %c
}

define <8 x half> @fabs_v8f16(<8 x half> %a) {
; CHECK-SD-NOFP16-LABEL: fabs_v8f16:
; CHECK-SD-NOFP16:       // %bb.0: // %entry
; CHECK-SD-NOFP16-NEXT:    bic v0.8h, #128, lsl #8
; CHECK-SD-NOFP16-NEXT:    ret
;
; CHECK-SD-FP16-LABEL: fabs_v8f16:
; CHECK-SD-FP16:       // %bb.0: // %entry
; CHECK-SD-FP16-NEXT:    fabs v0.8h, v0.8h
; CHECK-SD-FP16-NEXT:    ret
;
; CHECK-GI-NOFP16-LABEL: fabs_v8f16:
; CHECK-GI-NOFP16:       // %bb.0: // %entry
; CHECK-GI-NOFP16-NEXT:    fcvtl v1.4s, v0.4h
; CHECK-GI-NOFP16-NEXT:    fcvtl2 v0.4s, v0.8h
; CHECK-GI-NOFP16-NEXT:    fabs v1.4s, v1.4s
; CHECK-GI-NOFP16-NEXT:    fabs v2.4s, v0.4s
; CHECK-GI-NOFP16-NEXT:    fcvtn v0.4h, v1.4s
; CHECK-GI-NOFP16-NEXT:    fcvtn2 v0.8h, v2.4s
; CHECK-GI-NOFP16-NEXT:    ret
;
; CHECK-GI-FP16-LABEL: fabs_v8f16:
; CHECK-GI-FP16:       // %bb.0: // %entry
; CHECK-GI-FP16-NEXT:    fabs v0.8h, v0.8h
; CHECK-GI-FP16-NEXT:    ret
entry:
  %c = call <8 x half> @llvm.fabs.v8f16(<8 x half> %a)
  ret <8 x half> %c
}

define <16 x half> @fabs_v16f16(<16 x half> %a) {
; CHECK-SD-NOFP16-LABEL: fabs_v16f16:
; CHECK-SD-NOFP16:       // %bb.0: // %entry
; CHECK-SD-NOFP16-NEXT:    bic v0.8h, #128, lsl #8
; CHECK-SD-NOFP16-NEXT:    bic v1.8h, #128, lsl #8
; CHECK-SD-NOFP16-NEXT:    ret
;
; CHECK-SD-FP16-LABEL: fabs_v16f16:
; CHECK-SD-FP16:       // %bb.0: // %entry
; CHECK-SD-FP16-NEXT:    fabs v0.8h, v0.8h
; CHECK-SD-FP16-NEXT:    fabs v1.8h, v1.8h
; CHECK-SD-FP16-NEXT:    ret
;
; CHECK-GI-NOFP16-LABEL: fabs_v16f16:
; CHECK-GI-NOFP16:       // %bb.0: // %entry
; CHECK-GI-NOFP16-NEXT:    fcvtl v2.4s, v0.4h
; CHECK-GI-NOFP16-NEXT:    fcvtl v3.4s, v1.4h
; CHECK-GI-NOFP16-NEXT:    fcvtl2 v0.4s, v0.8h
; CHECK-GI-NOFP16-NEXT:    fcvtl2 v1.4s, v1.8h
; CHECK-GI-NOFP16-NEXT:    fabs v2.4s, v2.4s
; CHECK-GI-NOFP16-NEXT:    fabs v3.4s, v3.4s
; CHECK-GI-NOFP16-NEXT:    fabs v4.4s, v0.4s
; CHECK-GI-NOFP16-NEXT:    fabs v5.4s, v1.4s
; CHECK-GI-NOFP16-NEXT:    fcvtn v0.4h, v2.4s
; CHECK-GI-NOFP16-NEXT:    fcvtn v1.4h, v3.4s
; CHECK-GI-NOFP16-NEXT:    fcvtn2 v0.8h, v4.4s
; CHECK-GI-NOFP16-NEXT:    fcvtn2 v1.8h, v5.4s
; CHECK-GI-NOFP16-NEXT:    ret
;
; CHECK-GI-FP16-LABEL: fabs_v16f16:
; CHECK-GI-FP16:       // %bb.0: // %entry
; CHECK-GI-FP16-NEXT:    fabs v0.8h, v0.8h
; CHECK-GI-FP16-NEXT:    fabs v1.8h, v1.8h
; CHECK-GI-FP16-NEXT:    ret
entry:
  %c = call <16 x half> @llvm.fabs.v16f16(<16 x half> %a)
  ret <16 x half> %c
}

declare <16 x half> @llvm.fabs.v16f16(<16 x half>)
declare <2 x double> @llvm.fabs.v2f64(<2 x double>)
declare <2 x float> @llvm.fabs.v2f32(<2 x float>)
declare <3 x double> @llvm.fabs.v3f64(<3 x double>)
declare <3 x float> @llvm.fabs.v3f32(<3 x float>)
declare <4 x double> @llvm.fabs.v4f64(<4 x double>)
declare <4 x float> @llvm.fabs.v4f32(<4 x float>)
declare <4 x half> @llvm.fabs.v4f16(<4 x half>)
declare <7 x half> @llvm.fabs.v7f16(<7 x half>)
declare <8 x float> @llvm.fabs.v8f32(<8 x float>)
declare <8 x half> @llvm.fabs.v8f16(<8 x half>)
declare double @llvm.fabs.f64(double)
declare float @llvm.fabs.f32(float)
declare half @llvm.fabs.f16(half)
