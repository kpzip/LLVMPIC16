; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=instcombine -S -mtriple=thumbv8.1m.main-none-eabi -mattr=+mve.fp -o - %s | FileCheck %s

target datalayout = "e-m:e-p:32:32-Fi8-i64:64-v128:64:128-a:0:32-n32-S64"

; Various patterns testing v8i16

define <8 x i16> @test_shrn_v8i16_t1(<8 x i16> %a, <8 x i16> %b, <4 x i32> %c, <4 x i32> %d) {
; CHECK-LABEL: @test_shrn_v8i16_t1(
; CHECK-NEXT:    [[X:%.*]] = add <8 x i16> [[A:%.*]], <i16 1, i16 poison, i16 1, i16 poison, i16 1, i16 poison, i16 1, i16 poison>
; CHECK-NEXT:    [[Z:%.*]] = call <8 x i16> @llvm.arm.mve.vshrn.v8i16.v4i32(<8 x i16> [[X]], <4 x i32> [[D:%.*]], i32 16, i32 0, i32 0, i32 0, i32 0, i32 1)
; CHECK-NEXT:    ret <8 x i16> [[Z]]
;
  %x = add <8 x i16> %a, <i16 1, i16 -1, i16 1, i16 -1, i16 1, i16 -1, i16 1, i16 -1>
  %z = call <8 x i16> @llvm.arm.mve.vshrn.v8i16.v4i32(<8 x i16> %x, <4 x i32> %d, i32 16, i32 0, i32 0, i32 0, i32 0, i32 1)
  ret <8 x i16> %z
}

define <8 x i16> @test_shrn_v8i16_t2(<8 x i16> %a, <8 x i16> %b, <4 x i32> %c, <4 x i32> %d) {
; CHECK-LABEL: @test_shrn_v8i16_t2(
; CHECK-NEXT:    [[X:%.*]] = add <8 x i16> [[A:%.*]], <i16 -1, i16 poison, i16 -1, i16 poison, i16 -1, i16 poison, i16 -1, i16 poison>
; CHECK-NEXT:    [[Z:%.*]] = call <8 x i16> @llvm.arm.mve.vshrn.v8i16.v4i32(<8 x i16> [[X]], <4 x i32> [[D:%.*]], i32 16, i32 0, i32 0, i32 0, i32 0, i32 1)
; CHECK-NEXT:    ret <8 x i16> [[Z]]
;
  %x = add <8 x i16> %a, <i16 -1, i16 1, i16 -1, i16 1, i16 -1, i16 1, i16 -1, i16 1>
  %z = call <8 x i16> @llvm.arm.mve.vshrn.v8i16.v4i32(<8 x i16> %x, <4 x i32> %d, i32 16, i32 0, i32 0, i32 0, i32 0, i32 1)
  ret <8 x i16> %z
}

define <8 x i16> @test_shrn_v8i16_b1(<8 x i16> %a, <8 x i16> %b, <4 x i32> %c, <4 x i32> %d) {
; CHECK-LABEL: @test_shrn_v8i16_b1(
; CHECK-NEXT:    [[X:%.*]] = add <8 x i16> [[A:%.*]], <i16 poison, i16 -1, i16 poison, i16 -1, i16 poison, i16 -1, i16 poison, i16 -1>
; CHECK-NEXT:    [[Z:%.*]] = call <8 x i16> @llvm.arm.mve.vshrn.v8i16.v4i32(<8 x i16> [[X]], <4 x i32> [[D:%.*]], i32 16, i32 0, i32 0, i32 0, i32 0, i32 0)
; CHECK-NEXT:    ret <8 x i16> [[Z]]
;
  %x = add <8 x i16> %a, <i16 1, i16 -1, i16 1, i16 -1, i16 1, i16 -1, i16 1, i16 -1>
  %z = call <8 x i16> @llvm.arm.mve.vshrn.v8i16.v4i32(<8 x i16> %x, <4 x i32> %d, i32 16, i32 0, i32 0, i32 0, i32 0, i32 0)
  ret <8 x i16> %z
}

define <8 x i16> @test_shrn_v8i16_b2(<8 x i16> %a, <8 x i16> %b, <4 x i32> %c, <4 x i32> %d) {
; CHECK-LABEL: @test_shrn_v8i16_b2(
; CHECK-NEXT:    [[X:%.*]] = add <8 x i16> [[A:%.*]], <i16 poison, i16 1, i16 poison, i16 1, i16 poison, i16 1, i16 poison, i16 1>
; CHECK-NEXT:    [[Z:%.*]] = call <8 x i16> @llvm.arm.mve.vshrn.v8i16.v4i32(<8 x i16> [[X]], <4 x i32> [[D:%.*]], i32 16, i32 0, i32 0, i32 0, i32 0, i32 0)
; CHECK-NEXT:    ret <8 x i16> [[Z]]
;
  %x = add <8 x i16> %a, <i16 -1, i16 1, i16 -1, i16 1, i16 -1, i16 1, i16 -1, i16 1>
  %z = call <8 x i16> @llvm.arm.mve.vshrn.v8i16.v4i32(<8 x i16> %x, <4 x i32> %d, i32 16, i32 0, i32 0, i32 0, i32 0, i32 0)
  ret <8 x i16> %z
}

define <8 x i16> @test_shrn_v8i16_bt(<8 x i16> %a, <8 x i16> %b, <4 x i32> %c, <4 x i32> %d) {
; CHECK-LABEL: @test_shrn_v8i16_bt(
; CHECK-NEXT:    [[Y:%.*]] = call <8 x i16> @llvm.arm.mve.vshrn.v8i16.v4i32(<8 x i16> poison, <4 x i32> [[C:%.*]], i32 16, i32 0, i32 0, i32 0, i32 0, i32 0)
; CHECK-NEXT:    [[Z:%.*]] = call <8 x i16> @llvm.arm.mve.vshrn.v8i16.v4i32(<8 x i16> [[Y]], <4 x i32> [[D:%.*]], i32 16, i32 0, i32 0, i32 0, i32 0, i32 1)
; CHECK-NEXT:    ret <8 x i16> [[Z]]
;
  %x = add <8 x i16> %a, %b
  %y = call <8 x i16> @llvm.arm.mve.vshrn.v8i16.v4i32(<8 x i16> %x, <4 x i32> %c, i32 16, i32 0, i32 0, i32 0, i32 0, i32 0)
  %z = call <8 x i16> @llvm.arm.mve.vshrn.v8i16.v4i32(<8 x i16> %y, <4 x i32> %d, i32 16, i32 0, i32 0, i32 0, i32 0, i32 1)
  ret <8 x i16> %z
}

define <8 x i16> @test_shrn_v8i16_tb(<8 x i16> %a, <8 x i16> %b, <4 x i32> %c, <4 x i32> %d) {
; CHECK-LABEL: @test_shrn_v8i16_tb(
; CHECK-NEXT:    [[Y:%.*]] = call <8 x i16> @llvm.arm.mve.vshrn.v8i16.v4i32(<8 x i16> poison, <4 x i32> [[C:%.*]], i32 16, i32 0, i32 0, i32 0, i32 0, i32 1)
; CHECK-NEXT:    [[Z:%.*]] = call <8 x i16> @llvm.arm.mve.vshrn.v8i16.v4i32(<8 x i16> [[Y]], <4 x i32> [[D:%.*]], i32 16, i32 0, i32 0, i32 0, i32 0, i32 0)
; CHECK-NEXT:    ret <8 x i16> [[Z]]
;
  %x = add <8 x i16> %a, %b
  %y = call <8 x i16> @llvm.arm.mve.vshrn.v8i16.v4i32(<8 x i16> %x, <4 x i32> %c, i32 16, i32 0, i32 0, i32 0, i32 0, i32 1)
  %z = call <8 x i16> @llvm.arm.mve.vshrn.v8i16.v4i32(<8 x i16> %y, <4 x i32> %d, i32 16, i32 0, i32 0, i32 0, i32 0, i32 0)
  ret <8 x i16> %z
}

define <8 x i16> @test_shrn_v8i16_bb(<8 x i16> %a, <8 x i16> %b, <4 x i32> %c, <4 x i32> %d) {
; CHECK-LABEL: @test_shrn_v8i16_bb(
; CHECK-NEXT:    [[X:%.*]] = add <8 x i16> [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[Y:%.*]] = call <8 x i16> @llvm.arm.mve.vshrn.v8i16.v4i32(<8 x i16> [[X]], <4 x i32> [[C:%.*]], i32 16, i32 0, i32 0, i32 0, i32 0, i32 0)
; CHECK-NEXT:    [[Z:%.*]] = call <8 x i16> @llvm.arm.mve.vshrn.v8i16.v4i32(<8 x i16> [[Y]], <4 x i32> [[D:%.*]], i32 16, i32 0, i32 0, i32 0, i32 0, i32 0)
; CHECK-NEXT:    ret <8 x i16> [[Z]]
;
  %x = add <8 x i16> %a, %b
  %y = call <8 x i16> @llvm.arm.mve.vshrn.v8i16.v4i32(<8 x i16> %x, <4 x i32> %c, i32 16, i32 0, i32 0, i32 0, i32 0, i32 0)
  %z = call <8 x i16> @llvm.arm.mve.vshrn.v8i16.v4i32(<8 x i16> %y, <4 x i32> %d, i32 16, i32 0, i32 0, i32 0, i32 0, i32 0)
  ret <8 x i16> %z
}

define <8 x i16> @test_shrn_v8i16_tt(<8 x i16> %a, <8 x i16> %b, <4 x i32> %c, <4 x i32> %d) {
; CHECK-LABEL: @test_shrn_v8i16_tt(
; CHECK-NEXT:    [[X:%.*]] = add <8 x i16> [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[Y:%.*]] = call <8 x i16> @llvm.arm.mve.vshrn.v8i16.v4i32(<8 x i16> [[X]], <4 x i32> [[C:%.*]], i32 16, i32 0, i32 0, i32 0, i32 0, i32 1)
; CHECK-NEXT:    [[Z:%.*]] = call <8 x i16> @llvm.arm.mve.vshrn.v8i16.v4i32(<8 x i16> [[Y]], <4 x i32> [[D:%.*]], i32 16, i32 0, i32 0, i32 0, i32 0, i32 1)
; CHECK-NEXT:    ret <8 x i16> [[Z]]
;
  %x = add <8 x i16> %a, %b
  %y = call <8 x i16> @llvm.arm.mve.vshrn.v8i16.v4i32(<8 x i16> %x, <4 x i32> %c, i32 16, i32 0, i32 0, i32 0, i32 0, i32 1)
  %z = call <8 x i16> @llvm.arm.mve.vshrn.v8i16.v4i32(<8 x i16> %y, <4 x i32> %d, i32 16, i32 0, i32 0, i32 0, i32 0, i32 1)
  ret <8 x i16> %z
}

; Other types and sizes

define <16 x i8> @test_shrn_v16i8_bt(<16 x i8> %a, <16 x i8> %b, <8 x i16> %c, <8 x i16> %d) {
; CHECK-LABEL: @test_shrn_v16i8_bt(
; CHECK-NEXT:    [[Y:%.*]] = call <16 x i8> @llvm.arm.mve.vshrn.v16i8.v8i16(<16 x i8> poison, <8 x i16> [[C:%.*]], i32 16, i32 0, i32 0, i32 0, i32 0, i32 0)
; CHECK-NEXT:    [[Z:%.*]] = call <16 x i8> @llvm.arm.mve.vshrn.v16i8.v8i16(<16 x i8> [[Y]], <8 x i16> [[D:%.*]], i32 16, i32 0, i32 0, i32 0, i32 0, i32 1)
; CHECK-NEXT:    ret <16 x i8> [[Z]]
;
  %x = add <16 x i8> %a, %b
  %y = call <16 x i8> @llvm.arm.mve.vshrn.v16i8.v8i16(<16 x i8> %x, <8 x i16> %c, i32 16, i32 0, i32 0, i32 0, i32 0, i32 0)
  %z = call <16 x i8> @llvm.arm.mve.vshrn.v16i8.v8i16(<16 x i8> %y, <8 x i16> %d, i32 16, i32 0, i32 0, i32 0, i32 0, i32 1)
  ret <16 x i8> %z
}

define <8 x i16> @test_shrnp_v8i16_bt(<8 x i16> %a, <8 x i16> %b, <4 x i32> %c, <4 x i32> %d, <4 x i1> %p) {
; CHECK-LABEL: @test_shrnp_v8i16_bt(
; CHECK-NEXT:    [[X:%.*]] = add <8 x i16> [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[Y:%.*]] = call <8 x i16> @llvm.arm.mve.vshrn.predicated.v8i16.v4i32.v4i1(<8 x i16> [[X]], <4 x i32> [[C:%.*]], i32 16, i32 0, i32 0, i32 0, i32 0, i32 0, <4 x i1> [[P:%.*]])
; CHECK-NEXT:    [[Z:%.*]] = call <8 x i16> @llvm.arm.mve.vshrn.predicated.v8i16.v4i32.v4i1(<8 x i16> [[Y]], <4 x i32> [[D:%.*]], i32 16, i32 0, i32 0, i32 0, i32 0, i32 1, <4 x i1> [[P]])
; CHECK-NEXT:    ret <8 x i16> [[Z]]
;
  %x = add <8 x i16> %a, %b
  %y = call <8 x i16> @llvm.arm.mve.vshrn.predicated.v8i16.v4i32.v4i1(<8 x i16> %x, <4 x i32> %c, i32 16, i32 0, i32 0, i32 0, i32 0, i32 0, <4 x i1> %p)
  %z = call <8 x i16> @llvm.arm.mve.vshrn.predicated.v8i16.v4i32.v4i1(<8 x i16> %y, <4 x i32> %d, i32 16, i32 0, i32 0, i32 0, i32 0, i32 1, <4 x i1> %p)
  ret <8 x i16> %z
}

define <16 x i8> @test_shrnp_v16i8_bt(<16 x i8> %a, <16 x i8> %b, <8 x i16> %c, <8 x i16> %d, <8 x i1> %p) {
; CHECK-LABEL: @test_shrnp_v16i8_bt(
; CHECK-NEXT:    [[X:%.*]] = add <16 x i8> [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[Y:%.*]] = call <16 x i8> @llvm.arm.mve.vshrn.predicated.v16i8.v8i16.v8i1(<16 x i8> [[X]], <8 x i16> [[C:%.*]], i32 16, i32 0, i32 0, i32 0, i32 0, i32 0, <8 x i1> [[P:%.*]])
; CHECK-NEXT:    [[Z:%.*]] = call <16 x i8> @llvm.arm.mve.vshrn.predicated.v16i8.v8i16.v8i1(<16 x i8> [[Y]], <8 x i16> [[D:%.*]], i32 16, i32 0, i32 0, i32 0, i32 0, i32 1, <8 x i1> [[P]])
; CHECK-NEXT:    ret <16 x i8> [[Z]]
;
  %x = add <16 x i8> %a, %b
  %y = call <16 x i8> @llvm.arm.mve.vshrn.predicated.v16i8.v8i16.v8i1(<16 x i8> %x, <8 x i16> %c, i32 16, i32 0, i32 0, i32 0, i32 0, i32 0, <8 x i1> %p)
  %z = call <16 x i8> @llvm.arm.mve.vshrn.predicated.v16i8.v8i16.v8i1(<16 x i8> %y, <8 x i16> %d, i32 16, i32 0, i32 0, i32 0, i32 0, i32 1, <8 x i1> %p)
  ret <16 x i8> %z
}


define <8 x i16> @test_movnp_v8i16_bt(<8 x i16> %a, <8 x i16> %b, <4 x i32> %c, <4 x i32> %d, <4 x i1> %p) {
; CHECK-LABEL: @test_movnp_v8i16_bt(
; CHECK-NEXT:    [[X:%.*]] = add <8 x i16> [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[Y:%.*]] = call <8 x i16> @llvm.arm.mve.vmovn.predicated.v8i16.v4i32.v4i1(<8 x i16> [[X]], <4 x i32> [[C:%.*]], i32 0, <4 x i1> [[P:%.*]])
; CHECK-NEXT:    [[Z:%.*]] = call <8 x i16> @llvm.arm.mve.vmovn.predicated.v8i16.v4i32.v4i1(<8 x i16> [[Y]], <4 x i32> [[D:%.*]], i32 1, <4 x i1> [[P]])
; CHECK-NEXT:    ret <8 x i16> [[Z]]
;
  %x = add <8 x i16> %a, %b
  %y = call <8 x i16> @llvm.arm.mve.vmovn.predicated.v8i16.v4i32.v4i1(<8 x i16> %x, <4 x i32> %c, i32 0, <4 x i1> %p)
  %z = call <8 x i16> @llvm.arm.mve.vmovn.predicated.v8i16.v4i32.v4i1(<8 x i16> %y, <4 x i32> %d, i32 1, <4 x i1> %p)
  ret <8 x i16> %z
}

define <16 x i8> @test_movnp_v16i8_bt(<16 x i8> %a, <16 x i8> %b, <8 x i16> %c, <8 x i16> %d, <8 x i1> %p) {
; CHECK-LABEL: @test_movnp_v16i8_bt(
; CHECK-NEXT:    [[X:%.*]] = add <16 x i8> [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[Y:%.*]] = call <16 x i8> @llvm.arm.mve.vmovn.predicated.v16i8.v8i16.v8i1(<16 x i8> [[X]], <8 x i16> [[C:%.*]], i32 0, <8 x i1> [[P:%.*]])
; CHECK-NEXT:    [[Z:%.*]] = call <16 x i8> @llvm.arm.mve.vmovn.predicated.v16i8.v8i16.v8i1(<16 x i8> [[Y]], <8 x i16> [[D:%.*]], i32 1, <8 x i1> [[P]])
; CHECK-NEXT:    ret <16 x i8> [[Z]]
;
  %x = add <16 x i8> %a, %b
  %y = call <16 x i8> @llvm.arm.mve.vmovn.predicated.v16i8.v8i16.v8i1(<16 x i8> %x, <8 x i16> %c, i32 0, <8 x i1> %p)
  %z = call <16 x i8> @llvm.arm.mve.vmovn.predicated.v16i8.v8i16.v8i1(<16 x i8> %y, <8 x i16> %d, i32 1, <8 x i1> %p)
  ret <16 x i8> %z
}

define <8 x i16> @test_qmovn_v8i16_bt(<8 x i16> %a, <8 x i16> %b, <4 x i32> %c, <4 x i32> %d) {
; CHECK-LABEL: @test_qmovn_v8i16_bt(
; CHECK-NEXT:    [[Y:%.*]] = call <8 x i16> @llvm.arm.mve.vqmovn.v8i16.v4i32(<8 x i16> poison, <4 x i32> [[C:%.*]], i32 0, i32 0, i32 0)
; CHECK-NEXT:    [[Z:%.*]] = call <8 x i16> @llvm.arm.mve.vqmovn.v8i16.v4i32(<8 x i16> [[Y]], <4 x i32> [[D:%.*]], i32 0, i32 0, i32 1)
; CHECK-NEXT:    ret <8 x i16> [[Z]]
;
  %x = add <8 x i16> %a, %b
  %y = call <8 x i16> @llvm.arm.mve.vqmovn.v8i16.v4i32(<8 x i16> %x, <4 x i32> %c, i32 0, i32 0, i32 0)
  %z = call <8 x i16> @llvm.arm.mve.vqmovn.v8i16.v4i32(<8 x i16> %y, <4 x i32> %d, i32 0, i32 0, i32 1)
  ret <8 x i16> %z
}

define <16 x i8> @test_qmovn_v16i8_bt(<16 x i8> %a, <16 x i8> %b, <8 x i16> %c, <8 x i16> %d) {
; CHECK-LABEL: @test_qmovn_v16i8_bt(
; CHECK-NEXT:    [[Y:%.*]] = call <16 x i8> @llvm.arm.mve.vqmovn.v16i8.v8i16(<16 x i8> poison, <8 x i16> [[C:%.*]], i32 0, i32 0, i32 0)
; CHECK-NEXT:    [[Z:%.*]] = call <16 x i8> @llvm.arm.mve.vqmovn.v16i8.v8i16(<16 x i8> [[Y]], <8 x i16> [[D:%.*]], i32 0, i32 0, i32 1)
; CHECK-NEXT:    ret <16 x i8> [[Z]]
;
  %x = add <16 x i8> %a, %b
  %y = call <16 x i8> @llvm.arm.mve.vqmovn.v16i8.v8i16(<16 x i8> %x, <8 x i16> %c, i32 0, i32 0, i32 0)
  %z = call <16 x i8> @llvm.arm.mve.vqmovn.v16i8.v8i16(<16 x i8> %y, <8 x i16> %d, i32 0, i32 0, i32 1)
  ret <16 x i8> %z
}

define <8 x i16> @test_qmovnp_v8i16_bt(<8 x i16> %a, <8 x i16> %b, <4 x i32> %c, <4 x i32> %d, <4 x i1> %p) {
; CHECK-LABEL: @test_qmovnp_v8i16_bt(
; CHECK-NEXT:    [[X:%.*]] = add <8 x i16> [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[Y:%.*]] = call <8 x i16> @llvm.arm.mve.vqmovn.predicated.v8i16.v4i32.v4i1(<8 x i16> [[X]], <4 x i32> [[C:%.*]], i32 0, i32 0, i32 0, <4 x i1> [[P:%.*]])
; CHECK-NEXT:    [[Z:%.*]] = call <8 x i16> @llvm.arm.mve.vqmovn.predicated.v8i16.v4i32.v4i1(<8 x i16> [[Y]], <4 x i32> [[D:%.*]], i32 0, i32 0, i32 1, <4 x i1> [[P]])
; CHECK-NEXT:    ret <8 x i16> [[Z]]
;
  %x = add <8 x i16> %a, %b
  %y = call <8 x i16> @llvm.arm.mve.vqmovn.predicated.v8i16.v4i32.v4i1(<8 x i16> %x, <4 x i32> %c, i32 0, i32 0, i32 0, <4 x i1> %p)
  %z = call <8 x i16> @llvm.arm.mve.vqmovn.predicated.v8i16.v4i32.v4i1(<8 x i16> %y, <4 x i32> %d, i32 0, i32 0, i32 1, <4 x i1> %p)
  ret <8 x i16> %z
}

define <16 x i8> @test_qmovnp_v16i8_bt(<16 x i8> %a, <16 x i8> %b, <8 x i16> %c, <8 x i16> %d, <8 x i1> %p) {
; CHECK-LABEL: @test_qmovnp_v16i8_bt(
; CHECK-NEXT:    [[X:%.*]] = add <16 x i8> [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[Y:%.*]] = call <16 x i8> @llvm.arm.mve.vqmovn.predicated.v16i8.v8i16.v8i1(<16 x i8> [[X]], <8 x i16> [[C:%.*]], i32 0, i32 0, i32 0, <8 x i1> [[P:%.*]])
; CHECK-NEXT:    [[Z:%.*]] = call <16 x i8> @llvm.arm.mve.vqmovn.predicated.v16i8.v8i16.v8i1(<16 x i8> [[Y]], <8 x i16> [[D:%.*]], i32 0, i32 0, i32 1, <8 x i1> [[P]])
; CHECK-NEXT:    ret <16 x i8> [[Z]]
;
  %x = add <16 x i8> %a, %b
  %y = call <16 x i8> @llvm.arm.mve.vqmovn.predicated.v16i8.v8i16.v8i1(<16 x i8> %x, <8 x i16> %c, i32 0, i32 0, i32 0, <8 x i1> %p)
  %z = call <16 x i8> @llvm.arm.mve.vqmovn.predicated.v16i8.v8i16.v8i1(<16 x i8> %y, <8 x i16> %d, i32 0, i32 0, i32 1, <8 x i1> %p)
  ret <16 x i8> %z
}

define <8 x half> @test_cvtn_v8i16_bt(<8 x half> %a, <8 x half> %b, <4 x float> %c, <4 x float> %d) {
; CHECK-LABEL: @test_cvtn_v8i16_bt(
; CHECK-NEXT:    [[Y:%.*]] = call <8 x half> @llvm.arm.mve.vcvt.narrow(<8 x half> poison, <4 x float> [[C:%.*]], i32 0)
; CHECK-NEXT:    [[Z:%.*]] = call <8 x half> @llvm.arm.mve.vcvt.narrow(<8 x half> [[Y]], <4 x float> [[D:%.*]], i32 1)
; CHECK-NEXT:    ret <8 x half> [[Z]]
;
  %x = fadd <8 x half> %a, %b
  %y = call <8 x half> @llvm.arm.mve.vcvt.narrow(<8 x half> %x, <4 x float> %c, i32 0)
  %z = call <8 x half> @llvm.arm.mve.vcvt.narrow(<8 x half> %y, <4 x float> %d, i32 1)
  ret <8 x half> %z
}

define <8 x half> @test_cvtnp_v8i16_bt(<8 x half> %a, <8 x half> %b, <4 x float> %c, <4 x float> %d, <4 x i1> %p) {
; CHECK-LABEL: @test_cvtnp_v8i16_bt(
; CHECK-NEXT:    [[X:%.*]] = fadd <8 x half> [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[Y:%.*]] = call <8 x half> @llvm.arm.mve.vcvt.narrow.predicated(<8 x half> [[X]], <4 x float> [[C:%.*]], i32 0, <4 x i1> [[P:%.*]])
; CHECK-NEXT:    [[Z:%.*]] = call <8 x half> @llvm.arm.mve.vcvt.narrow.predicated(<8 x half> [[Y]], <4 x float> [[D:%.*]], i32 1, <4 x i1> [[P]])
; CHECK-NEXT:    ret <8 x half> [[Z]]
;
  %x = fadd <8 x half> %a, %b
  %y = call <8 x half> @llvm.arm.mve.vcvt.narrow.predicated(<8 x half> %x, <4 x float> %c, i32 0, <4 x i1> %p)
  %z = call <8 x half> @llvm.arm.mve.vcvt.narrow.predicated(<8 x half> %y, <4 x float> %d, i32 1, <4 x i1> %p)
  ret <8 x half> %z
}

define <4 x i32> @test_vshrn_const(<8 x i16> %a) {
; CHECK-LABEL: @test_vshrn_const(
; CHECK-NEXT:    [[Y:%.*]] = call <8 x i16> @llvm.arm.mve.vshrn.v8i16.v4i32(<8 x i16> poison, <4 x i32> <i32 512, i32 0, i32 0, i32 0>, i32 3, i32 0, i32 0, i32 0, i32 0, i32 1)
; CHECK-NEXT:    [[Z:%.*]] = shufflevector <8 x i16> [[Y]], <8 x i16> poison, <4 x i32> <i32 1, i32 3, i32 5, i32 7>
; CHECK-NEXT:    [[ZA:%.*]] = zext <4 x i16> [[Z]] to <4 x i32>
; CHECK-NEXT:    ret <4 x i32> [[ZA]]
;
  %y = call <8 x i16> @llvm.arm.mve.vshrn.v8i16.v4i32(<8 x i16> %a, <4 x i32> <i32 512, i32 0, i32 0, i32 0>, i32 3, i32 0, i32 0, i32 0, i32 0, i32 1)
  %z = shufflevector <8 x i16> %y, <8 x i16> poison, <4 x i32> <i32 1, i32 3, i32 5, i32 7>
  %za = zext <4 x i16> %z to <4 x i32>
  ret <4 x i32> %za
}

define zeroext i16 @test_undef_bits() {
; CHECK-LABEL: @test_undef_bits(
; CHECK-NEXT:  e:
; CHECK-NEXT:    [[TMP0:%.*]] = call <8 x i16> @llvm.arm.mve.vshrn.v8i16.v4i32(<8 x i16> poison, <4 x i32> <i32 256, i32 0, i32 0, i32 0>, i32 8, i32 1, i32 1, i32 1, i32 0, i32 1)
; CHECK-NEXT:    [[TMP1:%.*]] = shufflevector <8 x i16> [[TMP0]], <8 x i16> poison, <4 x i32> <i32 1, i32 3, i32 5, i32 7>
; CHECK-NEXT:    [[TMP2:%.*]] = zext <4 x i16> [[TMP1]] to <4 x i32>
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast <4 x i32> [[TMP2]] to <8 x i16>
; CHECK-NEXT:    [[TMP4:%.*]] = extractelement <8 x i16> [[TMP3]], i64 0
; CHECK-NEXT:    ret i16 [[TMP4]]
;
e:
  %0 = call <8 x i16> @llvm.arm.mve.vshrn.v8i16.v4i32(<8 x i16> zeroinitializer, <4 x i32> <i32 256, i32 0, i32 0, i32 0>, i32 8, i32 1, i32 1, i32 1, i32 0, i32 1)
  %1 = shufflevector <8 x i16> %0, <8 x i16> poison, <4 x i32> <i32 1, i32 3, i32 5, i32 7>
  %2 = zext <4 x i16> %1 to <4 x i32>
  %3 = bitcast <4 x i32> %2 to <8 x i16>
  %4 = extractelement <8 x i16> %3, i32 0
  ret i16 %4
}

declare <8 x i16> @llvm.arm.mve.vshrn.v8i16.v4i32(<8 x i16>, <4 x i32>, i32, i32, i32, i32, i32, i32)
declare <8 x i16> @llvm.arm.mve.vshrn.predicated.v8i16.v4i32.v4i1(<8 x i16>, <4 x i32>, i32, i32, i32, i32, i32, i32, <4 x i1>)
declare <16 x i8> @llvm.arm.mve.vshrn.v16i8.v8i16(<16 x i8>, <8 x i16>, i32, i32, i32, i32, i32, i32)
declare <16 x i8> @llvm.arm.mve.vshrn.predicated.v16i8.v8i16.v8i1(<16 x i8>, <8 x i16>, i32, i32, i32, i32, i32, i32, <8 x i1>)

declare <8 x i16> @llvm.arm.mve.vmovn.predicated.v8i16.v4i32.v4i1(<8 x i16>, <4 x i32>, i32, <4 x i1>)
declare <16 x i8> @llvm.arm.mve.vmovn.predicated.v16i8.v8i16.v8i1(<16 x i8>, <8 x i16>, i32, <8 x i1>)

declare <8 x i16> @llvm.arm.mve.vqmovn.v8i16.v4i32(<8 x i16>, <4 x i32>, i32, i32, i32)
declare <8 x i16> @llvm.arm.mve.vqmovn.predicated.v8i16.v4i32.v4i1(<8 x i16>, <4 x i32>, i32, i32, i32, <4 x i1>)
declare <16 x i8> @llvm.arm.mve.vqmovn.v16i8.v8i16(<16 x i8>, <8 x i16>, i32, i32, i32)
declare <16 x i8> @llvm.arm.mve.vqmovn.predicated.v16i8.v8i16.v8i1(<16 x i8>, <8 x i16>, i32, i32, i32, <8 x i1>)

declare <8 x half> @llvm.arm.mve.vcvt.narrow(<8 x half>, <4 x float>, i32)
declare <8 x half> @llvm.arm.mve.vcvt.narrow.predicated(<8 x half>, <4 x float>, i32, <4 x i1>)
