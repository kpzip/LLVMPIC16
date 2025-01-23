; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686 -mattr=cmov | FileCheck %s --check-prefixes=X86
; RUN: llc < %s -mtriple=x86_64-linux | FileCheck %s --check-prefixes=X64

;
; trunc(abs(sub(sext(a),sext(b)))) -> abds(a,b)
;

define i8 @abd_ext_i8(i8 %a, i8 %b) nounwind {
; X86-LABEL: abd_ext_i8:
; X86:       # %bb.0:
; X86-NEXT:    movsbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movsbl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    subl %eax, %ecx
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:    negl %eax
; X86-NEXT:    cmovsl %ecx, %eax
; X86-NEXT:    # kill: def $al killed $al killed $eax
; X86-NEXT:    retl
;
; X64-LABEL: abd_ext_i8:
; X64:       # %bb.0:
; X64-NEXT:    movsbl %sil, %eax
; X64-NEXT:    movsbl %dil, %ecx
; X64-NEXT:    subl %eax, %ecx
; X64-NEXT:    movl %ecx, %eax
; X64-NEXT:    negl %eax
; X64-NEXT:    cmovsl %ecx, %eax
; X64-NEXT:    # kill: def $al killed $al killed $eax
; X64-NEXT:    retq
  %aext = sext i8 %a to i64
  %bext = sext i8 %b to i64
  %sub = sub i64 %aext, %bext
  %abs = call i64 @llvm.abs.i64(i64 %sub, i1 false)
  %trunc = trunc i64 %abs to i8
  ret i8 %trunc
}

define i8 @abd_ext_i8_i16(i8 %a, i16 %b) nounwind {
; X86-LABEL: abd_ext_i8_i16:
; X86:       # %bb.0:
; X86-NEXT:    movswl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movsbl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    subl %eax, %ecx
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:    negl %eax
; X86-NEXT:    cmovsl %ecx, %eax
; X86-NEXT:    # kill: def $al killed $al killed $eax
; X86-NEXT:    retl
;
; X64-LABEL: abd_ext_i8_i16:
; X64:       # %bb.0:
; X64-NEXT:    movswl %si, %eax
; X64-NEXT:    movsbl %dil, %ecx
; X64-NEXT:    subl %eax, %ecx
; X64-NEXT:    movl %ecx, %eax
; X64-NEXT:    negl %eax
; X64-NEXT:    cmovsl %ecx, %eax
; X64-NEXT:    # kill: def $al killed $al killed $eax
; X64-NEXT:    retq
  %aext = sext i8 %a to i64
  %bext = sext i16 %b to i64
  %sub = sub i64 %aext, %bext
  %abs = call i64 @llvm.abs.i64(i64 %sub, i1 false)
  %trunc = trunc i64 %abs to i8
  ret i8 %trunc
}

define i8 @abd_ext_i8_undef(i8 %a, i8 %b) nounwind {
; X86-LABEL: abd_ext_i8_undef:
; X86:       # %bb.0:
; X86-NEXT:    movsbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movsbl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    subl %eax, %ecx
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:    negl %eax
; X86-NEXT:    cmovsl %ecx, %eax
; X86-NEXT:    # kill: def $al killed $al killed $eax
; X86-NEXT:    retl
;
; X64-LABEL: abd_ext_i8_undef:
; X64:       # %bb.0:
; X64-NEXT:    movsbl %sil, %eax
; X64-NEXT:    movsbl %dil, %ecx
; X64-NEXT:    subl %eax, %ecx
; X64-NEXT:    movl %ecx, %eax
; X64-NEXT:    negl %eax
; X64-NEXT:    cmovsl %ecx, %eax
; X64-NEXT:    # kill: def $al killed $al killed $eax
; X64-NEXT:    retq
  %aext = sext i8 %a to i64
  %bext = sext i8 %b to i64
  %sub = sub i64 %aext, %bext
  %abs = call i64 @llvm.abs.i64(i64 %sub, i1 true)
  %trunc = trunc i64 %abs to i8
  ret i8 %trunc
}

