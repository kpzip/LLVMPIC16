; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -verify-machineinstrs -mtriple=aarch64-none-linux-gnu -mattr=+neon | FileCheck %s --check-prefixes=CHECK,CHECK-NOFP16,CHECK-NOFP16-SD
; RUN: llc < %s -verify-machineinstrs -mtriple=aarch64-none-linux-gnu -mattr=+neon,+fullfp16 | FileCheck %s --check-prefixes=CHECK,CHECK-FP16,CHECK-FP16-SD
; RUN: llc -mtriple=aarch64-none-linux-gnu -mattr=+neon -global-isel %s -o - | FileCheck %s --check-prefixes=CHECK,CHECK-NOFP16,CHECK-NOFP16-GI
; RUN: llc -mtriple=aarch64-none-linux-gnu -mattr=+neon,+fullfp16 -global-isel %s -o - | FileCheck %s --check-prefixes=CHECK,CHECK-FP16,CHECK-FP16-GI

define <8 x i8> @movi8b_0() {
; CHECK-LABEL: movi8b_0:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v0.2d, #0000000000000000
; CHECK-NEXT:    ret
   ret <8 x i8> zeroinitializer
}

define <8 x i8> @movi8b() {
; CHECK-LABEL: movi8b:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v0.8b, #8
; CHECK-NEXT:    ret
   ret <8 x i8> <i8 8, i8 8, i8 8, i8 8, i8 8, i8 8, i8 8, i8 8>
}

define <16 x i8> @movi16b_0() {
; CHECK-LABEL: movi16b_0:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v0.2d, #0000000000000000
; CHECK-NEXT:    ret
   ret <16 x i8> zeroinitializer
}

define <16 x i8> @movi16b() {
; CHECK-LABEL: movi16b:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v0.16b, #8
; CHECK-NEXT:    ret
   ret <16 x i8> <i8 8, i8 8, i8 8, i8 8, i8 8, i8 8, i8 8, i8 8, i8 8, i8 8, i8 8, i8 8, i8 8, i8 8, i8 8, i8 8>
}

define <2 x i32> @movi2s_0() {
; CHECK-LABEL: movi2s_0:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v0.2d, #0000000000000000
; CHECK-NEXT:    ret
   ret <2 x i32> zeroinitializer
}

define <2 x i32> @movi2s_lsl0() {
; CHECK-LABEL: movi2s_lsl0:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi d0, #0x0000ff000000ff
; CHECK-NEXT:    ret
   ret <2 x i32> <i32 255, i32 255>
}

define <2 x i32> @movi2s_lsl8() {
; CHECK-LABEL: movi2s_lsl8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi d0, #0x00ff000000ff00
; CHECK-NEXT:    ret
   ret <2 x i32> <i32 65280, i32 65280>
}

define <2 x i32> @movi2s_lsl16() {
; CHECK-LABEL: movi2s_lsl16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi d0, #0xff000000ff0000
; CHECK-NEXT:    ret
   ret <2 x i32> <i32 16711680, i32 16711680>
}

define <2 x i32> @movi2s_lsl24() {
; CHECK-LABEL: movi2s_lsl24:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi d0, #0xff000000ff000000
; CHECK-NEXT:    ret
   ret <2 x i32> <i32 4278190080, i32 4278190080>
}

define <4 x i32> @movi4s_0() {
; CHECK-LABEL: movi4s_0:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v0.2d, #0000000000000000
; CHECK-NEXT:    ret
   ret <4 x i32> zeroinitializer
}

define <4 x i32> @movi4s_lsl0() {
; CHECK-LABEL: movi4s_lsl0:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v0.2d, #0x0000ff000000ff
; CHECK-NEXT:    ret
   ret <4 x i32> <i32 255, i32 255, i32 255, i32 255>
}

define <4 x i32> @movi4s_lsl8() {
; CHECK-LABEL: movi4s_lsl8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v0.2d, #0x00ff000000ff00
; CHECK-NEXT:    ret
   ret <4 x i32> <i32 65280, i32 65280, i32 65280, i32 65280>
}

define <4 x i32> @movi4s_lsl16() {
; CHECK-LABEL: movi4s_lsl16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v0.2d, #0xff000000ff0000
; CHECK-NEXT:    ret
   ret <4 x i32> <i32 16711680, i32 16711680, i32 16711680, i32 16711680>
}

