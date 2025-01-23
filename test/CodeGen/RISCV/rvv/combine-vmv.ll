; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: sed 's/iXLen/i32/g' %s | llc -mtriple=riscv32 -mattr=+v -verify-machineinstrs | FileCheck %s
; RUN: sed 's/iXLen/i64/g' %s | llc -mtriple=riscv64 -mattr=+v -verify-machineinstrs | FileCheck %s

declare <vscale x 4 x i32> @llvm.riscv.vmv.v.v.nxv4i32(<vscale x 4 x i32>, <vscale x 4 x i32>, iXLen)

declare <vscale x 4 x i32> @llvm.riscv.vadd.nxv4i32.nxv4i32(<vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, iXLen)

define <vscale x 4 x i32> @vadd(<vscale x 4 x i32> %passthru, <vscale x 4 x i32> %a, <vscale x 4 x i32> %b, iXLen %vl1, iXLen %vl2) {
; CHECK-LABEL: vadd:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m2, ta, ma
; CHECK-NEXT:    vadd.vv v10, v10, v12
; CHECK-NEXT:    vsetvli zero, a1, e32, m2, tu, ma
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    ret
  %v = call <vscale x 4 x i32> @llvm.riscv.vadd.nxv4i32.nxv4i32(<vscale x 4 x i32> poison, <vscale x 4 x i32> %a, <vscale x 4 x i32> %b, iXLen %vl1)
  %w = call <vscale x 4 x i32> @llvm.riscv.vmv.v.v.nxv4i32(<vscale x 4 x i32> %passthru, <vscale x 4 x i32> %v, iXLen %vl2)
  ret <vscale x 4 x i32> %w
}

define <vscale x 4 x i32> @vadd_mask(<vscale x 4 x i32> %passthru, <vscale x 4 x i32> %a, <vscale x 4 x i32> %b, <vscale x 4 x i1> %m, iXLen %vl) {
; CHECK-LABEL: vadd_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m2, tu, mu
; CHECK-NEXT:    vadd.vv v8, v10, v12, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 4 x i32> @llvm.riscv.vadd.mask.nxv4i32.nxv4i32(<vscale x 4 x i32> poison, <vscale x 4 x i32> %a, <vscale x 4 x i32> %b, <vscale x 4 x i1> %m, iXLen %vl, iXLen 3)
  %w = call <vscale x 4 x i32> @llvm.riscv.vmv.v.v.nxv4i32(<vscale x 4 x i32> %passthru, <vscale x 4 x i32> %v, iXLen %vl)
  ret <vscale x 4 x i32> %w
}

define <vscale x 4 x i32> @vadd_undef(<vscale x 4 x i32> %a, <vscale x 4 x i32> %b, iXLen %vl1, iXLen %vl2) {
; CHECK-LABEL: vadd_undef:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m2, ta, ma
; CHECK-NEXT:    vadd.vv v8, v8, v10
; CHECK-NEXT:    vsetvli zero, a1, e32, m2, ta, ma
; CHECK-NEXT:    vmv.v.v v8, v8
; CHECK-NEXT:    ret
  %v = call <vscale x 4 x i32> @llvm.riscv.vadd.nxv4i32.nxv4i32(<vscale x 4 x i32> poison, <vscale x 4 x i32> %a, <vscale x 4 x i32> %b, iXLen %vl1)
  %w = call <vscale x 4 x i32> @llvm.riscv.vmv.v.v.nxv4i32(<vscale x 4 x i32> poison, <vscale x 4 x i32> %v, iXLen %vl2)
  ret <vscale x 4 x i32> %w
}

; TODO: Is this correct if there's already a passthru in the src?
define <vscale x 4 x i32> @vadd_same_passthru(<vscale x 4 x i32> %passthru, <vscale x 4 x i32> %a, <vscale x 4 x i32> %b, iXLen %vl1, iXLen %vl2) {
; CHECK-LABEL: vadd_same_passthru:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv2r.v v14, v8
; CHECK-NEXT:    vsetvli zero, a0, e32, m2, tu, ma
; CHECK-NEXT:    vadd.vv v14, v10, v12
; CHECK-NEXT:    vsetvli zero, a1, e32, m2, tu, ma
; CHECK-NEXT:    vmv.v.v v8, v14
; CHECK-NEXT:    ret
  %v = call <vscale x 4 x i32> @llvm.riscv.vadd.nxv4i32.nxv4i32(<vscale x 4 x i32> %passthru, <vscale x 4 x i32> %a, <vscale x 4 x i32> %b, iXLen %vl1)
  %w = call <vscale x 4 x i32> @llvm.riscv.vmv.v.v.nxv4i32(<vscale x 4 x i32> %passthru, <vscale x 4 x i32> %v, iXLen %vl2)
  ret <vscale x 4 x i32> %w
}

