; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-unknown -mattr=+avx512cd | FileCheck %s --check-prefixes=CHECK,X86
; RUN: llc < %s -mtriple=x86_64-unknown -mattr=+avx512cd | FileCheck %s --check-prefixes=CHECK,X64

declare <16 x i32> @llvm.x86.avx512.mask.conflict.d.512(<16 x i32>, <16 x i32>, i16) nounwind readonly

define <16 x i32> @test_conflict_d(<16 x i32> %a) {
; CHECK-LABEL: test_conflict_d:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vpconflictd %zmm0, %zmm0
; CHECK-NEXT:    ret{{[l|q]}}
  %res = call <16 x i32> @llvm.x86.avx512.mask.conflict.d.512(<16 x i32> %a, <16 x i32> undef, i16 -1)
  ret <16 x i32> %res
}

define <16 x i32> @test_mask_conflict_d(<16 x i32> %a, <16 x i32> %b, i16 %mask) {
; X86-LABEL: test_mask_conflict_d:
; X86:       # %bb.0:
; X86-NEXT:    kmovw {{[0-9]+}}(%esp), %k1
; X86-NEXT:    vpconflictd %zmm0, %zmm1 {%k1}
; X86-NEXT:    vmovdqa64 %zmm1, %zmm0
; X86-NEXT:    retl
;
; X64-LABEL: test_mask_conflict_d:
; X64:       # %bb.0:
; X64-NEXT:    kmovw %edi, %k1
; X64-NEXT:    vpconflictd %zmm0, %zmm1 {%k1}
; X64-NEXT:    vmovdqa64 %zmm1, %zmm0
; X64-NEXT:    retq
  %res = call <16 x i32> @llvm.x86.avx512.mask.conflict.d.512(<16 x i32> %a, <16 x i32> %b, i16 %mask)
  ret <16 x i32> %res
}

define <16 x i32> @test_maskz_conflict_d(<16 x i32> %a, i16 %mask) {
; X86-LABEL: test_maskz_conflict_d:
; X86:       # %bb.0:
; X86-NEXT:    kmovw {{[0-9]+}}(%esp), %k1
; X86-NEXT:    vpconflictd %zmm0, %zmm0 {%k1} {z}
; X86-NEXT:    retl
;
; X64-LABEL: test_maskz_conflict_d:
; X64:       # %bb.0:
; X64-NEXT:    kmovw %edi, %k1
; X64-NEXT:    vpconflictd %zmm0, %zmm0 {%k1} {z}
; X64-NEXT:    retq
  %res = call <16 x i32> @llvm.x86.avx512.mask.conflict.d.512(<16 x i32> %a, <16 x i32> zeroinitializer, i16 %mask)
  ret <16 x i32> %res
}

declare <8 x i64> @llvm.x86.avx512.mask.conflict.q.512(<8 x i64>, <8 x i64>, i8) nounwind readonly

define <8 x i64> @test_conflict_q(<8 x i64> %a) {
; CHECK-LABEL: test_conflict_q:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vpconflictq %zmm0, %zmm0
; CHECK-NEXT:    ret{{[l|q]}}
  %res = call <8 x i64> @llvm.x86.avx512.mask.conflict.q.512(<8 x i64> %a, <8 x i64> undef, i8 -1)
  ret <8 x i64> %res
}

define <8 x i64> @test_mask_conflict_q(<8 x i64> %a, <8 x i64> %b, i8 %mask) {
; X86-LABEL: test_mask_conflict_q:
; X86:       # %bb.0:
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    kmovw %eax, %k1
; X86-NEXT:    vpconflictq %zmm0, %zmm1 {%k1}
; X86-NEXT:    vmovdqa64 %zmm1, %zmm0
; X86-NEXT:    retl
;
; X64-LABEL: test_mask_conflict_q:
; X64:       # %bb.0:
; X64-NEXT:    kmovw %edi, %k1
; X64-NEXT:    vpconflictq %zmm0, %zmm1 {%k1}
; X64-NEXT:    vmovdqa64 %zmm1, %zmm0
; X64-NEXT:    retq
  %res = call <8 x i64> @llvm.x86.avx512.mask.conflict.q.512(<8 x i64> %a, <8 x i64> %b, i8 %mask)
  ret <8 x i64> %res
}

define <8 x i64> @test_maskz_conflict_q(<8 x i64> %a, i8 %mask) {
; X86-LABEL: test_maskz_conflict_q:
; X86:       # %bb.0:
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    kmovw %eax, %k1
; X86-NEXT:    vpconflictq %zmm0, %zmm0 {%k1} {z}
; X86-NEXT:    retl
;
; X64-LABEL: test_maskz_conflict_q:
; X64:       # %bb.0:
; X64-NEXT:    kmovw %edi, %k1
; X64-NEXT:    vpconflictq %zmm0, %zmm0 {%k1} {z}
; X64-NEXT:    retq
  %res = call <8 x i64> @llvm.x86.avx512.mask.conflict.q.512(<8 x i64> %a, <8 x i64> zeroinitializer, i8 %mask)
  ret <8 x i64> %res
}

