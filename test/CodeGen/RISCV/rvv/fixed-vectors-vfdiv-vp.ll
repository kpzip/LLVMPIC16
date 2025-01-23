; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+d,+zfh,+zvfh,+v -target-abi=ilp32d \
; RUN:   -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,ZVFH
; RUN: llc -mtriple=riscv64 -mattr=+d,+zfh,+zvfh,+v -target-abi=lp64d \
; RUN:   -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,ZVFH
; RUN: llc -mtriple=riscv32 -mattr=+d,+zfh,+zvfhmin,+v -target-abi=ilp32d \
; RUN:   -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,ZVFHMIN
; RUN: llc -mtriple=riscv64 -mattr=+d,+zfh,+zvfhmin,+v -target-abi=lp64d \
; RUN:   -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,ZVFHMIN

declare <2 x half> @llvm.vp.fdiv.v2f16(<2 x half>, <2 x half>, <2 x i1>, i32)

define <2 x half> @vfdiv_vv_v2f16(<2 x half> %va, <2 x half> %b, <2 x i1> %m, i32 zeroext %evl) {
; ZVFH-LABEL: vfdiv_vv_v2f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, mf4, ta, ma
; ZVFH-NEXT:    vfdiv.vv v8, v8, v9, v0.t
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfdiv_vv_v2f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v10, v9
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v9, v8
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, mf2, ta, ma
; ZVFHMIN-NEXT:    vfdiv.vv v9, v9, v10, v0.t
; ZVFHMIN-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v9
; ZVFHMIN-NEXT:    ret
  %v = call <2 x half> @llvm.vp.fdiv.v2f16(<2 x half> %va, <2 x half> %b, <2 x i1> %m, i32 %evl)
  ret <2 x half> %v
}

define <2 x half> @vfdiv_vv_v2f16_unmasked(<2 x half> %va, <2 x half> %b, i32 zeroext %evl) {
; ZVFH-LABEL: vfdiv_vv_v2f16_unmasked:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, mf4, ta, ma
; ZVFH-NEXT:    vfdiv.vv v8, v8, v9
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfdiv_vv_v2f16_unmasked:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v10, v9
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v9, v8
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, mf2, ta, ma
; ZVFHMIN-NEXT:    vfdiv.vv v9, v9, v10
; ZVFHMIN-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v9
; ZVFHMIN-NEXT:    ret
  %v = call <2 x half> @llvm.vp.fdiv.v2f16(<2 x half> %va, <2 x half> %b, <2 x i1> splat (i1 true), i32 %evl)
  ret <2 x half> %v
}

define <2 x half> @vfdiv_vf_v2f16(<2 x half> %va, half %b, <2 x i1> %m, i32 zeroext %evl) {
; ZVFH-LABEL: vfdiv_vf_v2f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, mf4, ta, ma
; ZVFH-NEXT:    vfdiv.vf v8, v8, fa0, v0.t
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfdiv_vf_v2f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    fcvt.s.h fa5, fa0
; ZVFHMIN-NEXT:    vsetvli a1, zero, e32, mf2, ta, ma
; ZVFHMIN-NEXT:    vfmv.v.f v9, fa5
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, mf4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v10, v9
; ZVFHMIN-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v9, v8
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v8, v10
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, mf2, ta, ma
; ZVFHMIN-NEXT:    vfdiv.vv v9, v9, v8, v0.t
; ZVFHMIN-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v9
; ZVFHMIN-NEXT:    ret
  %elt.head = insertelement <2 x half> poison, half %b, i32 0
  %vb = shufflevector <2 x half> %elt.head, <2 x half> poison, <2 x i32> zeroinitializer
  %v = call <2 x half> @llvm.vp.fdiv.v2f16(<2 x half> %va, <2 x half> %vb, <2 x i1> %m, i32 %evl)
  ret <2 x half> %v
}

define <2 x half> @vfdiv_vf_v2f16_unmasked(<2 x half> %va, half %b, i32 zeroext %evl) {
; ZVFH-LABEL: vfdiv_vf_v2f16_unmasked:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, mf4, ta, ma
; ZVFH-NEXT:    vfdiv.vf v8, v8, fa0
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfdiv_vf_v2f16_unmasked:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    fcvt.s.h fa5, fa0
; ZVFHMIN-NEXT:    vsetvli a1, zero, e32, mf2, ta, ma
; ZVFHMIN-NEXT:    vfmv.v.f v9, fa5
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, mf4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v10, v9
; ZVFHMIN-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v9, v8
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v8, v10
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, mf2, ta, ma
; ZVFHMIN-NEXT:    vfdiv.vv v9, v9, v8
; ZVFHMIN-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v9
; ZVFHMIN-NEXT:    ret
  %elt.head = insertelement <2 x half> poison, half %b, i32 0
  %vb = shufflevector <2 x half> %elt.head, <2 x half> poison, <2 x i32> zeroinitializer
  %v = call <2 x half> @llvm.vp.fdiv.v2f16(<2 x half> %va, <2 x half> %vb, <2 x i1> splat (i1 true), i32 %evl)
  ret <2 x half> %v
}