declare <vscale x 4 x i32> @llvm.riscv.vadd.mask.nxv4i32.nxv4i32(<vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i1>, iXLen, iXLen)

define <vscale x 4 x i32> @vadd_mask_ma(<vscale x 4 x i32> %passthru, <vscale x 4 x i32> %a, <vscale x 4 x i32> %b, <vscale x 4 x i1> %mask, iXLen %vl1, iXLen %vl2) {
; CHECK-LABEL: vadd_mask_ma:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m2, ta, ma
; CHECK-NEXT:    vadd.vv v10, v10, v12, v0.t
; CHECK-NEXT:    vsetvli zero, a1, e32, m2, tu, ma
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    ret
  %v = call <vscale x 4 x i32> @llvm.riscv.vadd.mask.nxv4i32.nxv4i32(<vscale x 4 x i32> poison, <vscale x 4 x i32> %a, <vscale x 4 x i32> %b, <vscale x 4 x i1> %mask, iXLen %vl1, iXLen 2)
  %w = call <vscale x 4 x i32> @llvm.riscv.vmv.v.v.nxv4i32(<vscale x 4 x i32> %passthru, <vscale x 4 x i32> %v, iXLen %vl2)
  ret <vscale x 4 x i32> %w
}

define <vscale x 4 x i32> @vadd_mask_mu(<vscale x 4 x i32> %passthru, <vscale x 4 x i32> %a, <vscale x 4 x i32> %b, <vscale x 4 x i1> %mask, iXLen %vl1, iXLen %vl2) {
; CHECK-LABEL: vadd_mask_mu:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m2, ta, ma
; CHECK-NEXT:    vadd.vv v10, v10, v12, v0.t
; CHECK-NEXT:    vsetvli zero, a1, e32, m2, tu, ma
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    ret
  %v = call <vscale x 4 x i32> @llvm.riscv.vadd.mask.nxv4i32.nxv4i32(<vscale x 4 x i32> poison, <vscale x 4 x i32> %a, <vscale x 4 x i32> %b, <vscale x 4 x i1> %mask, iXLen %vl1, iXLen 0)
  %w = call <vscale x 4 x i32> @llvm.riscv.vmv.v.v.nxv4i32(<vscale x 4 x i32> %passthru, <vscale x 4 x i32> %v, iXLen %vl2)
  ret <vscale x 4 x i32> %w
}

declare <vscale x 4 x i32> @llvm.riscv.vle.nxv4i32(<vscale x 4 x i32>, ptr, iXLen)

define <vscale x 4 x i32> @foldable_load(<vscale x 4 x i32> %passthru, ptr %p) {
; CHECK-LABEL: foldable_load:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, m2, tu, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    ret
  %v = call <vscale x 4 x i32> @llvm.riscv.vle.nxv4i32(<vscale x 4 x i32> poison, ptr %p, iXLen 4)
  %w = call <vscale x 4 x i32> @llvm.riscv.vmv.v.v.nxv4i32(<vscale x 4 x i32> %passthru, <vscale x 4 x i32> %v, iXLen 2)
  ret <vscale x 4 x i32> %w
}

; Can't fold this as the VLs aren't constant.
define <vscale x 4 x i32> @unfoldable_load(<vscale x 4 x i32> %passthru, ptr %p, iXLen %vl1, iXLen %vl2) {
; CHECK-LABEL: unfoldable_load:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e32, m2, ta, ma
; CHECK-NEXT:    vle32.v v10, (a0)
; CHECK-NEXT:    vsetvli zero, a2, e32, m2, tu, ma
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    ret
  %v = call <vscale x 4 x i32> @llvm.riscv.vle.nxv4i32(<vscale x 4 x i32> poison, ptr %p, iXLen %vl1)
  %w = call <vscale x 4 x i32> @llvm.riscv.vmv.v.v.nxv4i32(<vscale x 4 x i32> %passthru, <vscale x 4 x i32> %v, iXLen %vl2)
  ret <vscale x 4 x i32> %w
}

declare <vscale x 4 x float> @llvm.riscv.vmv.v.v.nxv4f32(<vscale x 4 x float>, <vscale x 4 x float>, iXLen)

declare <vscale x 4 x float> @llvm.riscv.vfadd.nxv4f32.nxv4f32(<vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float>, iXLen, iXLen)

