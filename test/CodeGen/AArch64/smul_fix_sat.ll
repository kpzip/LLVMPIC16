; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=aarch64-linux-gnu | FileCheck %s

define i32 @func(i32 %x, i32 %y) nounwind {
; CHECK-LABEL: func:
; CHECK:       // %bb.0:
; CHECK-NEXT:    smull x9, w0, w1
; CHECK-NEXT:    mov w8, #2147483647 // =0x7fffffff
; CHECK-NEXT:    lsr x10, x9, #32
; CHECK-NEXT:    extr w9, w10, w9, #2
; CHECK-NEXT:    cmp w10, #1
; CHECK-NEXT:    csel w8, w8, w9, gt
; CHECK-NEXT:    cmn w10, #2
; CHECK-NEXT:    mov w9, #-2147483648 // =0x80000000
; CHECK-NEXT:    csel w0, w9, w8, lt
; CHECK-NEXT:    ret
  %tmp = call i32 @llvm.smul.fix.sat.i32(i32 %x, i32 %y, i32 2)
  ret i32 %tmp
}

define i64 @func2(i64 %x, i64 %y) nounwind {
; CHECK-LABEL: func2:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mul x9, x0, x1
; CHECK-NEXT:    mov x8, #9223372036854775807 // =0x7fffffffffffffff
; CHECK-NEXT:    smulh x10, x0, x1
; CHECK-NEXT:    extr x9, x10, x9, #2
; CHECK-NEXT:    cmp x10, #1
; CHECK-NEXT:    csel x8, x8, x9, gt
; CHECK-NEXT:    cmn x10, #2
; CHECK-NEXT:    mov x9, #-9223372036854775808 // =0x8000000000000000
; CHECK-NEXT:    csel x0, x9, x8, lt
; CHECK-NEXT:    ret
  %tmp = call i64 @llvm.smul.fix.sat.i64(i64 %x, i64 %y, i32 2)
  ret i64 %tmp
}

define i4 @func3(i4 %x, i4 %y) nounwind {
; CHECK-LABEL: func3:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sbfx w9, w1, #0, #4
; CHECK-NEXT:    lsl w10, w0, #28
; CHECK-NEXT:    mov w8, #2147483647 // =0x7fffffff
; CHECK-NEXT:    smull x9, w10, w9
; CHECK-NEXT:    lsr x10, x9, #32
; CHECK-NEXT:    extr w9, w10, w9, #2
; CHECK-NEXT:    cmp w10, #1
; CHECK-NEXT:    csel w8, w8, w9, gt
; CHECK-NEXT:    cmn w10, #2
; CHECK-NEXT:    mov w9, #-2147483648 // =0x80000000
; CHECK-NEXT:    csel w8, w9, w8, lt
; CHECK-NEXT:    asr w0, w8, #28
; CHECK-NEXT:    ret
  %tmp = call i4 @llvm.smul.fix.sat.i4(i4 %x, i4 %y, i32 2)
  ret i4 %tmp
}

;; These result in regular integer multiplication with a saturation check.
define i32 @func4(i32 %x, i32 %y) nounwind {
; CHECK-LABEL: func4:
; CHECK:       // %bb.0:
; CHECK-NEXT:    smull x9, w0, w1
; CHECK-NEXT:    eor w10, w0, w1
; CHECK-NEXT:    mov w8, #-2147483648 // =0x80000000
; CHECK-NEXT:    cmp w10, #0
; CHECK-NEXT:    cinv w8, w8, ge
; CHECK-NEXT:    cmp x9, w9, sxtw
; CHECK-NEXT:    csel w0, w8, w9, ne
; CHECK-NEXT:    ret
  %tmp = call i32 @llvm.smul.fix.sat.i32(i32 %x, i32 %y, i32 0)
  ret i32 %tmp
}

define i64 @func5(i64 %x, i64 %y) {
; CHECK-LABEL: func5:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mul x9, x0, x1
; CHECK-NEXT:    eor x11, x0, x1
; CHECK-NEXT:    mov x8, #-9223372036854775808 // =0x8000000000000000
; CHECK-NEXT:    cmp x11, #0
; CHECK-NEXT:    smulh x10, x0, x1
; CHECK-NEXT:    cinv x8, x8, ge
; CHECK-NEXT:    cmp x10, x9, asr #63
; CHECK-NEXT:    csel x0, x8, x9, ne
; CHECK-NEXT:    ret
  %tmp = call i64 @llvm.smul.fix.sat.i64(i64 %x, i64 %y, i32 0)
  ret i64 %tmp
}

