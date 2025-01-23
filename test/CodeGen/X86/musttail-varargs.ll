; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs < %s -enable-tail-merge=0 -mtriple=x86_64-linux | FileCheck %s --check-prefix=LINUX
; RUN: llc -verify-machineinstrs < %s -enable-tail-merge=0 -mtriple=x86_64-linux-gnux32 | FileCheck %s --check-prefix=LINUX-X32
; RUN: llc -verify-machineinstrs < %s -enable-tail-merge=0 -mtriple=x86_64-windows | FileCheck %s --check-prefix=WINDOWS
; RUN: llc -verify-machineinstrs < %s -enable-tail-merge=0 -mtriple=i686-windows | FileCheck %s --check-prefix=X86 --check-prefix=X86-NOSSE
; RUN: llc -verify-machineinstrs < %s -enable-tail-merge=0 -mtriple=i686-windows -mattr=+sse2 | FileCheck %s --check-prefix=X86 --check-prefix=X86-SSE

; Test that we actually spill and reload all arguments in the variadic argument
; pack. Doing a normal call will clobber all argument registers, and we will
; spill around it. A simple adjustment should not require any XMM spills.

declare void @llvm.va_start(ptr) nounwind

declare ptr @get_f(ptr %this)

define void @f_thunk(ptr %this, ...) {
  ; Use va_start so that we exercise the combination.
; LINUX-LABEL: f_thunk:
; LINUX:       # %bb.0:
; LINUX-NEXT:    pushq %rbp
; LINUX-NEXT:    .cfi_def_cfa_offset 16
; LINUX-NEXT:    pushq %r15
; LINUX-NEXT:    .cfi_def_cfa_offset 24
; LINUX-NEXT:    pushq %r14
; LINUX-NEXT:    .cfi_def_cfa_offset 32
; LINUX-NEXT:    pushq %r13
; LINUX-NEXT:    .cfi_def_cfa_offset 40
; LINUX-NEXT:    pushq %r12
; LINUX-NEXT:    .cfi_def_cfa_offset 48
; LINUX-NEXT:    pushq %rbx
; LINUX-NEXT:    .cfi_def_cfa_offset 56
; LINUX-NEXT:    subq $360, %rsp # imm = 0x168
; LINUX-NEXT:    .cfi_def_cfa_offset 416
; LINUX-NEXT:    .cfi_offset %rbx, -56
; LINUX-NEXT:    .cfi_offset %r12, -48
; LINUX-NEXT:    .cfi_offset %r13, -40
; LINUX-NEXT:    .cfi_offset %r14, -32
; LINUX-NEXT:    .cfi_offset %r15, -24
; LINUX-NEXT:    .cfi_offset %rbp, -16
; LINUX-NEXT:    movb %al, {{[-0-9]+}}(%r{{[sb]}}p) # 1-byte Spill
; LINUX-NEXT:    movaps %xmm7, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; LINUX-NEXT:    movaps %xmm6, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; LINUX-NEXT:    movaps %xmm5, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; LINUX-NEXT:    movaps %xmm4, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; LINUX-NEXT:    movaps %xmm3, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; LINUX-NEXT:    movaps %xmm2, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; LINUX-NEXT:    movaps %xmm1, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; LINUX-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; LINUX-NEXT:    movq %r9, %r14
; LINUX-NEXT:    movq %r8, %r15
; LINUX-NEXT:    movq %rcx, %r12
; LINUX-NEXT:    movq %rdx, %r13
; LINUX-NEXT:    movq %rsi, %rbp
; LINUX-NEXT:    movq %rdi, %rbx
; LINUX-NEXT:    movq %rsi, {{[0-9]+}}(%rsp)
; LINUX-NEXT:    movq %rdx, {{[0-9]+}}(%rsp)
; LINUX-NEXT:    movq %rcx, {{[0-9]+}}(%rsp)
; LINUX-NEXT:    movq %r8, {{[0-9]+}}(%rsp)
; LINUX-NEXT:    movq %r9, {{[0-9]+}}(%rsp)
; LINUX-NEXT:    testb %al, %al
; LINUX-NEXT:    je .LBB0_2
; LINUX-NEXT:  # %bb.1:
; LINUX-NEXT:    movaps %xmm0, {{[0-9]+}}(%rsp)
; LINUX-NEXT:    movaps %xmm1, {{[0-9]+}}(%rsp)
; LINUX-NEXT:    movaps %xmm2, {{[0-9]+}}(%rsp)
; LINUX-NEXT:    movaps %xmm3, {{[0-9]+}}(%rsp)
; LINUX-NEXT:    movaps %xmm4, {{[0-9]+}}(%rsp)
; LINUX-NEXT:    movaps %xmm5, {{[0-9]+}}(%rsp)
; LINUX-NEXT:    movaps %xmm6, {{[0-9]+}}(%rsp)
; LINUX-NEXT:    movaps %xmm7, {{[0-9]+}}(%rsp)
; LINUX-NEXT:  .LBB0_2:
; LINUX-NEXT:    leaq {{[0-9]+}}(%rsp), %rax
; LINUX-NEXT:    movq %rax, {{[0-9]+}}(%rsp)
; LINUX-NEXT:    leaq {{[0-9]+}}(%rsp), %rax
; LINUX-NEXT:    movq %rax, {{[0-9]+}}(%rsp)
; LINUX-NEXT:    movabsq $206158430216, %rax # imm = 0x3000000008
; LINUX-NEXT:    movq %rax, {{[0-9]+}}(%rsp)
; LINUX-NEXT:    callq get_f@PLT
; LINUX-NEXT:    movq %rax, %r11
; LINUX-NEXT:    movq %rbx, %rdi
; LINUX-NEXT:    movq %rbp, %rsi
; LINUX-NEXT:    movq %r13, %rdx
; LINUX-NEXT:    movq %r12, %rcx
; LINUX-NEXT:    movq %r15, %r8
; LINUX-NEXT:    movzbl {{[-0-9]+}}(%r{{[sb]}}p), %eax # 1-byte Folded Reload
; LINUX-NEXT:    movq %r14, %r9
; LINUX-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; LINUX-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; LINUX-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm2 # 16-byte Reload
; LINUX-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm3 # 16-byte Reload
; LINUX-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm4 # 16-byte Reload
; LINUX-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm5 # 16-byte Reload
; LINUX-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm6 # 16-byte Reload
; LINUX-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm7 # 16-byte Reload
; LINUX-NEXT:    addq $360, %rsp # imm = 0x168
; LINUX-NEXT:    .cfi_def_cfa_offset 56
; LINUX-NEXT:    popq %rbx
; LINUX-NEXT:    .cfi_def_cfa_offset 48
; LINUX-NEXT:    popq %r12
; LINUX-NEXT:    .cfi_def_cfa_offset 40
; LINUX-NEXT:    popq %r13
; LINUX-NEXT:    .cfi_def_cfa_offset 32
; LINUX-NEXT:    popq %r14
; LINUX-NEXT:    .cfi_def_cfa_offset 24
; LINUX-NEXT:    popq %r15
; LINUX-NEXT:    .cfi_def_cfa_offset 16
; LINUX-NEXT:    popq %rbp
; LINUX-NEXT:    .cfi_def_cfa_offset 8
; LINUX-NEXT:    jmpq *%r11 # TAILCALL
;
; LINUX-X32-LABEL: f_thunk:
; LINUX-X32:       # %bb.0:
; LINUX-X32-NEXT:    pushq %rbp
; LINUX-X32-NEXT:    .cfi_def_cfa_offset 16
; LINUX-X32-NEXT:    pushq %r15
; LINUX-X32-NEXT:    .cfi_def_cfa_offset 24
; LINUX-X32-NEXT:    pushq %r14
; LINUX-X32-NEXT:    .cfi_def_cfa_offset 32
; LINUX-X32-NEXT:    pushq %r13
; LINUX-X32-NEXT:    .cfi_def_cfa_offset 40
; LINUX-X32-NEXT:    pushq %r12
; LINUX-X32-NEXT:    .cfi_def_cfa_offset 48
; LINUX-X32-NEXT:    pushq %rbx
; LINUX-X32-NEXT:    .cfi_def_cfa_offset 56
; LINUX-X32-NEXT:    subl $344, %esp # imm = 0x158
; LINUX-X32-NEXT:    .cfi_def_cfa_offset 400
; LINUX-X32-NEXT:    .cfi_offset %rbx, -56
; LINUX-X32-NEXT:    .cfi_offset %r12, -48
; LINUX-X32-NEXT:    .cfi_offset %r13, -40
; LINUX-X32-NEXT:    .cfi_offset %r14, -32
; LINUX-X32-NEXT:    .cfi_offset %r15, -24
; LINUX-X32-NEXT:    .cfi_offset %rbp, -16
; LINUX-X32-NEXT:    movb %al, {{[-0-9]+}}(%e{{[sb]}}p) # 1-byte Spill
; LINUX-X32-NEXT:    movaps %xmm7, {{[-0-9]+}}(%e{{[sb]}}p) # 16-byte Spill
; LINUX-X32-NEXT:    movaps %xmm6, {{[-0-9]+}}(%e{{[sb]}}p) # 16-byte Spill
; LINUX-X32-NEXT:    movaps %xmm5, {{[-0-9]+}}(%e{{[sb]}}p) # 16-byte Spill
; LINUX-X32-NEXT:    movaps %xmm4, {{[-0-9]+}}(%e{{[sb]}}p) # 16-byte Spill
; LINUX-X32-NEXT:    movaps %xmm3, {{[-0-9]+}}(%e{{[sb]}}p) # 16-byte Spill
; LINUX-X32-NEXT:    movaps %xmm2, {{[-0-9]+}}(%e{{[sb]}}p) # 16-byte Spill
; LINUX-X32-NEXT:    movaps %xmm1, {{[-0-9]+}}(%e{{[sb]}}p) # 16-byte Spill
; LINUX-X32-NEXT:    movaps %xmm0, {{[-0-9]+}}(%e{{[sb]}}p) # 16-byte Spill
; LINUX-X32-NEXT:    movq %r9, %r14
; LINUX-X32-NEXT:    movq %r8, %r15
; LINUX-X32-NEXT:    movq %rcx, %r12
; LINUX-X32-NEXT:    movq %rdx, %r13
; LINUX-X32-NEXT:    movq %rsi, %rbp
; LINUX-X32-NEXT:    movq %rdi, %rbx
; LINUX-X32-NEXT:    movq %rsi, {{[0-9]+}}(%esp)
; LINUX-X32-NEXT:    movq %rdx, {{[0-9]+}}(%esp)
; LINUX-X32-NEXT:    movq %rcx, {{[0-9]+}}(%esp)
; LINUX-X32-NEXT:    movq %r8, {{[0-9]+}}(%esp)
; LINUX-X32-NEXT:    movq %r9, {{[0-9]+}}(%esp)
; LINUX-X32-NEXT:    testb %al, %al
; LINUX-X32-NEXT:    je .LBB0_2
; LINUX-X32-NEXT:  # %bb.1:
; LINUX-X32-NEXT:    movaps %xmm0, {{[0-9]+}}(%esp)
; LINUX-X32-NEXT:    movaps %xmm1, {{[0-9]+}}(%esp)
; LINUX-X32-NEXT:    movaps %xmm2, {{[0-9]+}}(%esp)
; LINUX-X32-NEXT:    movaps %xmm3, {{[0-9]+}}(%esp)
; LINUX-X32-NEXT:    movaps %xmm4, {{[0-9]+}}(%esp)
; LINUX-X32-NEXT:    movaps %xmm5, {{[0-9]+}}(%esp)
; LINUX-X32-NEXT:    movaps %xmm6, {{[0-9]+}}(%esp)
; LINUX-X32-NEXT:    movaps %xmm7, {{[0-9]+}}(%esp)
; LINUX-X32-NEXT:  .LBB0_2:
; LINUX-X32-NEXT:    leal {{[0-9]+}}(%rsp), %eax
; LINUX-X32-NEXT:    movl %eax, {{[0-9]+}}(%esp)
; LINUX-X32-NEXT:    leal {{[0-9]+}}(%rsp), %eax
; LINUX-X32-NEXT:    movl %eax, {{[0-9]+}}(%esp)
; LINUX-X32-NEXT:    movabsq $206158430216, %rax # imm = 0x3000000008
; LINUX-X32-NEXT:    movq %rax, {{[0-9]+}}(%esp)
; LINUX-X32-NEXT:    callq get_f@PLT
; LINUX-X32-NEXT:    movl %eax, %r11d
; LINUX-X32-NEXT:    movq %rbx, %rdi
; LINUX-X32-NEXT:    movq %rbp, %rsi
; LINUX-X32-NEXT:    movq %r13, %rdx
; LINUX-X32-NEXT:    movq %r12, %rcx
; LINUX-X32-NEXT:    movq %r15, %r8
; LINUX-X32-NEXT:    movzbl {{[-0-9]+}}(%e{{[sb]}}p), %eax # 1-byte Folded Reload
; LINUX-X32-NEXT:    movq %r14, %r9
; LINUX-X32-NEXT:    movaps {{[-0-9]+}}(%e{{[sb]}}p), %xmm0 # 16-byte Reload
; LINUX-X32-NEXT:    movaps {{[-0-9]+}}(%e{{[sb]}}p), %xmm1 # 16-byte Reload
; LINUX-X32-NEXT:    movaps {{[-0-9]+}}(%e{{[sb]}}p), %xmm2 # 16-byte Reload
; LINUX-X32-NEXT:    movaps {{[-0-9]+}}(%e{{[sb]}}p), %xmm3 # 16-byte Reload
; LINUX-X32-NEXT:    movaps {{[-0-9]+}}(%e{{[sb]}}p), %xmm4 # 16-byte Reload
; LINUX-X32-NEXT:    movaps {{[-0-9]+}}(%e{{[sb]}}p), %xmm5 # 16-byte Reload
; LINUX-X32-NEXT:    movaps {{[-0-9]+}}(%e{{[sb]}}p), %xmm6 # 16-byte Reload
; LINUX-X32-NEXT:    movaps {{[-0-9]+}}(%e{{[sb]}}p), %xmm7 # 16-byte Reload
; LINUX-X32-NEXT:    addl $344, %esp # imm = 0x158
; LINUX-X32-NEXT:    .cfi_def_cfa_offset 56
; LINUX-X32-NEXT:    popq %rbx
; LINUX-X32-NEXT:    .cfi_def_cfa_offset 48
; LINUX-X32-NEXT:    popq %r12
; LINUX-X32-NEXT:    .cfi_def_cfa_offset 40
; LINUX-X32-NEXT:    popq %r13
; LINUX-X32-NEXT:    .cfi_def_cfa_offset 32
; LINUX-X32-NEXT:    popq %r14
; LINUX-X32-NEXT:    .cfi_def_cfa_offset 24
; LINUX-X32-NEXT:    popq %r15
; LINUX-X32-NEXT:    .cfi_def_cfa_offset 16
; LINUX-X32-NEXT:    popq %rbp
; LINUX-X32-NEXT:    .cfi_def_cfa_offset 8
; LINUX-X32-NEXT:    jmpq *%r11 # TAILCALL
;
; WINDOWS-LABEL: f_thunk:
; WINDOWS:       # %bb.0:
; WINDOWS-NEXT:    pushq %r14
; WINDOWS-NEXT:    .seh_pushreg %r14
; WINDOWS-NEXT:    pushq %rsi
; WINDOWS-NEXT:    .seh_pushreg %rsi
; WINDOWS-NEXT:    pushq %rdi
; WINDOWS-NEXT:    .seh_pushreg %rdi
; WINDOWS-NEXT:    pushq %rbx
; WINDOWS-NEXT:    .seh_pushreg %rbx
; WINDOWS-NEXT:    subq $72, %rsp
; WINDOWS-NEXT:    .seh_stackalloc 72
; WINDOWS-NEXT:    .seh_endprologue
; WINDOWS-NEXT:    movq %r9, %rsi
; WINDOWS-NEXT:    movq %r8, %rdi
; WINDOWS-NEXT:    movq %rdx, %rbx
; WINDOWS-NEXT:    movq %rcx, %r14
; WINDOWS-NEXT:    movq %rdx, {{[0-9]+}}(%rsp)
; WINDOWS-NEXT:    movq %r8, {{[0-9]+}}(%rsp)
; WINDOWS-NEXT:    movq %r9, {{[0-9]+}}(%rsp)
; WINDOWS-NEXT:    leaq {{[0-9]+}}(%rsp), %rax
; WINDOWS-NEXT:    movq %rax, {{[0-9]+}}(%rsp)
; WINDOWS-NEXT:    callq get_f
; WINDOWS-NEXT:    movq %r14, %rcx
; WINDOWS-NEXT:    movq %rbx, %rdx
; WINDOWS-NEXT:    movq %rdi, %r8
; WINDOWS-NEXT:    movq %rsi, %r9
; WINDOWS-NEXT:    addq $72, %rsp
; WINDOWS-NEXT:    popq %rbx
; WINDOWS-NEXT:    popq %rdi
; WINDOWS-NEXT:    popq %rsi
; WINDOWS-NEXT:    popq %r14
; WINDOWS-NEXT:    rex64 jmpq *%rax # TAILCALL
; WINDOWS-NEXT:    .seh_endproc
;
; X86-NOSSE-LABEL: f_thunk:
; X86-NOSSE:       # %bb.0:
; X86-NOSSE-NEXT:    pushl %ebp
; X86-NOSSE-NEXT:    movl %esp, %ebp
; X86-NOSSE-NEXT:    pushl %esi
; X86-NOSSE-NEXT:    andl $-16, %esp
; X86-NOSSE-NEXT:    subl $32, %esp
; X86-NOSSE-NEXT:    movl 8(%ebp), %esi
; X86-NOSSE-NEXT:    leal 12(%ebp), %eax
; X86-NOSSE-NEXT:    movl %eax, (%esp)
; X86-NOSSE-NEXT:    pushl %esi
; X86-NOSSE-NEXT:    calll _get_f
; X86-NOSSE-NEXT:    addl $4, %esp
; X86-NOSSE-NEXT:    movl %esi, 8(%ebp)
; X86-NOSSE-NEXT:    leal -4(%ebp), %esp
; X86-NOSSE-NEXT:    popl %esi
; X86-NOSSE-NEXT:    popl %ebp
; X86-NOSSE-NEXT:    jmpl *%eax # TAILCALL
;
; X86-SSE-LABEL: f_thunk:
; X86-SSE:       # %bb.0:
; X86-SSE-NEXT:    pushl %ebp
; X86-SSE-NEXT:    movl %esp, %ebp
; X86-SSE-NEXT:    pushl %esi
; X86-SSE-NEXT:    andl $-16, %esp
; X86-SSE-NEXT:    subl $80, %esp
; X86-SSE-NEXT:    movaps %xmm2, {{[-0-9]+}}(%e{{[sb]}}p) # 16-byte Spill
; X86-SSE-NEXT:    movaps %xmm1, {{[-0-9]+}}(%e{{[sb]}}p) # 16-byte Spill
; X86-SSE-NEXT:    movaps %xmm0, (%esp) # 16-byte Spill
; X86-SSE-NEXT:    movl 8(%ebp), %esi
; X86-SSE-NEXT:    leal 12(%ebp), %eax
; X86-SSE-NEXT:    movl %eax, {{[0-9]+}}(%esp)
; X86-SSE-NEXT:    pushl %esi
; X86-SSE-NEXT:    calll _get_f
; X86-SSE-NEXT:    addl $4, %esp
; X86-SSE-NEXT:    movl %esi, 8(%ebp)
; X86-SSE-NEXT:    movaps (%esp), %xmm0 # 16-byte Reload
; X86-SSE-NEXT:    movaps {{[-0-9]+}}(%e{{[sb]}}p), %xmm1 # 16-byte Reload
; X86-SSE-NEXT:    movaps {{[-0-9]+}}(%e{{[sb]}}p), %xmm2 # 16-byte Reload
; X86-SSE-NEXT:    leal -4(%ebp), %esp
; X86-SSE-NEXT:    popl %esi
; X86-SSE-NEXT:    popl %ebp
; X86-SSE-NEXT:    jmpl *%eax # TAILCALL
  %ap = alloca [4 x ptr], align 16
  call void @llvm.va_start(ptr %ap)

  %fptr = call ptr(ptr) @get_f(ptr %this)
  musttail call void (ptr, ...) %fptr(ptr %this, ...)
  ret void
}

