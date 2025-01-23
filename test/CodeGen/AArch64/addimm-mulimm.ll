; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs < %s -mtriple=aarch64-linux-gnu | FileCheck %s

define i64 @addimm_mulimm_accept_00(i64 %a) {
; CHECK-LABEL: addimm_mulimm_accept_00:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #37 // =0x25
; CHECK-NEXT:    mov x9, #1147 // =0x47b
; CHECK-NEXT:    madd x0, x0, x8, x9
; CHECK-NEXT:    ret
  %tmp0 = add i64 %a, 31
  %tmp1 = mul i64 %tmp0, 37
  ret i64 %tmp1
}

define i64 @addimm_mulimm_accept_01(i64 %a) {
; CHECK-LABEL: addimm_mulimm_accept_01:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #37 // =0x25
; CHECK-NEXT:    mov x9, #-1147 // =0xfffffffffffffb85
; CHECK-NEXT:    madd x0, x0, x8, x9
; CHECK-NEXT:    ret
  %tmp0 = add i64 %a, -31
  %tmp1 = mul i64 %tmp0, 37
  ret i64 %tmp1
}

define signext i32 @addimm_mulimm_accept_02(i32 signext %a) {
; CHECK-LABEL: addimm_mulimm_accept_02:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #37 // =0x25
; CHECK-NEXT:    mov w9, #1147 // =0x47b
; CHECK-NEXT:    madd w0, w0, w8, w9
; CHECK-NEXT:    ret
  %tmp0 = add i32 %a, 31
  %tmp1 = mul i32 %tmp0, 37
  ret i32 %tmp1
}

define signext i32 @addimm_mulimm_accept_03(i32 signext %a) {
; CHECK-LABEL: addimm_mulimm_accept_03:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #37 // =0x25
; CHECK-NEXT:    mov w9, #-1147 // =0xfffffb85
; CHECK-NEXT:    madd w0, w0, w8, w9
; CHECK-NEXT:    ret
  %tmp0 = add i32 %a, -31
  %tmp1 = mul i32 %tmp0, 37
  ret i32 %tmp1
}

define i64 @addimm_mulimm_accept_10(i64 %a) {
; CHECK-LABEL: addimm_mulimm_accept_10:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #37 // =0x25
; CHECK-NEXT:    mov w9, #32888 // =0x8078
; CHECK-NEXT:    movk w9, #17, lsl #16
; CHECK-NEXT:    madd x0, x0, x8, x9
; CHECK-NEXT:    ret
  %tmp0 = add i64 %a, 31000
  %tmp1 = mul i64 %tmp0, 37
  ret i64 %tmp1
}

define i64 @addimm_mulimm_accept_11(i64 %a) {
; CHECK-LABEL: addimm_mulimm_accept_11:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #37 // =0x25
; CHECK-NEXT:    mov x9, #-32888 // =0xffffffffffff7f88
; CHECK-NEXT:    movk x9, #65518, lsl #16
; CHECK-NEXT:    madd x0, x0, x8, x9
; CHECK-NEXT:    ret
  %tmp0 = add i64 %a, -31000
  %tmp1 = mul i64 %tmp0, 37
  ret i64 %tmp1
}

define signext i32 @addimm_mulimm_accept_12(i32 signext %a) {
; CHECK-LABEL: addimm_mulimm_accept_12:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #37 // =0x25
; CHECK-NEXT:    mov w9, #32888 // =0x8078
; CHECK-NEXT:    movk w9, #17, lsl #16
; CHECK-NEXT:    madd w0, w0, w8, w9
; CHECK-NEXT:    ret
  %tmp0 = add i32 %a, 31000
  %tmp1 = mul i32 %tmp0, 37
  ret i32 %tmp1
}

define signext i32 @addimm_mulimm_accept_13(i32 signext %a) {
; CHECK-LABEL: addimm_mulimm_accept_13:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #37 // =0x25
; CHECK-NEXT:    mov w9, #32648 // =0x7f88
; CHECK-NEXT:    movk w9, #65518, lsl #16
; CHECK-NEXT:    madd w0, w0, w8, w9
; CHECK-NEXT:    ret
  %tmp0 = add i32 %a, -31000
  %tmp1 = mul i32 %tmp0, 37
  ret i32 %tmp1
}