define <4 x i32> @movi4s_fneg() {
; CHECK-NOFP16-SD-LABEL: movi4s_fneg:
; CHECK-NOFP16-SD:       // %bb.0:
; CHECK-NOFP16-SD-NEXT:    movi v0.4s, #240, lsl #8
; CHECK-NOFP16-SD-NEXT:    fneg v0.4s, v0.4s
; CHECK-NOFP16-SD-NEXT:    ret
;
; CHECK-FP16-SD-LABEL: movi4s_fneg:
; CHECK-FP16-SD:       // %bb.0:
; CHECK-FP16-SD-NEXT:    movi v0.4s, #240, lsl #8
; CHECK-FP16-SD-NEXT:    fneg v0.4s, v0.4s
; CHECK-FP16-SD-NEXT:    ret
;
; CHECK-NOFP16-GI-LABEL: movi4s_fneg:
; CHECK-NOFP16-GI:       // %bb.0:
; CHECK-NOFP16-GI-NEXT:    movi v0.4s, #240, lsl #8
; CHECK-NOFP16-GI-NEXT:    fneg v0.4s, v0.4s
; CHECK-NOFP16-GI-NEXT:    ret
;
; CHECK-FP16-GI-LABEL: movi4s_fneg:
; CHECK-FP16-GI:       // %bb.0:
; CHECK-FP16-GI-NEXT:    movi v0.4s, #240, lsl #8
; CHECK-FP16-GI-NEXT:    fneg v0.4s, v0.4s
; CHECK-FP16-GI-NEXT:    ret
   ret <4 x i32> <i32 2147545088, i32 2147545088, i32 2147545088, i32 2147545088>
}

define <4 x i32> @movi4s_lsl24() {
; CHECK-LABEL: movi4s_lsl24:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v0.2d, #0xff000000ff000000
; CHECK-NEXT:    ret
   ret <4 x i32> <i32 4278190080, i32 4278190080, i32 4278190080, i32 4278190080>
}

define <4 x i16> @movi4h_lsl0() {
; CHECK-LABEL: movi4h_lsl0:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi d0, #0xff00ff00ff00ff
; CHECK-NEXT:    ret
   ret <4 x i16> <i16 255, i16 255, i16 255, i16 255>
}

define <4 x i16> @movi4h_lsl8() {
; CHECK-LABEL: movi4h_lsl8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi d0, #0xff00ff00ff00ff00
; CHECK-NEXT:    ret
   ret <4 x i16> <i16 65280, i16 65280, i16 65280, i16 65280>
}

define <8 x i16> @movi8h_lsl0() {
; CHECK-LABEL: movi8h_lsl0:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v0.2d, #0xff00ff00ff00ff
; CHECK-NEXT:    ret
   ret <8 x i16> <i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255>
}

define <8 x i16> @movi8h_lsl8() {
; CHECK-LABEL: movi8h_lsl8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v0.2d, #0xff00ff00ff00ff00
; CHECK-NEXT:    ret
   ret <8 x i16> <i16 65280, i16 65280, i16 65280, i16 65280, i16 65280, i16 65280, i16 65280, i16 65280>
}

define <8 x i16> @movi8h_fneg() {
; CHECK-NOFP16-SD-LABEL: movi8h_fneg:
; CHECK-NOFP16-SD:       // %bb.0:
; CHECK-NOFP16-SD-NEXT:    movi v0.8h, #127, lsl #8
; CHECK-NOFP16-SD-NEXT:    fneg v0.4s, v0.4s
; CHECK-NOFP16-SD-NEXT:    ret
;
; CHECK-FP16-SD-LABEL: movi8h_fneg:
; CHECK-FP16-SD:       // %bb.0:
; CHECK-FP16-SD-NEXT:    movi v0.8h, #127, lsl #8
; CHECK-FP16-SD-NEXT:    fneg v0.4s, v0.4s
; CHECK-FP16-SD-NEXT:    ret
;
; CHECK-NOFP16-GI-LABEL: movi8h_fneg:
; CHECK-NOFP16-GI:       // %bb.0:
; CHECK-NOFP16-GI-NEXT:    adrp x8, .LCPI19_0
; CHECK-NOFP16-GI-NEXT:    ldr q0, [x8, :lo12:.LCPI19_0]
; CHECK-NOFP16-GI-NEXT:    ret
;
; CHECK-FP16-GI-LABEL: movi8h_fneg:
; CHECK-FP16-GI:       // %bb.0:
; CHECK-FP16-GI-NEXT:    adrp x8, .LCPI19_0
; CHECK-FP16-GI-NEXT:    ldr q0, [x8, :lo12:.LCPI19_0]
; CHECK-FP16-GI-NEXT:    ret
   ret <8 x i16> <i16 32512, i16 65280, i16 32512, i16 65280, i16 32512, i16 65280, i16 32512, i16 65280>
}


