; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-linux -mattr=+avx      | FileCheck %s --check-prefixes=AVX1
; RUN: llc < %s -mtriple=x86_64-linux -mattr=+avx2     | FileCheck %s --check-prefixes=AVX2
; RUN: llc < %s -mtriple=x86_64-linux -mattr=+avx512vl | FileCheck %s --check-prefixes=AVX512

;
; trunc(abs(sub(sext(a),sext(b)))) -> abds(a,b)
;

define <32 x i8> @abd_ext_v32i8(<32 x i8> %a, <32 x i8> %b) nounwind {
; AVX1-LABEL: abd_ext_v32i8:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vextractf128 $1, %ymm1, %xmm2
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm3
; AVX1-NEXT:    vpminsb %xmm2, %xmm3, %xmm4
; AVX1-NEXT:    vpmaxsb %xmm2, %xmm3, %xmm2
; AVX1-NEXT:    vpsubb %xmm4, %xmm2, %xmm2
; AVX1-NEXT:    vpminsb %xmm1, %xmm0, %xmm3
; AVX1-NEXT:    vpmaxsb %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vpsubb %xmm3, %xmm0, %xmm0
; AVX1-NEXT:    vinsertf128 $1, %xmm2, %ymm0, %ymm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: abd_ext_v32i8:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpminsb %ymm1, %ymm0, %ymm2
; AVX2-NEXT:    vpmaxsb %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpsubb %ymm2, %ymm0, %ymm0
; AVX2-NEXT:    retq
;
; AVX512-LABEL: abd_ext_v32i8:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpminsb %ymm1, %ymm0, %ymm2
; AVX512-NEXT:    vpmaxsb %ymm1, %ymm0, %ymm0
; AVX512-NEXT:    vpsubb %ymm2, %ymm0, %ymm0
; AVX512-NEXT:    retq
  %aext = sext <32 x i8> %a to <32 x i64>
  %bext = sext <32 x i8> %b to <32 x i64>
  %sub = sub <32 x i64> %aext, %bext
  %abs = call <32 x i64> @llvm.abs.v32i64(<32 x i64> %sub, i1 false)
  %trunc = trunc <32 x i64> %abs to <32 x i8>
  ret <32 x i8> %trunc
}

define <32 x i8> @abd_ext_v32i8_undef(<32 x i8> %a, <32 x i8> %b) nounwind {
; AVX1-LABEL: abd_ext_v32i8_undef:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vextractf128 $1, %ymm1, %xmm2
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm3
; AVX1-NEXT:    vpminsb %xmm2, %xmm3, %xmm4
; AVX1-NEXT:    vpmaxsb %xmm2, %xmm3, %xmm2
; AVX1-NEXT:    vpsubb %xmm4, %xmm2, %xmm2
; AVX1-NEXT:    vpminsb %xmm1, %xmm0, %xmm3
; AVX1-NEXT:    vpmaxsb %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vpsubb %xmm3, %xmm0, %xmm0
; AVX1-NEXT:    vinsertf128 $1, %xmm2, %ymm0, %ymm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: abd_ext_v32i8_undef:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpminsb %ymm1, %ymm0, %ymm2
; AVX2-NEXT:    vpmaxsb %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpsubb %ymm2, %ymm0, %ymm0
; AVX2-NEXT:    retq
;
; AVX512-LABEL: abd_ext_v32i8_undef:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpminsb %ymm1, %ymm0, %ymm2
; AVX512-NEXT:    vpmaxsb %ymm1, %ymm0, %ymm0
; AVX512-NEXT:    vpsubb %ymm2, %ymm0, %ymm0
; AVX512-NEXT:    retq
  %aext = sext <32 x i8> %a to <32 x i64>
  %bext = sext <32 x i8> %b to <32 x i64>
  %sub = sub <32 x i64> %aext, %bext
  %abs = call <32 x i64> @llvm.abs.v32i64(<32 x i64> %sub, i1 true)
  %trunc = trunc <32 x i64> %abs to <32 x i8>
  ret <32 x i8> %trunc
}

