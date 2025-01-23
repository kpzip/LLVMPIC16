; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=newgvn -S | FileCheck %s


;; Block 6 is reachable, but edge 6->4 is not
;; This means the phi value is undef, not 0
; Function Attrs: ssp uwtable
define i16 @hoge() {
; CHECK-LABEL: @hoge(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    switch i8 undef, label [[BB7:%.*]] [
; CHECK-NEXT:      i8 0, label [[BB1:%.*]]
; CHECK-NEXT:      i8 12, label [[BB2:%.*]]
; CHECK-NEXT:    ]
; CHECK:       bb1:
; CHECK-NEXT:    br label [[BB6:%.*]]
; CHECK:       bb2:
; CHECK-NEXT:    br label [[BB4:%.*]]
; CHECK:       bb3:
; CHECK-NEXT:    unreachable
; CHECK:       bb4:
; CHECK-NEXT:    ret i16 undef
; CHECK:       bb6:
; CHECK-NEXT:    br i1 true, label [[BB3:%.*]], label [[BB4]]
; CHECK:       bb7:
; CHECK-NEXT:    unreachable
;
bb:
  switch i8 undef, label %bb7 [
  i8 0, label %bb1
  i8 12, label %bb2
  ]

bb1:                                              ; preds = %bb
  br label %bb6

bb2:                                              ; preds = %bb
  br label %bb4

bb3:                                              ; preds = %bb6
  unreachable

bb4:                                              ; preds = %bb6, %bb2
  %tmp = phi i16 [ 0, %bb6 ], [ undef, %bb2 ]
  ret i16 %tmp

bb6:                                              ; preds = %bb4
  br i1 true, label %bb3, label %bb4

bb7:                                              ; preds = %bb
  unreachable
}

define i8 @only_undef(i1 %cond) {
; CHECK-LABEL: @only_undef(
; CHECK-NEXT:    br i1 [[COND:%.*]], label [[A:%.*]], label [[B:%.*]]
; CHECK:       A:
; CHECK-NEXT:    br label [[EXIT:%.*]]
; CHECK:       B:
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       EXIT:
; CHECK-NEXT:    ret i8 undef
;
  br i1 %cond, label %A, label %B
A:
  br label %EXIT
B:
  br label %EXIT
EXIT:
  %r = phi i8 [undef, %A], [undef, %B]
  ret i8 %r
}

define i8 @only_poison(i1 %cond) {
; CHECK-LABEL: @only_poison(
; CHECK-NEXT:    br i1 [[COND:%.*]], label [[A:%.*]], label [[B:%.*]]
; CHECK:       A:
; CHECK-NEXT:    br label [[EXIT:%.*]]
; CHECK:       B:
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       EXIT:
; CHECK-NEXT:    ret i8 poison
;
  br i1 %cond, label %A, label %B
A:
  br label %EXIT
B:
  br label %EXIT
EXIT:
  %r = phi i8 [poison, %A], [poison, %B]
  ret i8 %r
}

define i8 @undef_poison(i1 %cond) {
; CHECK-LABEL: @undef_poison(
; CHECK-NEXT:    br i1 [[COND:%.*]], label [[A:%.*]], label [[B:%.*]]
; CHECK:       A:
; CHECK-NEXT:    br label [[EXIT:%.*]]
; CHECK:       B:
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       EXIT:
; CHECK-NEXT:    ret i8 undef
;
  br i1 %cond, label %A, label %B
A:
  br label %EXIT
B:
  br label %EXIT
EXIT:
  %r = phi i8 [undef, %A], [poison, %B]
  ret i8 %r
}

define i8 @value_undef(i1 %cond, i8 %v) {
; CHECK-LABEL: @value_undef(
; CHECK-NEXT:    br i1 [[COND:%.*]], label [[A:%.*]], label [[B:%.*]]
; CHECK:       A:
; CHECK-NEXT:    br label [[EXIT:%.*]]
; CHECK:       B:
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       EXIT:
; CHECK-NEXT:    [[R:%.*]] = phi i8 [ undef, [[A]] ], [ [[V:%.*]], [[B]] ]
; CHECK-NEXT:    ret i8 [[R]]
;
  br i1 %cond, label %A, label %B
A:
  br label %EXIT
B:
  br label %EXIT
EXIT:
  %r = phi i8 [undef, %A], [%v, %B]
  ret i8 %r
}

define i8 @value_undef_noundef(i1 %cond, i8 noundef %v) {
; CHECK-LABEL: @value_undef_noundef(
; CHECK-NEXT:    br i1 [[COND:%.*]], label [[A:%.*]], label [[B:%.*]]
; CHECK:       A:
; CHECK-NEXT:    br label [[EXIT:%.*]]
; CHECK:       B:
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       EXIT:
; CHECK-NEXT:    ret i8 [[V:%.*]]
;
  br i1 %cond, label %A, label %B
A:
  br label %EXIT
B:
  br label %EXIT
EXIT:
  %r = phi i8 [undef, %A], [%v, %B]
  ret i8 %r
}

define i8 @value_poison(i1 %cond, i8 %v) {
; CHECK-LABEL: @value_poison(
; CHECK-NEXT:    br i1 [[COND:%.*]], label [[A:%.*]], label [[B:%.*]]
; CHECK:       A:
; CHECK-NEXT:    br label [[EXIT:%.*]]
; CHECK:       B:
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       EXIT:
; CHECK-NEXT:    ret i8 [[V:%.*]]
;
  br i1 %cond, label %A, label %B
A:
  br label %EXIT
B:
  br label %EXIT
EXIT:
  %r = phi i8 [poison, %A], [%v, %B]
  ret i8 %r
}
