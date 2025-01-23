; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i386-unknown-unknown   | FileCheck %s --check-prefix=X86
; RUN: llc < %s -mtriple=x86_64-unknown-unknown | FileCheck %s --check-prefix=X64

define i32 @t1(i32 %t, i32 %val) nounwind {
; X86-LABEL: t1:
; X86:       # %bb.0:
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    shll %cl, %eax
; X86-NEXT:    retl
;
; X64-LABEL: t1:
; X64:       # %bb.0:
; X64-NEXT:    movl %esi, %eax
; X64-NEXT:    movl %edi, %ecx
; X64-NEXT:    # kill: def $cl killed $cl killed $ecx
; X64-NEXT:    shll %cl, %eax
; X64-NEXT:    retq
       %shamt = and i32 %t, 31
       %res = shl i32 %val, %shamt
       ret i32 %res
}

define i32 @t2(i32 %t, i32 %val) nounwind {
; X86-LABEL: t2:
; X86:       # %bb.0:
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    shll %cl, %eax
; X86-NEXT:    retl
;
; X64-LABEL: t2:
; X64:       # %bb.0:
; X64-NEXT:    movl %esi, %eax
; X64-NEXT:    movl %edi, %ecx
; X64-NEXT:    # kill: def $cl killed $cl killed $ecx
; X64-NEXT:    shll %cl, %eax
; X64-NEXT:    retq
       %shamt = and i32 %t, 63
       %res = shl i32 %val, %shamt
       ret i32 %res
}

@X = internal global i16 0

define void @t3(i16 %t) nounwind {
; X86-LABEL: t3:
; X86:       # %bb.0:
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    sarw %cl, X
; X86-NEXT:    retl
;
; X64-LABEL: t3:
; X64:       # %bb.0:
; X64-NEXT:    movl %edi, %ecx
; X64-NEXT:    # kill: def $cl killed $cl killed $ecx
; X64-NEXT:    sarw %cl, X(%rip)
; X64-NEXT:    retq
       %shamt = and i16 %t, 31
       %tmp = load i16, ptr @X
       %tmp1 = ashr i16 %tmp, %shamt
       store i16 %tmp1, ptr @X
       ret void
}

define i64 @t4(i64 %t, i64 %val) nounwind {
; X86-LABEL: t4:
; X86:       # %bb.0:
; X86-NEXT:    pushl %esi
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X86-NEXT:    movl %esi, %edx
; X86-NEXT:    shrl %cl, %edx
; X86-NEXT:    shrdl %cl, %esi, %eax
; X86-NEXT:    testb $32, %cl
; X86-NEXT:    je .LBB3_2
; X86-NEXT:  # %bb.1:
; X86-NEXT:    movl %edx, %eax
; X86-NEXT:    xorl %edx, %edx
; X86-NEXT:  .LBB3_2:
; X86-NEXT:    popl %esi
; X86-NEXT:    retl
;
; X64-LABEL: t4:
; X64:       # %bb.0:
; X64-NEXT:    movq %rsi, %rax
; X64-NEXT:    movq %rdi, %rcx
; X64-NEXT:    # kill: def $cl killed $cl killed $rcx
; X64-NEXT:    shrq %cl, %rax
; X64-NEXT:    retq
       %shamt = and i64 %t, 63
       %res = lshr i64 %val, %shamt
       ret i64 %res
}

define i64 @t5(i64 %t, i64 %val) nounwind {
; X86-LABEL: t5:
; X86:       # %bb.0:
; X86-NEXT:    pushl %esi
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X86-NEXT:    movl %esi, %edx
; X86-NEXT:    shrl %cl, %edx
; X86-NEXT:    shrdl %cl, %esi, %eax
; X86-NEXT:    testb $32, %cl
; X86-NEXT:    je .LBB4_2
; X86-NEXT:  # %bb.1:
; X86-NEXT:    movl %edx, %eax
; X86-NEXT:    xorl %edx, %edx
; X86-NEXT:  .LBB4_2:
; X86-NEXT:    popl %esi
; X86-NEXT:    retl
;
; X64-LABEL: t5:
; X64:       # %bb.0:
; X64-NEXT:    movq %rsi, %rax
; X64-NEXT:    movq %rdi, %rcx
; X64-NEXT:    # kill: def $cl killed $cl killed $rcx
; X64-NEXT:    shrq %cl, %rax
; X64-NEXT:    retq
       %shamt = and i64 %t, 191
       %res = lshr i64 %val, %shamt
       ret i64 %res
}

