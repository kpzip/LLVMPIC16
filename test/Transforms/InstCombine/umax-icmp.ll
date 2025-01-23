; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=instcombine < %s | FileCheck %s

; If we have a umax feeding an unsigned or equality icmp that shares an
; operand with the umax, the compare should always be folded.
; Test all 4 foldable predicates (eq,ne,ugt,ule) * 4 commutation
; possibilities for each predicate. Note that folds to true/false
; (predicate = uge/ult) or folds to an existing instruction should be
; handled by InstSimplify.

; umax(X, Y) == X --> X >= Y

define i1 @eq_umax1(i32 %x, i32 %y) {
; CHECK-LABEL: @eq_umax1(
; CHECK-NEXT:    [[CMP2:%.*]] = icmp uge i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    ret i1 [[CMP2]]
;
  %cmp1 = icmp ugt i32 %x, %y
  %sel = select i1 %cmp1, i32 %x, i32 %y
  %cmp2 = icmp eq i32 %sel, %x
  ret i1 %cmp2
}

; Commute max operands.

define i1 @eq_umax2(i32 %x, i32 %y) {
; CHECK-LABEL: @eq_umax2(
; CHECK-NEXT:    [[CMP2:%.*]] = icmp uge i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    ret i1 [[CMP2]]
;
  %cmp1 = icmp ugt i32 %y, %x
  %sel = select i1 %cmp1, i32 %y, i32 %x
  %cmp2 = icmp eq i32 %sel, %x
  ret i1 %cmp2
}

; Disguise the icmp predicate by commuting the max op to the RHS.

define i1 @eq_umax3(i32 %a, i32 %y) {
; CHECK-LABEL: @eq_umax3(
; CHECK-NEXT:    [[X:%.*]] = add i32 [[A:%.*]], 3
; CHECK-NEXT:    [[CMP2:%.*]] = icmp uge i32 [[X]], [[Y:%.*]]
; CHECK-NEXT:    ret i1 [[CMP2]]
;
  %x = add i32 %a, 3 ; thwart complexity-based canonicalization
  %cmp1 = icmp ugt i32 %x, %y
  %sel = select i1 %cmp1, i32 %x, i32 %y
  %cmp2 = icmp eq i32 %x, %sel
  ret i1 %cmp2
}

; Commute max operands.

define i1 @eq_umax4(i32 %a, i32 %y) {
; CHECK-LABEL: @eq_umax4(
; CHECK-NEXT:    [[X:%.*]] = add i32 [[A:%.*]], 3
; CHECK-NEXT:    [[CMP2:%.*]] = icmp uge i32 [[X]], [[Y:%.*]]
; CHECK-NEXT:    ret i1 [[CMP2]]
;
  %x = add i32 %a, 3 ; thwart complexity-based canonicalization
  %cmp1 = icmp ugt i32 %y, %x
  %sel = select i1 %cmp1, i32 %y, i32 %x
  %cmp2 = icmp eq i32 %x, %sel
  ret i1 %cmp2
}

; umax(X, Y) <= X --> Y <= X

define i1 @ule_umax1(i32 %x, i32 %y) {
; CHECK-LABEL: @ule_umax1(
; CHECK-NEXT:    [[CMP2:%.*]] = icmp ule i32 [[Y:%.*]], [[X:%.*]]
; CHECK-NEXT:    ret i1 [[CMP2]]
;
  %cmp1 = icmp ugt i32 %x, %y
  %sel = select i1 %cmp1, i32 %x, i32 %y
  %cmp2 = icmp ule i32 %sel, %x
  ret i1 %cmp2
}

; Commute max operands.

define i1 @ule_umax2(i32 %x, i32 %y) {
; CHECK-LABEL: @ule_umax2(
; CHECK-NEXT:    [[CMP2:%.*]] = icmp ule i32 [[Y:%.*]], [[X:%.*]]
; CHECK-NEXT:    ret i1 [[CMP2]]
;
  %cmp1 = icmp ugt i32 %y, %x
  %sel = select i1 %cmp1, i32 %y, i32 %x
  %cmp2 = icmp ule i32 %sel, %x
  ret i1 %cmp2
}

; Disguise the icmp predicate by commuting the max op to the RHS.

define i1 @ule_umax3(i32 %a, i32 %y) {
; CHECK-LABEL: @ule_umax3(
; CHECK-NEXT:    [[X:%.*]] = add i32 [[A:%.*]], 3
; CHECK-NEXT:    [[CMP2:%.*]] = icmp uge i32 [[X]], [[Y:%.*]]
; CHECK-NEXT:    ret i1 [[CMP2]]
;
  %x = add i32 %a, 3 ; thwart complexity-based canonicalization
  %cmp1 = icmp ugt i32 %x, %y
  %sel = select i1 %cmp1, i32 %x, i32 %y
  %cmp2 = icmp uge i32 %x, %sel
  ret i1 %cmp2
}

; Commute max operands.

define i1 @ule_umax4(i32 %a, i32 %y) {
; CHECK-LABEL: @ule_umax4(
; CHECK-NEXT:    [[X:%.*]] = add i32 [[A:%.*]], 3
; CHECK-NEXT:    [[CMP2:%.*]] = icmp uge i32 [[X]], [[Y:%.*]]
; CHECK-NEXT:    ret i1 [[CMP2]]
;
  %x = add i32 %a, 3 ; thwart complexity-based canonicalization
  %cmp1 = icmp ugt i32 %y, %x
  %sel = select i1 %cmp1, i32 %y, i32 %x
  %cmp2 = icmp uge i32 %x, %sel
  ret i1 %cmp2
}

; umax(X, Y) != X --> X < Y

define i1 @ne_umax1(i32 %x, i32 %y) {
; CHECK-LABEL: @ne_umax1(
; CHECK-NEXT:    [[CMP2:%.*]] = icmp ult i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    ret i1 [[CMP2]]
;
  %cmp1 = icmp ugt i32 %x, %y
  %sel = select i1 %cmp1, i32 %x, i32 %y
  %cmp2 = icmp ne i32 %sel, %x
  ret i1 %cmp2
}

; Commute max operands.

define i1 @ne_umax2(i32 %x, i32 %y) {
; CHECK-LABEL: @ne_umax2(
; CHECK-NEXT:    [[CMP2:%.*]] = icmp ult i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    ret i1 [[CMP2]]
;
  %cmp1 = icmp ugt i32 %y, %x
  %sel = select i1 %cmp1, i32 %y, i32 %x
  %cmp2 = icmp ne i32 %sel, %x
  ret i1 %cmp2
}

; Disguise the icmp predicate by commuting the max op to the RHS.

define i1 @ne_umax3(i32 %a, i32 %y) {
; CHECK-LABEL: @ne_umax3(
; CHECK-NEXT:    [[X:%.*]] = add i32 [[A:%.*]], 3
; CHECK-NEXT:    [[CMP2:%.*]] = icmp ult i32 [[X]], [[Y:%.*]]
; CHECK-NEXT:    ret i1 [[CMP2]]
;
  %x = add i32 %a, 3 ; thwart complexity-based canonicalization
  %cmp1 = icmp ugt i32 %x, %y
  %sel = select i1 %cmp1, i32 %x, i32 %y
  %cmp2 = icmp ne i32 %x, %sel
  ret i1 %cmp2
}

; Commute max operands.

define i1 @ne_umax4(i32 %a, i32 %y) {
; CHECK-LABEL: @ne_umax4(
; CHECK-NEXT:    [[X:%.*]] = add i32 [[A:%.*]], 3
; CHECK-NEXT:    [[CMP2:%.*]] = icmp ult i32 [[X]], [[Y:%.*]]
; CHECK-NEXT:    ret i1 [[CMP2]]
;
  %x = add i32 %a, 3 ; thwart complexity-based canonicalization
  %cmp1 = icmp ugt i32 %y, %x
  %sel = select i1 %cmp1, i32 %y, i32 %x
  %cmp2 = icmp ne i32 %x, %sel
  ret i1 %cmp2
}

; umax(X, Y) > X --> Y > X

define i1 @ugt_umax1(i32 %x, i32 %y) {
; CHECK-LABEL: @ugt_umax1(
; CHECK-NEXT:    [[CMP2:%.*]] = icmp ugt i32 [[Y:%.*]], [[X:%.*]]
; CHECK-NEXT:    ret i1 [[CMP2]]
;
  %cmp1 = icmp ugt i32 %x, %y
  %sel = select i1 %cmp1, i32 %x, i32 %y
  %cmp2 = icmp ugt i32 %sel, %x
  ret i1 %cmp2
}

; Commute max operands.

define i1 @ugt_umax2(i32 %x, i32 %y) {
; CHECK-LABEL: @ugt_umax2(
; CHECK-NEXT:    [[CMP2:%.*]] = icmp ugt i32 [[Y:%.*]], [[X:%.*]]
; CHECK-NEXT:    ret i1 [[CMP2]]
;
  %cmp1 = icmp ugt i32 %y, %x
  %sel = select i1 %cmp1, i32 %y, i32 %x
  %cmp2 = icmp ugt i32 %sel, %x
  ret i1 %cmp2
}

; Disguise the icmp predicate by commuting the max op to the RHS.

define i1 @ugt_umax3(i32 %a, i32 %y) {
; CHECK-LABEL: @ugt_umax3(
; CHECK-NEXT:    [[X:%.*]] = add i32 [[A:%.*]], 3
; CHECK-NEXT:    [[CMP2:%.*]] = icmp ult i32 [[X]], [[Y:%.*]]
; CHECK-NEXT:    ret i1 [[CMP2]]
;
  %x = add i32 %a, 3 ; thwart complexity-based canonicalization
  %cmp1 = icmp ugt i32 %x, %y
  %sel = select i1 %cmp1, i32 %x, i32 %y
  %cmp2 = icmp ult i32 %x, %sel
  ret i1 %cmp2
}

; Commute max operands.

define i1 @ugt_umax4(i32 %a, i32 %y) {
; CHECK-LABEL: @ugt_umax4(
; CHECK-NEXT:    [[X:%.*]] = add i32 [[A:%.*]], 3
; CHECK-NEXT:    [[CMP2:%.*]] = icmp ult i32 [[X]], [[Y:%.*]]
; CHECK-NEXT:    ret i1 [[CMP2]]
;
  %x = add i32 %a, 3 ; thwart complexity-based canonicalization
  %cmp1 = icmp ugt i32 %y, %x
  %sel = select i1 %cmp1, i32 %y, i32 %x
  %cmp2 = icmp ult i32 %x, %sel
  ret i1 %cmp2
}

declare void @use(i1 %c)

define void @eq_umax_contextual(i32 %x, i32 %y, i32 %z) {
; CHECK-LABEL: @eq_umax_contextual(
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[X:%.*]], [[Z:%.*]]
; CHECK-NEXT:    br i1 [[CMP]], label [[IF:%.*]], label [[END:%.*]]
; CHECK:       if:
; CHECK-NEXT:    [[COND:%.*]] = call i32 @llvm.umax.i32(i32 [[X]], i32 [[Y:%.*]])
; CHECK-NEXT:    [[CMP1:%.*]] = icmp slt i32 [[COND]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP1]])
; CHECK-NEXT:    [[CMP2:%.*]] = icmp sle i32 [[COND]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP2]])
; CHECK-NEXT:    [[CMP3:%.*]] = icmp sgt i32 [[COND]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP3]])
; CHECK-NEXT:    [[CMP4:%.*]] = icmp sge i32 [[COND]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP4]])
; CHECK-NEXT:    call void @use(i1 false)
; CHECK-NEXT:    [[CMP6:%.*]] = icmp ule i32 [[Y]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP6]])
; CHECK-NEXT:    [[CMP7:%.*]] = icmp ugt i32 [[Y]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP7]])
; CHECK-NEXT:    call void @use(i1 true)
; CHECK-NEXT:    [[CMP9:%.*]] = icmp uge i32 [[X]], [[Y]]
; CHECK-NEXT:    call void @use(i1 [[CMP9]])
; CHECK-NEXT:    [[CMP10:%.*]] = icmp ult i32 [[X]], [[Y]]
; CHECK-NEXT:    call void @use(i1 [[CMP10]])
; CHECK-NEXT:    ret void
; CHECK:       end:
; CHECK-NEXT:    ret void
;
  %cmp = icmp eq i32 %x, %z
  br i1 %cmp, label %if, label %end
if:
  %cond = call i32 @llvm.umax.i32(i32 %x, i32 %y)
  %cmp1 = icmp slt i32 %cond, %z
  call void @use(i1 %cmp1)
  %cmp2 = icmp sle i32 %cond, %z
  call void @use(i1 %cmp2)
  %cmp3 = icmp sgt i32 %cond, %z
  call void @use(i1 %cmp3)
  %cmp4 = icmp sge i32 %cond, %z
  call void @use(i1 %cmp4)
  %cmp5 = icmp ult i32 %cond, %z
  call void @use(i1 %cmp5)
  %cmp6 = icmp ule i32 %cond, %z
  call void @use(i1 %cmp6)
  %cmp7 = icmp ugt i32 %cond, %z
  call void @use(i1 %cmp7)
  %cmp8 = icmp uge i32 %cond, %z
  call void @use(i1 %cmp8)
  %cmp9 = icmp eq i32 %cond, %z
  call void @use(i1 %cmp9)
  %cmp10 = icmp ne i32 %cond, %z
  call void @use(i1 %cmp10)
  ret void
end:
  ret void
}

define void @eq_umax_contextual_commuted(i32 %x, i32 %y, i32 %z) {
; CHECK-LABEL: @eq_umax_contextual_commuted(
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[X:%.*]], [[Z:%.*]]
; CHECK-NEXT:    br i1 [[CMP]], label [[IF:%.*]], label [[END:%.*]]
; CHECK:       if:
; CHECK-NEXT:    [[COND:%.*]] = call i32 @llvm.umax.i32(i32 [[Y:%.*]], i32 [[X]])
; CHECK-NEXT:    [[CMP1:%.*]] = icmp slt i32 [[COND]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP1]])
; CHECK-NEXT:    [[CMP2:%.*]] = icmp sle i32 [[COND]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP2]])
; CHECK-NEXT:    [[CMP3:%.*]] = icmp sgt i32 [[COND]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP3]])
; CHECK-NEXT:    [[CMP4:%.*]] = icmp sge i32 [[COND]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP4]])
; CHECK-NEXT:    call void @use(i1 false)
; CHECK-NEXT:    [[CMP6:%.*]] = icmp ule i32 [[Y]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP6]])
; CHECK-NEXT:    [[CMP7:%.*]] = icmp ugt i32 [[Y]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP7]])
; CHECK-NEXT:    call void @use(i1 true)
; CHECK-NEXT:    [[CMP9:%.*]] = icmp uge i32 [[X]], [[Y]]
; CHECK-NEXT:    call void @use(i1 [[CMP9]])
; CHECK-NEXT:    [[CMP10:%.*]] = icmp ult i32 [[X]], [[Y]]
; CHECK-NEXT:    call void @use(i1 [[CMP10]])
; CHECK-NEXT:    ret void
; CHECK:       end:
; CHECK-NEXT:    ret void
;
  %cmp = icmp eq i32 %x, %z
  br i1 %cmp, label %if, label %end
