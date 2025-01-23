; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 4
; RUN: opt -S --passes=slp-vectorizer -mtriple=x86_64-unknown-linux-gnu -slp-threshold=-99999 < %s | FileCheck %s

define void @test() {
; CHECK-LABEL: define void @test() {
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[TMP0:%.*]] = extractelement <2 x ptr> zeroinitializer, i32 0
; CHECK-NEXT:    [[GETELEMENTPTR6:%.*]] = getelementptr i8, ptr [[TMP0]], i64 872
; CHECK-NEXT:    store double 0.000000e+00, ptr [[GETELEMENTPTR6]], align 8
; CHECK-NEXT:    br label [[BB9:%.*]]
; CHECK:       bb9:
; CHECK-NEXT:    [[TMP1:%.*]] = phi <2 x ptr> [ getelementptr (i8, <2 x ptr> zeroinitializer, <2 x i64> <i64 32, i64 872>), [[BB:%.*]] ]
; CHECK-NEXT:    ret void
;
bb:
  %getelementptr = getelementptr i8, ptr null, i64 32
  %0 = extractelement <2 x ptr> zeroinitializer, i32 0
  %getelementptr6 = getelementptr i8, ptr %0, i64 872
  store double 0.000000e+00, ptr %getelementptr6, align 8
  br label %bb9

bb9:
  %phi10 = phi ptr [ %getelementptr, %bb ]
  %phi11 = phi ptr [ %getelementptr6, %bb ]
  ret void
}
