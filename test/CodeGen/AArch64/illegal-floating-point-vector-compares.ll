; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64 < %s | FileCheck %s

; All tests are doing unordered vector comparisons on vectors larger than a
; Neon vector.

define i1 @unordered_floating_point_compare_on_v8f32(<8 x float> %a_vec) {
; CHECK-LABEL: unordered_floating_point_compare_on_v8f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fcmgt v1.4s, v1.4s, #0.0
; CHECK-NEXT:    fcmgt v0.4s, v0.4s, #0.0
; CHECK-NEXT:    mov w8, #1 // =0x1
; CHECK-NEXT:    uzp1 v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    mvn v0.16b, v0.16b
; CHECK-NEXT:    xtn v0.8b, v0.8h
; CHECK-NEXT:    umaxv b0, v0.8b
; CHECK-NEXT:    fmov w9, s0
; CHECK-NEXT:    bic w0, w8, w9
; CHECK-NEXT:    ret
  %a_cmp = fcmp ule <8 x float> %a_vec, zeroinitializer
  %cmp_result = bitcast <8 x i1> %a_cmp to i8
  %all_zero = icmp eq i8 %cmp_result, 0
  ret i1 %all_zero
}

define i1 @unordered_floating_point_compare_on_v16f32(<16 x float> %a_vec) {
; CHECK-LABEL: unordered_floating_point_compare_on_v16f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fcmgt v3.4s, v3.4s, #0.0
; CHECK-NEXT:    fcmgt v2.4s, v2.4s, #0.0
; CHECK-NEXT:    mov w9, #1 // =0x1
; CHECK-NEXT:    fcmgt v1.4s, v1.4s, #0.0
; CHECK-NEXT:    fcmgt v0.4s, v0.4s, #0.0
; CHECK-NEXT:    uzp1 v2.8h, v2.8h, v3.8h
; CHECK-NEXT:    uzp1 v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    uzp1 v0.16b, v0.16b, v2.16b
; CHECK-NEXT:    mvn v0.16b, v0.16b
; CHECK-NEXT:    umaxv b0, v0.16b
; CHECK-NEXT:    fmov w8, s0
; CHECK-NEXT:    bic w0, w9, w8
; CHECK-NEXT:    ret
  %a_cmp = fcmp ule <16 x float> %a_vec, zeroinitializer
  %cmp_result = bitcast <16 x i1> %a_cmp to i16
  %all_zero = icmp eq i16 %cmp_result, 0
  ret i1 %all_zero
}

define i1 @unordered_floating_point_compare_on_v32f32(<32 x float> %a_vec) {
; CHECK-LABEL: unordered_floating_point_compare_on_v32f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fcmgt v3.4s, v3.4s, #0.0
; CHECK-NEXT:    fcmgt v2.4s, v2.4s, #0.0
; CHECK-NEXT:    mov w9, #1 // =0x1
; CHECK-NEXT:    fcmgt v1.4s, v1.4s, #0.0
; CHECK-NEXT:    fcmgt v0.4s, v0.4s, #0.0
; CHECK-NEXT:    fcmgt v7.4s, v7.4s, #0.0
; CHECK-NEXT:    fcmgt v6.4s, v6.4s, #0.0
; CHECK-NEXT:    fcmgt v5.4s, v5.4s, #0.0
; CHECK-NEXT:    fcmgt v4.4s, v4.4s, #0.0
; CHECK-NEXT:    uzp1 v2.8h, v2.8h, v3.8h
; CHECK-NEXT:    uzp1 v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    uzp1 v1.8h, v6.8h, v7.8h
; CHECK-NEXT:    uzp1 v3.8h, v4.8h, v5.8h
; CHECK-NEXT:    uzp1 v0.16b, v0.16b, v2.16b
; CHECK-NEXT:    uzp1 v1.16b, v3.16b, v1.16b
; CHECK-NEXT:    mvn v0.16b, v0.16b
; CHECK-NEXT:    orn v0.16b, v0.16b, v1.16b
; CHECK-NEXT:    shl v0.16b, v0.16b, #7
; CHECK-NEXT:    cmlt v0.16b, v0.16b, #0
; CHECK-NEXT:    umaxv b0, v0.16b
; CHECK-NEXT:    fmov w8, s0
; CHECK-NEXT:    bic w0, w9, w8
; CHECK-NEXT:    ret
  %a_cmp = fcmp ule <32 x float> %a_vec, zeroinitializer
  %cmp_result = bitcast <32 x i1> %a_cmp to i32
  %all_zero = icmp eq i32 %cmp_result, 0
  ret i1 %all_zero
}
