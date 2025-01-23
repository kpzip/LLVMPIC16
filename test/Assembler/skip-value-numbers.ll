; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: -p --version 4
; RUN: opt -S < %s | FileCheck %s

define i32 @instr() {
; CHECK-LABEL: define i32 @instr() {
; CHECK-NEXT:    %1 = add i32 1, 2
; CHECK-NEXT:    %2 = add i32 %1, 3
; CHECK-NEXT:    %3 = add i32 %2, 4
; CHECK-NEXT:    ret i32 %3
;
  %10 = add i32 1, 2
  %20 = add i32 %10, 3
  %30 = add i32 %20, 4
  ret i32 %30
}

define i32 @instr_some_implicit() {
; CHECK-LABEL: define i32 @instr_some_implicit() {
; CHECK-NEXT:    %1 = add i32 1, 2
; CHECK-NEXT:    %2 = add i32 3, 4
; CHECK-NEXT:    %3 = add i32 %1, %2
; CHECK-NEXT:    ret i32 %3
;
  add i32 1, 2
  %10 = add i32 3, 4
  add i32 %1, %10
  ret i32 %11
}

define i32 @args(i32 %0, i32 %10, i32 %20) {
; CHECK-LABEL: define i32 @args(i32 %0, i32 %1, i32 %2) {
; CHECK-NEXT:    %4 = add i32 %0, %1
; CHECK-NEXT:    %5 = add i32 %4, %2
; CHECK-NEXT:    ret i32 %5
;
  %30 = add i32 %0, %10
  %31 = add i32 %30, %20
  ret i32 %31
}

define i32 @args_some_implicit(i32, i32 %10, i32) {
; CHECK-LABEL: define i32 @args_some_implicit(i32 %0, i32 %1, i32 %2) {
; CHECK-NEXT:    %4 = add i32 %0, %1
; CHECK-NEXT:    %5 = add i32 %2, %4
; CHECK-NEXT:    ret i32 %5
;
  add i32 %0, %10
  %20 = add i32 %11, %13
  ret i32 %20
}

define i32 @blocks() {
; CHECK-LABEL: define i32 @blocks() {
; CHECK-NEXT:    br label %1
; CHECK:       1:
; CHECK-NEXT:    ret i32 0
;
10:
  br label %20

20:
  ret i32 0
}

define i32 @blocks_some_implicit() {
; CHECK-LABEL: define i32 @blocks_some_implicit() {
; CHECK-NEXT:    br label %1
; CHECK:       1:
; CHECK-NEXT:    br label %2
; CHECK:       2:
; CHECK-NEXT:    ret i32 0
;
  br label %10

10:
  br label %11

  ret i32 0
}