define <2 x i32> @mvni2s_lsl0() {
; CHECK-LABEL: mvni2s_lsl0:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mvni v0.2s, #16
; CHECK-NEXT:    ret
   ret <2 x i32> <i32 4294967279, i32 4294967279>
}

define <2 x i32> @mvni2s_lsl8() {
; CHECK-LABEL: mvni2s_lsl8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mvni v0.2s, #16, lsl #8
; CHECK-NEXT:    ret
   ret <2 x i32> <i32 4294963199, i32 4294963199>
}

define <2 x i32> @mvni2s_lsl16() {
; CHECK-LABEL: mvni2s_lsl16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mvni v0.2s, #16, lsl #16
; CHECK-NEXT:    ret
   ret <2 x i32> <i32 4293918719, i32 4293918719>
}

define <2 x i32> @mvni2s_lsl24() {
; CHECK-LABEL: mvni2s_lsl24:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mvni v0.2s, #16, lsl #24
; CHECK-NEXT:    ret
   ret <2 x i32> <i32 4026531839, i32 4026531839>
}

define <4 x i32> @mvni4s_lsl0() {
; CHECK-LABEL: mvni4s_lsl0:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mvni v0.4s, #16
; CHECK-NEXT:    ret
   ret <4 x i32> <i32 4294967279, i32 4294967279, i32 4294967279, i32 4294967279>
}

define <4 x i32> @mvni4s_lsl8() {
; CHECK-LABEL: mvni4s_lsl8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mvni v0.4s, #16, lsl #8
; CHECK-NEXT:    ret
   ret <4 x i32> <i32 4294963199, i32 4294963199, i32 4294963199, i32 4294963199>
}

define <4 x i32> @mvni4s_lsl16() {
; CHECK-LABEL: mvni4s_lsl16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mvni v0.4s, #16, lsl #16
; CHECK-NEXT:    ret
   ret <4 x i32> <i32 4293918719, i32 4293918719, i32 4293918719, i32 4293918719>

}

define <4 x i32> @mvni4s_lsl24() {
; CHECK-LABEL: mvni4s_lsl24:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mvni v0.4s, #16, lsl #24
; CHECK-NEXT:    ret
   ret <4 x i32> <i32 4026531839, i32 4026531839, i32 4026531839, i32 4026531839>
}


define <4 x i16> @mvni4h_lsl0() {
; CHECK-LABEL: mvni4h_lsl0:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mvni v0.4h, #16
; CHECK-NEXT:    ret
   ret <4 x i16> <i16 65519, i16 65519, i16 65519, i16 65519>
}

define <4 x i16> @mvni4h_lsl8() {
; CHECK-LABEL: mvni4h_lsl8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mvni v0.4h, #16, lsl #8
; CHECK-NEXT:    ret
   ret <4 x i16> <i16 61439, i16 61439, i16 61439, i16 61439>
}

define <8 x i16> @mvni8h_lsl0() {
; CHECK-LABEL: mvni8h_lsl0:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mvni v0.8h, #16
; CHECK-NEXT:    ret
   ret <8 x i16> <i16 65519, i16 65519, i16 65519, i16 65519, i16 65519, i16 65519, i16 65519, i16 65519>
}

define <8 x i16> @mvni8h_lsl8() {
; CHECK-LABEL: mvni8h_lsl8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mvni v0.8h, #16, lsl #8
; CHECK-NEXT:    ret
   ret <8 x i16> <i16 61439, i16 61439, i16 61439, i16 61439, i16 61439, i16 61439, i16 61439, i16 61439>
}

