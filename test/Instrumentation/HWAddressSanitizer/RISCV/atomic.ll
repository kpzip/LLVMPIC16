; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 2
; Test basic address sanitizer instrumentation.
;
; RUN: opt < %s -passes=hwasan -hwasan-inline-fast-path-checks=0 -S | FileCheck %s

target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux"

define void @atomicrmw(ptr %ptr) sanitize_hwaddress {
; CHECK-LABEL: define void @atomicrmw
; CHECK-SAME: (ptr [[PTR:%.*]]) #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load i64, ptr @__hwasan_tls, align 8
; CHECK-NEXT:    [[TMP1:%.*]] = and i64 [[TMP0]], 72057594037927935
; CHECK-NEXT:    [[TMP2:%.*]] = or i64 [[TMP1]], 4294967295
; CHECK-NEXT:    [[HWASAN_SHADOW:%.*]] = add i64 [[TMP2]], 1
; CHECK-NEXT:    [[TMP3:%.*]] = inttoptr i64 [[HWASAN_SHADOW]] to ptr
; CHECK-NEXT:    call void @llvm.hwasan.check.memaccess.shortgranules(ptr [[TMP3]], ptr [[PTR]], i32 19)
; CHECK-NEXT:    [[TMP4:%.*]] = atomicrmw add ptr [[PTR]], i64 1 seq_cst, align 8
; CHECK-NEXT:    ret void
;

entry:
  %0 = atomicrmw add ptr %ptr, i64 1 seq_cst
  ret void
}

define void @cmpxchg(ptr %ptr, i64 %compare_to, i64 %new_value) sanitize_hwaddress {
; CHECK-LABEL: define void @cmpxchg
; CHECK-SAME: (ptr [[PTR:%.*]], i64 [[COMPARE_TO:%.*]], i64 [[NEW_VALUE:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load i64, ptr @__hwasan_tls, align 8
; CHECK-NEXT:    [[TMP1:%.*]] = and i64 [[TMP0]], 72057594037927935
; CHECK-NEXT:    [[TMP2:%.*]] = or i64 [[TMP1]], 4294967295
; CHECK-NEXT:    [[HWASAN_SHADOW:%.*]] = add i64 [[TMP2]], 1
; CHECK-NEXT:    [[TMP3:%.*]] = inttoptr i64 [[HWASAN_SHADOW]] to ptr
; CHECK-NEXT:    call void @llvm.hwasan.check.memaccess.shortgranules(ptr [[TMP3]], ptr [[PTR]], i32 19)
; CHECK-NEXT:    [[TMP4:%.*]] = cmpxchg ptr [[PTR]], i64 [[COMPARE_TO]], i64 [[NEW_VALUE]] seq_cst seq_cst, align 8
; CHECK-NEXT:    ret void
;

entry:
  %0 = cmpxchg ptr %ptr, i64 %compare_to, i64 %new_value seq_cst seq_cst
  ret void
}
