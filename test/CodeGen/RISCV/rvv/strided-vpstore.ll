; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+m,+d,+zfh,+v,+zvfh \
; RUN:     -verify-machineinstrs < %s | FileCheck %s \
; RUN:     -check-prefixes=CHECK,CHECK-RV32
; RUN: llc -mtriple=riscv64 -mattr=+m,+d,+zfh,+v,+zvfh \
; RUN:     -verify-machineinstrs < %s | FileCheck %s \
; RUN:     -check-prefixes=CHECK,CHECK-RV64

declare void @llvm.experimental.vp.strided.store.nxv1i8.p0.i8(<vscale x 1 x i8>, ptr, i8, <vscale x 1 x i1>, i32)

define void @strided_vpstore_nxv1i8_i8(<vscale x 1 x i8> %val, ptr %ptr, i8 signext %stride, <vscale x 1 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpstore_nxv1i8_i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e8, mf8, ta, ma
; CHECK-NEXT:    vsse8.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret
  call void @llvm.experimental.vp.strided.store.nxv1i8.p0.i8(<vscale x 1 x i8> %val, ptr %ptr, i8 %stride, <vscale x 1 x i1> %m, i32 %evl)
  ret void
}

declare void @llvm.experimental.vp.strided.store.nxv1i8.p0.i16(<vscale x 1 x i8>, ptr, i16, <vscale x 1 x i1>, i32)

define void @strided_vpstore_nxv1i8_i16(<vscale x 1 x i8> %val, ptr %ptr, i16 signext %stride, <vscale x 1 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpstore_nxv1i8_i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e8, mf8, ta, ma
; CHECK-NEXT:    vsse8.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret
  call void @llvm.experimental.vp.strided.store.nxv1i8.p0.i16(<vscale x 1 x i8> %val, ptr %ptr, i16 %stride, <vscale x 1 x i1> %m, i32 %evl)
  ret void
}

declare void @llvm.experimental.vp.strided.store.nxv1i8.p0.i64(<vscale x 1 x i8>, ptr, i64, <vscale x 1 x i1>, i32)

define void @strided_vpstore_nxv1i8_i64(<vscale x 1 x i8> %val, ptr %ptr, i64 signext %stride, <vscale x 1 x i1> %m, i32 zeroext %evl) {
; CHECK-RV32-LABEL: strided_vpstore_nxv1i8_i64:
; CHECK-RV32:       # %bb.0:
; CHECK-RV32-NEXT:    vsetvli zero, a3, e8, mf8, ta, ma
; CHECK-RV32-NEXT:    vsse8.v v8, (a0), a1, v0.t
; CHECK-RV32-NEXT:    ret
;
; CHECK-RV64-LABEL: strided_vpstore_nxv1i8_i64:
; CHECK-RV64:       # %bb.0:
; CHECK-RV64-NEXT:    vsetvli zero, a2, e8, mf8, ta, ma
; CHECK-RV64-NEXT:    vsse8.v v8, (a0), a1, v0.t
; CHECK-RV64-NEXT:    ret
  call void @llvm.experimental.vp.strided.store.nxv1i8.p0.i64(<vscale x 1 x i8> %val, ptr %ptr, i64 %stride, <vscale x 1 x i1> %m, i32 %evl)
  ret void
}

declare void @llvm.experimental.vp.strided.store.nxv1i8.p0.i32(<vscale x 1 x i8>, ptr, i32, <vscale x 1 x i1>, i32)

define void @strided_vpstore_nxv1i8(<vscale x 1 x i8> %val, ptr %ptr, i32 signext %strided, <vscale x 1 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpstore_nxv1i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e8, mf8, ta, ma
; CHECK-NEXT:    vsse8.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret
  call void @llvm.experimental.vp.strided.store.nxv1i8.p0.i32(<vscale x 1 x i8> %val, ptr %ptr, i32 %strided, <vscale x 1 x i1> %m, i32 %evl)
  ret void
}

declare void @llvm.experimental.vp.strided.store.nxv2i8.p0.i32(<vscale x 2 x i8>, ptr, i32, <vscale x 2 x i1>, i32)