define <8 x i16> @mvni8h_neg() {
; CHECK-NOFP16-SD-LABEL: mvni8h_neg:
; CHECK-NOFP16-SD:       // %bb.0:
; CHECK-NOFP16-SD-NEXT:    mov w8, #33008 // =0x80f0
; CHECK-NOFP16-SD-NEXT:    dup v0.8h, w8
; CHECK-NOFP16-SD-NEXT:    ret
;
; CHECK-FP16-SD-LABEL: mvni8h_neg:
; CHECK-FP16-SD:       // %bb.0:
; CHECK-FP16-SD-NEXT:    movi v0.8h, #240
; CHECK-FP16-SD-NEXT:    fneg v0.8h, v0.8h
; CHECK-FP16-SD-NEXT:    ret
;
; CHECK-NOFP16-GI-LABEL: mvni8h_neg:
; CHECK-NOFP16-GI:       // %bb.0:
; CHECK-NOFP16-GI-NEXT:    adrp x8, .LCPI32_0
; CHECK-NOFP16-GI-NEXT:    ldr q0, [x8, :lo12:.LCPI32_0]
; CHECK-NOFP16-GI-NEXT:    ret
;
; CHECK-FP16-GI-LABEL: mvni8h_neg:
; CHECK-FP16-GI:       // %bb.0:
; CHECK-FP16-GI-NEXT:    movi v0.8h, #240
; CHECK-FP16-GI-NEXT:    fneg v0.8h, v0.8h
; CHECK-FP16-GI-NEXT:    ret
   ret <8 x i16> <i16 33008, i16 33008, i16 33008, i16 33008, i16 33008, i16 33008, i16 33008, i16 33008>
}


define <2 x i32> @movi2s_msl8(<2 x i32> %a) {
; CHECK-LABEL: movi2s_msl8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi d0, #0x00ffff0000ffff
; CHECK-NEXT:    ret
	ret <2 x i32> <i32 65535, i32 65535>
}

define <2 x i32> @movi2s_msl16() {
; CHECK-LABEL: movi2s_msl16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi d0, #0xffffff00ffffff
; CHECK-NEXT:    ret
   ret <2 x i32> <i32 16777215, i32 16777215>
}


define <4 x i32> @movi4s_msl8() {
; CHECK-LABEL: movi4s_msl8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v0.2d, #0x00ffff0000ffff
; CHECK-NEXT:    ret
   ret <4 x i32> <i32 65535, i32 65535, i32 65535, i32 65535>
}

define <4 x i32> @movi4s_msl16() {
; CHECK-LABEL: movi4s_msl16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v0.2d, #0xffffff00ffffff
; CHECK-NEXT:    ret
   ret <4 x i32> <i32 16777215, i32 16777215, i32 16777215, i32 16777215>
}

define <2 x i32> @mvni2s_msl8() {
; CHECK-LABEL: mvni2s_msl8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mvni v0.2s, #16, msl #8
; CHECK-NEXT:    ret
   ret <2 x i32> <i32 18446744073709547264, i32 18446744073709547264>
}

define <2 x i32> @mvni2s_msl16() {
; CHECK-LABEL: mvni2s_msl16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mvni v0.2s, #16, msl #16
; CHECK-NEXT:    ret
   ret <2 x i32> <i32 18446744073708437504, i32 18446744073708437504>
}

define <4 x i32> @mvni4s_msl8() {
; CHECK-LABEL: mvni4s_msl8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mvni v0.4s, #16, msl #8
; CHECK-NEXT:    ret
   ret <4 x i32> <i32 18446744073709547264, i32 18446744073709547264, i32 18446744073709547264, i32 18446744073709547264>
}

define <4 x i32> @mvni4s_msl16() {
; CHECK-LABEL: mvni4s_msl16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mvni v0.4s, #16, msl #16
; CHECK-NEXT:    ret
   ret <4 x i32> <i32 18446744073708437504, i32 18446744073708437504, i32 18446744073708437504, i32 18446744073708437504>
}

define <2 x i64> @movi2d() {
; CHECK-LABEL: movi2d:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v0.2d, #0xff0000ff0000ffff
; CHECK-NEXT:    ret
	ret <2 x i64> <i64 18374687574888349695, i64 18374687574888349695>
}

