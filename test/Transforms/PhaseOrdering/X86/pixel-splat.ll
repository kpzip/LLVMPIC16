; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -O2                   -S < %s  | FileCheck %s
; RUN: opt -passes="default<O2>" -S < %s  | FileCheck %s


target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.15.0"

; https://llvm.org/PR49055
;
; void loop_or(const unsigned char* __restrict pIn, unsigned int* __restrict pOut, int s) {
;   for (int i = 0; i < s; i++) {
;     unsigned int pixelChar = pIn[i];
;     unsigned int pixel = pixelChar | (pixelChar << 8) | (pixelChar << 16) | (255 << 24);
;     pOut[i] = pixel;
;   }
; }
;
; We are looking for the shifts to get combined into mul along with vectorization.

define void @loop_or(ptr noalias %pIn, ptr noalias %pOut, i32 %s) {
; CHECK-LABEL: @loop_or(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP1:%.*]] = icmp sgt i32 [[S:%.*]], 0
; CHECK-NEXT:    br i1 [[CMP1]], label [[FOR_BODY_PREHEADER:%.*]], label [[FOR_END:%.*]]
; CHECK:       for.body.preheader:
; CHECK-NEXT:    [[WIDE_TRIP_COUNT:%.*]] = zext nneg i32 [[S]] to i64
; CHECK-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i32 [[S]], 8
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[FOR_BODY_PREHEADER5:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[N_VEC:%.*]] = and i64 [[WIDE_TRIP_COUNT]], 2147483640
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = getelementptr inbounds i8, ptr [[PIN:%.*]], i64 [[INDEX]]
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr inbounds i8, ptr [[TMP0]], i64 4
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <4 x i8>, ptr [[TMP0]], align 1
; CHECK-NEXT:    [[WIDE_LOAD4:%.*]] = load <4 x i8>, ptr [[TMP1]], align 1
; CHECK-NEXT:    [[TMP2:%.*]] = zext <4 x i8> [[WIDE_LOAD]] to <4 x i32>
; CHECK-NEXT:    [[TMP3:%.*]] = zext <4 x i8> [[WIDE_LOAD4]] to <4 x i32>
; CHECK-NEXT:    [[TMP4:%.*]] = mul nuw nsw <4 x i32> [[TMP2]], <i32 65793, i32 65793, i32 65793, i32 65793>
; CHECK-NEXT:    [[TMP5:%.*]] = mul nuw nsw <4 x i32> [[TMP3]], <i32 65793, i32 65793, i32 65793, i32 65793>
; CHECK-NEXT:    [[TMP6:%.*]] = or disjoint <4 x i32> [[TMP4]], <i32 -16777216, i32 -16777216, i32 -16777216, i32 -16777216>
; CHECK-NEXT:    [[TMP7:%.*]] = or disjoint <4 x i32> [[TMP5]], <i32 -16777216, i32 -16777216, i32 -16777216, i32 -16777216>
; CHECK-NEXT:    [[TMP8:%.*]] = getelementptr inbounds i32, ptr [[POUT:%.*]], i64 [[INDEX]]
; CHECK-NEXT:    [[TMP9:%.*]] = getelementptr inbounds i8, ptr [[TMP8]], i64 16
; CHECK-NEXT:    store <4 x i32> [[TMP6]], ptr [[TMP8]], align 4
; CHECK-NEXT:    store <4 x i32> [[TMP7]], ptr [[TMP9]], align 4
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 8
; CHECK-NEXT:    [[TMP10:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP10]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i64 [[N_VEC]], [[WIDE_TRIP_COUNT]]
; CHECK-NEXT:    br i1 [[CMP_N]], label [[FOR_END]], label [[FOR_BODY_PREHEADER5]]
; CHECK:       for.body.preheader5:
; CHECK-NEXT:    [[INDVARS_IV_PH:%.*]] = phi i64 [ 0, [[FOR_BODY_PREHEADER]] ], [ [[N_VEC]], [[MIDDLE_BLOCK]] ]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[INDVARS_IV_NEXT:%.*]], [[FOR_BODY]] ], [ [[INDVARS_IV_PH]], [[FOR_BODY_PREHEADER5]] ]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i8, ptr [[PIN]], i64 [[INDVARS_IV]]
; CHECK-NEXT:    [[TMP11:%.*]] = load i8, ptr [[ARRAYIDX]], align 1
; CHECK-NEXT:    [[CONV:%.*]] = zext i8 [[TMP11]] to i32
; CHECK-NEXT:    [[OR2:%.*]] = mul nuw nsw i32 [[CONV]], 65793
; CHECK-NEXT:    [[OR3:%.*]] = or disjoint i32 [[OR2]], -16777216
; CHECK-NEXT:    [[ARRAYIDX5:%.*]] = getelementptr inbounds i32, ptr [[POUT]], i64 [[INDVARS_IV]]
; CHECK-NEXT:    store i32 [[OR3]], ptr [[ARRAYIDX5]], align 4
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nuw nsw i64 [[INDVARS_IV]], 1
; CHECK-NEXT:    [[EXITCOND_NOT:%.*]] = icmp eq i64 [[INDVARS_IV_NEXT]], [[WIDE_TRIP_COUNT]]
; CHECK-NEXT:    br i1 [[EXITCOND_NOT]], label [[FOR_END]], label [[FOR_BODY]], !llvm.loop [[LOOP3:![0-9]+]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  br label %for.cond

for.cond:
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %for.inc ]
  %cmp = icmp slt i32 %i.0, %s
  br i1 %cmp, label %for.body, label %for.cond.cleanup

for.cond.cleanup:
  br label %for.end

for.body:
  %idxprom = sext i32 %i.0 to i64
  %arrayidx = getelementptr inbounds i8, ptr %pIn, i64 %idxprom
  %0 = load i8, ptr %arrayidx, align 1
  %conv = zext i8 %0 to i32
  %shl = shl i32 %conv, 8
  %or = or i32 %conv, %shl
  %shl1 = shl i32 %conv, 16
  %or2 = or i32 %or, %shl1
  %or3 = or i32 %or2, -16777216
  %idxprom4 = sext i32 %i.0 to i64
  %arrayidx5 = getelementptr inbounds i32, ptr %pOut, i64 %idxprom4
  store i32 %or3, ptr %arrayidx5, align 4
  br label %for.inc

for.inc:
  %inc = add nsw i32 %i.0, 1
  br label %for.cond

for.end:
  ret void
}