define <16 x i16> @abd_ext_v16i16(<16 x i16> %a, <16 x i16> %b) nounwind {
; AVX1-LABEL: abd_ext_v16i16:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vextractf128 $1, %ymm1, %xmm2
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm3
; AVX1-NEXT:    vpminsw %xmm2, %xmm3, %xmm4
; AVX1-NEXT:    vpmaxsw %xmm2, %xmm3, %xmm2
; AVX1-NEXT:    vpsubw %xmm4, %xmm2, %xmm2
; AVX1-NEXT:    vpminsw %xmm1, %xmm0, %xmm3
; AVX1-NEXT:    vpmaxsw %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vpsubw %xmm3, %xmm0, %xmm0
; AVX1-NEXT:    vinsertf128 $1, %xmm2, %ymm0, %ymm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: abd_ext_v16i16:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpminsw %ymm1, %ymm0, %ymm2
; AVX2-NEXT:    vpmaxsw %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpsubw %ymm2, %ymm0, %ymm0
; AVX2-NEXT:    retq
;
; AVX512-LABEL: abd_ext_v16i16:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpminsw %ymm1, %ymm0, %ymm2
; AVX512-NEXT:    vpmaxsw %ymm1, %ymm0, %ymm0
; AVX512-NEXT:    vpsubw %ymm2, %ymm0, %ymm0
; AVX512-NEXT:    retq
  %aext = sext <16 x i16> %a to <16 x i64>
  %bext = sext <16 x i16> %b to <16 x i64>
  %sub = sub <16 x i64> %aext, %bext
  %abs = call <16 x i64> @llvm.abs.v16i64(<16 x i64> %sub, i1 false)
  %trunc = trunc <16 x i64> %abs to <16 x i16>
  ret <16 x i16> %trunc
}

define <16 x i16> @abd_ext_v16i16_undef(<16 x i16> %a, <16 x i16> %b) nounwind {
; AVX1-LABEL: abd_ext_v16i16_undef:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vextractf128 $1, %ymm1, %xmm2
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm3
; AVX1-NEXT:    vpminsw %xmm2, %xmm3, %xmm4
; AVX1-NEXT:    vpmaxsw %xmm2, %xmm3, %xmm2
; AVX1-NEXT:    vpsubw %xmm4, %xmm2, %xmm2
; AVX1-NEXT:    vpminsw %xmm1, %xmm0, %xmm3
; AVX1-NEXT:    vpmaxsw %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vpsubw %xmm3, %xmm0, %xmm0
; AVX1-NEXT:    vinsertf128 $1, %xmm2, %ymm0, %ymm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: abd_ext_v16i16_undef:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpminsw %ymm1, %ymm0, %ymm2
; AVX2-NEXT:    vpmaxsw %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpsubw %ymm2, %ymm0, %ymm0
; AVX2-NEXT:    retq
;
; AVX512-LABEL: abd_ext_v16i16_undef:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpminsw %ymm1, %ymm0, %ymm2
; AVX512-NEXT:    vpmaxsw %ymm1, %ymm0, %ymm0
; AVX512-NEXT:    vpsubw %ymm2, %ymm0, %ymm0
; AVX512-NEXT:    retq
  %aext = sext <16 x i16> %a to <16 x i64>
  %bext = sext <16 x i16> %b to <16 x i64>
  %sub = sub <16 x i64> %aext, %bext
  %abs = call <16 x i64> @llvm.abs.v16i64(<16 x i64> %sub, i1 true)
  %trunc = trunc <16 x i64> %abs to <16 x i16>
  ret <16 x i16> %trunc
}

define <8 x i32> @abd_ext_v8i32(<8 x i32> %a, <8 x i32> %b) nounwind {
; AVX1-LABEL: abd_ext_v8i32:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vextractf128 $1, %ymm1, %xmm2
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm3
; AVX1-NEXT:    vpminsd %xmm2, %xmm3, %xmm4
; AVX1-NEXT:    vpmaxsd %xmm2, %xmm3, %xmm2
; AVX1-NEXT:    vpsubd %xmm4, %xmm2, %xmm2
; AVX1-NEXT:    vpminsd %xmm1, %xmm0, %xmm3
; AVX1-NEXT:    vpmaxsd %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vpsubd %xmm3, %xmm0, %xmm0
; AVX1-NEXT:    vinsertf128 $1, %xmm2, %ymm0, %ymm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: abd_ext_v8i32:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpminsd %ymm1, %ymm0, %ymm2
; AVX2-NEXT:    vpmaxsd %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpsubd %ymm2, %ymm0, %ymm0
; AVX2-NEXT:    retq
;
; AVX512-LABEL: abd_ext_v8i32:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpminsd %ymm1, %ymm0, %ymm2
; AVX512-NEXT:    vpmaxsd %ymm1, %ymm0, %ymm0
; AVX512-NEXT:    vpsubd %ymm2, %ymm0, %ymm0
; AVX512-NEXT:    retq
  %aext = sext <8 x i32> %a to <8 x i64>
  %bext = sext <8 x i32> %b to <8 x i64>
  %sub = sub <8 x i64> %aext, %bext
  %abs = call <8 x i64> @llvm.abs.v8i64(<8 x i64> %sub, i1 false)
  %trunc = trunc <8 x i64> %abs to <8 x i32>
  ret <8 x i32> %trunc
}

