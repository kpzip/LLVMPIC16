; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -mtriple=x86_64-unknown-linux < %s | FileCheck %s --check-prefixes=X64
; RUN: llc -verify-machineinstrs -mtriple=i386-unknown-linux < %s | FileCheck %s --check-prefixes=X86

; Check CSR split can work properly for tests below.

@a = common dso_local local_unnamed_addr global i32 0, align 4

define dso_local signext i32 @test1(ptr %b) local_unnamed_addr  {
; X64-LABEL: test1:
; X64:       # %bb.0: # %entry
; X64-NEXT:    movslq a(%rip), %rax
; X64-NEXT:    cmpq %rdi, %rax
; X64-NEXT:    je .LBB0_2
; X64-NEXT:  # %bb.1: # %if.end
; X64-NEXT:    retq
; X64-NEXT:  .LBB0_2: # %if.then
; X64-NEXT:    pushq %rbx
; X64-NEXT:    .cfi_def_cfa_offset 16
; X64-NEXT:    .cfi_offset %rbx, -16
; X64-NEXT:    movq %rdi, %rbx
; X64-NEXT:    callq callVoid@PLT
; X64-NEXT:    movq %rbx, %rdi
; X64-NEXT:    popq %rbx
; X64-NEXT:    .cfi_def_cfa_offset 8
; X64-NEXT:    jmp callNonVoid@PLT # TAILCALL
;
; X86-LABEL: test1:
; X86:       # %bb.0: # %entry
; X86-NEXT:    subl $12, %esp
; X86-NEXT:    .cfi_def_cfa_offset 16
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    cmpl %eax, a
; X86-NEXT:    je .LBB0_2
; X86-NEXT:  # %bb.1: # %if.end
; X86-NEXT:    addl $12, %esp
; X86-NEXT:    .cfi_def_cfa_offset 4
; X86-NEXT:    retl
; X86-NEXT:  .LBB0_2: # %if.then
; X86-NEXT:    .cfi_def_cfa_offset 16
; X86-NEXT:    calll callVoid@PLT
; X86-NEXT:    addl $12, %esp
; X86-NEXT:    .cfi_def_cfa_offset 4
; X86-NEXT:    jmp callNonVoid@PLT # TAILCALL
entry:
  %0 = load i32, ptr @a, align 4, !tbaa !2
  %conv = sext i32 %0 to i64
  %1 = inttoptr i64 %conv to ptr
  %cmp = icmp eq ptr %1, %b
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %call = tail call signext i32 @callVoid()
  %call2 = tail call signext i32 @callNonVoid(ptr %b)
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  %retval.0 = phi i32 [ %call2, %if.then ], [ undef, %entry ]
  ret i32 %retval.0
}

declare signext i32 @callVoid(...) local_unnamed_addr

declare signext i32 @callNonVoid(ptr) local_unnamed_addr

define dso_local signext i32 @test2(ptr %p1) local_unnamed_addr  {
; X64-LABEL: test2:
; X64:       # %bb.0: # %entry
; X64-NEXT:    testq %rdi, %rdi
; X64-NEXT:    je .LBB1_2
; X64-NEXT:  # %bb.1: # %if.end
; X64-NEXT:    movslq a(%rip), %rax
; X64-NEXT:    cmpq %rdi, %rax
; X64-NEXT:    je .LBB1_3
; X64-NEXT:  .LBB1_2: # %return
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    retq
; X64-NEXT:  .LBB1_3: # %if.then2
; X64-NEXT:    pushq %rbx
; X64-NEXT:    .cfi_def_cfa_offset 16
; X64-NEXT:    .cfi_offset %rbx, -16
; X64-NEXT:    movq %rdi, %rbx
; X64-NEXT:    callq callVoid@PLT
; X64-NEXT:    movq %rbx, %rdi
; X64-NEXT:    popq %rbx
; X64-NEXT:    .cfi_def_cfa_offset 8
; X64-NEXT:    jmp callNonVoid@PLT # TAILCALL
;
; X86-LABEL: test2:
; X86:       # %bb.0: # %entry
; X86-NEXT:    subl $12, %esp
; X86-NEXT:    .cfi_def_cfa_offset 16
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    testl %eax, %eax
; X86-NEXT:    je .LBB1_2
; X86-NEXT:  # %bb.1: # %if.end
; X86-NEXT:    cmpl %eax, a
; X86-NEXT:    je .LBB1_3
; X86-NEXT:  .LBB1_2: # %return
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    addl $12, %esp
; X86-NEXT:    .cfi_def_cfa_offset 4
; X86-NEXT:    retl
; X86-NEXT:  .LBB1_3: # %if.then2
; X86-NEXT:    .cfi_def_cfa_offset 16
; X86-NEXT:    calll callVoid@PLT
; X86-NEXT:    addl $12, %esp
; X86-NEXT:    .cfi_def_cfa_offset 4
; X86-NEXT:    jmp callNonVoid@PLT # TAILCALL
entry:
  %tobool = icmp eq ptr %p1, null
  br i1 %tobool, label %return, label %if.end

if.end:                                           ; preds = %entry
  %0 = load i32, ptr @a, align 4, !tbaa !2
  %conv = sext i32 %0 to i64
  %1 = inttoptr i64 %conv to ptr
  %cmp = icmp eq ptr %1, %p1
  br i1 %cmp, label %if.then2, label %return

if.then2:                                         ; preds = %if.end
  %call = tail call signext i32 @callVoid()
  %call3 = tail call signext i32 @callNonVoid(ptr nonnull %p1)
  br label %return

return:                                           ; preds = %if.end, %entry, %if.then2
  %retval.0 = phi i32 [ %call3, %if.then2 ], [ 0, %entry ], [ 0, %if.end ]
  ret i32 %retval.0
}


