; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py
; RUN: opt -mtriple=x86_64-- -passes="print<cost-model>" 2>&1 -disable-output -cost-kind=throughput   < %s | FileCheck %s --check-prefix=THRU
; RUN: opt -mtriple=x86_64-- -passes="print<cost-model>" 2>&1 -disable-output -cost-kind=latency      < %s | FileCheck %s --check-prefix=LATE
; RUN: opt -mtriple=x86_64-- -passes="print<cost-model>" 2>&1 -disable-output -cost-kind=code-size    < %s | FileCheck %s --check-prefix=SIZE
; RUN: opt -mtriple=x86_64-- -passes="print<cost-model>" 2>&1 -disable-output -cost-kind=size-latency < %s | FileCheck %s --check-prefix=SIZE_LATE

; Test a cross-section of intrinsics for various cost-kinds.
; Other test files may check for accuracy of a particular intrinsic
; across subtargets or types. This is just a basic correctness check using the
; default x86 target and a legal scalar type (i32/float) and/or an
; illegal vector type (16 x i32/float).

declare {i32, i1} @llvm.umul.with.overflow.i32(i32, i32)
declare {<16 x i32>, <16 x i1>} @llvm.umul.with.overflow.v16i32(<16 x i32>, <16 x i32>)

declare i32 @llvm.smax.i32(i32, i32)
declare <16 x i32> @llvm.smax.v16i32(<16 x i32>, <16 x i32>)

declare float @llvm.copysign.f32(float, float)
declare <16 x float> @llvm.copysign.v16f32(<16 x float>, <16 x float>)

declare float @llvm.fmuladd.f32(float, float, float)
declare <16 x float> @llvm.fmuladd.v16f32(<16 x float>, <16 x float>, <16 x float>)

declare float @llvm.log2.f32(float)
declare <16 x float> @llvm.log2.v16f32(<16 x float>)

declare float @llvm.experimental.constrained.fadd.f32(float, float, metadata, metadata)
declare <16 x float> @llvm.experimental.constrained.fadd.v16f32(<16 x float>, <16 x float>, metadata, metadata)

declare float @llvm.maximum.f32(float, float)
declare <16 x float> @llvm.maximum.v16f32(<16 x float>, <16 x float>)

declare i32 @llvm.cttz.i32(i32, i1)
declare <16 x i32> @llvm.cttz.v16i32(<16 x i32>, i1)

declare i32 @llvm.ctlz.i32(i32, i1)
declare <16 x i32> @llvm.ctlz.v16i32(<16 x i32>, i1)

declare i32 @llvm.fshl.i32(i32, i32, i32)
declare <16 x i32> @llvm.fshl.v16i32(<16 x i32>, <16 x i32>, <16 x i32>)

declare <16 x float> @llvm.masked.gather.v16f32.v16p0(<16 x ptr>, i32, <16 x i1>, <16 x float>)
declare void @llvm.masked.scatter.v16f32.v16p0(<16 x float>, <16 x ptr>, i32, <16 x i1>)
declare float @llvm.vector.reduce.fmax.v16f32(<16 x float>)
declare float @llvm.vector.reduce.fmul.v16f32(float, <16 x float>)
declare float @llvm.vector.reduce.fadd.v16f32(float, <16 x float>)

declare void @llvm.memcpy.p0.p0.i32(ptr, ptr, i32, i1)

