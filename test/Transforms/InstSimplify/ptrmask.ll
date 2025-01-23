; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 2
; RUN: opt < %s -passes=instsimplify -S | FileCheck %s

target datalayout = "p1:64:64:64:32"

declare ptr addrspace(1) @llvm.ptrmask.p1.i32(ptr addrspace(1) , i32)
declare ptr @llvm.ptrmask.p0.i64(ptr, i64)

declare <2 x ptr addrspace(1) > @llvm.ptrmask.v2p1.v2i32(<2 x ptr addrspace(1) >, <2 x i32>)
declare <2 x ptr> @llvm.ptrmask.v2p1.v2i64(<2 x ptr>, <2 x i64>)

define ptr @ptrmask_simplify_poison_mask(ptr %p) {
; CHECK-LABEL: define ptr @ptrmask_simplify_poison_mask
; CHECK-SAME: (ptr [[P:%.*]]) {
; CHECK-NEXT:    ret ptr poison
;
  %r = call ptr @llvm.ptrmask.p0.i64(ptr %p, i64 poison)
  ret ptr %r
}

define <2 x ptr addrspace(1) > @ptrmask_simplify_poison_mask_vec(<2 x ptr addrspace(1) > %p) {
; CHECK-LABEL: define <2 x ptr addrspace(1)> @ptrmask_simplify_poison_mask_vec
; CHECK-SAME: (<2 x ptr addrspace(1)> [[P:%.*]]) {
; CHECK-NEXT:    ret <2 x ptr addrspace(1)> poison
;
  %r = call <2 x ptr addrspace(1) > @llvm.ptrmask.v2p1.v2i32(<2 x ptr addrspace(1) > %p, <2 x i32> poison)
  ret <2 x ptr addrspace(1) > %r
}

define <2 x ptr addrspace(1) > @ptrmask_simplify_poison_and_zero_i32_vec_fail(<2 x ptr addrspace(1) > %p) {
; CHECK-LABEL: define <2 x ptr addrspace(1)> @ptrmask_simplify_poison_and_zero_i32_vec_fail
; CHECK-SAME: (<2 x ptr addrspace(1)> [[P:%.*]]) {
; CHECK-NEXT:    [[R:%.*]] = call <2 x ptr addrspace(1)> @llvm.ptrmask.v2p1.v2i32(<2 x ptr addrspace(1)> [[P]], <2 x i32> <i32 undef, i32 0>)
; CHECK-NEXT:    ret <2 x ptr addrspace(1)> [[R]]
;
  %r = call <2 x ptr addrspace(1) > @llvm.ptrmask.v2p1.v2i32(<2 x ptr addrspace(1) > %p, <2 x i32> <i32 undef, i32 0>)
  ret <2 x ptr addrspace(1) > %r
}

define <2 x ptr> @ptrmask_simplify_undef_and_ones_vec(<2 x ptr> %p) {
; CHECK-LABEL: define <2 x ptr> @ptrmask_simplify_undef_and_ones_vec
; CHECK-SAME: (<2 x ptr> [[P:%.*]]) {
; CHECK-NEXT:    [[R:%.*]] = call <2 x ptr> @llvm.ptrmask.v2p0.v2i64(<2 x ptr> [[P]], <2 x i64> <i64 undef, i64 -1>)
; CHECK-NEXT:    ret <2 x ptr> [[R]]
;
  %r = call <2 x ptr> @llvm.ptrmask.v2p1.v2i64(<2 x ptr> %p, <2 x i64> <i64 undef, i64 -1>)
  ret <2 x ptr> %r
}

define <2 x ptr> @ptrmask_simplify_poison_and_ones_vec(<2 x ptr> %p) {
; CHECK-LABEL: define <2 x ptr> @ptrmask_simplify_poison_and_ones_vec
; CHECK-SAME: (<2 x ptr> [[P:%.*]]) {
; CHECK-NEXT:    ret <2 x ptr> [[P]]
;
  %r = call <2 x ptr> @llvm.ptrmask.v2p1.v2i64(<2 x ptr> %p, <2 x i64> <i64 poison, i64 -1>)
  ret <2 x ptr> %r
}

define <2 x ptr> @ptrmask_simplify_ones_vec(<2 x ptr> %p) {
; CHECK-LABEL: define <2 x ptr> @ptrmask_simplify_ones_vec
; CHECK-SAME: (<2 x ptr> [[P:%.*]]) {
; CHECK-NEXT:    ret <2 x ptr> [[P]]
;
  %r = call <2 x ptr> @llvm.ptrmask.v2p1.v2i64(<2 x ptr> %p, <2 x i64> <i64 -1, i64 -1>)
  ret <2 x ptr> %r
}

define <2 x ptr addrspace(1) > @ptrmask_simplify_ones_i32_vec(<2 x ptr addrspace(1) > %p) {
; CHECK-LABEL: define <2 x ptr addrspace(1)> @ptrmask_simplify_ones_i32_vec
; CHECK-SAME: (<2 x ptr addrspace(1)> [[P:%.*]]) {
; CHECK-NEXT:    ret <2 x ptr addrspace(1)> [[P]]
;
  %r = call <2 x ptr addrspace(1) > @llvm.ptrmask.v2p1.v2i32(<2 x ptr addrspace(1) > %p, <2 x i32> <i32 -1, i32 -1>)
  ret <2 x ptr addrspace(1) > %r
}

define ptr addrspace(1) @ptrmask_simplify_undef_mask(ptr addrspace(1) %p) {
; CHECK-LABEL: define ptr addrspace(1) @ptrmask_simplify_undef_mask
; CHECK-SAME: (ptr addrspace(1) [[P:%.*]]) {
; CHECK-NEXT:    ret ptr addrspace(1) [[P]]
;
  %r = call ptr addrspace(1) @llvm.ptrmask.p1.i32(ptr addrspace(1) %p, i32 undef)
  ret ptr addrspace(1) %r
}

define ptr @ptrmask_simplify_0_mask(ptr %p) {
; CHECK-LABEL: define ptr @ptrmask_simplify_0_mask
; CHECK-SAME: (ptr [[P:%.*]]) {
; CHECK-NEXT:    [[R:%.*]] = call ptr @llvm.ptrmask.p0.i64(ptr [[P]], i64 0)
; CHECK-NEXT:    ret ptr [[R]]
;
  %r = call ptr @llvm.ptrmask.p0.i64(ptr %p, i64 0)
  ret ptr %r
}

define ptr @ptrmask_simplify_1s_mask(ptr %p) {
; CHECK-LABEL: define ptr @ptrmask_simplify_1s_mask
; CHECK-SAME: (ptr [[P:%.*]]) {
; CHECK-NEXT:    ret ptr [[P]]
;
  %r = call ptr @llvm.ptrmask.p0.i64(ptr %p, i64 -1)
  ret ptr %r
}

define ptr addrspace(1) @ptrmask_simplify_1s_mask_i32(ptr addrspace(1) %p) {
; CHECK-LABEL: define ptr addrspace(1) @ptrmask_simplify_1s_mask_i32
; CHECK-SAME: (ptr addrspace(1) [[P:%.*]]) {
; CHECK-NEXT:    ret ptr addrspace(1) [[P]]
;
  %r = call ptr addrspace(1) @llvm.ptrmask.p1.i32(ptr addrspace(1) %p, i32 -1)
  ret ptr addrspace(1) %r
}

define ptr @ptrmask_simplify_poison_ptr(i64 %m) {
; CHECK-LABEL: define ptr @ptrmask_simplify_poison_ptr
; CHECK-SAME: (i64 [[M:%.*]]) {
; CHECK-NEXT:    ret ptr poison
;
  %r = call ptr @llvm.ptrmask.p0.i64(ptr poison, i64 %m)
  ret ptr %r
}

define ptr addrspace(1) @ptrmask_simplify_undef_ptr(i32 %m) {
; CHECK-LABEL: define ptr addrspace(1) @ptrmask_simplify_undef_ptr
; CHECK-SAME: (i32 [[M:%.*]]) {
; CHECK-NEXT:    ret ptr addrspace(1) null
;
  %r = call ptr addrspace(1) @llvm.ptrmask.p1.i32(ptr addrspace(1) undef, i32 %m)
  ret ptr addrspace(1) %r
}

define ptr @ptrmask_simplify_null_ptr(i64 %m) {
; CHECK-LABEL: define ptr @ptrmask_simplify_null_ptr
; CHECK-SAME: (i64 [[M:%.*]]) {
; CHECK-NEXT:    ret ptr null
;
  %r = call ptr @llvm.ptrmask.p0.i64(ptr null, i64 %m)
  ret ptr %r
}

define ptr @ptrmask_simplify_ptrmask(ptr %p) {
; CHECK-LABEL: define ptr @ptrmask_simplify_ptrmask
; CHECK-SAME: (ptr [[P:%.*]]) {
; CHECK-NEXT:    ret ptr [[P]]
;
  %m = ptrtoint ptr %p to i64
  %r = call ptr @llvm.ptrmask.p0.i64(ptr %p, i64 %m)
  ret ptr %r
}

define ptr addrspace(1) @ptrmask_simplify_ptrmask_i32(ptr addrspace(1) %p) {
; CHECK-LABEL: define ptr addrspace(1) @ptrmask_simplify_ptrmask_i32
; CHECK-SAME: (ptr addrspace(1) [[P:%.*]]) {
; CHECK-NEXT:    ret ptr addrspace(1) [[P]]
;
  %m = ptrtoint ptr addrspace(1) %p to i32
  %r = call ptr addrspace(1) @llvm.ptrmask.p1.i32(ptr addrspace(1) %p, i32 %m)
  ret ptr addrspace(1) %r
}

define ptr @ptrmask_simplify_aligned_unused(ptr align 64 %p) {
; CHECK-LABEL: define ptr @ptrmask_simplify_aligned_unused
; CHECK-SAME: (ptr align 64 [[P:%.*]]) {
; CHECK-NEXT:    ret ptr [[P]]
;
  %r = call ptr @llvm.ptrmask.p0.i64(ptr %p, i64 -64)
  ret ptr %r
}

define <2 x ptr> @ptrmask_simplify_aligned_unused_vec(<2 x ptr> align 128 %p) {
; CHECK-LABEL: define <2 x ptr> @ptrmask_simplify_aligned_unused_vec
; CHECK-SAME: (<2 x ptr> align 128 [[P:%.*]]) {
; CHECK-NEXT:    [[R:%.*]] = call <2 x ptr> @llvm.ptrmask.v2p0.v2i64(<2 x ptr> [[P]], <2 x i64> <i64 -64, i64 -64>)
; CHECK-NEXT:    ret <2 x ptr> [[R]]
;
  %r = call <2 x ptr> @llvm.ptrmask.v2p1.v2i64(<2 x ptr> %p, <2 x i64> <i64 -64, i64 -64>)
  ret <2 x ptr> %r
}

define <2 x ptr> @ptrmask_simplify_aligned_unused_vec_todo(<2 x ptr> align 128 %p) {
; CHECK-LABEL: define <2 x ptr> @ptrmask_simplify_aligned_unused_vec_todo
; CHECK-SAME: (<2 x ptr> align 128 [[P:%.*]]) {
; CHECK-NEXT:    [[R:%.*]] = call <2 x ptr> @llvm.ptrmask.v2p0.v2i64(<2 x ptr> [[P]], <2 x i64> <i64 -64, i64 -128>)
; CHECK-NEXT:    ret <2 x ptr> [[R]]
;
  %r = call <2 x ptr> @llvm.ptrmask.v2p1.v2i64(<2 x ptr> %p, <2 x i64> <i64 -64, i64 -128>)
  ret <2 x ptr> %r
}

define ptr addrspace(1) @ptrmask_simplify_aligned_unused_i32(ptr addrspace(1) align 64 %p) {
; CHECK-LABEL: define ptr addrspace(1) @ptrmask_simplify_aligned_unused_i32
; CHECK-SAME: (ptr addrspace(1) align 64 [[P:%.*]]) {
; CHECK-NEXT:    ret ptr addrspace(1) [[P]]
;
  %r = call ptr addrspace(1) @llvm.ptrmask.p1.i32(ptr addrspace(1) %p, i32 -64)
  ret ptr addrspace(1) %r
}

define ptr @ptrmask_simplify_known_unused(ptr %p) {
; CHECK-LABEL: define ptr @ptrmask_simplify_known_unused
; CHECK-SAME: (ptr [[P:%.*]]) {
; CHECK-NEXT:    [[PM0:%.*]] = call ptr @llvm.ptrmask.p0.i64(ptr [[P]], i64 -64)
; CHECK-NEXT:    [[PGEP:%.*]] = getelementptr i8, ptr [[PM0]], i64 32
; CHECK-NEXT:    ret ptr [[PGEP]]
;
  %pm0 = call ptr @llvm.ptrmask.p0.i64(ptr %p, i64 -64)
  %pgep = getelementptr i8, ptr %pm0, i64 32
  %r = call ptr @llvm.ptrmask.p0.i64(ptr %pgep, i64 -32)
  ret ptr %r
}

define <2 x ptr> @ptrmask_simplify_known_unused_vec(<2 x ptr> %p) {
; CHECK-LABEL: define <2 x ptr> @ptrmask_simplify_known_unused_vec
; CHECK-SAME: (<2 x ptr> [[P:%.*]]) {
; CHECK-NEXT:    [[PM0:%.*]] = call <2 x ptr> @llvm.ptrmask.v2p0.v2i64(<2 x ptr> [[P]], <2 x i64> <i64 -64, i64 -64>)
; CHECK-NEXT:    [[PGEP:%.*]] = getelementptr i8, <2 x ptr> [[PM0]], <2 x i64> <i64 32, i64 32>
; CHECK-NEXT:    ret <2 x ptr> [[PGEP]]
;
  %pm0 = call <2 x ptr> @llvm.ptrmask.v2p1.v2i64(<2 x ptr> %p, <2 x i64> <i64 -64, i64 -64>)
  %pgep = getelementptr i8, <2 x ptr> %pm0, <2 x i64> <i64 32, i64 32>
  %r = call <2 x ptr> @llvm.ptrmask.v2p1.v2i64(<2 x ptr> %pgep, <2 x i64> <i64 -32, i64 -32>)
  ret <2 x ptr> %r
}

define <2 x ptr> @ptrmask_simplify_known_unused_vec2(<2 x ptr> %p) {
; CHECK-LABEL: define <2 x ptr> @ptrmask_simplify_known_unused_vec2
; CHECK-SAME: (<2 x ptr> [[P:%.*]]) {
; CHECK-NEXT:    [[PM0:%.*]] = call <2 x ptr> @llvm.ptrmask.v2p0.v2i64(<2 x ptr> [[P]], <2 x i64> <i64 -64, i64 -64>)
; CHECK-NEXT:    [[PGEP:%.*]] = getelementptr i8, <2 x ptr> [[PM0]], <2 x i64> <i64 32, i64 32>
; CHECK-NEXT:    ret <2 x ptr> [[PGEP]]
;
  %pm0 = call <2 x ptr> @llvm.ptrmask.v2p1.v2i64(<2 x ptr> %p, <2 x i64> <i64 -64, i64 -64>)
  %pgep = getelementptr i8, <2 x ptr> %pm0, <2 x i64> <i64 32, i64 32>
  %r = call <2 x ptr> @llvm.ptrmask.v2p1.v2i64(<2 x ptr> %pgep, <2 x i64> <i64 -32, i64 -16>)
  ret <2 x ptr> %r
}

define <2 x ptr> @ptrmask_simplify_known_unused_vec3(<2 x ptr> %p) {
; CHECK-LABEL: define <2 x ptr> @ptrmask_simplify_known_unused_vec3
; CHECK-SAME: (<2 x ptr> [[P:%.*]]) {
; CHECK-NEXT:    [[PM0:%.*]] = call <2 x ptr> @llvm.ptrmask.v2p0.v2i64(<2 x ptr> [[P]], <2 x i64> <i64 -64, i64 -128>)
; CHECK-NEXT:    [[PGEP:%.*]] = getelementptr i8, <2 x ptr> [[PM0]], <2 x i64> <i64 32, i64 32>
; CHECK-NEXT:    ret <2 x ptr> [[PGEP]]
;
  %pm0 = call <2 x ptr> @llvm.ptrmask.v2p1.v2i64(<2 x ptr> %p, <2 x i64> <i64 -64, i64 -128>)
  %pgep = getelementptr i8, <2 x ptr> %pm0, <2 x i64> <i64 32, i64 32>
  %r = call <2 x ptr> @llvm.ptrmask.v2p1.v2i64(<2 x ptr> %pgep, <2 x i64> <i64 -32, i64 -32>)
  ret <2 x ptr> %r
}

define <2 x ptr> @ptrmask_simplify_known_unused_vec4(<2 x ptr> %p) {
; CHECK-LABEL: define <2 x ptr> @ptrmask_simplify_known_unused_vec4
; CHECK-SAME: (<2 x ptr> [[P:%.*]]) {
; CHECK-NEXT:    [[PM0:%.*]] = call <2 x ptr> @llvm.ptrmask.v2p0.v2i64(<2 x ptr> [[P]], <2 x i64> <i64 -64, i64 -128>)
; CHECK-NEXT:    [[PGEP:%.*]] = getelementptr i8, <2 x ptr> [[PM0]], <2 x i64> <i64 32, i64 64>
; CHECK-NEXT:    ret <2 x ptr> [[PGEP]]
;
  %pm0 = call <2 x ptr> @llvm.ptrmask.v2p1.v2i64(<2 x ptr> %p, <2 x i64> <i64 -64, i64 -128>)
  %pgep = getelementptr i8, <2 x ptr> %pm0, <2 x i64> <i64 32, i64 64>
  %r = call <2 x ptr> @llvm.ptrmask.v2p1.v2i64(<2 x ptr> %pgep, <2 x i64> <i64 -32, i64 -32>)
  ret <2 x ptr> %r
}

define <2 x ptr> @ptrmask_simplify_known_unused_vec_fail(<2 x ptr> %p) {
; CHECK-LABEL: define <2 x ptr> @ptrmask_simplify_known_unused_vec_fail
; CHECK-SAME: (<2 x ptr> [[P:%.*]]) {
; CHECK-NEXT:    [[PM0:%.*]] = call <2 x ptr> @llvm.ptrmask.v2p0.v2i64(<2 x ptr> [[P]], <2 x i64> <i64 -64, i64 -128>)
; CHECK-NEXT:    [[PGEP:%.*]] = getelementptr i8, <2 x ptr> [[PM0]], <2 x i64> <i64 16, i64 64>
; CHECK-NEXT:    [[R:%.*]] = call <2 x ptr> @llvm.ptrmask.v2p0.v2i64(<2 x ptr> [[PGEP]], <2 x i64> <i64 -32, i64 -32>)
; CHECK-NEXT:    ret <2 x ptr> [[R]]
;
  %pm0 = call <2 x ptr> @llvm.ptrmask.v2p1.v2i64(<2 x ptr> %p, <2 x i64> <i64 -64, i64 -128>)
  %pgep = getelementptr i8, <2 x ptr> %pm0, <2 x i64> <i64 16, i64 64>
  %r = call <2 x ptr> @llvm.ptrmask.v2p1.v2i64(<2 x ptr> %pgep, <2 x i64> <i64 -32, i64 -32>)
  ret <2 x ptr> %r
}

define <2 x ptr> @ptrmask_simplify_known_unused_vec_fail2(<2 x ptr> %p) {
; CHECK-LABEL: define <2 x ptr> @ptrmask_simplify_known_unused_vec_fail2
; CHECK-SAME: (<2 x ptr> [[P:%.*]]) {
; CHECK-NEXT:    [[PM0:%.*]] = call <2 x ptr> @llvm.ptrmask.v2p0.v2i64(<2 x ptr> [[P]], <2 x i64> <i64 -64, i64 -64>)
; CHECK-NEXT:    [[PGEP:%.*]] = getelementptr i8, <2 x ptr> [[PM0]], <2 x i64> <i64 32, i64 32>
; CHECK-NEXT:    [[R:%.*]] = call <2 x ptr> @llvm.ptrmask.v2p0.v2i64(<2 x ptr> [[PGEP]], <2 x i64> <i64 -32, i64 -64>)
; CHECK-NEXT:    ret <2 x ptr> [[R]]
;
  %pm0 = call <2 x ptr> @llvm.ptrmask.v2p1.v2i64(<2 x ptr> %p, <2 x i64> <i64 -64, i64 -64>)
  %pgep = getelementptr i8, <2 x ptr> %pm0, <2 x i64> <i64 32, i64 32>
  %r = call <2 x ptr> @llvm.ptrmask.v2p1.v2i64(<2 x ptr> %pgep, <2 x i64> <i64 -32, i64 -64>)
  ret <2 x ptr> %r
}

define <2 x ptr> @ptrmask_simplify_known_unused_vec_fail3(<2 x ptr> %p) {
; CHECK-LABEL: define <2 x ptr> @ptrmask_simplify_known_unused_vec_fail3
; CHECK-SAME: (<2 x ptr> [[P:%.*]]) {
; CHECK-NEXT:    [[PM0:%.*]] = call <2 x ptr> @llvm.ptrmask.v2p0.v2i64(<2 x ptr> [[P]], <2 x i64> <i64 -64, i64 -16>)
; CHECK-NEXT:    [[PGEP:%.*]] = getelementptr i8, <2 x ptr> [[PM0]], <2 x i64> <i64 32, i64 32>
; CHECK-NEXT:    [[R:%.*]] = call <2 x ptr> @llvm.ptrmask.v2p0.v2i64(<2 x ptr> [[PGEP]], <2 x i64> <i64 -32, i64 -32>)
; CHECK-NEXT:    ret <2 x ptr> [[R]]
;
  %pm0 = call <2 x ptr> @llvm.ptrmask.v2p1.v2i64(<2 x ptr> %p, <2 x i64> <i64 -64, i64 -16>)
  %pgep = getelementptr i8, <2 x ptr> %pm0, <2 x i64> <i64 32, i64 32>
  %r = call <2 x ptr> @llvm.ptrmask.v2p1.v2i64(<2 x ptr> %pgep, <2 x i64> <i64 -32, i64 -32>)
  ret <2 x ptr> %r
}

define ptr @ptrmask_maintain_provenance_i64(ptr %p0) {
; CHECK-LABEL: define ptr @ptrmask_maintain_provenance_i64
; CHECK-SAME: (ptr [[P0:%.*]]) {
; CHECK-NEXT:    [[R:%.*]] = call ptr @llvm.ptrmask.p0.i64(ptr [[P0]], i64 0)
; CHECK-NEXT:    ret ptr [[R]]
;
  %r = call ptr @llvm.ptrmask.p0.i64(ptr %p0, i64 0)
  ret ptr %r
}

define ptr addrspace(1) @ptrmask_maintain_provenance_i32(ptr addrspace(1) %p0) {
; CHECK-LABEL: define ptr addrspace(1) @ptrmask_maintain_provenance_i32
; CHECK-SAME: (ptr addrspace(1) [[P0:%.*]]) {
; CHECK-NEXT:    [[R:%.*]] = call ptr addrspace(1) @llvm.ptrmask.p1.i32(ptr addrspace(1) [[P0]], i32 0)
; CHECK-NEXT:    ret ptr addrspace(1) [[R]]
;
  %r = call ptr addrspace(1) @llvm.ptrmask.p1.i32(ptr addrspace(1) %p0, i32 0)
  ret ptr addrspace(1) %r
}

define <2 x ptr> @ptrmask_maintain_provenance_v2i64(<2 x ptr> %p0) {
; CHECK-LABEL: define <2 x ptr> @ptrmask_maintain_provenance_v2i64
; CHECK-SAME: (<2 x ptr> [[P0:%.*]]) {
; CHECK-NEXT:    [[R:%.*]] = call <2 x ptr> @llvm.ptrmask.v2p0.v2i64(<2 x ptr> [[P0]], <2 x i64> zeroinitializer)
; CHECK-NEXT:    ret <2 x ptr> [[R]]
;
  %r = call <2 x ptr> @llvm.ptrmask.v2p1.v2i64(<2 x ptr> %p0, <2 x i64> zeroinitializer)
  ret <2 x ptr> %r
}

define <2 x ptr addrspace(1) > @ptrmask_maintain_provenance_v2i32(<2 x ptr addrspace(1) > %p0) {
; CHECK-LABEL: define <2 x ptr addrspace(1)> @ptrmask_maintain_provenance_v2i32
; CHECK-SAME: (<2 x ptr addrspace(1)> [[P0:%.*]]) {
; CHECK-NEXT:    [[R:%.*]] = call <2 x ptr addrspace(1)> @llvm.ptrmask.v2p1.v2i32(<2 x ptr addrspace(1)> [[P0]], <2 x i32> zeroinitializer)
; CHECK-NEXT:    ret <2 x ptr addrspace(1)> [[R]]
;
  %r = call <2 x ptr addrspace(1) > @llvm.ptrmask.v2p1.v2i32(<2 x ptr addrspace(1) > %p0, <2 x i32> zeroinitializer)
  ret <2 x ptr addrspace(1) > %r
}