if:
  %cond = call i32 @llvm.umax.i32(i32 %y, i32 %x)
  %cmp1 = icmp slt i32 %cond, %z
  call void @use(i1 %cmp1)
  %cmp2 = icmp sle i32 %cond, %z
  call void @use(i1 %cmp2)
  %cmp3 = icmp sgt i32 %cond, %z
  call void @use(i1 %cmp3)
  %cmp4 = icmp sge i32 %cond, %z
  call void @use(i1 %cmp4)
  %cmp5 = icmp ult i32 %cond, %z
  call void @use(i1 %cmp5)
  %cmp6 = icmp ule i32 %cond, %z
  call void @use(i1 %cmp6)
  %cmp7 = icmp ugt i32 %cond, %z
  call void @use(i1 %cmp7)
  %cmp8 = icmp uge i32 %cond, %z
  call void @use(i1 %cmp8)
  %cmp9 = icmp eq i32 %cond, %z
  call void @use(i1 %cmp9)
  %cmp10 = icmp ne i32 %cond, %z
  call void @use(i1 %cmp10)
  ret void
end:
  ret void
}

define void @ult_umax_contextual(i32 %x, i32 %y, i32 %z) {
; CHECK-LABEL: @ult_umax_contextual(
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i32 [[X:%.*]], [[Z:%.*]]
; CHECK-NEXT:    br i1 [[CMP]], label [[IF:%.*]], label [[END:%.*]]
; CHECK:       if:
; CHECK-NEXT:    [[COND:%.*]] = call i32 @llvm.umax.i32(i32 [[X]], i32 [[Y:%.*]])
; CHECK-NEXT:    [[CMP1:%.*]] = icmp slt i32 [[COND]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP1]])
; CHECK-NEXT:    [[CMP2:%.*]] = icmp sle i32 [[COND]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP2]])
; CHECK-NEXT:    [[CMP3:%.*]] = icmp sgt i32 [[COND]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP3]])
; CHECK-NEXT:    [[CMP4:%.*]] = icmp sge i32 [[COND]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP4]])
; CHECK-NEXT:    [[CMP5:%.*]] = icmp ult i32 [[Y]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP5]])
; CHECK-NEXT:    [[CMP6:%.*]] = icmp ule i32 [[Y]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP6]])
; CHECK-NEXT:    [[CMP7:%.*]] = icmp ugt i32 [[Y]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP7]])
; CHECK-NEXT:    [[CMP8:%.*]] = icmp uge i32 [[Y]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP8]])
; CHECK-NEXT:    [[CMP9:%.*]] = icmp eq i32 [[Y]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP9]])
; CHECK-NEXT:    [[CMP10:%.*]] = icmp ne i32 [[Y]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP10]])
; CHECK-NEXT:    ret void
; CHECK:       end:
; CHECK-NEXT:    ret void
;
  %cmp = icmp ult i32 %x, %z
  br i1 %cmp, label %if, label %end
