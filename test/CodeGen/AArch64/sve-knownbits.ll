; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve -verify-machineinstrs < %s | FileCheck %s

define <vscale x 8 x i16> @test_knownzero(<vscale x 8 x i16> %x) {
; CHECK-LABEL: test_knownzero:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.h, #0 // =0x0
; CHECK-NEXT:    ret
  %a1 = shl <vscale x 8 x i16> %x, splat (i16 8)
  %a2 = and <vscale x 8 x i16> %a1, splat (i16 8)
  ret <vscale x 8 x i16> %a2
}

define <vscale x 4 x i32> @asrlsr(<vscale x 4 x i64> %va) {
; CHECK-LABEL: asrlsr:
; CHECK:       // %bb.0:
; CHECK-NEXT:    lsr z1.d, z1.d, #15
; CHECK-NEXT:    lsr z0.d, z0.d, #15
; CHECK-NEXT:    uzp1 z0.s, z0.s, z1.s
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 4 x i32> poison, i32 15, i32 0
  %splat = shufflevector <vscale x 4 x i32> %head, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  %vb = zext <vscale x 4 x i32> %splat to <vscale x 4 x i64>
  %x = ashr <vscale x 4 x i64> %va, %vb
  %y = trunc <vscale x 4 x i64> %x to <vscale x 4 x i32>
  ret <vscale x 4 x i32> %y
}