define void @strided_vpstore_nxv2i8(<vscale x 2 x i8> %val, ptr %ptr, i32 signext %strided, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpstore_nxv2i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e8, mf4, ta, ma
; CHECK-NEXT:    vsse8.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret
  call void @llvm.experimental.vp.strided.store.nxv2i8.p0.i32(<vscale x 2 x i8> %val, ptr %ptr, i32 %strided, <vscale x 2 x i1> %m, i32 %evl)
  ret void
}

declare void @llvm.experimental.vp.strided.store.nxv4i8.p0.i32(<vscale x 4 x i8>, ptr, i32, <vscale x 4 x i1>, i32)

define void @strided_vpstore_nxv4i8(<vscale x 4 x i8> %val, ptr %ptr, i32 signext %strided, <vscale x 4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpstore_nxv4i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e8, mf2, ta, ma
; CHECK-NEXT:    vsse8.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret
  call void @llvm.experimental.vp.strided.store.nxv4i8.p0.i32(<vscale x 4 x i8> %val, ptr %ptr, i32 %strided, <vscale x 4 x i1> %m, i32 %evl)
  ret void
}

declare void @llvm.experimental.vp.strided.store.nxv8i8.p0.i32(<vscale x 8 x i8>, ptr, i32, <vscale x 8 x i1>, i32)

define void @strided_vpstore_nxv8i8(<vscale x 8 x i8> %val, ptr %ptr, i32 signext %strided, <vscale x 8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpstore_nxv8i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e8, m1, ta, ma
; CHECK-NEXT:    vsse8.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret
  call void @llvm.experimental.vp.strided.store.nxv8i8.p0.i32(<vscale x 8 x i8> %val, ptr %ptr, i32 %strided, <vscale x 8 x i1> %m, i32 %evl)
  ret void
}

define void @strided_vpstore_nxv8i8_unit_stride(<vscale x 8 x i8> %val, ptr %ptr, <vscale x 8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpstore_nxv8i8_unit_stride:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e8, m1, ta, ma
; CHECK-NEXT:    vse8.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  call void @llvm.experimental.vp.strided.store.nxv8i8.p0.i32(<vscale x 8 x i8> %val, ptr %ptr, i32 1, <vscale x 8 x i1> %m, i32 %evl)
  ret void
}

declare void @llvm.experimental.vp.strided.store.nxv1i16.p0.i32(<vscale x 1 x i16>, ptr, i32, <vscale x 1 x i1>, i32)

define void @strided_vpstore_nxv1i16(<vscale x 1 x i16> %val, ptr %ptr, i32 signext %strided, <vscale x 1 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpstore_nxv1i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e16, mf4, ta, ma
; CHECK-NEXT:    vsse16.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret
  call void @llvm.experimental.vp.strided.store.nxv1i16.p0.i32(<vscale x 1 x i16> %val, ptr %ptr, i32 %strided, <vscale x 1 x i1> %m, i32 %evl)
  ret void
}

declare void @llvm.experimental.vp.strided.store.nxv2i16.p0.i32(<vscale x 2 x i16>, ptr, i32, <vscale x 2 x i1>, i32)

define void @strided_vpstore_nxv2i16(<vscale x 2 x i16> %val, ptr %ptr, i32 signext %strided, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpstore_nxv2i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e16, mf2, ta, ma
; CHECK-NEXT:    vsse16.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret
  call void @llvm.experimental.vp.strided.store.nxv2i16.p0.i32(<vscale x 2 x i16> %val, ptr %ptr, i32 %strided, <vscale x 2 x i1> %m, i32 %evl)
  ret void
}

declare void @llvm.experimental.vp.strided.store.nxv4i16.p0.i32(<vscale x 4 x i16>, ptr, i32, <vscale x 4 x i1>, i32)

define void @strided_vpstore_nxv4i16(<vscale x 4 x i16> %val, ptr %ptr, i32 signext %strided, <vscale x 4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpstore_nxv4i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e16, m1, ta, ma
; CHECK-NEXT:    vsse16.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret
  call void @llvm.experimental.vp.strided.store.nxv4i16.p0.i32(<vscale x 4 x i16> %val, ptr %ptr, i32 %strided, <vscale x 4 x i1> %m, i32 %evl)
  ret void
}

