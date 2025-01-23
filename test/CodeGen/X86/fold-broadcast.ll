; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 4
; RUN: llc -mtriple=x86_64-unknown-unknown -mattr=+avx512bf16 < %s | FileCheck %s

define <16 x float> @mm512_dpbf16_ps_broadcast_rhs(<16 x float> noundef %acc, <32 x bfloat> noundef %lhs, ptr nocapture noundef readonly %rhs) {
; CHECK-LABEL: mm512_dpbf16_ps_broadcast_rhs:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vdpbf16ps (%rdi){1to16}, %zmm1, %zmm0
; CHECK-NEXT:    retq
entry:
  %0 = load float, ptr %rhs, align 4
  %vecinit.i = insertelement <16 x float> poison, float %0, i64 0
  %vecinit15.i = shufflevector <16 x float> %vecinit.i, <16 x float> poison, <16 x i32> zeroinitializer
  %1 = bitcast <16 x float> %vecinit15.i to <32 x bfloat>
  %2 = tail call <16 x float> @llvm.x86.avx512bf16.dpbf16ps.512(<16 x float> %acc, <32 x bfloat> %lhs, <32 x bfloat> %1)
  ret <16 x float> %2
}

declare <16 x float> @llvm.x86.avx512bf16.dpbf16ps.512(<16 x float>, <32 x bfloat>, <32 x bfloat>)