declare <3 x half> @llvm.vp.fdiv.v3f16(<3 x half>, <3 x half>, <3 x i1>, i32)

define <3 x half> @vfdiv_vv_v3f16(<3 x half> %va, <3 x half> %b, <3 x i1> %m, i32 zeroext %evl) {
; ZVFH-LABEL: vfdiv_vv_v3f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; ZVFH-NEXT:    vfdiv.vv v8, v8, v9, v0.t
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfdiv_vv_v3f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v10, v9
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v9, v8
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; ZVFHMIN-NEXT:    vfdiv.vv v9, v9, v10, v0.t
; ZVFHMIN-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v9
; ZVFHMIN-NEXT:    ret
  %v = call <3 x half> @llvm.vp.fdiv.v3f16(<3 x half> %va, <3 x half> %b, <3 x i1> %m, i32 %evl)
  ret <3 x half> %v
}

declare <4 x half> @llvm.vp.fdiv.v4f16(<4 x half>, <4 x half>, <4 x i1>, i32)

define <4 x half> @vfdiv_vv_v4f16(<4 x half> %va, <4 x half> %b, <4 x i1> %m, i32 zeroext %evl) {
; ZVFH-LABEL: vfdiv_vv_v4f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; ZVFH-NEXT:    vfdiv.vv v8, v8, v9, v0.t
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfdiv_vv_v4f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v10, v9
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v9, v8
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; ZVFHMIN-NEXT:    vfdiv.vv v9, v9, v10, v0.t
; ZVFHMIN-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v9
; ZVFHMIN-NEXT:    ret
  %v = call <4 x half> @llvm.vp.fdiv.v4f16(<4 x half> %va, <4 x half> %b, <4 x i1> %m, i32 %evl)
  ret <4 x half> %v
}

define <4 x half> @vfdiv_vv_v4f16_unmasked(<4 x half> %va, <4 x half> %b, i32 zeroext %evl) {
; ZVFH-LABEL: vfdiv_vv_v4f16_unmasked:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; ZVFH-NEXT:    vfdiv.vv v8, v8, v9
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfdiv_vv_v4f16_unmasked:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v10, v9
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v9, v8
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; ZVFHMIN-NEXT:    vfdiv.vv v9, v9, v10
; ZVFHMIN-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v9
; ZVFHMIN-NEXT:    ret
  %v = call <4 x half> @llvm.vp.fdiv.v4f16(<4 x half> %va, <4 x half> %b, <4 x i1> splat (i1 true), i32 %evl)
  ret <4 x half> %v
}

define <4 x half> @vfdiv_vf_v4f16(<4 x half> %va, half %b, <4 x i1> %m, i32 zeroext %evl) {
; ZVFH-LABEL: vfdiv_vf_v4f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; ZVFH-NEXT:    vfdiv.vf v8, v8, fa0, v0.t
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfdiv_vf_v4f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    fcvt.s.h fa5, fa0
; ZVFHMIN-NEXT:    vsetvli a1, zero, e32, m1, ta, ma
; ZVFHMIN-NEXT:    vfmv.v.f v9, fa5
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v10, v9
; ZVFHMIN-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v9, v8
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v8, v10
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; ZVFHMIN-NEXT:    vfdiv.vv v9, v9, v8, v0.t
; ZVFHMIN-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v9
; ZVFHMIN-NEXT:    ret
  %elt.head = insertelement <4 x half> poison, half %b, i32 0
  %vb = shufflevector <4 x half> %elt.head, <4 x half> poison, <4 x i32> zeroinitializer
  %v = call <4 x half> @llvm.vp.fdiv.v4f16(<4 x half> %va, <4 x half> %vb, <4 x i1> %m, i32 %evl)
  ret <4 x half> %v
}

define <4 x half> @vfdiv_vf_v4f16_unmasked(<4 x half> %va, half %b, i32 zeroext %evl) {
; ZVFH-LABEL: vfdiv_vf_v4f16_unmasked:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; ZVFH-NEXT:    vfdiv.vf v8, v8, fa0
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfdiv_vf_v4f16_unmasked:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    fcvt.s.h fa5, fa0
; ZVFHMIN-NEXT:    vsetvli a1, zero, e32, m1, ta, ma
; ZVFHMIN-NEXT:    vfmv.v.f v9, fa5
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v10, v9
; ZVFHMIN-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v9, v8
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v8, v10
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; ZVFHMIN-NEXT:    vfdiv.vv v9, v9, v8
; ZVFHMIN-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v9
; ZVFHMIN-NEXT:    ret
  %elt.head = insertelement <4 x half> poison, half %b, i32 0
  %vb = shufflevector <4 x half> %elt.head, <4 x half> poison, <4 x i32> zeroinitializer
  %v = call <4 x half> @llvm.vp.fdiv.v4f16(<4 x half> %va, <4 x half> %vb, <4 x i1> splat (i1 true), i32 %evl)
  ret <4 x half> %v
}