define void @umul(i32 %a, i32 %b, <16 x i32> %va, <16 x i32> %vb) {
; THRU-LABEL: 'umul'
; THRU-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %s = call { i32, i1 } @llvm.umul.with.overflow.i32(i32 %a, i32 %b)
; THRU-NEXT:  Cost Model: Found an estimated cost of 104 for instruction: %v = call { <16 x i32>, <16 x i1> } @llvm.umul.with.overflow.v16i32(<16 x i32> %va, <16 x i32> %vb)
; THRU-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
; LATE-LABEL: 'umul'
; LATE-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %s = call { i32, i1 } @llvm.umul.with.overflow.i32(i32 %a, i32 %b)
; LATE-NEXT:  Cost Model: Found an estimated cost of 128 for instruction: %v = call { <16 x i32>, <16 x i1> } @llvm.umul.with.overflow.v16i32(<16 x i32> %va, <16 x i32> %vb)
; LATE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; SIZE-LABEL: 'umul'
; SIZE-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %s = call { i32, i1 } @llvm.umul.with.overflow.i32(i32 %a, i32 %b)
; SIZE-NEXT:  Cost Model: Found an estimated cost of 128 for instruction: %v = call { <16 x i32>, <16 x i1> } @llvm.umul.with.overflow.v16i32(<16 x i32> %va, <16 x i32> %vb)
; SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; SIZE_LATE-LABEL: 'umul'
; SIZE_LATE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %s = call { i32, i1 } @llvm.umul.with.overflow.i32(i32 %a, i32 %b)
; SIZE_LATE-NEXT:  Cost Model: Found an estimated cost of 128 for instruction: %v = call { <16 x i32>, <16 x i1> } @llvm.umul.with.overflow.v16i32(<16 x i32> %va, <16 x i32> %vb)
; SIZE_LATE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
  %s = call {i32, i1} @llvm.umul.with.overflow.i32(i32 %a, i32 %b)
  %v = call {<16 x i32>, <16 x i1>} @llvm.umul.with.overflow.v16i32(<16 x i32> %va, <16 x i32> %vb)
  ret void
}

define void @smax(i32 %a, i32 %b, <16 x i32> %va, <16 x i32> %vb) {
; THRU-LABEL: 'smax'
; THRU-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %s = call i32 @llvm.smax.i32(i32 %a, i32 %b)
; THRU-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %v = call <16 x i32> @llvm.smax.v16i32(<16 x i32> %va, <16 x i32> %vb)
; THRU-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
; LATE-LABEL: 'smax'
; LATE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %s = call i32 @llvm.smax.i32(i32 %a, i32 %b)
; LATE-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: %v = call <16 x i32> @llvm.smax.v16i32(<16 x i32> %va, <16 x i32> %vb)
; LATE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; SIZE-LABEL: 'smax'
; SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %s = call i32 @llvm.smax.i32(i32 %a, i32 %b)
; SIZE-NEXT:  Cost Model: Found an estimated cost of 20 for instruction: %v = call <16 x i32> @llvm.smax.v16i32(<16 x i32> %va, <16 x i32> %vb)
; SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; SIZE_LATE-LABEL: 'smax'
; SIZE_LATE-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %s = call i32 @llvm.smax.i32(i32 %a, i32 %b)
; SIZE_LATE-NEXT:  Cost Model: Found an estimated cost of 20 for instruction: %v = call <16 x i32> @llvm.smax.v16i32(<16 x i32> %va, <16 x i32> %vb)
; SIZE_LATE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
  %s = call i32 @llvm.smax.i32(i32 %a, i32 %b)
  %v = call <16 x i32> @llvm.smax.v16i32(<16 x i32> %va, <16 x i32> %vb)
  ret void
}

define void @fcopysign(float %a, float %b, <16 x float> %va, <16 x float> %vb) {
; THRU-LABEL: 'fcopysign'
; THRU-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %s = call float @llvm.copysign.f32(float %a, float %b)
; THRU-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %v = call <16 x float> @llvm.copysign.v16f32(<16 x float> %va, <16 x float> %vb)
; THRU-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
; LATE-LABEL: 'fcopysign'
; LATE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %s = call float @llvm.copysign.f32(float %a, float %b)
; LATE-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %v = call <16 x float> @llvm.copysign.v16f32(<16 x float> %va, <16 x float> %vb)
; LATE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; SIZE-LABEL: 'fcopysign'
; SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %s = call float @llvm.copysign.f32(float %a, float %b)
; SIZE-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %v = call <16 x float> @llvm.copysign.v16f32(<16 x float> %va, <16 x float> %vb)
; SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; SIZE_LATE-LABEL: 'fcopysign'
; SIZE_LATE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %s = call float @llvm.copysign.f32(float %a, float %b)
; SIZE_LATE-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %v = call <16 x float> @llvm.copysign.v16f32(<16 x float> %va, <16 x float> %vb)
; SIZE_LATE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
  %s = call float @llvm.copysign.f32(float %a, float %b)
  %v = call <16 x float> @llvm.copysign.v16f32(<16 x float> %va, <16 x float> %vb)
  ret void
}

