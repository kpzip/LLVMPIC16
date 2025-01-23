; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-- | FileCheck %s

define i64 @muladd_demand(i64 %x, i64 %y) {
; CHECK-LABEL: muladd_demand:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movq %rsi, %rax
; CHECK-NEXT:    shll $6, %edi
; CHECK-NEXT:    subl %edi, %eax
; CHECK-NEXT:    shlq $47, %rax
; CHECK-NEXT:    retq
  %m = mul i64 %x, 131008 ; 0x0001ffc0
  %a = add i64 %m, %y
  %r = shl i64 %a, 47
  ret i64 %r
}

define <2 x i64> @muladd_demand_commute(<2 x i64> %x, <2 x i64> %y) {
; CHECK-LABEL: muladd_demand_commute:
; CHECK:       # %bb.0:
; CHECK-NEXT:    psllq $6, %xmm0
; CHECK-NEXT:    psubq %xmm0, %xmm1
; CHECK-NEXT:    pand {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm1
; CHECK-NEXT:    movdqa %xmm1, %xmm0
; CHECK-NEXT:    retq
  %m = mul <2 x i64> %x, <i64 131008, i64 131008>
  %a = add <2 x i64> %y, %m
  %r = and <2 x i64> %a, <i64 131071, i64 131071>
  ret <2 x i64> %r
}
