; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=riscv32 -global-isel=0 -fast-isel=0 | FileCheck %s
; RUN: llc < %s -mtriple=riscv32 -global-isel=1 -fast-isel=0 | FileCheck %s
; RUN: llc < %s -mtriple=riscv32 -global-isel=0 -fast-isel=1 | FileCheck %s

; RUN: llc < %s -mtriple=riscv64 -global-isel=0 -fast-isel=0 | FileCheck %s
; RUN: llc < %s -mtriple=riscv64 -global-isel=1 -fast-isel=0 | FileCheck %s
; RUN: llc < %s -mtriple=riscv64 -global-isel=0 -fast-isel=1 | FileCheck %s

define i1 @test_runtime() local_unnamed_addr {
; CHECK-LABEL: test_runtime:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    li a0, 1
; CHECK-NEXT:    ret
entry:
  %allow = call i1 @llvm.allow.runtime.check(metadata !"test_check")
  ret i1 %allow
}

declare i1 @llvm.allow.runtime.check(metadata) nounwind

define i1 @test_ubsan() local_unnamed_addr {
; CHECK-LABEL: test_ubsan:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    li a0, 1
; CHECK-NEXT:    ret
entry:
  %allow = call i1 @llvm.allow.ubsan.check(i8 7)
  ret i1 %allow
}

declare i1 @llvm.allow.ubsan.check(i8) nounwind
