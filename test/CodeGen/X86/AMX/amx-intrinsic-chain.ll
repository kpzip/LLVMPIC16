; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+amx-int8 -mattr=+avx512f -verify-machineinstrs | FileCheck %s

define dso_local void @test_chain(ptr %A_mem, ptr %B_mem, ptr %C_mem) {
; CHECK-LABEL: test_chain:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vxorps %xmm0, %xmm0, %xmm0
; CHECK-NEXT:    vmovups %zmm0, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movb $1, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movb $16, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movw $64, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movb $16, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movw $64, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movb $16, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movw $64, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movb $16, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movw $64, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movb $16, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movw $64, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    ldtilecfg -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movl $64, %eax
; CHECK-NEXT:    movw $64, %cx
; CHECK-NEXT:    movw $16, %r8w
; CHECK-NEXT:    tileloadd (%rdi,%rax), %tmm0
; CHECK-NEXT:    addq $1024, %rdi # imm = 0x400
; CHECK-NEXT:    tileloadd (%rdi,%rax), %tmm1
; CHECK-NEXT:    tileloadd (%rdx,%rax), %tmm3
; CHECK-NEXT:    leaq 1024(%rdx), %rdi
; CHECK-NEXT:    tileloadd (%rdi,%rax), %tmm2
; CHECK-NEXT:    tileloadd (%rsi,%rax), %tmm4
; CHECK-NEXT:    tdpbssd %tmm4, %tmm0, %tmm3
; CHECK-NEXT:    tilestored %tmm3, (%rdx,%rax)
; CHECK-NEXT:    tdpbssd %tmm4, %tmm1, %tmm2
; CHECK-NEXT:    tilestored %tmm2, (%rdi,%rax)
; CHECK-NEXT:    tilerelease
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    retq
entry:
  %a1 = call x86_amx @llvm.x86.tileloadd64.internal(i16 16, i16 64, ptr nonnull %A_mem, i64 64)
  %addr = getelementptr inbounds i8, ptr %A_mem, i64 1024
  %a2 = call x86_amx @llvm.x86.tileloadd64.internal(i16 16, i16 64, ptr nonnull %addr, i64 64)
  %c1 = call x86_amx @llvm.x86.tileloadd64.internal(i16 16, i16 64, ptr nonnull %C_mem, i64 64)
  %caddr = getelementptr inbounds i8, ptr %C_mem, i64 1024
  %c2 = call x86_amx @llvm.x86.tileloadd64.internal(i16 16, i16 64, ptr nonnull %caddr, i64 64)
  br label %dotpd

dotpd:
  %b = call x86_amx @llvm.x86.tileloadd64.internal(i16 16, i16 64, ptr nonnull %B_mem, i64 64)
  %dp1 = call x86_amx @llvm.x86.tdpbssd.internal(i16 16, i16 64, i16 64, x86_amx %c1, x86_amx %a1, x86_amx %b)
  call void @llvm.x86.tilestored64.internal(i16 16, i16 64, ptr nonnull %C_mem, i64 64, x86_amx %dp1)
  %dp2 = call x86_amx @llvm.x86.tdpbssd.internal(i16 16, i16 64, i16 64, x86_amx %c2, x86_amx %a2, x86_amx %b)
  call void @llvm.x86.tilestored64.internal(i16 16, i16 64, ptr nonnull %caddr, i64 64, x86_amx %dp2)
  ret void
}

declare x86_amx @llvm.x86.tileloadd64.internal(i16, i16, ptr, i64)
declare x86_amx @llvm.x86.tdpbssd.internal(i16, i16, i16, x86_amx, x86_amx, x86_amx)
declare void @llvm.x86.tilestored64.internal(i16, i16, ptr, i64, x86_amx)