declare <8 x half> @llvm.vp.fdiv.v8f16(<8 x half>, <8 x half>, <8 x i1>, i32)

define <8 x half> @vfdiv_vv_v8f16(<8 x half> %va, <8 x half> %b, <8 x i1> %m, i32 zeroext %evl) {
; ZVFH-LABEL: vfdiv_vv_v8f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, m1, ta, ma
; ZVFH-NEXT:    vfdiv.vv v8, v8, v9, v0.t
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfdiv_vv_v8f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v10, v9
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v12, v8
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m2, ta, ma
; ZVFHMIN-NEXT:    vfdiv.vv v10, v12, v10, v0.t
; ZVFHMIN-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v10
; ZVFHMIN-NEXT:    ret
  %v = call <8 x half> @llvm.vp.fdiv.v8f16(<8 x half> %va, <8 x half> %b, <8 x i1> %m, i32 %evl)
  ret <8 x half> %v
}

define <8 x half> @vfdiv_vv_v8f16_unmasked(<8 x half> %va, <8 x half> %b, i32 zeroext %evl) {
; ZVFH-LABEL: vfdiv_vv_v8f16_unmasked:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, m1, ta, ma
; ZVFH-NEXT:    vfdiv.vv v8, v8, v9
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfdiv_vv_v8f16_unmasked:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v10, v9
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v12, v8
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m2, ta, ma
; ZVFHMIN-NEXT:    vfdiv.vv v10, v12, v10
; ZVFHMIN-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v10
; ZVFHMIN-NEXT:    ret
  %v = call <8 x half> @llvm.vp.fdiv.v8f16(<8 x half> %va, <8 x half> %b, <8 x i1> splat (i1 true), i32 %evl)
  ret <8 x half> %v
}

define <8 x half> @vfdiv_vf_v8f16(<8 x half> %va, half %b, <8 x i1> %m, i32 zeroext %evl) {
; ZVFH-LABEL: vfdiv_vf_v8f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, m1, ta, ma
; ZVFH-NEXT:    vfdiv.vf v8, v8, fa0, v0.t
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfdiv_vf_v8f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    fcvt.s.h fa5, fa0
; ZVFHMIN-NEXT:    vsetvli a1, zero, e32, m2, ta, ma
; ZVFHMIN-NEXT:    vfmv.v.f v10, fa5
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m1, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v9, v10
; ZVFHMIN-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v10, v8
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v12, v9
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m2, ta, ma
; ZVFHMIN-NEXT:    vfdiv.vv v10, v10, v12, v0.t
; ZVFHMIN-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v10
; ZVFHMIN-NEXT:    ret
  %elt.head = insertelement <8 x half> poison, half %b, i32 0
  %vb = shufflevector <8 x half> %elt.head, <8 x half> poison, <8 x i32> zeroinitializer
  %v = call <8 x half> @llvm.vp.fdiv.v8f16(<8 x half> %va, <8 x half> %vb, <8 x i1> %m, i32 %evl)
  ret <8 x half> %v
}

define <8 x half> @vfdiv_vf_v8f16_unmasked(<8 x half> %va, half %b, i32 zeroext %evl) {
; ZVFH-LABEL: vfdiv_vf_v8f16_unmasked:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, m1, ta, ma
; ZVFH-NEXT:    vfdiv.vf v8, v8, fa0
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfdiv_vf_v8f16_unmasked:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    fcvt.s.h fa5, fa0
; ZVFHMIN-NEXT:    vsetvli a1, zero, e32, m2, ta, ma
; ZVFHMIN-NEXT:    vfmv.v.f v10, fa5
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m1, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v9, v10
; ZVFHMIN-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v10, v8
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v12, v9
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m2, ta, ma
; ZVFHMIN-NEXT:    vfdiv.vv v10, v10, v12
; ZVFHMIN-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v10
; ZVFHMIN-NEXT:    ret
  %elt.head = insertelement <8 x half> poison, half %b, i32 0
  %vb = shufflevector <8 x half> %elt.head, <8 x half> poison, <8 x i32> zeroinitializer
  %v = call <8 x half> @llvm.vp.fdiv.v8f16(<8 x half> %va, <8 x half> %vb, <8 x i1> splat (i1 true), i32 %evl)
  ret <8 x half> %v
}

declare <16 x half> @llvm.vp.fdiv.v16f16(<16 x half>, <16 x half>, <16 x i1>, i32)