define i16 @abd_ext_i16(i16 %a, i16 %b) nounwind {
; X86-LABEL: abd_ext_i16:
; X86:       # %bb.0:
; X86-NEXT:    movswl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movswl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    subl %eax, %ecx
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:    negl %eax
; X86-NEXT:    cmovsl %ecx, %eax
; X86-NEXT:    # kill: def $ax killed $ax killed $eax
; X86-NEXT:    retl
;
; X64-LABEL: abd_ext_i16:
; X64:       # %bb.0:
; X64-NEXT:    movswl %si, %eax
; X64-NEXT:    movswl %di, %ecx
; X64-NEXT:    subl %eax, %ecx
; X64-NEXT:    movl %ecx, %eax
; X64-NEXT:    negl %eax
; X64-NEXT:    cmovsl %ecx, %eax
; X64-NEXT:    # kill: def $ax killed $ax killed $eax
; X64-NEXT:    retq
  %aext = sext i16 %a to i64
  %bext = sext i16 %b to i64
  %sub = sub i64 %aext, %bext
  %abs = call i64 @llvm.abs.i64(i64 %sub, i1 false)
  %trunc = trunc i64 %abs to i16
  ret i16 %trunc
}

define i16 @abd_ext_i16_i32(i16 %a, i32 %b) nounwind {
; X86-LABEL: abd_ext_i16_i32:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movswl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl %eax, %edx
; X86-NEXT:    subl %ecx, %edx
; X86-NEXT:    negl %edx
; X86-NEXT:    subl %ecx, %eax
; X86-NEXT:    cmovlel %edx, %eax
; X86-NEXT:    # kill: def $ax killed $ax killed $eax
; X86-NEXT:    retl
;
; X64-LABEL: abd_ext_i16_i32:
; X64:       # %bb.0:
; X64-NEXT:    # kill: def $edi killed $edi def $rdi
; X64-NEXT:    movswq %di, %rcx
; X64-NEXT:    movslq %esi, %rax
; X64-NEXT:    subq %rax, %rcx
; X64-NEXT:    movq %rcx, %rax
; X64-NEXT:    negq %rax
; X64-NEXT:    cmovsq %rcx, %rax
; X64-NEXT:    # kill: def $ax killed $ax killed $rax
; X64-NEXT:    retq
  %aext = sext i16 %a to i64
  %bext = sext i32 %b to i64
  %sub = sub i64 %aext, %bext
  %abs = call i64 @llvm.abs.i64(i64 %sub, i1 false)
  %trunc = trunc i64 %abs to i16
  ret i16 %trunc
}

define i16 @abd_ext_i16_undef(i16 %a, i16 %b) nounwind {
; X86-LABEL: abd_ext_i16_undef:
; X86:       # %bb.0:
; X86-NEXT:    movswl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movswl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    subl %eax, %ecx
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:    negl %eax
; X86-NEXT:    cmovsl %ecx, %eax
; X86-NEXT:    # kill: def $ax killed $ax killed $eax
; X86-NEXT:    retl
;
; X64-LABEL: abd_ext_i16_undef:
; X64:       # %bb.0:
; X64-NEXT:    movswl %si, %eax
; X64-NEXT:    movswl %di, %ecx
; X64-NEXT:    subl %eax, %ecx
; X64-NEXT:    movl %ecx, %eax
; X64-NEXT:    negl %eax
; X64-NEXT:    cmovsl %ecx, %eax
; X64-NEXT:    # kill: def $ax killed $ax killed $eax
; X64-NEXT:    retq
  %aext = sext i16 %a to i64
  %bext = sext i16 %b to i64
  %sub = sub i64 %aext, %bext
  %abs = call i64 @llvm.abs.i64(i64 %sub, i1 true)
  %trunc = trunc i64 %abs to i16
  ret i16 %trunc
}

define i32 @abd_ext_i32(i32 %a, i32 %b) nounwind {
; X86-LABEL: abd_ext_i32:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl %eax, %edx
; X86-NEXT:    subl %ecx, %edx
; X86-NEXT:    negl %edx
; X86-NEXT:    subl %ecx, %eax
; X86-NEXT:    cmovlel %edx, %eax
; X86-NEXT:    retl
;
; X64-LABEL: abd_ext_i32:
; X64:       # %bb.0:
; X64-NEXT:    movslq %esi, %rax
; X64-NEXT:    movslq %edi, %rcx
; X64-NEXT:    subq %rax, %rcx
; X64-NEXT:    movq %rcx, %rax
; X64-NEXT:    negq %rax
; X64-NEXT:    cmovsq %rcx, %rax
; X64-NEXT:    # kill: def $eax killed $eax killed $rax
; X64-NEXT:    retq
  %aext = sext i32 %a to i64
  %bext = sext i32 %b to i64
  %sub = sub i64 %aext, %bext
  %abs = call i64 @llvm.abs.i64(i64 %sub, i1 false)
  %trunc = trunc i64 %abs to i32
  ret i32 %trunc
}