define <16 x i32> @test_lzcnt_d(<16 x i32> %a) {
; CHECK-LABEL: test_lzcnt_d:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vplzcntd %zmm0, %zmm0
; CHECK-NEXT:    ret{{[l|q]}}
  %res = call <16 x i32> @llvm.x86.avx512.mask.lzcnt.d.512(<16 x i32> %a, <16 x i32> zeroinitializer, i16 -1)
  ret <16 x i32> %res
}

declare <16 x i32> @llvm.x86.avx512.mask.lzcnt.d.512(<16 x i32>, <16 x i32>, i16) nounwind readonly

define <8 x i64> @test_lzcnt_q(<8 x i64> %a) {
; CHECK-LABEL: test_lzcnt_q:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vplzcntq %zmm0, %zmm0
; CHECK-NEXT:    ret{{[l|q]}}
  %res = call <8 x i64> @llvm.x86.avx512.mask.lzcnt.q.512(<8 x i64> %a, <8 x i64> zeroinitializer, i8 -1)
  ret <8 x i64> %res
}

declare <8 x i64> @llvm.x86.avx512.mask.lzcnt.q.512(<8 x i64>, <8 x i64>, i8) nounwind readonly


define <16 x i32> @test_mask_lzcnt_d(<16 x i32> %a, <16 x i32> %b, i16 %mask) {
; X86-LABEL: test_mask_lzcnt_d:
; X86:       # %bb.0:
; X86-NEXT:    kmovw {{[0-9]+}}(%esp), %k1
; X86-NEXT:    vplzcntd %zmm0, %zmm1 {%k1}
; X86-NEXT:    vmovdqa64 %zmm1, %zmm0
; X86-NEXT:    retl
;
; X64-LABEL: test_mask_lzcnt_d:
; X64:       # %bb.0:
; X64-NEXT:    kmovw %edi, %k1
; X64-NEXT:    vplzcntd %zmm0, %zmm1 {%k1}
; X64-NEXT:    vmovdqa64 %zmm1, %zmm0
; X64-NEXT:    retq
  %res = call <16 x i32> @llvm.x86.avx512.mask.lzcnt.d.512(<16 x i32> %a, <16 x i32> %b, i16 %mask)
  ret <16 x i32> %res
}

define <8 x i64> @test_mask_lzcnt_q(<8 x i64> %a, <8 x i64> %b, i8 %mask) {
; X86-LABEL: test_mask_lzcnt_q:
; X86:       # %bb.0:
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    kmovw %eax, %k1
; X86-NEXT:    vplzcntq %zmm0, %zmm1 {%k1}
; X86-NEXT:    vmovdqa64 %zmm1, %zmm0
; X86-NEXT:    retl
;
; X64-LABEL: test_mask_lzcnt_q:
; X64:       # %bb.0:
; X64-NEXT:    kmovw %edi, %k1
; X64-NEXT:    vplzcntq %zmm0, %zmm1 {%k1}
; X64-NEXT:    vmovdqa64 %zmm1, %zmm0
; X64-NEXT:    retq
  %res = call <8 x i64> @llvm.x86.avx512.mask.lzcnt.q.512(<8 x i64> %a, <8 x i64> %b, i8 %mask)
  ret <8 x i64> %res
}

define <16 x i32> @test_x86_vbroadcastmw_512(i16 %a0) {
; X86-LABEL: test_x86_vbroadcastmw_512:
; X86:       # %bb.0:
; X86-NEXT:    movzwl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    vpbroadcastd %eax, %zmm0
; X86-NEXT:    retl
;
; X64-LABEL: test_x86_vbroadcastmw_512:
; X64:       # %bb.0:
; X64-NEXT:    movzwl %di, %eax
; X64-NEXT:    vpbroadcastd %eax, %zmm0
; X64-NEXT:    retq
  %res = call <16 x i32> @llvm.x86.avx512.broadcastmw.512(i16 %a0)
  ret <16 x i32> %res
}
declare <16 x i32> @llvm.x86.avx512.broadcastmw.512(i16)

define <8 x i64> @test_x86_broadcastmb_512(i8 %a0) {
; X86-LABEL: test_x86_broadcastmb_512:
; X86:       # %bb.0:
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    vmovd %eax, %xmm0
; X86-NEXT:    vpbroadcastq %xmm0, %zmm0
; X86-NEXT:    retl
;
; X64-LABEL: test_x86_broadcastmb_512:
; X64:       # %bb.0:
; X64-NEXT:    movzbl %dil, %eax
; X64-NEXT:    vpbroadcastq %rax, %zmm0
; X64-NEXT:    retq
  %res = call <8 x i64> @llvm.x86.avx512.broadcastmb.512(i8 %a0)
  ret <8 x i64> %res
}
declare <8 x i64> @llvm.x86.avx512.broadcastmb.512(i8)