define i4 @func6(i4 %x, i4 %y) nounwind {
; CHECK-LABEL: func6:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sbfx w9, w1, #0, #4
; CHECK-NEXT:    lsl w10, w0, #28
; CHECK-NEXT:    mov w8, #-2147483648 // =0x80000000
; CHECK-NEXT:    smull x11, w10, w9
; CHECK-NEXT:    eor w9, w10, w9
; CHECK-NEXT:    cmp w9, #0
; CHECK-NEXT:    cinv w8, w8, ge
; CHECK-NEXT:    cmp x11, w11, sxtw
; CHECK-NEXT:    csel w8, w8, w11, ne
; CHECK-NEXT:    asr w0, w8, #28
; CHECK-NEXT:    ret
  %tmp = call i4 @llvm.smul.fix.sat.i4(i4 %x, i4 %y, i32 0)
  ret i4 %tmp
}

define i64 @func7(i64 %x, i64 %y) nounwind {
; CHECK-LABEL: func7:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mul x9, x0, x1
; CHECK-NEXT:    mov w8, #2147483647 // =0x7fffffff
; CHECK-NEXT:    mov x11, #-2147483648 // =0xffffffff80000000
; CHECK-NEXT:    smulh x10, x0, x1
; CHECK-NEXT:    extr x9, x10, x9, #32
; CHECK-NEXT:    cmp x10, x8
; CHECK-NEXT:    mov x8, #9223372036854775807 // =0x7fffffffffffffff
; CHECK-NEXT:    csel x8, x8, x9, gt
; CHECK-NEXT:    cmp x10, x11
; CHECK-NEXT:    mov x9, #-9223372036854775808 // =0x8000000000000000
; CHECK-NEXT:    csel x0, x9, x8, lt
; CHECK-NEXT:    ret
  %tmp = call i64 @llvm.smul.fix.sat.i64(i64 %x, i64 %y, i32 32)
  ret i64 %tmp
}

define i64 @func8(i64 %x, i64 %y) nounwind {
; CHECK-LABEL: func8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mul x9, x0, x1
; CHECK-NEXT:    mov x8, #4611686018427387903 // =0x3fffffffffffffff
; CHECK-NEXT:    mov x11, #-4611686018427387904 // =0xc000000000000000
; CHECK-NEXT:    smulh x10, x0, x1
; CHECK-NEXT:    extr x9, x10, x9, #63
; CHECK-NEXT:    cmp x10, x8
; CHECK-NEXT:    mov x8, #9223372036854775807 // =0x7fffffffffffffff
; CHECK-NEXT:    csel x8, x8, x9, gt
; CHECK-NEXT:    cmp x10, x11
; CHECK-NEXT:    mov x9, #-9223372036854775808 // =0x8000000000000000
; CHECK-NEXT:    csel x0, x9, x8, lt
; CHECK-NEXT:    ret
  %tmp = call i64 @llvm.smul.fix.sat.i64(i64 %x, i64 %y, i32 63)
  ret i64 %tmp
}

define <2 x i32> @vec(<2 x i32> %x, <2 x i32> %y) nounwind {
; CHECK-LABEL: vec:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d1 killed $d1 def $q1
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-NEXT:    mov w9, v1.s[1]
; CHECK-NEXT:    mov w10, v0.s[1]
; CHECK-NEXT:    mov w8, #-2147483648 // =0x80000000
; CHECK-NEXT:    fmov w12, s0
; CHECK-NEXT:    smull x11, w10, w9
; CHECK-NEXT:    eor w9, w10, w9
; CHECK-NEXT:    fmov w10, s1
; CHECK-NEXT:    cmp w9, #0
; CHECK-NEXT:    smull x9, w12, w10
; CHECK-NEXT:    eor w10, w12, w10
; CHECK-NEXT:    cinv w12, w8, ge
; CHECK-NEXT:    cmp x11, w11, sxtw
; CHECK-NEXT:    csel w11, w12, w11, ne
; CHECK-NEXT:    cmp w10, #0
; CHECK-NEXT:    cinv w8, w8, ge
; CHECK-NEXT:    cmp x9, w9, sxtw
; CHECK-NEXT:    csel w8, w8, w9, ne
; CHECK-NEXT:    fmov s0, w8
; CHECK-NEXT:    mov v0.s[1], w11
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $q0
; CHECK-NEXT:    ret
  %tmp = call <2 x i32> @llvm.smul.fix.sat.v2i32(<2 x i32> %x, <2 x i32> %y, i32 0)
  ret <2 x i32> %tmp
}

