; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -mtriple=arm64-darwin-unknown -S -passes=consthoist < %s | FileCheck %s

; Make sure we hoist constants out of intrinsics.

define void @test_stxr(ptr %ptr) {
; CHECK-LABEL: @test_stxr(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CONST:%.*]] = bitcast i64 -9223372036317904832 to i64
; CHECK-NEXT:    [[CONST_MAT:%.*]] = add i64 [[CONST]], -64
; CHECK-NEXT:    [[BAR_0:%.*]] = call i32 @llvm.aarch64.stxr.p0(i64 [[CONST_MAT]], ptr elementtype(i64) [[PTR:%.*]])
; CHECK-NEXT:    [[PTR_1:%.*]] = getelementptr i64, ptr [[PTR]], i64 1
; CHECK-NEXT:    [[BAR_1:%.*]] = call i32 @llvm.aarch64.stxr.p0(i64 [[CONST]], ptr elementtype(i64) [[PTR_1]])
; CHECK-NEXT:    [[PTR_2:%.*]] = getelementptr i64, ptr [[PTR]], i64 2
; CHECK-NEXT:    [[CONST_MAT1:%.*]] = add i64 [[CONST]], 64
; CHECK-NEXT:    [[BAR_2:%.*]] = call i32 @llvm.aarch64.stxr.p0(i64 [[CONST_MAT1]], ptr elementtype(i64) [[PTR_2]])
; CHECK-NEXT:    [[PTR_3:%.*]] = getelementptr i64, ptr [[PTR]], i64 3
; CHECK-NEXT:    [[CONST_MAT2:%.*]] = add i64 [[CONST]], 128
; CHECK-NEXT:    [[BAR_3:%.*]] = call i32 @llvm.aarch64.stxr.p0(i64 [[CONST_MAT2]], ptr elementtype(i64) [[PTR_3]])
; CHECK-NEXT:    ret void
;
entry:
  %bar.0 = call i32 @llvm.aarch64.stxr.p0(i64 -9223372036317904896, ptr elementtype(i64) %ptr)
  %ptr.1 = getelementptr i64, ptr %ptr, i64 1
  %bar.1 = call i32 @llvm.aarch64.stxr.p0(i64 -9223372036317904832,  ptr elementtype(i64) %ptr.1)
  %ptr.2 = getelementptr i64, ptr %ptr, i64 2
  %bar.2 = call i32 @llvm.aarch64.stxr.p0(i64 -9223372036317904768, ptr elementtype(i64) %ptr.2)
  %ptr.3 = getelementptr i64, ptr %ptr, i64 3
  %bar.3 = call i32 @llvm.aarch64.stxr.p0(i64 -9223372036317904704, ptr elementtype(i64) %ptr.3)
  ret void
}

declare i32 @llvm.aarch64.stxr.p0(i64 , ptr)

define i64 @test_udiv(i64 %x) {
; CHECK-LABEL: @test_udiv(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CONST:%.*]] = bitcast i64 -9223372036317904832 to i64
; CHECK-NEXT:    [[CONST_MAT:%.*]] = add i64 [[CONST]], -64
; CHECK-NEXT:    [[BAR_0:%.*]] = call i64 @llvm.aarch64.udiv.i64(i64 [[CONST_MAT]], i64 [[X:%.*]])
; CHECK-NEXT:    [[BAR_1:%.*]] = call i64 @llvm.aarch64.udiv.i64(i64 [[CONST]], i64 [[X]])
; CHECK-NEXT:    [[CONST_MAT1:%.*]] = add i64 [[CONST]], 64
; CHECK-NEXT:    [[BAR_2:%.*]] = call i64 @llvm.aarch64.udiv.i64(i64 [[CONST_MAT1]], i64 [[X]])
; CHECK-NEXT:    [[CONST_MAT2:%.*]] = add i64 [[CONST]], 128
; CHECK-NEXT:    [[BAR_3:%.*]] = call i64 @llvm.aarch64.udiv.i64(i64 [[CONST_MAT2]], i64 [[X]])
; CHECK-NEXT:    [[RES_1:%.*]] = add i64 [[BAR_0]], [[BAR_1]]
; CHECK-NEXT:    [[RES_2:%.*]] = add i64 [[RES_1]], [[BAR_2]]
; CHECK-NEXT:    [[RES_3:%.*]] = add i64 [[RES_2]], [[BAR_3]]
; CHECK-NEXT:    ret i64 [[RES_3]]
;
entry:
  %bar.0 = call i64 @llvm.aarch64.udiv.i64.i64(i64 -9223372036317904896, i64 %x)
  %bar.1 = call i64 @llvm.aarch64.udiv.i64.i64(i64 -9223372036317904832,  i64 %x)
  %bar.2 = call i64 @llvm.aarch64.udiv.i64.i64(i64 -9223372036317904768, i64 %x)
  %bar.3 = call i64 @llvm.aarch64.udiv.i64.i64(i64 -9223372036317904704, i64 %x)
  %res.1 = add i64 %bar.0, %bar.1
  %res.2 = add i64 %res.1, %bar.2
  %res.3 = add i64 %res.2, %bar.3
  ret i64 %res.3
}

declare i64 @llvm.aarch64.udiv.i64.i64(i64, i64)

define void @test_free_intrinsics(i64 %x, ptr %ptr) {
; CHECK-LABEL: @test_free_intrinsics(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    call void @llvm.lifetime.start.p0(i64 100000000032, ptr [[PTR:%.*]])
; CHECK-NEXT:    call void @llvm.lifetime.start.p0(i64 100000000064, ptr [[PTR]])
; CHECK-NEXT:    call void @llvm.lifetime.end.p0(i64 100000000128, ptr [[PTR]])
; CHECK-NEXT:    [[I:%.*]] = call ptr @llvm.invariant.start.p0(i64 100000000256, ptr [[PTR]])
; CHECK-NEXT:    call void @llvm.invariant.end.p0(ptr [[I]], i64 100000000256, ptr [[PTR]])
; CHECK-NEXT:    ret void
;
entry:
  call void @llvm.lifetime.start.p0(i64 100000000032, ptr %ptr)
  call void @llvm.lifetime.start.p0(i64 100000000064, ptr %ptr)
  call void @llvm.lifetime.end.p0(i64 100000000128, ptr %ptr)
  %i = call ptr @llvm.invariant.start.p0(i64 100000000256, ptr %ptr)
  call void @llvm.invariant.end.p0(ptr %i, i64 100000000256, ptr %ptr)
  ret void
}

declare void @llvm.lifetime.start.p0(i64, ptr)
declare void @llvm.lifetime.end.p0(i64, ptr)

declare ptr @llvm.invariant.start.p0(i64, ptr nocapture)
declare void @llvm.invariant.end.p0(ptr, i64, ptr nocapture)