define i32 @abd_ext_i32_i16(i32 %a, i16 %b) nounwind {
; X86-LABEL: abd_ext_i32_i16:
; X86:       # %bb.0:
; X86-NEXT:    movswl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl %eax, %edx
; X86-NEXT:    subl %ecx, %edx
; X86-NEXT:    negl %edx
; X86-NEXT:    subl %ecx, %eax
; X86-NEXT:    cmovlel %edx, %eax
; X86-NEXT:    retl
;
; X64-LABEL: abd_ext_i32_i16:
; X64:       # %bb.0:
; X64-NEXT:    # kill: def $esi killed $esi def $rsi
; X64-NEXT:    movswq %si, %rax
; X64-NEXT:    movslq %edi, %rcx
; X64-NEXT:    subq %rax, %rcx
; X64-NEXT:    movq %rcx, %rax
; X64-NEXT:    negq %rax
; X64-NEXT:    cmovsq %rcx, %rax
; X64-NEXT:    # kill: def $eax killed $eax killed $rax
; X64-NEXT:    retq
  %aext = sext i32 %a to i64
  %bext = sext i16 %b to i64
  %sub = sub i64 %aext, %bext
  %abs = call i64 @llvm.abs.i64(i64 %sub, i1 false)
  %trunc = trunc i64 %abs to i32
  ret i32 %trunc
}

define i32 @abd_ext_i32_undef(i32 %a, i32 %b) nounwind {
; X86-LABEL: abd_ext_i32_undef:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl %eax, %edx
; X86-NEXT:    subl %ecx, %edx
; X86-NEXT:    negl %edx
; X86-NEXT:    subl %ecx, %eax
; X86-NEXT:    cmovlel %edx, %eax
; X86-NEXT:    retl
;
; X64-LABEL: abd_ext_i32_undef:
; X64:       # %bb.0:
; X64-NEXT:    movslq %esi, %rax
; X64-NEXT:    movslq %edi, %rcx
; X64-NEXT:    subq %rax, %rcx
; X64-NEXT:    movq %rcx, %rax
; X64-NEXT:    negq %rax
; X64-NEXT:    cmovsq %rcx, %rax
; X64-NEXT:    # kill: def $eax killed $eax killed $rax
; X64-NEXT:    retq
  %aext = sext i32 %a to i64
  %bext = sext i32 %b to i64
  %sub = sub i64 %aext, %bext
  %abs = call i64 @llvm.abs.i64(i64 %sub, i1 true)
  %trunc = trunc i64 %abs to i32
  ret i32 %trunc
}

define i64 @abd_ext_i64(i64 %a, i64 %b) nounwind {
; X86-LABEL: abd_ext_i64:
; X86:       # %bb.0:
; X86-NEXT:    pushl %edi
; X86-NEXT:    pushl %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X86-NEXT:    movl %esi, %edi
; X86-NEXT:    sarl $31, %edi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl %edx, %ecx
; X86-NEXT:    sarl $31, %ecx
; X86-NEXT:    subl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    sbbl %esi, %edx
; X86-NEXT:    movl %ecx, %esi
; X86-NEXT:    sbbl %edi, %esi
; X86-NEXT:    sbbl %edi, %ecx
; X86-NEXT:    sarl $31, %ecx
; X86-NEXT:    xorl %ecx, %edx
; X86-NEXT:    xorl %ecx, %eax
; X86-NEXT:    subl %ecx, %eax
; X86-NEXT:    sbbl %ecx, %edx
; X86-NEXT:    popl %esi
; X86-NEXT:    popl %edi
; X86-NEXT:    retl
;
; X64-LABEL: abd_ext_i64:
; X64:       # %bb.0:
; X64-NEXT:    movq %rdi, %rax
; X64-NEXT:    subq %rsi, %rax
; X64-NEXT:    negq %rax
; X64-NEXT:    subq %rsi, %rdi
; X64-NEXT:    cmovgq %rdi, %rax
; X64-NEXT:    retq
  %aext = sext i64 %a to i128
  %bext = sext i64 %b to i128
  %sub = sub i128 %aext, %bext
  %abs = call i128 @llvm.abs.i128(i128 %sub, i1 false)
  %trunc = trunc i128 %abs to i64
  ret i64 %trunc
}

