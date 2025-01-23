; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=licm < %s | FileCheck %s

define void @test(ptr %a) {
; CHECK-LABEL: @test(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[V:%.*]] = load i32, ptr null, align 4
; CHECK-NEXT:    br label [[LOOP]]
;
entry:
  br label %loop

loop:
  store ptr null, ptr null
  %p = load ptr, ptr null
  %v = load i32, ptr %p
  store i32 %v, ptr %a
  br label %loop
}
