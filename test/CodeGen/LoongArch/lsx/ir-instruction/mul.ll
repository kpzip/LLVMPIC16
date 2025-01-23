; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 4
; RUN: llc --mtriple=loongarch64 --mattr=+lsx < %s | FileCheck %s

define void @mul_v16i8(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: mul_v16i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vld $vr0, $a1, 0
; CHECK-NEXT:    vld $vr1, $a2, 0
; CHECK-NEXT:    vmul.b $vr0, $vr0, $vr1
; CHECK-NEXT:    vst $vr0, $a0, 0
; CHECK-NEXT:    ret
entry:
  %v0 = load <16 x i8>, ptr %a0
  %v1 = load <16 x i8>, ptr %a1
  %v2 = mul <16 x i8> %v0, %v1
  store <16 x i8> %v2, ptr %res
  ret void
}

define void @mul_v8i16(ptr %res, ptr %a0, ptr %a1)  nounwind {
; CHECK-LABEL: mul_v8i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vld $vr0, $a1, 0
; CHECK-NEXT:    vld $vr1, $a2, 0
; CHECK-NEXT:    vmul.h $vr0, $vr0, $vr1
; CHECK-NEXT:    vst $vr0, $a0, 0
; CHECK-NEXT:    ret
entry:
  %v0 = load <8 x i16>, ptr %a0
  %v1 = load <8 x i16>, ptr %a1
  %v2 = mul <8 x i16> %v0, %v1
  store <8 x i16> %v2, ptr %res
  ret void
}

define void @mul_v4i32(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: mul_v4i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vld $vr0, $a1, 0
; CHECK-NEXT:    vld $vr1, $a2, 0
; CHECK-NEXT:    vmul.w $vr0, $vr0, $vr1
; CHECK-NEXT:    vst $vr0, $a0, 0
; CHECK-NEXT:    ret
entry:
  %v0 = load <4 x i32>, ptr %a0
  %v1 = load <4 x i32>, ptr %a1
  %v2 = mul <4 x i32> %v0, %v1
  store <4 x i32> %v2, ptr %res
  ret void
}

define void @mul_v2i64(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: mul_v2i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vld $vr0, $a1, 0
; CHECK-NEXT:    vld $vr1, $a2, 0
; CHECK-NEXT:    vmul.d $vr0, $vr0, $vr1
; CHECK-NEXT:    vst $vr0, $a0, 0
; CHECK-NEXT:    ret
entry:
  %v0 = load <2 x i64>, ptr %a0
  %v1 = load <2 x i64>, ptr %a1
  %v2 = mul <2 x i64> %v0, %v1
  store <2 x i64> %v2, ptr %res
  ret void
}

define void @mul_square_v16i8(ptr %res, ptr %a0) nounwind {
; CHECK-LABEL: mul_square_v16i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vld $vr0, $a1, 0
; CHECK-NEXT:    vmul.b $vr0, $vr0, $vr0
; CHECK-NEXT:    vst $vr0, $a0, 0
; CHECK-NEXT:    ret
entry:
  %v0 = load <16 x i8>, ptr %a0
  %v1 = mul <16 x i8> %v0, %v0
  store <16 x i8> %v1, ptr %res
  ret void
}

define void @mul_square_v8i16(ptr %res, ptr %a0)  nounwind {
; CHECK-LABEL: mul_square_v8i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vld $vr0, $a1, 0
; CHECK-NEXT:    vmul.h $vr0, $vr0, $vr0
; CHECK-NEXT:    vst $vr0, $a0, 0
; CHECK-NEXT:    ret
entry:
  %v0 = load <8 x i16>, ptr %a0
  %v1 = mul <8 x i16> %v0, %v0
  store <8 x i16> %v1, ptr %res
  ret void
}

define void @mul_square_v4i32(ptr %res, ptr %a0) nounwind {
; CHECK-LABEL: mul_square_v4i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vld $vr0, $a1, 0
; CHECK-NEXT:    vmul.w $vr0, $vr0, $vr0
; CHECK-NEXT:    vst $vr0, $a0, 0
; CHECK-NEXT:    ret
entry:
  %v0 = load <4 x i32>, ptr %a0
  %v1 = mul <4 x i32> %v0, %v0
  store <4 x i32> %v1, ptr %res
  ret void
}

define void @mul_square_v2i64(ptr %res, ptr %a0) nounwind {
; CHECK-LABEL: mul_square_v2i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vld $vr0, $a1, 0
; CHECK-NEXT:    vmul.d $vr0, $vr0, $vr0
; CHECK-NEXT:    vst $vr0, $a0, 0
; CHECK-NEXT:    ret
entry:
  %v0 = load <2 x i64>, ptr %a0
  %v1 = mul <2 x i64> %v0, %v0
  store <2 x i64> %v1, ptr %res
  ret void
}