define void @strided_vpstore_nxv4i16_unit_stride(<vscale x 4 x i16> %val, ptr %ptr, <vscale x 4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpstore_nxv4i16_unit_stride:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e16, m1, ta, ma
; CHECK-NEXT:    vse16.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  call void @llvm.experimental.vp.strided.store.nxv4i16.p0.i32(<vscale x 4 x i16> %val, ptr %ptr, i32 2, <vscale x 4 x i1> %m, i32 %evl)
  ret void
}

declare void @llvm.experimental.vp.strided.store.nxv8i16.p0.i32(<vscale x 8 x i16>, ptr, i32, <vscale x 8 x i1>, i32)

define void @strided_vpstore_nxv8i16(<vscale x 8 x i16> %val, ptr %ptr, i32 signext %strided, <vscale x 8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpstore_nxv8i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e16, m2, ta, ma
; CHECK-NEXT:    vsse16.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret
  call void @llvm.experimental.vp.strided.store.nxv8i16.p0.i32(<vscale x 8 x i16> %val, ptr %ptr, i32 %strided, <vscale x 8 x i1> %m, i32 %evl)
  ret void
}

declare void @llvm.experimental.vp.strided.store.nxv1i32.p0.i32(<vscale x 1 x i32>, ptr, i32, <vscale x 1 x i1>, i32)

define void @strided_vpstore_nxv1i32(<vscale x 1 x i32> %val, ptr %ptr, i32 signext %strided, <vscale x 1 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpstore_nxv1i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e32, mf2, ta, ma
; CHECK-NEXT:    vsse32.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret
  call void @llvm.experimental.vp.strided.store.nxv1i32.p0.i32(<vscale x 1 x i32> %val, ptr %ptr, i32 %strided, <vscale x 1 x i1> %m, i32 %evl)
  ret void
}

declare void @llvm.experimental.vp.strided.store.nxv2i32.p0.i32(<vscale x 2 x i32>, ptr, i32, <vscale x 2 x i1>, i32)

define void @strided_vpstore_nxv2i32(<vscale x 2 x i32> %val, ptr %ptr, i32 signext %strided, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpstore_nxv2i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e32, m1, ta, ma
; CHECK-NEXT:    vsse32.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret
  call void @llvm.experimental.vp.strided.store.nxv2i32.p0.i32(<vscale x 2 x i32> %val, ptr %ptr, i32 %strided, <vscale x 2 x i1> %m, i32 %evl)
  ret void
}

declare void @llvm.experimental.vp.strided.store.nxv4i32.p0.i32(<vscale x 4 x i32>, ptr, i32, <vscale x 4 x i1>, i32)

define void @strided_vpstore_nxv4i32(<vscale x 4 x i32> %val, ptr %ptr, i32 signext %strided, <vscale x 4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpstore_nxv4i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e32, m2, ta, ma
; CHECK-NEXT:    vsse32.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret
  call void @llvm.experimental.vp.strided.store.nxv4i32.p0.i32(<vscale x 4 x i32> %val, ptr %ptr, i32 %strided, <vscale x 4 x i1> %m, i32 %evl)
  ret void
}

define void @strided_vpstore_nxv4i32_unit_stride(<vscale x 4 x i32> %val, ptr %ptr, <vscale x 4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpstore_nxv4i32_unit_stride:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e32, m2, ta, ma
; CHECK-NEXT:    vse32.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  call void @llvm.experimental.vp.strided.store.nxv4i32.p0.i32(<vscale x 4 x i32> %val, ptr %ptr, i32 4, <vscale x 4 x i1> %m, i32 %evl)
  ret void
}

declare void @llvm.experimental.vp.strided.store.nxv8i32.p0.i32(<vscale x 8 x i32>, ptr, i32, <vscale x 8 x i1>, i32)

define void @strided_vpstore_nxv8i32(<vscale x 8 x i32> %val, ptr %ptr, i32 signext %strided, <vscale x 8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpstore_nxv8i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e32, m4, ta, ma
; CHECK-NEXT:    vsse32.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret
  call void @llvm.experimental.vp.strided.store.nxv8i32.p0.i32(<vscale x 8 x i32> %val, ptr %ptr, i32 %strided, <vscale x 8 x i1> %m, i32 %evl)
  ret void
}

declare void @llvm.experimental.vp.strided.store.nxv1i64.p0.i32(<vscale x 1 x i64>, ptr, i32, <vscale x 1 x i1>, i32)

