; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-- -mattr=avx | FileCheck %s

; PR38527 - https://bugs.llvm.org/show_bug.cgi?id=38527

; Use an AVX target to show that the potential problem
; is not limited to 128-bit types/registers. Ie, widening
; up to 256-bits may also result in bogus libcalls.

; Use fsin as the representative test for various data types.

declare <1 x float> @llvm.sin.v1f32(<1 x float>)
declare <2 x float> @llvm.sin.v2f32(<2 x float>)
declare <3 x float> @llvm.sin.v3f32(<3 x float>)
declare <4 x float> @llvm.sin.v4f32(<4 x float>)
declare <5 x float> @llvm.sin.v5f32(<5 x float>)
declare <6 x float> @llvm.sin.v6f32(<6 x float>)
declare <3 x double> @llvm.sin.v3f64(<3 x double>)

declare <1 x float> @llvm.tan.v1f32(<1 x float>)
declare <2 x float> @llvm.tan.v2f32(<2 x float>)
declare <3 x float> @llvm.tan.v3f32(<3 x float>)
declare <4 x float> @llvm.tan.v4f32(<4 x float>)
declare <5 x float> @llvm.tan.v5f32(<5 x float>)
declare <6 x float> @llvm.tan.v6f32(<6 x float>)
declare <3 x double> @llvm.tan.v3f64(<3 x double>)

; Verify that all of the potential libcall candidates are handled.
; Some of these have custom lowering, so those cases won't have
; libcalls.

declare <2 x float> @llvm.fabs.v2f32(<2 x float>)
declare <2 x float> @llvm.ceil.v2f32(<2 x float>)
declare <2 x float> @llvm.cos.v2f32(<2 x float>)
declare <2 x float> @llvm.exp.v2f32(<2 x float>)
declare <2 x float> @llvm.exp2.v2f32(<2 x float>)
declare <2 x float> @llvm.floor.v2f32(<2 x float>)
declare <2 x float> @llvm.log.v2f32(<2 x float>)
declare <2 x float> @llvm.log10.v2f32(<2 x float>)
declare <2 x float> @llvm.log2.v2f32(<2 x float>)
declare <2 x float> @llvm.nearbyint.v2f32(<2 x float>)
declare <2 x float> @llvm.rint.v2f32(<2 x float>)
declare <2 x float> @llvm.round.v2f32(<2 x float>)
declare <2 x float> @llvm.sqrt.v2f32(<2 x float>)
declare <2 x float> @llvm.trunc.v2f32(<2 x float>)

define <1 x float> @sin_v1f32(<1 x float> %x) nounwind {
; CHECK-LABEL: sin_v1f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushq %rax
; CHECK-NEXT:    callq sinf@PLT
; CHECK-NEXT:    popq %rax
; CHECK-NEXT:    retq
  %r = call <1 x float> @llvm.sin.v1f32(<1 x float> %x)
  ret <1 x float> %r
}