define i64 @abd_ext_i64_undef(i64 %a, i64 %b) nounwind {
; X86-LABEL: abd_ext_i64_undef:
; X86:       # %bb.0:
; X86-NEXT:    pushl %edi
; X86-NEXT:    pushl %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X86-NEXT:    movl %esi, %edi
; X86-NEXT:    sarl $31, %edi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl %edx, %ecx
; X86-NEXT:    sarl $31, %ecx
; X86-NEXT:    subl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    sbbl %esi, %edx
; X86-NEXT:    movl %ecx, %esi
; X86-NEXT:    sbbl %edi, %esi
; X86-NEXT:    sbbl %edi, %ecx
; X86-NEXT:    sarl $31, %ecx
; X86-NEXT:    xorl %ecx, %edx
; X86-NEXT:    xorl %ecx, %eax
; X86-NEXT:    subl %ecx, %eax
; X86-NEXT:    sbbl %ecx, %edx
; X86-NEXT:    popl %esi
; X86-NEXT:    popl %edi
; X86-NEXT:    retl
;
; X64-LABEL: abd_ext_i64_undef:
; X64:       # %bb.0:
; X64-NEXT:    movq %rdi, %rax
; X64-NEXT:    subq %rsi, %rax
; X64-NEXT:    negq %rax
; X64-NEXT:    subq %rsi, %rdi
; X64-NEXT:    cmovgq %rdi, %rax
; X64-NEXT:    retq
  %aext = sext i64 %a to i128
  %bext = sext i64 %b to i128
  %sub = sub i128 %aext, %bext
  %abs = call i128 @llvm.abs.i128(i128 %sub, i1 true)
  %trunc = trunc i128 %abs to i64
  ret i64 %trunc
}

;
; sub(smax(a,b),smin(a,b)) -> abds(a,b)
;

define i8 @abd_minmax_i8(i8 %a, i8 %b) nounwind {
; X86-LABEL: abd_minmax_i8:
; X86:       # %bb.0:
; X86-NEXT:    movsbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movsbl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    subl %eax, %ecx
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:    negl %eax
; X86-NEXT:    cmovsl %ecx, %eax
; X86-NEXT:    # kill: def $al killed $al killed $eax
; X86-NEXT:    retl
;
; X64-LABEL: abd_minmax_i8:
; X64:       # %bb.0:
; X64-NEXT:    movsbl %sil, %eax
; X64-NEXT:    movsbl %dil, %ecx
; X64-NEXT:    subl %eax, %ecx
; X64-NEXT:    movl %ecx, %eax
; X64-NEXT:    negl %eax
; X64-NEXT:    cmovsl %ecx, %eax
; X64-NEXT:    # kill: def $al killed $al killed $eax
; X64-NEXT:    retq
  %min = call i8 @llvm.smin.i8(i8 %a, i8 %b)
  %max = call i8 @llvm.smax.i8(i8 %a, i8 %b)
  %sub = sub i8 %max, %min
  ret i8 %sub
}

define i16 @abd_minmax_i16(i16 %a, i16 %b) nounwind {
; X86-LABEL: abd_minmax_i16:
; X86:       # %bb.0:
; X86-NEXT:    movswl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movswl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    subl %eax, %ecx
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:    negl %eax
; X86-NEXT:    cmovsl %ecx, %eax
; X86-NEXT:    # kill: def $ax killed $ax killed $eax
; X86-NEXT:    retl
;
; X64-LABEL: abd_minmax_i16:
; X64:       # %bb.0:
; X64-NEXT:    movswl %si, %eax
; X64-NEXT:    movswl %di, %ecx
; X64-NEXT:    subl %eax, %ecx
; X64-NEXT:    movl %ecx, %eax
; X64-NEXT:    negl %eax
; X64-NEXT:    cmovsl %ecx, %eax
; X64-NEXT:    # kill: def $ax killed $ax killed $eax
; X64-NEXT:    retq
  %min = call i16 @llvm.smin.i16(i16 %a, i16 %b)
  %max = call i16 @llvm.smax.i16(i16 %a, i16 %b)
  %sub = sub i16 %max, %min
  ret i16 %sub
}

