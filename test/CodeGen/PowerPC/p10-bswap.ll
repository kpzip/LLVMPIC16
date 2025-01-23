; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -mtriple=powerpc64le-unknown-linux-gnu \
; RUN:     -mcpu=pwr10 -ppc-asm-full-reg-names < %s | FileCheck %s

; Check that the brh/brw/brd instructions are generated for the bswap
; intrinsic for register operand on P10 and that the lhbrx/lwbrx/ldbrw
; instructions are generated for memory operand.

declare i16 @llvm.bswap.i16(i16)

define zeroext i16 @test_nomem16(i16 zeroext %a) {
; CHECK-LABEL: test_nomem16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    brh r3, r3
; CHECK-NEXT:    clrldi r3, r3, 48
; CHECK-NEXT:    blr
entry:
  %0 = tail call i16 @llvm.bswap.i16(i16 %a)
  ret i16 %0
}

declare i32 @llvm.bswap.i32(i32)

define zeroext i32 @test_nomem32(i32 zeroext %a) {
; CHECK-LABEL: test_nomem32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    brw r3, r3
; CHECK-NEXT:    clrldi r3, r3, 32
; CHECK-NEXT:    blr
entry:
  %0 = tail call i32 @llvm.bswap.i32(i32 %a)
  ret i32 %0
}

; Check that brh and clrldi are produced from a call to @llvm.bswap.i32
; followed by a right shift of 16 (and a zero-extend at the end of the DAG).
define zeroext i32 @test_bswap_shift16(i32 zeroext %a) {
; CHECK-LABEL: test_bswap_shift16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    brh r3, r3
; CHECK-NEXT:    clrldi r3, r3, 48
; CHECK-NEXT:    blr
entry:
  %0 = tail call i32 @llvm.bswap.i32(i32 %a)
  %shr = lshr i32 %0, 16
  ret i32 %shr
}

; Check that brh are produced from a call to @llvm.bswap.i32
; followed by a right shift of 16.
declare i64 @call_1()
define void @test_bswap_shift16_2() {
; CHECK-LABEL: test_bswap_shift16_2:
; CHECK:       # %bb.0: # %bb
; CHECK-NEXT:    mflr r0
; CHECK-NEXT:    std r0, 16(r1)
; CHECK-NEXT:    stdu r1, -32(r1)
; CHECK-NEXT:    .cfi_def_cfa_offset 32
; CHECK-NEXT:    .cfi_offset lr, 16
; CHECK-NEXT:    bl call_1@notoc
; CHECK-NEXT:    brh r3, r3
; CHECK-NEXT:    rldicl r3, r3, 0, 48
; CHECK-NEXT:    sth r3, 0(r3)
bb:
  switch i32 undef, label %bb1 [
    i32 78, label %bb2
  ]

bb1:
  unreachable

bb2:
  %i = call i64 @call_1()
  %i3 = trunc i64 %i to i32
  %i4 = call i32 @llvm.bswap.i32(i32 %i3)
  %i5 = lshr i32 %i4, 16
  %i6 = trunc i32 %i5 to i16
  store i16 %i6, ptr undef, align 2
  unreachable
}

define zeroext i32 @test_bswap_shift18(i32 zeroext %a) {
; CHECK-LABEL: test_bswap_shift18:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    brw r3, r3
; CHECK-NEXT:    rlwinm r3, r3, 14, 18, 31
; CHECK-NEXT:    blr
entry:
  %0 = tail call i32 @llvm.bswap.i32(i32 %a)
  %shr = lshr i32 %0, 18
  ret i32 %shr
}

declare i64 @llvm.bswap.i64(i64)

define i64 @test_nomem64(i64 %a) {
; CHECK-LABEL: test_nomem64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    brd r3, r3
; CHECK-NEXT:    blr
entry:
  %0 = tail call i64 @llvm.bswap.i64(i64 %a)
  ret i64 %0
}

define i16 @test_mem16(ptr %a) {
; CHECK-LABEL: test_mem16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    lhbrx r3, 0, r3
; CHECK-NEXT:    blr
entry:
  %0 = load i16, ptr %a, align 2
  %1 = tail call i16 @llvm.bswap.i16(i16 %0)
  ret i16 %1
}

define i32 @test_mem32(ptr %a) {
; CHECK-LABEL: test_mem32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    lwbrx r3, 0, r3
; CHECK-NEXT:    blr
entry:
  %0 = load i32, ptr %a, align 4
  %1 = tail call i32 @llvm.bswap.i32(i32 %0)
  ret i32 %1
}

define i64 @test_mem64(ptr %a) {
; CHECK-LABEL: test_mem64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    ldbrx r3, 0, r3
; CHECK-NEXT:    blr
entry:
  %0 = load i64, ptr %a, align 8
  %1 = tail call i64 @llvm.bswap.i64(i64 %0)
  ret i64 %1
}

