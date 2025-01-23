; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc < %s -mtriple=arm64-eabi -aarch64-enable-stp-suppress=false -verify-machineinstrs -mcpu=cyclone -aarch64-enable-sink-fold=true | FileCheck %s

define void @stp_int(i32 %a, i32 %b, ptr nocapture %p) nounwind {
; CHECK-LABEL: stp_int:
; CHECK:       // %bb.0:
; CHECK-NEXT:    stp w0, w1, [x2]
; CHECK-NEXT:    ret
  store i32 %a, ptr %p, align 4
  %add.ptr = getelementptr inbounds i32, ptr %p, i64 1
  store i32 %b, ptr %add.ptr, align 4
  ret void
}

define void @stp_long(i64 %a, i64 %b, ptr nocapture %p) nounwind {
; CHECK-LABEL: stp_long:
; CHECK:       // %bb.0:
; CHECK-NEXT:    stp x0, x1, [x2]
; CHECK-NEXT:    ret
  store i64 %a, ptr %p, align 8
  %add.ptr = getelementptr inbounds i64, ptr %p, i64 1
  store i64 %b, ptr %add.ptr, align 8
  ret void
}

define void @stp_float(float %a, float %b, ptr nocapture %p) nounwind {
; CHECK-LABEL: stp_float:
; CHECK:       // %bb.0:
; CHECK-NEXT:    stp s0, s1, [x0]
; CHECK-NEXT:    ret
  store float %a, ptr %p, align 4
  %add.ptr = getelementptr inbounds float, ptr %p, i64 1
  store float %b, ptr %add.ptr, align 4
  ret void
}

define void @stp_double(double %a, double %b, ptr nocapture %p) nounwind {
; CHECK-LABEL: stp_double:
; CHECK:       // %bb.0:
; CHECK-NEXT:    stp d0, d1, [x0]
; CHECK-NEXT:    ret
  store double %a, ptr %p, align 8
  %add.ptr = getelementptr inbounds double, ptr %p, i64 1
  store double %b, ptr %add.ptr, align 8
  ret void
}

define void @stp_doublex2(<2 x double> %a, <2 x double> %b, ptr nocapture %p) nounwind {
; CHECK-LABEL: stp_doublex2:
; CHECK:       // %bb.0:
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  store <2 x double> %a, ptr %p, align 16
  %add.ptr = getelementptr inbounds <2 x double>, ptr %p, i64 1
  store <2 x double> %b, ptr %add.ptr, align 16
  ret void
}

