; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+v,+f,+d -target-abi=ilp32d \
; RUN:     -verify-machineinstrs < %s | FileCheck %s
; RUN: llc -mtriple=riscv64 -mattr=+v,+f,+d -target-abi=lp64d \
; RUN:     -verify-machineinstrs < %s | FileCheck %s

define <vscale x 1 x i64> @llrint_nxv1i64_nxv1f32(<vscale x 1 x float> %x, <vscale x 1 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: llrint_nxv1i64_nxv1f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, mf2, ta, ma
; CHECK-NEXT:    vfwcvt.x.f.v v9, v8, v0.t
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %a = call <vscale x 1 x i64> @llvm.vp.llrint.nxv1i64.nxv1f32(<vscale x 1 x float> %x, <vscale x 1 x i1> %m, i32 %evl)
  ret <vscale x 1 x i64> %a
}
declare <vscale x 1 x i64> @llvm.vp.llrint.nxv1i64.nxv1f32(<vscale x 1 x float>, <vscale x 1 x i1>, i32)

define <vscale x 2 x i64> @llrint_nxv2i64_nxv2f32(<vscale x 2 x float> %x, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: llrint_nxv2i64_nxv2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vfwcvt.x.f.v v10, v8, v0.t
; CHECK-NEXT:    vmv2r.v v8, v10
; CHECK-NEXT:    ret
  %a = call <vscale x 2 x i64> @llvm.vp.llrint.nxv2i64.nxv2f32(<vscale x 2 x float> %x, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x i64> %a
}
declare <vscale x 2 x i64> @llvm.vp.llrint.nxv2i64.nxv2f32(<vscale x 2 x float>, <vscale x 2 x i1>, i32)

define <vscale x 4 x i64> @llrint_nxv4i64_nxv4f32(<vscale x 4 x float> %x, <vscale x 4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: llrint_nxv4i64_nxv4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m2, ta, ma
; CHECK-NEXT:    vfwcvt.x.f.v v12, v8, v0.t
; CHECK-NEXT:    vmv4r.v v8, v12
; CHECK-NEXT:    ret
  %a = call <vscale x 4 x i64> @llvm.vp.llrint.nxv4i64.nxv4f32(<vscale x 4 x float> %x, <vscale x 4 x i1> %m, i32 %evl)
  ret <vscale x 4 x i64> %a
}
declare <vscale x 4 x i64> @llvm.vp.llrint.nxv4i64.nxv4f32(<vscale x 4 x float>, <vscale x 4 x i1>, i32)

define <vscale x 8 x i64> @llrint_nxv8i64_nxv8f32(<vscale x 8 x float> %x, <vscale x 8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: llrint_nxv8i64_nxv8f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m4, ta, ma
; CHECK-NEXT:    vfwcvt.x.f.v v16, v8, v0.t
; CHECK-NEXT:    vmv8r.v v8, v16
; CHECK-NEXT:    ret
  %a = call <vscale x 8 x i64> @llvm.vp.llrint.nxv8i64.nxv8f32(<vscale x 8 x float> %x, <vscale x 8 x i1> %m, i32 %evl)
  ret <vscale x 8 x i64> %a
}
declare <vscale x 8 x i64> @llvm.vp.llrint.nxv8i64.nxv8f32(<vscale x 8 x float>, <vscale x 8 x i1>, i32)

define <vscale x 16 x i64> @llrint_nxv16i64_nxv16f32(<vscale x 16 x float> %x, <vscale x 16 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: llrint_nxv16i64_nxv16f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v24, v0
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    srli a2, a1, 3
; CHECK-NEXT:    vsetvli a3, zero, e8, mf4, ta, ma
; CHECK-NEXT:    vslidedown.vx v0, v0, a2
; CHECK-NEXT:    sub a2, a0, a1
; CHECK-NEXT:    sltu a3, a0, a2
; CHECK-NEXT:    addi a3, a3, -1
; CHECK-NEXT:    and a2, a3, a2
; CHECK-NEXT:    vsetvli zero, a2, e32, m4, ta, ma
; CHECK-NEXT:    vfwcvt.x.f.v v16, v12, v0.t
; CHECK-NEXT:    bltu a0, a1, .LBB4_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a0, a1
; CHECK-NEXT:  .LBB4_2:
; CHECK-NEXT:    vmv1r.v v0, v24
; CHECK-NEXT:    vsetvli zero, a0, e32, m4, ta, ma
; CHECK-NEXT:    vfwcvt.x.f.v v24, v8, v0.t
; CHECK-NEXT:    vmv8r.v v8, v24
; CHECK-NEXT:    ret
  %a = call <vscale x 16 x i64> @llvm.vp.llrint.nxv16i64.nxv16f32(<vscale x 16 x float> %x, <vscale x 16 x i1> %m, i32 %evl)
  ret <vscale x 16 x i64> %a
}
declare <vscale x 16 x i64> @llvm.vp.llrint.nxv16i64.nxv16f32(<vscale x 16 x float>, <vscale x 16 x i1>, i32)

define <vscale x 1 x i64> @llrint_nxv1i64_nxv1f64(<vscale x 1 x double> %x, <vscale x 1 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: llrint_nxv1i64_nxv1f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m1, ta, ma
; CHECK-NEXT:    vfcvt.x.f.v v8, v8, v0.t
; CHECK-NEXT:    ret
  %a = call <vscale x 1 x i64> @llvm.vp.llrint.nxv1i64.nxv1f64(<vscale x 1 x double> %x, <vscale x 1 x i1> %m, i32 %evl)
  ret <vscale x 1 x i64> %a
}
declare <vscale x 1 x i64> @llvm.vp.llrint.nxv1i64.nxv1f64(<vscale x 1 x double>, <vscale x 1 x i1>, i32)

define <vscale x 2 x i64> @llrint_nxv2i64_nxv2f64(<vscale x 2 x double> %x, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: llrint_nxv2i64_nxv2f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, ta, ma
; CHECK-NEXT:    vfcvt.x.f.v v8, v8, v0.t
; CHECK-NEXT:    ret
  %a = call <vscale x 2 x i64> @llvm.vp.llrint.nxv2i64.nxv2f64(<vscale x 2 x double> %x, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x i64> %a
}
declare <vscale x 2 x i64> @llvm.vp.llrint.nxv2i64.nxv2f64(<vscale x 2 x double>, <vscale x 2 x i1>, i32)

define <vscale x 4 x i64> @llrint_nxv4i64_nxv4f64(<vscale x 4 x double> %x, <vscale x 4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: llrint_nxv4i64_nxv4f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m4, ta, ma
; CHECK-NEXT:    vfcvt.x.f.v v8, v8, v0.t
; CHECK-NEXT:    ret
  %a = call <vscale x 4 x i64> @llvm.vp.llrint.nxv4i64.nxv4f64(<vscale x 4 x double> %x, <vscale x 4 x i1> %m, i32 %evl)
  ret <vscale x 4 x i64> %a
}
declare <vscale x 4 x i64> @llvm.vp.llrint.nxv4i64.nxv4f64(<vscale x 4 x double>, <vscale x 4 x i1>, i32)

define <vscale x 8 x i64> @llrint_nxv8i64_nxv8f64(<vscale x 8 x double> %x, <vscale x 8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: llrint_nxv8i64_nxv8f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m8, ta, ma
; CHECK-NEXT:    vfcvt.x.f.v v8, v8, v0.t
; CHECK-NEXT:    ret
  %a = call <vscale x 8 x i64> @llvm.vp.llrint.nxv8i64.nxv8f64(<vscale x 8 x double> %x, <vscale x 8 x i1> %m, i32 %evl)
  ret <vscale x 8 x i64> %a
}
declare <vscale x 8 x i64> @llvm.vp.llrint.nxv8i64.nxv8f64(<vscale x 8 x double>, <vscale x 8 x i1>, i32)
