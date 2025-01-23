; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc < %s -mtriple=x86_64-- -mcpu=skylake-avx512 | FileCheck %s

define void @PR95278(ptr %p0, ptr %p1) {
; CHECK-LABEL: PR95278:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vcvtph2ps 2016(%rdi), %zmm0
; CHECK-NEXT:    vextractf32x4 $3, %zmm0, %xmm0
; CHECK-NEXT:    vshufpd {{.*#+}} xmm0 = xmm0[1,0]
; CHECK-NEXT:    vcvtps2ph $4, %xmm0, %xmm0
; CHECK-NEXT:    vmovd %xmm0, %eax
; CHECK-NEXT:    movw %ax, (%rsi)
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    retq
  %load = load <1024 x half>, ptr %p0, align 2
  %ext = fpext <1024 x half> %load to <1024 x float>
  %shuffle = shufflevector <1024 x float> %ext, <1024 x float> poison, <1 x i32> <i32 1022>
  %elt = extractelement <1 x float> %shuffle, i64 0
  %trunc = fptrunc float %elt to half
  store half %trunc, ptr %p1, align 2
  ret void
}
