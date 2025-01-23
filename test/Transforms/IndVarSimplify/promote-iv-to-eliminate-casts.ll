; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=indvars -S | FileCheck %s

; Provide legal integer types.
target datalayout = "n8:16:32:64"

; CHECK-NOT: sext

define i64 @test(ptr nocapture %first, i32 %count) nounwind readonly {
; CHECK-LABEL: @test(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[T0:%.*]] = icmp sgt i32 [[COUNT:%.*]], 0
; CHECK-NEXT:    br i1 [[T0]], label [[BB_NPH:%.*]], label [[BB2:%.*]]
; CHECK:       bb.nph:
; CHECK-NEXT:    [[WIDE_TRIP_COUNT:%.*]] = zext i32 [[COUNT]] to i64
; CHECK-NEXT:    br label [[BB:%.*]]
; CHECK:       bb:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[INDVARS_IV_NEXT:%.*]], [[BB1:%.*]] ], [ 0, [[BB_NPH]] ]
; CHECK-NEXT:    [[RESULT_02:%.*]] = phi i64 [ [[T5:%.*]], [[BB1]] ], [ 0, [[BB_NPH]] ]
; CHECK-NEXT:    [[T2:%.*]] = getelementptr i64, ptr [[FIRST:%.*]], i64 [[INDVARS_IV]]
; CHECK-NEXT:    [[T3:%.*]] = load i64, ptr [[T2]], align 8
; CHECK-NEXT:    [[T4:%.*]] = lshr i64 [[T3]], 4
; CHECK-NEXT:    [[T5]] = add i64 [[T4]], [[RESULT_02]]
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nuw nsw i64 [[INDVARS_IV]], 1
; CHECK-NEXT:    br label [[BB1]]
; CHECK:       bb1:
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp ne i64 [[INDVARS_IV_NEXT]], [[WIDE_TRIP_COUNT]]
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[BB]], label [[BB1_BB2_CRIT_EDGE:%.*]]
; CHECK:       bb1.bb2_crit_edge:
; CHECK-NEXT:    [[DOTLCSSA:%.*]] = phi i64 [ [[T5]], [[BB1]] ]
; CHECK-NEXT:    br label [[BB2]]
; CHECK:       bb2:
; CHECK-NEXT:    [[RESULT_0_LCSSA:%.*]] = phi i64 [ [[DOTLCSSA]], [[BB1_BB2_CRIT_EDGE]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    ret i64 [[RESULT_0_LCSSA]]
;
entry:
  %t0 = icmp sgt i32 %count, 0		; <i1> [#uses=1]
  br i1 %t0, label %bb.nph, label %bb2

bb.nph:		; preds = %entry
  br label %bb

bb:		; preds = %bb1, %bb.nph
  %result.02 = phi i64 [ %t5, %bb1 ], [ 0, %bb.nph ]		; <i64> [#uses=1]
  %n.01 = phi i32 [ %t6, %bb1 ], [ 0, %bb.nph ]		; <i32> [#uses=2]
  %t1 = sext i32 %n.01 to i64		; <i64> [#uses=1]
  %t2 = getelementptr i64, ptr %first, i64 %t1		; <ptr> [#uses=1]
  %t3 = load i64, ptr %t2, align 8		; <i64> [#uses=1]
  %t4 = lshr i64 %t3, 4		; <i64> [#uses=1]
  %t5 = add i64 %t4, %result.02		; <i64> [#uses=2]
  %t6 = add i32 %n.01, 1		; <i32> [#uses=2]
  br label %bb1

bb1:		; preds = %bb
  %t7 = icmp slt i32 %t6, %count		; <i1> [#uses=1]
  br i1 %t7, label %bb, label %bb1.bb2_crit_edge

bb1.bb2_crit_edge:		; preds = %bb1
  %.lcssa = phi i64 [ %t5, %bb1 ]		; <i64> [#uses=1]
  br label %bb2

bb2:		; preds = %bb1.bb2_crit_edge, %entry
  %result.0.lcssa = phi i64 [ %.lcssa, %bb1.bb2_crit_edge ], [ 0, %entry ]		; <i64> [#uses=1]
  ret i64 %result.0.lcssa
}

define void @foo(i16 signext %N, ptr nocapture %P) nounwind {
; CHECK-LABEL: @foo(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[T0:%.*]] = icmp sgt i16 [[N:%.*]], 0
; CHECK-NEXT:    br i1 [[T0]], label [[BB_NPH:%.*]], label [[RETURN:%.*]]
; CHECK:       bb.nph:
; CHECK-NEXT:    [[WIDE_TRIP_COUNT:%.*]] = zext i16 [[N]] to i64
; CHECK-NEXT:    br label [[BB:%.*]]
; CHECK:       bb:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[INDVARS_IV_NEXT:%.*]], [[BB1:%.*]] ], [ 0, [[BB_NPH]] ]
; CHECK-NEXT:    [[T2:%.*]] = getelementptr i32, ptr [[P:%.*]], i64 [[INDVARS_IV]]
; CHECK-NEXT:    store i32 123, ptr [[T2]], align 4
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nuw nsw i64 [[INDVARS_IV]], 1
; CHECK-NEXT:    br label [[BB1]]
; CHECK:       bb1:
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp ne i64 [[INDVARS_IV_NEXT]], [[WIDE_TRIP_COUNT]]
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[BB]], label [[BB1_RETURN_CRIT_EDGE:%.*]]
; CHECK:       bb1.return_crit_edge:
; CHECK-NEXT:    br label [[RETURN]]
; CHECK:       return:
; CHECK-NEXT:    ret void
;
entry:
  %t0 = icmp sgt i16 %N, 0		; <i1> [#uses=1]
  br i1 %t0, label %bb.nph, label %return

bb.nph:		; preds = %entry
  br label %bb

bb:		; preds = %bb1, %bb.nph
  %i.01 = phi i16 [ %t3, %bb1 ], [ 0, %bb.nph ]		; <i16> [#uses=2]
  %t1 = sext i16 %i.01 to i64		; <i64> [#uses=1]
  %t2 = getelementptr i32, ptr %P, i64 %t1		; <ptr> [#uses=1]
  store i32 123, ptr %t2, align 4
  %t3 = add i16 %i.01, 1		; <i16> [#uses=2]
  br label %bb1

bb1:		; preds = %bb
  %t4 = icmp slt i16 %t3, %N		; <i1> [#uses=1]
  br i1 %t4, label %bb, label %bb1.return_crit_edge

bb1.return_crit_edge:		; preds = %bb1
  br label %return

return:		; preds = %bb1.return_crit_edge, %entry
  ret void
}

; Test cases from PR1301:

define void @kinds__srangezero(ptr nocapture %a) nounwind {
; CHECK-LABEL: @kinds__srangezero(
; CHECK-NEXT:  bb.thread:
; CHECK-NEXT:    br label [[BB:%.*]]
; CHECK:       bb:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i32 [ [[INDVARS_IV_NEXT:%.*]], [[BB]] ], [ -10, [[BB_THREAD:%.*]] ]
; CHECK-NEXT:    [[TMP4:%.*]] = add nsw i32 [[INDVARS_IV]], 10
; CHECK-NEXT:    [[TMP5:%.*]] = getelementptr [21 x i32], ptr [[A:%.*]], i32 0, i32 [[TMP4]]
; CHECK-NEXT:    store i32 0, ptr [[TMP5]], align 4
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nsw i32 [[INDVARS_IV]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i32 [[INDVARS_IV_NEXT]], 11
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[RETURN:%.*]], label [[BB]]
; CHECK:       return:
; CHECK-NEXT:    ret void
;
bb.thread:
  br label %bb

bb:             ; preds = %bb, %bb.thread
  %i.0.reg2mem.0 = phi i8 [ -10, %bb.thread ], [ %tmp7, %bb ]           ; <i8> [#uses=2]
  %tmp12 = sext i8 %i.0.reg2mem.0 to i32                ; <i32> [#uses=1]
  %tmp4 = add i32 %tmp12, 10            ; <i32> [#uses=1]
  %tmp5 = getelementptr [21 x i32], ptr %a, i32 0, i32 %tmp4                ; <ptr> [#uses=1]
  store i32 0, ptr %tmp5
  %tmp7 = add i8 %i.0.reg2mem.0, 1              ; <i8> [#uses=2]
  %0 = icmp sgt i8 %tmp7, 10            ; <i1> [#uses=1]
  br i1 %0, label %return, label %bb

return:         ; preds = %bb
  ret void
}

define void @kinds__urangezero(ptr nocapture %a) nounwind {
; CHECK-LABEL: @kinds__urangezero(
; CHECK-NEXT:  bb.thread:
; CHECK-NEXT:    br label [[BB:%.*]]
; CHECK:       bb:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i32 [ [[INDVARS_IV_NEXT:%.*]], [[BB]] ], [ 10, [[BB_THREAD:%.*]] ]
; CHECK-NEXT:    [[TMP4:%.*]] = add nsw i32 [[INDVARS_IV]], -10
; CHECK-NEXT:    [[TMP5:%.*]] = getelementptr [21 x i32], ptr [[A:%.*]], i32 0, i32 [[TMP4]]
; CHECK-NEXT:    store i32 0, ptr [[TMP5]], align 4
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nuw nsw i32 [[INDVARS_IV]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i32 [[INDVARS_IV_NEXT]], 31
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[RETURN:%.*]], label [[BB]]
; CHECK:       return:
; CHECK-NEXT:    ret void
;
bb.thread:
  br label %bb

bb:             ; preds = %bb, %bb.thread
  %i.0.reg2mem.0 = phi i8 [ 10, %bb.thread ], [ %tmp7, %bb ]            ; <i8> [#uses=2]
  %tmp12 = sext i8 %i.0.reg2mem.0 to i32                ; <i32> [#uses=1]
  %tmp4 = add i32 %tmp12, -10           ; <i32> [#uses=1]
  %tmp5 = getelementptr [21 x i32], ptr %a, i32 0, i32 %tmp4                ; <ptr> [#uses=1]
  store i32 0, ptr %tmp5
  %tmp7 = add i8 %i.0.reg2mem.0, 1              ; <i8> [#uses=2]
  %0 = icmp sgt i8 %tmp7, 30            ; <i1> [#uses=1]
  br i1 %0, label %return, label %bb

return:         ; preds = %bb
  ret void
}

define void @promote_latch_condition_decrementing_loop_01(ptr %p, ptr %a) {
; CHECK-LABEL: @promote_latch_condition_decrementing_loop_01(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[LEN:%.*]] = load i32, ptr [[P:%.*]], align 4, !range [[RNG0:![0-9]+]]
; CHECK-NEXT:    [[LEN_MINUS_1:%.*]] = add nsw i32 [[LEN]], -1
; CHECK-NEXT:    [[ZERO_CHECK:%.*]] = icmp eq i32 [[LEN]], 0
; CHECK-NEXT:    br i1 [[ZERO_CHECK]], label [[LOOPEXIT:%.*]], label [[PREHEADER:%.*]]
; CHECK:       preheader:
; CHECK-NEXT:    [[TMP0:%.*]] = zext i32 [[LEN_MINUS_1]] to i64
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loopexit.loopexit:
; CHECK-NEXT:    br label [[LOOPEXIT]]
; CHECK:       loopexit:
; CHECK-NEXT:    ret void
; CHECK:       loop:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[INDVARS_IV_NEXT:%.*]], [[LOOP]] ], [ [[TMP0]], [[PREHEADER]] ]
; CHECK-NEXT:    [[EL:%.*]] = getelementptr inbounds i32, ptr [[A:%.*]], i64 [[INDVARS_IV]]
; CHECK-NEXT:    store atomic i32 0, ptr [[EL]] unordered, align 4
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nsw i64 [[INDVARS_IV]], -1
; CHECK-NEXT:    [[LOOPCOND:%.*]] = icmp slt i64 [[INDVARS_IV]], 1
; CHECK-NEXT:    br i1 [[LOOPCOND]], label [[LOOPEXIT_LOOPEXIT:%.*]], label [[LOOP]]
;

entry:
  %len = load i32, ptr %p, align 4, !range !0
  %len.minus.1 = add nsw i32 %len, -1
  %zero_check = icmp eq i32 %len, 0
  br i1 %zero_check, label %loopexit, label %preheader

preheader:
  br label %loop

loopexit:
  ret void

loop:
  %iv = phi i32 [ %iv.next, %loop ], [ %len.minus.1, %preheader ]
  %iv.wide = zext i32 %iv to i64
  %el = getelementptr inbounds i32, ptr %a, i64 %iv.wide
  store atomic i32 0, ptr %el unordered, align 4
  %iv.next = add nsw i32 %iv, -1
  %loopcond = icmp slt i32 %iv, 1
  br i1 %loopcond, label %loopexit, label %loop
}

define void @promote_latch_condition_decrementing_loop_02(ptr %p, ptr %a) {
; CHECK-LABEL: @promote_latch_condition_decrementing_loop_02(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[LEN:%.*]] = load i32, ptr [[P:%.*]], align 4, !range [[RNG0]]
; CHECK-NEXT:    [[ZERO_CHECK:%.*]] = icmp eq i32 [[LEN]], 0
; CHECK-NEXT:    br i1 [[ZERO_CHECK]], label [[LOOPEXIT:%.*]], label [[PREHEADER:%.*]]
; CHECK:       preheader:
; CHECK-NEXT:    [[TMP0:%.*]] = zext nneg i32 [[LEN]] to i64
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loopexit.loopexit:
; CHECK-NEXT:    br label [[LOOPEXIT]]
; CHECK:       loopexit:
; CHECK-NEXT:    ret void
; CHECK:       loop:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[INDVARS_IV_NEXT:%.*]], [[LOOP]] ], [ [[TMP0]], [[PREHEADER]] ]
; CHECK-NEXT:    [[EL:%.*]] = getelementptr inbounds i32, ptr [[A:%.*]], i64 [[INDVARS_IV]]
; CHECK-NEXT:    store atomic i32 0, ptr [[EL]] unordered, align 4
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nsw i64 [[INDVARS_IV]], -1
; CHECK-NEXT:    [[LOOPCOND:%.*]] = icmp slt i64 [[INDVARS_IV]], 1
; CHECK-NEXT:    br i1 [[LOOPCOND]], label [[LOOPEXIT_LOOPEXIT:%.*]], label [[LOOP]]
;

entry:
  %len = load i32, ptr %p, align 4, !range !0
  %zero_check = icmp eq i32 %len, 0
  br i1 %zero_check, label %loopexit, label %preheader

preheader:
  br label %loop

loopexit:
  ret void

loop:
  %iv = phi i32 [ %iv.next, %loop ], [ %len, %preheader ]
  %iv.wide = zext i32 %iv to i64
  %el = getelementptr inbounds i32, ptr %a, i64 %iv.wide
  store atomic i32 0, ptr %el unordered, align 4
  %iv.next = add nsw i32 %iv, -1
  %loopcond = icmp slt i32 %iv, 1
  br i1 %loopcond, label %loopexit, label %loop
}

define void @promote_latch_condition_decrementing_loop_03(ptr %p, ptr %a) {
; CHECK-LABEL: @promote_latch_condition_decrementing_loop_03(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[LEN:%.*]] = load i32, ptr [[P:%.*]], align 4, !range [[RNG0]]
; CHECK-NEXT:    [[ZERO_CHECK:%.*]] = icmp eq i32 [[LEN]], 0
; CHECK-NEXT:    br i1 [[ZERO_CHECK]], label [[LOOPEXIT:%.*]], label [[PREHEADER:%.*]]
; CHECK:       preheader:
; CHECK-NEXT:    [[TMP0:%.*]] = zext nneg i32 [[LEN]] to i64
; CHECK-NEXT:    [[TMP1:%.*]] = add nuw nsw i64 [[TMP0]], 1
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loopexit.loopexit:
; CHECK-NEXT:    br label [[LOOPEXIT]]
; CHECK:       loopexit:
; CHECK-NEXT:    ret void
; CHECK:       loop:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[INDVARS_IV_NEXT:%.*]], [[LOOP]] ], [ [[TMP1]], [[PREHEADER]] ]
; CHECK-NEXT:    [[EL:%.*]] = getelementptr inbounds i32, ptr [[A:%.*]], i64 [[INDVARS_IV]]
; CHECK-NEXT:    store atomic i32 0, ptr [[EL]] unordered, align 4
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nsw i64 [[INDVARS_IV]], -1
; CHECK-NEXT:    [[LOOPCOND:%.*]] = icmp slt i64 [[INDVARS_IV]], 1
; CHECK-NEXT:    br i1 [[LOOPCOND]], label [[LOOPEXIT_LOOPEXIT:%.*]], label [[LOOP]]
;

entry:
  %len = load i32, ptr %p, align 4, !range !0
  %len.plus.1 = add i32 %len, 1
  %zero_check = icmp eq i32 %len, 0
  br i1 %zero_check, label %loopexit, label %preheader

preheader:
  br label %loop

loopexit:
  ret void

loop:
  %iv = phi i32 [ %iv.next, %loop ], [ %len.plus.1, %preheader ]
  %iv.wide = zext i32 %iv to i64
  %el = getelementptr inbounds i32, ptr %a, i64 %iv.wide
  store atomic i32 0, ptr %el unordered, align 4
  %iv.next = add nsw i32 %iv, -1
  %loopcond = icmp slt i32 %iv, 1
  br i1 %loopcond, label %loopexit, label %loop
}

define void @promote_latch_condition_decrementing_loop_04(ptr %p, ptr %a, i1 %cond) {
; CHECK-LABEL: @promote_latch_condition_decrementing_loop_04(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[LEN:%.*]] = load i32, ptr [[P:%.*]], align 4, !range [[RNG0]]
; CHECK-NEXT:    [[LEN_MINUS_1:%.*]] = add nsw i32 [[LEN]], -1
; CHECK-NEXT:    br i1 [[COND:%.*]], label [[IF_TRUE:%.*]], label [[IF_FALSE:%.*]]
; CHECK:       if.true:
; CHECK-NEXT:    br label [[MERGE:%.*]]
; CHECK:       if.false:
; CHECK-NEXT:    br label [[MERGE]]
; CHECK:       merge:
; CHECK-NEXT:    [[IV_START:%.*]] = phi i32 [ [[LEN]], [[IF_TRUE]] ], [ [[LEN_MINUS_1]], [[IF_FALSE]] ]
; CHECK-NEXT:    [[ZERO_CHECK:%.*]] = icmp eq i32 [[LEN]], 0
; CHECK-NEXT:    br i1 [[ZERO_CHECK]], label [[LOOPEXIT:%.*]], label [[PREHEADER:%.*]]
; CHECK:       preheader:
; CHECK-NEXT:    [[TMP0:%.*]] = zext i32 [[IV_START]] to i64
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loopexit.loopexit:
; CHECK-NEXT:    br label [[LOOPEXIT]]
; CHECK:       loopexit:
; CHECK-NEXT:    ret void
; CHECK:       loop:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[INDVARS_IV_NEXT:%.*]], [[LOOP]] ], [ [[TMP0]], [[PREHEADER]] ]
; CHECK-NEXT:    [[EL:%.*]] = getelementptr inbounds i32, ptr [[A:%.*]], i64 [[INDVARS_IV]]
; CHECK-NEXT:    store atomic i32 0, ptr [[EL]] unordered, align 4
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nsw i64 [[INDVARS_IV]], -1
; CHECK-NEXT:    [[LOOPCOND:%.*]] = icmp slt i64 [[INDVARS_IV]], 1
; CHECK-NEXT:    br i1 [[LOOPCOND]], label [[LOOPEXIT_LOOPEXIT:%.*]], label [[LOOP]]
;

entry:
  %len = load i32, ptr %p, align 4, !range !0
  %len.minus.1 = add nsw i32 %len, -1
  br i1 %cond, label %if.true, label %if.false

if.true:
  br label %merge

if.false:
  br label %merge

merge:
  %iv_start = phi i32 [ %len, %if.true ], [%len.minus.1, %if.false ]
  %zero_check = icmp eq i32 %len, 0
  br i1 %zero_check, label %loopexit, label %preheader

preheader:
  br label %loop

loopexit:
  ret void

loop:
  %iv = phi i32 [ %iv.next, %loop ], [ %iv_start, %preheader ]
  %iv.wide = zext i32 %iv to i64
  %el = getelementptr inbounds i32, ptr %a, i64 %iv.wide
  store atomic i32 0, ptr %el unordered, align 4
  %iv.next = add nsw i32 %iv, -1
  %loopcond = icmp slt i32 %iv, 1
  br i1 %loopcond, label %loopexit, label %loop
}

define void @promote_latch_condition_decrementing_loop_05(ptr %p, ptr %a, i1 %cond) {
; CHECK-LABEL: @promote_latch_condition_decrementing_loop_05(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[LEN:%.*]] = load i32, ptr [[P:%.*]], align 4, !range [[RNG0]]
; CHECK-NEXT:    br i1 [[COND:%.*]], label [[IF_TRUE:%.*]], label [[IF_FALSE:%.*]]
; CHECK:       if.true:
; CHECK-NEXT:    br label [[MERGE:%.*]]
; CHECK:       if.false:
; CHECK-NEXT:    [[LEN_MINUS_1:%.*]] = add nsw i32 [[LEN]], -1
; CHECK-NEXT:    br label [[MERGE]]
; CHECK:       merge:
; CHECK-NEXT:    [[IV_START:%.*]] = phi i32 [ [[LEN]], [[IF_TRUE]] ], [ [[LEN_MINUS_1]], [[IF_FALSE]] ]
; CHECK-NEXT:    [[ZERO_CHECK:%.*]] = icmp eq i32 [[LEN]], 0
; CHECK-NEXT:    br i1 [[ZERO_CHECK]], label [[LOOPEXIT:%.*]], label [[PREHEADER:%.*]]
; CHECK:       preheader:
; CHECK-NEXT:    [[TMP0:%.*]] = zext i32 [[IV_START]] to i64
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loopexit.loopexit:
; CHECK-NEXT:    br label [[LOOPEXIT]]
; CHECK:       loopexit:
; CHECK-NEXT:    ret void
; CHECK:       loop:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[INDVARS_IV_NEXT:%.*]], [[LOOP]] ], [ [[TMP0]], [[PREHEADER]] ]
; CHECK-NEXT:    [[EL:%.*]] = getelementptr inbounds i32, ptr [[A:%.*]], i64 [[INDVARS_IV]]
; CHECK-NEXT:    store atomic i32 0, ptr [[EL]] unordered, align 4
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nsw i64 [[INDVARS_IV]], -1
; CHECK-NEXT:    [[LOOPCOND:%.*]] = icmp slt i64 [[INDVARS_IV]], 1
; CHECK-NEXT:    br i1 [[LOOPCOND]], label [[LOOPEXIT_LOOPEXIT:%.*]], label [[LOOP]]
;

entry:
  %len = load i32, ptr %p, align 4, !range !0
  br i1 %cond, label %if.true, label %if.false

if.true:
  br label %merge

if.false:
  %len.minus.1 = add nsw i32 %len, -1
  br label %merge

merge:
  %iv_start = phi i32 [ %len, %if.true ], [%len.minus.1, %if.false ]
  %zero_check = icmp eq i32 %len, 0
  br i1 %zero_check, label %loopexit, label %preheader

preheader:
  br label %loop

loopexit:
  ret void

loop:
  %iv = phi i32 [ %iv.next, %loop ], [ %iv_start, %preheader ]
  %iv.wide = zext i32 %iv to i64
  %el = getelementptr inbounds i32, ptr %a, i64 %iv.wide
  store atomic i32 0, ptr %el unordered, align 4
  %iv.next = add nsw i32 %iv, -1
  %loopcond = icmp slt i32 %iv, 1
  br i1 %loopcond, label %loopexit, label %loop
}

!0 = !{i32 0, i32 2147483647}