; Save and restore 6 GPRs, 8 XMMs, and AL around the call.

; No regparms on normal x86 conventions.

; This thunk shouldn't require any spills and reloads, assuming the register
; allocator knows what it's doing.

define void @g_thunk(ptr %fptr_i8, ...) {
; LINUX-LABEL: g_thunk:
; LINUX:       # %bb.0:
; LINUX-NEXT:    jmpq *%rdi # TAILCALL
;
; LINUX-X32-LABEL: g_thunk:
; LINUX-X32:       # %bb.0:
; LINUX-X32-NEXT:    jmpq *%rdi # TAILCALL
;
; WINDOWS-LABEL: g_thunk:
; WINDOWS:       # %bb.0:
; WINDOWS-NEXT:    rex64 jmpq *%rcx # TAILCALL
;
; X86-LABEL: g_thunk:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl %eax, {{[0-9]+}}(%esp)
; X86-NEXT:    jmpl *%eax # TAILCALL
  musttail call void (ptr, ...) %fptr_i8(ptr %fptr_i8, ...)
  ret void
}

; Do a simple multi-exit multi-bb test.

%struct.Foo = type { i1, ptr, ptr }

@g = external dso_local global i32

define void @h_thunk(ptr %this, ...) {
; LINUX-LABEL: h_thunk:
; LINUX:       # %bb.0:
; LINUX-NEXT:    cmpb $1, (%rdi)
; LINUX-NEXT:    jne .LBB2_2
; LINUX-NEXT:  # %bb.1: # %then
; LINUX-NEXT:    movq 8(%rdi), %r11
; LINUX-NEXT:    jmpq *%r11 # TAILCALL
; LINUX-NEXT:  .LBB2_2: # %else
; LINUX-NEXT:    movq 16(%rdi), %r11
; LINUX-NEXT:    movl $42, g(%rip)
; LINUX-NEXT:    jmpq *%r11 # TAILCALL
;
; LINUX-X32-LABEL: h_thunk:
; LINUX-X32:       # %bb.0:
; LINUX-X32-NEXT:    cmpb $1, (%edi)
; LINUX-X32-NEXT:    jne .LBB2_2
; LINUX-X32-NEXT:  # %bb.1: # %then
; LINUX-X32-NEXT:    movl 4(%edi), %r11d
; LINUX-X32-NEXT:    movl %edi, %edi
; LINUX-X32-NEXT:    jmpq *%r11 # TAILCALL
; LINUX-X32-NEXT:  .LBB2_2: # %else
; LINUX-X32-NEXT:    movl 8(%edi), %r11d
; LINUX-X32-NEXT:    movl $42, g(%rip)
; LINUX-X32-NEXT:    movl %edi, %edi
; LINUX-X32-NEXT:    jmpq *%r11 # TAILCALL
;
; WINDOWS-LABEL: h_thunk:
; WINDOWS:       # %bb.0:
; WINDOWS-NEXT:    cmpb $1, (%rcx)
; WINDOWS-NEXT:    jne .LBB2_2
; WINDOWS-NEXT:  # %bb.1: # %then
; WINDOWS-NEXT:    movq 8(%rcx), %rax
; WINDOWS-NEXT:    rex64 jmpq *%rax # TAILCALL
; WINDOWS-NEXT:  .LBB2_2: # %else
; WINDOWS-NEXT:    movq 16(%rcx), %rax
; WINDOWS-NEXT:    movl $42, g(%rip)
; WINDOWS-NEXT:    rex64 jmpq *%rax # TAILCALL
;
; X86-LABEL: h_thunk:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    cmpb $1, (%eax)
; X86-NEXT:    jne LBB2_2
; X86-NEXT:  # %bb.1: # %then
; X86-NEXT:    movl 4(%eax), %ecx
; X86-NEXT:    movl %eax, {{[0-9]+}}(%esp)
; X86-NEXT:    jmpl *%ecx # TAILCALL
; X86-NEXT:  LBB2_2: # %else
; X86-NEXT:    movl 8(%eax), %ecx
; X86-NEXT:    movl $42, _g
; X86-NEXT:    movl %eax, {{[0-9]+}}(%esp)
; X86-NEXT:    jmpl *%ecx # TAILCALL
  %cond = load i1, ptr %this
  br i1 %cond, label %then, label %else

then:
  %a_p = getelementptr %struct.Foo, ptr %this, i32 0, i32 1
  %a_i8 = load ptr, ptr %a_p
  musttail call void (ptr, ...) %a_i8(ptr %this, ...)
  ret void

else:
  %b_p = getelementptr %struct.Foo, ptr %this, i32 0, i32 2
  %b_i8 = load ptr, ptr %b_p
  store i32 42, ptr @g
  musttail call void (ptr, ...) %b_i8(ptr %this, ...)
  ret void
}