define void @fmuladd(float %a, float %b, float %c, <16 x float> %va, <16 x float> %vb, <16 x float> %vc) {
; THRU-LABEL: 'fmuladd'
; THRU-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %s = call float @llvm.fmuladd.f32(float %a, float %b, float %c)
; THRU-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: %v = call <16 x float> @llvm.fmuladd.v16f32(<16 x float> %va, <16 x float> %vb, <16 x float> %vc)
; THRU-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
; LATE-LABEL: 'fmuladd'
; LATE-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %s = call float @llvm.fmuladd.f32(float %a, float %b, float %c)
; LATE-NEXT:  Cost Model: Found an estimated cost of 32 for instruction: %v = call <16 x float> @llvm.fmuladd.v16f32(<16 x float> %va, <16 x float> %vb, <16 x float> %vc)
; LATE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; SIZE-LABEL: 'fmuladd'
; SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %s = call float @llvm.fmuladd.f32(float %a, float %b, float %c)
; SIZE-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %v = call <16 x float> @llvm.fmuladd.v16f32(<16 x float> %va, <16 x float> %vb, <16 x float> %vc)
; SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; SIZE_LATE-LABEL: 'fmuladd'
; SIZE_LATE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %s = call float @llvm.fmuladd.f32(float %a, float %b, float %c)
; SIZE_LATE-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %v = call <16 x float> @llvm.fmuladd.v16f32(<16 x float> %va, <16 x float> %vb, <16 x float> %vc)
; SIZE_LATE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
  %s = call float @llvm.fmuladd.f32(float %a, float %b, float %c)
  %v = call <16 x float> @llvm.fmuladd.v16f32(<16 x float> %va, <16 x float> %vb, <16 x float> %vc)
  ret void
}

define void @log2(float %a, <16 x float> %va) {
; THRU-LABEL: 'log2'
; THRU-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %s = call float @llvm.log2.f32(float %a)
; THRU-NEXT:  Cost Model: Found an estimated cost of 184 for instruction: %v = call <16 x float> @llvm.log2.v16f32(<16 x float> %va)
; THRU-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
; LATE-LABEL: 'log2'
; LATE-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %s = call float @llvm.log2.f32(float %a)
; LATE-NEXT:  Cost Model: Found an estimated cost of 184 for instruction: %v = call <16 x float> @llvm.log2.v16f32(<16 x float> %va)
; LATE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; SIZE-LABEL: 'log2'
; SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %s = call float @llvm.log2.f32(float %a)
; SIZE-NEXT:  Cost Model: Found an estimated cost of 40 for instruction: %v = call <16 x float> @llvm.log2.v16f32(<16 x float> %va)
; SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; SIZE_LATE-LABEL: 'log2'
; SIZE_LATE-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %s = call float @llvm.log2.f32(float %a)
; SIZE_LATE-NEXT:  Cost Model: Found an estimated cost of 184 for instruction: %v = call <16 x float> @llvm.log2.v16f32(<16 x float> %va)
; SIZE_LATE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
  %s = call float @llvm.log2.f32(float %a)
  %v = call <16 x float> @llvm.log2.v16f32(<16 x float> %va)
  ret void
}

