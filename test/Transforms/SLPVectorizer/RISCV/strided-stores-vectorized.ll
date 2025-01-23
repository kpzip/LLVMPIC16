; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=slp-vectorizer -S < %s -mtriple=riscv64-unknown-linux -mattr=+v | FileCheck %s

define void @store_reverse(ptr %p3) {
; CHECK-LABEL: @store_reverse(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ARRAYIDX1:%.*]] = getelementptr inbounds i64, ptr [[P3:%.*]], i64 8
; CHECK-NEXT:    [[ARRAYIDX2:%.*]] = getelementptr inbounds i64, ptr [[P3]], i64 7
; CHECK-NEXT:    [[TMP0:%.*]] = load <4 x i64>, ptr [[P3]], align 8
; CHECK-NEXT:    [[TMP1:%.*]] = load <4 x i64>, ptr [[ARRAYIDX1]], align 8
; CHECK-NEXT:    [[TMP2:%.*]] = shl <4 x i64> [[TMP0]], [[TMP1]]
; CHECK-NEXT:    call void @llvm.experimental.vp.strided.store.v4i64.p0.i64(<4 x i64> [[TMP2]], ptr align 8 [[ARRAYIDX2]], i64 -8, <4 x i1> <i1 true, i1 true, i1 true, i1 true>, i32 4)
; CHECK-NEXT:    ret void
;
entry:
  %0 = load i64, ptr %p3, align 8
  %arrayidx1 = getelementptr inbounds i64, ptr %p3, i64 8
  %1 = load i64, ptr %arrayidx1, align 8
  %shl = shl i64 %0, %1
  %arrayidx2 = getelementptr inbounds i64, ptr %p3, i64 7
  store i64 %shl, ptr %arrayidx2, align 8
  %arrayidx3 = getelementptr inbounds i64, ptr %p3, i64 1
  %2 = load i64, ptr %arrayidx3, align 8
  %arrayidx4 = getelementptr inbounds i64, ptr %p3, i64 9
  %3 = load i64, ptr %arrayidx4, align 8
  %shl5 = shl i64 %2, %3
  %arrayidx6 = getelementptr inbounds i64, ptr %p3, i64 6
  store i64 %shl5, ptr %arrayidx6, align 8
  %arrayidx7 = getelementptr inbounds i64, ptr %p3, i64 2
  %4 = load i64, ptr %arrayidx7, align 8
  %arrayidx8 = getelementptr inbounds i64, ptr %p3, i64 10
  %5 = load i64, ptr %arrayidx8, align 8
  %shl9 = shl i64 %4, %5
  %arrayidx10 = getelementptr inbounds i64, ptr %p3, i64 5
  store i64 %shl9, ptr %arrayidx10, align 8
  %arrayidx11 = getelementptr inbounds i64, ptr %p3, i64 3
  %6 = load i64, ptr %arrayidx11, align 8
  %arrayidx12 = getelementptr inbounds i64, ptr %p3, i64 11
  %7 = load i64, ptr %arrayidx12, align 8
  %shl13 = shl i64 %6, %7
  %arrayidx14 = getelementptr inbounds i64, ptr %p3, i64 4
  store i64 %shl13, ptr %arrayidx14, align 8
  ret void
}