define void @strided_vpstore_nxv1i64(<vscale x 1 x i64> %val, ptr %ptr, i32 signext %strided, <vscale x 1 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpstore_nxv1i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e64, m1, ta, ma
; CHECK-NEXT:    vsse64.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret
  call void @llvm.experimental.vp.strided.store.nxv1i64.p0.i32(<vscale x 1 x i64> %val, ptr %ptr, i32 %strided, <vscale x 1 x i1> %m, i32 %evl)
  ret void
}

define void @strided_vpstore_nxv1i64_unit_stride(<vscale x 1 x i64> %val, ptr %ptr, <vscale x 1 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpstore_nxv1i64_unit_stride:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e64, m1, ta, ma
; CHECK-NEXT:    vse64.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  call void @llvm.experimental.vp.strided.store.nxv1i64.p0.i32(<vscale x 1 x i64> %val, ptr %ptr, i32 8, <vscale x 1 x i1> %m, i32 %evl)
  ret void
}

declare void @llvm.experimental.vp.strided.store.nxv2i64.p0.i32(<vscale x 2 x i64>, ptr, i32, <vscale x 2 x i1>, i32)

define void @strided_vpstore_nxv2i64(<vscale x 2 x i64> %val, ptr %ptr, i32 signext %strided, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpstore_nxv2i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e64, m2, ta, ma
; CHECK-NEXT:    vsse64.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret
  call void @llvm.experimental.vp.strided.store.nxv2i64.p0.i32(<vscale x 2 x i64> %val, ptr %ptr, i32 %strided, <vscale x 2 x i1> %m, i32 %evl)
  ret void
}

declare void @llvm.experimental.vp.strided.store.nxv4i64.p0.i32(<vscale x 4 x i64>, ptr, i32, <vscale x 4 x i1>, i32)

define void @strided_vpstore_nxv4i64(<vscale x 4 x i64> %val, ptr %ptr, i32 signext %strided, <vscale x 4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpstore_nxv4i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e64, m4, ta, ma
; CHECK-NEXT:    vsse64.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret
  call void @llvm.experimental.vp.strided.store.nxv4i64.p0.i32(<vscale x 4 x i64> %val, ptr %ptr, i32 %strided, <vscale x 4 x i1> %m, i32 %evl)
  ret void
}

declare void @llvm.experimental.vp.strided.store.nxv8i64.p0.i32(<vscale x 8 x i64>, ptr, i32, <vscale x 8 x i1>, i32)

define void @strided_vpstore_nxv8i64(<vscale x 8 x i64> %val, ptr %ptr, i32 signext %strided, <vscale x 8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpstore_nxv8i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e64, m8, ta, ma
; CHECK-NEXT:    vsse64.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret
  call void @llvm.experimental.vp.strided.store.nxv8i64.p0.i32(<vscale x 8 x i64> %val, ptr %ptr, i32 %strided, <vscale x 8 x i1> %m, i32 %evl)
  ret void
}

declare void @llvm.experimental.vp.strided.store.nxv1f16.p0.i32(<vscale x 1 x half>, ptr, i32, <vscale x 1 x i1>, i32)

define void @strided_vpstore_nxv1f16(<vscale x 1 x half> %val, ptr %ptr, i32 signext %strided, <vscale x 1 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpstore_nxv1f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e16, mf4, ta, ma
; CHECK-NEXT:    vsse16.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret
  call void @llvm.experimental.vp.strided.store.nxv1f16.p0.i32(<vscale x 1 x half> %val, ptr %ptr, i32 %strided, <vscale x 1 x i1> %m, i32 %evl)
  ret void
}

declare void @llvm.experimental.vp.strided.store.nxv2f16.p0.i32(<vscale x 2 x half>, ptr, i32, <vscale x 2 x i1>, i32)

define void @strided_vpstore_nxv2f16(<vscale x 2 x half> %val, ptr %ptr, i32 signext %strided, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpstore_nxv2f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e16, mf2, ta, ma
; CHECK-NEXT:    vsse16.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret
  call void @llvm.experimental.vp.strided.store.nxv2f16.p0.i32(<vscale x 2 x half> %val, ptr %ptr, i32 %strided, <vscale x 2 x i1> %m, i32 %evl)
  ret void
}

