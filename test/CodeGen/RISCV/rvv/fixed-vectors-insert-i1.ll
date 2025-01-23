; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+v -verify-machineinstrs < %s | FileCheck %s
; RUN: llc -mtriple=riscv64 -mattr=+v -verify-machineinstrs < %s | FileCheck %s

define <1 x i1> @insertelt_v1i1(<1 x i1> %x, i1 %elt) nounwind {
; CHECK-LABEL: insertelt_v1i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    andi a0, a0, 1
; CHECK-NEXT:    vsetivli zero, 1, e8, mf8, ta, ma
; CHECK-NEXT:    vmv.s.x v8, a0
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
  %y = insertelement <1 x i1> %x, i1 %elt, i64 0
  ret <1 x i1> %y
}

define <1 x i1> @insertelt_idx_v1i1(<1 x i1> %x, i1 %elt, i32 zeroext %idx) nounwind {
; CHECK-LABEL: insertelt_idx_v1i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e8, mf8, ta, ma
; CHECK-NEXT:    vmv.s.x v8, zero
; CHECK-NEXT:    vmerge.vim v8, v8, 1, v0
; CHECK-NEXT:    addi a2, a1, 1
; CHECK-NEXT:    vmv.s.x v9, a0
; CHECK-NEXT:    vsetvli zero, a2, e8, mf8, tu, ma
; CHECK-NEXT:    vslideup.vx v8, v9, a1
; CHECK-NEXT:    vsetivli zero, 1, e8, mf8, ta, ma
; CHECK-NEXT:    vand.vi v8, v8, 1
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
  %y = insertelement <1 x i1> %x, i1 %elt, i32 %idx
  ret <1 x i1> %y
}

define <2 x i1> @insertelt_v2i1(<2 x i1> %x, i1 %elt) nounwind {
; CHECK-LABEL: insertelt_v2i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e8, mf8, ta, ma
; CHECK-NEXT:    vmv.v.i v8, 0
; CHECK-NEXT:    vmerge.vim v8, v8, 1, v0
; CHECK-NEXT:    vmv.s.x v9, a0
; CHECK-NEXT:    vslideup.vi v8, v9, 1
; CHECK-NEXT:    vand.vi v8, v8, 1
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
  %y = insertelement <2 x i1> %x, i1 %elt, i64 1
  ret <2 x i1> %y
}

define <2 x i1> @insertelt_idx_v2i1(<2 x i1> %x, i1 %elt, i32 zeroext %idx) nounwind {
; CHECK-LABEL: insertelt_idx_v2i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e8, mf8, ta, ma
; CHECK-NEXT:    vmv.v.i v8, 0
; CHECK-NEXT:    vmerge.vim v8, v8, 1, v0
; CHECK-NEXT:    addi a2, a1, 1
; CHECK-NEXT:    vmv.s.x v9, a0
; CHECK-NEXT:    vsetvli zero, a2, e8, mf8, tu, ma
; CHECK-NEXT:    vslideup.vx v8, v9, a1
; CHECK-NEXT:    vsetivli zero, 2, e8, mf8, ta, ma
; CHECK-NEXT:    vand.vi v8, v8, 1
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
  %y = insertelement <2 x i1> %x, i1 %elt, i32 %idx
  ret <2 x i1> %y
}

define <8 x i1> @insertelt_v8i1(<8 x i1> %x, i1 %elt) nounwind {
; CHECK-LABEL: insertelt_v8i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vmv.v.i v8, 0
; CHECK-NEXT:    vmerge.vim v8, v8, 1, v0
; CHECK-NEXT:    vmv.s.x v9, a0
; CHECK-NEXT:    vsetivli zero, 2, e8, mf2, tu, ma
; CHECK-NEXT:    vslideup.vi v8, v9, 1
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vand.vi v8, v8, 1
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
  %y = insertelement <8 x i1> %x, i1 %elt, i64 1
  ret <8 x i1> %y
}

define <8 x i1> @insertelt_idx_v8i1(<8 x i1> %x, i1 %elt, i32 zeroext %idx) nounwind {
; CHECK-LABEL: insertelt_idx_v8i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vmv.v.i v8, 0
; CHECK-NEXT:    vmerge.vim v8, v8, 1, v0
; CHECK-NEXT:    addi a2, a1, 1
; CHECK-NEXT:    vmv.s.x v9, a0
; CHECK-NEXT:    vsetvli zero, a2, e8, mf2, tu, ma
; CHECK-NEXT:    vslideup.vx v8, v9, a1
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vand.vi v8, v8, 1
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
  %y = insertelement <8 x i1> %x, i1 %elt, i32 %idx
  ret <8 x i1> %y
}

define <64 x i1> @insertelt_v64i1(<64 x i1> %x, i1 %elt) nounwind {
; CHECK-LABEL: insertelt_v64i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a1, 64
; CHECK-NEXT:    vsetvli zero, a1, e8, m4, ta, ma
; CHECK-NEXT:    vmv.v.i v8, 0
; CHECK-NEXT:    vmerge.vim v8, v8, 1, v0
; CHECK-NEXT:    vmv.s.x v12, a0
; CHECK-NEXT:    vsetivli zero, 2, e8, m1, tu, ma
; CHECK-NEXT:    vslideup.vi v8, v12, 1
; CHECK-NEXT:    vsetvli zero, a1, e8, m4, ta, ma
; CHECK-NEXT:    vand.vi v8, v8, 1
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
  %y = insertelement <64 x i1> %x, i1 %elt, i64 1
  ret <64 x i1> %y
}

define <64 x i1> @insertelt_idx_v64i1(<64 x i1> %x, i1 %elt, i32 zeroext %idx) nounwind {
; CHECK-LABEL: insertelt_idx_v64i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a2, 64
; CHECK-NEXT:    vsetvli zero, a2, e8, m4, ta, ma
; CHECK-NEXT:    vmv.v.i v8, 0
; CHECK-NEXT:    vmerge.vim v8, v8, 1, v0
; CHECK-NEXT:    vmv.s.x v12, a0
; CHECK-NEXT:    addi a0, a1, 1
; CHECK-NEXT:    vsetvli zero, a0, e8, m4, tu, ma
; CHECK-NEXT:    vslideup.vx v8, v12, a1
; CHECK-NEXT:    vsetvli zero, a2, e8, m4, ta, ma
; CHECK-NEXT:    vand.vi v8, v8, 1
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
  %y = insertelement <64 x i1> %x, i1 %elt, i32 %idx
  ret <64 x i1> %y
}
