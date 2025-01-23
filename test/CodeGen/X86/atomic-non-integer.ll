; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i386-linux-generic -verify-machineinstrs -mattr=sse | FileCheck %s --check-prefixes=X86,X86-SSE1
; RUN: llc < %s -mtriple=i386-linux-generic -verify-machineinstrs -mattr=sse2 | FileCheck %s --check-prefixes=X86,X86-SSE2
; RUN: llc < %s -mtriple=i386-linux-generic -verify-machineinstrs -mattr=avx | FileCheck %s --check-prefixes=X86,X86-AVX
; RUN: llc < %s -mtriple=i386-linux-generic -verify-machineinstrs -mattr=avx512f | FileCheck %s --check-prefixes=X86,X86-AVX
; RUN: llc < %s -mtriple=i386-linux-generic -verify-machineinstrs | FileCheck %s --check-prefixes=X86,X86-NOSSE
; RUN: llc < %s -mtriple=x86_64-linux-generic -verify-machineinstrs -mattr=sse2 | FileCheck %s --check-prefixes=X64-SSE
; RUN: llc < %s -mtriple=x86_64-linux-generic -verify-machineinstrs -mattr=avx | FileCheck %s --check-prefixes=X64-AVX
; RUN: llc < %s -mtriple=x86_64-linux-generic -verify-machineinstrs -mattr=avx512f | FileCheck %s --check-prefixes=X64-AVX

; Note: This test is testing that the lowering for atomics matches what we
; currently emit for non-atomics + the atomic restriction.  The presence of
; particular lowering detail in these tests should not be read as requiring
; that detail for correctness unless it's related to the atomicity itself.
; (Specifically, there were reviewer questions about the lowering for halfs
;  and their calling convention which remain unresolved.)

define void @store_half(ptr %fptr, half %v) {
; X86-SSE1-LABEL: store_half:
; X86-SSE1:       # %bb.0:
; X86-SSE1-NEXT:    movzwl {{[0-9]+}}(%esp), %eax
; X86-SSE1-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-SSE1-NEXT:    movw %ax, (%ecx)
; X86-SSE1-NEXT:    retl
;
; X86-SSE2-LABEL: store_half:
; X86-SSE2:       # %bb.0:
; X86-SSE2-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-SSE2-NEXT:    movzwl {{[0-9]+}}(%esp), %ecx
; X86-SSE2-NEXT:    movw %cx, (%eax)
; X86-SSE2-NEXT:    retl
;
; X86-AVX-LABEL: store_half:
; X86-AVX:       # %bb.0:
; X86-AVX-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-AVX-NEXT:    movzwl {{[0-9]+}}(%esp), %ecx
; X86-AVX-NEXT:    movw %cx, (%eax)
; X86-AVX-NEXT:    retl
;
; X86-NOSSE-LABEL: store_half:
; X86-NOSSE:       # %bb.0:
; X86-NOSSE-NEXT:    movzwl {{[0-9]+}}(%esp), %eax
; X86-NOSSE-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NOSSE-NEXT:    movw %ax, (%ecx)
; X86-NOSSE-NEXT:    retl
;
; X64-SSE-LABEL: store_half:
; X64-SSE:       # %bb.0:
; X64-SSE-NEXT:    pextrw $0, %xmm0, %eax
; X64-SSE-NEXT:    movw %ax, (%rdi)
; X64-SSE-NEXT:    retq
;
; X64-AVX-LABEL: store_half:
; X64-AVX:       # %bb.0:
; X64-AVX-NEXT:    vpextrw $0, %xmm0, %eax
; X64-AVX-NEXT:    movw %ax, (%rdi)
; X64-AVX-NEXT:    retq
  store atomic half %v, ptr %fptr unordered, align 2
  ret void
}

define void @store_float(ptr %fptr, float %v) {
; X86-LABEL: store_float:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl %ecx, (%eax)
; X86-NEXT:    retl
;
; X64-SSE-LABEL: store_float:
; X64-SSE:       # %bb.0:
; X64-SSE-NEXT:    movss %xmm0, (%rdi)
; X64-SSE-NEXT:    retq
;
; X64-AVX-LABEL: store_float:
; X64-AVX:       # %bb.0:
; X64-AVX-NEXT:    vmovss %xmm0, (%rdi)
; X64-AVX-NEXT:    retq
  store atomic float %v, ptr %fptr unordered, align 4
  ret void
}

