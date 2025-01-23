; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64 -mattr=+gcs -verify-machineinstrs -o - %s | FileCheck %s

; We call each intrinsic twice, once with the result being unused and once with
; it being used, to check that dead code elimination is being done correctly.
; chkfeat does not have side effects so can be eliminated, but the others do and
; can't be eliminated.

define i64 @test_chkfeat(i64 %arg) {
; CHECK-LABEL: test_chkfeat:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov x16, x0
; CHECK-NEXT:    chkfeat x16
; CHECK-NEXT:    mov x0, x16
; CHECK-NEXT:    ret
entry:
  %0 = call i64 @llvm.aarch64.chkfeat(i64 %arg)
  %1 = call i64 @llvm.aarch64.chkfeat(i64 %arg)
  ret i64 %1
}

define i64 @test_gcspopm(i64 %arg) {
; CHECK-LABEL: test_gcspopm:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov x8, x0
; CHECK-NEXT:    gcspopm x8
; CHECK-NEXT:    gcspopm x0
; CHECK-NEXT:    ret
entry:
  %0 = call i64 @llvm.aarch64.gcspopm(i64 %arg)
  %1 = call i64 @llvm.aarch64.gcspopm(i64 %arg)
  ret i64 %1
}

define ptr @test_gcsss(ptr %p) {
; CHECK-LABEL: test_gcsss:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov x9, xzr
; CHECK-NEXT:    gcsss1 x0
; CHECK-NEXT:    mov x8, xzr
; CHECK-NEXT:    gcsss2 x9
; CHECK-NEXT:    gcsss1 x0
; CHECK-NEXT:    gcsss2 x8
; CHECK-NEXT:    mov x0, x8
; CHECK-NEXT:    ret
entry:
  %0 = call ptr @llvm.aarch64.gcsss(ptr %p)
  %1 = call ptr @llvm.aarch64.gcsss(ptr %p)
  ret ptr %1
}

declare i64 @llvm.aarch64.chkfeat(i64)
declare i64 @llvm.aarch64.gcspopm(i64)
declare ptr @llvm.aarch64.gcsss(ptr)
