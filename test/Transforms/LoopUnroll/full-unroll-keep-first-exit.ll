; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=loop-unroll < %s | FileCheck %s
; RUN: opt -S -passes='require<opt-remark-emit>,loop(loop-unroll-full)' < %s | FileCheck %s

; Unroll twice, with first loop exit kept
define void @s32_max1(i32 %n, ptr %p) {
;
; CHECK-LABEL: @s32_max1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD:%.*]] = add i32 [[N:%.*]], 1
; CHECK-NEXT:    br label [[DO_BODY:%.*]]
; CHECK:       do.body:
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr i32, ptr [[P:%.*]], i32 [[N]]
; CHECK-NEXT:    store i32 [[N]], ptr [[ARRAYIDX]], align 4
; CHECK-NEXT:    [[INC:%.*]] = add i32 [[N]], 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i32 [[N]], [[ADD]]
; CHECK-NEXT:    br i1 [[CMP]], label [[DO_BODY_1:%.*]], label [[DO_END:%.*]]
; CHECK:       do.body.1:
; CHECK-NEXT:    [[ARRAYIDX_1:%.*]] = getelementptr i32, ptr [[P]], i32 [[INC]]
; CHECK-NEXT:    store i32 [[INC]], ptr [[ARRAYIDX_1]], align 4
; CHECK-NEXT:    br label [[DO_END]]
; CHECK:       do.end:
; CHECK-NEXT:    ret void
;
entry:
  %add = add i32 %n, 1
  br label %do.body

do.body:
  %i.0 = phi i32 [ %n, %entry ], [ %inc, %do.body ]
  %arrayidx = getelementptr i32, ptr %p, i32 %i.0
  store i32 %i.0, ptr %arrayidx, align 4
  %inc = add i32 %i.0, 1
  %cmp = icmp slt i32 %i.0, %add
  br i1 %cmp, label %do.body, label %do.end ; taken either 0 or 1 times

do.end:
  ret void
}

; Unroll thrice, with first loop exit kept
define void @s32_max2(i32 %n, ptr %p) {
;
; CHECK-LABEL: @s32_max2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD:%.*]] = add i32 [[N:%.*]], 2
; CHECK-NEXT:    br label [[DO_BODY:%.*]]
; CHECK:       do.body:
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr i32, ptr [[P:%.*]], i32 [[N]]
; CHECK-NEXT:    store i32 [[N]], ptr [[ARRAYIDX]], align 4
; CHECK-NEXT:    [[INC:%.*]] = add i32 [[N]], 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i32 [[N]], [[ADD]]
; CHECK-NEXT:    br i1 [[CMP]], label [[DO_BODY_1:%.*]], label [[DO_END:%.*]]
; CHECK:       do.body.1:
; CHECK-NEXT:    [[ARRAYIDX_1:%.*]] = getelementptr i32, ptr [[P]], i32 [[INC]]
; CHECK-NEXT:    store i32 [[INC]], ptr [[ARRAYIDX_1]], align 4
; CHECK-NEXT:    [[INC_1:%.*]] = add i32 [[N]], 2
; CHECK-NEXT:    [[ARRAYIDX_2:%.*]] = getelementptr i32, ptr [[P]], i32 [[INC_1]]
; CHECK-NEXT:    store i32 [[INC_1]], ptr [[ARRAYIDX_2]], align 4
; CHECK-NEXT:    br label [[DO_END]]
; CHECK:       do.end:
; CHECK-NEXT:    ret void
;
entry:
  %add = add i32 %n, 2
  br label %do.body

do.body:
  %i.0 = phi i32 [ %n, %entry ], [ %inc, %do.body ]
  %arrayidx = getelementptr i32, ptr %p, i32 %i.0
  store i32 %i.0, ptr %arrayidx, align 4
  %inc = add i32 %i.0, 1
  %cmp = icmp slt i32 %i.0, %add
  br i1 %cmp, label %do.body, label %do.end ; taken either 0 or 2 times

do.end:
  ret void
}

; Should not be unrolled
define void @s32_maxx(i32 %n, i32 %x, ptr %p) {
;
; CHECK-LABEL: @s32_maxx(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD:%.*]] = add i32 [[X:%.*]], [[N:%.*]]
; CHECK-NEXT:    br label [[DO_BODY:%.*]]
; CHECK:       do.body:
; CHECK-NEXT:    [[I_0:%.*]] = phi i32 [ [[N]], [[ENTRY:%.*]] ], [ [[INC:%.*]], [[DO_BODY]] ]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr i32, ptr [[P:%.*]], i32 [[I_0]]
; CHECK-NEXT:    store i32 [[I_0]], ptr [[ARRAYIDX]], align 4
; CHECK-NEXT:    [[INC]] = add i32 [[I_0]], 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i32 [[I_0]], [[ADD]]
; CHECK-NEXT:    br i1 [[CMP]], label [[DO_BODY]], label [[DO_END:%.*]]
; CHECK:       do.end:
; CHECK-NEXT:    ret void
;
entry:
  %add = add i32 %x, %n
  br label %do.body

