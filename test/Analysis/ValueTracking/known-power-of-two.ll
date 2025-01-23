; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 2
; RUN: opt -S -passes=instcombine < %s | FileCheck %s

; https://llvm.org/bugs/show_bug.cgi?id=25900
; An arithmetic shift right of a power of two is not a power
; of two if the original value is the sign bit. Therefore,
; we can't transform the sdiv into a udiv.

declare i16 @llvm.bitreverse.i16(i16)
declare i16 @llvm.bswap.i16(i16)
declare i16 @llvm.ctpop.i16(i16)
declare i16 @llvm.fshl.i16(i16, i16, i16)
declare i16 @llvm.fshr.i16(i16, i16, i16)
declare i16 @llvm.umax.i16(i16, i16)

define i32 @pr25900(i32 %d) {
; CHECK-LABEL: define i32 @pr25900
; CHECK-SAME: (i32 [[D:%.*]]) {
; CHECK-NEXT:    [[AND:%.*]] = ashr i32 [[D]], 31
; CHECK-NEXT:    [[DIV:%.*]] = sdiv i32 4, [[AND]]
; CHECK-NEXT:    ret i32 [[DIV]]
;
  %and = and i32 %d, -2147483648
; The next 3 lines prevent another fold from masking the bug.
  %ext = zext i32 %and to i64
  %or = or i64 %ext, 4294967296
  %trunc = trunc i64 %or to i32
  %ashr = ashr exact i32 %trunc, 31
  %div = sdiv i32 4, %ashr
  ret i32 %div

}

define i8 @trunc_is_pow2_or_zero(i16 %x, i8 %y) {
; CHECK-LABEL: define i8 @trunc_is_pow2_or_zero
; CHECK-SAME: (i16 [[X:%.*]], i8 [[Y:%.*]]) {
; CHECK-NEXT:    [[XP2:%.*]] = shl i16 4, [[X]]
; CHECK-NEXT:    [[XX:%.*]] = trunc i16 [[XP2]] to i8
; CHECK-NEXT:    [[TMP1:%.*]] = add i8 [[XX]], -1
; CHECK-NEXT:    [[R:%.*]] = and i8 [[TMP1]], [[Y]]
; CHECK-NEXT:    ret i8 [[R]]
;
  %xp2 = shl i16 4, %x
  %xx = trunc i16 %xp2 to i8

  %r = urem i8 %y, %xx
  ret i8 %r
}

define i8 @trunc_is_pow2_or_zero_fail(i16 %x, i8 %y) {
; CHECK-LABEL: define i8 @trunc_is_pow2_or_zero_fail
; CHECK-SAME: (i16 [[X:%.*]], i8 [[Y:%.*]]) {
; CHECK-NEXT:    [[XP2:%.*]] = shl i16 5, [[X]]
; CHECK-NEXT:    [[XX:%.*]] = trunc i16 [[XP2]] to i8
; CHECK-NEXT:    [[R:%.*]] = urem i8 [[Y]], [[XX]]
; CHECK-NEXT:    ret i8 [[R]]
;
  %xp2 = shl i16 5, %x
  %xx = trunc i16 %xp2 to i8

  %r = urem i8 %y, %xx
  ret i8 %r
}

define i1 @trunc_is_pow2_fail(i16 %x, i8 %y) {
; CHECK-LABEL: define i1 @trunc_is_pow2_fail
; CHECK-SAME: (i16 [[X:%.*]], i8 [[Y:%.*]]) {
; CHECK-NEXT:    [[XP2:%.*]] = shl i16 4, [[X]]
; CHECK-NEXT:    [[XX:%.*]] = trunc i16 [[XP2]] to i8
; CHECK-NEXT:    [[AND:%.*]] = and i8 [[XX]], [[Y]]
; CHECK-NEXT:    [[R:%.*]] = icmp eq i8 [[AND]], [[XX]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %xp2 = shl i16 4, %x
  %xx = trunc i16 %xp2 to i8

  %and = and i8 %y, %xx
  %r = icmp eq i8 %and, %xx
  ret i1 %r
}

define i16 @bswap_is_pow2_or_zero(i16 %x, i16 %y) {
; CHECK-LABEL: define i16 @bswap_is_pow2_or_zero
; CHECK-SAME: (i16 [[X:%.*]], i16 [[Y:%.*]]) {
; CHECK-NEXT:    [[XP2:%.*]] = shl i16 4, [[X]]
; CHECK-NEXT:    [[XX:%.*]] = call i16 @llvm.bswap.i16(i16 [[XP2]])
; CHECK-NEXT:    [[TMP1:%.*]] = add i16 [[XX]], -1
; CHECK-NEXT:    [[R:%.*]] = and i16 [[TMP1]], [[Y]]
; CHECK-NEXT:    ret i16 [[R]]
;
  %xp2 = shl i16 4, %x
  %xx = call i16 @llvm.bswap.i16(i16 %xp2)

  %r = urem i16 %y, %xx
  ret i16 %r
}

define i16 @bswap_is_pow2_or_zero_fail(i16 %x, i16 %y) {
; CHECK-LABEL: define i16 @bswap_is_pow2_or_zero_fail
; CHECK-SAME: (i16 [[X:%.*]], i16 [[Y:%.*]]) {
; CHECK-NEXT:    [[XP2:%.*]] = shl i16 5, [[X]]
; CHECK-NEXT:    [[XX:%.*]] = call i16 @llvm.bswap.i16(i16 [[XP2]])
; CHECK-NEXT:    [[R:%.*]] = urem i16 [[Y]], [[XX]]
; CHECK-NEXT:    ret i16 [[R]]
;
  %xp2 = shl i16 5, %x
  %xx = call i16 @llvm.bswap.i16(i16 %xp2)

  %r = urem i16 %y, %xx
  ret i16 %r
}

define i1 @bswap_is_pow2(i16 %x, i16 %y) {
; CHECK-LABEL: define i1 @bswap_is_pow2
; CHECK-SAME: (i16 [[X:%.*]], i16 [[Y:%.*]]) {
; CHECK-NEXT:    [[XP2:%.*]] = shl nuw i16 1, [[X]]
; CHECK-NEXT:    [[XX:%.*]] = call i16 @llvm.bswap.i16(i16 [[XP2]])
; CHECK-NEXT:    [[AND:%.*]] = and i16 [[XX]], [[Y]]
; CHECK-NEXT:    [[R:%.*]] = icmp ne i16 [[AND]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %xp2 = shl i16 1, %x
  %xx = call i16 @llvm.bswap.i16(i16 %xp2)

  %and = and i16 %y, %xx
  %r = icmp eq i16 %and, %xx
  ret i1 %r
}

define i1 @bswap_is_pow2_fail(i16 %x, i16 %y) {
; CHECK-LABEL: define i1 @bswap_is_pow2_fail
; CHECK-SAME: (i16 [[X:%.*]], i16 [[Y:%.*]]) {
; CHECK-NEXT:    [[XP2:%.*]] = shl i16 2, [[X]]
; CHECK-NEXT:    [[XX:%.*]] = call i16 @llvm.bswap.i16(i16 [[XP2]])
; CHECK-NEXT:    [[AND:%.*]] = and i16 [[XX]], [[Y]]
; CHECK-NEXT:    [[R:%.*]] = icmp eq i16 [[AND]], [[XX]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %xp2 = shl i16 2, %x
  %xx = call i16 @llvm.bswap.i16(i16 %xp2)

  %and = and i16 %y, %xx
  %r = icmp eq i16 %and, %xx
  ret i1 %r
}

define i16 @bitreverse_is_pow2_or_zero(i16 %x, i16 %y) {
; CHECK-LABEL: define i16 @bitreverse_is_pow2_or_zero
; CHECK-SAME: (i16 [[X:%.*]], i16 [[Y:%.*]]) {
; CHECK-NEXT:    [[XP2:%.*]] = shl i16 4, [[X]]
; CHECK-NEXT:    [[XX:%.*]] = call i16 @llvm.bitreverse.i16(i16 [[XP2]])
; CHECK-NEXT:    [[TMP1:%.*]] = add nsw i16 [[XX]], -1
; CHECK-NEXT:    [[R:%.*]] = and i16 [[TMP1]], [[Y]]
; CHECK-NEXT:    ret i16 [[R]]
;
  %xp2 = shl i16 4, %x
  %xx = call i16 @llvm.bitreverse.i16(i16 %xp2)

  %r = urem i16 %y, %xx
  ret i16 %r
}

define i16 @bitreverse_is_pow2_or_zero_fail(i16 %x, i16 %y) {
; CHECK-LABEL: define i16 @bitreverse_is_pow2_or_zero_fail
; CHECK-SAME: (i16 [[X:%.*]], i16 [[Y:%.*]]) {
; CHECK-NEXT:    [[XP2:%.*]] = shl i16 5, [[X]]
; CHECK-NEXT:    [[XX:%.*]] = call i16 @llvm.bitreverse.i16(i16 [[XP2]])
; CHECK-NEXT:    [[R:%.*]] = urem i16 [[Y]], [[XX]]
; CHECK-NEXT:    ret i16 [[R]]
;
  %xp2 = shl i16 5, %x
  %xx = call i16 @llvm.bitreverse.i16(i16 %xp2)

  %r = urem i16 %y, %xx
  ret i16 %r
}

define i1 @bitreverse_is_pow2(i16 %x, i16 %y) {
; CHECK-LABEL: define i1 @bitreverse_is_pow2
; CHECK-SAME: (i16 [[X:%.*]], i16 [[Y:%.*]]) {
; CHECK-NEXT:    [[XP2:%.*]] = shl nuw i16 1, [[X]]
; CHECK-NEXT:    [[XX:%.*]] = call i16 @llvm.bitreverse.i16(i16 [[XP2]])
; CHECK-NEXT:    [[AND:%.*]] = and i16 [[XX]], [[Y]]
; CHECK-NEXT:    [[R:%.*]] = icmp ne i16 [[AND]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %xp2 = shl i16 1, %x
  %xx = call i16 @llvm.bitreverse.i16(i16 %xp2)

  %and = and i16 %y, %xx
  %r = icmp eq i16 %and, %xx
  ret i1 %r
}

define i1 @bitreverse_is_pow2_fail(i16 %x, i16 %y) {
; CHECK-LABEL: define i1 @bitreverse_is_pow2_fail
; CHECK-SAME: (i16 [[X:%.*]], i16 [[Y:%.*]]) {
; CHECK-NEXT:    [[XP2:%.*]] = shl i16 2, [[X]]
; CHECK-NEXT:    [[XX:%.*]] = call i16 @llvm.bitreverse.i16(i16 [[XP2]])
; CHECK-NEXT:    [[AND:%.*]] = and i16 [[XX]], [[Y]]
; CHECK-NEXT:    [[R:%.*]] = icmp eq i16 [[AND]], [[XX]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %xp2 = shl i16 2, %x
  %xx = call i16 @llvm.bitreverse.i16(i16 %xp2)

  %and = and i16 %y, %xx
  %r = icmp eq i16 %and, %xx
  ret i1 %r
}

define i16 @fshl_is_pow2_or_zero(i16 %x, i16 %y, i16 %z) {
; CHECK-LABEL: define i16 @fshl_is_pow2_or_zero
; CHECK-SAME: (i16 [[X:%.*]], i16 [[Y:%.*]], i16 [[Z:%.*]]) {
; CHECK-NEXT:    [[XP2:%.*]] = shl i16 4, [[X]]
; CHECK-NEXT:    [[XX:%.*]] = call i16 @llvm.fshl.i16(i16 [[XP2]], i16 [[XP2]], i16 [[Z]])
; CHECK-NEXT:    [[TMP1:%.*]] = add i16 [[XX]], -1
; CHECK-NEXT:    [[R:%.*]] = and i16 [[TMP1]], [[Y]]
; CHECK-NEXT:    ret i16 [[R]]
;
  %xp2 = shl i16 4, %x
  %xx = call i16 @llvm.fshl.i16(i16 %xp2, i16 %xp2, i16 %z)

  %r = urem i16 %y, %xx
  ret i16 %r
}

define i16 @fshl_is_pow2_or_zero_fail_not_rotate(i16 %w, i16 %x, i16 %y, i16 %z) {
; CHECK-LABEL: define i16 @fshl_is_pow2_or_zero_fail_not_rotate
; CHECK-SAME: (i16 [[W:%.*]], i16 [[X:%.*]], i16 [[Y:%.*]], i16 [[Z:%.*]]) {
; CHECK-NEXT:    [[XP2:%.*]] = shl i16 4, [[X]]
; CHECK-NEXT:    [[WP2:%.*]] = shl i16 2, [[W]]
; CHECK-NEXT:    [[XX:%.*]] = call i16 @llvm.fshl.i16(i16 [[XP2]], i16 [[WP2]], i16 [[Z]])
; CHECK-NEXT:    [[R:%.*]] = urem i16 [[Y]], [[XX]]
; CHECK-NEXT:    ret i16 [[R]]
;
  %xp2 = shl i16 4, %x
  %wp2 = shl i16 2, %w
  %xx = call i16 @llvm.fshl.i16(i16 %xp2, i16 %wp2, i16 %z)

  %r = urem i16 %y, %xx
  ret i16 %r
}

define i16 @fshl_is_pow2_or_zero_fail(i16 %x, i16 %y, i16 %z) {
; CHECK-LABEL: define i16 @fshl_is_pow2_or_zero_fail
; CHECK-SAME: (i16 [[X:%.*]], i16 [[Y:%.*]], i16 [[Z:%.*]]) {
; CHECK-NEXT:    [[XP2:%.*]] = shl i16 5, [[X]]
; CHECK-NEXT:    [[XX:%.*]] = call i16 @llvm.fshl.i16(i16 [[XP2]], i16 [[XP2]], i16 [[Z]])
; CHECK-NEXT:    [[R:%.*]] = urem i16 [[Y]], [[XX]]
; CHECK-NEXT:    ret i16 [[R]]
;
  %xp2 = shl i16 5, %x
  %xx = call i16 @llvm.fshl.i16(i16 %xp2, i16 %xp2, i16 %z)

  %r = urem i16 %y, %xx
  ret i16 %r
}

define i1 @fshl_is_pow2(i16 %x, i16 %y, i16 %z) {
; CHECK-LABEL: define i1 @fshl_is_pow2
; CHECK-SAME: (i16 [[X:%.*]], i16 [[Y:%.*]], i16 [[Z:%.*]]) {
; CHECK-NEXT:    [[XP2:%.*]] = shl nuw i16 1, [[X]]
; CHECK-NEXT:    [[XX:%.*]] = call i16 @llvm.fshl.i16(i16 [[XP2]], i16 [[XP2]], i16 [[Z]])
; CHECK-NEXT:    [[AND:%.*]] = and i16 [[XX]], [[Y]]
; CHECK-NEXT:    [[R:%.*]] = icmp ne i16 [[AND]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %xp2 = shl i16 1, %x
  %xx = call i16 @llvm.fshl.i16(i16 %xp2, i16 %xp2, i16 %z)

  %and = and i16 %y, %xx
  %r = icmp eq i16 %and, %xx
  ret i1 %r
}

define i1 @fshl_is_pow2_fail(i16 %x, i16 %y, i16 %z) {
; CHECK-LABEL: define i1 @fshl_is_pow2_fail
; CHECK-SAME: (i16 [[X:%.*]], i16 [[Y:%.*]], i16 [[Z:%.*]]) {
; CHECK-NEXT:    [[XP2:%.*]] = shl i16 2, [[X]]
; CHECK-NEXT:    [[XX:%.*]] = call i16 @llvm.fshl.i16(i16 [[XP2]], i16 [[XP2]], i16 [[Z]])
; CHECK-NEXT:    [[AND:%.*]] = and i16 [[XX]], [[Y]]
; CHECK-NEXT:    [[R:%.*]] = icmp eq i16 [[AND]], [[XX]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %xp2 = shl i16 2, %x
  %xx = call i16 @llvm.fshl.i16(i16 %xp2, i16 %xp2, i16 %z)

  %and = and i16 %y, %xx
  %r = icmp eq i16 %and, %xx
  ret i1 %r
}

define i16 @fshr_is_pow2_or_zero(i16 %x, i16 %y, i16 %z) {
; CHECK-LABEL: define i16 @fshr_is_pow2_or_zero
; CHECK-SAME: (i16 [[X:%.*]], i16 [[Y:%.*]], i16 [[Z:%.*]]) {
; CHECK-NEXT:    [[XP2:%.*]] = shl i16 4, [[X]]
; CHECK-NEXT:    [[XX:%.*]] = call i16 @llvm.fshr.i16(i16 [[XP2]], i16 [[XP2]], i16 [[Z]])
; CHECK-NEXT:    [[TMP1:%.*]] = add i16 [[XX]], -1
; CHECK-NEXT:    [[R:%.*]] = and i16 [[TMP1]], [[Y]]
; CHECK-NEXT:    ret i16 [[R]]
;
  %xp2 = shl i16 4, %x
  %xx = call i16 @llvm.fshr.i16(i16 %xp2, i16 %xp2, i16 %z)

  %r = urem i16 %y, %xx
  ret i16 %r
}

define i16 @fshr_is_pow2_or_zero_fail_not_rotate(i16 %w, i16 %x, i16 %y, i16 %z) {
; CHECK-LABEL: define i16 @fshr_is_pow2_or_zero_fail_not_rotate
; CHECK-SAME: (i16 [[W:%.*]], i16 [[X:%.*]], i16 [[Y:%.*]], i16 [[Z:%.*]]) {
; CHECK-NEXT:    [[XP2:%.*]] = shl i16 4, [[X]]
; CHECK-NEXT:    [[WP2:%.*]] = shl i16 2, [[W]]
; CHECK-NEXT:    [[XX:%.*]] = call i16 @llvm.fshr.i16(i16 [[XP2]], i16 [[WP2]], i16 [[Z]])
; CHECK-NEXT:    [[R:%.*]] = urem i16 [[Y]], [[XX]]
; CHECK-NEXT:    ret i16 [[R]]
;
  %xp2 = shl i16 4, %x
  %wp2 = shl i16 2, %w
  %xx = call i16 @llvm.fshr.i16(i16 %xp2, i16 %wp2, i16 %z)

  %r = urem i16 %y, %xx
  ret i16 %r
}

define i16 @fshr_is_pow2_or_zero_fail(i16 %x, i16 %y, i16 %z) {
; CHECK-LABEL: define i16 @fshr_is_pow2_or_zero_fail
; CHECK-SAME: (i16 [[X:%.*]], i16 [[Y:%.*]], i16 [[Z:%.*]]) {
; CHECK-NEXT:    [[XP2:%.*]] = shl i16 5, [[X]]
; CHECK-NEXT:    [[XX:%.*]] = call i16 @llvm.fshr.i16(i16 [[XP2]], i16 [[XP2]], i16 [[Z]])
; CHECK-NEXT:    [[R:%.*]] = urem i16 [[Y]], [[XX]]
; CHECK-NEXT:    ret i16 [[R]]
;
  %xp2 = shl i16 5, %x
  %xx = call i16 @llvm.fshr.i16(i16 %xp2, i16 %xp2, i16 %z)

  %r = urem i16 %y, %xx
  ret i16 %r
}

define i1 @fshr_is_pow2(i16 %x, i16 %y, i16 %z) {
; CHECK-LABEL: define i1 @fshr_is_pow2
; CHECK-SAME: (i16 [[X:%.*]], i16 [[Y:%.*]], i16 [[Z:%.*]]) {
; CHECK-NEXT:    [[XP2:%.*]] = shl nuw i16 1, [[X]]
; CHECK-NEXT:    [[XX:%.*]] = call i16 @llvm.fshr.i16(i16 [[XP2]], i16 [[XP2]], i16 [[Z]])
; CHECK-NEXT:    [[AND:%.*]] = and i16 [[XX]], [[Y]]
; CHECK-NEXT:    [[R:%.*]] = icmp ne i16 [[AND]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %xp2 = shl i16 1, %x
  %xx = call i16 @llvm.fshr.i16(i16 %xp2, i16 %xp2, i16 %z)

  %and = and i16 %y, %xx
  %r = icmp eq i16 %and, %xx
  ret i1 %r
}

define i1 @fshr_is_pow2_fail(i16 %x, i16 %y, i16 %z) {
; CHECK-LABEL: define i1 @fshr_is_pow2_fail
; CHECK-SAME: (i16 [[X:%.*]], i16 [[Y:%.*]], i16 [[Z:%.*]]) {
; CHECK-NEXT:    [[XP2:%.*]] = shl i16 2, [[X]]
; CHECK-NEXT:    [[XX:%.*]] = call i16 @llvm.fshr.i16(i16 [[XP2]], i16 [[XP2]], i16 [[Z]])
; CHECK-NEXT:    [[AND:%.*]] = and i16 [[XX]], [[Y]]
; CHECK-NEXT:    [[R:%.*]] = icmp eq i16 [[AND]], [[XX]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %xp2 = shl i16 2, %x
  %xx = call i16 @llvm.fshr.i16(i16 %xp2, i16 %xp2, i16 %z)

  %and = and i16 %y, %xx
  %r = icmp eq i16 %and, %xx
  ret i1 %r
}

define i16 @mul_is_pow2_or_zero(i16 %x, i16 %y, i16 %z) {
; CHECK-LABEL: define i16 @mul_is_pow2_or_zero
; CHECK-SAME: (i16 [[X:%.*]], i16 [[Y:%.*]], i16 [[Z:%.*]]) {
; CHECK-NEXT:    [[XP2:%.*]] = shl i16 4, [[X]]
; CHECK-NEXT:    [[ZP2:%.*]] = shl i16 2, [[Z]]
; CHECK-NEXT:    [[XX:%.*]] = mul i16 [[XP2]], [[ZP2]]
; CHECK-NEXT:    [[TMP1:%.*]] = add i16 [[XX]], -1
; CHECK-NEXT:    [[R:%.*]] = and i16 [[TMP1]], [[Y]]
; CHECK-NEXT:    ret i16 [[R]]
;
  %xp2 = shl i16 4, %x
  %zp2 = shl i16 2, %z
  %xx = mul i16 %xp2, %zp2

  %r = urem i16 %y, %xx
  ret i16 %r
}

define i16 @mul_is_pow2_or_zero_fail(i16 %x, i16 %y, i16 %z) {
; CHECK-LABEL: define i16 @mul_is_pow2_or_zero_fail
; CHECK-SAME: (i16 [[X:%.*]], i16 [[Y:%.*]], i16 [[Z:%.*]]) {
; CHECK-NEXT:    [[XP2:%.*]] = shl i16 4, [[X]]
; CHECK-NEXT:    [[ZP2:%.*]] = shl i16 5, [[Z]]
; CHECK-NEXT:    [[XX:%.*]] = mul i16 [[XP2]], [[ZP2]]
; CHECK-NEXT:    [[R:%.*]] = urem i16 [[Y]], [[XX]]
; CHECK-NEXT:    ret i16 [[R]]
;
  %xp2 = shl i16 4, %x
  %zp2 = shl i16 5, %z
  %xx = mul i16 %xp2, %zp2

  %r = urem i16 %y, %xx
  ret i16 %r
}

define i1 @mul_is_pow2(i16 %x, i16 %y, i16 %z) {
; CHECK-LABEL: define i1 @mul_is_pow2
; CHECK-SAME: (i16 [[X:%.*]], i16 [[Y:%.*]], i16 [[Z:%.*]]) {
; CHECK-NEXT:    [[XSMALL:%.*]] = and i16 [[X]], 3
; CHECK-NEXT:    [[ZSMALL:%.*]] = and i16 [[Z]], 3
; CHECK-NEXT:    [[ZP2:%.*]] = shl nuw nsw i16 2, [[ZSMALL]]
; CHECK-NEXT:    [[TMP1:%.*]] = add nuw nsw i16 [[XSMALL]], 2
; CHECK-NEXT:    [[XX:%.*]] = shl nuw nsw i16 [[ZP2]], [[TMP1]]
; CHECK-NEXT:    [[AND:%.*]] = and i16 [[XX]], [[Y]]
; CHECK-NEXT:    [[R:%.*]] = icmp ne i16 [[AND]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %xsmall = and i16 %x, 3
  %zsmall = and i16 %z, 3
  %xp2 = shl i16 4, %xsmall
  %zp2 = shl i16 2, %zsmall
  %xx = mul i16 %xp2, %zp2

  %and = and i16 %y, %xx
  %r = icmp eq i16 %and, %xx
  ret i1 %r
}

define i1 @mul_is_pow2_fail(i16 %x, i16 %y, i16 %z) {
; CHECK-LABEL: define i1 @mul_is_pow2_fail
; CHECK-SAME: (i16 [[X:%.*]], i16 [[Y:%.*]], i16 [[Z:%.*]]) {
; CHECK-NEXT:    [[XSMALL:%.*]] = and i16 [[X]], 7
; CHECK-NEXT:    [[ZSMALL:%.*]] = and i16 [[Z]], 7
; CHECK-NEXT:    [[ZP2:%.*]] = shl nuw nsw i16 2, [[ZSMALL]]
; CHECK-NEXT:    [[TMP1:%.*]] = add nuw nsw i16 [[XSMALL]], 2
; CHECK-NEXT:    [[XX:%.*]] = shl i16 [[ZP2]], [[TMP1]]
; CHECK-NEXT:    [[AND:%.*]] = and i16 [[XX]], [[Y]]
; CHECK-NEXT:    [[R:%.*]] = icmp eq i16 [[AND]], [[XX]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %xsmall = and i16 %x, 7
  %zsmall = and i16 %z, 7
  %xp2 = shl i16 4, %xsmall
  %zp2 = shl i16 2, %zsmall
  %xx = mul i16 %xp2, %zp2

  %and = and i16 %y, %xx
  %r = icmp eq i16 %and, %xx
  ret i1 %r
}

define i1 @mul_is_pow2_fail2(i16 %x, i16 %y, i16 %z) {
; CHECK-LABEL: define i1 @mul_is_pow2_fail2
; CHECK-SAME: (i16 [[X:%.*]], i16 [[Y:%.*]], i16 [[Z:%.*]]) {
; CHECK-NEXT:    [[XSMALL:%.*]] = and i16 [[X]], 3
; CHECK-NEXT:    [[ZSMALL:%.*]] = and i16 [[Z]], 3
; CHECK-NEXT:    [[XP2:%.*]] = shl nuw nsw i16 3, [[XSMALL]]
; CHECK-NEXT:    [[TMP1:%.*]] = add nuw nsw i16 [[ZSMALL]], 1
; CHECK-NEXT:    [[XX:%.*]] = shl nuw nsw i16 [[XP2]], [[TMP1]]
; CHECK-NEXT:    [[AND:%.*]] = and i16 [[XX]], [[Y]]
; CHECK-NEXT:    [[R:%.*]] = icmp eq i16 [[AND]], [[XX]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %xsmall = and i16 %x, 3
  %zsmall = and i16 %z, 3
  %xp2 = shl i16 3, %xsmall
  %zp2 = shl i16 2, %zsmall
  %xx = mul i16 %xp2, %zp2

  %and = and i16 %y, %xx
  %r = icmp eq i16 %and, %xx
  ret i1 %r
}

define i1 @shl_is_pow2(i16 %x, i16 %y) {
; CHECK-LABEL: define i1 @shl_is_pow2
; CHECK-SAME: (i16 [[X:%.*]], i16 [[Y:%.*]]) {
; CHECK-NEXT:    [[XSMALL:%.*]] = and i16 [[X]], 7
; CHECK-NEXT:    [[XX:%.*]] = shl nuw nsw i16 4, [[XSMALL]]
; CHECK-NEXT:    [[AND:%.*]] = and i16 [[XX]], [[Y]]
; CHECK-NEXT:    [[R:%.*]] = icmp ne i16 [[AND]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %xsmall = and i16 %x, 7
  %xx = shl i16 4, %xsmall

  %and = and i16 %y, %xx
  %r = icmp eq i16 %and, %xx
  ret i1 %r
}

define i1 @shl_is_pow2_fail(i16 %x, i16 %y) {
; CHECK-LABEL: define i1 @shl_is_pow2_fail
; CHECK-SAME: (i16 [[X:%.*]], i16 [[Y:%.*]]) {
; CHECK-NEXT:    [[XSMALL:%.*]] = and i16 [[X]], 7
; CHECK-NEXT:    [[XX:%.*]] = shl i16 512, [[XSMALL]]
; CHECK-NEXT:    [[AND:%.*]] = and i16 [[XX]], [[Y]]
; CHECK-NEXT:    [[R:%.*]] = icmp eq i16 [[AND]], [[XX]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %xsmall = and i16 %x, 7
  %xx = shl i16 512, %xsmall

  %and = and i16 %y, %xx
  %r = icmp eq i16 %and, %xx
  ret i1 %r
}

define i1 @shl_is_pow2_fail2(i16 %x, i16 %y) {
; CHECK-LABEL: define i1 @shl_is_pow2_fail2
; CHECK-SAME: (i16 [[X:%.*]], i16 [[Y:%.*]]) {
; CHECK-NEXT:    [[XSMALL:%.*]] = and i16 [[X]], 7
; CHECK-NEXT:    [[XX:%.*]] = shl nuw nsw i16 5, [[XSMALL]]
; CHECK-NEXT:    [[AND:%.*]] = and i16 [[XX]], [[Y]]
; CHECK-NEXT:    [[R:%.*]] = icmp eq i16 [[AND]], [[XX]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %xsmall = and i16 %x, 7
  %xx = shl i16 5, %xsmall

  %and = and i16 %y, %xx
  %r = icmp eq i16 %and, %xx
  ret i1 %r
}

define i1 @lshr_is_pow2(i16 %x, i16 %y) {
; CHECK-LABEL: define i1 @lshr_is_pow2
; CHECK-SAME: (i16 [[X:%.*]], i16 [[Y:%.*]]) {
; CHECK-NEXT:    [[XSMALL:%.*]] = and i16 [[X]], 7
; CHECK-NEXT:    [[XX:%.*]] = lshr exact i16 512, [[XSMALL]]
; CHECK-NEXT:    [[AND:%.*]] = and i16 [[XX]], [[Y]]
; CHECK-NEXT:    [[R:%.*]] = icmp ne i16 [[AND]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %xsmall = and i16 %x, 7
  %xx = lshr i16 512, %xsmall

  %and = and i16 %y, %xx
  %r = icmp eq i16 %and, %xx
  ret i1 %r
}

define i1 @lshr_is_pow2_fail(i16 %x, i16 %y) {
; CHECK-LABEL: define i1 @lshr_is_pow2_fail
; CHECK-SAME: (i16 [[X:%.*]], i16 [[Y:%.*]]) {
; CHECK-NEXT:    [[XSMALL:%.*]] = and i16 [[X]], 7
; CHECK-NEXT:    [[XX:%.*]] = lshr i16 4, [[XSMALL]]
; CHECK-NEXT:    [[AND:%.*]] = and i16 [[XX]], [[Y]]
; CHECK-NEXT:    [[R:%.*]] = icmp eq i16 [[AND]], [[XX]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %xsmall = and i16 %x, 7
  %xx = lshr i16 4, %xsmall

  %and = and i16 %y, %xx
  %r = icmp eq i16 %and, %xx
  ret i1 %r
}

define i1 @lshr_is_pow2_fail2(i16 %x, i16 %y) {
; CHECK-LABEL: define i1 @lshr_is_pow2_fail2
; CHECK-SAME: (i16 [[X:%.*]], i16 [[Y:%.*]]) {
; CHECK-NEXT:    [[XSMALL:%.*]] = and i16 [[X]], 7
; CHECK-NEXT:    [[XX:%.*]] = lshr i16 513, [[XSMALL]]
; CHECK-NEXT:    [[AND:%.*]] = and i16 [[XX]], [[Y]]
; CHECK-NEXT:    [[R:%.*]] = icmp eq i16 [[AND]], [[XX]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %xsmall = and i16 %x, 7
  %xx = lshr i16 513, %xsmall

  %and = and i16 %y, %xx
  %r = icmp eq i16 %and, %xx
  ret i1 %r
}

define i1 @and_is_pow2(i16 %x, i16 %y) {
; CHECK-LABEL: define i1 @and_is_pow2
; CHECK-SAME: (i16 [[X:%.*]], i16 [[Y:%.*]]) {
; CHECK-NEXT:    [[XNZ:%.*]] = or i16 [[X]], 4
; CHECK-NEXT:    [[X_NEG:%.*]] = sub nsw i16 0, [[XNZ]]
; CHECK-NEXT:    [[TMP1:%.*]] = and i16 [[X_NEG]], [[Y]]
; CHECK-NEXT:    [[AND:%.*]] = and i16 [[TMP1]], [[XNZ]]
; CHECK-NEXT:    [[R:%.*]] = icmp ne i16 [[AND]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %xnz = or i16 %x, 4
  %x_neg = sub i16 0, %xnz
  %xx = and i16 %xnz, %x_neg

  %and = and i16 %y, %xx
  %r = icmp eq i16 %and, %xx
  ret i1 %r
}

define i1 @and_is_pow2_fail(i16 %x, i16 %y) {
; CHECK-LABEL: define i1 @and_is_pow2_fail
; CHECK-SAME: (i16 [[X:%.*]], i16 [[Y:%.*]]) {
; CHECK-NEXT:    [[X_NEG:%.*]] = sub i16 0, [[X]]
; CHECK-NEXT:    [[XX:%.*]] = and i16 [[X_NEG]], [[X]]
; CHECK-NEXT:    [[AND:%.*]] = and i16 [[XX]], [[Y]]
; CHECK-NEXT:    [[R:%.*]] = icmp eq i16 [[AND]], [[XX]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %x_neg = sub i16 0, %x
  %xx = and i16 %x, %x_neg

  %and = and i16 %y, %xx
  %r = icmp eq i16 %and, %xx
  ret i1 %r
}

define i16 @i1_is_pow2_or_zero(i1 %x, i16 %y) {
; CHECK-LABEL: define i16 @i1_is_pow2_or_zero
; CHECK-SAME: (i1 [[X:%.*]], i16 [[Y:%.*]]) {
; CHECK-NEXT:    [[XX:%.*]] = zext i1 [[X]] to i16
; CHECK-NEXT:    [[R:%.*]] = or i16 [[XX]], [[Y]]
; CHECK-NEXT:    ret i16 [[R]]
;
  %xx = zext i1 %x to i16
  %yy = xor i16 %y, %xx
  %r = call i16 @llvm.umax.i16(i16 %yy, i16 %y)
  ret i16 %r
}

define i16 @i1_is_pow2_or_zero2(i1 %x, i16 %y0, i16 %z) {
; CHECK-LABEL: define i16 @i1_is_pow2_or_zero2
; CHECK-SAME: (i1 [[X:%.*]], i16 [[Y0:%.*]], i16 [[Z:%.*]]) {
; CHECK-NEXT:    [[XX:%.*]] = zext i1 [[X]] to i16
; CHECK-NEXT:    [[Y:%.*]] = or i16 [[Y0]], [[Z]]
; CHECK-NEXT:    [[R:%.*]] = or i16 [[Y]], [[XX]]
; CHECK-NEXT:    ret i16 [[R]]
;
  %xx = zext i1 %x to i16
  %y = or i16 %y0, %z
  %yy = xor i16 %y, %xx
  %r = call i16 @llvm.umax.i16(i16 %yy, i16 %y)
  ret i16 %r
}