define <8 x i32> @abd_ext_v8i32_undef(<8 x i32> %a, <8 x i32> %b) nounwind {
; AVX1-LABEL: abd_ext_v8i32_undef:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vextractf128 $1, %ymm1, %xmm2
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm3
; AVX1-NEXT:    vpminsd %xmm2, %xmm3, %xmm4
; AVX1-NEXT:    vpmaxsd %xmm2, %xmm3, %xmm2
; AVX1-NEXT:    vpsubd %xmm4, %xmm2, %xmm2
; AVX1-NEXT:    vpminsd %xmm1, %xmm0, %xmm3
; AVX1-NEXT:    vpmaxsd %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vpsubd %xmm3, %xmm0, %xmm0
; AVX1-NEXT:    vinsertf128 $1, %xmm2, %ymm0, %ymm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: abd_ext_v8i32_undef:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpminsd %ymm1, %ymm0, %ymm2
; AVX2-NEXT:    vpmaxsd %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpsubd %ymm2, %ymm0, %ymm0
; AVX2-NEXT:    retq
;
; AVX512-LABEL: abd_ext_v8i32_undef:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpminsd %ymm1, %ymm0, %ymm2
; AVX512-NEXT:    vpmaxsd %ymm1, %ymm0, %ymm0
; AVX512-NEXT:    vpsubd %ymm2, %ymm0, %ymm0
; AVX512-NEXT:    retq
  %aext = sext <8 x i32> %a to <8 x i64>
  %bext = sext <8 x i32> %b to <8 x i64>
  %sub = sub <8 x i64> %aext, %bext
  %abs = call <8 x i64> @llvm.abs.v8i64(<8 x i64> %sub, i1 true)
  %trunc = trunc <8 x i64> %abs to <8 x i32>
  ret <8 x i32> %trunc
}

define <4 x i64> @abd_ext_v4i64(<4 x i64> %a, <4 x i64> %b) nounwind {
; AVX1-LABEL: abd_ext_v4i64:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vextractf128 $1, %ymm1, %xmm2
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm3
; AVX1-NEXT:    vpcmpgtq %xmm2, %xmm3, %xmm4
; AVX1-NEXT:    vpsubq %xmm2, %xmm3, %xmm2
; AVX1-NEXT:    vpxor %xmm4, %xmm2, %xmm2
; AVX1-NEXT:    vpsubq %xmm2, %xmm4, %xmm2
; AVX1-NEXT:    vpcmpgtq %xmm1, %xmm0, %xmm3
; AVX1-NEXT:    vpsubq %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vpxor %xmm3, %xmm0, %xmm0
; AVX1-NEXT:    vpsubq %xmm0, %xmm3, %xmm0
; AVX1-NEXT:    vinsertf128 $1, %xmm2, %ymm0, %ymm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: abd_ext_v4i64:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpcmpgtq %ymm1, %ymm0, %ymm2
; AVX2-NEXT:    vpsubq %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpxor %ymm2, %ymm0, %ymm0
; AVX2-NEXT:    vpsubq %ymm0, %ymm2, %ymm0
; AVX2-NEXT:    retq
;
; AVX512-LABEL: abd_ext_v4i64:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpminsq %ymm1, %ymm0, %ymm2
; AVX512-NEXT:    vpmaxsq %ymm1, %ymm0, %ymm0
; AVX512-NEXT:    vpsubq %ymm2, %ymm0, %ymm0
; AVX512-NEXT:    retq
  %aext = sext <4 x i64> %a to <4 x i128>
  %bext = sext <4 x i64> %b to <4 x i128>
  %sub = sub <4 x i128> %aext, %bext
  %abs = call <4 x i128> @llvm.abs.v4i128(<4 x i128> %sub, i1 false)
  %trunc = trunc <4 x i128> %abs to <4 x i64>
  ret <4 x i64> %trunc
}