define i64 @addimm_mulimm_reject_00(i64 %a) {
; CHECK-LABEL: addimm_mulimm_reject_00:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #3700 // =0xe74
; CHECK-NEXT:    add x9, x0, #3100
; CHECK-NEXT:    mul x0, x9, x8
; CHECK-NEXT:    ret
  %tmp0 = add i64 %a, 3100
  %tmp1 = mul i64 %tmp0, 3700
  ret i64 %tmp1
}

define i64 @addimm_mulimm_reject_01(i64 %a) {
; CHECK-LABEL: addimm_mulimm_reject_01:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #3700 // =0xe74
; CHECK-NEXT:    sub x9, x0, #3100
; CHECK-NEXT:    mul x0, x9, x8
; CHECK-NEXT:    ret
  %tmp0 = add i64 %a, -3100
  %tmp1 = mul i64 %tmp0, 3700
  ret i64 %tmp1
}

define signext i32 @addimm_mulimm_reject_02(i32 signext %a) {
; CHECK-LABEL: addimm_mulimm_reject_02:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #3700 // =0xe74
; CHECK-NEXT:    add w9, w0, #3100
; CHECK-NEXT:    mul w0, w9, w8
; CHECK-NEXT:    ret
  %tmp0 = add i32 %a, 3100
  %tmp1 = mul i32 %tmp0, 3700
  ret i32 %tmp1
}

define signext i32 @addimm_mulimm_reject_03(i32 signext %a) {
; CHECK-LABEL: addimm_mulimm_reject_03:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #3700 // =0xe74
; CHECK-NEXT:    sub w9, w0, #3100
; CHECK-NEXT:    mul w0, w9, w8
; CHECK-NEXT:    ret
  %tmp0 = add i32 %a, -3100
  %tmp1 = mul i32 %tmp0, 3700
  ret i32 %tmp1
}

define signext i32 @addmuladd(i32 signext %a) {
; CHECK-LABEL: addmuladd:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #324 // =0x144
; CHECK-NEXT:    mov w9, #1300 // =0x514
; CHECK-NEXT:    madd w0, w0, w8, w9
; CHECK-NEXT:    ret
  %tmp0 = add i32 %a, 4
  %tmp1 = mul i32 %tmp0, 324
  %tmp2 = add i32 %tmp1, 4
  ret i32 %tmp2
}

define signext i32 @addmuladd_multiuse(i32 signext %a) {
; CHECK-LABEL: addmuladd_multiuse:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #324 // =0x144
; CHECK-NEXT:    mov w9, #1300 // =0x514
; CHECK-NEXT:    madd w8, w0, w8, w9
; CHECK-NEXT:    add w9, w0, #4
; CHECK-NEXT:    eor w0, w9, w8
; CHECK-NEXT:    ret
  %tmp0 = add i32 %a, 4
  %tmp1 = mul i32 %tmp0, 324
  %tmp2 = add i32 %tmp1, 4
  %tmp3 = xor i32 %tmp0, %tmp2
  ret i32 %tmp3
}

define signext i32 @addmuladd_multiusemul(i32 signext %a) {
; CHECK-LABEL: addmuladd_multiusemul:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #324 // =0x144
; CHECK-NEXT:    mul w8, w0, w8
; CHECK-NEXT:    add w9, w8, #1296
; CHECK-NEXT:    add w8, w8, #1300
; CHECK-NEXT:    eor w0, w9, w8
; CHECK-NEXT:    ret
  %tmp0 = add i32 %a, 4
  %tmp1 = mul i32 %tmp0, 324
  %tmp2 = add i32 %tmp1, 4
  %tmp3 = xor i32 %tmp1, %tmp2
  ret i32 %tmp3
}

define signext i32 @addmuladd_multiuse2(i32 signext %a) {
; CHECK-LABEL: addmuladd_multiuse2:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #324 // =0x144
; CHECK-NEXT:    lsl w9, w0, #2
; CHECK-NEXT:    mov w10, #1300 // =0x514
; CHECK-NEXT:    madd w8, w0, w8, w10
; CHECK-NEXT:    add w9, w9, #20
; CHECK-NEXT:    eor w0, w8, w9
; CHECK-NEXT:    ret
  %tmp0 = add i32 %a, 4
  %tmp1 = mul i32 %tmp0, 4
  %tmp2 = add i32 %tmp1, 4
  %tmp3 = mul i32 %tmp0, 324
  %tmp4 = add i32 %tmp3, 4
  %tmp5 = xor i32 %tmp4, %tmp2
  ret i32 %tmp5
}