; Test the load/store optimizer---combine ldurs into a ldp, if appropriate
define void @stur_int(i32 %a, i32 %b, ptr nocapture %p) nounwind {
; CHECK-LABEL: stur_int:
; CHECK:       // %bb.0:
; CHECK-NEXT:    stp w1, w0, [x2, #-8]
; CHECK-NEXT:    ret
  %p1 = getelementptr inbounds i32, ptr %p, i32 -1
  store i32 %a, ptr %p1, align 2
  %p2 = getelementptr inbounds i32, ptr %p, i32 -2
  store i32 %b, ptr %p2, align 2
  ret void
}

define void @stur_long(i64 %a, i64 %b, ptr nocapture %p) nounwind {
; CHECK-LABEL: stur_long:
; CHECK:       // %bb.0:
; CHECK-NEXT:    stp x1, x0, [x2, #-16]
; CHECK-NEXT:    ret
  %p1 = getelementptr inbounds i64, ptr %p, i32 -1
  store i64 %a, ptr %p1, align 2
  %p2 = getelementptr inbounds i64, ptr %p, i32 -2
  store i64 %b, ptr %p2, align 2
  ret void
}

define void @stur_float(float %a, float %b, ptr nocapture %p) nounwind {
; CHECK-LABEL: stur_float:
; CHECK:       // %bb.0:
; CHECK-NEXT:    stp s1, s0, [x0, #-8]
; CHECK-NEXT:    ret
  %p1 = getelementptr inbounds float, ptr %p, i32 -1
  store float %a, ptr %p1, align 2
  %p2 = getelementptr inbounds float, ptr %p, i32 -2
  store float %b, ptr %p2, align 2
  ret void
}

define void @stur_double(double %a, double %b, ptr nocapture %p) nounwind {
; CHECK-LABEL: stur_double:
; CHECK:       // %bb.0:
; CHECK-NEXT:    stp d1, d0, [x0, #-16]
; CHECK-NEXT:    ret
  %p1 = getelementptr inbounds double, ptr %p, i32 -1
  store double %a, ptr %p1, align 2
  %p2 = getelementptr inbounds double, ptr %p, i32 -2
  store double %b, ptr %p2, align 2
  ret void
}

define void @stur_doublex2(<2 x double> %a, <2 x double> %b, ptr nocapture %p) nounwind {
; CHECK-LABEL: stur_doublex2:
; CHECK:       // %bb.0:
; CHECK-NEXT:    stp q1, q0, [x0, #-32]
; CHECK-NEXT:    ret
  %p1 = getelementptr inbounds <2 x double>, ptr %p, i32 -1
  store <2 x double> %a, ptr %p1, align 2
  %p2 = getelementptr inbounds <2 x double>, ptr %p, i32 -2
  store <2 x double> %b, ptr %p2, align 2
  ret void
}

define void @splat_v4i32(i32 %v, ptr %p) {
; CHECK-LABEL: splat_v4i32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    dup v0.4s, w0
; CHECK-NEXT:    str q0, [x1]
; CHECK-NEXT:    ret
entry:
  %p17 = insertelement <4 x i32> undef, i32 %v, i32 0
  %p18 = insertelement <4 x i32> %p17, i32 %v, i32 1
  %p19 = insertelement <4 x i32> %p18, i32 %v, i32 2
  %p20 = insertelement <4 x i32> %p19, i32 %v, i32 3
  store <4 x i32> %p20, ptr %p, align 4
  ret void
}

; Check that a non-splat store that is storing a vector created by 4
; insertelements that is not a splat vector does not get split.
define void @nosplat_v4i32(i32 %v, ptr %p) {
; CHECK-LABEL: nosplat_v4i32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sub sp, sp, #16
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    // kill: def $w0 killed $w0 def $x0
; CHECK-NEXT:    mov x8, sp
; CHECK-NEXT:    bfi x8, x0, #2, #2
; CHECK-NEXT:    str w0, [x8]
; CHECK-NEXT:    ldr q0, [sp]
; CHECK-NEXT:    mov v0.s[1], w0
; CHECK-NEXT:    mov v0.s[2], w0
; CHECK-NEXT:    mov v0.s[3], w0
; CHECK-NEXT:    str q0, [x1]
; CHECK-NEXT:    add sp, sp, #16
; CHECK-NEXT:    ret
entry:
  %p17 = insertelement <4 x i32> undef, i32 %v, i32 %v
  %p18 = insertelement <4 x i32> %p17, i32 %v, i32 1
  %p19 = insertelement <4 x i32> %p18, i32 %v, i32 2
  %p20 = insertelement <4 x i32> %p19, i32 %v, i32 3
  store <4 x i32> %p20, ptr %p, align 4
  ret void
}

; Check that a non-splat store that is storing a vector created by 4
; insertelements that is not a splat vector does not get split.
define void @nosplat2_v4i32(i32 %v, ptr %p, <4 x i32> %vin) {
; CHECK-LABEL: nosplat2_v4i32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov v0.s[1], w0
; CHECK-NEXT:    mov v0.s[2], w0
; CHECK-NEXT:    mov v0.s[3], w0
; CHECK-NEXT:    str q0, [x1]
; CHECK-NEXT:    ret
entry:
  %p18 = insertelement <4 x i32> %vin, i32 %v, i32 1
  %p19 = insertelement <4 x i32> %p18, i32 %v, i32 2
  %p20 = insertelement <4 x i32> %p19, i32 %v, i32 3
  store <4 x i32> %p20, ptr %p, align 4
  ret void
}

; Read of %b to compute %tmp2 shouldn't prevent formation of stp
define i32 @stp_int_rar_hazard(i32 %a, i32 %b, ptr nocapture %p) nounwind {
; CHECK-LABEL: stp_int_rar_hazard:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr w8, [x2, #8]
; CHECK-NEXT:    stp w0, w1, [x2]
; CHECK-NEXT:    add w0, w8, w1
; CHECK-NEXT:    ret
  store i32 %a, ptr %p, align 4
  %ld.ptr = getelementptr inbounds i32, ptr %p, i64 2
  %tmp = load i32, ptr %ld.ptr, align 4
  %tmp2 = add i32 %tmp, %b
  %add.ptr = getelementptr inbounds i32, ptr %p, i64 1
  store i32 %b, ptr %add.ptr, align 4
  ret i32 %tmp2
}

; Read of %b to compute %tmp2 shouldn't prevent formation of stp
define i32 @stp_int_rar_hazard_after(i32 %w0, i32 %a, i32 %b, ptr nocapture %p) nounwind {
; CHECK-LABEL: stp_int_rar_hazard_after:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr w8, [x3, #4]
; CHECK-NEXT:    stp w1, w2, [x3]
; CHECK-NEXT:    add w0, w8, w2
; CHECK-NEXT:    ret
  store i32 %a, ptr %p, align 4
  %ld.ptr = getelementptr inbounds i32, ptr %p, i64 1
  %tmp = load i32, ptr %ld.ptr, align 4
  %tmp2 = add i32 %tmp, %b
  %add.ptr = getelementptr inbounds i32, ptr %p, i64 1
  store i32 %b, ptr %add.ptr, align 4
  ret i32 %tmp2
}