declare void @llvm.experimental.vp.strided.store.nxv4f16.p0.i32(<vscale x 4 x half>, ptr, i32, <vscale x 4 x i1>, i32)

define void @strided_vpstore_nxv4f16(<vscale x 4 x half> %val, ptr %ptr, i32 signext %strided, <vscale x 4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpstore_nxv4f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e16, m1, ta, ma
; CHECK-NEXT:    vsse16.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret
  call void @llvm.experimental.vp.strided.store.nxv4f16.p0.i32(<vscale x 4 x half> %val, ptr %ptr, i32 %strided, <vscale x 4 x i1> %m, i32 %evl)
  ret void
}

define void @strided_vpstore_nxv4f16_unit_stride(<vscale x 4 x half> %val, ptr %ptr, <vscale x 4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpstore_nxv4f16_unit_stride:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e16, m1, ta, ma
; CHECK-NEXT:    vse16.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  call void @llvm.experimental.vp.strided.store.nxv4f16.p0.i32(<vscale x 4 x half> %val, ptr %ptr, i32 2, <vscale x 4 x i1> %m, i32 %evl)
  ret void
}

declare void @llvm.experimental.vp.strided.store.nxv8f16.p0.i32(<vscale x 8 x half>, ptr, i32, <vscale x 8 x i1>, i32)

define void @strided_vpstore_nxv8f16(<vscale x 8 x half> %val, ptr %ptr, i32 signext %strided, <vscale x 8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpstore_nxv8f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e16, m2, ta, ma
; CHECK-NEXT:    vsse16.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret
  call void @llvm.experimental.vp.strided.store.nxv8f16.p0.i32(<vscale x 8 x half> %val, ptr %ptr, i32 %strided, <vscale x 8 x i1> %m, i32 %evl)
  ret void
}

declare void @llvm.experimental.vp.strided.store.nxv1f32.p0.i32(<vscale x 1 x float>, ptr, i32, <vscale x 1 x i1>, i32)

define void @strided_vpstore_nxv1f32(<vscale x 1 x float> %val, ptr %ptr, i32 signext %strided, <vscale x 1 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpstore_nxv1f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e32, mf2, ta, ma
; CHECK-NEXT:    vsse32.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret
  call void @llvm.experimental.vp.strided.store.nxv1f32.p0.i32(<vscale x 1 x float> %val, ptr %ptr, i32 %strided, <vscale x 1 x i1> %m, i32 %evl)
  ret void
}

declare void @llvm.experimental.vp.strided.store.nxv2f32.p0.i32(<vscale x 2 x float>, ptr, i32, <vscale x 2 x i1>, i32)

define void @strided_vpstore_nxv2f32(<vscale x 2 x float> %val, ptr %ptr, i32 signext %strided, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpstore_nxv2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e32, m1, ta, ma
; CHECK-NEXT:    vsse32.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret
  call void @llvm.experimental.vp.strided.store.nxv2f32.p0.i32(<vscale x 2 x float> %val, ptr %ptr, i32 %strided, <vscale x 2 x i1> %m, i32 %evl)
  ret void
}

declare void @llvm.experimental.vp.strided.store.nxv4f32.p0.i32(<vscale x 4 x float>, ptr, i32, <vscale x 4 x i1>, i32)

define void @strided_vpstore_nxv4f32(<vscale x 4 x float> %val, ptr %ptr, i32 signext %strided, <vscale x 4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpstore_nxv4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e32, m2, ta, ma
; CHECK-NEXT:    vsse32.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret
  call void @llvm.experimental.vp.strided.store.nxv4f32.p0.i32(<vscale x 4 x float> %val, ptr %ptr, i32 %strided, <vscale x 4 x i1> %m, i32 %evl)
  ret void
}

define void @strided_vpstore_nxv4f32_unit_stride(<vscale x 4 x float> %val, ptr %ptr, <vscale x 4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpstore_nxv4f32_unit_stride:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e32, m2, ta, ma
; CHECK-NEXT:    vse32.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  call void @llvm.experimental.vp.strided.store.nxv4f32.p0.i32(<vscale x 4 x float> %val, ptr %ptr, i32 4, <vscale x 4 x i1> %m, i32 %evl)
  ret void
}

