; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+sse2 | FileCheck %s --check-prefixes=SSE,SSE2
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+sse4.1 | FileCheck %s --check-prefixes=SSE,SSE41
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx | FileCheck %s --check-prefixes=AVX,AVX1
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx2 | FileCheck %s --check-prefixes=AVX,AVX2
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512f | FileCheck %s --check-prefixes=AVX,AVX512F
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512f,+avx512vl | FileCheck %s --check-prefixes=AVX,AVX512VL
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512f,+avx512bw | FileCheck %s --check-prefixes=AVX,AVX512BW
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512f,+avx512bw,+avx512vl | FileCheck %s --check-prefixes=AVX,AVX512VLBW
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512f,+avx512vbmi,+avx512vbmi2 | FileCheck %s --check-prefixes=AVX512VBMI2
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512f,+avx512vbmi,+avx512vbmi2,+avx512vl | FileCheck %s --check-prefixes=AVX512VLVBMI2
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+xop,+avx | FileCheck %s --check-prefixes=XOP,XOPAVX1
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+xop,+avx2 | FileCheck %s --check-prefixes=XOP,XOPAVX2

; Just one 32-bit run to make sure we do reasonable things for i64 cases.
; RUN: llc < %s -mtriple=i686-unknown-unknown -mattr=+sse2 | FileCheck %s --check-prefixes=X86-SSE2

declare <2 x i32> @llvm.fshl.v2i32(<2 x i32>, <2 x i32>, <2 x i32>)

;
; Variable Shifts
;