define <16 x half> @vfdiv_vv_v16f16(<16 x half> %va, <16 x half> %b, <16 x i1> %m, i32 zeroext %evl) {
; ZVFH-LABEL: vfdiv_vv_v16f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, m2, ta, ma
; ZVFH-NEXT:    vfdiv.vv v8, v8, v10, v0.t
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfdiv_vv_v16f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 16, e16, m2, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v12, v10
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v16, v8
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m4, ta, ma
; ZVFHMIN-NEXT:    vfdiv.vv v12, v16, v12, v0.t
; ZVFHMIN-NEXT:    vsetivli zero, 16, e16, m2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v12
; ZVFHMIN-NEXT:    ret
  %v = call <16 x half> @llvm.vp.fdiv.v16f16(<16 x half> %va, <16 x half> %b, <16 x i1> %m, i32 %evl)
  ret <16 x half> %v
}

define <16 x half> @vfdiv_vv_v16f16_unmasked(<16 x half> %va, <16 x half> %b, i32 zeroext %evl) {
; ZVFH-LABEL: vfdiv_vv_v16f16_unmasked:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, m2, ta, ma
; ZVFH-NEXT:    vfdiv.vv v8, v8, v10
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfdiv_vv_v16f16_unmasked:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 16, e16, m2, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v12, v10
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v16, v8
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m4, ta, ma
; ZVFHMIN-NEXT:    vfdiv.vv v12, v16, v12
; ZVFHMIN-NEXT:    vsetivli zero, 16, e16, m2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v12
; ZVFHMIN-NEXT:    ret
  %v = call <16 x half> @llvm.vp.fdiv.v16f16(<16 x half> %va, <16 x half> %b, <16 x i1> splat (i1 true), i32 %evl)
  ret <16 x half> %v
}

define <16 x half> @vfdiv_vf_v16f16(<16 x half> %va, half %b, <16 x i1> %m, i32 zeroext %evl) {
; ZVFH-LABEL: vfdiv_vf_v16f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, m2, ta, ma
; ZVFH-NEXT:    vfdiv.vf v8, v8, fa0, v0.t
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfdiv_vf_v16f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    fcvt.s.h fa5, fa0
; ZVFHMIN-NEXT:    vsetvli a1, zero, e32, m4, ta, ma
; ZVFHMIN-NEXT:    vfmv.v.f v12, fa5
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v10, v12
; ZVFHMIN-NEXT:    vsetivli zero, 16, e16, m2, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v12, v8
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v16, v10
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m4, ta, ma
; ZVFHMIN-NEXT:    vfdiv.vv v12, v12, v16, v0.t
; ZVFHMIN-NEXT:    vsetivli zero, 16, e16, m2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v12
; ZVFHMIN-NEXT:    ret
  %elt.head = insertelement <16 x half> poison, half %b, i32 0
  %vb = shufflevector <16 x half> %elt.head, <16 x half> poison, <16 x i32> zeroinitializer
  %v = call <16 x half> @llvm.vp.fdiv.v16f16(<16 x half> %va, <16 x half> %vb, <16 x i1> %m, i32 %evl)
  ret <16 x half> %v
}

define <16 x half> @vfdiv_vf_v16f16_unmasked(<16 x half> %va, half %b, i32 zeroext %evl) {
; ZVFH-LABEL: vfdiv_vf_v16f16_unmasked:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, m2, ta, ma
; ZVFH-NEXT:    vfdiv.vf v8, v8, fa0
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfdiv_vf_v16f16_unmasked:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    fcvt.s.h fa5, fa0
; ZVFHMIN-NEXT:    vsetvli a1, zero, e32, m4, ta, ma
; ZVFHMIN-NEXT:    vfmv.v.f v12, fa5
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v10, v12
; ZVFHMIN-NEXT:    vsetivli zero, 16, e16, m2, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v12, v8
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v16, v10
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m4, ta, ma
; ZVFHMIN-NEXT:    vfdiv.vv v12, v12, v16
; ZVFHMIN-NEXT:    vsetivli zero, 16, e16, m2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v12
; ZVFHMIN-NEXT:    ret
  %elt.head = insertelement <16 x half> poison, half %b, i32 0
  %vb = shufflevector <16 x half> %elt.head, <16 x half> poison, <16 x i32> zeroinitializer
  %v = call <16 x half> @llvm.vp.fdiv.v16f16(<16 x half> %va, <16 x half> %vb, <16 x i1> splat (i1 true), i32 %evl)
  ret <16 x half> %v
}

declare <2 x float> @llvm.vp.fdiv.v2f32(<2 x float>, <2 x float>, <2 x i1>, i32)

define <2 x float> @vfdiv_vv_v2f32(<2 x float> %va, <2 x float> %b, <2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfdiv_vv_v2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, mf2, ta, ma
; CHECK-NEXT:    vfdiv.vv v8, v8, v9, v0.t
; CHECK-NEXT:    ret
  %v = call <2 x float> @llvm.vp.fdiv.v2f32(<2 x float> %va, <2 x float> %b, <2 x i1> %m, i32 %evl)
  ret <2 x float> %v
}

