; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=slp-vectorizer -slp-vectorize-hor -slp-vectorize-hor-store -S < %s -mtriple=x86_64-unknown-linux-gnu | FileCheck %s

define void @test(ptr %ptr, ptr noalias %s)  {
; CHECK-LABEL: @test(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq ptr [[PTR:%.*]], null
; CHECK-NEXT:    br i1 [[CMP]], label [[LOOP:%.*]], label [[BAIL_OUT:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[TMP1:%.*]] = load <4 x i32>, ptr [[PTR]], align 4
; CHECK-NEXT:    store <4 x i32> [[TMP1]], ptr [[S:%.*]], align 4
; CHECK-NEXT:    [[TMP3:%.*]] = extractelement <4 x i32> [[TMP1]], i32 0
; CHECK-NEXT:    br label [[LOOP1:%.*]]
; CHECK:       loop1:
; CHECK-NEXT:    store i32 [[TMP3]], ptr [[S]], align 4
; CHECK-NEXT:    br i1 true, label [[LOOP1]], label [[CONT:%.*]]
; CHECK:       cont:
; CHECK-NEXT:    br i1 true, label [[LOOP]], label [[BAIL_OUT]]
; CHECK:       bail_out:
; CHECK-NEXT:    [[DUMMY_PHI:%.*]] = phi i32 [ 1, [[ENTRY:%.*]] ], [ [[TMP3]], [[CONT]] ]
; CHECK-NEXT:    store i32 [[DUMMY_PHI]], ptr [[S]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %cmp = icmp eq ptr %ptr, null
  br i1 %cmp, label %loop, label %bail_out

loop:
  %0 = load i32, ptr %ptr , align 4
  %1 = getelementptr inbounds i32, ptr %ptr, i64 1
  %2 = load i32, ptr %1 , align 4
  %3 = getelementptr inbounds i32, ptr %ptr, i64 2
  %4 = load i32, ptr %3 , align 4
  %5 = getelementptr inbounds i32, ptr %ptr, i64 3
  %6 = load i32, ptr %5 , align 4
  store i32 %0, ptr %s, align 4
  %7 = getelementptr inbounds i32, ptr %s, i64 1
  store i32 %2, ptr %7, align 4
  %8 = getelementptr inbounds i32, ptr %s, i64 2
  store i32 %4, ptr %8, align 4
  %9 = getelementptr inbounds i32, ptr %s, i64 3
  store i32 %6, ptr %9, align 4
  br label %loop1

loop1:
  store i32 %0, ptr %s, align 4
  br i1 true, label %loop1, label %cont

cont:
  br i1 true, label %loop, label %bail_out

bail_out:
  %dummy_phi = phi i32 [ 1, %entry ], [ %0, %cont ]
  store i32 %dummy_phi, ptr %s, align 4
  ret void
}