define i32 @abd_minmax_i32(i32 %a, i32 %b) nounwind {
; X86-LABEL: abd_minmax_i32:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl %eax, %edx
; X86-NEXT:    subl %ecx, %edx
; X86-NEXT:    negl %edx
; X86-NEXT:    subl %ecx, %eax
; X86-NEXT:    cmovlel %edx, %eax
; X86-NEXT:    retl
;
; X64-LABEL: abd_minmax_i32:
; X64:       # %bb.0:
; X64-NEXT:    movslq %esi, %rax
; X64-NEXT:    movslq %edi, %rcx
; X64-NEXT:    subq %rax, %rcx
; X64-NEXT:    movq %rcx, %rax
; X64-NEXT:    negq %rax
; X64-NEXT:    cmovsq %rcx, %rax
; X64-NEXT:    # kill: def $eax killed $eax killed $rax
; X64-NEXT:    retq
  %min = call i32 @llvm.smin.i32(i32 %a, i32 %b)
  %max = call i32 @llvm.smax.i32(i32 %a, i32 %b)
  %sub = sub i32 %max, %min
  ret i32 %sub
}

define i64 @abd_minmax_i64(i64 %a, i64 %b) nounwind {
; X86-LABEL: abd_minmax_i64:
; X86:       # %bb.0:
; X86-NEXT:    pushl %ebp
; X86-NEXT:    pushl %ebx
; X86-NEXT:    pushl %edi
; X86-NEXT:    pushl %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X86-NEXT:    cmpl %eax, %ecx
; X86-NEXT:    movl %esi, %edi
; X86-NEXT:    sbbl %edx, %edi
; X86-NEXT:    movl %edx, %edi
; X86-NEXT:    cmovll %esi, %edi
; X86-NEXT:    movl %eax, %ebx
; X86-NEXT:    cmovll %ecx, %ebx
; X86-NEXT:    cmpl %ecx, %eax
; X86-NEXT:    movl %edx, %ebp
; X86-NEXT:    sbbl %esi, %ebp
; X86-NEXT:    cmovll %esi, %edx
; X86-NEXT:    cmovll %ecx, %eax
; X86-NEXT:    subl %ebx, %eax
; X86-NEXT:    sbbl %edi, %edx
; X86-NEXT:    popl %esi
; X86-NEXT:    popl %edi
; X86-NEXT:    popl %ebx
; X86-NEXT:    popl %ebp
; X86-NEXT:    retl
;
; X64-LABEL: abd_minmax_i64:
; X64:       # %bb.0:
; X64-NEXT:    movq %rdi, %rax
; X64-NEXT:    subq %rsi, %rax
; X64-NEXT:    negq %rax
; X64-NEXT:    subq %rsi, %rdi
; X64-NEXT:    cmovgq %rdi, %rax
; X64-NEXT:    retq
  %min = call i64 @llvm.smin.i64(i64 %a, i64 %b)
  %max = call i64 @llvm.smax.i64(i64 %a, i64 %b)
  %sub = sub i64 %max, %min
  ret i64 %sub
}

;
; select(icmp(a,b),sub(a,b),sub(b,a)) -> abds(a,b)
;

define i8 @abd_cmp_i8(i8 %a, i8 %b) nounwind {
; X86-LABEL: abd_cmp_i8:
; X86:       # %bb.0:
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl %eax, %edx
; X86-NEXT:    subb %cl, %dl
; X86-NEXT:    negb %dl
; X86-NEXT:    subb %cl, %al
; X86-NEXT:    movzbl %al, %ecx
; X86-NEXT:    movzbl %dl, %eax
; X86-NEXT:    cmovgl %ecx, %eax
; X86-NEXT:    # kill: def $al killed $al killed $eax
; X86-NEXT:    retl
;
; X64-LABEL: abd_cmp_i8:
; X64:       # %bb.0:
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    subb %sil, %al
; X64-NEXT:    negb %al
; X64-NEXT:    subb %sil, %dil
; X64-NEXT:    movzbl %dil, %ecx
; X64-NEXT:    movzbl %al, %eax
; X64-NEXT:    cmovgl %ecx, %eax
; X64-NEXT:    # kill: def $al killed $al killed $eax
; X64-NEXT:    retq
  %cmp = icmp sgt i8 %a, %b
  %ab = sub i8 %a, %b
  %ba = sub i8 %b, %a
  %sel = select i1 %cmp, i8 %ab, i8 %ba
  ret i8 %sel
}

