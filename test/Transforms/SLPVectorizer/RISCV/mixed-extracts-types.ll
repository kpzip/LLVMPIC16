; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 4
; RUN: opt -S --passes=slp-vectorizer -mtriple=riscv64-unknown-linux-gnu -mattr="+v" < %s | FileCheck %s

define i32 @test() {
; CHECK-LABEL: define i32 @test(
; CHECK-SAME: ) #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[VECTOR_RECUR_EXTRACT:%.*]] = extractelement <vscale x 4 x i8> zeroinitializer, i64 0
; CHECK-NEXT:    [[CONV5:%.*]] = sext i8 [[VECTOR_RECUR_EXTRACT]] to i32
; CHECK-NEXT:    store i32 [[CONV5]], ptr getelementptr ([0 x i32], ptr null, i64 0, i64 -14), align 4
; CHECK-NEXT:    [[TMP0:%.*]] = load <2 x i8>, ptr getelementptr ([9 x i8], ptr null, i64 -2, i64 5), align 1
; CHECK-NEXT:    [[TMP1:%.*]] = icmp ne <2 x i8> [[TMP0]], zeroinitializer
; CHECK-NEXT:    [[TMP2:%.*]] = zext <2 x i1> [[TMP1]] to <2 x i16>
; CHECK-NEXT:    store <2 x i16> [[TMP2]], ptr getelementptr ([0 x i16], ptr null, i64 0, i64 -14), align 2
; CHECK-NEXT:    [[TMP3:%.*]] = extractelement <2 x i8> [[TMP0]], i32 0
; CHECK-NEXT:    [[CONV5_1:%.*]] = sext i8 [[TMP3]] to i32
; CHECK-NEXT:    store i32 [[CONV5_1]], ptr getelementptr ([0 x i32], ptr null, i64 0, i64 -13), align 4
; CHECK-NEXT:    ret i32 0
;
entry:
  %vector.recur.extract = extractelement <vscale x 4 x i8> zeroinitializer, i64 0
  %0 = load i8, ptr getelementptr ([9 x i8], ptr null, i64 -2, i64 5), align 1
  %tobool1.not = icmp ne i8 %0, 0
  %conv2 = zext i1 %tobool1.not to i16
  store i16 %conv2, ptr getelementptr ([0 x i16], ptr null, i64 0, i64 -14), align 2
  %conv5 = sext i8 %vector.recur.extract to i32
  store i32 %conv5, ptr getelementptr ([0 x i32], ptr null, i64 0, i64 -14), align 4
  %1 = load i8, ptr getelementptr ([9 x i8], ptr null, i64 -2, i64 6), align 1
  %tobool1.not.1 = icmp ne i8 %1, 0
  %conv2.1 = zext i1 %tobool1.not.1 to i16
  store i16 %conv2.1, ptr getelementptr ([0 x i16], ptr null, i64 0, i64 -13), align 2
  %conv5.1 = sext i8 %0 to i32
  store i32 %conv5.1, ptr getelementptr ([0 x i32], ptr null, i64 0, i64 -13), align 4
  ret i32 0
}