if:
  %cond = call i32 @llvm.umax.i32(i32 %x, i32 %y)
  %cmp1 = icmp slt i32 %cond, %z
  call void @use(i1 %cmp1)
  %cmp2 = icmp sle i32 %cond, %z
  call void @use(i1 %cmp2)
  %cmp3 = icmp sgt i32 %cond, %z
  call void @use(i1 %cmp3)
  %cmp4 = icmp sge i32 %cond, %z
  call void @use(i1 %cmp4)
  %cmp5 = icmp ult i32 %cond, %z
  call void @use(i1 %cmp5)
  %cmp6 = icmp ule i32 %cond, %z
  call void @use(i1 %cmp6)
  %cmp7 = icmp ugt i32 %cond, %z
  call void @use(i1 %cmp7)
  %cmp8 = icmp uge i32 %cond, %z
  call void @use(i1 %cmp8)
  %cmp9 = icmp eq i32 %cond, %z
  call void @use(i1 %cmp9)
  %cmp10 = icmp ne i32 %cond, %z
  call void @use(i1 %cmp10)
  ret void
end:
  ret void
}

define void @ult_umax_contextual_commuted(i32 %x, i32 %y, i32 %z) {
; CHECK-LABEL: @ult_umax_contextual_commuted(
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i32 [[X:%.*]], [[Z:%.*]]
; CHECK-NEXT:    br i1 [[CMP]], label [[IF:%.*]], label [[END:%.*]]
; CHECK:       if:
; CHECK-NEXT:    [[COND:%.*]] = call i32 @llvm.umax.i32(i32 [[Y:%.*]], i32 [[X]])
; CHECK-NEXT:    [[CMP1:%.*]] = icmp slt i32 [[COND]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP1]])
; CHECK-NEXT:    [[CMP2:%.*]] = icmp sle i32 [[COND]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP2]])
; CHECK-NEXT:    [[CMP3:%.*]] = icmp sgt i32 [[COND]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP3]])
; CHECK-NEXT:    [[CMP4:%.*]] = icmp sge i32 [[COND]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP4]])
; CHECK-NEXT:    [[CMP5:%.*]] = icmp ult i32 [[Y]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP5]])
; CHECK-NEXT:    [[CMP6:%.*]] = icmp ule i32 [[Y]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP6]])
; CHECK-NEXT:    [[CMP7:%.*]] = icmp ugt i32 [[Y]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP7]])
; CHECK-NEXT:    [[CMP8:%.*]] = icmp uge i32 [[Y]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP8]])
; CHECK-NEXT:    [[CMP9:%.*]] = icmp eq i32 [[Y]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP9]])
; CHECK-NEXT:    [[CMP10:%.*]] = icmp ne i32 [[Y]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP10]])
; CHECK-NEXT:    ret void
; CHECK:       end:
; CHECK-NEXT:    ret void
;
  %cmp = icmp ult i32 %x, %z
  br i1 %cmp, label %if, label %end
