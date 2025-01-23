; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+v -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK

declare <vscale x 2 x i64> @llvm.bitreverse.nxv2i64(<vscale x 2 x i64>)

define i32 @splat_vector_split_i64() {
; CHECK-LABEL: splat_vector_split_i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi sp, sp, -16
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    vsetvli a0, zero, e64, m1, ta, ma
; CHECK-NEXT:    vmv.v.i v10, 3
; CHECK-NEXT:    vsetvli a0, zero, e64, m2, ta, ma
; CHECK-NEXT:    vmv.v.i v8, 0
; CHECK-NEXT:    vsetivli zero, 4, e64, m2, tu, ma
; CHECK-NEXT:    vslideup.vi v8, v10, 3
; CHECK-NEXT:    sw zero, 12(sp)
; CHECK-NEXT:    lui a0, 1044480
; CHECK-NEXT:    sw a0, 8(sp)
; CHECK-NEXT:    li a0, 56
; CHECK-NEXT:    vsetvli a1, zero, e64, m2, ta, ma
; CHECK-NEXT:    vsrl.vx v10, v8, a0
; CHECK-NEXT:    li a1, 40
; CHECK-NEXT:    vsrl.vx v12, v8, a1
; CHECK-NEXT:    lui a2, 16
; CHECK-NEXT:    addi a2, a2, -256
; CHECK-NEXT:    vand.vx v12, v12, a2
; CHECK-NEXT:    vor.vv v10, v12, v10
; CHECK-NEXT:    vsrl.vi v12, v8, 24
; CHECK-NEXT:    addi a3, sp, 8
; CHECK-NEXT:    vlse64.v v14, (a3), zero
; CHECK-NEXT:    lui a3, 4080
; CHECK-NEXT:    vand.vx v12, v12, a3
; CHECK-NEXT:    vsrl.vi v16, v8, 8
; CHECK-NEXT:    vand.vv v16, v16, v14
; CHECK-NEXT:    vor.vv v12, v16, v12
; CHECK-NEXT:    vor.vv v10, v12, v10
; CHECK-NEXT:    vand.vv v12, v8, v14
; CHECK-NEXT:    vsll.vi v12, v12, 8
; CHECK-NEXT:    vand.vx v14, v8, a3
; CHECK-NEXT:    vsll.vi v14, v14, 24
; CHECK-NEXT:    vor.vv v12, v14, v12
; CHECK-NEXT:    vsll.vx v14, v8, a0
; CHECK-NEXT:    vand.vx v8, v8, a2
; CHECK-NEXT:    vsll.vx v8, v8, a1
; CHECK-NEXT:    vor.vv v8, v14, v8
; CHECK-NEXT:    vor.vv v8, v8, v12
; CHECK-NEXT:    vor.vv v8, v8, v10
; CHECK-NEXT:    vsrl.vi v10, v8, 4
; CHECK-NEXT:    lui a0, 61681
; CHECK-NEXT:    addi a0, a0, -241
; CHECK-NEXT:    vsetvli a1, zero, e32, m2, ta, ma
; CHECK-NEXT:    vmv.v.x v12, a0
; CHECK-NEXT:    vsetvli a0, zero, e64, m2, ta, ma
; CHECK-NEXT:    vand.vv v10, v10, v12
; CHECK-NEXT:    vand.vv v8, v8, v12
; CHECK-NEXT:    vsll.vi v8, v8, 4
; CHECK-NEXT:    vor.vv v8, v10, v8
; CHECK-NEXT:    vsrl.vi v10, v8, 2
; CHECK-NEXT:    lui a0, 209715
; CHECK-NEXT:    addi a0, a0, 819
; CHECK-NEXT:    vsetvli a1, zero, e32, m2, ta, ma
; CHECK-NEXT:    vmv.v.x v12, a0
; CHECK-NEXT:    vsetvli a0, zero, e64, m2, ta, ma
; CHECK-NEXT:    vand.vv v10, v10, v12
; CHECK-NEXT:    vand.vv v8, v8, v12
; CHECK-NEXT:    vsll.vi v8, v8, 2
; CHECK-NEXT:    vor.vv v8, v10, v8
; CHECK-NEXT:    vsrl.vi v10, v8, 1
; CHECK-NEXT:    lui a0, 349525
; CHECK-NEXT:    addi a0, a0, 1365
; CHECK-NEXT:    vsetvli a1, zero, e32, m2, ta, ma
; CHECK-NEXT:    vmv.v.x v12, a0
; CHECK-NEXT:    vsetvli a0, zero, e64, m2, ta, ma
; CHECK-NEXT:    vand.vv v10, v10, v12
; CHECK-NEXT:    vand.vv v8, v8, v12
; CHECK-NEXT:    vadd.vv v8, v8, v8
; CHECK-NEXT:    vor.vv v8, v10, v8
; CHECK-NEXT:    vslidedown.vi v8, v8, 3
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    addi sp, sp, 16
; CHECK-NEXT:    ret
    %1 = insertelement <vscale x 2 x i64> zeroinitializer, i64 3, i64 3
    %2 = tail call <vscale x 2 x i64> @llvm.bitreverse.nxv2i64(<vscale x 2 x i64> %1)
    %3 = extractelement <vscale x 2 x i64> %2, i32 3
    %4 = trunc i64 %3 to i32
    ret i32 %4
}