define <4 x i64> @abd_ext_v4i64_undef(<4 x i64> %a, <4 x i64> %b) nounwind {
; AVX1-LABEL: abd_ext_v4i64_undef:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vextractf128 $1, %ymm1, %xmm2
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm3
; AVX1-NEXT:    vpcmpgtq %xmm2, %xmm3, %xmm4
; AVX1-NEXT:    vpsubq %xmm2, %xmm3, %xmm2
; AVX1-NEXT:    vpxor %xmm4, %xmm2, %xmm2
; AVX1-NEXT:    vpsubq %xmm2, %xmm4, %xmm2
; AVX1-NEXT:    vpcmpgtq %xmm1, %xmm0, %xmm3
; AVX1-NEXT:    vpsubq %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vpxor %xmm3, %xmm0, %xmm0
; AVX1-NEXT:    vpsubq %xmm0, %xmm3, %xmm0
; AVX1-NEXT:    vinsertf128 $1, %xmm2, %ymm0, %ymm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: abd_ext_v4i64_undef:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpcmpgtq %ymm1, %ymm0, %ymm2
; AVX2-NEXT:    vpsubq %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpxor %ymm2, %ymm0, %ymm0
; AVX2-NEXT:    vpsubq %ymm0, %ymm2, %ymm0
; AVX2-NEXT:    retq
;
; AVX512-LABEL: abd_ext_v4i64_undef:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpminsq %ymm1, %ymm0, %ymm2
; AVX512-NEXT:    vpmaxsq %ymm1, %ymm0, %ymm0
; AVX512-NEXT:    vpsubq %ymm2, %ymm0, %ymm0
; AVX512-NEXT:    retq
  %aext = sext <4 x i64> %a to <4 x i128>
  %bext = sext <4 x i64> %b to <4 x i128>
  %sub = sub <4 x i128> %aext, %bext
  %abs = call <4 x i128> @llvm.abs.v4i128(<4 x i128> %sub, i1 true)
  %trunc = trunc <4 x i128> %abs to <4 x i64>
  ret <4 x i64> %trunc
}

;
; sub(smax(a,b),smin(a,b)) -> abds(a,b)
;

define <32 x i8> @abd_minmax_v32i8(<32 x i8> %a, <32 x i8> %b) nounwind {
; AVX1-LABEL: abd_minmax_v32i8:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vextractf128 $1, %ymm1, %xmm2
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm3
; AVX1-NEXT:    vpminsb %xmm2, %xmm3, %xmm4
; AVX1-NEXT:    vpmaxsb %xmm2, %xmm3, %xmm2
; AVX1-NEXT:    vpsubb %xmm4, %xmm2, %xmm2
; AVX1-NEXT:    vpminsb %xmm1, %xmm0, %xmm3
; AVX1-NEXT:    vpmaxsb %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vpsubb %xmm3, %xmm0, %xmm0
; AVX1-NEXT:    vinsertf128 $1, %xmm2, %ymm0, %ymm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: abd_minmax_v32i8:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpminsb %ymm1, %ymm0, %ymm2
; AVX2-NEXT:    vpmaxsb %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpsubb %ymm2, %ymm0, %ymm0
; AVX2-NEXT:    retq
;
; AVX512-LABEL: abd_minmax_v32i8:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpminsb %ymm1, %ymm0, %ymm2
; AVX512-NEXT:    vpmaxsb %ymm1, %ymm0, %ymm0
; AVX512-NEXT:    vpsubb %ymm2, %ymm0, %ymm0
; AVX512-NEXT:    retq
  %min = call <32 x i8> @llvm.smin.v32i8(<32 x i8> %a, <32 x i8> %b)
  %max = call <32 x i8> @llvm.smax.v32i8(<32 x i8> %a, <32 x i8> %b)
  %sub = sub <32 x i8> %max, %min
  ret <32 x i8> %sub
}

define <16 x i16> @abd_minmax_v16i16(<16 x i16> %a, <16 x i16> %b) nounwind {
; AVX1-LABEL: abd_minmax_v16i16:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vextractf128 $1, %ymm1, %xmm2
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm3
; AVX1-NEXT:    vpminsw %xmm2, %xmm3, %xmm4
; AVX1-NEXT:    vpmaxsw %xmm2, %xmm3, %xmm2
; AVX1-NEXT:    vpsubw %xmm4, %xmm2, %xmm2
; AVX1-NEXT:    vpminsw %xmm1, %xmm0, %xmm3
; AVX1-NEXT:    vpmaxsw %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vpsubw %xmm3, %xmm0, %xmm0
; AVX1-NEXT:    vinsertf128 $1, %xmm2, %ymm0, %ymm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: abd_minmax_v16i16:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpminsw %ymm1, %ymm0, %ymm2
; AVX2-NEXT:    vpmaxsw %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpsubw %ymm2, %ymm0, %ymm0
; AVX2-NEXT:    retq
;
; AVX512-LABEL: abd_minmax_v16i16:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpminsw %ymm1, %ymm0, %ymm2
; AVX512-NEXT:    vpmaxsw %ymm1, %ymm0, %ymm0
; AVX512-NEXT:    vpsubw %ymm2, %ymm0, %ymm0
; AVX512-NEXT:    retq
  %min = call <16 x i16> @llvm.smin.v16i16(<16 x i16> %a, <16 x i16> %b)
  %max = call <16 x i16> @llvm.smax.v16i16(<16 x i16> %a, <16 x i16> %b)
  %sub = sub <16 x i16> %max, %min
  ret <16 x i16> %sub
}