define void @constrained_fadd(float %a, <16 x float> %va) strictfp {
; THRU-LABEL: 'constrained_fadd'
; THRU-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %s = call float @llvm.experimental.constrained.fadd.f32(float %a, float %a, metadata !"round.dynamic", metadata !"fpexcept.ignore")
; THRU-NEXT:  Cost Model: Found an estimated cost of 40 for instruction: %t = call <16 x float> @llvm.experimental.constrained.fadd.v16f32(<16 x float> %va, <16 x float> %va, metadata !"round.dynamic", metadata !"fpexcept.ignore")
; THRU-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
; LATE-LABEL: 'constrained_fadd'
; LATE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %s = call float @llvm.experimental.constrained.fadd.f32(float %a, float %a, metadata !"round.dynamic", metadata !"fpexcept.ignore")
; LATE-NEXT:  Cost Model: Found an estimated cost of 40 for instruction: %t = call <16 x float> @llvm.experimental.constrained.fadd.v16f32(<16 x float> %va, <16 x float> %va, metadata !"round.dynamic", metadata !"fpexcept.ignore")
; LATE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; SIZE-LABEL: 'constrained_fadd'
; SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %s = call float @llvm.experimental.constrained.fadd.f32(float %a, float %a, metadata !"round.dynamic", metadata !"fpexcept.ignore")
; SIZE-NEXT:  Cost Model: Found an estimated cost of 40 for instruction: %t = call <16 x float> @llvm.experimental.constrained.fadd.v16f32(<16 x float> %va, <16 x float> %va, metadata !"round.dynamic", metadata !"fpexcept.ignore")
; SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; SIZE_LATE-LABEL: 'constrained_fadd'
; SIZE_LATE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %s = call float @llvm.experimental.constrained.fadd.f32(float %a, float %a, metadata !"round.dynamic", metadata !"fpexcept.ignore")
; SIZE_LATE-NEXT:  Cost Model: Found an estimated cost of 40 for instruction: %t = call <16 x float> @llvm.experimental.constrained.fadd.v16f32(<16 x float> %va, <16 x float> %va, metadata !"round.dynamic", metadata !"fpexcept.ignore")
; SIZE_LATE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
  %s = call float @llvm.experimental.constrained.fadd.f32(float %a, float %a, metadata !"round.dynamic", metadata !"fpexcept.ignore")
  %t = call <16 x float> @llvm.experimental.constrained.fadd.v16f32(<16 x float> %va, <16 x float> %va, metadata !"round.dynamic", metadata !"fpexcept.ignore")
  ret void
}

define void @fmaximum(float %a, float %b, <16 x float> %va, <16 x float> %vb) {
; THRU-LABEL: 'fmaximum'
; THRU-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %s = call float @llvm.maximum.f32(float %a, float %b)
; THRU-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %v = call <16 x float> @llvm.maximum.v16f32(<16 x float> %va, <16 x float> %vb)
; THRU-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
; LATE-LABEL: 'fmaximum'
; LATE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %s = call float @llvm.maximum.f32(float %a, float %b)
; LATE-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %v = call <16 x float> @llvm.maximum.v16f32(<16 x float> %va, <16 x float> %vb)
; LATE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; SIZE-LABEL: 'fmaximum'
; SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %s = call float @llvm.maximum.f32(float %a, float %b)
; SIZE-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %v = call <16 x float> @llvm.maximum.v16f32(<16 x float> %va, <16 x float> %vb)
; SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; SIZE_LATE-LABEL: 'fmaximum'
; SIZE_LATE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %s = call float @llvm.maximum.f32(float %a, float %b)
; SIZE_LATE-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %v = call <16 x float> @llvm.maximum.v16f32(<16 x float> %va, <16 x float> %vb)
; SIZE_LATE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
  %s = call float @llvm.maximum.f32(float %a, float %b)
  %v = call <16 x float> @llvm.maximum.v16f32(<16 x float> %va, <16 x float> %vb)
  ret void
}

define void @cttz(i32 %a, <16 x i32> %va) {
; THRU-LABEL: 'cttz'
; THRU-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %s = call i32 @llvm.cttz.i32(i32 %a, i1 false)
; THRU-NEXT:  Cost Model: Found an estimated cost of 72 for instruction: %v = call <16 x i32> @llvm.cttz.v16i32(<16 x i32> %va, i1 false)
; THRU-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
; LATE-LABEL: 'cttz'
; LATE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %s = call i32 @llvm.cttz.i32(i32 %a, i1 false)
; LATE-NEXT:  Cost Model: Found an estimated cost of 124 for instruction: %v = call <16 x i32> @llvm.cttz.v16i32(<16 x i32> %va, i1 false)
; LATE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; SIZE-LABEL: 'cttz'
; SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %s = call i32 @llvm.cttz.i32(i32 %a, i1 false)
; SIZE-NEXT:  Cost Model: Found an estimated cost of 96 for instruction: %v = call <16 x i32> @llvm.cttz.v16i32(<16 x i32> %va, i1 false)
; SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; SIZE_LATE-LABEL: 'cttz'
; SIZE_LATE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %s = call i32 @llvm.cttz.i32(i32 %a, i1 false)
; SIZE_LATE-NEXT:  Cost Model: Found an estimated cost of 104 for instruction: %v = call <16 x i32> @llvm.cttz.v16i32(<16 x i32> %va, i1 false)
; SIZE_LATE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
  %s = call i32 @llvm.cttz.i32(i32 %a, i1 false)
  %v = call <16 x i32> @llvm.cttz.v16i32(<16 x i32> %va, i1 false)
  ret void
}