define <1 x i64> @movid() {
; CHECK-NOFP16-SD-LABEL: movid:
; CHECK-NOFP16-SD:       // %bb.0:
; CHECK-NOFP16-SD-NEXT:    movi d0, #0xff0000ff0000ffff
; CHECK-NOFP16-SD-NEXT:    ret
;
; CHECK-FP16-SD-LABEL: movid:
; CHECK-FP16-SD:       // %bb.0:
; CHECK-FP16-SD-NEXT:    movi d0, #0xff0000ff0000ffff
; CHECK-FP16-SD-NEXT:    ret
;
; CHECK-NOFP16-GI-LABEL: movid:
; CHECK-NOFP16-GI:       // %bb.0:
; CHECK-NOFP16-GI-NEXT:    mov x8, #-72056494526300161 // =0xff0000ffffffffff
; CHECK-NOFP16-GI-NEXT:    movk x8, #0, lsl #16
; CHECK-NOFP16-GI-NEXT:    fmov d0, x8
; CHECK-NOFP16-GI-NEXT:    ret
;
; CHECK-FP16-GI-LABEL: movid:
; CHECK-FP16-GI:       // %bb.0:
; CHECK-FP16-GI-NEXT:    mov x8, #-72056494526300161 // =0xff0000ffffffffff
; CHECK-FP16-GI-NEXT:    movk x8, #0, lsl #16
; CHECK-FP16-GI-NEXT:    fmov d0, x8
; CHECK-FP16-GI-NEXT:    ret
	ret  <1 x i64> <i64 18374687574888349695>
}

define <2 x float> @fmov2s_0() {
; CHECK-LABEL: fmov2s_0:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v0.2d, #0000000000000000
; CHECK-NEXT:    ret
	ret <2 x float> zeroinitializer
}

define <2 x float> @fmov2s() {
; CHECK-LABEL: fmov2s:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmov v0.2s, #-12.00000000
; CHECK-NEXT:    ret
	ret <2 x float> <float -1.2e1, float -1.2e1>
}

define <2 x float> @fmov2s_neg0() {
; CHECK-LABEL: fmov2s_neg0:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v0.2s, #128, lsl #24
; CHECK-NEXT:    ret
	ret <2 x float> <float -0.0, float -0.0>
}

define <4 x float> @fmov4s_0() {
; CHECK-LABEL: fmov4s_0:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v0.2d, #0000000000000000
; CHECK-NEXT:    ret
	ret <4 x float> zeroinitializer
}

define <4 x float> @fmov4s() {
; CHECK-LABEL: fmov4s:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmov v0.4s, #-12.00000000
; CHECK-NEXT:    ret
	ret <4 x float> <float -1.2e1, float -1.2e1, float -1.2e1, float -1.2e1>
}

define <4 x float> @fmov4s_neg0() {
; CHECK-LABEL: fmov4s_neg0:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v0.4s, #128, lsl #24
; CHECK-NEXT:    ret
	ret <4 x float> <float -0.0, float -0.0, float -0.0, float -0.0>
}

define <2 x double> @fmov2d_0() {
; CHECK-LABEL: fmov2d_0:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v0.2d, #0000000000000000
; CHECK-NEXT:    ret
	ret <2 x double> zeroinitializer
}

define <2 x double> @fmov2d() {
; CHECK-LABEL: fmov2d:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmov v0.2d, #-12.00000000
; CHECK-NEXT:    ret
	ret <2 x double> <double -1.2e1, double -1.2e1>
}

define <2 x double> @fmov2d_neg0() {
; CHECK-NOFP16-SD-LABEL: fmov2d_neg0:
; CHECK-NOFP16-SD:       // %bb.0:
; CHECK-NOFP16-SD-NEXT:    movi v0.2d, #0000000000000000
; CHECK-NOFP16-SD-NEXT:    fneg v0.2d, v0.2d
; CHECK-NOFP16-SD-NEXT:    ret
;
; CHECK-FP16-SD-LABEL: fmov2d_neg0:
; CHECK-FP16-SD:       // %bb.0:
; CHECK-FP16-SD-NEXT:    movi v0.2d, #0000000000000000
; CHECK-FP16-SD-NEXT:    fneg v0.2d, v0.2d
; CHECK-FP16-SD-NEXT:    ret
;
; CHECK-NOFP16-GI-LABEL: fmov2d_neg0:
; CHECK-NOFP16-GI:       // %bb.0:
; CHECK-NOFP16-GI-NEXT:    movi v0.2d, #0000000000000000
; CHECK-NOFP16-GI-NEXT:    fneg v0.2d, v0.2d
; CHECK-NOFP16-GI-NEXT:    ret
;
; CHECK-FP16-GI-LABEL: fmov2d_neg0:
; CHECK-FP16-GI:       // %bb.0:
; CHECK-FP16-GI-NEXT:    movi v0.2d, #0000000000000000
; CHECK-FP16-GI-NEXT:    fneg v0.2d, v0.2d
; CHECK-FP16-GI-NEXT:    ret
	ret <2 x double> <double -0.0, double -0.0>
}