define <8 x i32> @abd_minmax_v8i32(<8 x i32> %a, <8 x i32> %b) nounwind {
; AVX1-LABEL: abd_minmax_v8i32:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vextractf128 $1, %ymm1, %xmm2
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm3
; AVX1-NEXT:    vpminsd %xmm2, %xmm3, %xmm4
; AVX1-NEXT:    vpmaxsd %xmm2, %xmm3, %xmm2
; AVX1-NEXT:    vpsubd %xmm4, %xmm2, %xmm2
; AVX1-NEXT:    vpminsd %xmm1, %xmm0, %xmm3
; AVX1-NEXT:    vpmaxsd %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vpsubd %xmm3, %xmm0, %xmm0
; AVX1-NEXT:    vinsertf128 $1, %xmm2, %ymm0, %ymm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: abd_minmax_v8i32:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpminsd %ymm1, %ymm0, %ymm2
; AVX2-NEXT:    vpmaxsd %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpsubd %ymm2, %ymm0, %ymm0
; AVX2-NEXT:    retq
;
; AVX512-LABEL: abd_minmax_v8i32:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpminsd %ymm1, %ymm0, %ymm2
; AVX512-NEXT:    vpmaxsd %ymm1, %ymm0, %ymm0
; AVX512-NEXT:    vpsubd %ymm2, %ymm0, %ymm0
; AVX512-NEXT:    retq
  %min = call <8 x i32> @llvm.smin.v8i32(<8 x i32> %a, <8 x i32> %b)
  %max = call <8 x i32> @llvm.smax.v8i32(<8 x i32> %a, <8 x i32> %b)
  %sub = sub <8 x i32> %max, %min
  ret <8 x i32> %sub
}

define <4 x i64> @abd_minmax_v4i64(<4 x i64> %a, <4 x i64> %b) nounwind {
; AVX1-LABEL: abd_minmax_v4i64:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vextractf128 $1, %ymm1, %xmm2
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm3
; AVX1-NEXT:    vpcmpgtq %xmm2, %xmm3, %xmm4
; AVX1-NEXT:    vpsubq %xmm2, %xmm3, %xmm2
; AVX1-NEXT:    vpxor %xmm4, %xmm2, %xmm2
; AVX1-NEXT:    vpsubq %xmm2, %xmm4, %xmm2
; AVX1-NEXT:    vpcmpgtq %xmm1, %xmm0, %xmm3
; AVX1-NEXT:    vpsubq %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vpxor %xmm3, %xmm0, %xmm0
; AVX1-NEXT:    vpsubq %xmm0, %xmm3, %xmm0
; AVX1-NEXT:    vinsertf128 $1, %xmm2, %ymm0, %ymm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: abd_minmax_v4i64:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpcmpgtq %ymm1, %ymm0, %ymm2
; AVX2-NEXT:    vpsubq %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpxor %ymm2, %ymm0, %ymm0
; AVX2-NEXT:    vpsubq %ymm0, %ymm2, %ymm0
; AVX2-NEXT:    retq
;
; AVX512-LABEL: abd_minmax_v4i64:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpminsq %ymm1, %ymm0, %ymm2
; AVX512-NEXT:    vpmaxsq %ymm1, %ymm0, %ymm0
; AVX512-NEXT:    vpsubq %ymm2, %ymm0, %ymm0
; AVX512-NEXT:    retq
  %min = call <4 x i64> @llvm.smin.v4i64(<4 x i64> %a, <4 x i64> %b)
  %max = call <4 x i64> @llvm.smax.v4i64(<4 x i64> %a, <4 x i64> %b)
  %sub = sub <4 x i64> %max, %min
  ret <4 x i64> %sub
}

;
; select(icmp(a,b),sub(a,b),sub(b,a)) -> abds(a,b)
;