if:
  %cond = call i32 @llvm.umax.i32(i32 %y, i32 %x)
  %cmp1 = icmp slt i32 %cond, %z
  call void @use(i1 %cmp1)
  %cmp2 = icmp sle i32 %cond, %z
  call void @use(i1 %cmp2)
  %cmp3 = icmp sgt i32 %cond, %z
  call void @use(i1 %cmp3)
  %cmp4 = icmp sge i32 %cond, %z
  call void @use(i1 %cmp4)
  %cmp5 = icmp ult i32 %cond, %z
  call void @use(i1 %cmp5)
  %cmp6 = icmp ule i32 %cond, %z
  call void @use(i1 %cmp6)
  %cmp7 = icmp ugt i32 %cond, %z
  call void @use(i1 %cmp7)
  %cmp8 = icmp uge i32 %cond, %z
  call void @use(i1 %cmp8)
  %cmp9 = icmp eq i32 %cond, %z
  call void @use(i1 %cmp9)
  %cmp10 = icmp ne i32 %cond, %z
  call void @use(i1 %cmp10)
  ret void
end:
  ret void
}

define void @ule_umax_contextual(i32 %x, i32 %y, i32 %z) {
; CHECK-LABEL: @ule_umax_contextual(
; CHECK-NEXT:    [[CMP_NOT:%.*]] = icmp ugt i32 [[X:%.*]], [[Z:%.*]]
; CHECK-NEXT:    br i1 [[CMP_NOT]], label [[END:%.*]], label [[IF:%.*]]
; CHECK:       if:
; CHECK-NEXT:    [[COND:%.*]] = call i32 @llvm.umax.i32(i32 [[X]], i32 [[Y:%.*]])
; CHECK-NEXT:    [[CMP1:%.*]] = icmp slt i32 [[COND]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP1]])
; CHECK-NEXT:    [[CMP2:%.*]] = icmp sle i32 [[COND]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP2]])
; CHECK-NEXT:    [[CMP3:%.*]] = icmp sgt i32 [[COND]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP3]])
; CHECK-NEXT:    [[CMP4:%.*]] = icmp sge i32 [[COND]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP4]])
; CHECK-NEXT:    [[CMP5:%.*]] = icmp ult i32 [[COND]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP5]])
; CHECK-NEXT:    [[CMP6:%.*]] = icmp ule i32 [[Y]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP6]])
; CHECK-NEXT:    [[CMP7:%.*]] = icmp ugt i32 [[Y]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP7]])
; CHECK-NEXT:    [[CMP8:%.*]] = icmp uge i32 [[COND]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP8]])
; CHECK-NEXT:    [[CMP9:%.*]] = icmp eq i32 [[COND]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP9]])
; CHECK-NEXT:    [[CMP10:%.*]] = icmp ne i32 [[COND]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP10]])
; CHECK-NEXT:    ret void
; CHECK:       end:
; CHECK-NEXT:    ret void
;
  %cmp = icmp ule i32 %x, %z
  br i1 %cmp, label %if, label %end
