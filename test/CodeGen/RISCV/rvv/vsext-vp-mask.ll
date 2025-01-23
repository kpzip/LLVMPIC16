; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+v < %s | FileCheck %s
; RUN: llc -mtriple=riscv64 -mattr=+v < %s | FileCheck %s

declare <vscale x 2 x i16> @llvm.vp.sext.nxv2i16.nxv2i1(<vscale x 2 x i1>, <vscale x 2 x i1>, i32)

define <vscale x 2 x i16> @vsext_nxv2i1_nxv2i16(<vscale x 2 x i1> %a, <vscale x 2 x i1> %m, i32 zeroext %vl) {
; CHECK-LABEL: vsext_nxv2i1_nxv2i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vmv.v.i v8, 0
; CHECK-NEXT:    vmerge.vim v8, v8, -1, v0
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i16> @llvm.vp.sext.nxv2i16.nxv2i1(<vscale x 2 x i1> %a, <vscale x 2 x i1> %m, i32 %vl)
  ret <vscale x 2 x i16> %v
}

define <vscale x 2 x i16> @vsext_nxv2i1_nxv2i16_unmasked(<vscale x 2 x i1> %a, i32 zeroext %vl) {
; CHECK-LABEL: vsext_nxv2i1_nxv2i16_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vmv.v.i v8, 0
; CHECK-NEXT:    vmerge.vim v8, v8, -1, v0
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i16> @llvm.vp.sext.nxv2i16.nxv2i1(<vscale x 2 x i1> %a, <vscale x 2 x i1> splat (i1 true), i32 %vl)
  ret <vscale x 2 x i16> %v
}

declare <vscale x 2 x i32> @llvm.vp.sext.nxv2i32.nxv2i1(<vscale x 2 x i1>, <vscale x 2 x i1>, i32)

define <vscale x 2 x i32> @vsext_nxv2i1_nxv2i32(<vscale x 2 x i1> %a, <vscale x 2 x i1> %m, i32 zeroext %vl) {
; CHECK-LABEL: vsext_nxv2i1_nxv2i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vmv.v.i v8, 0
; CHECK-NEXT:    vmerge.vim v8, v8, -1, v0
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i32> @llvm.vp.sext.nxv2i32.nxv2i1(<vscale x 2 x i1> %a, <vscale x 2 x i1> %m, i32 %vl)
  ret <vscale x 2 x i32> %v
}

define <vscale x 2 x i32> @vsext_nxv2i1_nxv2i32_unmasked(<vscale x 2 x i1> %a, i32 zeroext %vl) {
; CHECK-LABEL: vsext_nxv2i1_nxv2i32_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vmv.v.i v8, 0
; CHECK-NEXT:    vmerge.vim v8, v8, -1, v0
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i32> @llvm.vp.sext.nxv2i32.nxv2i1(<vscale x 2 x i1> %a, <vscale x 2 x i1> splat (i1 true), i32 %vl)
  ret <vscale x 2 x i32> %v
}

declare <vscale x 2 x i64> @llvm.vp.sext.nxv2i64.nxv2i1(<vscale x 2 x i1>, <vscale x 2 x i1>, i32)

define <vscale x 2 x i64> @vsext_nxv2i1_nxv2i64(<vscale x 2 x i1> %a, <vscale x 2 x i1> %m, i32 zeroext %vl) {
; CHECK-LABEL: vsext_nxv2i1_nxv2i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, ta, ma
; CHECK-NEXT:    vmv.v.i v8, 0
; CHECK-NEXT:    vmerge.vim v8, v8, -1, v0
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i64> @llvm.vp.sext.nxv2i64.nxv2i1(<vscale x 2 x i1> %a, <vscale x 2 x i1> %m, i32 %vl)
  ret <vscale x 2 x i64> %v
}

define <vscale x 2 x i64> @vsext_nxv2i1_nxv2i64_unmasked(<vscale x 2 x i1> %a, i32 zeroext %vl) {
; CHECK-LABEL: vsext_nxv2i1_nxv2i64_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, ta, ma
; CHECK-NEXT:    vmv.v.i v8, 0
; CHECK-NEXT:    vmerge.vim v8, v8, -1, v0
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i64> @llvm.vp.sext.nxv2i64.nxv2i1(<vscale x 2 x i1> %a, <vscale x 2 x i1> splat (i1 true), i32 %vl)
  ret <vscale x 2 x i64> %v
}