define <32 x i8> @abd_cmp_v32i8(<32 x i8> %a, <32 x i8> %b) nounwind {
; AVX1-LABEL: abd_cmp_v32i8:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vextractf128 $1, %ymm1, %xmm2
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm3
; AVX1-NEXT:    vpminsb %xmm2, %xmm3, %xmm4
; AVX1-NEXT:    vpmaxsb %xmm2, %xmm3, %xmm2
; AVX1-NEXT:    vpsubb %xmm4, %xmm2, %xmm2
; AVX1-NEXT:    vpminsb %xmm1, %xmm0, %xmm3
; AVX1-NEXT:    vpmaxsb %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vpsubb %xmm3, %xmm0, %xmm0
; AVX1-NEXT:    vinsertf128 $1, %xmm2, %ymm0, %ymm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: abd_cmp_v32i8:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpminsb %ymm1, %ymm0, %ymm2
; AVX2-NEXT:    vpmaxsb %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpsubb %ymm2, %ymm0, %ymm0
; AVX2-NEXT:    retq
;
; AVX512-LABEL: abd_cmp_v32i8:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpminsb %ymm1, %ymm0, %ymm2
; AVX512-NEXT:    vpmaxsb %ymm1, %ymm0, %ymm0
; AVX512-NEXT:    vpsubb %ymm2, %ymm0, %ymm0
; AVX512-NEXT:    retq
  %cmp = icmp sgt <32 x i8> %a, %b
  %ab = sub <32 x i8> %a, %b
  %ba = sub <32 x i8> %b, %a
  %sel = select <32 x i1> %cmp, <32 x i8> %ab, <32 x i8> %ba
  ret <32 x i8> %sel
}

define <16 x i16> @abd_cmp_v16i16(<16 x i16> %a, <16 x i16> %b) nounwind {
; AVX1-LABEL: abd_cmp_v16i16:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vextractf128 $1, %ymm1, %xmm2
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm3
; AVX1-NEXT:    vpminsw %xmm2, %xmm3, %xmm4
; AVX1-NEXT:    vpmaxsw %xmm2, %xmm3, %xmm2
; AVX1-NEXT:    vpsubw %xmm4, %xmm2, %xmm2
; AVX1-NEXT:    vpminsw %xmm1, %xmm0, %xmm3
; AVX1-NEXT:    vpmaxsw %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vpsubw %xmm3, %xmm0, %xmm0
; AVX1-NEXT:    vinsertf128 $1, %xmm2, %ymm0, %ymm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: abd_cmp_v16i16:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpminsw %ymm1, %ymm0, %ymm2
; AVX2-NEXT:    vpmaxsw %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpsubw %ymm2, %ymm0, %ymm0
; AVX2-NEXT:    retq
;
; AVX512-LABEL: abd_cmp_v16i16:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpminsw %ymm1, %ymm0, %ymm2
; AVX512-NEXT:    vpmaxsw %ymm1, %ymm0, %ymm0
; AVX512-NEXT:    vpsubw %ymm2, %ymm0, %ymm0
; AVX512-NEXT:    retq
  %cmp = icmp sge <16 x i16> %a, %b
  %ab = sub <16 x i16> %a, %b
  %ba = sub <16 x i16> %b, %a
  %sel = select <16 x i1> %cmp, <16 x i16> %ab, <16 x i16> %ba
  ret <16 x i16> %sel
}

define <8 x i32> @abd_cmp_v8i32(<8 x i32> %a, <8 x i32> %b) nounwind {
; AVX1-LABEL: abd_cmp_v8i32:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vextractf128 $1, %ymm1, %xmm2
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm3
; AVX1-NEXT:    vpminsd %xmm2, %xmm3, %xmm4
; AVX1-NEXT:    vpmaxsd %xmm2, %xmm3, %xmm2
; AVX1-NEXT:    vpsubd %xmm4, %xmm2, %xmm2
; AVX1-NEXT:    vpminsd %xmm1, %xmm0, %xmm3
; AVX1-NEXT:    vpmaxsd %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vpsubd %xmm3, %xmm0, %xmm0
; AVX1-NEXT:    vinsertf128 $1, %xmm2, %ymm0, %ymm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: abd_cmp_v8i32:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpminsd %ymm1, %ymm0, %ymm2
; AVX2-NEXT:    vpmaxsd %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpsubd %ymm2, %ymm0, %ymm0
; AVX2-NEXT:    retq
;
; AVX512-LABEL: abd_cmp_v8i32:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpminsd %ymm1, %ymm0, %ymm2
; AVX512-NEXT:    vpmaxsd %ymm1, %ymm0, %ymm0
; AVX512-NEXT:    vpsubd %ymm2, %ymm0, %ymm0
; AVX512-NEXT:    retq
  %cmp = icmp slt <8 x i32> %a, %b
  %ab = sub <8 x i32> %a, %b
  %ba = sub <8 x i32> %b, %a
  %sel = select <8 x i1> %cmp, <8 x i32> %ba, <8 x i32> %ab
  ret <8 x i32> %sel
}

