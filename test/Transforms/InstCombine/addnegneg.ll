; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 4
; RUN: opt < %s -passes=instcombine -S | FileCheck %s
; PR2047

define i32 @l(i32 %a, i32 %b, i32 %c, i32 %d) {
; CHECK-LABEL: define i32 @l(
; CHECK-SAME: i32 [[A:%.*]], i32 [[B:%.*]], i32 [[C:%.*]], i32 [[D:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = add i32 [[C]], [[B]]
; CHECK-NEXT:    [[SUB6:%.*]] = sub i32 [[D]], [[TMP0]]
; CHECK-NEXT:    ret i32 [[SUB6]]
;
entry:
  %b.neg = sub i32 0, %b		; <i32> [#uses=1]
  %c.neg = sub i32 0, %c		; <i32> [#uses=1]
  %sub4 = add i32 %c.neg, %b.neg		; <i32> [#uses=1]
  %sub6 = add i32 %sub4, %d		; <i32> [#uses=1]
  ret i32 %sub6
}