define dso_local ptr @test3(ptr nocapture %p1, i8 zeroext %p2) local_unnamed_addr  {
; X64-LABEL: test3:
; X64:       # %bb.0: # %entry
; X64-NEXT:    pushq %r14
; X64-NEXT:    .cfi_def_cfa_offset 16
; X64-NEXT:    pushq %rbx
; X64-NEXT:    .cfi_def_cfa_offset 24
; X64-NEXT:    pushq %rax
; X64-NEXT:    .cfi_def_cfa_offset 32
; X64-NEXT:    .cfi_offset %rbx, -24
; X64-NEXT:    .cfi_offset %r14, -16
; X64-NEXT:    movq (%rdi), %rbx
; X64-NEXT:    testq %rbx, %rbx
; X64-NEXT:    je .LBB2_2
; X64-NEXT:  # %bb.1: # %land.rhs
; X64-NEXT:    movq %rdi, %r14
; X64-NEXT:    movzbl %sil, %esi
; X64-NEXT:    movq %rbx, %rdi
; X64-NEXT:    callq bar@PLT
; X64-NEXT:    movq %rax, (%r14)
; X64-NEXT:  .LBB2_2: # %land.end
; X64-NEXT:    movq %rbx, %rax
; X64-NEXT:    addq $8, %rsp
; X64-NEXT:    .cfi_def_cfa_offset 24
; X64-NEXT:    popq %rbx
; X64-NEXT:    .cfi_def_cfa_offset 16
; X64-NEXT:    popq %r14
; X64-NEXT:    .cfi_def_cfa_offset 8
; X64-NEXT:    retq
;
; X86-LABEL: test3:
; X86:       # %bb.0: # %entry
; X86-NEXT:    pushl %edi
; X86-NEXT:    .cfi_def_cfa_offset 8
; X86-NEXT:    pushl %esi
; X86-NEXT:    .cfi_def_cfa_offset 12
; X86-NEXT:    pushl %eax
; X86-NEXT:    .cfi_def_cfa_offset 16
; X86-NEXT:    .cfi_offset %esi, -12
; X86-NEXT:    .cfi_offset %edi, -8
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edi
; X86-NEXT:    movl (%edi), %esi
; X86-NEXT:    testl %esi, %esi
; X86-NEXT:    je .LBB2_2
; X86-NEXT:  # %bb.1: # %land.rhs
; X86-NEXT:    subl $8, %esp
; X86-NEXT:    .cfi_adjust_cfa_offset 8
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    pushl %eax
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    pushl %esi
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    calll bar@PLT
; X86-NEXT:    addl $16, %esp
; X86-NEXT:    .cfi_adjust_cfa_offset -16
; X86-NEXT:    movl %eax, (%edi)
; X86-NEXT:  .LBB2_2: # %land.end
; X86-NEXT:    movl %esi, %eax
; X86-NEXT:    addl $4, %esp
; X86-NEXT:    .cfi_def_cfa_offset 12
; X86-NEXT:    popl %esi
; X86-NEXT:    .cfi_def_cfa_offset 8
; X86-NEXT:    popl %edi
; X86-NEXT:    .cfi_def_cfa_offset 4
; X86-NEXT:    retl
entry:
  %0 = load ptr, ptr %p1, align 8, !tbaa !6
  %tobool = icmp eq ptr %0, null
  br i1 %tobool, label %land.end, label %land.rhs

land.rhs:                                         ; preds = %entry
  %call = tail call ptr @bar(ptr nonnull %0, i8 zeroext %p2)
  store ptr %call, ptr %p1, align 8, !tbaa !6
  br label %land.end

land.end:                                         ; preds = %entry, %land.rhs
  ret ptr %0
}

declare ptr @bar(ptr, i8 zeroext) local_unnamed_addr


!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 10.0.0 (trunk 367381) (llvm/trunk 367388)"}
!2 = !{!3, !3, i64 0}
!3 = !{!"int", !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C/C++ TBAA"}
!6 = !{!7, !7, i64 0}
!7 = !{!"any pointer", !4, i64 0}