define signext i32 @addaddmuladd(i32 signext %a, i32 %b) {
; CHECK-LABEL: addaddmuladd:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #324 // =0x144
; CHECK-NEXT:    madd w8, w0, w8, w1
; CHECK-NEXT:    add w0, w8, #1300
; CHECK-NEXT:    ret
  %tmp0 = add i32 %a, 4
  %tmp1 = mul i32 %tmp0, 324
  %tmp2 = add i32 %tmp1, %b
  %tmp3 = add i32 %tmp2, 4
  ret i32 %tmp3
}

define signext i32 @addaddmuladd_multiuse(i32 signext %a, i32 %b) {
; CHECK-LABEL: addaddmuladd_multiuse:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #324 // =0x144
; CHECK-NEXT:    add w9, w0, #4
; CHECK-NEXT:    madd w8, w0, w8, w1
; CHECK-NEXT:    add w8, w8, #1300
; CHECK-NEXT:    eor w0, w9, w8
; CHECK-NEXT:    ret
  %tmp0 = add i32 %a, 4
  %tmp1 = mul i32 %tmp0, 324
  %tmp2 = add i32 %tmp1, %b
  %tmp3 = add i32 %tmp2, 4
  %tmp4 = xor i32 %tmp0, %tmp3
  ret i32 %tmp4
}

define signext i32 @addaddmuladd_multiuse2(i32 signext %a, i32 %b) {
; CHECK-LABEL: addaddmuladd_multiuse2:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #324 // =0x144
; CHECK-NEXT:    mov w9, #162 // =0xa2
; CHECK-NEXT:    madd w8, w0, w8, w1
; CHECK-NEXT:    madd w9, w0, w9, w1
; CHECK-NEXT:    add w8, w8, #1300
; CHECK-NEXT:    add w9, w9, #652
; CHECK-NEXT:    eor w0, w9, w8
; CHECK-NEXT:    ret
  %tmp0 = add i32 %a, 4
  %tmp1 = mul i32 %tmp0, 324
  %tmp2 = add i32 %tmp1, %b
  %tmp3 = add i32 %tmp2, 4
  %tmp1b = mul i32 %tmp0, 162
  %tmp2b = add i32 %tmp1b, %b
  %tmp3b = add i32 %tmp2b, 4
  %tmp4 = xor i32 %tmp3b, %tmp3
  ret i32 %tmp4
}

define <4 x i32> @addmuladd_vec(<4 x i32> %a) {
; CHECK-LABEL: addmuladd_vec:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #324 // =0x144
; CHECK-NEXT:    mov w9, #1300 // =0x514
; CHECK-NEXT:    dup v2.4s, w8
; CHECK-NEXT:    dup v1.4s, w9
; CHECK-NEXT:    mla v1.4s, v0.4s, v2.4s
; CHECK-NEXT:    mov v0.16b, v1.16b
; CHECK-NEXT:    ret
  %tmp0 = add <4 x i32> %a, <i32 4, i32 4, i32 4, i32 4>
  %tmp1 = mul <4 x i32> %tmp0, <i32 324, i32 324, i32 324, i32 324>
  %tmp2 = add <4 x i32> %tmp1, <i32 4, i32 4, i32 4, i32 4>
  ret <4 x i32> %tmp2
}

define <4 x i32> @addmuladd_vec_multiuse(<4 x i32> %a) {
; CHECK-LABEL: addmuladd_vec_multiuse:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v1.4s, #4
; CHECK-NEXT:    mov w8, #324 // =0x144
; CHECK-NEXT:    dup v2.4s, w8
; CHECK-NEXT:    add v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    mla v1.4s, v0.4s, v2.4s
; CHECK-NEXT:    eor v0.16b, v0.16b, v1.16b
; CHECK-NEXT:    ret
  %tmp0 = add <4 x i32> %a, <i32 4, i32 4, i32 4, i32 4>
  %tmp1 = mul <4 x i32> %tmp0, <i32 324, i32 324, i32 324, i32 324>
  %tmp2 = add <4 x i32> %tmp1, <i32 4, i32 4, i32 4, i32 4>
  %tmp3 = xor <4 x i32> %tmp0, %tmp2
  ret <4 x i32> %tmp3
}

