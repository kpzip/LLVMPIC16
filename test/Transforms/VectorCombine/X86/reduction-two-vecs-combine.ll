; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 3
; RUN: opt -S --passes=vector-combine -mtriple=x86_64-unknown-linux < %s | FileCheck %s
; RUN: opt -S --passes=vector-combine -mtriple=x86_64-sie-ps5 < %s | FileCheck %s

define i16 @test_spill_mixed() {
; CHECK-LABEL: define i16 @test_spill_mixed() {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = shufflevector <32 x i32> zeroinitializer, <32 x i32> zeroinitializer, <4 x i32> <i32 28, i32 29, i32 30, i32 31>
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> [[TMP0]])
; CHECK-NEXT:    ret i16 0
;
entry:
  %0 = shufflevector <32 x i32> zeroinitializer, <32 x i32> zeroinitializer, <4 x i32> <i32 28, i32 29, i32 30, i32 31>
  %1 = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %0)
  ret i16 0
}

define i16 @crash() {
; CHECK-LABEL: define i16 @crash() {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = shufflevector <8 x i32> zeroinitializer, <8 x i32> zeroinitializer, <4 x i32> <i32 1, i32 2, i32 3, i32 9>
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> [[TMP0]])
; CHECK-NEXT:    ret i16 0
;
entry:
  %0 = shufflevector <8 x i32> zeroinitializer, <8 x i32> zeroinitializer, <4 x i32> <i32 1, i32 2, i32 3, i32 9>
  %1 = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %0)
  ret i16 0
}

declare i32 @llvm.vector.reduce.add.v4i32(<4 x i32>)