define i16 @abd_cmp_i16(i16 %a, i16 %b) nounwind {
; X86-LABEL: abd_cmp_i16:
; X86:       # %bb.0:
; X86-NEXT:    pushl %esi
; X86-NEXT:    movzwl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movzwl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl %ecx, %esi
; X86-NEXT:    subw %dx, %si
; X86-NEXT:    movl %esi, %eax
; X86-NEXT:    negl %eax
; X86-NEXT:    cmpw %dx, %cx
; X86-NEXT:    cmovgel %esi, %eax
; X86-NEXT:    # kill: def $ax killed $ax killed $eax
; X86-NEXT:    popl %esi
; X86-NEXT:    retl
;
; X64-LABEL: abd_cmp_i16:
; X64:       # %bb.0:
; X64-NEXT:    movl %edi, %ecx
; X64-NEXT:    subw %si, %cx
; X64-NEXT:    movl %ecx, %eax
; X64-NEXT:    negl %eax
; X64-NEXT:    cmpw %si, %di
; X64-NEXT:    cmovgel %ecx, %eax
; X64-NEXT:    # kill: def $ax killed $ax killed $eax
; X64-NEXT:    retq
  %cmp = icmp sge i16 %a, %b
  %ab = sub i16 %a, %b
  %ba = sub i16 %b, %a
  %sel = select i1 %cmp, i16 %ab, i16 %ba
  ret i16 %sel
}

define i32 @abd_cmp_i32(i32 %a, i32 %b) nounwind {
; X86-LABEL: abd_cmp_i32:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl %eax, %edx
; X86-NEXT:    subl %ecx, %edx
; X86-NEXT:    negl %edx
; X86-NEXT:    subl %ecx, %eax
; X86-NEXT:    cmovll %edx, %eax
; X86-NEXT:    retl
;
; X64-LABEL: abd_cmp_i32:
; X64:       # %bb.0:
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    subl %esi, %eax
; X64-NEXT:    negl %eax
; X64-NEXT:    subl %esi, %edi
; X64-NEXT:    cmovgel %edi, %eax
; X64-NEXT:    retq
  %cmp = icmp slt i32 %a, %b
  %ab = sub i32 %a, %b
  %ba = sub i32 %b, %a
  %sel = select i1 %cmp, i32 %ba, i32 %ab
  ret i32 %sel
}

define i64 @abd_cmp_i64(i64 %a, i64 %b) nounwind {
; X86-LABEL: abd_cmp_i64:
; X86:       # %bb.0:
; X86-NEXT:    pushl %ebx
; X86-NEXT:    pushl %edi
; X86-NEXT:    pushl %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X86-NEXT:    movl %ecx, %edi
; X86-NEXT:    subl %eax, %edi
; X86-NEXT:    movl %esi, %ebx
; X86-NEXT:    sbbl %edx, %ebx
; X86-NEXT:    subl %ecx, %eax
; X86-NEXT:    sbbl %esi, %edx
; X86-NEXT:    cmovgel %edi, %eax
; X86-NEXT:    cmovgel %ebx, %edx
; X86-NEXT:    popl %esi
; X86-NEXT:    popl %edi
; X86-NEXT:    popl %ebx
; X86-NEXT:    retl
;
; X64-LABEL: abd_cmp_i64:
; X64:       # %bb.0:
; X64-NEXT:    movq %rdi, %rax
; X64-NEXT:    subq %rsi, %rax
; X64-NEXT:    negq %rax
; X64-NEXT:    subq %rsi, %rdi
; X64-NEXT:    cmovlq %rdi, %rax
; X64-NEXT:    retq
  %cmp = icmp sge i64 %a, %b
  %ab = sub i64 %a, %b
  %ba = sub i64 %b, %a
  %sel = select i1 %cmp, i64 %ba, i64 %ab
  ret i64 %sel
}