define <2 x i32> @movi1d_1() {
; CHECK-NOFP16-SD-LABEL: movi1d_1:
; CHECK-NOFP16-SD:       // %bb.0:
; CHECK-NOFP16-SD-NEXT:    movi d0, #0x00ffffffff0000
; CHECK-NOFP16-SD-NEXT:    ret
;
; CHECK-FP16-SD-LABEL: movi1d_1:
; CHECK-FP16-SD:       // %bb.0:
; CHECK-FP16-SD-NEXT:    movi d0, #0x00ffffffff0000
; CHECK-FP16-SD-NEXT:    ret
;
; CHECK-NOFP16-GI-LABEL: movi1d_1:
; CHECK-NOFP16-GI:       // %bb.0:
; CHECK-NOFP16-GI-NEXT:    adrp x8, .LCPI52_0
; CHECK-NOFP16-GI-NEXT:    ldr d0, [x8, :lo12:.LCPI52_0]
; CHECK-NOFP16-GI-NEXT:    ret
;
; CHECK-FP16-GI-LABEL: movi1d_1:
; CHECK-FP16-GI:       // %bb.0:
; CHECK-FP16-GI-NEXT:    adrp x8, .LCPI52_0
; CHECK-FP16-GI-NEXT:    ldr d0, [x8, :lo12:.LCPI52_0]
; CHECK-FP16-GI-NEXT:    ret
  ret <2 x i32> <i32  -65536, i32 65535>
}


declare <2 x i32> @test_movi1d(<2 x i32>, <2 x i32>)
define <2 x i32> @movi1d() {
; CHECK-NOFP16-SD-LABEL: movi1d:
; CHECK-NOFP16-SD:       // %bb.0:
; CHECK-NOFP16-SD-NEXT:    movi d1, #0x00ffffffff0000
; CHECK-NOFP16-SD-NEXT:    adrp x8, .LCPI53_0
; CHECK-NOFP16-SD-NEXT:    ldr d0, [x8, :lo12:.LCPI53_0]
; CHECK-NOFP16-SD-NEXT:    b test_movi1d
;
; CHECK-FP16-SD-LABEL: movi1d:
; CHECK-FP16-SD:       // %bb.0:
; CHECK-FP16-SD-NEXT:    movi d1, #0x00ffffffff0000
; CHECK-FP16-SD-NEXT:    adrp x8, .LCPI53_0
; CHECK-FP16-SD-NEXT:    ldr d0, [x8, :lo12:.LCPI53_0]
; CHECK-FP16-SD-NEXT:    b test_movi1d
;
; CHECK-NOFP16-GI-LABEL: movi1d:
; CHECK-NOFP16-GI:       // %bb.0:
; CHECK-NOFP16-GI-NEXT:    adrp x8, .LCPI53_1
; CHECK-NOFP16-GI-NEXT:    adrp x9, .LCPI53_0
; CHECK-NOFP16-GI-NEXT:    ldr d0, [x8, :lo12:.LCPI53_1]
; CHECK-NOFP16-GI-NEXT:    ldr d1, [x9, :lo12:.LCPI53_0]
; CHECK-NOFP16-GI-NEXT:    b test_movi1d
;
; CHECK-FP16-GI-LABEL: movi1d:
; CHECK-FP16-GI:       // %bb.0:
; CHECK-FP16-GI-NEXT:    adrp x8, .LCPI53_1
; CHECK-FP16-GI-NEXT:    adrp x9, .LCPI53_0
; CHECK-FP16-GI-NEXT:    ldr d0, [x8, :lo12:.LCPI53_1]
; CHECK-FP16-GI-NEXT:    ldr d1, [x9, :lo12:.LCPI53_0]
; CHECK-FP16-GI-NEXT:    b test_movi1d
  %1 = tail call <2 x i32> @test_movi1d(<2 x i32> <i32 -2147483648, i32 2147450880>, <2 x i32> <i32 -65536, i32 65535>)
  ret <2 x i32> %1
}
;; NOTE: These prefixes are unused and the list is autogenerated. Do not add tests below this line:
; CHECK-FP16: {{.*}}
; CHECK-NOFP16: {{.*}}
