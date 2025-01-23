; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=slp-vectorizer -S -mtriple=x86_64-apple-macosx10.8.0 -mcpu=corei7-avx | FileCheck %s

define void @tiny_tree_fully_vectorizable(ptr noalias nocapture %dst, ptr noalias nocapture readonly %src, i64 %count) #0 {
; CHECK-LABEL: @tiny_tree_fully_vectorizable(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP12:%.*]] = icmp eq i64 [[COUNT:%.*]], 0
; CHECK-NEXT:    br i1 [[CMP12]], label [[FOR_END:%.*]], label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[I_015:%.*]] = phi i64 [ [[INC:%.*]], [[FOR_BODY]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[DST_ADDR_014:%.*]] = phi ptr [ [[ADD_PTR4:%.*]], [[FOR_BODY]] ], [ [[DST:%.*]], [[ENTRY]] ]
; CHECK-NEXT:    [[SRC_ADDR_013:%.*]] = phi ptr [ [[ADD_PTR:%.*]], [[FOR_BODY]] ], [ [[SRC:%.*]], [[ENTRY]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = load <2 x double>, ptr [[SRC_ADDR_013]], align 8
; CHECK-NEXT:    store <2 x double> [[TMP0]], ptr [[DST_ADDR_014]], align 8
; CHECK-NEXT:    [[ADD_PTR]] = getelementptr inbounds double, ptr [[SRC_ADDR_013]], i64 [[I_015]]
; CHECK-NEXT:    [[ADD_PTR4]] = getelementptr inbounds double, ptr [[DST_ADDR_014]], i64 [[I_015]]
; CHECK-NEXT:    [[INC]] = add i64 [[I_015]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[INC]], [[COUNT]]
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[FOR_END]], label [[FOR_BODY]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  %cmp12 = icmp eq i64 %count, 0
  br i1 %cmp12, label %for.end, label %for.body

for.body:                                         ; preds = %entry, %for.body
  %i.015 = phi i64 [ %inc, %for.body ], [ 0, %entry ]
  %dst.addr.014 = phi ptr [ %add.ptr4, %for.body ], [ %dst, %entry ]
  %src.addr.013 = phi ptr [ %add.ptr, %for.body ], [ %src, %entry ]
  %0 = load double, ptr %src.addr.013, align 8
  store double %0, ptr %dst.addr.014, align 8
  %arrayidx2 = getelementptr inbounds double, ptr %src.addr.013, i64 1
  %1 = load double, ptr %arrayidx2, align 8
  %arrayidx3 = getelementptr inbounds double, ptr %dst.addr.014, i64 1
  store double %1, ptr %arrayidx3, align 8
  %add.ptr = getelementptr inbounds double, ptr %src.addr.013, i64 %i.015
  %add.ptr4 = getelementptr inbounds double, ptr %dst.addr.014, i64 %i.015
  %inc = add i64 %i.015, 1
  %exitcond = icmp eq i64 %inc, %count
  br i1 %exitcond, label %for.end, label %for.body

for.end:                                          ; preds = %for.body, %entry
  ret void
}

define void @tiny_tree_fully_vectorizable2(ptr noalias nocapture %dst, ptr noalias nocapture readonly %src, i64 %count) #0 {
; CHECK-LABEL: @tiny_tree_fully_vectorizable2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP20:%.*]] = icmp eq i64 [[COUNT:%.*]], 0
; CHECK-NEXT:    br i1 [[CMP20]], label [[FOR_END:%.*]], label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[I_023:%.*]] = phi i64 [ [[INC:%.*]], [[FOR_BODY]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[DST_ADDR_022:%.*]] = phi ptr [ [[ADD_PTR8:%.*]], [[FOR_BODY]] ], [ [[DST:%.*]], [[ENTRY]] ]
; CHECK-NEXT:    [[SRC_ADDR_021:%.*]] = phi ptr [ [[ADD_PTR:%.*]], [[FOR_BODY]] ], [ [[SRC:%.*]], [[ENTRY]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = load <4 x float>, ptr [[SRC_ADDR_021]], align 4
; CHECK-NEXT:    store <4 x float> [[TMP0]], ptr [[DST_ADDR_022]], align 4
; CHECK-NEXT:    [[ADD_PTR]] = getelementptr inbounds float, ptr [[SRC_ADDR_021]], i64 [[I_023]]
; CHECK-NEXT:    [[ADD_PTR8]] = getelementptr inbounds float, ptr [[DST_ADDR_022]], i64 [[I_023]]
; CHECK-NEXT:    [[INC]] = add i64 [[I_023]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[INC]], [[COUNT]]
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[FOR_END]], label [[FOR_BODY]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  %cmp20 = icmp eq i64 %count, 0
  br i1 %cmp20, label %for.end, label %for.body

for.body:                                         ; preds = %entry, %for.body
  %i.023 = phi i64 [ %inc, %for.body ], [ 0, %entry ]
  %dst.addr.022 = phi ptr [ %add.ptr8, %for.body ], [ %dst, %entry ]
  %src.addr.021 = phi ptr [ %add.ptr, %for.body ], [ %src, %entry ]
  %0 = load float, ptr %src.addr.021, align 4
  store float %0, ptr %dst.addr.022, align 4
  %arrayidx2 = getelementptr inbounds float, ptr %src.addr.021, i64 1
  %1 = load float, ptr %arrayidx2, align 4
  %arrayidx3 = getelementptr inbounds float, ptr %dst.addr.022, i64 1
  store float %1, ptr %arrayidx3, align 4
  %arrayidx4 = getelementptr inbounds float, ptr %src.addr.021, i64 2
  %2 = load float, ptr %arrayidx4, align 4
  %arrayidx5 = getelementptr inbounds float, ptr %dst.addr.022, i64 2
  store float %2, ptr %arrayidx5, align 4
  %arrayidx6 = getelementptr inbounds float, ptr %src.addr.021, i64 3
  %3 = load float, ptr %arrayidx6, align 4
  %arrayidx7 = getelementptr inbounds float, ptr %dst.addr.022, i64 3
  store float %3, ptr %arrayidx7, align 4
  %add.ptr = getelementptr inbounds float, ptr %src.addr.021, i64 %i.023
  %add.ptr8 = getelementptr inbounds float, ptr %dst.addr.022, i64 %i.023
  %inc = add i64 %i.023, 1
  %exitcond = icmp eq i64 %inc, %count
  br i1 %exitcond, label %for.end, label %for.body

for.end:                                          ; preds = %for.body, %entry
  ret void
}

; We do not vectorize the tiny tree which is not fully vectorizable.

define void @tiny_tree_not_fully_vectorizable(ptr noalias nocapture %dst, ptr noalias nocapture readonly %src, i64 %count) #0 {
; CHECK-LABEL: @tiny_tree_not_fully_vectorizable(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP12:%.*]] = icmp eq i64 [[COUNT:%.*]], 0
; CHECK-NEXT:    br i1 [[CMP12]], label [[FOR_END:%.*]], label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[I_015:%.*]] = phi i64 [ [[INC:%.*]], [[FOR_BODY]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[DST_ADDR_014:%.*]] = phi ptr [ [[ADD_PTR4:%.*]], [[FOR_BODY]] ], [ [[DST:%.*]], [[ENTRY]] ]
; CHECK-NEXT:    [[SRC_ADDR_013:%.*]] = phi ptr [ [[ADD_PTR:%.*]], [[FOR_BODY]] ], [ [[SRC:%.*]], [[ENTRY]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = load double, ptr [[SRC_ADDR_013]], align 8
; CHECK-NEXT:    store double [[TMP0]], ptr [[DST_ADDR_014]], align 8
; CHECK-NEXT:    [[ARRAYIDX2:%.*]] = getelementptr inbounds double, ptr [[SRC_ADDR_013]], i64 2
; CHECK-NEXT:    [[TMP1:%.*]] = load double, ptr [[ARRAYIDX2]], align 8
; CHECK-NEXT:    [[ARRAYIDX3:%.*]] = getelementptr inbounds double, ptr [[DST_ADDR_014]], i64 1
; CHECK-NEXT:    store double [[TMP1]], ptr [[ARRAYIDX3]], align 8
; CHECK-NEXT:    [[ADD_PTR]] = getelementptr inbounds double, ptr [[SRC_ADDR_013]], i64 [[I_015]]
; CHECK-NEXT:    [[ADD_PTR4]] = getelementptr inbounds double, ptr [[DST_ADDR_014]], i64 [[I_015]]
; CHECK-NEXT:    [[INC]] = add i64 [[I_015]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[INC]], [[COUNT]]
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[FOR_END]], label [[FOR_BODY]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  %cmp12 = icmp eq i64 %count, 0
  br i1 %cmp12, label %for.end, label %for.body

for.body:                                         ; preds = %entry, %for.body
  %i.015 = phi i64 [ %inc, %for.body ], [ 0, %entry ]
  %dst.addr.014 = phi ptr [ %add.ptr4, %for.body ], [ %dst, %entry ]
  %src.addr.013 = phi ptr [ %add.ptr, %for.body ], [ %src, %entry ]
  %0 = load double, ptr %src.addr.013, align 8
  store double %0, ptr %dst.addr.014, align 8
  %arrayidx2 = getelementptr inbounds double, ptr %src.addr.013, i64 2
  %1 = load double, ptr %arrayidx2, align 8
  %arrayidx3 = getelementptr inbounds double, ptr %dst.addr.014, i64 1
  store double %1, ptr %arrayidx3, align 8
  %add.ptr = getelementptr inbounds double, ptr %src.addr.013, i64 %i.015
  %add.ptr4 = getelementptr inbounds double, ptr %dst.addr.014, i64 %i.015
  %inc = add i64 %i.015, 1
  %exitcond = icmp eq i64 %inc, %count
  br i1 %exitcond, label %for.end, label %for.body

for.end:                                          ; preds = %for.body, %entry
  ret void
}

define void @tiny_tree_not_fully_vectorizable2(ptr noalias nocapture %dst, ptr noalias nocapture readonly %src, i64 %count) #0 {
; CHECK-LABEL: @tiny_tree_not_fully_vectorizable2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP20:%.*]] = icmp eq i64 [[COUNT:%.*]], 0
; CHECK-NEXT:    br i1 [[CMP20]], label [[FOR_END:%.*]], label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[I_023:%.*]] = phi i64 [ [[INC:%.*]], [[FOR_BODY]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[DST_ADDR_022:%.*]] = phi ptr [ [[ADD_PTR8:%.*]], [[FOR_BODY]] ], [ [[DST:%.*]], [[ENTRY]] ]
; CHECK-NEXT:    [[SRC_ADDR_021:%.*]] = phi ptr [ [[ADD_PTR:%.*]], [[FOR_BODY]] ], [ [[SRC:%.*]], [[ENTRY]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = load float, ptr [[SRC_ADDR_021]], align 4
; CHECK-NEXT:    [[ARRAYIDX2:%.*]] = getelementptr inbounds float, ptr [[SRC_ADDR_021]], i64 4
; CHECK-NEXT:    [[TMP1:%.*]] = load float, ptr [[ARRAYIDX2]], align 4
; CHECK-NEXT:    [[ARRAYIDX4:%.*]] = getelementptr inbounds float, ptr [[SRC_ADDR_021]], i64 2
; CHECK-NEXT:    [[TMP2:%.*]] = load <2 x float>, ptr [[ARRAYIDX4]], align 4
; CHECK-NEXT:    [[TMP3:%.*]] = insertelement <4 x float> poison, float [[TMP0]], i32 0
; CHECK-NEXT:    [[TMP4:%.*]] = insertelement <4 x float> [[TMP3]], float [[TMP1]], i32 1
; CHECK-NEXT:    [[TMP5:%.*]] = shufflevector <2 x float> [[TMP2]], <2 x float> poison, <4 x i32> <i32 0, i32 1, i32 poison, i32 poison>
; CHECK-NEXT:    [[TMP6:%.*]] = shufflevector <4 x float> [[TMP4]], <4 x float> [[TMP5]], <4 x i32> <i32 0, i32 1, i32 4, i32 5>
; CHECK-NEXT:    store <4 x float> [[TMP6]], ptr [[DST_ADDR_022]], align 4
; CHECK-NEXT:    [[ADD_PTR]] = getelementptr inbounds float, ptr [[SRC_ADDR_021]], i64 [[I_023]]
; CHECK-NEXT:    [[ADD_PTR8]] = getelementptr inbounds float, ptr [[DST_ADDR_022]], i64 [[I_023]]
; CHECK-NEXT:    [[INC]] = add i64 [[I_023]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[INC]], [[COUNT]]
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[FOR_END]], label [[FOR_BODY]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  %cmp20 = icmp eq i64 %count, 0
  br i1 %cmp20, label %for.end, label %for.body

for.body:                                         ; preds = %entry, %for.body
  %i.023 = phi i64 [ %inc, %for.body ], [ 0, %entry ]
  %dst.addr.022 = phi ptr [ %add.ptr8, %for.body ], [ %dst, %entry ]
  %src.addr.021 = phi ptr [ %add.ptr, %for.body ], [ %src, %entry ]
  %0 = load float, ptr %src.addr.021, align 4
  store float %0, ptr %dst.addr.022, align 4
  %arrayidx2 = getelementptr inbounds float, ptr %src.addr.021, i64 4
  %1 = load float, ptr %arrayidx2, align 4
  %arrayidx3 = getelementptr inbounds float, ptr %dst.addr.022, i64 1
  store float %1, ptr %arrayidx3, align 4
  %arrayidx4 = getelementptr inbounds float, ptr %src.addr.021, i64 2
  %2 = load float, ptr %arrayidx4, align 4
  %arrayidx5 = getelementptr inbounds float, ptr %dst.addr.022, i64 2
  store float %2, ptr %arrayidx5, align 4
  %arrayidx6 = getelementptr inbounds float, ptr %src.addr.021, i64 3
  %3 = load float, ptr %arrayidx6, align 4
  %arrayidx7 = getelementptr inbounds float, ptr %dst.addr.022, i64 3
  store float %3, ptr %arrayidx7, align 4
  %add.ptr = getelementptr inbounds float, ptr %src.addr.021, i64 %i.023
  %add.ptr8 = getelementptr inbounds float, ptr %dst.addr.022, i64 %i.023
  %inc = add i64 %i.023, 1
  %exitcond = icmp eq i64 %inc, %count
  br i1 %exitcond, label %for.end, label %for.body

for.end:                                          ; preds = %for.body, %entry
  ret void
}

define void @store_splat(ptr, float) {
; CHECK-LABEL: @store_splat(
; CHECK-NEXT:    [[TMP3:%.*]] = insertelement <4 x float> poison, float [[TMP1:%.*]], i32 0
; CHECK-NEXT:    [[TMP4:%.*]] = shufflevector <4 x float> [[TMP3]], <4 x float> poison, <4 x i32> zeroinitializer
; CHECK-NEXT:    store <4 x float> [[TMP4]], ptr [[TMP0:%.*]], align 4
; CHECK-NEXT:    ret void
;
  store float %1, ptr %0, align 4
  %3 = getelementptr inbounds float, ptr %0, i64 1
  store float %1, ptr %3, align 4
  %4 = getelementptr inbounds float, ptr %0, i64 2
  store float %1, ptr %4, align 4
  %5 = getelementptr inbounds float, ptr %0, i64 3
  store float %1, ptr %5, align 4
  ret void
}

define void @store_const(ptr %a) {
; CHECK-LABEL: @store_const(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    store <4 x i32> <i32 10, i32 30, i32 20, i32 40>, ptr [[A:%.*]], align 4
; CHECK-NEXT:    ret void
;
entry:
  store i32 10, ptr %a, align 4
  %ptr1 = getelementptr inbounds i32, ptr %a, i64 1
  store i32 30, ptr %ptr1, align 4
  %ptr2 = getelementptr inbounds i32, ptr %a, i64 2
  store i32 20, ptr %ptr2, align 4
  %ptr3 = getelementptr inbounds i32, ptr %a, i64 3
  store i32 40, ptr %ptr3, align 4
  ret void
}

define void @tiny_vector_gather(ptr %a, ptr %v1, ptr %v2) {
; CHECK-LABEL: @tiny_vector_gather(
; CHECK-NEXT:    [[TMP1:%.*]] = load i32, ptr [[V1:%.*]], align 4
; CHECK-NEXT:    [[TMP2:%.*]] = load i32, ptr [[V2:%.*]], align 4
; CHECK-NEXT:    [[TMP3:%.*]] = insertelement <8 x i32> poison, i32 [[TMP1]], i32 0
; CHECK-NEXT:    [[TMP4:%.*]] = insertelement <8 x i32> [[TMP3]], i32 [[TMP2]], i32 1
; CHECK-NEXT:    [[TMP5:%.*]] = shufflevector <8 x i32> [[TMP4]], <8 x i32> poison, <8 x i32> <i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1>
; CHECK-NEXT:    store <8 x i32> [[TMP5]], ptr [[A:%.*]], align 16
; CHECK-NEXT:    ret void
;
  %1 = load i32, ptr %v1, align 4
  %2 = load i32, ptr %v2, align 4
  store i32 %1, ptr %a, align 16
  %ptr1 = getelementptr inbounds i32, ptr %a, i64 1
  store i32 %2, ptr %ptr1, align 4
  %ptr2 = getelementptr inbounds i32, ptr %a, i64 2
  store i32 %1, ptr %ptr2, align 8
  %ptr3 = getelementptr inbounds i32, ptr %a, i64 3
  store i32 %2, ptr %ptr3, align 4
  %ptr4 = getelementptr inbounds i32, ptr %a, i64 4
  store i32 %1, ptr %ptr4, align 16
  %ptr5 = getelementptr inbounds i32, ptr %a, i64 5
  store i32 %2, ptr %ptr5, align 4
  %ptr6 = getelementptr inbounds i32, ptr %a, i64 6
  store i32 %1, ptr %ptr6, align 8
  %ptr7 = getelementptr inbounds i32, ptr %a, i64 7
  store i32 %2, ptr %ptr7, align 4
  ret void
}

define void @tiny_vector_with_diff_opcode(ptr %a, ptr %v1) {
; CHECK-LABEL: @tiny_vector_with_diff_opcode(
; CHECK-NEXT:    [[TMP1:%.*]] = load i16, ptr [[V1:%.*]], align 4
; CHECK-NEXT:    [[TMP2:%.*]] = trunc i64 undef to i16
; CHECK-NEXT:    [[TMP3:%.*]] = insertelement <8 x i16> poison, i16 [[TMP1]], i32 0
; CHECK-NEXT:    [[TMP4:%.*]] = insertelement <8 x i16> [[TMP3]], i16 [[TMP2]], i32 1
; CHECK-NEXT:    [[TMP5:%.*]] = shufflevector <8 x i16> [[TMP4]], <8 x i16> poison, <8 x i32> <i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1>
; CHECK-NEXT:    store <8 x i16> [[TMP5]], ptr [[A:%.*]], align 16
; CHECK-NEXT:    ret void
;
  %1 = load i16, ptr %v1, align 4
  %2 = trunc i64 undef to i16
  store i16 %1, ptr %a, align 16
  %ptr1 = getelementptr inbounds i16, ptr %a, i64 1
  store i16 %2, ptr %ptr1, align 4
  %ptr2 = getelementptr inbounds i16, ptr %a, i64 2
  store i16 %1, ptr %ptr2, align 8
  %ptr3 = getelementptr inbounds i16, ptr %a, i64 3
  store i16 %2, ptr %ptr3, align 4
  %ptr4 = getelementptr inbounds i16, ptr %a, i64 4
  store i16 %1, ptr %ptr4, align 16
  %ptr5 = getelementptr inbounds i16, ptr %a, i64 5
  store i16 %2, ptr %ptr5, align 4
  %ptr6 = getelementptr inbounds i16, ptr %a, i64 6
  store i16 %1, ptr %ptr6, align 8
  %ptr7 = getelementptr inbounds i16, ptr %a, i64 7
  store i16 %2, ptr %ptr7, align 4
  ret void
}