if:
  %cond = call i32 @llvm.umax.i32(i32 %x, i32 %y)
  %cmp1 = icmp slt i32 %cond, %z
  call void @use(i1 %cmp1)
  %cmp2 = icmp sle i32 %cond, %z
  call void @use(i1 %cmp2)
  %cmp3 = icmp sgt i32 %cond, %z
  call void @use(i1 %cmp3)
  %cmp4 = icmp sge i32 %cond, %z
  call void @use(i1 %cmp4)
  %cmp5 = icmp ult i32 %cond, %z
  call void @use(i1 %cmp5)
  %cmp6 = icmp ule i32 %cond, %z
  call void @use(i1 %cmp6)
  %cmp7 = icmp ugt i32 %cond, %z
  call void @use(i1 %cmp7)
  %cmp8 = icmp uge i32 %cond, %z
  call void @use(i1 %cmp8)
  %cmp9 = icmp eq i32 %cond, %z
  call void @use(i1 %cmp9)
  %cmp10 = icmp ne i32 %cond, %z
  call void @use(i1 %cmp10)
  ret void
end:
  ret void
}

define void @ule_umax_contextual_commuted(i32 %x, i32 %y, i32 %z) {
; CHECK-LABEL: @ule_umax_contextual_commuted(
; CHECK-NEXT:    [[CMP_NOT:%.*]] = icmp ugt i32 [[X:%.*]], [[Z:%.*]]
; CHECK-NEXT:    br i1 [[CMP_NOT]], label [[END:%.*]], label [[IF:%.*]]
; CHECK:       if:
; CHECK-NEXT:    [[COND:%.*]] = call i32 @llvm.umax.i32(i32 [[Y:%.*]], i32 [[X]])
; CHECK-NEXT:    [[CMP1:%.*]] = icmp slt i32 [[COND]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP1]])
; CHECK-NEXT:    [[CMP2:%.*]] = icmp sle i32 [[COND]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP2]])
; CHECK-NEXT:    [[CMP3:%.*]] = icmp sgt i32 [[COND]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP3]])
; CHECK-NEXT:    [[CMP4:%.*]] = icmp sge i32 [[COND]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP4]])
; CHECK-NEXT:    [[CMP5:%.*]] = icmp ult i32 [[COND]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP5]])
; CHECK-NEXT:    [[CMP6:%.*]] = icmp ule i32 [[Y]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP6]])
; CHECK-NEXT:    [[CMP7:%.*]] = icmp ugt i32 [[Y]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP7]])
; CHECK-NEXT:    [[CMP8:%.*]] = icmp uge i32 [[COND]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP8]])
; CHECK-NEXT:    [[CMP9:%.*]] = icmp eq i32 [[COND]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP9]])
; CHECK-NEXT:    [[CMP10:%.*]] = icmp ne i32 [[COND]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP10]])
; CHECK-NEXT:    ret void
; CHECK:       end:
; CHECK-NEXT:    ret void
;
  %cmp = icmp ule i32 %x, %z
  br i1 %cmp, label %if, label %end
