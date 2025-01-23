; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --extra_scrub --version 5
; RUN: llc < %s -march=nvptx64 -mcpu=sm_70 -mattr=+ptx83 | FileCheck %s
; RUN: %if ptxas %{ llc < %s -march=nvptx64 -mcpu=sm_70 -mattr=+ptx83 | %ptxas-verify -arch=sm_70 %}

target triple = "nvptx64-nvidia-cuda"

@size = internal addrspace(1) global i32 0, align 4
@x = internal addrspace(1) global i128 0, align 16

define void @test_b128_in_loop() {
; CHECK-LABEL: test_b128_in_loop(
; CHECK:       {
; CHECK-NEXT:    .reg .pred %p<3>;
; CHECK-NEXT:    .reg .b64 %rd<15>;
; CHECK-NEXT:    .reg .b128 %rq<3>;
; CHECK-EMPTY:
; CHECK-NEXT:  // %bb.0:
; CHECK-NEXT:    ld.global.s32 %rd1, [size];
; CHECK-NEXT:    setp.eq.s64 %p1, %rd1, 0;
; CHECK-NEXT:    @%p1 bra $L__BB0_3;
; CHECK-NEXT:  // %bb.1: // %BB1
; CHECK-NEXT:    ld.global.u64 %rd13, [x+8];
; CHECK-NEXT:    ld.global.u64 %rd12, [x];
; CHECK-NEXT:    mov.u64 %rd14, 0;
; CHECK-NEXT:  $L__BB0_2: // %BB2
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    mov.b128 %rq1, {%rd12, %rd13};
; CHECK-NEXT:    // begin inline asm
; CHECK-NEXT:    {
; CHECK-NEXT:    .reg .b64 lo;
; CHECK-NEXT:    .reg .b64 hi;
; CHECK-NEXT:    mov.b128 {lo, hi}, %rq1;
; CHECK-NEXT:    add.cc.u64 lo, lo, %rd14;
; CHECK-NEXT:    mov.b128 %rq1, {lo, hi};
; CHECK-NEXT:    }
; CHECK-NEXT:    // end inline asm
; CHECK-NEXT:    mov.b128 {%rd12, %rd13}, %rq1;
; CHECK-NEXT:    st.global.u64 [x+8], %rd13;
; CHECK-NEXT:    st.global.u64 [x], %rd12;
; CHECK-NEXT:    add.s64 %rd14, %rd14, 1;
; CHECK-NEXT:    setp.ne.s64 %p2, %rd1, %rd14;
; CHECK-NEXT:    @%p2 bra $L__BB0_2;
; CHECK-NEXT:  $L__BB0_3: // %BB3
; CHECK-NEXT:    ret;

  %1 = load i32, ptr addrspace(1) @size, align 4
  %2 = icmp eq i32 %1, 0
  br i1 %2, label %BB3, label %BB1

BB1:                                 ; preds = %0
  %3 = load i128, ptr addrspace(1) @x, align 16
  %4 = sext i32 %1 to i64
  br label %BB2

BB2:                                           ; preds = %BB2, %BB1
  %5 = phi i128 [ %7, %BB2 ], [ %3, %BB1 ]
  %6 = phi i64 [ %9, %BB2 ], [ 0, %BB1 ]
  %7 = tail call i128 asm "{\0A\09.reg .b64 lo;\0A\09.reg .b64 hi;\0A\09mov.b128 {lo, hi}, $0;\0A\09add.cc.u64 lo, lo, $1;\0A\09mov.b128 $0, {lo, hi};\0A\09}", "=q,l,0"(i64 %6, i128 %5)
  %8 = bitcast i128 %7 to <2 x i64>
  store <2 x i64> %8, ptr addrspace(1) @x, align 16
  %9 = add nuw i64 %6, 1
  %10 = icmp eq i64 %9, %4
  br i1 %10, label %BB3, label %BB2

BB3:                                      ; preds = %BB2, %0
  ret void
}
