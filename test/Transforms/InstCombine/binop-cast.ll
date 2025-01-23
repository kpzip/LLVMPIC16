; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instcombine -S | FileCheck %s

declare void @use(i32)
declare void @use_vec(<2 x i32>)

define i32 @testAdd(i32 %X, i32 %Y) {
; CHECK-LABEL: @testAdd(
; CHECK-NEXT:    [[T:%.*]] = add i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    ret i32 [[T]]
;
  %t = add i32 %X, %Y
  %tl = bitcast i32 %t to i32
  ret i32 %tl
}

define i32 @and_sext_to_sel(i32 %x, i1 %y) {
; CHECK-LABEL: @and_sext_to_sel(
; CHECK-NEXT:    [[R:%.*]] = select i1 [[Y:%.*]], i32 [[X:%.*]], i32 0
; CHECK-NEXT:    ret i32 [[R]]
;
  %sext = sext i1 %y to i32
  %r = and i32 %sext, %x
  ret i32 %r
}

define <2 x i32> @and_sext_to_sel_constant_vec(<2 x i1> %y) {
; CHECK-LABEL: @and_sext_to_sel_constant_vec(
; CHECK-NEXT:    [[R:%.*]] = select <2 x i1> [[Y:%.*]], <2 x i32> <i32 42, i32 -7>, <2 x i32> zeroinitializer
; CHECK-NEXT:    ret <2 x i32> [[R]]
;
  %sext = sext <2 x i1> %y to <2 x i32>
  %r = and <2 x i32> <i32 42, i32 -7>, %sext
  ret <2 x i32> %r
}

define <2 x i32> @and_sext_to_sel_swap(<2 x i32> %px, <2 x i1> %y) {
; CHECK-LABEL: @and_sext_to_sel_swap(
; CHECK-NEXT:    [[X:%.*]] = mul <2 x i32> [[PX:%.*]], [[PX]]
; CHECK-NEXT:    [[R:%.*]] = select <2 x i1> [[Y:%.*]], <2 x i32> [[X]], <2 x i32> zeroinitializer
; CHECK-NEXT:    ret <2 x i32> [[R]]
;
  %x = mul <2 x i32> %px, %px ; thwart complexity-based canonicalization
  %sext = sext <2 x i1> %y to <2 x i32>
  %r = and <2 x i32> %x, %sext
  ret <2 x i32> %r
}

define i32 @and_sext_to_sel_multi_use(i32 %x, i1 %y) {
; CHECK-LABEL: @and_sext_to_sel_multi_use(
; CHECK-NEXT:    [[SEXT:%.*]] = sext i1 [[Y:%.*]] to i32
; CHECK-NEXT:    call void @use(i32 [[SEXT]])
; CHECK-NEXT:    [[R:%.*]] = select i1 [[Y]], i32 [[X:%.*]], i32 0
; CHECK-NEXT:    ret i32 [[R]]
;
  %sext = sext i1 %y to i32
  call void @use(i32 %sext)
  %r = and i32 %sext, %x
  ret i32 %r
}

define i32 @and_sext_to_sel_multi_use_constant_mask(i1 %y) {
; CHECK-LABEL: @and_sext_to_sel_multi_use_constant_mask(
; CHECK-NEXT:    [[SEXT:%.*]] = sext i1 [[Y:%.*]] to i32
; CHECK-NEXT:    call void @use(i32 [[SEXT]])
; CHECK-NEXT:    [[R:%.*]] = select i1 [[Y]], i32 42, i32 0
; CHECK-NEXT:    ret i32 [[R]]
;
  %sext = sext i1 %y to i32
  call void @use(i32 %sext)
  %r = and i32 %sext, 42
  ret i32 %r
}

define <2 x i32> @and_not_sext_to_sel(<2 x i32> %x, <2 x i1> %y) {
; CHECK-LABEL: @and_not_sext_to_sel(
; CHECK-NEXT:    [[SEXT:%.*]] = sext <2 x i1> [[Y:%.*]] to <2 x i32>
; CHECK-NEXT:    call void @use_vec(<2 x i32> [[SEXT]])
; CHECK-NEXT:    [[R:%.*]] = select <2 x i1> [[Y]], <2 x i32> zeroinitializer, <2 x i32> [[X:%.*]]
; CHECK-NEXT:    ret <2 x i32> [[R]]
;
  %sext = sext <2 x i1> %y to <2 x i32>
  call void @use_vec(<2 x i32> %sext)
  %not = xor <2 x i32> %sext, <i32 -1, i32 -1>
  %r = and <2 x i32> %not, %x
  ret <2 x i32> %r
}

define i32 @and_not_sext_to_sel_commute(i32 %px, i1 %y) {
; CHECK-LABEL: @and_not_sext_to_sel_commute(
; CHECK-NEXT:    [[X:%.*]] = mul i32 [[PX:%.*]], [[PX]]
; CHECK-NEXT:    [[SEXT:%.*]] = sext i1 [[Y:%.*]] to i32
; CHECK-NEXT:    call void @use(i32 [[SEXT]])
; CHECK-NEXT:    [[NOT:%.*]] = xor i32 [[SEXT]], -1
; CHECK-NEXT:    call void @use(i32 [[NOT]])
; CHECK-NEXT:    [[R:%.*]] = select i1 [[Y]], i32 0, i32 [[X]]
; CHECK-NEXT:    ret i32 [[R]]
;
  %x = mul i32 %px, %px ; thwart complexity-based canonicalization
  %sext = sext i1 %y to i32
  call void @use(i32 %sext)
  %not = xor i32 %sext, -1
  call void @use(i32 %not)
  %r = and i32 %x, %not
  ret i32 %r
}

; negative test - must be 'not'

define i32 @and_xor_sext_to_sel(i32 %x, i1 %y) {
; CHECK-LABEL: @and_xor_sext_to_sel(
; CHECK-NEXT:    [[SEXT:%.*]] = sext i1 [[Y:%.*]] to i32
; CHECK-NEXT:    call void @use(i32 [[SEXT]])
; CHECK-NEXT:    [[XOR:%.*]] = xor i32 [[SEXT]], -2
; CHECK-NEXT:    [[R:%.*]] = and i32 [[XOR]], [[X:%.*]]
; CHECK-NEXT:    ret i32 [[R]]
;
  %sext = sext i1 %y to i32
  call void @use(i32 %sext)
  %xor = xor i32 %sext, -2
  %r = and i32 %xor, %x
  ret i32 %r
}

; negative test - must be 'sext'

define i32 @and_not_zext_to_sel(i32 %x, i1 %y) {
; CHECK-LABEL: @and_not_zext_to_sel(
; CHECK-NEXT:    [[ZEXT:%.*]] = zext i1 [[Y:%.*]] to i32
; CHECK-NEXT:    call void @use(i32 [[ZEXT]])
; CHECK-NEXT:    [[NOT:%.*]] = xor i32 [[ZEXT]], -1
; CHECK-NEXT:    [[R:%.*]] = and i32 [[NOT]], [[X:%.*]]
; CHECK-NEXT:    ret i32 [[R]]
;
  %zext = zext i1 %y to i32
  call void @use(i32 %zext)
  %not = xor i32 %zext, -1
  %r = and i32 %not, %x
  ret i32 %r
}

define i32 @or_sext_to_sel(i32 %x, i1 %y) {
; CHECK-LABEL: @or_sext_to_sel(
; CHECK-NEXT:    [[R:%.*]] = select i1 [[Y:%.*]], i32 -1, i32 [[X:%.*]]
; CHECK-NEXT:    ret i32 [[R]]
;
  %sext = sext i1 %y to i32
  %r = or i32 %sext, %x
  ret i32 %r
}

define <2 x i32> @or_sext_to_sel_constant_vec(<2 x i1> %y) {
; CHECK-LABEL: @or_sext_to_sel_constant_vec(
; CHECK-NEXT:    [[R:%.*]] = select <2 x i1> [[Y:%.*]], <2 x i32> <i32 -1, i32 -1>, <2 x i32> <i32 42, i32 -7>
; CHECK-NEXT:    ret <2 x i32> [[R]]
;
  %sext = sext <2 x i1> %y to <2 x i32>
  %r = or <2 x i32> <i32 42, i32 -7>, %sext
  ret <2 x i32> %r
}

define <2 x i32> @or_sext_to_sel_swap(<2 x i32> %px, <2 x i1> %y) {
; CHECK-LABEL: @or_sext_to_sel_swap(
; CHECK-NEXT:    [[X:%.*]] = mul <2 x i32> [[PX:%.*]], [[PX]]
; CHECK-NEXT:    [[R:%.*]] = select <2 x i1> [[Y:%.*]], <2 x i32> <i32 -1, i32 -1>, <2 x i32> [[X]]
; CHECK-NEXT:    ret <2 x i32> [[R]]
;
  %x = mul <2 x i32> %px, %px ; thwart complexity-based canonicalization
  %sext = sext <2 x i1> %y to <2 x i32>
  %r = or <2 x i32> %x, %sext
  ret <2 x i32> %r
}

define i32 @or_sext_to_sel_multi_use(i32 %x, i1 %y) {
; CHECK-LABEL: @or_sext_to_sel_multi_use(
; CHECK-NEXT:    [[SEXT:%.*]] = sext i1 [[Y:%.*]] to i32
; CHECK-NEXT:    call void @use(i32 [[SEXT]])
; CHECK-NEXT:    [[R:%.*]] = or i32 [[SEXT]], [[X:%.*]]
; CHECK-NEXT:    ret i32 [[R]]
;
  %sext = sext i1 %y to i32
  call void @use(i32 %sext)
  %r = or i32 %sext, %x
  ret i32 %r
}

define i32 @or_sext_to_sel_multi_use_constant_mask(i1 %y) {
; CHECK-LABEL: @or_sext_to_sel_multi_use_constant_mask(
; CHECK-NEXT:    [[SEXT:%.*]] = sext i1 [[Y:%.*]] to i32
; CHECK-NEXT:    call void @use(i32 [[SEXT]])
; CHECK-NEXT:    [[R:%.*]] = select i1 [[Y]], i32 -1, i32 42
; CHECK-NEXT:    ret i32 [[R]]
;
  %sext = sext i1 %y to i32
  call void @use(i32 %sext)
  %r = or i32 %sext, 42
  ret i32 %r
}

define i32 @xor_sext_to_sel(i32 %x, i1 %y) {
; CHECK-LABEL: @xor_sext_to_sel(
; CHECK-NEXT:    [[SEXT:%.*]] = sext i1 [[Y:%.*]] to i32
; CHECK-NEXT:    [[R:%.*]] = xor i32 [[SEXT]], [[X:%.*]]
; CHECK-NEXT:    ret i32 [[R]]
;
  %sext = sext i1 %y to i32
  %r = xor i32 %sext, %x
  ret i32 %r
}

define <2 x i32> @xor_sext_to_sel_constant_vec(<2 x i1> %y) {
; CHECK-LABEL: @xor_sext_to_sel_constant_vec(
; CHECK-NEXT:    [[SEXT:%.*]] = sext <2 x i1> [[Y:%.*]] to <2 x i32>
; CHECK-NEXT:    [[R:%.*]] = xor <2 x i32> [[SEXT]], <i32 42, i32 -7>
; CHECK-NEXT:    ret <2 x i32> [[R]]
;
  %sext = sext <2 x i1> %y to <2 x i32>
  %r = xor <2 x i32> <i32 42, i32 -7>, %sext
  ret <2 x i32> %r
}

define <2 x i32> @xor_sext_to_sel_swap(<2 x i32> %px, <2 x i1> %y) {
; CHECK-LABEL: @xor_sext_to_sel_swap(
; CHECK-NEXT:    [[X:%.*]] = mul <2 x i32> [[PX:%.*]], [[PX]]
; CHECK-NEXT:    [[SEXT:%.*]] = sext <2 x i1> [[Y:%.*]] to <2 x i32>
; CHECK-NEXT:    [[R:%.*]] = xor <2 x i32> [[X]], [[SEXT]]
; CHECK-NEXT:    ret <2 x i32> [[R]]
;
  %x = mul <2 x i32> %px, %px ; thwart complexity-based canonicalization
  %sext = sext <2 x i1> %y to <2 x i32>
  %r = xor <2 x i32> %x, %sext
  ret <2 x i32> %r
}

define i32 @xor_sext_to_sel_multi_use(i32 %x, i1 %y) {
; CHECK-LABEL: @xor_sext_to_sel_multi_use(
; CHECK-NEXT:    [[SEXT:%.*]] = sext i1 [[Y:%.*]] to i32
; CHECK-NEXT:    call void @use(i32 [[SEXT]])
; CHECK-NEXT:    [[R:%.*]] = xor i32 [[SEXT]], [[X:%.*]]
; CHECK-NEXT:    ret i32 [[R]]
;
  %sext = sext i1 %y to i32
  call void @use(i32 %sext)
  %r = xor i32 %sext, %x
  ret i32 %r
}

define i32 @xor_sext_to_sel_multi_use_constant_mask(i1 %y) {
; CHECK-LABEL: @xor_sext_to_sel_multi_use_constant_mask(
; CHECK-NEXT:    [[SEXT:%.*]] = sext i1 [[Y:%.*]] to i32
; CHECK-NEXT:    call void @use(i32 [[SEXT]])
; CHECK-NEXT:    [[R:%.*]] = xor i32 [[SEXT]], 42
; CHECK-NEXT:    ret i32 [[R]]
;
  %sext = sext i1 %y to i32
  call void @use(i32 %sext)
  %r = xor i32 %sext, 42
  ret i32 %r
}

define i64 @PR63321(ptr %ptr, i64 %c) {
; CHECK-LABEL: @PR63321(
; CHECK-NEXT:    [[VAL:%.*]] = load i8, ptr [[PTR:%.*]], align 1, !range [[RNG0:![0-9]+]]
; CHECK-NEXT:    [[TMP1:%.*]] = icmp eq i8 [[VAL]], 0
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[TMP1]], i64 [[C:%.*]], i64 0
; CHECK-NEXT:    ret i64 [[RES]]
;
  %val = load i8, ptr %ptr, align 1, !range !{i8 0, i8 2}
  %rhs = zext i8 %val to i64
  %mask = add i64 -1, %rhs
  %res = and i64 %mask, %c
  ret i64 %res
}

; Negative test of PR63321
define i64 @and_add_non_bool(ptr %ptr, i64 %c) {
; CHECK-LABEL: @and_add_non_bool(
; CHECK-NEXT:    [[VAL:%.*]] = load i8, ptr [[PTR:%.*]], align 1, !range [[RNG1:![0-9]+]]
; CHECK-NEXT:    [[RHS:%.*]] = zext nneg i8 [[VAL]] to i64
; CHECK-NEXT:    [[MASK:%.*]] = add nsw i64 [[RHS]], -1
; CHECK-NEXT:    [[RES:%.*]] = and i64 [[MASK]], [[C:%.*]]
; CHECK-NEXT:    ret i64 [[RES]]
;
  %val = load i8, ptr %ptr, align 1, !range !{i8 0, i8 3}
  %rhs = zext i8 %val to i64
  %mask = add i64 -1, %rhs
  %res = and i64 %mask, %c
  ret i64 %res
}

define i32 @and_add_bool_to_select(i1 %x, i32 %y) {
; CHECK-LABEL: @and_add_bool_to_select(
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[X:%.*]], i32 0, i32 [[Y:%.*]]
; CHECK-NEXT:    ret i32 [[RES]]
;
  %val = zext i1 %x to i32
  %mask = add i32 -1, %val
  %res = and i32 %mask, %y
  ret i32 %res
}

define i32 @and_add_bool_no_fold(i32 %y) {
; CHECK-LABEL: @and_add_bool_no_fold(
; CHECK-NEXT:    [[X:%.*]] = and i32 [[Y:%.*]], 1
; CHECK-NEXT:    [[TMP1:%.*]] = icmp eq i32 [[X]], 0
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[TMP1]], i32 [[Y]], i32 0
; CHECK-NEXT:    ret i32 [[RES]]
;
  %x = and i32 %y, 1
  %mask = add i32 -1, %x
  %res = and i32 %mask, %y
  ret i32 %res
}

define <2 x i32> @and_add_bool_vec_to_select(<2 x i1> %x, <2 x i32> %y) {
; CHECK-LABEL: @and_add_bool_vec_to_select(
; CHECK-NEXT:    [[RES:%.*]] = select <2 x i1> [[X:%.*]], <2 x i32> zeroinitializer, <2 x i32> [[Y:%.*]]
; CHECK-NEXT:    ret <2 x i32> [[RES]]
;
  %val = zext <2 x i1> %x to <2 x i32>
  %mask = add <2 x i32> <i32 -1, i32 -1>, %val
  %res = and <2 x i32> %mask, %y
  ret <2 x i32> %res
}

; Negative test of and_add_bool_to_select
define i32 @and_add_bool_to_select_multi_use(i1 %x, i32 %y) {
; CHECK-LABEL: @and_add_bool_to_select_multi_use(
; CHECK-NEXT:    [[TMP1:%.*]] = add i32 [[Y:%.*]], -1
; CHECK-NEXT:    [[RET:%.*]] = select i1 [[X:%.*]], i32 0, i32 [[TMP1]]
; CHECK-NEXT:    ret i32 [[RET]]
;
  %val = zext i1 %x to i32
  %mask = add i32 -1, %val
  %res = and i32 %mask, %y
  %ret = add i32 %res, %mask
  ret i32 %ret
}
