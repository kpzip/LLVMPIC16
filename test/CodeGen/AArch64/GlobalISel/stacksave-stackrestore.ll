; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc -global-isel=1 -mtriple=aarch64-linux-gnu -o - %s | FileCheck %s

declare void @use_addr(ptr)
declare ptr @llvm.stacksave.p0()
declare void @llvm.stackrestore.p0(ptr)

define void @test_scoped_alloca(i64 %n) {
; CHECK-LABEL: test_scoped_alloca:
; CHECK:       // %bb.0:
; CHECK-NEXT:    stp x29, x30, [sp, #-32]! // 16-byte Folded Spill
; CHECK-NEXT:    str x19, [sp, #16] // 8-byte Folded Spill
; CHECK-NEXT:    mov x29, sp
; CHECK-NEXT:    .cfi_def_cfa w29, 32
; CHECK-NEXT:    .cfi_offset w19, -16
; CHECK-NEXT:    .cfi_offset w30, -24
; CHECK-NEXT:    .cfi_offset w29, -32
; CHECK-NEXT:    add x9, x0, #15
; CHECK-NEXT:    mov x8, sp
; CHECK-NEXT:    mov x19, sp
; CHECK-NEXT:    and x9, x9, #0xfffffffffffffff0
; CHECK-NEXT:    sub x0, x8, x9
; CHECK-NEXT:    mov sp, x0
; CHECK-NEXT:    bl use_addr
; CHECK-NEXT:    mov sp, x19
; CHECK-NEXT:    mov sp, x29
; CHECK-NEXT:    ldr x19, [sp, #16] // 8-byte Folded Reload
; CHECK-NEXT:    ldp x29, x30, [sp], #32 // 16-byte Folded Reload
; CHECK-NEXT:    ret
  %sp = call ptr @llvm.stacksave.p0()
  %addr = alloca i8, i64 %n
  call void @use_addr(ptr %addr)
  call void @llvm.stackrestore.p0(ptr %sp)
  ret void
}