define void @addmuladd_gep(ptr %p, i64 %a) {
; CHECK-LABEL: addmuladd_gep:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #40 // =0x28
; CHECK-NEXT:    str wzr, [x0, #10]!
; CHECK-NEXT:    madd x8, x1, x8, x0
; CHECK-NEXT:    str wzr, [x8, #20]
; CHECK-NEXT:    ret
  %q = getelementptr i8, ptr %p, i64 10
  %r = getelementptr [10 x [10 x i32]], ptr %q, i64 0, i64 %a, i64 5
  store i32 0, ptr %q
  store i32 0, ptr %r
  ret void
}

define i32 @addmuladd_gep2(ptr %p, i32 %a) {
; CHECK-LABEL: addmuladd_gep2:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #3240 // =0xca8
; CHECK-NEXT:    // kill: def $w1 killed $w1 def $x1
; CHECK-NEXT:    smaddl x8, w1, w8, x0
; CHECK-NEXT:    ldr w8, [x8, #3260]
; CHECK-NEXT:    tbnz w8, #31, .LBB22_2
; CHECK-NEXT:  // %bb.1:
; CHECK-NEXT:    mov w0, wzr
; CHECK-NEXT:    ret
; CHECK-NEXT:  .LBB22_2: // %then
; CHECK-NEXT:    sxtw x8, w1
; CHECK-NEXT:    add x8, x8, #1
; CHECK-NEXT:    str x8, [x0]
; CHECK-NEXT:    mov w0, #1 // =0x1
; CHECK-NEXT:    ret
  %b = sext i32 %a to i64
  %c = add nsw i64 %b, 1
  %d = mul nsw i64 %c, 81
  %g = getelementptr [10 x [10 x i32]], ptr %p, i64 0, i64 %d, i64 5
  %l = load i32, ptr %g, align 4
  %cc = icmp slt i32 %l, 0
  br i1 %cc, label %then, label %else
then:
  store i64 %c, ptr %p
  ret i32 1
else:
  ret i32 0
}

define signext i32 @addmuladd_multiuse2_nsw(i32 signext %a) {
; CHECK-LABEL: addmuladd_multiuse2_nsw:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #324 // =0x144
; CHECK-NEXT:    lsl w9, w0, #2
; CHECK-NEXT:    mov w10, #1300 // =0x514
; CHECK-NEXT:    madd w8, w0, w8, w10
; CHECK-NEXT:    add w9, w9, #20
; CHECK-NEXT:    eor w0, w8, w9
; CHECK-NEXT:    ret
  %tmp0 = add nsw i32 %a, 4
  %tmp1 = mul nsw i32 %tmp0, 4
  %tmp2 = add nsw i32 %tmp1, 4
  %tmp3 = mul nsw i32 %tmp0, 324
  %tmp4 = add nsw i32 %tmp3, 4
  %tmp5 = xor i32 %tmp4, %tmp2
  ret i32 %tmp5
}

define signext i32 @addmuladd_multiuse2_nuw(i32 signext %a) {
; CHECK-LABEL: addmuladd_multiuse2_nuw:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #324 // =0x144
; CHECK-NEXT:    lsl w9, w0, #2
; CHECK-NEXT:    mov w10, #1300 // =0x514
; CHECK-NEXT:    madd w8, w0, w8, w10
; CHECK-NEXT:    add w9, w9, #20
; CHECK-NEXT:    eor w0, w8, w9
; CHECK-NEXT:    ret
  %tmp0 = add nuw i32 %a, 4
  %tmp1 = mul nuw i32 %tmp0, 4
  %tmp2 = add nuw i32 %tmp1, 4
  %tmp3 = mul nuw i32 %tmp0, 324
  %tmp4 = add nuw i32 %tmp3, 4
  %tmp5 = xor i32 %tmp4, %tmp2
  ret i32 %tmp5
}

define signext i32 @addmuladd_multiuse2_nswnuw(i32 signext %a) {
; CHECK-LABEL: addmuladd_multiuse2_nswnuw:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #324 // =0x144
; CHECK-NEXT:    lsl w9, w0, #2
; CHECK-NEXT:    mov w10, #1300 // =0x514
; CHECK-NEXT:    madd w8, w0, w8, w10
; CHECK-NEXT:    add w9, w9, #20
; CHECK-NEXT:    eor w0, w8, w9
; CHECK-NEXT:    ret
  %tmp0 = add nsw nuw i32 %a, 4
  %tmp1 = mul nsw nuw i32 %tmp0, 4
  %tmp2 = add nsw nuw i32 %tmp1, 4
  %tmp3 = mul nsw nuw i32 %tmp0, 324
  %tmp4 = add nsw nuw i32 %tmp3, 4
  %tmp5 = xor i32 %tmp4, %tmp2
  ret i32 %tmp5
}