define <2 x float> @vfdiv_vv_v2f32_unmasked(<2 x float> %va, <2 x float> %b, i32 zeroext %evl) {
; CHECK-LABEL: vfdiv_vv_v2f32_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, mf2, ta, ma
; CHECK-NEXT:    vfdiv.vv v8, v8, v9
; CHECK-NEXT:    ret
  %v = call <2 x float> @llvm.vp.fdiv.v2f32(<2 x float> %va, <2 x float> %b, <2 x i1> splat (i1 true), i32 %evl)
  ret <2 x float> %v
}

define <2 x float> @vfdiv_vf_v2f32(<2 x float> %va, float %b, <2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfdiv_vf_v2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, mf2, ta, ma
; CHECK-NEXT:    vfdiv.vf v8, v8, fa0, v0.t
; CHECK-NEXT:    ret
  %elt.head = insertelement <2 x float> poison, float %b, i32 0
  %vb = shufflevector <2 x float> %elt.head, <2 x float> poison, <2 x i32> zeroinitializer
  %v = call <2 x float> @llvm.vp.fdiv.v2f32(<2 x float> %va, <2 x float> %vb, <2 x i1> %m, i32 %evl)
  ret <2 x float> %v
}

define <2 x float> @vfdiv_vf_v2f32_unmasked(<2 x float> %va, float %b, i32 zeroext %evl) {
; CHECK-LABEL: vfdiv_vf_v2f32_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, mf2, ta, ma
; CHECK-NEXT:    vfdiv.vf v8, v8, fa0
; CHECK-NEXT:    ret
  %elt.head = insertelement <2 x float> poison, float %b, i32 0
  %vb = shufflevector <2 x float> %elt.head, <2 x float> poison, <2 x i32> zeroinitializer
  %v = call <2 x float> @llvm.vp.fdiv.v2f32(<2 x float> %va, <2 x float> %vb, <2 x i1> splat (i1 true), i32 %evl)
  ret <2 x float> %v
}

declare <4 x float> @llvm.vp.fdiv.v4f32(<4 x float>, <4 x float>, <4 x i1>, i32)

define <4 x float> @vfdiv_vv_v4f32(<4 x float> %va, <4 x float> %b, <4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfdiv_vv_v4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vfdiv.vv v8, v8, v9, v0.t
; CHECK-NEXT:    ret
  %v = call <4 x float> @llvm.vp.fdiv.v4f32(<4 x float> %va, <4 x float> %b, <4 x i1> %m, i32 %evl)
  ret <4 x float> %v
}

define <4 x float> @vfdiv_vv_v4f32_unmasked(<4 x float> %va, <4 x float> %b, i32 zeroext %evl) {
; CHECK-LABEL: vfdiv_vv_v4f32_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vfdiv.vv v8, v8, v9
; CHECK-NEXT:    ret
  %v = call <4 x float> @llvm.vp.fdiv.v4f32(<4 x float> %va, <4 x float> %b, <4 x i1> splat (i1 true), i32 %evl)
  ret <4 x float> %v
}

define <4 x float> @vfdiv_vf_v4f32(<4 x float> %va, float %b, <4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfdiv_vf_v4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vfdiv.vf v8, v8, fa0, v0.t
; CHECK-NEXT:    ret
  %elt.head = insertelement <4 x float> poison, float %b, i32 0
  %vb = shufflevector <4 x float> %elt.head, <4 x float> poison, <4 x i32> zeroinitializer
  %v = call <4 x float> @llvm.vp.fdiv.v4f32(<4 x float> %va, <4 x float> %vb, <4 x i1> %m, i32 %evl)
  ret <4 x float> %v
}

define <4 x float> @vfdiv_vf_v4f32_unmasked(<4 x float> %va, float %b, i32 zeroext %evl) {
; CHECK-LABEL: vfdiv_vf_v4f32_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vfdiv.vf v8, v8, fa0
; CHECK-NEXT:    ret
  %elt.head = insertelement <4 x float> poison, float %b, i32 0
  %vb = shufflevector <4 x float> %elt.head, <4 x float> poison, <4 x i32> zeroinitializer
  %v = call <4 x float> @llvm.vp.fdiv.v4f32(<4 x float> %va, <4 x float> %vb, <4 x i1> splat (i1 true), i32 %evl)
  ret <4 x float> %v
}

declare <8 x float> @llvm.vp.fdiv.v8f32(<8 x float>, <8 x float>, <8 x i1>, i32)

define <8 x float> @vfdiv_vv_v8f32(<8 x float> %va, <8 x float> %b, <8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfdiv_vv_v8f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m2, ta, ma
; CHECK-NEXT:    vfdiv.vv v8, v8, v10, v0.t
; CHECK-NEXT:    ret
  %v = call <8 x float> @llvm.vp.fdiv.v8f32(<8 x float> %va, <8 x float> %b, <8 x i1> %m, i32 %evl)
  ret <8 x float> %v
}

