; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 3
; RUN: opt < %s -passes=loop-vectorize -force-vector-width=4 -S | FileCheck %s

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"

define void @fn(ptr %hbuf, ptr %ref, i32 %height) {
; CHECK-LABEL: define void @fn(
; CHECK-SAME: ptr [[HBUF:%.*]], ptr [[REF:%.*]], i32 [[HEIGHT:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    store i16 0, ptr [[HBUF]], align 1
; CHECK-NEXT:    [[CMP1:%.*]] = icmp sgt i32 [[HEIGHT]], 0
; CHECK-NEXT:    br i1 [[CMP1]], label [[FOR_BODY_PREHEADER:%.*]], label [[FOR_END:%.*]]
; CHECK:       for.body.preheader:
; CHECK-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i32 [[HEIGHT]], 4
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[SCALAR_PH:%.*]], label [[VECTOR_MEMCHECK:%.*]]
; CHECK:       vector.memcheck:
; CHECK-NEXT:    [[SCEVGEP:%.*]] = getelementptr i8, ptr [[HBUF]], i64 2
; CHECK-NEXT:    [[SCEVGEP1:%.*]] = getelementptr i8, ptr [[REF]], i64 2
; CHECK-NEXT:    [[BOUND0:%.*]] = icmp ult ptr [[HBUF]], [[SCEVGEP1]]
; CHECK-NEXT:    [[BOUND1:%.*]] = icmp ult ptr [[REF]], [[SCEVGEP]]
; CHECK-NEXT:    [[FOUND_CONFLICT:%.*]] = and i1 [[BOUND0]], [[BOUND1]]
; CHECK-NEXT:    br i1 [[FOUND_CONFLICT]], label [[SCALAR_PH]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[N_MOD_VF:%.*]] = urem i32 [[HEIGHT]], 4
; CHECK-NEXT:    [[N_VEC:%.*]] = sub i32 [[HEIGHT]], [[N_MOD_VF]]
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI:%.*]] = phi <4 x i16> [ zeroinitializer, [[VECTOR_PH]] ], [ [[TMP1:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = load i16, ptr [[REF]], align 1, !alias.scope !0
; CHECK-NEXT:    [[BROADCAST_SPLATINSERT:%.*]] = insertelement <4 x i16> poison, i16 [[TMP0]], i64 0
; CHECK-NEXT:    [[BROADCAST_SPLAT:%.*]] = shufflevector <4 x i16> [[BROADCAST_SPLATINSERT]], <4 x i16> poison, <4 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP1]] = add <4 x i16> [[BROADCAST_SPLAT]], [[VEC_PHI]]
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i32 [[INDEX]], 4
; CHECK-NEXT:    [[TMP2:%.*]] = icmp eq i32 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP2]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP3:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[TMP3:%.*]] = call i16 @llvm.vector.reduce.add.v4i16(<4 x i16> [[TMP1]])
; CHECK-NEXT:    store i16 [[TMP3]], ptr [[HBUF]], align 1
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i32 [[HEIGHT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[CMP_N]], label [[FOR_END_LOOPEXIT:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i32 [ [[N_VEC]], [[MIDDLE_BLOCK]] ], [ 0, [[FOR_BODY_PREHEADER]] ], [ 0, [[VECTOR_MEMCHECK]] ]
; CHECK-NEXT:    [[BC_MERGE_RDX:%.*]] = phi i16 [ [[TMP3]], [[MIDDLE_BLOCK]] ], [ 0, [[VECTOR_MEMCHECK]] ], [ 0, [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[TMP4:%.*]] = phi i16 [ [[ADD:%.*]], [[FOR_BODY]] ], [ [[BC_MERGE_RDX]], [[SCALAR_PH]] ]
; CHECK-NEXT:    [[I:%.*]] = phi i32 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[INC:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[TMP5:%.*]] = load i16, ptr [[REF]], align 1
; CHECK-NEXT:    [[ADD]] = add i16 [[TMP5]], [[TMP4]]
; CHECK-NEXT:    store i16 [[ADD]], ptr [[HBUF]], align 1
; CHECK-NEXT:    [[INC]] = add i32 [[I]], 1
; CHECK-NEXT:    [[EXITCOND_NOT:%.*]] = icmp eq i32 [[INC]], [[HEIGHT]]
; CHECK-NEXT:    br i1 [[EXITCOND_NOT]], label [[FOR_END_LOOPEXIT]], label [[FOR_BODY]], !llvm.loop [[LOOP6:![0-9]+]]
; CHECK:       for.end.loopexit:
; CHECK-NEXT:    br label [[FOR_END]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  store i16 0, ptr %hbuf, align 1
  %cmp1 = icmp sgt i32 %height, 0
  br i1 %cmp1, label %for.body.preheader, label %for.end

for.body.preheader:
  br label %for.body

for.body:
  %0 = phi i16 [ %add, %for.body ], [ 0, %for.body.preheader ]
  %i = phi i32 [ 0, %for.body.preheader ], [ %inc, %for.body ]
  %1 = load i16, ptr %ref, align 1
  %add = add i16 %1, %0
  store i16 %add, ptr %hbuf, align 1
  %inc = add i32 %i, 1
  %exitcond.not = icmp eq i32 %inc, %height
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret void
}
