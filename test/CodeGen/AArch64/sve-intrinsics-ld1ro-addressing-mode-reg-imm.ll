; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve,+f64mm < %s | FileCheck %s

;
; LD1ROB
;

define <vscale x 16 x i8> @ld1rob_i8(<vscale x 16 x i1> %pg, ptr %a) {
; CHECK-LABEL: ld1rob_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ld1rob { z0.b }, p0/z, [x0, #32]
; CHECK-NEXT:    ret
  %base = getelementptr i8, ptr %a, i64 32
  %load = call <vscale x 16 x i8> @llvm.aarch64.sve.ld1ro.nxv16i8(<vscale x 16 x i1> %pg, ptr %base)
  ret <vscale x 16 x i8> %load
}

;
; LD1ROH
;

define <vscale x 8 x i16> @ld1roh_i16(<vscale x 8 x i1> %pg, ptr %a) {
; CHECK-LABEL: ld1roh_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ld1roh { z0.h }, p0/z, [x0, #64]
; CHECK-NEXT:    ret
  %base = getelementptr i16, ptr %a, i64 32
  %load = call <vscale x 8 x i16> @llvm.aarch64.sve.ld1ro.nxv8i16(<vscale x 8 x i1> %pg, ptr %base)
  ret <vscale x 8 x i16> %load
}

define <vscale x 8 x half> @ld1roh_f16(<vscale x 8 x i1> %pg, ptr %a) {
; CHECK-LABEL: ld1roh_f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ld1roh { z0.h }, p0/z, [x0, #64]
; CHECK-NEXT:    ret
  %base = getelementptr half, ptr %a, i64 32
  %load = call <vscale x 8 x half> @llvm.aarch64.sve.ld1ro.nxv8f16(<vscale x 8 x i1> %pg, ptr %base)
  ret <vscale x 8 x half> %load
}

define <vscale x 8 x bfloat> @ld1roh_bf16(<vscale x 8 x i1> %pg, ptr %a) #0 {
; CHECK-LABEL: ld1roh_bf16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ld1roh { z0.h }, p0/z, [x0, #64]
; CHECK-NEXT:    ret
  %base = getelementptr bfloat, ptr %a, i64 32
  %load = call <vscale x 8 x bfloat> @llvm.aarch64.sve.ld1ro.nxv8bf16(<vscale x 8 x i1> %pg, ptr %base)
  ret <vscale x 8 x bfloat> %load
}

;
; LD1ROW
;

define <vscale x 4 x i32> @ld1row_i32(<vscale x 4 x i1> %pg, ptr %a) {
; CHECK-LABEL: ld1row_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ld1row { z0.s }, p0/z, [x0, #128]
; CHECK-NEXT:    ret
  %base = getelementptr i32, ptr %a, i64 32
  %load = call <vscale x 4 x i32> @llvm.aarch64.sve.ld1ro.nxv4i32(<vscale x 4 x i1> %pg, ptr %base)
  ret <vscale x 4 x i32> %load
}

define <vscale x 4 x float> @ld1row_f32(<vscale x 4 x i1> %pg, ptr %a) {
; CHECK-LABEL: ld1row_f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ld1row { z0.s }, p0/z, [x0, #128]
; CHECK-NEXT:    ret
  %base = getelementptr float, ptr %a, i64 32
  %load = call <vscale x 4 x float> @llvm.aarch64.sve.ld1ro.nxv4f32(<vscale x 4 x i1> %pg, ptr %base)
  ret <vscale x 4 x float> %load
}

;
; LD1ROD
;

define <vscale x 2 x i64> @ld1rod_i64(<vscale x 2 x i1> %pg, ptr %a) {
; CHECK-LABEL: ld1rod_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ld1rod { z0.d }, p0/z, [x0, #-64]
; CHECK-NEXT:    ret
  %base = getelementptr i64, ptr %a, i64 -8
  %load = call <vscale x 2 x i64> @llvm.aarch64.sve.ld1ro.nxv2i64(<vscale x 2 x i1> %pg, ptr %base)
  ret <vscale x 2 x i64> %load
}

define <vscale x 2 x double> @ld1rod_f64(<vscale x 2 x i1> %pg, ptr %a) {
; CHECK-LABEL: ld1rod_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ld1rod { z0.d }, p0/z, [x0, #-128]
; CHECK-NEXT:    ret
  %base = getelementptr double, ptr %a, i64 -16
  %load = call <vscale x 2 x double> @llvm.aarch64.sve.ld1ro.nxv2f64(<vscale x 2 x i1> %pg, ptr %base)
  ret <vscale x 2 x double> %load
}


;;;;;;;;;;;;;;
; range checks: immediate must be a multiple of 32 in the range -256, ..., 224

; lower bound
define <vscale x 16 x i8> @ld1rob_i8_lower_bound(<vscale x 16 x i1> %pg, ptr %a) {
; CHECK-LABEL: ld1rob_i8_lower_bound:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ld1rob { z0.b }, p0/z, [x0, #-256]
; CHECK-NEXT:    ret
  %base = getelementptr i8, ptr %a, i64 -256
  %load = call <vscale x 16 x i8> @llvm.aarch64.sve.ld1ro.nxv16i8(<vscale x 16 x i1> %pg, ptr %base)
  ret <vscale x 16 x i8> %load
}

; below lower bound
define <vscale x 8 x i16> @ld1roh_i16_below_lower_bound(<vscale x 8 x i1> %pg, ptr %a) {
; CHECK-LABEL: ld1roh_i16_below_lower_bound:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov x8, #-129
; CHECK-NEXT:    ld1roh { z0.h }, p0/z, [x0, x8, lsl #1]
; CHECK-NEXT:    ret
  %base = getelementptr i16, ptr %a, i64 -129
  %load = call <vscale x 8 x i16> @llvm.aarch64.sve.ld1ro.nxv8i16(<vscale x 8 x i1> %pg, ptr %base)
  ret <vscale x 8 x i16> %load
}

define <vscale x 16 x i8> @ld1rob_i8_below_lower_bound_01(<vscale x 16 x i1> %pg, ptr %a) {
; CHECK-LABEL: ld1rob_i8_below_lower_bound_01:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov x8, #-257
; CHECK-NEXT:    ld1rob { z0.b }, p0/z, [x0, x8]
; CHECK-NEXT:    ret
  %base = getelementptr i8, ptr %a, i64 -257
  %load = call <vscale x 16 x i8> @llvm.aarch64.sve.ld1ro.nxv16i8(<vscale x 16 x i1> %pg, ptr %base)
  ret <vscale x 16 x i8> %load
}

; not a multiple of 32
define <vscale x 4 x i32> @ld1row_i32_not_multiple(<vscale x 4 x i1> %pg, ptr %a) {
; CHECK-LABEL: ld1row_i32_not_multiple:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov x8, #3
; CHECK-NEXT:    ld1row { z0.s }, p0/z, [x0, x8, lsl #2]
; CHECK-NEXT:    ret
  %base = getelementptr i32, ptr %a, i64 3
  %load = call <vscale x 4 x i32> @llvm.aarch64.sve.ld1ro.nxv4i32(<vscale x 4 x i1> %pg, ptr %base)
  ret <vscale x 4 x i32> %load
}

; upper bound
define <vscale x 2 x i64> @ld1rod_i64_upper_bound(<vscale x 2 x i1> %pg, ptr %a) {
; CHECK-LABEL: ld1rod_i64_upper_bound:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ld1rod { z0.d }, p0/z, [x0, #224]
; CHECK-NEXT:    ret
  %base = getelementptr i64, ptr %a, i64 28
  %load = call <vscale x 2 x i64> @llvm.aarch64.sve.ld1ro.nxv2i64(<vscale x 2 x i1> %pg, ptr %base)
  ret <vscale x 2 x i64> %load
}

define <vscale x 16 x i8> @ld1rob_i8_beyond_upper_bound(<vscale x 16 x i1> %pg, ptr %a) {
; CHECK-LABEL: ld1rob_i8_beyond_upper_bound:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #225
; CHECK-NEXT:    ld1rob { z0.b }, p0/z, [x0, x8]
; CHECK-NEXT:    ret
  %base = getelementptr i8, ptr %a, i64 225
  %load = call <vscale x 16 x i8> @llvm.aarch64.sve.ld1ro.nxv16i8(<vscale x 16 x i1> %pg, ptr %base)
  ret <vscale x 16 x i8> %load
}

declare <vscale x 16 x i8> @llvm.aarch64.sve.ld1ro.nxv16i8(<vscale x 16 x i1>, ptr)

declare <vscale x 8 x i16> @llvm.aarch64.sve.ld1ro.nxv8i16(<vscale x 8 x i1>, ptr)
declare <vscale x 8 x half> @llvm.aarch64.sve.ld1ro.nxv8f16(<vscale x 8 x i1>, ptr)
declare <vscale x 8 x bfloat> @llvm.aarch64.sve.ld1ro.nxv8bf16(<vscale x 8 x i1>, ptr)

declare <vscale x 4 x i32> @llvm.aarch64.sve.ld1ro.nxv4i32(<vscale x 4 x i1>, ptr)
declare <vscale x 4 x float> @llvm.aarch64.sve.ld1ro.nxv4f32(<vscale x 4 x i1>, ptr)

declare <vscale x 2 x i64> @llvm.aarch64.sve.ld1ro.nxv2i64(<vscale x 2 x i1>, ptr)
declare <vscale x 2 x double> @llvm.aarch64.sve.ld1ro.nxv2f64(<vscale x 2 x i1>, ptr)


; +bf16 is required for the bfloat version.
attributes #0 = { "target-features"="+sve,+f64mm,+bf16" }