declare void @llvm.experimental.vp.strided.store.nxv8f32.p0.i32(<vscale x 8 x float>, ptr, i32, <vscale x 8 x i1>, i32)

define void @strided_vpstore_nxv8f32(<vscale x 8 x float> %val, ptr %ptr, i32 signext %strided, <vscale x 8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpstore_nxv8f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e32, m4, ta, ma
; CHECK-NEXT:    vsse32.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret
  call void @llvm.experimental.vp.strided.store.nxv8f32.p0.i32(<vscale x 8 x float> %val, ptr %ptr, i32 %strided, <vscale x 8 x i1> %m, i32 %evl)
  ret void
}

declare void @llvm.experimental.vp.strided.store.nxv1f64.p0.i32(<vscale x 1 x double>, ptr, i32, <vscale x 1 x i1>, i32)

define void @strided_vpstore_nxv1f64(<vscale x 1 x double> %val, ptr %ptr, i32 signext %strided, <vscale x 1 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpstore_nxv1f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e64, m1, ta, ma
; CHECK-NEXT:    vsse64.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret
  call void @llvm.experimental.vp.strided.store.nxv1f64.p0.i32(<vscale x 1 x double> %val, ptr %ptr, i32 %strided, <vscale x 1 x i1> %m, i32 %evl)
  ret void
}

define void @strided_vpstore_nxv1f64_unit_stride(<vscale x 1 x double> %val, ptr %ptr, <vscale x 1 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpstore_nxv1f64_unit_stride:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e64, m1, ta, ma
; CHECK-NEXT:    vse64.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  call void @llvm.experimental.vp.strided.store.nxv1f64.p0.i32(<vscale x 1 x double> %val, ptr %ptr, i32 8, <vscale x 1 x i1> %m, i32 %evl)
  ret void
}

declare void @llvm.experimental.vp.strided.store.nxv2f64.p0.i32(<vscale x 2 x double>, ptr, i32, <vscale x 2 x i1>, i32)

define void @strided_vpstore_nxv2f64(<vscale x 2 x double> %val, ptr %ptr, i32 signext %strided, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpstore_nxv2f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e64, m2, ta, ma
; CHECK-NEXT:    vsse64.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret
  call void @llvm.experimental.vp.strided.store.nxv2f64.p0.i32(<vscale x 2 x double> %val, ptr %ptr, i32 %strided, <vscale x 2 x i1> %m, i32 %evl)
  ret void
}

declare void @llvm.experimental.vp.strided.store.nxv4f64.p0.i32(<vscale x 4 x double>, ptr, i32, <vscale x 4 x i1>, i32)

define void @strided_vpstore_nxv4f64(<vscale x 4 x double> %val, ptr %ptr, i32 signext %strided, <vscale x 4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpstore_nxv4f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e64, m4, ta, ma
; CHECK-NEXT:    vsse64.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret
  call void @llvm.experimental.vp.strided.store.nxv4f64.p0.i32(<vscale x 4 x double> %val, ptr %ptr, i32 %strided, <vscale x 4 x i1> %m, i32 %evl)
  ret void
}

declare void @llvm.experimental.vp.strided.store.nxv8f64.p0.i32(<vscale x 8 x double>, ptr, i32, <vscale x 8 x i1>, i32)

define void @strided_vpstore_nxv8f64(<vscale x 8 x double> %val, ptr %ptr, i32 signext %strided, <vscale x 8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpstore_nxv8f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e64, m8, ta, ma
; CHECK-NEXT:    vsse64.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret
  call void @llvm.experimental.vp.strided.store.nxv8f64.p0.i32(<vscale x 8 x double> %val, ptr %ptr, i32 %strided, <vscale x 8 x i1> %m, i32 %evl)
  ret void
}

define void @strided_vpstore_nxv1i8_allones_mask(<vscale x 1 x i8> %val, ptr %ptr, i32 signext %strided, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpstore_nxv1i8_allones_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e8, mf8, ta, ma
; CHECK-NEXT:    vsse8.v v8, (a0), a1
; CHECK-NEXT:    ret
  call void @llvm.experimental.vp.strided.store.nxv1i8.p0.i32(<vscale x 1 x i8> %val, ptr %ptr, i32 %strided, <vscale x 1 x i1> splat (i1 true), i32 %evl)
  ret void
}