define void @ctlz(i32 %a, <16 x i32> %va) {
; THRU-LABEL: 'ctlz'
; THRU-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %s = call i32 @llvm.ctlz.i32(i32 %a, i1 true)
; THRU-NEXT:  Cost Model: Found an estimated cost of 40 for instruction: %v = call <16 x i32> @llvm.ctlz.v16i32(<16 x i32> %va, i1 true)
; THRU-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
; LATE-LABEL: 'ctlz'
; LATE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %s = call i32 @llvm.ctlz.i32(i32 %a, i1 true)
; LATE-NEXT:  Cost Model: Found an estimated cost of 180 for instruction: %v = call <16 x i32> @llvm.ctlz.v16i32(<16 x i32> %va, i1 true)
; LATE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; SIZE-LABEL: 'ctlz'
; SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %s = call i32 @llvm.ctlz.i32(i32 %a, i1 true)
; SIZE-NEXT:  Cost Model: Found an estimated cost of 152 for instruction: %v = call <16 x i32> @llvm.ctlz.v16i32(<16 x i32> %va, i1 true)
; SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; SIZE_LATE-LABEL: 'ctlz'
; SIZE_LATE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %s = call i32 @llvm.ctlz.i32(i32 %a, i1 true)
; SIZE_LATE-NEXT:  Cost Model: Found an estimated cost of 160 for instruction: %v = call <16 x i32> @llvm.ctlz.v16i32(<16 x i32> %va, i1 true)
; SIZE_LATE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
  %s = call i32 @llvm.ctlz.i32(i32 %a, i1 true)
  %v = call <16 x i32> @llvm.ctlz.v16i32(<16 x i32> %va, i1 true)
  ret void
}

define void @fshl(i32 %a, i32 %b, i32 %c, <16 x i32> %va, <16 x i32> %vb, <16 x i32> %vc) {
; THRU-LABEL: 'fshl'
; THRU-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %s = call i32 @llvm.fshl.i32(i32 %a, i32 %b, i32 %c)
; THRU-NEXT:  Cost Model: Found an estimated cost of 140 for instruction: %v = call <16 x i32> @llvm.fshl.v16i32(<16 x i32> %va, <16 x i32> %vb, <16 x i32> %vc)
; THRU-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
; LATE-LABEL: 'fshl'
; LATE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %s = call i32 @llvm.fshl.i32(i32 %a, i32 %b, i32 %c)
; LATE-NEXT:  Cost Model: Found an estimated cost of 145 for instruction: %v = call <16 x i32> @llvm.fshl.v16i32(<16 x i32> %va, <16 x i32> %vb, <16 x i32> %vc)
; LATE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; SIZE-LABEL: 'fshl'
; SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %s = call i32 @llvm.fshl.i32(i32 %a, i32 %b, i32 %c)
; SIZE-NEXT:  Cost Model: Found an estimated cost of 125 for instruction: %v = call <16 x i32> @llvm.fshl.v16i32(<16 x i32> %va, <16 x i32> %vb, <16 x i32> %vc)
; SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; SIZE_LATE-LABEL: 'fshl'
; SIZE_LATE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %s = call i32 @llvm.fshl.i32(i32 %a, i32 %b, i32 %c)
; SIZE_LATE-NEXT:  Cost Model: Found an estimated cost of 149 for instruction: %v = call <16 x i32> @llvm.fshl.v16i32(<16 x i32> %va, <16 x i32> %vb, <16 x i32> %vc)
; SIZE_LATE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
  %s = call i32 @llvm.fshl.i32(i32 %a, i32 %b, i32 %c)
  %v = call <16 x i32> @llvm.fshl.v16i32(<16 x i32> %va, <16 x i32> %vb, <16 x i32> %vc)
  ret void
}