define <2 x i32> @var_funnnel_v2i32(<2 x i32> %x, <2 x i32> %y, <2 x i32> %amt) nounwind {
; SSE2-LABEL: var_funnnel_v2i32:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movdqa {{.*#+}} xmm4 = [31,31,31,31]
; SSE2-NEXT:    movdqa %xmm2, %xmm5
; SSE2-NEXT:    pandn %xmm4, %xmm5
; SSE2-NEXT:    pshuflw {{.*#+}} xmm3 = xmm5[2,3,3,3,4,5,6,7]
; SSE2-NEXT:    psrld $1, %xmm1
; SSE2-NEXT:    movdqa %xmm1, %xmm6
; SSE2-NEXT:    psrld %xmm3, %xmm6
; SSE2-NEXT:    pshuflw {{.*#+}} xmm7 = xmm5[0,1,1,1,4,5,6,7]
; SSE2-NEXT:    movdqa %xmm1, %xmm3
; SSE2-NEXT:    psrld %xmm7, %xmm3
; SSE2-NEXT:    punpcklqdq {{.*#+}} xmm3 = xmm3[0],xmm6[0]
; SSE2-NEXT:    pshufd {{.*#+}} xmm5 = xmm5[2,3,2,3]
; SSE2-NEXT:    pshuflw {{.*#+}} xmm6 = xmm5[2,3,3,3,4,5,6,7]
; SSE2-NEXT:    movdqa %xmm1, %xmm7
; SSE2-NEXT:    psrld %xmm6, %xmm7
; SSE2-NEXT:    pshuflw {{.*#+}} xmm5 = xmm5[0,1,1,1,4,5,6,7]
; SSE2-NEXT:    psrld %xmm5, %xmm1
; SSE2-NEXT:    punpckhqdq {{.*#+}} xmm1 = xmm1[1],xmm7[1]
; SSE2-NEXT:    shufps {{.*#+}} xmm3 = xmm3[0,3],xmm1[0,3]
; SSE2-NEXT:    pand %xmm4, %xmm2
; SSE2-NEXT:    pslld $23, %xmm2
; SSE2-NEXT:    paddd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm2
; SSE2-NEXT:    cvttps2dq %xmm2, %xmm1
; SSE2-NEXT:    pshufd {{.*#+}} xmm2 = xmm0[1,1,3,3]
; SSE2-NEXT:    pmuludq %xmm1, %xmm0
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,2,2,3]
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[1,1,3,3]
; SSE2-NEXT:    pmuludq %xmm2, %xmm1
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[0,2,2,3]
; SSE2-NEXT:    punpckldq {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
; SSE2-NEXT:    por %xmm3, %xmm0
; SSE2-NEXT:    retq
;
; SSE41-LABEL: var_funnnel_v2i32:
; SSE41:       # %bb.0:
; SSE41-NEXT:    pmovsxbd {{.*#+}} xmm3 = [31,31,31,31]
; SSE41-NEXT:    movdqa %xmm2, %xmm4
; SSE41-NEXT:    pandn %xmm3, %xmm4
; SSE41-NEXT:    pshuflw {{.*#+}} xmm5 = xmm4[2,3,3,3,4,5,6,7]
; SSE41-NEXT:    psrld $1, %xmm1
; SSE41-NEXT:    movdqa %xmm1, %xmm6
; SSE41-NEXT:    psrld %xmm5, %xmm6
; SSE41-NEXT:    pshufd {{.*#+}} xmm5 = xmm4[2,3,2,3]
; SSE41-NEXT:    pshuflw {{.*#+}} xmm7 = xmm5[2,3,3,3,4,5,6,7]
; SSE41-NEXT:    movdqa %xmm1, %xmm8
; SSE41-NEXT:    psrld %xmm7, %xmm8
; SSE41-NEXT:    pblendw {{.*#+}} xmm8 = xmm6[0,1,2,3],xmm8[4,5,6,7]
; SSE41-NEXT:    pshuflw {{.*#+}} xmm4 = xmm4[0,1,1,1,4,5,6,7]
; SSE41-NEXT:    movdqa %xmm1, %xmm6
; SSE41-NEXT:    psrld %xmm4, %xmm6
; SSE41-NEXT:    pshuflw {{.*#+}} xmm4 = xmm5[0,1,1,1,4,5,6,7]
; SSE41-NEXT:    psrld %xmm4, %xmm1
; SSE41-NEXT:    pblendw {{.*#+}} xmm6 = xmm6[0,1,2,3],xmm1[4,5,6,7]
; SSE41-NEXT:    pblendw {{.*#+}} xmm6 = xmm6[0,1],xmm8[2,3],xmm6[4,5],xmm8[6,7]
; SSE41-NEXT:    pand %xmm3, %xmm2
; SSE41-NEXT:    pslld $23, %xmm2
; SSE41-NEXT:    paddd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm2
; SSE41-NEXT:    cvttps2dq %xmm2, %xmm1
; SSE41-NEXT:    pmulld %xmm1, %xmm0
; SSE41-NEXT:    por %xmm6, %xmm0
; SSE41-NEXT:    retq
;
; AVX1-LABEL: var_funnnel_v2i32:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vbroadcastss {{.*#+}} xmm3 = [31,31,31,31]
; AVX1-NEXT:    vpandn %xmm3, %xmm2, %xmm4
; AVX1-NEXT:    vpsrldq {{.*#+}} xmm5 = xmm4[12,13,14,15],zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
; AVX1-NEXT:    vpsrld $1, %xmm1, %xmm1
; AVX1-NEXT:    vpsrld %xmm5, %xmm1, %xmm5
; AVX1-NEXT:    vpsrlq $32, %xmm4, %xmm6
; AVX1-NEXT:    vpsrld %xmm6, %xmm1, %xmm6
; AVX1-NEXT:    vpblendw {{.*#+}} xmm5 = xmm6[0,1,2,3],xmm5[4,5,6,7]
; AVX1-NEXT:    vpxor %xmm6, %xmm6, %xmm6
; AVX1-NEXT:    vpunpckhdq {{.*#+}} xmm6 = xmm4[2],xmm6[2],xmm4[3],xmm6[3]
; AVX1-NEXT:    vpsrld %xmm6, %xmm1, %xmm6
; AVX1-NEXT:    vpmovzxdq {{.*#+}} xmm4 = xmm4[0],zero,xmm4[1],zero
; AVX1-NEXT:    vpsrld %xmm4, %xmm1, %xmm1
; AVX1-NEXT:    vpblendw {{.*#+}} xmm1 = xmm1[0,1,2,3],xmm6[4,5,6,7]
; AVX1-NEXT:    vpblendw {{.*#+}} xmm1 = xmm1[0,1],xmm5[2,3],xmm1[4,5],xmm5[6,7]
; AVX1-NEXT:    vpand %xmm3, %xmm2, %xmm2
; AVX1-NEXT:    vpslld $23, %xmm2, %xmm2
; AVX1-NEXT:    vpaddd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm2, %xmm2
; AVX1-NEXT:    vcvttps2dq %xmm2, %xmm2
; AVX1-NEXT:    vpmulld %xmm2, %xmm0, %xmm0
; AVX1-NEXT:    vpor %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: var_funnnel_v2i32:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpbroadcastd {{.*#+}} xmm3 = [31,31,31,31]
; AVX2-NEXT:    vpandn %xmm3, %xmm2, %xmm4
; AVX2-NEXT:    vpsrld $1, %xmm1, %xmm1
; AVX2-NEXT:    vpsrlvd %xmm4, %xmm1, %xmm1
; AVX2-NEXT:    vpand %xmm3, %xmm2, %xmm2
; AVX2-NEXT:    vpsllvd %xmm2, %xmm0, %xmm0
; AVX2-NEXT:    vpor %xmm1, %xmm0, %xmm0
; AVX2-NEXT:    retq
;
; AVX512F-LABEL: var_funnnel_v2i32:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vpbroadcastd {{.*#+}} xmm3 = [31,31,31,31]
; AVX512F-NEXT:    vpandn %xmm3, %xmm2, %xmm4
; AVX512F-NEXT:    vpsrld $1, %xmm1, %xmm1
; AVX512F-NEXT:    vpsrlvd %xmm4, %xmm1, %xmm1
; AVX512F-NEXT:    vpand %xmm3, %xmm2, %xmm2
; AVX512F-NEXT:    vpsllvd %xmm2, %xmm0, %xmm0
; AVX512F-NEXT:    vpor %xmm1, %xmm0, %xmm0
; AVX512F-NEXT:    retq
;
; AVX512VL-LABEL: var_funnnel_v2i32:
; AVX512VL:       # %bb.0:
; AVX512VL-NEXT:    vpbroadcastd {{.*#+}} xmm3 = [31,31,31,31]
; AVX512VL-NEXT:    vpandn %xmm3, %xmm2, %xmm4
; AVX512VL-NEXT:    vpsrld $1, %xmm1, %xmm1
; AVX512VL-NEXT:    vpsrlvd %xmm4, %xmm1, %xmm1
; AVX512VL-NEXT:    vpand %xmm3, %xmm2, %xmm2
; AVX512VL-NEXT:    vpsllvd %xmm2, %xmm0, %xmm0
; AVX512VL-NEXT:    vpor %xmm1, %xmm0, %xmm0
; AVX512VL-NEXT:    retq
;
; AVX512BW-LABEL: var_funnnel_v2i32:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vpbroadcastd {{.*#+}} xmm3 = [31,31,31,31]
; AVX512BW-NEXT:    vpandn %xmm3, %xmm2, %xmm4
; AVX512BW-NEXT:    vpsrld $1, %xmm1, %xmm1
; AVX512BW-NEXT:    vpsrlvd %xmm4, %xmm1, %xmm1
; AVX512BW-NEXT:    vpand %xmm3, %xmm2, %xmm2
; AVX512BW-NEXT:    vpsllvd %xmm2, %xmm0, %xmm0
; AVX512BW-NEXT:    vpor %xmm1, %xmm0, %xmm0
; AVX512BW-NEXT:    retq
;
; AVX512VLBW-LABEL: var_funnnel_v2i32:
; AVX512VLBW:       # %bb.0:
; AVX512VLBW-NEXT:    vpbroadcastd {{.*#+}} xmm3 = [31,31,31,31]
; AVX512VLBW-NEXT:    vpandn %xmm3, %xmm2, %xmm4
; AVX512VLBW-NEXT:    vpsrld $1, %xmm1, %xmm1
; AVX512VLBW-NEXT:    vpsrlvd %xmm4, %xmm1, %xmm1
; AVX512VLBW-NEXT:    vpand %xmm3, %xmm2, %xmm2
; AVX512VLBW-NEXT:    vpsllvd %xmm2, %xmm0, %xmm0
; AVX512VLBW-NEXT:    vpor %xmm1, %xmm0, %xmm0
; AVX512VLBW-NEXT:    retq
;
; AVX512VBMI2-LABEL: var_funnnel_v2i32:
; AVX512VBMI2:       # %bb.0:
; AVX512VBMI2-NEXT:    # kill: def $xmm2 killed $xmm2 def $zmm2
; AVX512VBMI2-NEXT:    # kill: def $xmm1 killed $xmm1 def $zmm1
; AVX512VBMI2-NEXT:    # kill: def $xmm0 killed $xmm0 def $zmm0
; AVX512VBMI2-NEXT:    vpshldvd %zmm2, %zmm1, %zmm0
; AVX512VBMI2-NEXT:    # kill: def $xmm0 killed $xmm0 killed $zmm0
; AVX512VBMI2-NEXT:    vzeroupper
; AVX512VBMI2-NEXT:    retq
;
; AVX512VLVBMI2-LABEL: var_funnnel_v2i32:
; AVX512VLVBMI2:       # %bb.0:
; AVX512VLVBMI2-NEXT:    vpshldvd %xmm2, %xmm1, %xmm0
; AVX512VLVBMI2-NEXT:    retq
;
; XOPAVX1-LABEL: var_funnnel_v2i32:
; XOPAVX1:       # %bb.0:
; XOPAVX1-NEXT:    vbroadcastss {{.*#+}} xmm3 = [31,31,31,31]
; XOPAVX1-NEXT:    vpand %xmm3, %xmm2, %xmm4
; XOPAVX1-NEXT:    vpshld %xmm4, %xmm0, %xmm0
; XOPAVX1-NEXT:    vpandn %xmm3, %xmm2, %xmm2
; XOPAVX1-NEXT:    vpxor %xmm3, %xmm3, %xmm3
; XOPAVX1-NEXT:    vpsubd %xmm2, %xmm3, %xmm2
; XOPAVX1-NEXT:    vpsrld $1, %xmm1, %xmm1
; XOPAVX1-NEXT:    vpshld %xmm2, %xmm1, %xmm1
; XOPAVX1-NEXT:    vpor %xmm1, %xmm0, %xmm0
; XOPAVX1-NEXT:    retq
;
; XOPAVX2-LABEL: var_funnnel_v2i32:
; XOPAVX2:       # %bb.0:
; XOPAVX2-NEXT:    vpbroadcastd {{.*#+}} xmm3 = [31,31,31,31]
; XOPAVX2-NEXT:    vpandn %xmm3, %xmm2, %xmm4
; XOPAVX2-NEXT:    vpsrld $1, %xmm1, %xmm1
; XOPAVX2-NEXT:    vpsrlvd %xmm4, %xmm1, %xmm1
; XOPAVX2-NEXT:    vpand %xmm3, %xmm2, %xmm2
; XOPAVX2-NEXT:    vpsllvd %xmm2, %xmm0, %xmm0
; XOPAVX2-NEXT:    vpor %xmm1, %xmm0, %xmm0
; XOPAVX2-NEXT:    retq
;
; X86-SSE2-LABEL: var_funnnel_v2i32:
; X86-SSE2:       # %bb.0:
; X86-SSE2-NEXT:    movdqa {{.*#+}} xmm4 = [31,31,31,31]
; X86-SSE2-NEXT:    movdqa %xmm2, %xmm5
; X86-SSE2-NEXT:    pandn %xmm4, %xmm5
; X86-SSE2-NEXT:    pshuflw {{.*#+}} xmm3 = xmm5[2,3,3,3,4,5,6,7]
; X86-SSE2-NEXT:    psrld $1, %xmm1
; X86-SSE2-NEXT:    movdqa %xmm1, %xmm6
; X86-SSE2-NEXT:    psrld %xmm3, %xmm6
; X86-SSE2-NEXT:    pshuflw {{.*#+}} xmm7 = xmm5[0,1,1,1,4,5,6,7]
; X86-SSE2-NEXT:    movdqa %xmm1, %xmm3
; X86-SSE2-NEXT:    psrld %xmm7, %xmm3
; X86-SSE2-NEXT:    punpcklqdq {{.*#+}} xmm3 = xmm3[0],xmm6[0]
; X86-SSE2-NEXT:    pshufd {{.*#+}} xmm5 = xmm5[2,3,2,3]
; X86-SSE2-NEXT:    pshuflw {{.*#+}} xmm6 = xmm5[2,3,3,3,4,5,6,7]
; X86-SSE2-NEXT:    movdqa %xmm1, %xmm7
; X86-SSE2-NEXT:    psrld %xmm6, %xmm7
; X86-SSE2-NEXT:    pshuflw {{.*#+}} xmm5 = xmm5[0,1,1,1,4,5,6,7]
; X86-SSE2-NEXT:    psrld %xmm5, %xmm1
; X86-SSE2-NEXT:    punpckhqdq {{.*#+}} xmm1 = xmm1[1],xmm7[1]
; X86-SSE2-NEXT:    shufps {{.*#+}} xmm3 = xmm3[0,3],xmm1[0,3]
; X86-SSE2-NEXT:    pand %xmm4, %xmm2
; X86-SSE2-NEXT:    pslld $23, %xmm2
; X86-SSE2-NEXT:    paddd {{\.?LCPI[0-9]+_[0-9]+}}, %xmm2
; X86-SSE2-NEXT:    cvttps2dq %xmm2, %xmm1
; X86-SSE2-NEXT:    pshufd {{.*#+}} xmm2 = xmm0[1,1,3,3]
; X86-SSE2-NEXT:    pmuludq %xmm1, %xmm0
; X86-SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,2,2,3]
; X86-SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[1,1,3,3]
; X86-SSE2-NEXT:    pmuludq %xmm2, %xmm1
; X86-SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[0,2,2,3]
; X86-SSE2-NEXT:    punpckldq {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
; X86-SSE2-NEXT:    por %xmm3, %xmm0
; X86-SSE2-NEXT:    retl
  %res = call <2 x i32> @llvm.fshl.v2i32(<2 x i32> %x, <2 x i32> %y, <2 x i32> %amt)
  ret <2 x i32> %res
}

;
; Uniform Variable Shifts
;

define <2 x i32> @splatvar_funnnel_v2i32(<2 x i32> %x, <2 x i32> %y, <2 x i32> %amt) nounwind {
; SSE-LABEL: splatvar_funnnel_v2i32:
; SSE:       # %bb.0:
; SSE-NEXT:    movdqa %xmm1, %xmm3
; SSE-NEXT:    punpckhdq {{.*#+}} xmm3 = xmm3[2],xmm0[2],xmm3[3],xmm0[3]
; SSE-NEXT:    pand {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm2
; SSE-NEXT:    psllq %xmm2, %xmm3
; SSE-NEXT:    punpckldq {{.*#+}} xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1]
; SSE-NEXT:    psllq %xmm2, %xmm1
; SSE-NEXT:    shufps {{.*#+}} xmm1 = xmm1[1,3],xmm3[1,3]
; SSE-NEXT:    movaps %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: splatvar_funnnel_v2i32:
; AVX:       # %bb.0:
; AVX-NEXT:    vpunpckhdq {{.*#+}} xmm3 = xmm1[2],xmm0[2],xmm1[3],xmm0[3]
; AVX-NEXT:    vpand {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm2, %xmm2
; AVX-NEXT:    vpsllq %xmm2, %xmm3, %xmm3
; AVX-NEXT:    vpunpckldq {{.*#+}} xmm0 = xmm1[0],xmm0[0],xmm1[1],xmm0[1]
; AVX-NEXT:    vpsllq %xmm2, %xmm0, %xmm0
; AVX-NEXT:    vshufps {{.*#+}} xmm0 = xmm0[1,3],xmm3[1,3]
; AVX-NEXT:    retq
;
; AVX512VBMI2-LABEL: splatvar_funnnel_v2i32:
; AVX512VBMI2:       # %bb.0:
; AVX512VBMI2-NEXT:    # kill: def $xmm1 killed $xmm1 def $zmm1
; AVX512VBMI2-NEXT:    # kill: def $xmm0 killed $xmm0 def $zmm0
; AVX512VBMI2-NEXT:    vpbroadcastd %xmm2, %xmm2
; AVX512VBMI2-NEXT:    vpshldvd %zmm2, %zmm1, %zmm0
; AVX512VBMI2-NEXT:    # kill: def $xmm0 killed $xmm0 killed $zmm0
; AVX512VBMI2-NEXT:    vzeroupper
; AVX512VBMI2-NEXT:    retq
;
; AVX512VLVBMI2-LABEL: splatvar_funnnel_v2i32:
; AVX512VLVBMI2:       # %bb.0:
; AVX512VLVBMI2-NEXT:    vpbroadcastd %xmm2, %xmm2
; AVX512VLVBMI2-NEXT:    vpshldvd %xmm2, %xmm1, %xmm0
; AVX512VLVBMI2-NEXT:    retq
;
; XOP-LABEL: splatvar_funnnel_v2i32:
; XOP:       # %bb.0:
; XOP-NEXT:    vpunpckhdq {{.*#+}} xmm3 = xmm1[2],xmm0[2],xmm1[3],xmm0[3]
; XOP-NEXT:    vpand {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm2, %xmm2
; XOP-NEXT:    vpsllq %xmm2, %xmm3, %xmm3
; XOP-NEXT:    vpunpckldq {{.*#+}} xmm0 = xmm1[0],xmm0[0],xmm1[1],xmm0[1]
; XOP-NEXT:    vpsllq %xmm2, %xmm0, %xmm0
; XOP-NEXT:    vshufps {{.*#+}} xmm0 = xmm0[1,3],xmm3[1,3]
; XOP-NEXT:    retq
;
; X86-SSE2-LABEL: splatvar_funnnel_v2i32:
; X86-SSE2:       # %bb.0:
; X86-SSE2-NEXT:    movdqa %xmm1, %xmm3
; X86-SSE2-NEXT:    punpckhdq {{.*#+}} xmm3 = xmm3[2],xmm0[2],xmm3[3],xmm0[3]
; X86-SSE2-NEXT:    pand {{\.?LCPI[0-9]+_[0-9]+}}, %xmm2
; X86-SSE2-NEXT:    psllq %xmm2, %xmm3
; X86-SSE2-NEXT:    punpckldq {{.*#+}} xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1]
; X86-SSE2-NEXT:    psllq %xmm2, %xmm1
; X86-SSE2-NEXT:    shufps {{.*#+}} xmm1 = xmm1[1,3],xmm3[1,3]
; X86-SSE2-NEXT:    movaps %xmm1, %xmm0
; X86-SSE2-NEXT:    retl
  %splat = shufflevector <2 x i32> %amt, <2 x i32> undef, <2 x i32> zeroinitializer
  %res = call <2 x i32> @llvm.fshl.v2i32(<2 x i32> %x, <2 x i32> %y, <2 x i32> %splat)
  ret <2 x i32> %res
}

;
; Constant Shifts
;

define <2 x i32> @constant_funnnel_v2i32(<2 x i32> %x, <2 x i32> %y) nounwind {
; SSE2-LABEL: constant_funnnel_v2i32:
; SSE2:       # %bb.0:
; SSE2-NEXT:    pshufd {{.*#+}} xmm2 = xmm1[1,1,1,1]
; SSE2-NEXT:    psrld $28, %xmm1
; SSE2-NEXT:    psrld $27, %xmm2
; SSE2-NEXT:    punpckldq {{.*#+}} xmm1 = xmm1[0],xmm2[0],xmm1[1],xmm2[1]
; SSE2-NEXT:    pshufd {{.*#+}} xmm2 = xmm0[1,1,3,3]
; SSE2-NEXT:    pmuludq {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,2,2,3]
; SSE2-NEXT:    pmuludq {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm2
; SSE2-NEXT:    pshufd {{.*#+}} xmm2 = xmm2[0,2,2,3]
; SSE2-NEXT:    punpckldq {{.*#+}} xmm0 = xmm0[0],xmm2[0],xmm0[1],xmm2[1]
; SSE2-NEXT:    por %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE41-LABEL: constant_funnnel_v2i32:
; SSE41:       # %bb.0:
; SSE41-NEXT:    movdqa %xmm1, %xmm2
; SSE41-NEXT:    psrld $27, %xmm2
; SSE41-NEXT:    psrld $28, %xmm1
; SSE41-NEXT:    pblendw {{.*#+}} xmm2 = xmm1[0,1],xmm2[2,3],xmm1[4,5],xmm2[6,7]
; SSE41-NEXT:    pmulld {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE41-NEXT:    por %xmm2, %xmm0
; SSE41-NEXT:    retq
;
; AVX1-LABEL: constant_funnnel_v2i32:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vpsrld $27, %xmm1, %xmm2
; AVX1-NEXT:    vpsrld $28, %xmm1, %xmm1
; AVX1-NEXT:    vpblendw {{.*#+}} xmm1 = xmm1[0,1],xmm2[2,3],xmm1[4,5],xmm2[6,7]
; AVX1-NEXT:    vpmulld {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; AVX1-NEXT:    vpor %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: constant_funnnel_v2i32:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpsrlvd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm1, %xmm1
; AVX2-NEXT:    vpsllvd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; AVX2-NEXT:    vpor %xmm1, %xmm0, %xmm0
; AVX2-NEXT:    retq
;
; AVX512F-LABEL: constant_funnnel_v2i32:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vpsrlvd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm1, %xmm1
; AVX512F-NEXT:    vpsllvd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; AVX512F-NEXT:    vpor %xmm1, %xmm0, %xmm0
; AVX512F-NEXT:    retq
;
; AVX512VL-LABEL: constant_funnnel_v2i32:
; AVX512VL:       # %bb.0:
; AVX512VL-NEXT:    vpsrlvd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm1, %xmm1
; AVX512VL-NEXT:    vpsllvd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; AVX512VL-NEXT:    vpor %xmm1, %xmm0, %xmm0
; AVX512VL-NEXT:    retq
;
; AVX512BW-LABEL: constant_funnnel_v2i32:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vpsrlvd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm1, %xmm1
; AVX512BW-NEXT:    vpsllvd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; AVX512BW-NEXT:    vpor %xmm1, %xmm0, %xmm0
; AVX512BW-NEXT:    retq
;
; AVX512VLBW-LABEL: constant_funnnel_v2i32:
; AVX512VLBW:       # %bb.0:
; AVX512VLBW-NEXT:    vpsrlvd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm1, %xmm1
; AVX512VLBW-NEXT:    vpsllvd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; AVX512VLBW-NEXT:    vpor %xmm1, %xmm0, %xmm0
; AVX512VLBW-NEXT:    retq
;
; AVX512VBMI2-LABEL: constant_funnnel_v2i32:
; AVX512VBMI2:       # %bb.0:
; AVX512VBMI2-NEXT:    # kill: def $xmm1 killed $xmm1 def $zmm1
; AVX512VBMI2-NEXT:    # kill: def $xmm0 killed $xmm0 def $zmm0
; AVX512VBMI2-NEXT:    vpmovsxbd {{.*#+}} xmm2 = [4,5,0,0]
; AVX512VBMI2-NEXT:    vpshldvd %zmm2, %zmm1, %zmm0
; AVX512VBMI2-NEXT:    # kill: def $xmm0 killed $xmm0 killed $zmm0
; AVX512VBMI2-NEXT:    vzeroupper
; AVX512VBMI2-NEXT:    retq
;
; AVX512VLVBMI2-LABEL: constant_funnnel_v2i32:
; AVX512VLVBMI2:       # %bb.0:
; AVX512VLVBMI2-NEXT:    vpshldvd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm1, %xmm0
; AVX512VLVBMI2-NEXT:    retq
;
; XOPAVX1-LABEL: constant_funnnel_v2i32:
; XOPAVX1:       # %bb.0:
; XOPAVX1-NEXT:    vpshld {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm1, %xmm1
; XOPAVX1-NEXT:    vpshld {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; XOPAVX1-NEXT:    vpor %xmm1, %xmm0, %xmm0
; XOPAVX1-NEXT:    retq
;
; XOPAVX2-LABEL: constant_funnnel_v2i32:
; XOPAVX2:       # %bb.0:
; XOPAVX2-NEXT:    vpsrlvd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm1, %xmm1
; XOPAVX2-NEXT:    vpsllvd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; XOPAVX2-NEXT:    vpor %xmm1, %xmm0, %xmm0
; XOPAVX2-NEXT:    retq
;
; X86-SSE2-LABEL: constant_funnnel_v2i32:
; X86-SSE2:       # %bb.0:
; X86-SSE2-NEXT:    pshufd {{.*#+}} xmm2 = xmm1[1,1,1,1]
; X86-SSE2-NEXT:    psrld $28, %xmm1
; X86-SSE2-NEXT:    psrld $27, %xmm2
; X86-SSE2-NEXT:    punpckldq {{.*#+}} xmm1 = xmm1[0],xmm2[0],xmm1[1],xmm2[1]
; X86-SSE2-NEXT:    pshufd {{.*#+}} xmm2 = xmm0[1,1,3,3]
; X86-SSE2-NEXT:    pmuludq {{\.?LCPI[0-9]+_[0-9]+}}, %xmm0
; X86-SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,2,2,3]
; X86-SSE2-NEXT:    pmuludq {{\.?LCPI[0-9]+_[0-9]+}}, %xmm2
; X86-SSE2-NEXT:    pshufd {{.*#+}} xmm2 = xmm2[0,2,2,3]
; X86-SSE2-NEXT:    punpckldq {{.*#+}} xmm0 = xmm0[0],xmm2[0],xmm0[1],xmm2[1]
; X86-SSE2-NEXT:    por %xmm1, %xmm0
; X86-SSE2-NEXT:    retl
  %res = call <2 x i32> @llvm.fshl.v2i32(<2 x i32> %x, <2 x i32> %y, <2 x i32> <i32 4, i32 5>)
  ret <2 x i32> %res
}

;
; Uniform Constant Shifts
;

define <2 x i32> @splatconstant_funnnel_v2i32(<2 x i32> %x, <2 x i32> %y) nounwind {
; SSE-LABEL: splatconstant_funnnel_v2i32:
; SSE:       # %bb.0:
; SSE-NEXT:    psrld $28, %xmm1
; SSE-NEXT:    pslld $4, %xmm0
; SSE-NEXT:    por %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: splatconstant_funnnel_v2i32:
; AVX:       # %bb.0:
; AVX-NEXT:    vpsrld $28, %xmm1, %xmm1
; AVX-NEXT:    vpslld $4, %xmm0, %xmm0
; AVX-NEXT:    vpor %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
;
; AVX512VBMI2-LABEL: splatconstant_funnnel_v2i32:
; AVX512VBMI2:       # %bb.0:
; AVX512VBMI2-NEXT:    # kill: def $xmm1 killed $xmm1 def $zmm1
; AVX512VBMI2-NEXT:    # kill: def $xmm0 killed $xmm0 def $zmm0
; AVX512VBMI2-NEXT:    vpshldd $4, %zmm1, %zmm0, %zmm0
; AVX512VBMI2-NEXT:    # kill: def $xmm0 killed $xmm0 killed $zmm0
; AVX512VBMI2-NEXT:    vzeroupper
; AVX512VBMI2-NEXT:    retq
;
; AVX512VLVBMI2-LABEL: splatconstant_funnnel_v2i32:
; AVX512VLVBMI2:       # %bb.0:
; AVX512VLVBMI2-NEXT:    vpshldd $4, %xmm1, %xmm0, %xmm0
; AVX512VLVBMI2-NEXT:    retq
;
; XOP-LABEL: splatconstant_funnnel_v2i32:
; XOP:       # %bb.0:
; XOP-NEXT:    vpsrld $28, %xmm1, %xmm1
; XOP-NEXT:    vpslld $4, %xmm0, %xmm0
; XOP-NEXT:    vpor %xmm1, %xmm0, %xmm0
; XOP-NEXT:    retq
;
; X86-SSE2-LABEL: splatconstant_funnnel_v2i32:
; X86-SSE2:       # %bb.0:
; X86-SSE2-NEXT:    psrld $28, %xmm1
; X86-SSE2-NEXT:    pslld $4, %xmm0
; X86-SSE2-NEXT:    por %xmm1, %xmm0
; X86-SSE2-NEXT:    retl
  %res = call <2 x i32> @llvm.fshl.v2i32(<2 x i32> %x, <2 x i32> %y, <2 x i32> <i32 4, i32 4>)
  ret <2 x i32> %res
}