if:
  %cond = call i32 @llvm.umax.i32(i32 %y, i32 %x)
  %cmp1 = icmp slt i32 %cond, %z
  call void @use(i1 %cmp1)
  %cmp2 = icmp sle i32 %cond, %z
  call void @use(i1 %cmp2)
  %cmp3 = icmp sgt i32 %cond, %z
  call void @use(i1 %cmp3)
  %cmp4 = icmp sge i32 %cond, %z
  call void @use(i1 %cmp4)
  %cmp5 = icmp ult i32 %cond, %z
  call void @use(i1 %cmp5)
  %cmp6 = icmp ule i32 %cond, %z
  call void @use(i1 %cmp6)
  %cmp7 = icmp ugt i32 %cond, %z
  call void @use(i1 %cmp7)
  %cmp8 = icmp uge i32 %cond, %z
  call void @use(i1 %cmp8)
  %cmp9 = icmp eq i32 %cond, %z
  call void @use(i1 %cmp9)
  %cmp10 = icmp ne i32 %cond, %z
  call void @use(i1 %cmp10)
  ret void
end:
  ret void
}

define void @ugt_umax_contextual(i32 %x, i32 %y, i32 %z) {
; CHECK-LABEL: @ugt_umax_contextual(
; CHECK-NEXT:    [[CMP:%.*]] = icmp ugt i32 [[X:%.*]], [[Z:%.*]]
; CHECK-NEXT:    br i1 [[CMP]], label [[IF:%.*]], label [[END:%.*]]
; CHECK:       if:
; CHECK-NEXT:    [[COND:%.*]] = call i32 @llvm.umax.i32(i32 [[X]], i32 [[Y:%.*]])
; CHECK-NEXT:    [[CMP1:%.*]] = icmp slt i32 [[COND]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP1]])
; CHECK-NEXT:    [[CMP2:%.*]] = icmp sle i32 [[COND]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP2]])
; CHECK-NEXT:    [[CMP3:%.*]] = icmp sgt i32 [[COND]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP3]])
; CHECK-NEXT:    [[CMP4:%.*]] = icmp sge i32 [[COND]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP4]])
; CHECK-NEXT:    call void @use(i1 false)
; CHECK-NEXT:    call void @use(i1 false)
; CHECK-NEXT:    call void @use(i1 true)
; CHECK-NEXT:    call void @use(i1 true)
; CHECK-NEXT:    call void @use(i1 false)
; CHECK-NEXT:    call void @use(i1 true)
; CHECK-NEXT:    ret void
; CHECK:       end:
; CHECK-NEXT:    ret void
;
  %cmp = icmp ugt i32 %x, %z
  br i1 %cmp, label %if, label %end