define void @maskedgather(<16 x ptr> %va, <16 x i1> %vb, <16 x float> %vc) {
; THRU-LABEL: 'maskedgather'
; THRU-NEXT:  Cost Model: Found an estimated cost of 61 for instruction: %v = call <16 x float> @llvm.masked.gather.v16f32.v16p0(<16 x ptr> %va, i32 1, <16 x i1> %vb, <16 x float> %vc)
; THRU-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
; LATE-LABEL: 'maskedgather'
; LATE-NEXT:  Cost Model: Found an estimated cost of 77 for instruction: %v = call <16 x float> @llvm.masked.gather.v16f32.v16p0(<16 x ptr> %va, i32 1, <16 x i1> %vb, <16 x float> %vc)
; LATE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; SIZE-LABEL: 'maskedgather'
; SIZE-NEXT:  Cost Model: Found an estimated cost of 77 for instruction: %v = call <16 x float> @llvm.masked.gather.v16f32.v16p0(<16 x ptr> %va, i32 1, <16 x i1> %vb, <16 x float> %vc)
; SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; SIZE_LATE-LABEL: 'maskedgather'
; SIZE_LATE-NEXT:  Cost Model: Found an estimated cost of 77 for instruction: %v = call <16 x float> @llvm.masked.gather.v16f32.v16p0(<16 x ptr> %va, i32 1, <16 x i1> %vb, <16 x float> %vc)
; SIZE_LATE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
  %v = call <16 x float> @llvm.masked.gather.v16f32.v16p0(<16 x ptr> %va, i32 1, <16 x i1> %vb, <16 x float> %vc)
  ret void
}

define void @maskedscatter(<16 x float> %va, <16 x ptr> %vb, <16 x i1> %vc) {
; THRU-LABEL: 'maskedscatter'
; THRU-NEXT:  Cost Model: Found an estimated cost of 61 for instruction: call void @llvm.masked.scatter.v16f32.v16p0(<16 x float> %va, <16 x ptr> %vb, i32 1, <16 x i1> %vc)
; THRU-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
; LATE-LABEL: 'maskedscatter'
; LATE-NEXT:  Cost Model: Found an estimated cost of 77 for instruction: call void @llvm.masked.scatter.v16f32.v16p0(<16 x float> %va, <16 x ptr> %vb, i32 1, <16 x i1> %vc)
; LATE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; SIZE-LABEL: 'maskedscatter'
; SIZE-NEXT:  Cost Model: Found an estimated cost of 77 for instruction: call void @llvm.masked.scatter.v16f32.v16p0(<16 x float> %va, <16 x ptr> %vb, i32 1, <16 x i1> %vc)
; SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; SIZE_LATE-LABEL: 'maskedscatter'
; SIZE_LATE-NEXT:  Cost Model: Found an estimated cost of 77 for instruction: call void @llvm.masked.scatter.v16f32.v16p0(<16 x float> %va, <16 x ptr> %vb, i32 1, <16 x i1> %vc)
; SIZE_LATE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
  call void @llvm.masked.scatter.v16f32.v16p0(<16 x float> %va, <16 x ptr> %vb, i32 1, <16 x i1> %vc)
  ret void
}

define void @reduce_fmax(<16 x float> %va) {
; THRU-LABEL: 'reduce_fmax'
; THRU-NEXT:  Cost Model: Found an estimated cost of 22 for instruction: %v = call float @llvm.vector.reduce.fmax.v16f32(<16 x float> %va)
; THRU-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
; LATE-LABEL: 'reduce_fmax'
; LATE-NEXT:  Cost Model: Found an estimated cost of 32 for instruction: %v = call float @llvm.vector.reduce.fmax.v16f32(<16 x float> %va)
; LATE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; SIZE-LABEL: 'reduce_fmax'
; SIZE-NEXT:  Cost Model: Found an estimated cost of 32 for instruction: %v = call float @llvm.vector.reduce.fmax.v16f32(<16 x float> %va)
; SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; SIZE_LATE-LABEL: 'reduce_fmax'
; SIZE_LATE-NEXT:  Cost Model: Found an estimated cost of 32 for instruction: %v = call float @llvm.vector.reduce.fmax.v16f32(<16 x float> %va)
; SIZE_LATE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
  %v = call float @llvm.vector.reduce.fmax.v16f32(<16 x float> %va)
  ret void
}

