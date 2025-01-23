; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 5
; RUN: opt < %s -passes=instcombine -S | FileCheck %s
; PR2389

define i1 @test(i1 %a, i1 %b) {
; CHECK-LABEL: define i1 @test(
; CHECK-SAME: i1 [[A:%.*]], i1 [[B:%.*]]) {
; CHECK-NEXT:    [[R:%.*]] = xor i1 [[A]], [[B]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %r = add i1 %a, %b
  ret i1 %r
}