define <4 x i64> @abd_cmp_v4i64(<4 x i64> %a, <4 x i64> %b) nounwind {
; AVX1-LABEL: abd_cmp_v4i64:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vextractf128 $1, %ymm1, %xmm2
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm3
; AVX1-NEXT:    vpcmpgtq %xmm2, %xmm3, %xmm4
; AVX1-NEXT:    vpsubq %xmm2, %xmm3, %xmm2
; AVX1-NEXT:    vpxor %xmm4, %xmm2, %xmm2
; AVX1-NEXT:    vpsubq %xmm2, %xmm4, %xmm2
; AVX1-NEXT:    vpcmpgtq %xmm1, %xmm0, %xmm3
; AVX1-NEXT:    vpsubq %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vpxor %xmm3, %xmm0, %xmm0
; AVX1-NEXT:    vpsubq %xmm0, %xmm3, %xmm0
; AVX1-NEXT:    vinsertf128 $1, %xmm2, %ymm0, %ymm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: abd_cmp_v4i64:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpcmpgtq %ymm1, %ymm0, %ymm2
; AVX2-NEXT:    vpsubq %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpxor %ymm2, %ymm0, %ymm0
; AVX2-NEXT:    vpsubq %ymm0, %ymm2, %ymm0
; AVX2-NEXT:    retq
;
; AVX512-LABEL: abd_cmp_v4i64:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpminsq %ymm1, %ymm0, %ymm2
; AVX512-NEXT:    vpmaxsq %ymm1, %ymm0, %ymm0
; AVX512-NEXT:    vpsubq %ymm2, %ymm0, %ymm0
; AVX512-NEXT:    retq
  %cmp = icmp sge <4 x i64> %a, %b
  %ab = sub <4 x i64> %a, %b
  %ba = sub <4 x i64> %b, %a
  %sel = select <4 x i1> %cmp, <4 x i64> %ab, <4 x i64> %ba
  ret <4 x i64> %sel
}

;
; abs(sub_nsw(x, y)) -> abds(a,b)
;

define <32 x i8> @abd_subnsw_v32i8(<32 x i8> %a, <32 x i8> %b) nounwind {
; AVX1-LABEL: abd_subnsw_v32i8:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vextractf128 $1, %ymm1, %xmm2
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm3
; AVX1-NEXT:    vpsubb %xmm2, %xmm3, %xmm2
; AVX1-NEXT:    vpsubb %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vpabsb %xmm0, %xmm0
; AVX1-NEXT:    vpabsb %xmm2, %xmm1
; AVX1-NEXT:    vinsertf128 $1, %xmm1, %ymm0, %ymm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: abd_subnsw_v32i8:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpsubb %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpabsb %ymm0, %ymm0
; AVX2-NEXT:    retq
;
; AVX512-LABEL: abd_subnsw_v32i8:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpsubb %ymm1, %ymm0, %ymm0
; AVX512-NEXT:    vpabsb %ymm0, %ymm0
; AVX512-NEXT:    retq
  %sub = sub nsw <32 x i8> %a, %b
  %abs = call <32 x i8> @llvm.abs.v32i8(<32 x i8> %sub, i1 false)
  ret <32 x i8> %abs
}

define <16 x i16> @abd_subnsw_v16i16(<16 x i16> %a, <16 x i16> %b) nounwind {
; AVX1-LABEL: abd_subnsw_v16i16:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vextractf128 $1, %ymm1, %xmm2
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm3
; AVX1-NEXT:    vpsubw %xmm2, %xmm3, %xmm2
; AVX1-NEXT:    vpsubw %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vpabsw %xmm0, %xmm0
; AVX1-NEXT:    vpabsw %xmm2, %xmm1
; AVX1-NEXT:    vinsertf128 $1, %xmm1, %ymm0, %ymm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: abd_subnsw_v16i16:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpsubw %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpabsw %ymm0, %ymm0
; AVX2-NEXT:    retq
;
; AVX512-LABEL: abd_subnsw_v16i16:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpsubw %ymm1, %ymm0, %ymm0
; AVX512-NEXT:    vpabsw %ymm0, %ymm0
; AVX512-NEXT:    retq
  %sub = sub nsw <16 x i16> %a, %b
  %abs = call <16 x i16> @llvm.abs.v16i16(<16 x i16> %sub, i1 false)
  ret <16 x i16> %abs
}