define <vscale x 4 x float> @unfoldable_vfadd(<vscale x 4 x float> %passthru, <vscale x 4 x float> %a, <vscale x 4 x float> %b, iXLen %vl1, iXLen %vl2) {
; CHECK-LABEL: unfoldable_vfadd:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m2, ta, ma
; CHECK-NEXT:    vfadd.vv v10, v10, v12
; CHECK-NEXT:    vsetvli zero, a1, e32, m2, tu, ma
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    ret
  %v = call <vscale x 4 x float> @llvm.riscv.vfadd.nxv4f32.nxv4f32(<vscale x 4 x float> poison, <vscale x 4 x float> %a, <vscale x 4 x float> %b, iXLen 7, iXLen %vl1)
  %w = call <vscale x 4 x float> @llvm.riscv.vmv.v.v.nxv4f32(<vscale x 4 x float> %passthru, <vscale x 4 x float> %v, iXLen %vl2)
  ret <vscale x 4 x float> %w
}

define <vscale x 4 x float> @foldable_vfadd(<vscale x 4 x float> %passthru, <vscale x 4 x float> %a, <vscale x 4 x float> %b, iXLen %vl) {
; CHECK-LABEL: foldable_vfadd:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m2, tu, ma
; CHECK-NEXT:    vfadd.vv v8, v10, v12
; CHECK-NEXT:    ret
  %v = call <vscale x 4 x float> @llvm.riscv.vfadd.nxv4f32.nxv4f32(<vscale x 4 x float> poison, <vscale x 4 x float> %a, <vscale x 4 x float> %b, iXLen 7, iXLen %vl)
  %w = call <vscale x 4 x float> @llvm.riscv.vmv.v.v.nxv4f32(<vscale x 4 x float> %passthru, <vscale x 4 x float> %v, iXLen %vl)
  ret <vscale x 4 x float> %w
}

; This shouldn't be folded because we need to preserve exceptions with
; "fpexcept.strict" exception behaviour, and changing the VL may hide them.
define <vscale x 4 x float> @unfoldable_constrained_fadd(<vscale x 4 x float> %passthru, <vscale x 4 x float> %x, <vscale x 4 x float> %y, iXLen %vl) strictfp {
; CHECK-LABEL: unfoldable_constrained_fadd:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e32, m2, ta, ma
; CHECK-NEXT:    vfadd.vv v10, v10, v12
; CHECK-NEXT:    vsetvli zero, a0, e32, m2, tu, ma
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    ret
  %a = call <vscale x 4 x float> @llvm.experimental.constrained.fadd(<vscale x 4 x float> %x, <vscale x 4 x float> %y, metadata !"round.dynamic", metadata !"fpexcept.strict") strictfp
  %b = call <vscale x 4 x float> @llvm.riscv.vmv.v.v.nxv4f32(<vscale x 4 x float> %passthru, <vscale x 4 x float> %a, iXLen %vl) strictfp
  ret <vscale x 4 x float> %b
}

define <vscale x 2 x i32> @unfoldable_vredsum(<vscale x 2 x i32> %passthru, <vscale x 4 x i32> %x, <vscale x 2 x i32> %y) {
; CHECK-LABEL: unfoldable_vredsum:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m2, ta, ma
; CHECK-NEXT:    vredsum.vs v9, v10, v9
; CHECK-NEXT:    vsetivli zero, 1, e32, m1, tu, ma
; CHECK-NEXT:    vmv.v.v v8, v9
; CHECK-NEXT:    ret
  %a = call <vscale x 2 x i32> @llvm.riscv.vredsum.nxv2i32.nxv4i32(<vscale x 2 x i32> poison, <vscale x 4 x i32> %x, <vscale x 2 x i32> %y, iXLen -1)
  %b = call <vscale x 2 x i32> @llvm.riscv.vmv.v.v.nxv2i32(<vscale x 2 x i32> %passthru, <vscale x 2 x i32> %a, iXLen 1)
  ret <vscale x 2 x i32> %b
}

define <vscale x 2 x i32> @unfoldable_mismatched_sew(<vscale x 2 x i32> %passthru, <vscale x 1 x i64> %x, <vscale x 1 x i64> %y, iXLen %avl) {
; CHECK-LABEL: unfoldable_mismatched_sew:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m1, ta, ma
; CHECK-NEXT:    vadd.vv v9, v9, v10
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, tu, ma
; CHECK-NEXT:    vmv.v.v v8, v9
; CHECK-NEXT:    ret
  %a = call <vscale x 1 x i64> @llvm.riscv.vadd.nxv1i64.nxv1i64(<vscale x 1 x i64> poison, <vscale x 1 x i64> %x, <vscale x 1 x i64> %y, iXLen %avl)
  %a.bitcast = bitcast <vscale x 1 x i64> %a to <vscale x 2 x i32>
  %b = call <vscale x 2 x i32> @llvm.riscv.vmv.v.v.nxv2i32(<vscale x 2 x i32> %passthru, <vscale x 2 x i32> %a.bitcast, iXLen %avl)
  ret <vscale x 2 x i32> %b
}