define <8 x float> @vfdiv_vv_v8f32_unmasked(<8 x float> %va, <8 x float> %b, i32 zeroext %evl) {
; CHECK-LABEL: vfdiv_vv_v8f32_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m2, ta, ma
; CHECK-NEXT:    vfdiv.vv v8, v8, v10
; CHECK-NEXT:    ret
  %v = call <8 x float> @llvm.vp.fdiv.v8f32(<8 x float> %va, <8 x float> %b, <8 x i1> splat (i1 true), i32 %evl)
  ret <8 x float> %v
}

define <8 x float> @vfdiv_vf_v8f32(<8 x float> %va, float %b, <8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfdiv_vf_v8f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m2, ta, ma
; CHECK-NEXT:    vfdiv.vf v8, v8, fa0, v0.t
; CHECK-NEXT:    ret
  %elt.head = insertelement <8 x float> poison, float %b, i32 0
  %vb = shufflevector <8 x float> %elt.head, <8 x float> poison, <8 x i32> zeroinitializer
  %v = call <8 x float> @llvm.vp.fdiv.v8f32(<8 x float> %va, <8 x float> %vb, <8 x i1> %m, i32 %evl)
  ret <8 x float> %v
}

define <8 x float> @vfdiv_vf_v8f32_unmasked(<8 x float> %va, float %b, i32 zeroext %evl) {
; CHECK-LABEL: vfdiv_vf_v8f32_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m2, ta, ma
; CHECK-NEXT:    vfdiv.vf v8, v8, fa0
; CHECK-NEXT:    ret
  %elt.head = insertelement <8 x float> poison, float %b, i32 0
  %vb = shufflevector <8 x float> %elt.head, <8 x float> poison, <8 x i32> zeroinitializer
  %v = call <8 x float> @llvm.vp.fdiv.v8f32(<8 x float> %va, <8 x float> %vb, <8 x i1> splat (i1 true), i32 %evl)
  ret <8 x float> %v
}

declare <16 x float> @llvm.vp.fdiv.v16f32(<16 x float>, <16 x float>, <16 x i1>, i32)

define <16 x float> @vfdiv_vv_v16f32(<16 x float> %va, <16 x float> %b, <16 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfdiv_vv_v16f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m4, ta, ma
; CHECK-NEXT:    vfdiv.vv v8, v8, v12, v0.t
; CHECK-NEXT:    ret
  %v = call <16 x float> @llvm.vp.fdiv.v16f32(<16 x float> %va, <16 x float> %b, <16 x i1> %m, i32 %evl)
  ret <16 x float> %v
}

define <16 x float> @vfdiv_vv_v16f32_unmasked(<16 x float> %va, <16 x float> %b, i32 zeroext %evl) {
; CHECK-LABEL: vfdiv_vv_v16f32_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m4, ta, ma
; CHECK-NEXT:    vfdiv.vv v8, v8, v12
; CHECK-NEXT:    ret
  %v = call <16 x float> @llvm.vp.fdiv.v16f32(<16 x float> %va, <16 x float> %b, <16 x i1> splat (i1 true), i32 %evl)
  ret <16 x float> %v
}

define <16 x float> @vfdiv_vf_v16f32(<16 x float> %va, float %b, <16 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfdiv_vf_v16f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m4, ta, ma
; CHECK-NEXT:    vfdiv.vf v8, v8, fa0, v0.t
; CHECK-NEXT:    ret
  %elt.head = insertelement <16 x float> poison, float %b, i32 0
  %vb = shufflevector <16 x float> %elt.head, <16 x float> poison, <16 x i32> zeroinitializer
  %v = call <16 x float> @llvm.vp.fdiv.v16f32(<16 x float> %va, <16 x float> %vb, <16 x i1> %m, i32 %evl)
  ret <16 x float> %v
}

define <16 x float> @vfdiv_vf_v16f32_unmasked(<16 x float> %va, float %b, i32 zeroext %evl) {
; CHECK-LABEL: vfdiv_vf_v16f32_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m4, ta, ma
; CHECK-NEXT:    vfdiv.vf v8, v8, fa0
; CHECK-NEXT:    ret
  %elt.head = insertelement <16 x float> poison, float %b, i32 0
  %vb = shufflevector <16 x float> %elt.head, <16 x float> poison, <16 x i32> zeroinitializer
  %v = call <16 x float> @llvm.vp.fdiv.v16f32(<16 x float> %va, <16 x float> %vb, <16 x i1> splat (i1 true), i32 %evl)
  ret <16 x float> %v
}

declare <2 x double> @llvm.vp.fdiv.v2f64(<2 x double>, <2 x double>, <2 x i1>, i32)

define <2 x double> @vfdiv_vv_v2f64(<2 x double> %va, <2 x double> %b, <2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfdiv_vv_v2f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m1, ta, ma
; CHECK-NEXT:    vfdiv.vv v8, v8, v9, v0.t
; CHECK-NEXT:    ret
  %v = call <2 x double> @llvm.vp.fdiv.v2f64(<2 x double> %va, <2 x double> %b, <2 x i1> %m, i32 %evl)
  ret <2 x double> %v
}