define <2 x float> @sin_v2f32(<2 x float> %x) nounwind {
; CHECK-LABEL: sin_v2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subq $40, %rsp
; CHECK-NEXT:    vmovaps %xmm0, (%rsp) # 16-byte Spill
; CHECK-NEXT:    callq sinf@PLT
; CHECK-NEXT:    vmovaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    vmovshdup (%rsp), %xmm0 # 16-byte Folded Reload
; CHECK-NEXT:    # xmm0 = mem[1,1,3,3]
; CHECK-NEXT:    callq sinf@PLT
; CHECK-NEXT:    vmovaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; CHECK-NEXT:    vinsertps {{.*#+}} xmm0 = xmm1[0],xmm0[0],xmm1[2,3]
; CHECK-NEXT:    addq $40, %rsp
; CHECK-NEXT:    retq
  %r = call <2 x float> @llvm.sin.v2f32(<2 x float> %x)
  ret <2 x float> %r
}

define <3 x float> @sin_v3f32(<3 x float> %x) nounwind {
; CHECK-LABEL: sin_v3f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subq $40, %rsp
; CHECK-NEXT:    vmovaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    callq sinf@PLT
; CHECK-NEXT:    vmovaps %xmm0, (%rsp) # 16-byte Spill
; CHECK-NEXT:    vmovshdup {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Folded Reload
; CHECK-NEXT:    # xmm0 = mem[1,1,3,3]
; CHECK-NEXT:    callq sinf@PLT
; CHECK-NEXT:    vmovaps (%rsp), %xmm1 # 16-byte Reload
; CHECK-NEXT:    vinsertps {{.*#+}} xmm0 = xmm1[0],xmm0[0],xmm1[2,3]
; CHECK-NEXT:    vmovaps %xmm0, (%rsp) # 16-byte Spill
; CHECK-NEXT:    vpermilpd $1, {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Folded Reload
; CHECK-NEXT:    # xmm0 = mem[1,0]
; CHECK-NEXT:    callq sinf@PLT
; CHECK-NEXT:    vmovaps (%rsp), %xmm1 # 16-byte Reload
; CHECK-NEXT:    vinsertps {{.*#+}} xmm0 = xmm1[0,1],xmm0[0],xmm1[3]
; CHECK-NEXT:    addq $40, %rsp
; CHECK-NEXT:    retq
  %r = call <3 x float> @llvm.sin.v3f32(<3 x float> %x)
  ret <3 x float> %r
}

define <4 x float> @sin_v4f32(<4 x float> %x) nounwind {
; CHECK-LABEL: sin_v4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subq $40, %rsp
; CHECK-NEXT:    vmovaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    callq sinf@PLT
; CHECK-NEXT:    vmovaps %xmm0, (%rsp) # 16-byte Spill
; CHECK-NEXT:    vmovshdup {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Folded Reload
; CHECK-NEXT:    # xmm0 = mem[1,1,3,3]
; CHECK-NEXT:    callq sinf@PLT
; CHECK-NEXT:    vmovaps (%rsp), %xmm1 # 16-byte Reload
; CHECK-NEXT:    vinsertps {{.*#+}} xmm0 = xmm1[0],xmm0[0],xmm1[2,3]
; CHECK-NEXT:    vmovaps %xmm0, (%rsp) # 16-byte Spill
; CHECK-NEXT:    vpermilpd $1, {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Folded Reload
; CHECK-NEXT:    # xmm0 = mem[1,0]
; CHECK-NEXT:    callq sinf@PLT
; CHECK-NEXT:    vmovaps (%rsp), %xmm1 # 16-byte Reload
; CHECK-NEXT:    vinsertps {{.*#+}} xmm0 = xmm1[0,1],xmm0[0],xmm1[3]
; CHECK-NEXT:    vmovaps %xmm0, (%rsp) # 16-byte Spill
; CHECK-NEXT:    vpermilps $255, {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Folded Reload
; CHECK-NEXT:    # xmm0 = mem[3,3,3,3]
; CHECK-NEXT:    callq sinf@PLT
; CHECK-NEXT:    vmovaps (%rsp), %xmm1 # 16-byte Reload
; CHECK-NEXT:    vinsertps {{.*#+}} xmm0 = xmm1[0,1,2],xmm0[0]
; CHECK-NEXT:    addq $40, %rsp
; CHECK-NEXT:    retq
  %r = call <4 x float> @llvm.sin.v4f32(<4 x float> %x)
  ret <4 x float> %r
}

define <5 x float> @sin_v5f32(<5 x float> %x) nounwind {
; CHECK-LABEL: sin_v5f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subq $72, %rsp
; CHECK-NEXT:    vmovups %ymm0, {{[-0-9]+}}(%r{{[sb]}}p) # 32-byte Spill
; CHECK-NEXT:    # kill: def $xmm0 killed $xmm0 killed $ymm0
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    callq sinf@PLT
; CHECK-NEXT:    vmovaps %xmm0, (%rsp) # 16-byte Spill
; CHECK-NEXT:    vmovshdup {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Folded Reload
; CHECK-NEXT:    # xmm0 = mem[1,1,3,3]
; CHECK-NEXT:    callq sinf@PLT
; CHECK-NEXT:    vmovaps (%rsp), %xmm1 # 16-byte Reload
; CHECK-NEXT:    vinsertps {{.*#+}} xmm0 = xmm1[0],xmm0[0],xmm1[2,3]
; CHECK-NEXT:    vmovaps %xmm0, (%rsp) # 16-byte Spill
; CHECK-NEXT:    vpermilpd $1, {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Folded Reload
; CHECK-NEXT:    # xmm0 = mem[1,0]
; CHECK-NEXT:    callq sinf@PLT
; CHECK-NEXT:    vmovaps (%rsp), %xmm1 # 16-byte Reload
; CHECK-NEXT:    vinsertps {{.*#+}} xmm0 = xmm1[0,1],xmm0[0],xmm1[3]
; CHECK-NEXT:    vmovaps %xmm0, (%rsp) # 16-byte Spill
; CHECK-NEXT:    vpermilps $255, {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Folded Reload
; CHECK-NEXT:    # xmm0 = mem[3,3,3,3]
; CHECK-NEXT:    callq sinf@PLT
; CHECK-NEXT:    vmovaps (%rsp), %xmm1 # 16-byte Reload
; CHECK-NEXT:    vinsertps {{.*#+}} xmm0 = xmm1[0,1,2],xmm0[0]
; CHECK-NEXT:    vmovups %ymm0, (%rsp) # 32-byte Spill
; CHECK-NEXT:    vmovups {{[-0-9]+}}(%r{{[sb]}}p), %ymm0 # 32-byte Reload
; CHECK-NEXT:    vextractf128 $1, %ymm0, %xmm0
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    callq sinf@PLT
; CHECK-NEXT:    vmovups (%rsp), %ymm1 # 32-byte Reload
; CHECK-NEXT:    vinsertf128 $1, %xmm0, %ymm1, %ymm0
; CHECK-NEXT:    addq $72, %rsp
; CHECK-NEXT:    retq
  %r = call <5 x float> @llvm.sin.v5f32(<5 x float> %x)
  ret <5 x float> %r
}

define <6 x float> @sin_v6f32(<6 x float> %x) nounwind {
; CHECK-LABEL: sin_v6f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subq $72, %rsp
; CHECK-NEXT:    vmovups %ymm0, {{[-0-9]+}}(%r{{[sb]}}p) # 32-byte Spill
; CHECK-NEXT:    vextractf128 $1, %ymm0, %xmm0
; CHECK-NEXT:    vmovaps %xmm0, (%rsp) # 16-byte Spill
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    callq sinf@PLT
; CHECK-NEXT:    vmovaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    vmovshdup (%rsp), %xmm0 # 16-byte Folded Reload
; CHECK-NEXT:    # xmm0 = mem[1,1,3,3]
; CHECK-NEXT:    callq sinf@PLT
; CHECK-NEXT:    vmovaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; CHECK-NEXT:    vinsertps {{.*#+}} xmm0 = xmm1[0],xmm0[0],xmm1[2,3]
; CHECK-NEXT:    vmovaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    vmovups {{[-0-9]+}}(%r{{[sb]}}p), %ymm0 # 32-byte Reload
; CHECK-NEXT:    # kill: def $xmm0 killed $xmm0 killed $ymm0
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    callq sinf@PLT
; CHECK-NEXT:    vmovaps %xmm0, (%rsp) # 16-byte Spill
; CHECK-NEXT:    vmovshdup {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Folded Reload
; CHECK-NEXT:    # xmm0 = mem[1,1,3,3]
; CHECK-NEXT:    callq sinf@PLT
; CHECK-NEXT:    vmovaps (%rsp), %xmm1 # 16-byte Reload
; CHECK-NEXT:    vinsertps {{.*#+}} xmm0 = xmm1[0],xmm0[0],xmm1[2,3]
; CHECK-NEXT:    vmovaps %xmm0, (%rsp) # 16-byte Spill
; CHECK-NEXT:    vpermilpd $1, {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Folded Reload
; CHECK-NEXT:    # xmm0 = mem[1,0]
; CHECK-NEXT:    callq sinf@PLT
; CHECK-NEXT:    vmovaps (%rsp), %xmm1 # 16-byte Reload
; CHECK-NEXT:    vinsertps {{.*#+}} xmm0 = xmm1[0,1],xmm0[0],xmm1[3]
; CHECK-NEXT:    vmovaps %xmm0, (%rsp) # 16-byte Spill
; CHECK-NEXT:    vpermilps $255, {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Folded Reload
; CHECK-NEXT:    # xmm0 = mem[3,3,3,3]
; CHECK-NEXT:    callq sinf@PLT
; CHECK-NEXT:    vmovaps (%rsp), %xmm1 # 16-byte Reload
; CHECK-NEXT:    vinsertps {{.*#+}} xmm0 = xmm1[0,1,2],xmm0[0]
; CHECK-NEXT:    vinsertf128 $1, {{[-0-9]+}}(%r{{[sb]}}p), %ymm0, %ymm0 # 16-byte Folded Reload
; CHECK-NEXT:    addq $72, %rsp
; CHECK-NEXT:    retq
  %r = call <6 x float> @llvm.sin.v6f32(<6 x float> %x)
  ret <6 x float> %r
}

define <3 x double> @sin_v3f64(<3 x double> %x) nounwind {
; CHECK-LABEL: sin_v3f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subq $72, %rsp
; CHECK-NEXT:    vmovups %ymm0, {{[-0-9]+}}(%r{{[sb]}}p) # 32-byte Spill
; CHECK-NEXT:    # kill: def $xmm0 killed $xmm0 killed $ymm0
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    callq sin@PLT
; CHECK-NEXT:    vmovaps %xmm0, (%rsp) # 16-byte Spill
; CHECK-NEXT:    vpermilpd $1, {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Folded Reload
; CHECK-NEXT:    # xmm0 = mem[1,0]
; CHECK-NEXT:    callq sin@PLT
; CHECK-NEXT:    vmovapd (%rsp), %xmm1 # 16-byte Reload
; CHECK-NEXT:    vunpcklpd {{.*#+}} xmm0 = xmm1[0],xmm0[0]
; CHECK-NEXT:    vmovupd %ymm0, (%rsp) # 32-byte Spill
; CHECK-NEXT:    vmovups {{[-0-9]+}}(%r{{[sb]}}p), %ymm0 # 32-byte Reload
; CHECK-NEXT:    vextractf128 $1, %ymm0, %xmm0
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    callq sin@PLT
; CHECK-NEXT:    vmovups (%rsp), %ymm1 # 32-byte Reload
; CHECK-NEXT:    vinsertf128 $1, %xmm0, %ymm1, %ymm0
; CHECK-NEXT:    addq $72, %rsp
; CHECK-NEXT:    retq
  %r = call <3 x double> @llvm.sin.v3f64(<3 x double> %x)
  ret <3 x double> %r
}

define <1 x float> @tan_v1f32(<1 x float> %x) nounwind {
; CHECK-LABEL: tan_v1f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushq %rax
; CHECK-NEXT:    callq tanf@PLT
; CHECK-NEXT:    popq %rax
; CHECK-NEXT:    retq
  %r = call <1 x float> @llvm.tan.v1f32(<1 x float> %x)
  ret <1 x float> %r
}

define <2 x float> @tan_v2f32(<2 x float> %x) nounwind {
; CHECK-LABEL: tan_v2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subq $40, %rsp
; CHECK-NEXT:    vmovaps %xmm0, (%rsp) # 16-byte Spill
; CHECK-NEXT:    callq tanf@PLT
; CHECK-NEXT:    vmovaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    vmovshdup (%rsp), %xmm0 # 16-byte Folded Reload
; CHECK-NEXT:    # xmm0 = mem[1,1,3,3]
; CHECK-NEXT:    callq tanf@PLT
; CHECK-NEXT:    vmovaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; CHECK-NEXT:    vinsertps {{.*#+}} xmm0 = xmm1[0],xmm0[0],xmm1[2,3]
; CHECK-NEXT:    addq $40, %rsp
; CHECK-NEXT:    retq
  %r = call <2 x float> @llvm.tan.v2f32(<2 x float> %x)
  ret <2 x float> %r
}

define <3 x float> @tan_v3f32(<3 x float> %x) nounwind {
; CHECK-LABEL: tan_v3f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subq $40, %rsp
; CHECK-NEXT:    vmovaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    callq tanf@PLT
; CHECK-NEXT:    vmovaps %xmm0, (%rsp) # 16-byte Spill
; CHECK-NEXT:    vmovshdup {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Folded Reload
; CHECK-NEXT:    # xmm0 = mem[1,1,3,3]
; CHECK-NEXT:    callq tanf@PLT
; CHECK-NEXT:    vmovaps (%rsp), %xmm1 # 16-byte Reload
; CHECK-NEXT:    vinsertps {{.*#+}} xmm0 = xmm1[0],xmm0[0],xmm1[2,3]
; CHECK-NEXT:    vmovaps %xmm0, (%rsp) # 16-byte Spill
; CHECK-NEXT:    vpermilpd $1, {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Folded Reload
; CHECK-NEXT:    # xmm0 = mem[1,0]
; CHECK-NEXT:    callq tanf@PLT
; CHECK-NEXT:    vmovaps (%rsp), %xmm1 # 16-byte Reload
; CHECK-NEXT:    vinsertps {{.*#+}} xmm0 = xmm1[0,1],xmm0[0],xmm1[3]
; CHECK-NEXT:    addq $40, %rsp
; CHECK-NEXT:    retq
  %r = call <3 x float> @llvm.tan.v3f32(<3 x float> %x)
  ret <3 x float> %r
}

define <4 x float> @tan_v4f32(<4 x float> %x) nounwind {
; CHECK-LABEL: tan_v4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subq $40, %rsp
; CHECK-NEXT:    vmovaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    callq tanf@PLT
; CHECK-NEXT:    vmovaps %xmm0, (%rsp) # 16-byte Spill
; CHECK-NEXT:    vmovshdup {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Folded Reload
; CHECK-NEXT:    # xmm0 = mem[1,1,3,3]
; CHECK-NEXT:    callq tanf@PLT
; CHECK-NEXT:    vmovaps (%rsp), %xmm1 # 16-byte Reload
; CHECK-NEXT:    vinsertps {{.*#+}} xmm0 = xmm1[0],xmm0[0],xmm1[2,3]
; CHECK-NEXT:    vmovaps %xmm0, (%rsp) # 16-byte Spill
; CHECK-NEXT:    vpermilpd $1, {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Folded Reload
; CHECK-NEXT:    # xmm0 = mem[1,0]
; CHECK-NEXT:    callq tanf@PLT
; CHECK-NEXT:    vmovaps (%rsp), %xmm1 # 16-byte Reload
; CHECK-NEXT:    vinsertps {{.*#+}} xmm0 = xmm1[0,1],xmm0[0],xmm1[3]
; CHECK-NEXT:    vmovaps %xmm0, (%rsp) # 16-byte Spill
; CHECK-NEXT:    vpermilps $255, {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Folded Reload
; CHECK-NEXT:    # xmm0 = mem[3,3,3,3]
; CHECK-NEXT:    callq tanf@PLT
; CHECK-NEXT:    vmovaps (%rsp), %xmm1 # 16-byte Reload
; CHECK-NEXT:    vinsertps {{.*#+}} xmm0 = xmm1[0,1,2],xmm0[0]
; CHECK-NEXT:    addq $40, %rsp
; CHECK-NEXT:    retq
  %r = call <4 x float> @llvm.tan.v4f32(<4 x float> %x)
  ret <4 x float> %r
}

define <5 x float> @tan_v5f32(<5 x float> %x) nounwind {
; CHECK-LABEL: tan_v5f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subq $72, %rsp
; CHECK-NEXT:    vmovups %ymm0, {{[-0-9]+}}(%r{{[sb]}}p) # 32-byte Spill
; CHECK-NEXT:    # kill: def $xmm0 killed $xmm0 killed $ymm0
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    callq tanf@PLT
; CHECK-NEXT:    vmovaps %xmm0, (%rsp) # 16-byte Spill
; CHECK-NEXT:    vmovshdup {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Folded Reload
; CHECK-NEXT:    # xmm0 = mem[1,1,3,3]
; CHECK-NEXT:    callq tanf@PLT
; CHECK-NEXT:    vmovaps (%rsp), %xmm1 # 16-byte Reload
; CHECK-NEXT:    vinsertps {{.*#+}} xmm0 = xmm1[0],xmm0[0],xmm1[2,3]
; CHECK-NEXT:    vmovaps %xmm0, (%rsp) # 16-byte Spill
; CHECK-NEXT:    vpermilpd $1, {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Folded Reload
; CHECK-NEXT:    # xmm0 = mem[1,0]
; CHECK-NEXT:    callq tanf@PLT
; CHECK-NEXT:    vmovaps (%rsp), %xmm1 # 16-byte Reload
; CHECK-NEXT:    vinsertps {{.*#+}} xmm0 = xmm1[0,1],xmm0[0],xmm1[3]
; CHECK-NEXT:    vmovaps %xmm0, (%rsp) # 16-byte Spill
; CHECK-NEXT:    vpermilps $255, {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Folded Reload
; CHECK-NEXT:    # xmm0 = mem[3,3,3,3]
; CHECK-NEXT:    callq tanf@PLT
; CHECK-NEXT:    vmovaps (%rsp), %xmm1 # 16-byte Reload
; CHECK-NEXT:    vinsertps {{.*#+}} xmm0 = xmm1[0,1,2],xmm0[0]
; CHECK-NEXT:    vmovups %ymm0, (%rsp) # 32-byte Spill
; CHECK-NEXT:    vmovups {{[-0-9]+}}(%r{{[sb]}}p), %ymm0 # 32-byte Reload
; CHECK-NEXT:    vextractf128 $1, %ymm0, %xmm0
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    callq tanf@PLT
; CHECK-NEXT:    vmovups (%rsp), %ymm1 # 32-byte Reload
; CHECK-NEXT:    vinsertf128 $1, %xmm0, %ymm1, %ymm0
; CHECK-NEXT:    addq $72, %rsp
; CHECK-NEXT:    retq
  %r = call <5 x float> @llvm.tan.v5f32(<5 x float> %x)
  ret <5 x float> %r
}

define <6 x float> @tan_v6f32(<6 x float> %x) nounwind {
; CHECK-LABEL: tan_v6f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subq $72, %rsp
; CHECK-NEXT:    vmovups %ymm0, {{[-0-9]+}}(%r{{[sb]}}p) # 32-byte Spill
; CHECK-NEXT:    vextractf128 $1, %ymm0, %xmm0
; CHECK-NEXT:    vmovaps %xmm0, (%rsp) # 16-byte Spill
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    callq tanf@PLT
; CHECK-NEXT:    vmovaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    vmovshdup (%rsp), %xmm0 # 16-byte Folded Reload
; CHECK-NEXT:    # xmm0 = mem[1,1,3,3]
; CHECK-NEXT:    callq tanf@PLT
; CHECK-NEXT:    vmovaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; CHECK-NEXT:    vinsertps {{.*#+}} xmm0 = xmm1[0],xmm0[0],xmm1[2,3]
; CHECK-NEXT:    vmovaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    vmovups {{[-0-9]+}}(%r{{[sb]}}p), %ymm0 # 32-byte Reload
; CHECK-NEXT:    # kill: def $xmm0 killed $xmm0 killed $ymm0
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    callq tanf@PLT
; CHECK-NEXT:    vmovaps %xmm0, (%rsp) # 16-byte Spill
; CHECK-NEXT:    vmovshdup {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Folded Reload
; CHECK-NEXT:    # xmm0 = mem[1,1,3,3]
; CHECK-NEXT:    callq tanf@PLT
; CHECK-NEXT:    vmovaps (%rsp), %xmm1 # 16-byte Reload
; CHECK-NEXT:    vinsertps {{.*#+}} xmm0 = xmm1[0],xmm0[0],xmm1[2,3]
; CHECK-NEXT:    vmovaps %xmm0, (%rsp) # 16-byte Spill
; CHECK-NEXT:    vpermilpd $1, {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Folded Reload
; CHECK-NEXT:    # xmm0 = mem[1,0]
; CHECK-NEXT:    callq tanf@PLT
; CHECK-NEXT:    vmovaps (%rsp), %xmm1 # 16-byte Reload
; CHECK-NEXT:    vinsertps {{.*#+}} xmm0 = xmm1[0,1],xmm0[0],xmm1[3]
; CHECK-NEXT:    vmovaps %xmm0, (%rsp) # 16-byte Spill
; CHECK-NEXT:    vpermilps $255, {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Folded Reload
; CHECK-NEXT:    # xmm0 = mem[3,3,3,3]
; CHECK-NEXT:    callq tanf@PLT
; CHECK-NEXT:    vmovaps (%rsp), %xmm1 # 16-byte Reload
; CHECK-NEXT:    vinsertps {{.*#+}} xmm0 = xmm1[0,1,2],xmm0[0]
; CHECK-NEXT:    vinsertf128 $1, {{[-0-9]+}}(%r{{[sb]}}p), %ymm0, %ymm0 # 16-byte Folded Reload
; CHECK-NEXT:    addq $72, %rsp
; CHECK-NEXT:    retq
  %r = call <6 x float> @llvm.tan.v6f32(<6 x float> %x)
  ret <6 x float> %r
}

define <3 x double> @tan_v3f64(<3 x double> %x) nounwind {
; CHECK-LABEL: tan_v3f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subq $72, %rsp
; CHECK-NEXT:    vmovups %ymm0, {{[-0-9]+}}(%r{{[sb]}}p) # 32-byte Spill
; CHECK-NEXT:    # kill: def $xmm0 killed $xmm0 killed $ymm0
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    callq tan@PLT
; CHECK-NEXT:    vmovaps %xmm0, (%rsp) # 16-byte Spill
; CHECK-NEXT:    vpermilpd $1, {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Folded Reload
; CHECK-NEXT:    # xmm0 = mem[1,0]
; CHECK-NEXT:    callq tan@PLT
; CHECK-NEXT:    vmovapd (%rsp), %xmm1 # 16-byte Reload
; CHECK-NEXT:    vunpcklpd {{.*#+}} xmm0 = xmm1[0],xmm0[0]
; CHECK-NEXT:    vmovupd %ymm0, (%rsp) # 32-byte Spill
; CHECK-NEXT:    vmovups {{[-0-9]+}}(%r{{[sb]}}p), %ymm0 # 32-byte Reload
; CHECK-NEXT:    vextractf128 $1, %ymm0, %xmm0
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    callq tan@PLT
; CHECK-NEXT:    vmovups (%rsp), %ymm1 # 32-byte Reload
; CHECK-NEXT:    vinsertf128 $1, %xmm0, %ymm1, %ymm0
; CHECK-NEXT:    addq $72, %rsp
; CHECK-NEXT:    retq
  %r = call <3 x double> @llvm.tan.v3f64(<3 x double> %x)
  ret <3 x double> %r
}

define <2 x float> @fabs_v2f32(<2 x float> %x) nounwind {
; CHECK-LABEL: fabs_v2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vandps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; CHECK-NEXT:    retq
  %r = call <2 x float> @llvm.fabs.v2f32(<2 x float> %x)
  ret <2 x float> %r
}

define <2 x float> @ceil_v2f32(<2 x float> %x) nounwind {
; CHECK-LABEL: ceil_v2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vroundps $10, %xmm0, %xmm0
; CHECK-NEXT:    retq
  %r = call <2 x float> @llvm.ceil.v2f32(<2 x float> %x)
  ret <2 x float> %r
}

define <2 x float> @cos_v2f32(<2 x float> %x) nounwind {
; CHECK-LABEL: cos_v2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subq $40, %rsp
; CHECK-NEXT:    vmovaps %xmm0, (%rsp) # 16-byte Spill
; CHECK-NEXT:    callq cosf@PLT
; CHECK-NEXT:    vmovaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    vmovshdup (%rsp), %xmm0 # 16-byte Folded Reload
; CHECK-NEXT:    # xmm0 = mem[1,1,3,3]
; CHECK-NEXT:    callq cosf@PLT
; CHECK-NEXT:    vmovaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; CHECK-NEXT:    vinsertps {{.*#+}} xmm0 = xmm1[0],xmm0[0],xmm1[2,3]
; CHECK-NEXT:    addq $40, %rsp
; CHECK-NEXT:    retq
  %r = call <2 x float> @llvm.cos.v2f32(<2 x float> %x)
  ret <2 x float> %r
}

define <2 x float> @exp_v2f32(<2 x float> %x) nounwind {
; CHECK-LABEL: exp_v2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subq $40, %rsp
; CHECK-NEXT:    vmovaps %xmm0, (%rsp) # 16-byte Spill
; CHECK-NEXT:    callq expf@PLT
; CHECK-NEXT:    vmovaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    vmovshdup (%rsp), %xmm0 # 16-byte Folded Reload
; CHECK-NEXT:    # xmm0 = mem[1,1,3,3]
; CHECK-NEXT:    callq expf@PLT
; CHECK-NEXT:    vmovaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; CHECK-NEXT:    vinsertps {{.*#+}} xmm0 = xmm1[0],xmm0[0],xmm1[2,3]
; CHECK-NEXT:    addq $40, %rsp
; CHECK-NEXT:    retq
  %r = call <2 x float> @llvm.exp.v2f32(<2 x float> %x)
  ret <2 x float> %r
}

define <2 x float> @exp2_v2f32(<2 x float> %x) nounwind {
; CHECK-LABEL: exp2_v2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subq $40, %rsp
; CHECK-NEXT:    vmovaps %xmm0, (%rsp) # 16-byte Spill
; CHECK-NEXT:    callq exp2f@PLT
; CHECK-NEXT:    vmovaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    vmovshdup (%rsp), %xmm0 # 16-byte Folded Reload
; CHECK-NEXT:    # xmm0 = mem[1,1,3,3]
; CHECK-NEXT:    callq exp2f@PLT
; CHECK-NEXT:    vmovaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; CHECK-NEXT:    vinsertps {{.*#+}} xmm0 = xmm1[0],xmm0[0],xmm1[2,3]
; CHECK-NEXT:    addq $40, %rsp
; CHECK-NEXT:    retq
  %r = call <2 x float> @llvm.exp2.v2f32(<2 x float> %x)
  ret <2 x float> %r
}

define <2 x float> @floor_v2f32(<2 x float> %x) nounwind {
; CHECK-LABEL: floor_v2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vroundps $9, %xmm0, %xmm0
; CHECK-NEXT:    retq
  %r = call <2 x float> @llvm.floor.v2f32(<2 x float> %x)
  ret <2 x float> %r
}

define <2 x float> @log_v2f32(<2 x float> %x) nounwind {
; CHECK-LABEL: log_v2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subq $40, %rsp
; CHECK-NEXT:    vmovaps %xmm0, (%rsp) # 16-byte Spill
; CHECK-NEXT:    callq logf@PLT
; CHECK-NEXT:    vmovaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    vmovshdup (%rsp), %xmm0 # 16-byte Folded Reload
; CHECK-NEXT:    # xmm0 = mem[1,1,3,3]
; CHECK-NEXT:    callq logf@PLT
; CHECK-NEXT:    vmovaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; CHECK-NEXT:    vinsertps {{.*#+}} xmm0 = xmm1[0],xmm0[0],xmm1[2,3]
; CHECK-NEXT:    addq $40, %rsp
; CHECK-NEXT:    retq
  %r = call <2 x float> @llvm.log.v2f32(<2 x float> %x)
  ret <2 x float> %r
}

define <2 x float> @log10_v2f32(<2 x float> %x) nounwind {
; CHECK-LABEL: log10_v2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subq $40, %rsp
; CHECK-NEXT:    vmovaps %xmm0, (%rsp) # 16-byte Spill
; CHECK-NEXT:    callq log10f@PLT
; CHECK-NEXT:    vmovaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    vmovshdup (%rsp), %xmm0 # 16-byte Folded Reload
; CHECK-NEXT:    # xmm0 = mem[1,1,3,3]
; CHECK-NEXT:    callq log10f@PLT
; CHECK-NEXT:    vmovaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; CHECK-NEXT:    vinsertps {{.*#+}} xmm0 = xmm1[0],xmm0[0],xmm1[2,3]
; CHECK-NEXT:    addq $40, %rsp
; CHECK-NEXT:    retq
  %r = call <2 x float> @llvm.log10.v2f32(<2 x float> %x)
  ret <2 x float> %r
}

define <2 x float> @log2_v2f32(<2 x float> %x) nounwind {
; CHECK-LABEL: log2_v2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subq $40, %rsp
; CHECK-NEXT:    vmovaps %xmm0, (%rsp) # 16-byte Spill
; CHECK-NEXT:    callq log2f@PLT
; CHECK-NEXT:    vmovaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    vmovshdup (%rsp), %xmm0 # 16-byte Folded Reload
; CHECK-NEXT:    # xmm0 = mem[1,1,3,3]
; CHECK-NEXT:    callq log2f@PLT
; CHECK-NEXT:    vmovaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; CHECK-NEXT:    vinsertps {{.*#+}} xmm0 = xmm1[0],xmm0[0],xmm1[2,3]
; CHECK-NEXT:    addq $40, %rsp
; CHECK-NEXT:    retq
  %r = call <2 x float> @llvm.log2.v2f32(<2 x float> %x)
  ret <2 x float> %r
}

define <2 x float> @nearbyint__v2f32(<2 x float> %x) nounwind {
; CHECK-LABEL: nearbyint__v2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vroundps $12, %xmm0, %xmm0
; CHECK-NEXT:    retq
  %r = call <2 x float> @llvm.nearbyint.v2f32(<2 x float> %x)
  ret <2 x float> %r
}

define <2 x float> @rint_v2f32(<2 x float> %x) nounwind {
; CHECK-LABEL: rint_v2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vroundps $4, %xmm0, %xmm0
; CHECK-NEXT:    retq
  %r = call <2 x float> @llvm.rint.v2f32(<2 x float> %x)
  ret <2 x float> %r
}

define <2 x float> @round_v2f32(<2 x float> %x) nounwind {
; CHECK-LABEL: round_v2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vandps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm1
; CHECK-NEXT:    vorps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm1, %xmm1
; CHECK-NEXT:    vaddps %xmm1, %xmm0, %xmm0
; CHECK-NEXT:    vroundps $11, %xmm0, %xmm0
; CHECK-NEXT:    retq
  %r = call <2 x float> @llvm.round.v2f32(<2 x float> %x)
  ret <2 x float> %r
}

define <2 x float> @sqrt_v2f32(<2 x float> %x) nounwind {
; CHECK-LABEL: sqrt_v2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsqrtps %xmm0, %xmm0
; CHECK-NEXT:    retq
  %r = call <2 x float> @llvm.sqrt.v2f32(<2 x float> %x)
  ret <2 x float> %r
}

define <2 x float> @trunc_v2f32(<2 x float> %x) nounwind {
; CHECK-LABEL: trunc_v2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vroundps $11, %xmm0, %xmm0
; CHECK-NEXT:    retq
  %r = call <2 x float> @llvm.trunc.v2f32(<2 x float> %x)
  ret <2 x float> %r
}