if:
  %cond = call i32 @llvm.umax.i32(i32 %x, i32 %y)
  %cmp1 = icmp slt i32 %cond, %z
  call void @use(i1 %cmp1)
  %cmp2 = icmp sle i32 %cond, %z
  call void @use(i1 %cmp2)
  %cmp3 = icmp sgt i32 %cond, %z
  call void @use(i1 %cmp3)
  %cmp4 = icmp sge i32 %cond, %z
  call void @use(i1 %cmp4)
  %cmp5 = icmp ult i32 %cond, %z
  call void @use(i1 %cmp5)
  %cmp6 = icmp ule i32 %cond, %z
  call void @use(i1 %cmp6)
  %cmp7 = icmp ugt i32 %cond, %z
  call void @use(i1 %cmp7)
  %cmp8 = icmp uge i32 %cond, %z
  call void @use(i1 %cmp8)
  %cmp9 = icmp eq i32 %cond, %z
  call void @use(i1 %cmp9)
  %cmp10 = icmp ne i32 %cond, %z
  call void @use(i1 %cmp10)
  ret void
end:
  ret void
}

define void @ugt_umax_contextual_commuted(i32 %x, i32 %y, i32 %z) {
; CHECK-LABEL: @ugt_umax_contextual_commuted(
; CHECK-NEXT:    [[CMP:%.*]] = icmp ugt i32 [[X:%.*]], [[Z:%.*]]
; CHECK-NEXT:    br i1 [[CMP]], label [[IF:%.*]], label [[END:%.*]]
; CHECK:       if:
; CHECK-NEXT:    [[COND:%.*]] = call i32 @llvm.umax.i32(i32 [[Y:%.*]], i32 [[X]])
; CHECK-NEXT:    [[CMP1:%.*]] = icmp slt i32 [[COND]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP1]])
; CHECK-NEXT:    [[CMP2:%.*]] = icmp sle i32 [[COND]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP2]])
; CHECK-NEXT:    [[CMP3:%.*]] = icmp sgt i32 [[COND]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP3]])
; CHECK-NEXT:    [[CMP4:%.*]] = icmp sge i32 [[COND]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP4]])
; CHECK-NEXT:    call void @use(i1 false)
; CHECK-NEXT:    call void @use(i1 false)
; CHECK-NEXT:    call void @use(i1 true)
; CHECK-NEXT:    call void @use(i1 true)
; CHECK-NEXT:    call void @use(i1 false)
; CHECK-NEXT:    call void @use(i1 true)
; CHECK-NEXT:    ret void
; CHECK:       end:
; CHECK-NEXT:    ret void
;
  %cmp = icmp ugt i32 %x, %z
  br i1 %cmp, label %if, label %end
if:
  %cond = call i32 @llvm.umax.i32(i32 %y, i32 %x)
  %cmp1 = icmp slt i32 %cond, %z
  call void @use(i1 %cmp1)
  %cmp2 = icmp sle i32 %cond, %z
  call void @use(i1 %cmp2)
  %cmp3 = icmp sgt i32 %cond, %z
  call void @use(i1 %cmp3)
  %cmp4 = icmp sge i32 %cond, %z
  call void @use(i1 %cmp4)
  %cmp5 = icmp ult i32 %cond, %z
  call void @use(i1 %cmp5)
  %cmp6 = icmp ule i32 %cond, %z
  call void @use(i1 %cmp6)
  %cmp7 = icmp ugt i32 %cond, %z
  call void @use(i1 %cmp7)
  %cmp8 = icmp uge i32 %cond, %z
  call void @use(i1 %cmp8)
  %cmp9 = icmp eq i32 %cond, %z
  call void @use(i1 %cmp9)
  %cmp10 = icmp ne i32 %cond, %z
  call void @use(i1 %cmp10)
  ret void
end:
  ret void
}

define void @uge_umax_contextual(i32 %x, i32 %y, i32 %z) {
; CHECK-LABEL: @uge_umax_contextual(
; CHECK-NEXT:    [[CMP_NOT:%.*]] = icmp ult i32 [[X:%.*]], [[Z:%.*]]
; CHECK-NEXT:    br i1 [[CMP_NOT]], label [[END:%.*]], label [[IF:%.*]]
; CHECK:       if:
; CHECK-NEXT:    [[COND:%.*]] = call i32 @llvm.umax.i32(i32 [[X]], i32 [[Y:%.*]])
; CHECK-NEXT:    [[CMP1:%.*]] = icmp slt i32 [[COND]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP1]])
; CHECK-NEXT:    [[CMP2:%.*]] = icmp sle i32 [[COND]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP2]])
; CHECK-NEXT:    [[CMP3:%.*]] = icmp sgt i32 [[COND]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP3]])
; CHECK-NEXT:    [[CMP4:%.*]] = icmp sge i32 [[COND]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP4]])
; CHECK-NEXT:    call void @use(i1 false)
; CHECK-NEXT:    [[CMP6:%.*]] = icmp ule i32 [[COND]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP6]])
; CHECK-NEXT:    [[CMP7:%.*]] = icmp ugt i32 [[COND]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP7]])
; CHECK-NEXT:    call void @use(i1 true)
; CHECK-NEXT:    [[CMP9:%.*]] = icmp eq i32 [[COND]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP9]])
; CHECK-NEXT:    [[CMP10:%.*]] = icmp ne i32 [[COND]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP10]])
; CHECK-NEXT:    ret void
; CHECK:       end:
; CHECK-NEXT:    ret void
;
  %cmp = icmp uge i32 %x, %z
  br i1 %cmp, label %if, label %end