define <2 x double> @vfdiv_vv_v2f64_unmasked(<2 x double> %va, <2 x double> %b, i32 zeroext %evl) {
; CHECK-LABEL: vfdiv_vv_v2f64_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m1, ta, ma
; CHECK-NEXT:    vfdiv.vv v8, v8, v9
; CHECK-NEXT:    ret
  %v = call <2 x double> @llvm.vp.fdiv.v2f64(<2 x double> %va, <2 x double> %b, <2 x i1> splat (i1 true), i32 %evl)
  ret <2 x double> %v
}

define <2 x double> @vfdiv_vf_v2f64(<2 x double> %va, double %b, <2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfdiv_vf_v2f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m1, ta, ma
; CHECK-NEXT:    vfdiv.vf v8, v8, fa0, v0.t
; CHECK-NEXT:    ret
  %elt.head = insertelement <2 x double> poison, double %b, i32 0
  %vb = shufflevector <2 x double> %elt.head, <2 x double> poison, <2 x i32> zeroinitializer
  %v = call <2 x double> @llvm.vp.fdiv.v2f64(<2 x double> %va, <2 x double> %vb, <2 x i1> %m, i32 %evl)
  ret <2 x double> %v
}

define <2 x double> @vfdiv_vf_v2f64_unmasked(<2 x double> %va, double %b, i32 zeroext %evl) {
; CHECK-LABEL: vfdiv_vf_v2f64_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m1, ta, ma
; CHECK-NEXT:    vfdiv.vf v8, v8, fa0
; CHECK-NEXT:    ret
  %elt.head = insertelement <2 x double> poison, double %b, i32 0
  %vb = shufflevector <2 x double> %elt.head, <2 x double> poison, <2 x i32> zeroinitializer
  %v = call <2 x double> @llvm.vp.fdiv.v2f64(<2 x double> %va, <2 x double> %vb, <2 x i1> splat (i1 true), i32 %evl)
  ret <2 x double> %v
}

declare <4 x double> @llvm.vp.fdiv.v4f64(<4 x double>, <4 x double>, <4 x i1>, i32)

define <4 x double> @vfdiv_vv_v4f64(<4 x double> %va, <4 x double> %b, <4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfdiv_vv_v4f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, ta, ma
; CHECK-NEXT:    vfdiv.vv v8, v8, v10, v0.t
; CHECK-NEXT:    ret
  %v = call <4 x double> @llvm.vp.fdiv.v4f64(<4 x double> %va, <4 x double> %b, <4 x i1> %m, i32 %evl)
  ret <4 x double> %v
}

define <4 x double> @vfdiv_vv_v4f64_unmasked(<4 x double> %va, <4 x double> %b, i32 zeroext %evl) {
; CHECK-LABEL: vfdiv_vv_v4f64_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, ta, ma
; CHECK-NEXT:    vfdiv.vv v8, v8, v10
; CHECK-NEXT:    ret
  %v = call <4 x double> @llvm.vp.fdiv.v4f64(<4 x double> %va, <4 x double> %b, <4 x i1> splat (i1 true), i32 %evl)
  ret <4 x double> %v
}

define <4 x double> @vfdiv_vf_v4f64(<4 x double> %va, double %b, <4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfdiv_vf_v4f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, ta, ma
; CHECK-NEXT:    vfdiv.vf v8, v8, fa0, v0.t
; CHECK-NEXT:    ret
  %elt.head = insertelement <4 x double> poison, double %b, i32 0
  %vb = shufflevector <4 x double> %elt.head, <4 x double> poison, <4 x i32> zeroinitializer
  %v = call <4 x double> @llvm.vp.fdiv.v4f64(<4 x double> %va, <4 x double> %vb, <4 x i1> %m, i32 %evl)
  ret <4 x double> %v
}

define <4 x double> @vfdiv_vf_v4f64_unmasked(<4 x double> %va, double %b, i32 zeroext %evl) {
; CHECK-LABEL: vfdiv_vf_v4f64_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, ta, ma
; CHECK-NEXT:    vfdiv.vf v8, v8, fa0
; CHECK-NEXT:    ret
  %elt.head = insertelement <4 x double> poison, double %b, i32 0
  %vb = shufflevector <4 x double> %elt.head, <4 x double> poison, <4 x i32> zeroinitializer
  %v = call <4 x double> @llvm.vp.fdiv.v4f64(<4 x double> %va, <4 x double> %vb, <4 x i1> splat (i1 true), i32 %evl)
  ret <4 x double> %v
}

declare <8 x double> @llvm.vp.fdiv.v8f64(<8 x double>, <8 x double>, <8 x i1>, i32)