; Widening
define void @strided_vpstore_nxv3f32(<vscale x 3 x float> %v, ptr %ptr, i32 signext %stride, <vscale x 3 x i1> %mask, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpstore_nxv3f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e32, m2, ta, ma
; CHECK-NEXT:    vsse32.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret
  call void @llvm.experimental.vp.strided.store.nxv3f32.p0.i32(<vscale x 3 x float> %v, ptr %ptr, i32 %stride, <vscale x 3 x i1> %mask, i32 %evl)
  ret void
}

define void @strided_vpstore_nxv3f32_allones_mask(<vscale x 3 x float> %v, ptr %ptr, i32 signext %stride, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpstore_nxv3f32_allones_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e32, m2, ta, ma
; CHECK-NEXT:    vsse32.v v8, (a0), a1
; CHECK-NEXT:    ret
  call void @llvm.experimental.vp.strided.store.nxv3f32.p0.i32(<vscale x 3 x float> %v, ptr %ptr, i32 %stride, <vscale x 3 x i1> splat (i1 true), i32 %evl)
  ret void
}

declare void @llvm.experimental.vp.strided.store.nxv3f32.p0.i32(<vscale x 3 x float>, ptr , i32, <vscale x 3 x i1>, i32)

; Splitting
define void @strided_store_nxv16f64(<vscale x 16 x double> %v, ptr %ptr, i32 signext %stride, <vscale x 16 x i1> %mask, i32 zeroext %evl) {
; CHECK-LABEL: strided_store_nxv16f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a3, vlenb
; CHECK-NEXT:    mv a4, a2
; CHECK-NEXT:    bltu a2, a3, .LBB41_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a4, a3
; CHECK-NEXT:  .LBB41_2:
; CHECK-NEXT:    vsetvli zero, a4, e64, m8, ta, ma
; CHECK-NEXT:    vsse64.v v8, (a0), a1, v0.t
; CHECK-NEXT:    sub a5, a2, a3
; CHECK-NEXT:    sltu a2, a2, a5
; CHECK-NEXT:    addi a2, a2, -1
; CHECK-NEXT:    and a2, a2, a5
; CHECK-NEXT:    mul a4, a4, a1
; CHECK-NEXT:    srli a3, a3, 3
; CHECK-NEXT:    vsetvli a5, zero, e8, mf4, ta, ma
; CHECK-NEXT:    vslidedown.vx v0, v0, a3
; CHECK-NEXT:    add a0, a0, a4
; CHECK-NEXT:    vsetvli zero, a2, e64, m8, ta, ma
; CHECK-NEXT:    vsse64.v v16, (a0), a1, v0.t
; CHECK-NEXT:    ret
  call void @llvm.experimental.vp.strided.store.nxv16f64.p0.i32(<vscale x 16 x double> %v, ptr %ptr, i32 %stride, <vscale x 16 x i1> %mask, i32 %evl)
  ret void
}

define void @strided_store_nxv16f64_allones_mask(<vscale x 16 x double> %v, ptr %ptr, i32 signext %stride, i32 zeroext %evl) {
; CHECK-LABEL: strided_store_nxv16f64_allones_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a3, vlenb
; CHECK-NEXT:    mv a4, a2
; CHECK-NEXT:    bltu a2, a3, .LBB42_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a4, a3
; CHECK-NEXT:  .LBB42_2:
; CHECK-NEXT:    vsetvli zero, a4, e64, m8, ta, ma
; CHECK-NEXT:    vsse64.v v8, (a0), a1
; CHECK-NEXT:    sub a3, a2, a3
; CHECK-NEXT:    sltu a2, a2, a3
; CHECK-NEXT:    addi a2, a2, -1
; CHECK-NEXT:    and a2, a2, a3
; CHECK-NEXT:    mul a3, a4, a1
; CHECK-NEXT:    add a0, a0, a3
; CHECK-NEXT:    vsetvli zero, a2, e64, m8, ta, ma
; CHECK-NEXT:    vsse64.v v16, (a0), a1
; CHECK-NEXT:    ret
  call void @llvm.experimental.vp.strided.store.nxv16f64.p0.i32(<vscale x 16 x double> %v, ptr %ptr, i32 %stride, <vscale x 16 x i1> splat (i1 true), i32 %evl)
  ret void
}