if:
  %cond = call i32 @llvm.umax.i32(i32 %x, i32 %y)
  %cmp1 = icmp slt i32 %cond, %z
  call void @use(i1 %cmp1)
  %cmp2 = icmp sle i32 %cond, %z
  call void @use(i1 %cmp2)
  %cmp3 = icmp sgt i32 %cond, %z
  call void @use(i1 %cmp3)
  %cmp4 = icmp sge i32 %cond, %z
  call void @use(i1 %cmp4)
  %cmp5 = icmp ult i32 %cond, %z
  call void @use(i1 %cmp5)
  %cmp6 = icmp ule i32 %cond, %z
  call void @use(i1 %cmp6)
  %cmp7 = icmp ugt i32 %cond, %z
  call void @use(i1 %cmp7)
  %cmp8 = icmp uge i32 %cond, %z
  call void @use(i1 %cmp8)
  %cmp9 = icmp eq i32 %cond, %z
  call void @use(i1 %cmp9)
  %cmp10 = icmp ne i32 %cond, %z
  call void @use(i1 %cmp10)
  ret void
end:
  ret void
}

define void @uge_umax_contextual_commuted(i32 %x, i32 %y, i32 %z) {
; CHECK-LABEL: @uge_umax_contextual_commuted(
; CHECK-NEXT:    [[CMP_NOT:%.*]] = icmp ult i32 [[X:%.*]], [[Z:%.*]]
; CHECK-NEXT:    br i1 [[CMP_NOT]], label [[END:%.*]], label [[IF:%.*]]
; CHECK:       if:
; CHECK-NEXT:    [[COND:%.*]] = call i32 @llvm.umax.i32(i32 [[Y:%.*]], i32 [[X]])
; CHECK-NEXT:    [[CMP1:%.*]] = icmp slt i32 [[COND]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP1]])
; CHECK-NEXT:    [[CMP2:%.*]] = icmp sle i32 [[COND]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP2]])
; CHECK-NEXT:    [[CMP3:%.*]] = icmp sgt i32 [[COND]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP3]])
; CHECK-NEXT:    [[CMP4:%.*]] = icmp sge i32 [[COND]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP4]])
; CHECK-NEXT:    call void @use(i1 false)
; CHECK-NEXT:    [[CMP6:%.*]] = icmp ule i32 [[COND]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP6]])
; CHECK-NEXT:    [[CMP7:%.*]] = icmp ugt i32 [[COND]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP7]])
; CHECK-NEXT:    call void @use(i1 true)
; CHECK-NEXT:    [[CMP9:%.*]] = icmp eq i32 [[COND]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP9]])
; CHECK-NEXT:    [[CMP10:%.*]] = icmp ne i32 [[COND]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[CMP10]])
; CHECK-NEXT:    ret void
; CHECK:       end:
; CHECK-NEXT:    ret void
;
  %cmp = icmp uge i32 %x, %z
  br i1 %cmp, label %if, label %end
if:
  %cond = call i32 @llvm.umax.i32(i32 %y, i32 %x)
  %cmp1 = icmp slt i32 %cond, %z
  call void @use(i1 %cmp1)
  %cmp2 = icmp sle i32 %cond, %z
  call void @use(i1 %cmp2)
  %cmp3 = icmp sgt i32 %cond, %z
  call void @use(i1 %cmp3)
  %cmp4 = icmp sge i32 %cond, %z
  call void @use(i1 %cmp4)
  %cmp5 = icmp ult i32 %cond, %z
  call void @use(i1 %cmp5)
  %cmp6 = icmp ule i32 %cond, %z
  call void @use(i1 %cmp6)
  %cmp7 = icmp ugt i32 %cond, %z
  call void @use(i1 %cmp7)
  %cmp8 = icmp uge i32 %cond, %z
  call void @use(i1 %cmp8)
  %cmp9 = icmp eq i32 %cond, %z
  call void @use(i1 %cmp9)
  %cmp10 = icmp ne i32 %cond, %z
  call void @use(i1 %cmp10)
  ret void
end:
  ret void
}

declare i32 @llvm.umax.i32(i32, i32)