do.body:
  %i.0 = phi i32 [ %n, %entry ], [ %inc, %do.body ]
  %arrayidx = getelementptr i32, ptr %p, i32 %i.0
  store i32 %i.0, ptr %arrayidx, align 4
  %inc = add i32 %i.0, 1
  %cmp = icmp slt i32 %i.0, %add
  br i1 %cmp, label %do.body, label %do.end ; taken either 0 or x times

do.end:
  ret void
}

; Should not be unrolled
define void @s32_max2_unpredictable_exit(i32 %n, i32 %x, ptr %p) {
;
; CHECK-LABEL: @s32_max2_unpredictable_exit(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD:%.*]] = add i32 [[N:%.*]], 2
; CHECK-NEXT:    br label [[DO_BODY:%.*]]
; CHECK:       do.body:
; CHECK-NEXT:    [[I_0:%.*]] = phi i32 [ [[N]], [[ENTRY:%.*]] ], [ [[INC:%.*]], [[IF_END:%.*]] ]
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[I_0]], [[X:%.*]]
; CHECK-NEXT:    br i1 [[CMP]], label [[DO_END:%.*]], label [[IF_END]]
; CHECK:       if.end:
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr i32, ptr [[P:%.*]], i32 [[I_0]]
; CHECK-NEXT:    store i32 [[I_0]], ptr [[ARRAYIDX]], align 4
; CHECK-NEXT:    [[INC]] = add i32 [[I_0]], 1
; CHECK-NEXT:    [[CMP1:%.*]] = icmp slt i32 [[I_0]], [[ADD]]
; CHECK-NEXT:    br i1 [[CMP1]], label [[DO_BODY]], label [[DO_END]]
; CHECK:       do.end:
; CHECK-NEXT:    ret void
;
entry:
  %add = add i32 %n, 2
  br label %do.body

do.body:
  %i.0 = phi i32 [ %n, %entry ], [ %inc, %if.end ]
  %cmp = icmp eq i32 %i.0, %x
  br i1 %cmp, label %do.end, label %if.end ; unpredictable

if.end:
  %arrayidx = getelementptr i32, ptr %p, i32 %i.0
  store i32 %i.0, ptr %arrayidx, align 4
  %inc = add i32 %i.0, 1
  %cmp1 = icmp slt i32 %i.0, %add
  br i1 %cmp1, label %do.body, label %do.end ; taken either 0 or 2 times

do.end:
  ret void
}

; Unroll twice, with first loop exit kept
define void @u32_max1(i32 %n, ptr %p) {
;
; CHECK-LABEL: @u32_max1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD:%.*]] = add i32 [[N:%.*]], 1
; CHECK-NEXT:    br label [[DO_BODY:%.*]]
; CHECK:       do.body:
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr i32, ptr [[P:%.*]], i32 [[N]]
; CHECK-NEXT:    store i32 [[N]], ptr [[ARRAYIDX]], align 4
; CHECK-NEXT:    [[INC:%.*]] = add i32 [[N]], 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i32 [[N]], [[ADD]]
; CHECK-NEXT:    br i1 [[CMP]], label [[DO_BODY_1:%.*]], label [[DO_END:%.*]]
; CHECK:       do.body.1:
; CHECK-NEXT:    [[ARRAYIDX_1:%.*]] = getelementptr i32, ptr [[P]], i32 [[INC]]
; CHECK-NEXT:    store i32 [[INC]], ptr [[ARRAYIDX_1]], align 4
; CHECK-NEXT:    br label [[DO_END]]
; CHECK:       do.end:
; CHECK-NEXT:    ret void
;
entry:
  %add = add i32 %n, 1
  br label %do.body

do.body:
  %i.0 = phi i32 [ %n, %entry ], [ %inc, %do.body ]
  %arrayidx = getelementptr i32, ptr %p, i32 %i.0
  store i32 %i.0, ptr %arrayidx, align 4
  %inc = add i32 %i.0, 1
  %cmp = icmp ult i32 %i.0, %add
  br i1 %cmp, label %do.body, label %do.end ; taken either 0 or 1 times

do.end:
  ret void
}