define <8 x double> @vfdiv_vv_v8f64(<8 x double> %va, <8 x double> %b, <8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfdiv_vv_v8f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m4, ta, ma
; CHECK-NEXT:    vfdiv.vv v8, v8, v12, v0.t
; CHECK-NEXT:    ret
  %v = call <8 x double> @llvm.vp.fdiv.v8f64(<8 x double> %va, <8 x double> %b, <8 x i1> %m, i32 %evl)
  ret <8 x double> %v
}

define <8 x double> @vfdiv_vv_v8f64_unmasked(<8 x double> %va, <8 x double> %b, i32 zeroext %evl) {
; CHECK-LABEL: vfdiv_vv_v8f64_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m4, ta, ma
; CHECK-NEXT:    vfdiv.vv v8, v8, v12
; CHECK-NEXT:    ret
  %v = call <8 x double> @llvm.vp.fdiv.v8f64(<8 x double> %va, <8 x double> %b, <8 x i1> splat (i1 true), i32 %evl)
  ret <8 x double> %v
}

define <8 x double> @vfdiv_vf_v8f64(<8 x double> %va, double %b, <8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfdiv_vf_v8f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m4, ta, ma
; CHECK-NEXT:    vfdiv.vf v8, v8, fa0, v0.t
; CHECK-NEXT:    ret
  %elt.head = insertelement <8 x double> poison, double %b, i32 0
  %vb = shufflevector <8 x double> %elt.head, <8 x double> poison, <8 x i32> zeroinitializer
  %v = call <8 x double> @llvm.vp.fdiv.v8f64(<8 x double> %va, <8 x double> %vb, <8 x i1> %m, i32 %evl)
  ret <8 x double> %v
}

define <8 x double> @vfdiv_vf_v8f64_unmasked(<8 x double> %va, double %b, i32 zeroext %evl) {
; CHECK-LABEL: vfdiv_vf_v8f64_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m4, ta, ma
; CHECK-NEXT:    vfdiv.vf v8, v8, fa0
; CHECK-NEXT:    ret
  %elt.head = insertelement <8 x double> poison, double %b, i32 0
  %vb = shufflevector <8 x double> %elt.head, <8 x double> poison, <8 x i32> zeroinitializer
  %v = call <8 x double> @llvm.vp.fdiv.v8f64(<8 x double> %va, <8 x double> %vb, <8 x i1> splat (i1 true), i32 %evl)
  ret <8 x double> %v
}

declare <16 x double> @llvm.vp.fdiv.v16f64(<16 x double>, <16 x double>, <16 x i1>, i32)

define <16 x double> @vfdiv_vv_v16f64(<16 x double> %va, <16 x double> %b, <16 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfdiv_vv_v16f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m8, ta, ma
; CHECK-NEXT:    vfdiv.vv v8, v8, v16, v0.t
; CHECK-NEXT:    ret
  %v = call <16 x double> @llvm.vp.fdiv.v16f64(<16 x double> %va, <16 x double> %b, <16 x i1> %m, i32 %evl)
  ret <16 x double> %v
}

define <16 x double> @vfdiv_vv_v16f64_unmasked(<16 x double> %va, <16 x double> %b, i32 zeroext %evl) {
; CHECK-LABEL: vfdiv_vv_v16f64_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m8, ta, ma
; CHECK-NEXT:    vfdiv.vv v8, v8, v16
; CHECK-NEXT:    ret
  %v = call <16 x double> @llvm.vp.fdiv.v16f64(<16 x double> %va, <16 x double> %b, <16 x i1> splat (i1 true), i32 %evl)
  ret <16 x double> %v
}

define <16 x double> @vfdiv_vf_v16f64(<16 x double> %va, double %b, <16 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfdiv_vf_v16f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m8, ta, ma
; CHECK-NEXT:    vfdiv.vf v8, v8, fa0, v0.t
; CHECK-NEXT:    ret
  %elt.head = insertelement <16 x double> poison, double %b, i32 0
  %vb = shufflevector <16 x double> %elt.head, <16 x double> poison, <16 x i32> zeroinitializer
  %v = call <16 x double> @llvm.vp.fdiv.v16f64(<16 x double> %va, <16 x double> %vb, <16 x i1> %m, i32 %evl)
  ret <16 x double> %v
}

define <16 x double> @vfdiv_vf_v16f64_unmasked(<16 x double> %va, double %b, i32 zeroext %evl) {
; CHECK-LABEL: vfdiv_vf_v16f64_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m8, ta, ma
; CHECK-NEXT:    vfdiv.vf v8, v8, fa0
; CHECK-NEXT:    ret
  %elt.head = insertelement <16 x double> poison, double %b, i32 0
  %vb = shufflevector <16 x double> %elt.head, <16 x double> poison, <16 x i32> zeroinitializer
  %v = call <16 x double> @llvm.vp.fdiv.v16f64(<16 x double> %va, <16 x double> %vb, <16 x i1> splat (i1 true), i32 %evl)
  ret <16 x double> %v
}