define <8 x i32> @abd_subnsw_v8i32(<8 x i32> %a, <8 x i32> %b) nounwind {
; AVX1-LABEL: abd_subnsw_v8i32:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vextractf128 $1, %ymm1, %xmm2
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm3
; AVX1-NEXT:    vpsubd %xmm2, %xmm3, %xmm2
; AVX1-NEXT:    vpsubd %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vpabsd %xmm0, %xmm0
; AVX1-NEXT:    vpabsd %xmm2, %xmm1
; AVX1-NEXT:    vinsertf128 $1, %xmm1, %ymm0, %ymm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: abd_subnsw_v8i32:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpsubd %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpabsd %ymm0, %ymm0
; AVX2-NEXT:    retq
;
; AVX512-LABEL: abd_subnsw_v8i32:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpsubd %ymm1, %ymm0, %ymm0
; AVX512-NEXT:    vpabsd %ymm0, %ymm0
; AVX512-NEXT:    retq
  %sub = sub nsw <8 x i32> %a, %b
  %abs = call <8 x i32> @llvm.abs.v8i32(<8 x i32> %sub, i1 false)
  ret <8 x i32> %abs
}

define <4 x i64> @abd_subnsw_v4i64(<4 x i64> %a, <4 x i64> %b) nounwind {
; AVX1-LABEL: abd_subnsw_v4i64:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vextractf128 $1, %ymm1, %xmm2
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm3
; AVX1-NEXT:    vpsubq %xmm2, %xmm3, %xmm2
; AVX1-NEXT:    vpsubq %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vinsertf128 $1, %xmm2, %ymm0, %ymm1
; AVX1-NEXT:    vpxor %xmm3, %xmm3, %xmm3
; AVX1-NEXT:    vpsubq %xmm2, %xmm3, %xmm2
; AVX1-NEXT:    vpsubq %xmm0, %xmm3, %xmm0
; AVX1-NEXT:    vinsertf128 $1, %xmm2, %ymm0, %ymm0
; AVX1-NEXT:    vblendvpd %ymm1, %ymm0, %ymm1, %ymm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: abd_subnsw_v4i64:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpsubq %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpxor %xmm1, %xmm1, %xmm1
; AVX2-NEXT:    vpsubq %ymm0, %ymm1, %ymm1
; AVX2-NEXT:    vblendvpd %ymm0, %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    retq
;
; AVX512-LABEL: abd_subnsw_v4i64:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpsubq %ymm1, %ymm0, %ymm0
; AVX512-NEXT:    vpabsq %ymm0, %ymm0
; AVX512-NEXT:    retq
  %sub = sub nsw <4 x i64> %a, %b
  %abs = call <4 x i64> @llvm.abs.v4i64(<4 x i64> %sub, i1 false)
  ret <4 x i64> %abs
}

declare <32 x i8> @llvm.abs.v32i8(<32 x i8>, i1)
declare <16 x i16> @llvm.abs.v16i16(<16 x i16>, i1)
declare <8 x i32> @llvm.abs.v8i32(<8 x i32>, i1)
declare <4 x i64> @llvm.abs.v4i64(<4 x i64>, i1)
declare <8 x i64> @llvm.abs.v8i64(<8 x i64>, i1)
declare <16 x i64> @llvm.abs.v16i64(<16 x i64>, i1)
declare <32 x i64> @llvm.abs.v32i64(<32 x i64>, i1)
declare <4 x i128> @llvm.abs.v4i128(<4 x i128>, i1)

declare <32 x i8> @llvm.smax.v32i8(<32 x i8>, <32 x i8>)
declare <16 x i16> @llvm.smax.v16i16(<16 x i16>, <16 x i16>)
declare <8 x i32> @llvm.smax.v8i32(<8 x i32>, <8 x i32>)
declare <4 x i64> @llvm.smax.v4i64(<4 x i64>, <4 x i64>)

declare <32 x i8> @llvm.smin.v32i8(<32 x i8>, <32 x i8>)
declare <16 x i16> @llvm.smin.v16i16(<16 x i16>, <16 x i16>)
declare <8 x i32> @llvm.smin.v8i32(<8 x i32>, <8 x i32>)
declare <4 x i64> @llvm.smin.v4i64(<4 x i64>, <4 x i64>)
