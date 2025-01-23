; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -S -passes=instcombine | FileCheck %s

declare i32 @llvm.ctpop.i32(i32)
declare <2 x i32> @llvm.ctpop.v2i32(<2 x i32>)

; PR43513
; __builtin_popcount(i | -i) -> 32 - __builtin_cttz(i, false)
define i32 @ctpop1(i32 %0) {
; CHECK-LABEL: @ctpop1(
; CHECK-NEXT:    [[TMP2:%.*]] = call range(i32 0, 33) i32 @llvm.cttz.i32(i32 [[TMP0:%.*]], i1 false)
; CHECK-NEXT:    ret i32 [[TMP2]]
;
  %2 = sub i32 0, %0
  %3 = or i32 %0, %2
  %4 = tail call i32 @llvm.ctpop.i32(i32 %3)
  %5 = sub i32 32, %4
  ret i32 %5
}

define <2 x i32> @ctpop1v(<2 x i32> %0) {
; CHECK-LABEL: @ctpop1v(
; CHECK-NEXT:    [[TMP2:%.*]] = call range(i32 0, 33) <2 x i32> @llvm.cttz.v2i32(<2 x i32> [[TMP0:%.*]], i1 false)
; CHECK-NEXT:    [[TMP3:%.*]] = sub nuw nsw <2 x i32> <i32 32, i32 32>, [[TMP2]]
; CHECK-NEXT:    ret <2 x i32> [[TMP3]]
;
  %2 = sub <2 x i32> zeroinitializer, %0
  %3 = or <2 x i32> %2, %0
  %4 = tail call <2 x i32> @llvm.ctpop.v2i32(<2 x i32> %3)
  ret <2 x i32> %4
}

define i32 @ctpop1_multiuse(i32 %0) {
; CHECK-LABEL: @ctpop1_multiuse(
; CHECK-NEXT:    [[TMP2:%.*]] = sub i32 0, [[TMP0:%.*]]
; CHECK-NEXT:    [[TMP3:%.*]] = or i32 [[TMP2]], [[TMP0]]
; CHECK-NEXT:    [[TMP4:%.*]] = xor i32 [[TMP3]], -1
; CHECK-NEXT:    [[TMP5:%.*]] = call range(i32 0, 33) i32 @llvm.ctpop.i32(i32 [[TMP4]])
; CHECK-NEXT:    [[TMP6:%.*]] = add i32 [[TMP5]], [[TMP3]]
; CHECK-NEXT:    ret i32 [[TMP6]]
;
  %2 = sub i32 0, %0
  %3 = or i32 %0, %2
  %4 = tail call i32 @llvm.ctpop.i32(i32 %3)
  %5 = sub i32 32, %4
  %6 = add i32 %5, %3
  ret i32 %6
}

; PR43513
; __builtin_popcount(~i & (i-1)) -> __builtin_cttz(i, false)
define i32 @ctpop2(i32 %0) {
; CHECK-LABEL: @ctpop2(
; CHECK-NEXT:    [[TMP2:%.*]] = call range(i32 0, 33) i32 @llvm.cttz.i32(i32 [[TMP0:%.*]], i1 false)
; CHECK-NEXT:    ret i32 [[TMP2]]
;
  %2 = xor i32 %0, -1
  %3 = sub i32 %0, 1
  %4 = and i32 %3, %2
  %5 = tail call i32 @llvm.ctpop.i32(i32 %4)
  ret i32 %5
}

define <2 x i32> @ctpop2v(<2 x i32> %0) {
; CHECK-LABEL: @ctpop2v(
; CHECK-NEXT:    [[TMP2:%.*]] = call range(i32 0, 33) <2 x i32> @llvm.cttz.v2i32(<2 x i32> [[TMP0:%.*]], i1 false)
; CHECK-NEXT:    ret <2 x i32> [[TMP2]]
;
  %2 = xor <2 x i32> %0, <i32 -1, i32 -1>
  %3 = add <2 x i32> %0, <i32 -1, i32 -1>
  %4 = and <2 x i32> %2, %3
  %5 = tail call <2 x i32> @llvm.ctpop.v2i32(<2 x i32> %4)
  ret <2 x i32> %5
}

define i32 @ctpop2_multiuse(i32 %0) {
; CHECK-LABEL: @ctpop2_multiuse(
; CHECK-NEXT:    [[TMP2:%.*]] = xor i32 [[TMP0:%.*]], -1
; CHECK-NEXT:    [[TMP3:%.*]] = add i32 [[TMP0]], -1
; CHECK-NEXT:    [[TMP4:%.*]] = and i32 [[TMP3]], [[TMP2]]
; CHECK-NEXT:    [[TMP5:%.*]] = call range(i32 0, 33) i32 @llvm.cttz.i32(i32 [[TMP0]], i1 false)
; CHECK-NEXT:    [[TMP6:%.*]] = add i32 [[TMP5]], [[TMP4]]
; CHECK-NEXT:    ret i32 [[TMP6]]
;
  %2 = xor i32 %0, -1
  %3 = sub i32 %0, 1
  %4 = and i32 %3, %2
  %5 = tail call i32 @llvm.ctpop.i32(i32 %4)
  %6 = add i32 %5, %4
  ret i32 %6
}

; PR51784
; __builtin_popcount((i & -i) - 1) -> __builtin_cttz(i, false)
define i32 @ctpop3(i32 %0) {
; CHECK-LABEL: @ctpop3(
; CHECK-NEXT:    [[TMP2:%.*]] = call range(i32 0, 33) i32 @llvm.cttz.i32(i32 [[TMP0:%.*]], i1 false)
; CHECK-NEXT:    ret i32 [[TMP2]]
;
  %2 = sub i32 0, %0
  %3 = and i32 %2, %0
  %4 = add i32 %3, -1
  %5 = tail call i32 @llvm.ctpop.i32(i32 %4)
  ret i32 %5
}

define <2 x i32> @ctpop3v(<2 x i32> %0) {
; CHECK-LABEL: @ctpop3v(
; CHECK-NEXT:    [[TMP2:%.*]] = call range(i32 0, 33) <2 x i32> @llvm.cttz.v2i32(<2 x i32> [[TMP0:%.*]], i1 false)
; CHECK-NEXT:    ret <2 x i32> [[TMP2]]
;
  %2 = sub <2 x i32> zeroinitializer, %0
  %3 = and <2 x i32> %2, %0
  %4 = add <2 x i32> %3, <i32 -1, i32 -1>
  %5 = tail call <2 x i32> @llvm.ctpop.v2i32(<2 x i32> %4)
  ret <2 x i32> %5
}

define <2 x i32> @ctpop3v_poison(<2 x i32> %0) {
; CHECK-LABEL: @ctpop3v_poison(
; CHECK-NEXT:    [[TMP2:%.*]] = call range(i32 0, 33) <2 x i32> @llvm.cttz.v2i32(<2 x i32> [[TMP0:%.*]], i1 false)
; CHECK-NEXT:    ret <2 x i32> [[TMP2]]
;
  %2 = sub <2 x i32> zeroinitializer, %0
  %3 = and <2 x i32> %2, %0
  %4 = add <2 x i32> %3, <i32 -1, i32 poison>
  %5 = tail call <2 x i32> @llvm.ctpop.v2i32(<2 x i32> %4)
  ret <2 x i32> %5
}