define <4 x i32> @vec2(<4 x i32> %x, <4 x i32> %y) nounwind {
; CHECK-LABEL: vec2:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w9, v1.s[1]
; CHECK-NEXT:    mov w10, v0.s[1]
; CHECK-NEXT:    mov w8, #-2147483648 // =0x80000000
; CHECK-NEXT:    fmov w12, s1
; CHECK-NEXT:    fmov w13, s0
; CHECK-NEXT:    mov w14, v0.s[2]
; CHECK-NEXT:    eor w11, w10, w9
; CHECK-NEXT:    smull x9, w10, w9
; CHECK-NEXT:    mov w10, v1.s[2]
; CHECK-NEXT:    cmp w11, #0
; CHECK-NEXT:    smull x11, w13, w12
; CHECK-NEXT:    eor w12, w13, w12
; CHECK-NEXT:    cinv w13, w8, ge
; CHECK-NEXT:    cmp x9, w9, sxtw
; CHECK-NEXT:    csel w9, w13, w9, ne
; CHECK-NEXT:    cmp w12, #0
; CHECK-NEXT:    mov w13, v1.s[3]
; CHECK-NEXT:    cinv w12, w8, ge
; CHECK-NEXT:    cmp x11, w11, sxtw
; CHECK-NEXT:    csel w11, w12, w11, ne
; CHECK-NEXT:    mov w12, v0.s[3]
; CHECK-NEXT:    fmov s0, w11
; CHECK-NEXT:    smull x11, w14, w10
; CHECK-NEXT:    mov v0.s[1], w9
; CHECK-NEXT:    eor w9, w14, w10
; CHECK-NEXT:    smull x10, w12, w13
; CHECK-NEXT:    cmp w9, #0
; CHECK-NEXT:    cinv w9, w8, ge
; CHECK-NEXT:    cmp x11, w11, sxtw
; CHECK-NEXT:    csel w9, w9, w11, ne
; CHECK-NEXT:    mov v0.s[2], w9
; CHECK-NEXT:    eor w9, w12, w13
; CHECK-NEXT:    cmp w9, #0
; CHECK-NEXT:    cinv w8, w8, ge
; CHECK-NEXT:    cmp x10, w10, sxtw
; CHECK-NEXT:    csel w8, w8, w10, ne
; CHECK-NEXT:    mov v0.s[3], w8
; CHECK-NEXT:    ret
  %tmp = call <4 x i32> @llvm.smul.fix.sat.v4i32(<4 x i32> %x, <4 x i32> %y, i32 0)
  ret <4 x i32> %tmp
}

define <4 x i64> @vec3(<4 x i64> %x, <4 x i64> %y) nounwind {
; CHECK-LABEL: vec3:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov x8, v2.d[1]
; CHECK-NEXT:    mov x9, v0.d[1]
; CHECK-NEXT:    mov w16, #2147483647 // =0x7fffffff
; CHECK-NEXT:    fmov x10, d2
; CHECK-NEXT:    fmov x11, d0
; CHECK-NEXT:    mov x18, #9223372036854775807 // =0x7fffffffffffffff
; CHECK-NEXT:    mov x14, v3.d[1]
; CHECK-NEXT:    mov x15, v1.d[1]
; CHECK-NEXT:    mul x13, x9, x8
; CHECK-NEXT:    smulh x8, x9, x8
; CHECK-NEXT:    mul x12, x11, x10
; CHECK-NEXT:    smulh x9, x11, x10
; CHECK-NEXT:    extr x13, x8, x13, #32
; CHECK-NEXT:    cmp x8, x16
; CHECK-NEXT:    mul x10, x15, x14
; CHECK-NEXT:    csel x13, x18, x13, gt
; CHECK-NEXT:    smulh x11, x15, x14
; CHECK-NEXT:    fmov x14, d3
; CHECK-NEXT:    fmov x15, d1
; CHECK-NEXT:    extr x12, x9, x12, #32
; CHECK-NEXT:    mul x17, x15, x14
; CHECK-NEXT:    smulh x14, x15, x14
; CHECK-NEXT:    mov x15, #-2147483648 // =0xffffffff80000000
; CHECK-NEXT:    cmp x8, x15
; CHECK-NEXT:    mov x8, #-9223372036854775808 // =0x8000000000000000
; CHECK-NEXT:    csel x13, x8, x13, lt
; CHECK-NEXT:    cmp x9, x16
; CHECK-NEXT:    csel x12, x18, x12, gt
; CHECK-NEXT:    cmp x9, x15
; CHECK-NEXT:    extr x9, x11, x10, #32
; CHECK-NEXT:    csel x10, x8, x12, lt
; CHECK-NEXT:    cmp x11, x16
; CHECK-NEXT:    csel x9, x18, x9, gt
; CHECK-NEXT:    cmp x11, x15
; CHECK-NEXT:    extr x11, x14, x17, #32
; CHECK-NEXT:    csel x9, x8, x9, lt
; CHECK-NEXT:    cmp x14, x16
; CHECK-NEXT:    fmov d0, x10
; CHECK-NEXT:    csel x11, x18, x11, gt
; CHECK-NEXT:    cmp x14, x15
; CHECK-NEXT:    csel x8, x8, x11, lt
; CHECK-NEXT:    fmov d1, x8
; CHECK-NEXT:    mov v0.d[1], x13
; CHECK-NEXT:    mov v1.d[1], x9
; CHECK-NEXT:    ret
  %tmp = call <4 x i64> @llvm.smul.fix.sat.v4i64(<4 x i64> %x, <4 x i64> %y, i32 32)
  ret <4 x i64> %tmp
}
