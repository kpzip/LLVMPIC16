; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc < %s -mtriple=nvptx -mcpu=sm_20 -O1 | FileCheck %s
; RUN: llc < %s -mtriple=nvptx64 -mcpu=sm_20 -O1 | FileCheck %s
; RUN: %if ptxas && !ptxas-12.0 %{ llc < %s -mtriple=nvptx -mcpu=sm_20 -O1 | %ptxas-verify %}
; RUN: %if ptxas %{ llc < %s -mtriple=nvptx64 -mcpu=sm_20 -O1 | %ptxas-verify %}

define i32 @test1(i32 %n, i32 %m) {
;
; CHECK-LABEL: test1(
; CHECK:       {
; CHECK-NEXT:    .reg .b32 %r<4>;
; CHECK-EMPTY:
; CHECK-NEXT:  // %bb.0:
; CHECK-NEXT:    ld.param.u32 %r1, [test1_param_0];
; CHECK-NEXT:    ld.param.u32 %r2, [test1_param_1];
; CHECK-NEXT:    mad.lo.s32 %r3, %r2, %r1, %r2;
; CHECK-NEXT:    st.param.b32 [func_retval0+0], %r3;
; CHECK-NEXT:    ret;
  %add = add i32 %n, 1
  %mul = mul i32 %add, %m
  ret i32 %mul
}

define i32 @test1_rev(i32 %n, i32 %m) {
;
; CHECK-LABEL: test1_rev(
; CHECK:       {
; CHECK-NEXT:    .reg .b32 %r<4>;
; CHECK-EMPTY:
; CHECK-NEXT:  // %bb.0:
; CHECK-NEXT:    ld.param.u32 %r1, [test1_rev_param_0];
; CHECK-NEXT:    ld.param.u32 %r2, [test1_rev_param_1];
; CHECK-NEXT:    mad.lo.s32 %r3, %r2, %r1, %r2;
; CHECK-NEXT:    st.param.b32 [func_retval0+0], %r3;
; CHECK-NEXT:    ret;
  %add = add i32 %n, 1
  %mul = mul i32 %m, %add
  ret i32 %mul
}

; Transpose (mul (select)) if it can then be folded to mad
define i32 @test2(i32 %n, i32 %m, i32 %s) {
;
; CHECK-LABEL: test2(
; CHECK:       {
; CHECK-NEXT:    .reg .pred %p<2>;
; CHECK-NEXT:    .reg .b32 %r<6>;
; CHECK-EMPTY:
; CHECK-NEXT:  // %bb.0:
; CHECK-NEXT:    ld.param.u32 %r1, [test2_param_0];
; CHECK-NEXT:    ld.param.u32 %r2, [test2_param_1];
; CHECK-NEXT:    ld.param.u32 %r3, [test2_param_2];
; CHECK-NEXT:    setp.lt.s32 %p1, %r3, 1;
; CHECK-NEXT:    mad.lo.s32 %r4, %r2, %r1, %r2;
; CHECK-NEXT:    selp.b32 %r5, %r2, %r4, %p1;
; CHECK-NEXT:    st.param.b32 [func_retval0+0], %r5;
; CHECK-NEXT:    ret;
  %add = add i32 %n, 1
  %cond = icmp slt i32 %s, 1
  %sel = select i1 %cond, i32 1, i32 %add
  %mul = mul i32 %sel, %m
  ret i32 %mul
}

;; Transpose (mul (select)) if it can then be folded to mad
define i32 @test2_rev1(i32 %n, i32 %m, i32 %s) {
;
; CHECK-LABEL: test2_rev1(
; CHECK:       {
; CHECK-NEXT:    .reg .pred %p<2>;
; CHECK-NEXT:    .reg .b32 %r<6>;
; CHECK-EMPTY:
; CHECK-NEXT:  // %bb.0:
; CHECK-NEXT:    ld.param.u32 %r1, [test2_rev1_param_0];
; CHECK-NEXT:    ld.param.u32 %r2, [test2_rev1_param_1];
; CHECK-NEXT:    ld.param.u32 %r3, [test2_rev1_param_2];
; CHECK-NEXT:    setp.lt.s32 %p1, %r3, 1;
; CHECK-NEXT:    mad.lo.s32 %r4, %r2, %r1, %r2;
; CHECK-NEXT:    selp.b32 %r5, %r4, %r2, %p1;
; CHECK-NEXT:    st.param.b32 [func_retval0+0], %r5;
; CHECK-NEXT:    ret;
  %add = add i32 %n, 1
  %cond = icmp slt i32 %s, 1
  %sel = select i1 %cond, i32 %add, i32 1
  %mul = mul i32 %sel, %m
  ret i32 %mul
}

;; Transpose (mul (select)) if it can then be folded to mad
define i32 @test2_rev2(i32 %n, i32 %m, i32 %s) {
;
; CHECK-LABEL: test2_rev2(
; CHECK:       {
; CHECK-NEXT:    .reg .pred %p<2>;
; CHECK-NEXT:    .reg .b32 %r<6>;
; CHECK-EMPTY:
; CHECK-NEXT:  // %bb.0:
; CHECK-NEXT:    ld.param.u32 %r1, [test2_rev2_param_0];
; CHECK-NEXT:    ld.param.u32 %r2, [test2_rev2_param_1];
; CHECK-NEXT:    ld.param.u32 %r3, [test2_rev2_param_2];
; CHECK-NEXT:    setp.lt.s32 %p1, %r3, 1;
; CHECK-NEXT:    mad.lo.s32 %r4, %r2, %r1, %r2;
; CHECK-NEXT:    selp.b32 %r5, %r4, %r2, %p1;
; CHECK-NEXT:    st.param.b32 [func_retval0+0], %r5;
; CHECK-NEXT:    ret;
  %add = add i32 %n, 1
  %cond = icmp slt i32 %s, 1
  %sel = select i1 %cond, i32 %add, i32 1
  %mul = mul i32  %m, %sel
  ret i32 %mul
}

;; Leave (mul (select)) intact if it transposing is not profitable
define i32 @test3(i32 %n, i32 %m, i32 %s) {
;
; CHECK-LABEL: test3(
; CHECK:       {
; CHECK-NEXT:    .reg .pred %p<2>;
; CHECK-NEXT:    .reg .b32 %r<7>;
; CHECK-EMPTY:
; CHECK-NEXT:  // %bb.0:
; CHECK-NEXT:    ld.param.u32 %r1, [test3_param_0];
; CHECK-NEXT:    add.s32 %r2, %r1, 3;
; CHECK-NEXT:    ld.param.u32 %r3, [test3_param_1];
; CHECK-NEXT:    ld.param.u32 %r4, [test3_param_2];
; CHECK-NEXT:    setp.lt.s32 %p1, %r4, 1;
; CHECK-NEXT:    selp.b32 %r5, 1, %r2, %p1;
; CHECK-NEXT:    mul.lo.s32 %r6, %r5, %r3;
; CHECK-NEXT:    st.param.b32 [func_retval0+0], %r6;
; CHECK-NEXT:    ret;
  %add = add i32 %n, 3
  %cond = icmp slt i32 %s, 1
  %sel = select i1 %cond, i32 1, i32 %add
  %mul = mul i32 %sel, %m
  ret i32 %mul
}

;; (add (select 0, (mul a, b)), c) -> (select (mad a, b, c), c)
define i32 @test4(i32 %a, i32 %b, i32 %c, i1 %p) {
; CHECK-LABEL: test4(
; CHECK:       {
; CHECK-NEXT:    .reg .pred %p<2>;
; CHECK-NEXT:    .reg .b16 %rs<3>;
; CHECK-NEXT:    .reg .b32 %r<6>;
; CHECK-EMPTY:
; CHECK-NEXT:  // %bb.0:
; CHECK-NEXT:    ld.param.u8 %rs1, [test4_param_3];
; CHECK-NEXT:    and.b16 %rs2, %rs1, 1;
; CHECK-NEXT:    setp.eq.b16 %p1, %rs2, 1;
; CHECK-NEXT:    ld.param.u32 %r1, [test4_param_0];
; CHECK-NEXT:    ld.param.u32 %r2, [test4_param_1];
; CHECK-NEXT:    ld.param.u32 %r3, [test4_param_2];
; CHECK-NEXT:    mad.lo.s32 %r4, %r1, %r2, %r3;
; CHECK-NEXT:    selp.b32 %r5, %r4, %r3, %p1;
; CHECK-NEXT:    st.param.b32 [func_retval0+0], %r5;
; CHECK-NEXT:    ret;
  %mul = mul i32 %a, %b
  %sel = select i1 %p, i32 %mul, i32 0
  %add = add i32 %c, %sel
  ret i32 %add
}

define i32 @test4_rev(i32 %a, i32 %b, i32 %c, i1 %p) {
; CHECK-LABEL: test4_rev(
; CHECK:       {
; CHECK-NEXT:    .reg .pred %p<2>;
; CHECK-NEXT:    .reg .b16 %rs<3>;
; CHECK-NEXT:    .reg .b32 %r<6>;
; CHECK-EMPTY:
; CHECK-NEXT:  // %bb.0:
; CHECK-NEXT:    ld.param.u8 %rs1, [test4_rev_param_3];
; CHECK-NEXT:    and.b16 %rs2, %rs1, 1;
; CHECK-NEXT:    setp.eq.b16 %p1, %rs2, 1;
; CHECK-NEXT:    ld.param.u32 %r1, [test4_rev_param_0];
; CHECK-NEXT:    ld.param.u32 %r2, [test4_rev_param_1];
; CHECK-NEXT:    ld.param.u32 %r3, [test4_rev_param_2];
; CHECK-NEXT:    mad.lo.s32 %r4, %r1, %r2, %r3;
; CHECK-NEXT:    selp.b32 %r5, %r3, %r4, %p1;
; CHECK-NEXT:    st.param.b32 [func_retval0+0], %r5;
; CHECK-NEXT:    ret;
  %mul = mul i32 %a, %b
  %sel = select i1 %p, i32 0, i32 %mul
  %add = add i32 %c, %sel
  ret i32 %add
}