define void @store_double(ptr %fptr, double %v) {
; X86-SSE1-LABEL: store_double:
; X86-SSE1:       # %bb.0:
; X86-SSE1-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-SSE1-NEXT:    xorps %xmm0, %xmm0
; X86-SSE1-NEXT:    movlps {{.*#+}} xmm0 = mem[0,1],xmm0[2,3]
; X86-SSE1-NEXT:    movlps %xmm0, (%eax)
; X86-SSE1-NEXT:    retl
;
; X86-SSE2-LABEL: store_double:
; X86-SSE2:       # %bb.0:
; X86-SSE2-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-SSE2-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; X86-SSE2-NEXT:    movlps %xmm0, (%eax)
; X86-SSE2-NEXT:    retl
;
; X86-AVX-LABEL: store_double:
; X86-AVX:       # %bb.0:
; X86-AVX-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-AVX-NEXT:    vmovsd {{.*#+}} xmm0 = mem[0],zero
; X86-AVX-NEXT:    vmovlps %xmm0, (%eax)
; X86-AVX-NEXT:    retl
;
; X86-NOSSE-LABEL: store_double:
; X86-NOSSE:       # %bb.0:
; X86-NOSSE-NEXT:    subl $12, %esp
; X86-NOSSE-NEXT:    .cfi_def_cfa_offset 16
; X86-NOSSE-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NOSSE-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NOSSE-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NOSSE-NEXT:    movl %edx, {{[0-9]+}}(%esp)
; X86-NOSSE-NEXT:    movl %ecx, (%esp)
; X86-NOSSE-NEXT:    fildll (%esp)
; X86-NOSSE-NEXT:    fistpll (%eax)
; X86-NOSSE-NEXT:    addl $12, %esp
; X86-NOSSE-NEXT:    .cfi_def_cfa_offset 4
; X86-NOSSE-NEXT:    retl
;
; X64-SSE-LABEL: store_double:
; X64-SSE:       # %bb.0:
; X64-SSE-NEXT:    movsd %xmm0, (%rdi)
; X64-SSE-NEXT:    retq
;
; X64-AVX-LABEL: store_double:
; X64-AVX:       # %bb.0:
; X64-AVX-NEXT:    vmovsd %xmm0, (%rdi)
; X64-AVX-NEXT:    retq
  store atomic double %v, ptr %fptr unordered, align 8
  ret void
}

define half @load_half(ptr %fptr) {
; X86-SSE1-LABEL: load_half:
; X86-SSE1:       # %bb.0:
; X86-SSE1-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-SSE1-NEXT:    movzwl (%eax), %eax
; X86-SSE1-NEXT:    retl
;
; X86-SSE2-LABEL: load_half:
; X86-SSE2:       # %bb.0:
; X86-SSE2-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-SSE2-NEXT:    movzwl (%eax), %eax
; X86-SSE2-NEXT:    pinsrw $0, %eax, %xmm0
; X86-SSE2-NEXT:    retl
;
; X86-AVX-LABEL: load_half:
; X86-AVX:       # %bb.0:
; X86-AVX-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-AVX-NEXT:    movzwl (%eax), %eax
; X86-AVX-NEXT:    vpinsrw $0, %eax, %xmm0, %xmm0
; X86-AVX-NEXT:    retl
;
; X86-NOSSE-LABEL: load_half:
; X86-NOSSE:       # %bb.0:
; X86-NOSSE-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NOSSE-NEXT:    movzwl (%eax), %eax
; X86-NOSSE-NEXT:    retl
;
; X64-SSE-LABEL: load_half:
; X64-SSE:       # %bb.0:
; X64-SSE-NEXT:    movzwl (%rdi), %eax
; X64-SSE-NEXT:    pinsrw $0, %eax, %xmm0
; X64-SSE-NEXT:    retq
;
; X64-AVX-LABEL: load_half:
; X64-AVX:       # %bb.0:
; X64-AVX-NEXT:    movzwl (%rdi), %eax
; X64-AVX-NEXT:    vpinsrw $0, %eax, %xmm0, %xmm0
; X64-AVX-NEXT:    retq
  %v = load atomic half, ptr %fptr unordered, align 2
  ret half %v
}

define float @load_float(ptr %fptr) {
; X86-SSE1-LABEL: load_float:
; X86-SSE1:       # %bb.0:
; X86-SSE1-NEXT:    pushl %eax
; X86-SSE1-NEXT:    .cfi_def_cfa_offset 8
; X86-SSE1-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-SSE1-NEXT:    movl (%eax), %eax
; X86-SSE1-NEXT:    movl %eax, (%esp)
; X86-SSE1-NEXT:    flds (%esp)
; X86-SSE1-NEXT:    popl %eax
; X86-SSE1-NEXT:    .cfi_def_cfa_offset 4
; X86-SSE1-NEXT:    retl
;
; X86-SSE2-LABEL: load_float:
; X86-SSE2:       # %bb.0:
; X86-SSE2-NEXT:    pushl %eax
; X86-SSE2-NEXT:    .cfi_def_cfa_offset 8
; X86-SSE2-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-SSE2-NEXT:    movss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; X86-SSE2-NEXT:    movss %xmm0, (%esp)
; X86-SSE2-NEXT:    flds (%esp)
; X86-SSE2-NEXT:    popl %eax
; X86-SSE2-NEXT:    .cfi_def_cfa_offset 4
; X86-SSE2-NEXT:    retl
;
; X86-AVX-LABEL: load_float:
; X86-AVX:       # %bb.0:
; X86-AVX-NEXT:    pushl %eax
; X86-AVX-NEXT:    .cfi_def_cfa_offset 8
; X86-AVX-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-AVX-NEXT:    vmovss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; X86-AVX-NEXT:    vmovss %xmm0, (%esp)
; X86-AVX-NEXT:    flds (%esp)
; X86-AVX-NEXT:    popl %eax
; X86-AVX-NEXT:    .cfi_def_cfa_offset 4
; X86-AVX-NEXT:    retl
;
; X86-NOSSE-LABEL: load_float:
; X86-NOSSE:       # %bb.0:
; X86-NOSSE-NEXT:    pushl %eax
; X86-NOSSE-NEXT:    .cfi_def_cfa_offset 8
; X86-NOSSE-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NOSSE-NEXT:    movl (%eax), %eax
; X86-NOSSE-NEXT:    movl %eax, (%esp)
; X86-NOSSE-NEXT:    flds (%esp)
; X86-NOSSE-NEXT:    popl %eax
; X86-NOSSE-NEXT:    .cfi_def_cfa_offset 4
; X86-NOSSE-NEXT:    retl
;
; X64-SSE-LABEL: load_float:
; X64-SSE:       # %bb.0:
; X64-SSE-NEXT:    movss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; X64-SSE-NEXT:    retq
;
; X64-AVX-LABEL: load_float:
; X64-AVX:       # %bb.0:
; X64-AVX-NEXT:    vmovss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; X64-AVX-NEXT:    retq
  %v = load atomic float, ptr %fptr unordered, align 4
  ret float %v
}

define double @load_double(ptr %fptr) {
; X86-SSE1-LABEL: load_double:
; X86-SSE1:       # %bb.0:
; X86-SSE1-NEXT:    subl $12, %esp
; X86-SSE1-NEXT:    .cfi_def_cfa_offset 16
; X86-SSE1-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-SSE1-NEXT:    xorps %xmm0, %xmm0
; X86-SSE1-NEXT:    movlps {{.*#+}} xmm0 = mem[0,1],xmm0[2,3]
; X86-SSE1-NEXT:    movss %xmm0, (%esp)
; X86-SSE1-NEXT:    shufps {{.*#+}} xmm0 = xmm0[1,1,1,1]
; X86-SSE1-NEXT:    movss %xmm0, {{[0-9]+}}(%esp)
; X86-SSE1-NEXT:    fldl (%esp)
; X86-SSE1-NEXT:    addl $12, %esp
; X86-SSE1-NEXT:    .cfi_def_cfa_offset 4
; X86-SSE1-NEXT:    retl
;
; X86-SSE2-LABEL: load_double:
; X86-SSE2:       # %bb.0:
; X86-SSE2-NEXT:    subl $12, %esp
; X86-SSE2-NEXT:    .cfi_def_cfa_offset 16
; X86-SSE2-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-SSE2-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; X86-SSE2-NEXT:    movlps %xmm0, (%esp)
; X86-SSE2-NEXT:    fldl (%esp)
; X86-SSE2-NEXT:    addl $12, %esp
; X86-SSE2-NEXT:    .cfi_def_cfa_offset 4
; X86-SSE2-NEXT:    retl
;
; X86-AVX-LABEL: load_double:
; X86-AVX:       # %bb.0:
; X86-AVX-NEXT:    subl $12, %esp
; X86-AVX-NEXT:    .cfi_def_cfa_offset 16
; X86-AVX-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-AVX-NEXT:    vmovsd {{.*#+}} xmm0 = mem[0],zero
; X86-AVX-NEXT:    vmovlps %xmm0, (%esp)
; X86-AVX-NEXT:    fldl (%esp)
; X86-AVX-NEXT:    addl $12, %esp
; X86-AVX-NEXT:    .cfi_def_cfa_offset 4
; X86-AVX-NEXT:    retl
;
; X86-NOSSE-LABEL: load_double:
; X86-NOSSE:       # %bb.0:
; X86-NOSSE-NEXT:    subl $20, %esp
; X86-NOSSE-NEXT:    .cfi_def_cfa_offset 24
; X86-NOSSE-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NOSSE-NEXT:    fildll (%eax)
; X86-NOSSE-NEXT:    fistpll {{[0-9]+}}(%esp)
; X86-NOSSE-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NOSSE-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NOSSE-NEXT:    movl %ecx, {{[0-9]+}}(%esp)
; X86-NOSSE-NEXT:    movl %eax, (%esp)
; X86-NOSSE-NEXT:    fldl (%esp)
; X86-NOSSE-NEXT:    addl $20, %esp
; X86-NOSSE-NEXT:    .cfi_def_cfa_offset 4
; X86-NOSSE-NEXT:    retl
;
; X64-SSE-LABEL: load_double:
; X64-SSE:       # %bb.0:
; X64-SSE-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; X64-SSE-NEXT:    retq
;
; X64-AVX-LABEL: load_double:
; X64-AVX:       # %bb.0:
; X64-AVX-NEXT:    vmovsd {{.*#+}} xmm0 = mem[0],zero
; X64-AVX-NEXT:    retq
  %v = load atomic double, ptr %fptr unordered, align 8
  ret double %v
}

define half @exchange_half(ptr %fptr, half %x) {
; X86-SSE1-LABEL: exchange_half:
; X86-SSE1:       # %bb.0:
; X86-SSE1-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-SSE1-NEXT:    movzwl {{[0-9]+}}(%esp), %eax
; X86-SSE1-NEXT:    xchgw %ax, (%ecx)
; X86-SSE1-NEXT:    retl
;
; X86-SSE2-LABEL: exchange_half:
; X86-SSE2:       # %bb.0:
; X86-SSE2-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-SSE2-NEXT:    movzwl {{[0-9]+}}(%esp), %ecx
; X86-SSE2-NEXT:    xchgw %cx, (%eax)
; X86-SSE2-NEXT:    pinsrw $0, %ecx, %xmm0
; X86-SSE2-NEXT:    retl
;
; X86-AVX-LABEL: exchange_half:
; X86-AVX:       # %bb.0:
; X86-AVX-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-AVX-NEXT:    movzwl {{[0-9]+}}(%esp), %ecx
; X86-AVX-NEXT:    xchgw %cx, (%eax)
; X86-AVX-NEXT:    vpinsrw $0, %ecx, %xmm0, %xmm0
; X86-AVX-NEXT:    retl
;
; X86-NOSSE-LABEL: exchange_half:
; X86-NOSSE:       # %bb.0:
; X86-NOSSE-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NOSSE-NEXT:    movzwl {{[0-9]+}}(%esp), %eax
; X86-NOSSE-NEXT:    xchgw %ax, (%ecx)
; X86-NOSSE-NEXT:    retl
;
; X64-SSE-LABEL: exchange_half:
; X64-SSE:       # %bb.0:
; X64-SSE-NEXT:    pextrw $0, %xmm0, %eax
; X64-SSE-NEXT:    xchgw %ax, (%rdi)
; X64-SSE-NEXT:    pinsrw $0, %eax, %xmm0
; X64-SSE-NEXT:    retq
;
; X64-AVX-LABEL: exchange_half:
; X64-AVX:       # %bb.0:
; X64-AVX-NEXT:    vpextrw $0, %xmm0, %eax
; X64-AVX-NEXT:    xchgw %ax, (%rdi)
; X64-AVX-NEXT:    vpinsrw $0, %eax, %xmm0, %xmm0
; X64-AVX-NEXT:    retq
  %v = atomicrmw xchg ptr %fptr, half %x monotonic, align 2
  ret half %v
}

define float @exchange_float(ptr %fptr, float %x) {
; X86-SSE1-LABEL: exchange_float:
; X86-SSE1:       # %bb.0:
; X86-SSE1-NEXT:    pushl %eax
; X86-SSE1-NEXT:    .cfi_def_cfa_offset 8
; X86-SSE1-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-SSE1-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-SSE1-NEXT:    xchgl %ecx, (%eax)
; X86-SSE1-NEXT:    movl %ecx, (%esp)
; X86-SSE1-NEXT:    flds (%esp)
; X86-SSE1-NEXT:    popl %eax
; X86-SSE1-NEXT:    .cfi_def_cfa_offset 4
; X86-SSE1-NEXT:    retl
;
; X86-SSE2-LABEL: exchange_float:
; X86-SSE2:       # %bb.0:
; X86-SSE2-NEXT:    pushl %eax
; X86-SSE2-NEXT:    .cfi_def_cfa_offset 8
; X86-SSE2-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-SSE2-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-SSE2-NEXT:    xchgl %ecx, (%eax)
; X86-SSE2-NEXT:    movd %ecx, %xmm0
; X86-SSE2-NEXT:    movd %xmm0, (%esp)
; X86-SSE2-NEXT:    flds (%esp)
; X86-SSE2-NEXT:    popl %eax
; X86-SSE2-NEXT:    .cfi_def_cfa_offset 4
; X86-SSE2-NEXT:    retl
;
; X86-AVX-LABEL: exchange_float:
; X86-AVX:       # %bb.0:
; X86-AVX-NEXT:    pushl %eax
; X86-AVX-NEXT:    .cfi_def_cfa_offset 8
; X86-AVX-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-AVX-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-AVX-NEXT:    xchgl %ecx, (%eax)
; X86-AVX-NEXT:    vmovd %ecx, %xmm0
; X86-AVX-NEXT:    vmovd %xmm0, (%esp)
; X86-AVX-NEXT:    flds (%esp)
; X86-AVX-NEXT:    popl %eax
; X86-AVX-NEXT:    .cfi_def_cfa_offset 4
; X86-AVX-NEXT:    retl
;
; X86-NOSSE-LABEL: exchange_float:
; X86-NOSSE:       # %bb.0:
; X86-NOSSE-NEXT:    pushl %eax
; X86-NOSSE-NEXT:    .cfi_def_cfa_offset 8
; X86-NOSSE-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NOSSE-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NOSSE-NEXT:    xchgl %ecx, (%eax)
; X86-NOSSE-NEXT:    movl %ecx, (%esp)
; X86-NOSSE-NEXT:    flds (%esp)
; X86-NOSSE-NEXT:    popl %eax
; X86-NOSSE-NEXT:    .cfi_def_cfa_offset 4
; X86-NOSSE-NEXT:    retl
;
; X64-SSE-LABEL: exchange_float:
; X64-SSE:       # %bb.0:
; X64-SSE-NEXT:    movd %xmm0, %eax
; X64-SSE-NEXT:    xchgl %eax, (%rdi)
; X64-SSE-NEXT:    movd %eax, %xmm0
; X64-SSE-NEXT:    retq
;
; X64-AVX-LABEL: exchange_float:
; X64-AVX:       # %bb.0:
; X64-AVX-NEXT:    vmovd %xmm0, %eax
; X64-AVX-NEXT:    xchgl %eax, (%rdi)
; X64-AVX-NEXT:    vmovd %eax, %xmm0
; X64-AVX-NEXT:    retq
  %v = atomicrmw xchg ptr %fptr, float %x monotonic, align 4
  ret float %v
}

define double @exchange_double(ptr %fptr, double %x) {
; X86-SSE1-LABEL: exchange_double:
; X86-SSE1:       # %bb.0:
; X86-SSE1-NEXT:    pushl %ebx
; X86-SSE1-NEXT:    .cfi_def_cfa_offset 8
; X86-SSE1-NEXT:    pushl %esi
; X86-SSE1-NEXT:    .cfi_def_cfa_offset 12
; X86-SSE1-NEXT:    subl $12, %esp
; X86-SSE1-NEXT:    .cfi_def_cfa_offset 24
; X86-SSE1-NEXT:    .cfi_offset %esi, -12
; X86-SSE1-NEXT:    .cfi_offset %ebx, -8
; X86-SSE1-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X86-SSE1-NEXT:    movl {{[0-9]+}}(%esp), %ebx
; X86-SSE1-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-SSE1-NEXT:    movl (%esi), %eax
; X86-SSE1-NEXT:    movl 4(%esi), %edx
; X86-SSE1-NEXT:    .p2align 4, 0x90
; X86-SSE1-NEXT:  .LBB8_1: # %atomicrmw.start
; X86-SSE1-NEXT:    # =>This Inner Loop Header: Depth=1
; X86-SSE1-NEXT:    lock cmpxchg8b (%esi)
; X86-SSE1-NEXT:    jne .LBB8_1
; X86-SSE1-NEXT:  # %bb.2: # %atomicrmw.end
; X86-SSE1-NEXT:    movl %eax, (%esp)
; X86-SSE1-NEXT:    movl %edx, {{[0-9]+}}(%esp)
; X86-SSE1-NEXT:    fldl (%esp)
; X86-SSE1-NEXT:    addl $12, %esp
; X86-SSE1-NEXT:    .cfi_def_cfa_offset 12
; X86-SSE1-NEXT:    popl %esi
; X86-SSE1-NEXT:    .cfi_def_cfa_offset 8
; X86-SSE1-NEXT:    popl %ebx
; X86-SSE1-NEXT:    .cfi_def_cfa_offset 4
; X86-SSE1-NEXT:    retl
;
; X86-SSE2-LABEL: exchange_double:
; X86-SSE2:       # %bb.0:
; X86-SSE2-NEXT:    pushl %ebx
; X86-SSE2-NEXT:    .cfi_def_cfa_offset 8
; X86-SSE2-NEXT:    pushl %esi
; X86-SSE2-NEXT:    .cfi_def_cfa_offset 12
; X86-SSE2-NEXT:    subl $12, %esp
; X86-SSE2-NEXT:    .cfi_def_cfa_offset 24
; X86-SSE2-NEXT:    .cfi_offset %esi, -12
; X86-SSE2-NEXT:    .cfi_offset %ebx, -8
; X86-SSE2-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X86-SSE2-NEXT:    movl {{[0-9]+}}(%esp), %ebx
; X86-SSE2-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-SSE2-NEXT:    movl (%esi), %eax
; X86-SSE2-NEXT:    movl 4(%esi), %edx
; X86-SSE2-NEXT:    .p2align 4, 0x90
; X86-SSE2-NEXT:  .LBB8_1: # %atomicrmw.start
; X86-SSE2-NEXT:    # =>This Inner Loop Header: Depth=1
; X86-SSE2-NEXT:    lock cmpxchg8b (%esi)
; X86-SSE2-NEXT:    jne .LBB8_1
; X86-SSE2-NEXT:  # %bb.2: # %atomicrmw.end
; X86-SSE2-NEXT:    movd %eax, %xmm0
; X86-SSE2-NEXT:    movd %edx, %xmm1
; X86-SSE2-NEXT:    punpckldq {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
; X86-SSE2-NEXT:    movq %xmm0, (%esp)
; X86-SSE2-NEXT:    fldl (%esp)
; X86-SSE2-NEXT:    addl $12, %esp
; X86-SSE2-NEXT:    .cfi_def_cfa_offset 12
; X86-SSE2-NEXT:    popl %esi
; X86-SSE2-NEXT:    .cfi_def_cfa_offset 8
; X86-SSE2-NEXT:    popl %ebx
; X86-SSE2-NEXT:    .cfi_def_cfa_offset 4
; X86-SSE2-NEXT:    retl
;
; X86-AVX-LABEL: exchange_double:
; X86-AVX:       # %bb.0:
; X86-AVX-NEXT:    pushl %ebx
; X86-AVX-NEXT:    .cfi_def_cfa_offset 8
; X86-AVX-NEXT:    pushl %esi
; X86-AVX-NEXT:    .cfi_def_cfa_offset 12
; X86-AVX-NEXT:    subl $12, %esp
; X86-AVX-NEXT:    .cfi_def_cfa_offset 24
; X86-AVX-NEXT:    .cfi_offset %esi, -12
; X86-AVX-NEXT:    .cfi_offset %ebx, -8
; X86-AVX-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X86-AVX-NEXT:    movl {{[0-9]+}}(%esp), %ebx
; X86-AVX-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-AVX-NEXT:    movl (%esi), %eax
; X86-AVX-NEXT:    movl 4(%esi), %edx
; X86-AVX-NEXT:    .p2align 4, 0x90
; X86-AVX-NEXT:  .LBB8_1: # %atomicrmw.start
; X86-AVX-NEXT:    # =>This Inner Loop Header: Depth=1
; X86-AVX-NEXT:    lock cmpxchg8b (%esi)
; X86-AVX-NEXT:    jne .LBB8_1
; X86-AVX-NEXT:  # %bb.2: # %atomicrmw.end
; X86-AVX-NEXT:    vmovd %eax, %xmm0
; X86-AVX-NEXT:    vpinsrd $1, %edx, %xmm0, %xmm0
; X86-AVX-NEXT:    vmovq %xmm0, (%esp)
; X86-AVX-NEXT:    fldl (%esp)
; X86-AVX-NEXT:    addl $12, %esp
; X86-AVX-NEXT:    .cfi_def_cfa_offset 12
; X86-AVX-NEXT:    popl %esi
; X86-AVX-NEXT:    .cfi_def_cfa_offset 8
; X86-AVX-NEXT:    popl %ebx
; X86-AVX-NEXT:    .cfi_def_cfa_offset 4
; X86-AVX-NEXT:    retl
;
; X86-NOSSE-LABEL: exchange_double:
; X86-NOSSE:       # %bb.0:
; X86-NOSSE-NEXT:    pushl %ebx
; X86-NOSSE-NEXT:    .cfi_def_cfa_offset 8
; X86-NOSSE-NEXT:    pushl %esi
; X86-NOSSE-NEXT:    .cfi_def_cfa_offset 12
; X86-NOSSE-NEXT:    subl $12, %esp
; X86-NOSSE-NEXT:    .cfi_def_cfa_offset 24
; X86-NOSSE-NEXT:    .cfi_offset %esi, -12
; X86-NOSSE-NEXT:    .cfi_offset %ebx, -8
; X86-NOSSE-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X86-NOSSE-NEXT:    movl {{[0-9]+}}(%esp), %ebx
; X86-NOSSE-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NOSSE-NEXT:    movl (%esi), %eax
; X86-NOSSE-NEXT:    movl 4(%esi), %edx
; X86-NOSSE-NEXT:    .p2align 4, 0x90
; X86-NOSSE-NEXT:  .LBB8_1: # %atomicrmw.start
; X86-NOSSE-NEXT:    # =>This Inner Loop Header: Depth=1
; X86-NOSSE-NEXT:    lock cmpxchg8b (%esi)
; X86-NOSSE-NEXT:    jne .LBB8_1
; X86-NOSSE-NEXT:  # %bb.2: # %atomicrmw.end
; X86-NOSSE-NEXT:    movl %eax, (%esp)
; X86-NOSSE-NEXT:    movl %edx, {{[0-9]+}}(%esp)
; X86-NOSSE-NEXT:    fldl (%esp)
; X86-NOSSE-NEXT:    addl $12, %esp
; X86-NOSSE-NEXT:    .cfi_def_cfa_offset 12
; X86-NOSSE-NEXT:    popl %esi
; X86-NOSSE-NEXT:    .cfi_def_cfa_offset 8
; X86-NOSSE-NEXT:    popl %ebx
; X86-NOSSE-NEXT:    .cfi_def_cfa_offset 4
; X86-NOSSE-NEXT:    retl
;
; X64-SSE-LABEL: exchange_double:
; X64-SSE:       # %bb.0:
; X64-SSE-NEXT:    movq %xmm0, %rax
; X64-SSE-NEXT:    xchgq %rax, (%rdi)
; X64-SSE-NEXT:    movq %rax, %xmm0
; X64-SSE-NEXT:    retq
;
; X64-AVX-LABEL: exchange_double:
; X64-AVX:       # %bb.0:
; X64-AVX-NEXT:    vmovq %xmm0, %rax
; X64-AVX-NEXT:    xchgq %rax, (%rdi)
; X64-AVX-NEXT:    vmovq %rax, %xmm0
; X64-AVX-NEXT:    retq
  %v = atomicrmw xchg ptr %fptr, double %x monotonic, align 8
  ret double %v
}


; Check the seq_cst lowering since that's the
; interesting one from an ordering perspective on x86.

define void @store_float_seq_cst(ptr %fptr, float %v) {
; X86-LABEL: store_float_seq_cst:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    xchgl %ecx, (%eax)
; X86-NEXT:    retl
;
; X64-SSE-LABEL: store_float_seq_cst:
; X64-SSE:       # %bb.0:
; X64-SSE-NEXT:    movd %xmm0, %eax
; X64-SSE-NEXT:    xchgl %eax, (%rdi)
; X64-SSE-NEXT:    retq
;
; X64-AVX-LABEL: store_float_seq_cst:
; X64-AVX:       # %bb.0:
; X64-AVX-NEXT:    vmovd %xmm0, %eax
; X64-AVX-NEXT:    xchgl %eax, (%rdi)
; X64-AVX-NEXT:    retq
  store atomic float %v, ptr %fptr seq_cst, align 4
  ret void
}

define void @store_double_seq_cst(ptr %fptr, double %v) {
; X86-SSE1-LABEL: store_double_seq_cst:
; X86-SSE1:       # %bb.0:
; X86-SSE1-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-SSE1-NEXT:    xorps %xmm0, %xmm0
; X86-SSE1-NEXT:    movlps {{.*#+}} xmm0 = mem[0,1],xmm0[2,3]
; X86-SSE1-NEXT:    movlps %xmm0, (%eax)
; X86-SSE1-NEXT:    lock orl $0, (%esp)
; X86-SSE1-NEXT:    retl
;
; X86-SSE2-LABEL: store_double_seq_cst:
; X86-SSE2:       # %bb.0:
; X86-SSE2-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-SSE2-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; X86-SSE2-NEXT:    movlps %xmm0, (%eax)
; X86-SSE2-NEXT:    lock orl $0, (%esp)
; X86-SSE2-NEXT:    retl
;
; X86-AVX-LABEL: store_double_seq_cst:
; X86-AVX:       # %bb.0:
; X86-AVX-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-AVX-NEXT:    vmovsd {{.*#+}} xmm0 = mem[0],zero
; X86-AVX-NEXT:    vmovlps %xmm0, (%eax)
; X86-AVX-NEXT:    lock orl $0, (%esp)
; X86-AVX-NEXT:    retl
;
; X86-NOSSE-LABEL: store_double_seq_cst:
; X86-NOSSE:       # %bb.0:
; X86-NOSSE-NEXT:    subl $12, %esp
; X86-NOSSE-NEXT:    .cfi_def_cfa_offset 16
; X86-NOSSE-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NOSSE-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NOSSE-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NOSSE-NEXT:    movl %edx, {{[0-9]+}}(%esp)
; X86-NOSSE-NEXT:    movl %ecx, (%esp)
; X86-NOSSE-NEXT:    fildll (%esp)
; X86-NOSSE-NEXT:    fistpll (%eax)
; X86-NOSSE-NEXT:    lock orl $0, (%esp)
; X86-NOSSE-NEXT:    addl $12, %esp
; X86-NOSSE-NEXT:    .cfi_def_cfa_offset 4
; X86-NOSSE-NEXT:    retl
;
; X64-SSE-LABEL: store_double_seq_cst:
; X64-SSE:       # %bb.0:
; X64-SSE-NEXT:    movq %xmm0, %rax
; X64-SSE-NEXT:    xchgq %rax, (%rdi)
; X64-SSE-NEXT:    retq
;
; X64-AVX-LABEL: store_double_seq_cst:
; X64-AVX:       # %bb.0:
; X64-AVX-NEXT:    vmovq %xmm0, %rax
; X64-AVX-NEXT:    xchgq %rax, (%rdi)
; X64-AVX-NEXT:    retq
  store atomic double %v, ptr %fptr seq_cst, align 8
  ret void
}

define float @load_float_seq_cst(ptr %fptr) {
; X86-SSE1-LABEL: load_float_seq_cst:
; X86-SSE1:       # %bb.0:
; X86-SSE1-NEXT:    pushl %eax
; X86-SSE1-NEXT:    .cfi_def_cfa_offset 8
; X86-SSE1-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-SSE1-NEXT:    movl (%eax), %eax
; X86-SSE1-NEXT:    movl %eax, (%esp)
; X86-SSE1-NEXT:    flds (%esp)
; X86-SSE1-NEXT:    popl %eax
; X86-SSE1-NEXT:    .cfi_def_cfa_offset 4
; X86-SSE1-NEXT:    retl
;
; X86-SSE2-LABEL: load_float_seq_cst:
; X86-SSE2:       # %bb.0:
; X86-SSE2-NEXT:    pushl %eax
; X86-SSE2-NEXT:    .cfi_def_cfa_offset 8
; X86-SSE2-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-SSE2-NEXT:    movss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; X86-SSE2-NEXT:    movss %xmm0, (%esp)
; X86-SSE2-NEXT:    flds (%esp)
; X86-SSE2-NEXT:    popl %eax
; X86-SSE2-NEXT:    .cfi_def_cfa_offset 4
; X86-SSE2-NEXT:    retl
;
; X86-AVX-LABEL: load_float_seq_cst:
; X86-AVX:       # %bb.0:
; X86-AVX-NEXT:    pushl %eax
; X86-AVX-NEXT:    .cfi_def_cfa_offset 8
; X86-AVX-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-AVX-NEXT:    vmovss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; X86-AVX-NEXT:    vmovss %xmm0, (%esp)
; X86-AVX-NEXT:    flds (%esp)
; X86-AVX-NEXT:    popl %eax
; X86-AVX-NEXT:    .cfi_def_cfa_offset 4
; X86-AVX-NEXT:    retl
;
; X86-NOSSE-LABEL: load_float_seq_cst:
; X86-NOSSE:       # %bb.0:
; X86-NOSSE-NEXT:    pushl %eax
; X86-NOSSE-NEXT:    .cfi_def_cfa_offset 8
; X86-NOSSE-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NOSSE-NEXT:    movl (%eax), %eax
; X86-NOSSE-NEXT:    movl %eax, (%esp)
; X86-NOSSE-NEXT:    flds (%esp)
; X86-NOSSE-NEXT:    popl %eax
; X86-NOSSE-NEXT:    .cfi_def_cfa_offset 4
; X86-NOSSE-NEXT:    retl
;
; X64-SSE-LABEL: load_float_seq_cst:
; X64-SSE:       # %bb.0:
; X64-SSE-NEXT:    movss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; X64-SSE-NEXT:    retq
;
; X64-AVX-LABEL: load_float_seq_cst:
; X64-AVX:       # %bb.0:
; X64-AVX-NEXT:    vmovss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; X64-AVX-NEXT:    retq
  %v = load atomic float, ptr %fptr seq_cst, align 4
  ret float %v
}

define double @load_double_seq_cst(ptr %fptr) {
; X86-SSE1-LABEL: load_double_seq_cst:
; X86-SSE1:       # %bb.0:
; X86-SSE1-NEXT:    subl $12, %esp
; X86-SSE1-NEXT:    .cfi_def_cfa_offset 16
; X86-SSE1-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-SSE1-NEXT:    xorps %xmm0, %xmm0
; X86-SSE1-NEXT:    movlps {{.*#+}} xmm0 = mem[0,1],xmm0[2,3]
; X86-SSE1-NEXT:    movss %xmm0, (%esp)
; X86-SSE1-NEXT:    shufps {{.*#+}} xmm0 = xmm0[1,1,1,1]
; X86-SSE1-NEXT:    movss %xmm0, {{[0-9]+}}(%esp)
; X86-SSE1-NEXT:    fldl (%esp)
; X86-SSE1-NEXT:    addl $12, %esp
; X86-SSE1-NEXT:    .cfi_def_cfa_offset 4
; X86-SSE1-NEXT:    retl
;
; X86-SSE2-LABEL: load_double_seq_cst:
; X86-SSE2:       # %bb.0:
; X86-SSE2-NEXT:    subl $12, %esp
; X86-SSE2-NEXT:    .cfi_def_cfa_offset 16
; X86-SSE2-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-SSE2-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; X86-SSE2-NEXT:    movlps %xmm0, (%esp)
; X86-SSE2-NEXT:    fldl (%esp)
; X86-SSE2-NEXT:    addl $12, %esp
; X86-SSE2-NEXT:    .cfi_def_cfa_offset 4
; X86-SSE2-NEXT:    retl
;
; X86-AVX-LABEL: load_double_seq_cst:
; X86-AVX:       # %bb.0:
; X86-AVX-NEXT:    subl $12, %esp
; X86-AVX-NEXT:    .cfi_def_cfa_offset 16
; X86-AVX-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-AVX-NEXT:    vmovsd {{.*#+}} xmm0 = mem[0],zero
; X86-AVX-NEXT:    vmovlps %xmm0, (%esp)
; X86-AVX-NEXT:    fldl (%esp)
; X86-AVX-NEXT:    addl $12, %esp
; X86-AVX-NEXT:    .cfi_def_cfa_offset 4
; X86-AVX-NEXT:    retl
;
; X86-NOSSE-LABEL: load_double_seq_cst:
; X86-NOSSE:       # %bb.0:
; X86-NOSSE-NEXT:    subl $20, %esp
; X86-NOSSE-NEXT:    .cfi_def_cfa_offset 24
; X86-NOSSE-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NOSSE-NEXT:    fildll (%eax)
; X86-NOSSE-NEXT:    fistpll {{[0-9]+}}(%esp)
; X86-NOSSE-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NOSSE-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NOSSE-NEXT:    movl %ecx, {{[0-9]+}}(%esp)
; X86-NOSSE-NEXT:    movl %eax, (%esp)
; X86-NOSSE-NEXT:    fldl (%esp)
; X86-NOSSE-NEXT:    addl $20, %esp
; X86-NOSSE-NEXT:    .cfi_def_cfa_offset 4
; X86-NOSSE-NEXT:    retl
;
; X64-SSE-LABEL: load_double_seq_cst:
; X64-SSE:       # %bb.0:
; X64-SSE-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; X64-SSE-NEXT:    retq
;
; X64-AVX-LABEL: load_double_seq_cst:
; X64-AVX:       # %bb.0:
; X64-AVX-NEXT:    vmovsd {{.*#+}} xmm0 = mem[0],zero
; X64-AVX-NEXT:    retq
  %v = load atomic double, ptr %fptr seq_cst, align 8
  ret double %v
}

define void @store_bfloat(ptr %fptr, bfloat %v) {
; X86-LABEL: store_bfloat:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movzwl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movw %cx, (%eax)
; X86-NEXT:    retl
;
; X64-SSE-LABEL: store_bfloat:
; X64-SSE:       # %bb.0:
; X64-SSE-NEXT:    pextrw $0, %xmm0, %eax
; X64-SSE-NEXT:    movw %ax, (%rdi)
; X64-SSE-NEXT:    retq
;
; X64-AVX-LABEL: store_bfloat:
; X64-AVX:       # %bb.0:
; X64-AVX-NEXT:    vpextrw $0, %xmm0, %eax
; X64-AVX-NEXT:    movw %ax, (%rdi)
; X64-AVX-NEXT:    retq
  store atomic bfloat %v, ptr %fptr unordered, align 2
  ret void
}

; Work around issue #92899 by casting to float
define float @load_bfloat(ptr %fptr) {
; X86-SSE1-LABEL: load_bfloat:
; X86-SSE1:       # %bb.0:
; X86-SSE1-NEXT:    pushl %eax
; X86-SSE1-NEXT:    .cfi_def_cfa_offset 8
; X86-SSE1-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-SSE1-NEXT:    movzwl (%eax), %eax
; X86-SSE1-NEXT:    shll $16, %eax
; X86-SSE1-NEXT:    movl %eax, (%esp)
; X86-SSE1-NEXT:    flds (%esp)
; X86-SSE1-NEXT:    popl %eax
; X86-SSE1-NEXT:    .cfi_def_cfa_offset 4
; X86-SSE1-NEXT:    retl
;
; X86-SSE2-LABEL: load_bfloat:
; X86-SSE2:       # %bb.0:
; X86-SSE2-NEXT:    pushl %eax
; X86-SSE2-NEXT:    .cfi_def_cfa_offset 8
; X86-SSE2-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-SSE2-NEXT:    movzwl (%eax), %eax
; X86-SSE2-NEXT:    shll $16, %eax
; X86-SSE2-NEXT:    movd %eax, %xmm0
; X86-SSE2-NEXT:    movd %xmm0, (%esp)
; X86-SSE2-NEXT:    flds (%esp)
; X86-SSE2-NEXT:    popl %eax
; X86-SSE2-NEXT:    .cfi_def_cfa_offset 4
; X86-SSE2-NEXT:    retl
;
; X86-AVX-LABEL: load_bfloat:
; X86-AVX:       # %bb.0:
; X86-AVX-NEXT:    pushl %eax
; X86-AVX-NEXT:    .cfi_def_cfa_offset 8
; X86-AVX-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-AVX-NEXT:    movzwl (%eax), %eax
; X86-AVX-NEXT:    shll $16, %eax
; X86-AVX-NEXT:    vmovd %eax, %xmm0
; X86-AVX-NEXT:    vmovd %xmm0, (%esp)
; X86-AVX-NEXT:    flds (%esp)
; X86-AVX-NEXT:    popl %eax
; X86-AVX-NEXT:    .cfi_def_cfa_offset 4
; X86-AVX-NEXT:    retl
;
; X86-NOSSE-LABEL: load_bfloat:
; X86-NOSSE:       # %bb.0:
; X86-NOSSE-NEXT:    pushl %eax
; X86-NOSSE-NEXT:    .cfi_def_cfa_offset 8
; X86-NOSSE-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NOSSE-NEXT:    movzwl (%eax), %eax
; X86-NOSSE-NEXT:    shll $16, %eax
; X86-NOSSE-NEXT:    movl %eax, (%esp)
; X86-NOSSE-NEXT:    flds (%esp)
; X86-NOSSE-NEXT:    popl %eax
; X86-NOSSE-NEXT:    .cfi_def_cfa_offset 4
; X86-NOSSE-NEXT:    retl
;
; X64-SSE-LABEL: load_bfloat:
; X64-SSE:       # %bb.0:
; X64-SSE-NEXT:    movzwl (%rdi), %eax
; X64-SSE-NEXT:    shll $16, %eax
; X64-SSE-NEXT:    movd %eax, %xmm0
; X64-SSE-NEXT:    retq
;
; X64-AVX-LABEL: load_bfloat:
; X64-AVX:       # %bb.0:
; X64-AVX-NEXT:    movzwl (%rdi), %eax
; X64-AVX-NEXT:    shll $16, %eax
; X64-AVX-NEXT:    vmovd %eax, %xmm0
; X64-AVX-NEXT:    retq
  %v = load atomic bfloat, ptr %fptr unordered, align 2
  %ext = fpext bfloat %v to float
  ret float %ext
}
