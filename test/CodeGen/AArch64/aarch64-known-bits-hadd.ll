; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 4
; RUN: llc -mtriple=aarch64 < %s | FileCheck %s

declare <8 x i16> @llvm.aarch64.neon.uhadd.v8i16(<8 x i16>, <8 x i16>)
declare <8 x i16> @llvm.aarch64.neon.urhadd.v8i16(<8 x i16>, <8 x i16>)
declare <8 x i16> @llvm.aarch64.neon.shadd.v8i16(<8 x i16>, <8 x i16>)
declare <8 x i16> @llvm.aarch64.neon.srhadd.v8i16(<8 x i16>, <8 x i16>)

define <8 x i16> @haddu_zext(<8 x i8> %a0, <8 x i8> %a1) {
; CHECK-LABEL: haddu_zext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    uhadd v0.8b, v0.8b, v1.8b
; CHECK-NEXT:    ushll v0.8h, v0.8b, #0
; CHECK-NEXT:    ret
  %x0 = zext <8 x i8> %a0 to <8 x i16>
  %x1 = zext <8 x i8> %a1 to <8 x i16>
  %hadd = call <8 x i16> @llvm.aarch64.neon.uhadd.v8i16(<8 x i16> %x0, <8 x i16> %x1)
  %res = and <8 x i16> %hadd, <i16 511, i16 511, i16 511, i16 511,i16 511, i16 511, i16 511, i16 511>
  ret <8 x i16> %res
}

define <8 x i16> @rhaddu_zext(<8 x i8> %a0, <8 x i8> %a1) {
; CHECK-LABEL: rhaddu_zext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    urhadd v0.8b, v0.8b, v1.8b
; CHECK-NEXT:    ushll v0.8h, v0.8b, #0
; CHECK-NEXT:    ret
  %x0 = zext <8 x i8> %a0 to <8 x i16>
  %x1 = zext <8 x i8> %a1 to <8 x i16>
  %hadd = call <8 x i16> @llvm.aarch64.neon.urhadd.v8i16(<8 x i16> %x0, <8 x i16> %x1)
  %res = and <8 x i16> %hadd, <i16 511, i16 511, i16 511, i16 511, i16 511, i16 511, i16 511, i16 511>
  ret <8 x i16> %res
}

define <8 x i16> @hadds_zext(<8 x i8> %a0, <8 x i8> %a1) {
; CHECK-LABEL: hadds_zext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ushll v0.8h, v0.8b, #0
; CHECK-NEXT:    ushll v1.8h, v1.8b, #0
; CHECK-NEXT:    shadd v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
  %x0 = zext <8 x i8> %a0 to <8 x i16>
  %x1 = zext <8 x i8> %a1 to <8 x i16>
  %hadd = call <8 x i16> @llvm.aarch64.neon.shadd.v8i16(<8 x i16> %x0, <8 x i16> %x1)
  %res = and <8 x i16> %hadd, <i16 511, i16 511, i16 511, i16 511, i16 511, i16 511, i16 511, i16 511>
  ret <8 x i16> %res
}

define <8 x i16> @shaddu_zext(<8 x i8> %a0, <8 x i8> %a1) {
; CHECK-LABEL: shaddu_zext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ushll v0.8h, v0.8b, #0
; CHECK-NEXT:    ushll v1.8h, v1.8b, #0
; CHECK-NEXT:    srhadd v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
  %x0 = zext <8 x i8> %a0 to <8 x i16>
  %x1 = zext <8 x i8> %a1 to <8 x i16>
  %hadd = call <8 x i16> @llvm.aarch64.neon.srhadd.v8i16(<8 x i16> %x0, <8 x i16> %x1)
  %res = and <8 x i16> %hadd, <i16 511, i16 511, i16 511, i16 511, i16 511, i16 511, i16 511, i16 511>
  ret <8 x i16> %res
}

; ; negative tests

define <8 x i16> @haddu_sext(<8 x i8> %a0, <8 x i8> %a1) {
; CHECK-LABEL: haddu_sext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sshll v0.8h, v0.8b, #0
; CHECK-NEXT:    sshll v1.8h, v1.8b, #0
; CHECK-NEXT:    uhadd v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    bic v0.8h, #254, lsl #8
; CHECK-NEXT:    ret
  %x0 = sext <8 x i8> %a0 to <8 x i16>
  %x1 = sext <8 x i8> %a1 to <8 x i16>
  %hadd = call <8 x i16> @llvm.aarch64.neon.uhadd.v8i16(<8 x i16> %x0, <8 x i16> %x1)
  %res = and <8 x i16> %hadd, <i16 511, i16 511, i16 511, i16 511,i16 511, i16 511, i16 511, i16 511>
  ret <8 x i16> %res
}

define <8 x i16> @urhadd_sext(<8 x i8> %a0, <8 x i8> %a1) {
; CHECK-LABEL: urhadd_sext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sshll v0.8h, v0.8b, #0
; CHECK-NEXT:    sshll v1.8h, v1.8b, #0
; CHECK-NEXT:    urhadd v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    bic v0.8h, #254, lsl #8
; CHECK-NEXT:    ret
  %x0 = sext <8 x i8> %a0 to <8 x i16>
  %x1 = sext <8 x i8> %a1 to <8 x i16>
  %hadd = call <8 x i16> @llvm.aarch64.neon.urhadd.v8i16(<8 x i16> %x0, <8 x i16> %x1)
  %res = and <8 x i16> %hadd, <i16 511, i16 511, i16 511, i16 511,i16 511, i16 511, i16 511, i16 511>
  ret <8 x i16> %res
}

define <8 x i16> @hadds_sext(<8 x i8> %a0, <8 x i8> %a1) {
; CHECK-LABEL: hadds_sext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    shadd v0.8b, v0.8b, v1.8b
; CHECK-NEXT:    sshll v0.8h, v0.8b, #0
; CHECK-NEXT:    bic v0.8h, #254, lsl #8
; CHECK-NEXT:    ret
  %x0 = sext <8 x i8> %a0 to <8 x i16>
  %x1 = sext <8 x i8> %a1 to <8 x i16>
  %hadd = call <8 x i16> @llvm.aarch64.neon.shadd.v8i16(<8 x i16> %x0, <8 x i16> %x1)
  %res = and <8 x i16> %hadd, <i16 511, i16 511, i16 511, i16 511, i16 511, i16 511, i16 511, i16 511>
  ret <8 x i16> %res
}

define <8 x i16> @shaddu_sext(<8 x i8> %a0, <8 x i8> %a1) {
; CHECK-LABEL: shaddu_sext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    srhadd v0.8b, v0.8b, v1.8b
; CHECK-NEXT:    sshll v0.8h, v0.8b, #0
; CHECK-NEXT:    bic v0.8h, #254, lsl #8
; CHECK-NEXT:    ret
  %x0 = sext <8 x i8> %a0 to <8 x i16>
  %x1 = sext <8 x i8> %a1 to <8 x i16>
  %hadd = call <8 x i16> @llvm.aarch64.neon.srhadd.v8i16(<8 x i16> %x0, <8 x i16> %x1)
  %res = and <8 x i16> %hadd, <i16 511, i16 511, i16 511, i16 511, i16 511, i16 511, i16 511, i16 511>
  ret <8 x i16> %res
}