define void @reduce_fmul(<16 x float> %va) {
; THRU-LABEL: 'reduce_fmul'
; THRU-NEXT:  Cost Model: Found an estimated cost of 44 for instruction: %v = call float @llvm.vector.reduce.fmul.v16f32(float 4.200000e+01, <16 x float> %va)
; THRU-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
; LATE-LABEL: 'reduce_fmul'
; LATE-NEXT:  Cost Model: Found an estimated cost of 92 for instruction: %v = call float @llvm.vector.reduce.fmul.v16f32(float 4.200000e+01, <16 x float> %va)
; LATE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; SIZE-LABEL: 'reduce_fmul'
; SIZE-NEXT:  Cost Model: Found an estimated cost of 28 for instruction: %v = call float @llvm.vector.reduce.fmul.v16f32(float 4.200000e+01, <16 x float> %va)
; SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; SIZE_LATE-LABEL: 'reduce_fmul'
; SIZE_LATE-NEXT:  Cost Model: Found an estimated cost of 28 for instruction: %v = call float @llvm.vector.reduce.fmul.v16f32(float 4.200000e+01, <16 x float> %va)
; SIZE_LATE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
  %v = call float @llvm.vector.reduce.fmul.v16f32(float 42.0, <16 x float> %va)
  ret void
}

define void @reduce_fadd_fast(<16 x float> %va) {
; THRU-LABEL: 'reduce_fadd_fast'
; THRU-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %v = call fast float @llvm.vector.reduce.fadd.v16f32(float 0.000000e+00, <16 x float> %va)
; THRU-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
; LATE-LABEL: 'reduce_fadd_fast'
; LATE-NEXT:  Cost Model: Found an estimated cost of 13 for instruction: %v = call fast float @llvm.vector.reduce.fadd.v16f32(float 0.000000e+00, <16 x float> %va)
; LATE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; SIZE-LABEL: 'reduce_fadd_fast'
; SIZE-NEXT:  Cost Model: Found an estimated cost of 7 for instruction: %v = call fast float @llvm.vector.reduce.fadd.v16f32(float 0.000000e+00, <16 x float> %va)
; SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; SIZE_LATE-LABEL: 'reduce_fadd_fast'
; SIZE_LATE-NEXT:  Cost Model: Found an estimated cost of 7 for instruction: %v = call fast float @llvm.vector.reduce.fadd.v16f32(float 0.000000e+00, <16 x float> %va)
; SIZE_LATE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
  %v = call fast float @llvm.vector.reduce.fadd.v16f32(float 0.0, <16 x float> %va)
  ret void
}

define void @memcpy(ptr %a, ptr %b, i32 %c) {
; THRU-LABEL: 'memcpy'
; THRU-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: call void @llvm.memcpy.p0.p0.i32(ptr align 1 %a, ptr align 1 %b, i32 32, i1 false)
; THRU-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
; LATE-LABEL: 'memcpy'
; LATE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: call void @llvm.memcpy.p0.p0.i32(ptr align 1 %a, ptr align 1 %b, i32 32, i1 false)
; LATE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; SIZE-LABEL: 'memcpy'
; SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: call void @llvm.memcpy.p0.p0.i32(ptr align 1 %a, ptr align 1 %b, i32 32, i1 false)
; SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; SIZE_LATE-LABEL: 'memcpy'
; SIZE_LATE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: call void @llvm.memcpy.p0.p0.i32(ptr align 1 %a, ptr align 1 %b, i32 32, i1 false)
; SIZE_LATE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
  call void @llvm.memcpy.p0.p0.i32(ptr align 1 %a, ptr align 1 %b, i32 32, i1 false)
  ret void
}
