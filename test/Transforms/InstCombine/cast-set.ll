; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instcombine -S | FileCheck %s

target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128"

define i1 @test1(i32 %X) {
; CHECK-LABEL: @test1(
; CHECK-NEXT:    [[C:%.*]] = icmp ne i32 [[X:%.*]], 12
; CHECK-NEXT:    ret i1 [[C]]
;
  %A = bitcast i32 %X to i32
  ; Convert to setne int %X, 12
  %c = icmp ne i32 %A, 12
  ret i1 %c
}

define i1 @test2(i32 %X, i32 %Y) {
; CHECK-LABEL: @test2(
; CHECK-NEXT:    [[C:%.*]] = icmp ne i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    ret i1 [[C]]
;
  %A = bitcast i32 %X to i32
  %B = bitcast i32 %Y to i32
  ; Convert to setne int %X, %Y
  %c = icmp ne i32 %A, %B
  ret i1 %c
}

define i32 @test4(i32 %A) {
; CHECK-LABEL: @test4(
; CHECK-NEXT:    [[C:%.*]] = shl i32 [[A:%.*]], 2
; CHECK-NEXT:    ret i32 [[C]]
;
  %B = bitcast i32 %A to i32
  %C = shl i32 %B, 2
  %D = bitcast i32 %C to i32
  ret i32 %D
}

define i16 @test5(i16 %A) {
; CHECK-LABEL: @test5(
; CHECK-NEXT:    [[TMP1:%.*]] = and i16 [[A:%.*]], 15
; CHECK-NEXT:    ret i16 [[TMP1]]
;
  %B = sext i16 %A to i32
  %C = and i32 %B, 15
  %D = trunc i32 %C to i16
  ret i16 %D
}

define i1 @test6(i1 %A) {
; CHECK-LABEL: @test6(
; CHECK-NEXT:    ret i1 [[A:%.*]]
;
  %B = zext i1 %A to i32
  %C = icmp ne i32 %B, 0
  ret i1 %C
}

define i1 @test6a(i1 %A) {
; CHECK-LABEL: @test6a(
; CHECK-NEXT:    ret i1 true
;
  %B = zext i1 %A to i32
  %C = icmp ne i32 %B, -1
  ret i1 %C
}

define i1 @test7(ptr %A) {
; CHECK-LABEL: @test7(
; CHECK-NEXT:    [[C:%.*]] = icmp eq ptr [[A:%.*]], null
; CHECK-NEXT:    ret i1 [[C]]
;
  %C = icmp eq ptr %A, null
  ret i1 %C
}