;
; abs(sub_nsw(x, y)) -> abds(a,b)
;

define i8 @abd_subnsw_i8(i8 %a, i8 %b) nounwind {
; X86-LABEL: abd_subnsw_i8:
; X86:       # %bb.0:
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    subb {{[0-9]+}}(%esp), %al
; X86-NEXT:    movl %eax, %ecx
; X86-NEXT:    sarb $7, %cl
; X86-NEXT:    xorb %cl, %al
; X86-NEXT:    subb %cl, %al
; X86-NEXT:    retl
;
; X64-LABEL: abd_subnsw_i8:
; X64:       # %bb.0:
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    subb %sil, %al
; X64-NEXT:    movl %eax, %ecx
; X64-NEXT:    sarb $7, %cl
; X64-NEXT:    xorb %cl, %al
; X64-NEXT:    subb %cl, %al
; X64-NEXT:    # kill: def $al killed $al killed $eax
; X64-NEXT:    retq
  %sub = sub nsw i8 %a, %b
  %abs = call i8 @llvm.abs.i8(i8 %sub, i1 false)
  ret i8 %abs
}

define i8 @abd_subnsw_i8_undef(i8 %a, i8 %b) nounwind {
; X86-LABEL: abd_subnsw_i8_undef:
; X86:       # %bb.0:
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    subb {{[0-9]+}}(%esp), %al
; X86-NEXT:    movl %eax, %ecx
; X86-NEXT:    sarb $7, %cl
; X86-NEXT:    xorb %cl, %al
; X86-NEXT:    subb %cl, %al
; X86-NEXT:    retl
;
; X64-LABEL: abd_subnsw_i8_undef:
; X64:       # %bb.0:
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    subb %sil, %al
; X64-NEXT:    movl %eax, %ecx
; X64-NEXT:    sarb $7, %cl
; X64-NEXT:    xorb %cl, %al
; X64-NEXT:    subb %cl, %al
; X64-NEXT:    # kill: def $al killed $al killed $eax
; X64-NEXT:    retq
  %sub = sub nsw i8 %a, %b
  %abs = call i8 @llvm.abs.i8(i8 %sub, i1 true)
  ret i8 %abs
}

define i16 @abd_subnsw_i16(i16 %a, i16 %b) nounwind {
; X86-LABEL: abd_subnsw_i16:
; X86:       # %bb.0:
; X86-NEXT:    movzwl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    subw {{[0-9]+}}(%esp), %cx
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:    negw %ax
; X86-NEXT:    cmovsw %cx, %ax
; X86-NEXT:    retl
;
; X64-LABEL: abd_subnsw_i16:
; X64:       # %bb.0:
; X64-NEXT:    subl %esi, %edi
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    negw %ax
; X64-NEXT:    cmovsw %di, %ax
; X64-NEXT:    retq
  %sub = sub nsw i16 %a, %b
  %abs = call i16 @llvm.abs.i16(i16 %sub, i1 false)
  ret i16 %abs
}

define i16 @abd_subnsw_i16_undef(i16 %a, i16 %b) nounwind {
; X86-LABEL: abd_subnsw_i16_undef:
; X86:       # %bb.0:
; X86-NEXT:    movzwl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    subw {{[0-9]+}}(%esp), %cx
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:    negw %ax
; X86-NEXT:    cmovsw %cx, %ax
; X86-NEXT:    retl
;
; X64-LABEL: abd_subnsw_i16_undef:
; X64:       # %bb.0:
; X64-NEXT:    subl %esi, %edi
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    negw %ax
; X64-NEXT:    cmovsw %di, %ax
; X64-NEXT:    retq
  %sub = sub nsw i16 %a, %b
  %abs = call i16 @llvm.abs.i16(i16 %sub, i1 true)
  ret i16 %abs
}

define i32 @abd_subnsw_i32(i32 %a, i32 %b) nounwind {
; X86-LABEL: abd_subnsw_i32:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    subl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:    negl %eax
; X86-NEXT:    cmovsl %ecx, %eax
; X86-NEXT:    retl
;
; X64-LABEL: abd_subnsw_i32:
; X64:       # %bb.0:
; X64-NEXT:    subl %esi, %edi
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    negl %eax
; X64-NEXT:    cmovsl %edi, %eax
; X64-NEXT:    retq
  %sub = sub nsw i32 %a, %b
  %abs = call i32 @llvm.abs.i32(i32 %sub, i1 false)
  ret i32 %abs
}