; Unroll thrice, with first loop exit kept
define void @u32_max2(i32 %n, ptr %p) {
;
; CHECK-LABEL: @u32_max2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD:%.*]] = add i32 [[N:%.*]], 2
; CHECK-NEXT:    br label [[DO_BODY:%.*]]
; CHECK:       do.body:
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr i32, ptr [[P:%.*]], i32 [[N]]
; CHECK-NEXT:    store i32 [[N]], ptr [[ARRAYIDX]], align 4
; CHECK-NEXT:    [[INC:%.*]] = add i32 [[N]], 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i32 [[N]], [[ADD]]
; CHECK-NEXT:    br i1 [[CMP]], label [[DO_BODY_1:%.*]], label [[DO_END:%.*]]
; CHECK:       do.body.1:
; CHECK-NEXT:    [[ARRAYIDX_1:%.*]] = getelementptr i32, ptr [[P]], i32 [[INC]]
; CHECK-NEXT:    store i32 [[INC]], ptr [[ARRAYIDX_1]], align 4
; CHECK-NEXT:    [[INC_1:%.*]] = add i32 [[N]], 2
; CHECK-NEXT:    [[ARRAYIDX_2:%.*]] = getelementptr i32, ptr [[P]], i32 [[INC_1]]
; CHECK-NEXT:    store i32 [[INC_1]], ptr [[ARRAYIDX_2]], align 4
; CHECK-NEXT:    br label [[DO_END]]
; CHECK:       do.end:
; CHECK-NEXT:    ret void
;
entry:
  %add = add i32 %n, 2
  br label %do.body

do.body:
  %i.0 = phi i32 [ %n, %entry ], [ %inc, %do.body ]
  %arrayidx = getelementptr i32, ptr %p, i32 %i.0
  store i32 %i.0, ptr %arrayidx, align 4
  %inc = add i32 %i.0, 1
  %cmp = icmp ult i32 %i.0, %add
  br i1 %cmp, label %do.body, label %do.end ; taken either 0 or 2 times

do.end:
  ret void
}

; Should not be unrolled
define void @u32_maxx(i32 %n, i32 %x, ptr %p) {
;
; CHECK-LABEL: @u32_maxx(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD:%.*]] = add i32 [[X:%.*]], [[N:%.*]]
; CHECK-NEXT:    br label [[DO_BODY:%.*]]
; CHECK:       do.body:
; CHECK-NEXT:    [[I_0:%.*]] = phi i32 [ [[N]], [[ENTRY:%.*]] ], [ [[INC:%.*]], [[DO_BODY]] ]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr i32, ptr [[P:%.*]], i32 [[I_0]]
; CHECK-NEXT:    store i32 [[I_0]], ptr [[ARRAYIDX]], align 4
; CHECK-NEXT:    [[INC]] = add i32 [[I_0]], 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i32 [[I_0]], [[ADD]]
; CHECK-NEXT:    br i1 [[CMP]], label [[DO_BODY]], label [[DO_END:%.*]]
; CHECK:       do.end:
; CHECK-NEXT:    ret void
;
entry:
  %add = add i32 %x, %n
  br label %do.body

do.body:
  %i.0 = phi i32 [ %n, %entry ], [ %inc, %do.body ]
  %arrayidx = getelementptr i32, ptr %p, i32 %i.0
  store i32 %i.0, ptr %arrayidx, align 4
  %inc = add i32 %i.0, 1
  %cmp = icmp ult i32 %i.0, %add
  br i1 %cmp, label %do.body, label %do.end ; taken either 0 or x times

do.end:
  ret void
}

; Should not be unrolled
define void @u32_max2_unpredictable_exit(i32 %n, i32 %x, ptr %p) {
;
; CHECK-LABEL: @u32_max2_unpredictable_exit(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD:%.*]] = add i32 [[N:%.*]], 2
; CHECK-NEXT:    br label [[DO_BODY:%.*]]
; CHECK:       do.body:
; CHECK-NEXT:    [[I_0:%.*]] = phi i32 [ [[N]], [[ENTRY:%.*]] ], [ [[INC:%.*]], [[IF_END:%.*]] ]
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[I_0]], [[X:%.*]]
; CHECK-NEXT:    br i1 [[CMP]], label [[DO_END:%.*]], label [[IF_END]]
; CHECK:       if.end:
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr i32, ptr [[P:%.*]], i32 [[I_0]]
; CHECK-NEXT:    store i32 [[I_0]], ptr [[ARRAYIDX]], align 4
; CHECK-NEXT:    [[INC]] = add i32 [[I_0]], 1
; CHECK-NEXT:    [[CMP1:%.*]] = icmp ult i32 [[I_0]], [[ADD]]
; CHECK-NEXT:    br i1 [[CMP1]], label [[DO_BODY]], label [[DO_END]]
; CHECK:       do.end:
; CHECK-NEXT:    ret void
;
entry:
  %add = add i32 %n, 2
  br label %do.body

do.body:
  %i.0 = phi i32 [ %n, %entry ], [ %inc, %if.end ]
  %cmp = icmp eq i32 %i.0, %x
  br i1 %cmp, label %do.end, label %if.end ; unpredictable

if.end:
  %arrayidx = getelementptr i32, ptr %p, i32 %i.0
  store i32 %i.0, ptr %arrayidx, align 4
  %inc = add i32 %i.0, 1
  %cmp1 = icmp ult i32 %i.0, %add
  br i1 %cmp1, label %do.body, label %do.end ; taken either 0 or 2 times

do.end:
  ret void
}