define void @mul_v16i8_8(ptr %res, ptr %a0) nounwind {
; CHECK-LABEL: mul_v16i8_8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vld $vr0, $a1, 0
; CHECK-NEXT:    vslli.b $vr0, $vr0, 3
; CHECK-NEXT:    vst $vr0, $a0, 0
; CHECK-NEXT:    ret
entry:
  %v0 = load <16 x i8>, ptr %a0
  %v1 = mul <16 x i8> %v0, <i8 8, i8 8, i8 8, i8 8, i8 8, i8 8, i8 8, i8 8, i8 8, i8 8, i8 8, i8 8, i8 8, i8 8, i8 8, i8 8>
  store <16 x i8> %v1, ptr %res
  ret void
}

define void @mul_v8i16_8(ptr %res, ptr %a0)  nounwind {
; CHECK-LABEL: mul_v8i16_8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vld $vr0, $a1, 0
; CHECK-NEXT:    vslli.h $vr0, $vr0, 3
; CHECK-NEXT:    vst $vr0, $a0, 0
; CHECK-NEXT:    ret
entry:
  %v0 = load <8 x i16>, ptr %a0
  %v1 = mul <8 x i16> %v0, <i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8>
  store <8 x i16> %v1, ptr %res
  ret void
}

define void @mul_v4i32_8(ptr %res, ptr %a0) nounwind {
; CHECK-LABEL: mul_v4i32_8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vld $vr0, $a1, 0
; CHECK-NEXT:    vslli.w $vr0, $vr0, 3
; CHECK-NEXT:    vst $vr0, $a0, 0
; CHECK-NEXT:    ret
entry:
  %v0 = load <4 x i32>, ptr %a0
  %v1 = mul <4 x i32> %v0, <i32 8, i32 8, i32 8, i32 8>
  store <4 x i32> %v1, ptr %res
  ret void
}

define void @mul_v2i64_8(ptr %res, ptr %a0) nounwind {
; CHECK-LABEL: mul_v2i64_8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vld $vr0, $a1, 0
; CHECK-NEXT:    vslli.d $vr0, $vr0, 3
; CHECK-NEXT:    vst $vr0, $a0, 0
; CHECK-NEXT:    ret
entry:
  %v0 = load <2 x i64>, ptr %a0
  %v1 = mul <2 x i64> %v0, <i64 8, i64 8>
  store <2 x i64> %v1, ptr %res
  ret void
}

define void @mul_v16i8_17(ptr %res, ptr %a0) nounwind {
; CHECK-LABEL: mul_v16i8_17:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vld $vr0, $a1, 0
; CHECK-NEXT:    vrepli.b $vr1, 17
; CHECK-NEXT:    vmul.b $vr0, $vr0, $vr1
; CHECK-NEXT:    vst $vr0, $a0, 0
; CHECK-NEXT:    ret
entry:
  %v0 = load <16 x i8>, ptr %a0
  %v1 = mul <16 x i8> %v0, <i8 17, i8 17, i8 17, i8 17, i8 17, i8 17, i8 17, i8 17, i8 17, i8 17, i8 17, i8 17, i8 17, i8 17, i8 17, i8 17>
  store <16 x i8> %v1, ptr %res
  ret void
}

define void @mul_v8i16_17(ptr %res, ptr %a0) nounwind {
; CHECK-LABEL: mul_v8i16_17:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vld $vr0, $a1, 0
; CHECK-NEXT:    vrepli.h $vr1, 17
; CHECK-NEXT:    vmul.h $vr0, $vr0, $vr1
; CHECK-NEXT:    vst $vr0, $a0, 0
; CHECK-NEXT:    ret
entry:
  %v0 = load <8 x i16>, ptr %a0
  %v1 = mul <8 x i16> %v0, <i16 17, i16 17, i16 17, i16 17, i16 17, i16 17, i16 17, i16 17>
  store <8 x i16> %v1, ptr %res
  ret void
}

define void @mul_v4i32_17(ptr %res, ptr %a0) nounwind {
; CHECK-LABEL: mul_v4i32_17:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vld $vr0, $a1, 0
; CHECK-NEXT:    vrepli.w $vr1, 17
; CHECK-NEXT:    vmul.w $vr0, $vr0, $vr1
; CHECK-NEXT:    vst $vr0, $a0, 0
; CHECK-NEXT:    ret
entry:
  %v0 = load <4 x i32>, ptr %a0
  %v1 = mul <4 x i32> %v0, <i32 17, i32 17, i32 17, i32 17>
  store <4 x i32> %v1, ptr %res
  ret void
}

define void @mul_v2i64_17(ptr %res, ptr %a0) nounwind {
; CHECK-LABEL: mul_v2i64_17:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vld $vr0, $a1, 0
; CHECK-NEXT:    vrepli.d $vr1, 17
; CHECK-NEXT:    vmul.d $vr0, $vr0, $vr1
; CHECK-NEXT:    vst $vr0, $a0, 0
; CHECK-NEXT:    ret
entry:
  %v0 = load <2 x i64>, ptr %a0
  %v1 = mul <2 x i64> %v0, <i64 17, i64 17>
  store <2 x i64> %v1, ptr %res
  ret void
}