define void @t5ptr(i64 %t, ptr %ptr) nounwind {
; X86-LABEL: t5ptr:
; X86:       # %bb.0:
; X86-NEXT:    pushl %edi
; X86-NEXT:    pushl %esi
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl (%eax), %edx
; X86-NEXT:    movl 4(%eax), %edi
; X86-NEXT:    movl %edi, %esi
; X86-NEXT:    shrl %cl, %esi
; X86-NEXT:    shrdl %cl, %edi, %edx
; X86-NEXT:    testb $32, %cl
; X86-NEXT:    je .LBB5_2
; X86-NEXT:  # %bb.1:
; X86-NEXT:    movl %esi, %edx
; X86-NEXT:    xorl %esi, %esi
; X86-NEXT:  .LBB5_2:
; X86-NEXT:    movl %edx, (%eax)
; X86-NEXT:    movl %esi, 4(%eax)
; X86-NEXT:    popl %esi
; X86-NEXT:    popl %edi
; X86-NEXT:    retl
;
; X64-LABEL: t5ptr:
; X64:       # %bb.0:
; X64-NEXT:    movq %rdi, %rcx
; X64-NEXT:    # kill: def $cl killed $cl killed $rcx
; X64-NEXT:    shrq %cl, (%rsi)
; X64-NEXT:    retq
       %shamt = and i64 %t, 191
       %tmp = load i64, ptr %ptr
       %tmp1 = lshr i64 %tmp, %shamt
       store i64 %tmp1, ptr %ptr
       ret void
}


; rdar://11866926
define i64 @t6(i64 %key, ptr nocapture %val) nounwind {
; X86-LABEL: t6:
; X86:       # %bb.0:
; X86-NEXT:    pushl %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    shrdl $3, %eax, %ecx
; X86-NEXT:    movl %eax, %esi
; X86-NEXT:    shrl $3, %esi
; X86-NEXT:    movl (%edx), %eax
; X86-NEXT:    movl 4(%edx), %edx
; X86-NEXT:    addl $-1, %eax
; X86-NEXT:    adcl $-1, %edx
; X86-NEXT:    andl %ecx, %eax
; X86-NEXT:    andl %esi, %edx
; X86-NEXT:    popl %esi
; X86-NEXT:    retl
;
; X64-LABEL: t6:
; X64:       # %bb.0:
; X64-NEXT:    shrq $3, %rdi
; X64-NEXT:    movq (%rsi), %rax
; X64-NEXT:    decq %rax
; X64-NEXT:    andq %rdi, %rax
; X64-NEXT:    retq
  %shr = lshr i64 %key, 3
  %1 = load i64, ptr %val, align 8
  %sub = add i64 %1, 2305843009213693951
  %and = and i64 %sub, %shr
  ret i64 %and
}

define i64 @big_mask_constant(i64 %x) nounwind {
; X86-LABEL: big_mask_constant:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    andl $4, %eax
; X86-NEXT:    shll $25, %eax
; X86-NEXT:    xorl %edx, %edx
; X86-NEXT:    retl
;
; X64-LABEL: big_mask_constant:
; X64:       # %bb.0:
; X64-NEXT:    movq %rdi, %rax
; X64-NEXT:    shrq $7, %rax
; X64-NEXT:    andl $134217728, %eax # imm = 0x8000000
; X64-NEXT:    retq
  %and = and i64 %x, 17179869184 ; 0x400000000
  %sh = lshr i64 %and, 7
  ret i64 %sh
}

