; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-unknown -mattr=+sse4.1 | FileCheck %s --check-prefix=X86
; RUN: llc < %s -mtriple=x86_64-unknown -mattr=+sse4.1 | FileCheck %s --check-prefix=X64

define void @t1(ptr %R, ptr %P1) nounwind {
; X86-LABEL: t1:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; X86-NEXT:    movss %xmm0, (%eax)
; X86-NEXT:    retl
;
; X64-LABEL: t1:
; X64:       # %bb.0:
; X64-NEXT:    movss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; X64-NEXT:    movss %xmm0, (%rdi)
; X64-NEXT:    retq
  %X = load <4 x float>, ptr %P1
  %tmp = extractelement <4 x float> %X, i32 3
  store float %tmp, ptr %R
  ret void
}

define float @t2(ptr %P1) nounwind {
; X86-LABEL: t2:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    flds 8(%eax)
; X86-NEXT:    retl
;
; X64-LABEL: t2:
; X64:       # %bb.0:
; X64-NEXT:    movss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; X64-NEXT:    retq
  %X = load <4 x float>, ptr %P1
  %tmp = extractelement <4 x float> %X, i32 2
  ret float %tmp
}

define void @t3(ptr %R, ptr %P1) nounwind {
; X86-LABEL: t3:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl 12(%ecx), %ecx
; X86-NEXT:    movl %ecx, (%eax)
; X86-NEXT:    retl
;
; X64-LABEL: t3:
; X64:       # %bb.0:
; X64-NEXT:    movl 12(%rsi), %eax
; X64-NEXT:    movl %eax, (%rdi)
; X64-NEXT:    retq
  %X = load <4 x i32>, ptr %P1
  %tmp = extractelement <4 x i32> %X, i32 3
  store i32 %tmp, ptr %R
  ret void
}

define i32 @t4(ptr %P1) nounwind {
; X86-LABEL: t4:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl 12(%eax), %eax
; X86-NEXT:    retl
;
; X64-LABEL: t4:
; X64:       # %bb.0:
; X64-NEXT:    movl 12(%rdi), %eax
; X64-NEXT:    retq
  %X = load <4 x i32>, ptr %P1
  %tmp = extractelement <4 x i32> %X, i32 3
  ret i32 %tmp
}