define i32 @abd_subnsw_i32_undef(i32 %a, i32 %b) nounwind {
; X86-LABEL: abd_subnsw_i32_undef:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    subl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:    negl %eax
; X86-NEXT:    cmovsl %ecx, %eax
; X86-NEXT:    retl
;
; X64-LABEL: abd_subnsw_i32_undef:
; X64:       # %bb.0:
; X64-NEXT:    subl %esi, %edi
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    negl %eax
; X64-NEXT:    cmovsl %edi, %eax
; X64-NEXT:    retq
  %sub = sub nsw i32 %a, %b
  %abs = call i32 @llvm.abs.i32(i32 %sub, i1 true)
  ret i32 %abs
}

define i64 @abd_subnsw_i64(i64 %a, i64 %b) nounwind {
; X86-LABEL: abd_subnsw_i64:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    subl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    sbbl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl %edx, %ecx
; X86-NEXT:    sarl $31, %ecx
; X86-NEXT:    xorl %ecx, %edx
; X86-NEXT:    xorl %ecx, %eax
; X86-NEXT:    subl %ecx, %eax
; X86-NEXT:    sbbl %ecx, %edx
; X86-NEXT:    retl
;
; X64-LABEL: abd_subnsw_i64:
; X64:       # %bb.0:
; X64-NEXT:    subq %rsi, %rdi
; X64-NEXT:    movq %rdi, %rax
; X64-NEXT:    negq %rax
; X64-NEXT:    cmovsq %rdi, %rax
; X64-NEXT:    retq
  %sub = sub nsw i64 %a, %b
  %abs = call i64 @llvm.abs.i64(i64 %sub, i1 false)
  ret i64 %abs
}

define i64 @abd_subnsw_i64_undef(i64 %a, i64 %b) nounwind {
; X86-LABEL: abd_subnsw_i64_undef:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    subl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    sbbl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl %edx, %ecx
; X86-NEXT:    sarl $31, %ecx
; X86-NEXT:    xorl %ecx, %edx
; X86-NEXT:    xorl %ecx, %eax
; X86-NEXT:    subl %ecx, %eax
; X86-NEXT:    sbbl %ecx, %edx
; X86-NEXT:    retl
;
; X64-LABEL: abd_subnsw_i64_undef:
; X64:       # %bb.0:
; X64-NEXT:    subq %rsi, %rdi
; X64-NEXT:    movq %rdi, %rax
; X64-NEXT:    negq %rax
; X64-NEXT:    cmovsq %rdi, %rax
; X64-NEXT:    retq
  %sub = sub nsw i64 %a, %b
  %abs = call i64 @llvm.abs.i64(i64 %sub, i1 true)
  ret i64 %abs
}

;
; negative tests
;

define i32 @abd_sub_i32(i32 %a, i32 %b) nounwind {
; X86-LABEL: abd_sub_i32:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    subl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:    negl %eax
; X86-NEXT:    cmovsl %ecx, %eax
; X86-NEXT:    retl
;
; X64-LABEL: abd_sub_i32:
; X64:       # %bb.0:
; X64-NEXT:    subl %esi, %edi
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    negl %eax
; X64-NEXT:    cmovsl %edi, %eax
; X64-NEXT:    retq
  %sub = sub i32 %a, %b
  %abs = call i32 @llvm.abs.i32(i32 %sub, i1 false)
  ret i32 %abs
}


declare i8 @llvm.abs.i8(i8, i1)
declare i16 @llvm.abs.i16(i16, i1)
declare i32 @llvm.abs.i32(i32, i1)
declare i64 @llvm.abs.i64(i64, i1)
declare i128 @llvm.abs.i128(i128, i1)

declare i8 @llvm.smax.i8(i8, i8)
declare i16 @llvm.smax.i16(i16, i16)
declare i32 @llvm.smax.i32(i32, i32)
declare i64 @llvm.smax.i64(i64, i64)

declare i8 @llvm.smin.i8(i8, i8)
declare i16 @llvm.smin.i16(i16, i16)
declare i32 @llvm.smin.i32(i32, i32)
declare i64 @llvm.smin.i64(i64, i64)