declare void @llvm.experimental.vp.strided.store.nxv16f64.p0.i32(<vscale x 16 x double>, ptr, i32, <vscale x 16 x i1>, i32)

; Widening + splitting (with HiIsEmpty == true)
define void @strided_store_nxv17f64(<vscale x 17 x double> %v, ptr %ptr, i32 signext %stride, <vscale x 17 x i1> %mask, i32 zeroext %evl) {
; CHECK-LABEL: strided_store_nxv17f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a4, vlenb
; CHECK-NEXT:    slli a6, a4, 1
; CHECK-NEXT:    vmv1r.v v24, v0
; CHECK-NEXT:    mv a5, a3
; CHECK-NEXT:    bltu a3, a6, .LBB43_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a5, a6
; CHECK-NEXT:  .LBB43_2:
; CHECK-NEXT:    mv a7, a5
; CHECK-NEXT:    bltu a5, a4, .LBB43_4
; CHECK-NEXT:  # %bb.3:
; CHECK-NEXT:    mv a7, a4
; CHECK-NEXT:  .LBB43_4:
; CHECK-NEXT:    addi sp, sp, -16
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    csrr t0, vlenb
; CHECK-NEXT:    slli t0, t0, 3
; CHECK-NEXT:    sub sp, sp, t0
; CHECK-NEXT:    .cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x10, 0x22, 0x11, 0x08, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 16 + 8 * vlenb
; CHECK-NEXT:    vl8re64.v v0, (a0)
; CHECK-NEXT:    addi a0, sp, 16
; CHECK-NEXT:    vs8r.v v0, (a0) # Unknown-size Folded Spill
; CHECK-NEXT:    vmv1r.v v0, v24
; CHECK-NEXT:    vsetvli zero, a7, e64, m8, ta, ma
; CHECK-NEXT:    vsse64.v v8, (a1), a2, v0.t
; CHECK-NEXT:    sub a0, a5, a4
; CHECK-NEXT:    sltu t0, a5, a0
; CHECK-NEXT:    addi t0, t0, -1
; CHECK-NEXT:    and t0, t0, a0
; CHECK-NEXT:    mul a0, a7, a2
; CHECK-NEXT:    add a7, a1, a0
; CHECK-NEXT:    srli a0, a4, 3
; CHECK-NEXT:    vsetvli t1, zero, e8, mf4, ta, ma
; CHECK-NEXT:    vslidedown.vx v0, v24, a0
; CHECK-NEXT:    sub a0, a3, a6
; CHECK-NEXT:    sltu a3, a3, a0
; CHECK-NEXT:    addi a3, a3, -1
; CHECK-NEXT:    and a0, a3, a0
; CHECK-NEXT:    vsetvli zero, t0, e64, m8, ta, ma
; CHECK-NEXT:    vsse64.v v16, (a7), a2, v0.t
; CHECK-NEXT:    bltu a0, a4, .LBB43_6
; CHECK-NEXT:  # %bb.5:
; CHECK-NEXT:    mv a0, a4
; CHECK-NEXT:  .LBB43_6:
; CHECK-NEXT:    mul a3, a5, a2
; CHECK-NEXT:    srli a4, a4, 2
; CHECK-NEXT:    vsetvli a5, zero, e8, mf2, ta, ma
; CHECK-NEXT:    vslidedown.vx v0, v24, a4
; CHECK-NEXT:    add a1, a1, a3
; CHECK-NEXT:    addi a3, sp, 16
; CHECK-NEXT:    vl8r.v v8, (a3) # Unknown-size Folded Reload
; CHECK-NEXT:    vsetvli zero, a0, e64, m8, ta, ma
; CHECK-NEXT:    vsse64.v v8, (a1), a2, v0.t
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 3
; CHECK-NEXT:    add sp, sp, a0
; CHECK-NEXT:    addi sp, sp, 16
; CHECK-NEXT:    ret
  call void @llvm.experimental.vp.strided.store.nxv17f64.p0.i32(<vscale x 17 x double> %v, ptr %ptr, i32 %stride, <vscale x 17 x i1> %mask, i32 %evl)
  ret void
}

declare void @llvm.experimental.vp.strided.store.nxv17f64.p0.i32(<vscale x 17 x double>, ptr, i32, <vscale x 17 x i1>, i32)
