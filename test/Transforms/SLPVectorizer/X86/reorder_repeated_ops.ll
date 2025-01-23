; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=slp-vectorizer -S -mtriple=x86_64-unknown-linux-gnu -mcpu=bdver2 < %s | FileCheck %s

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"

define void @hoge() {
; CHECK-LABEL: @hoge(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    br i1 undef, label [[BB1:%.*]], label [[BB2:%.*]]
; CHECK:       bb1:
; CHECK-NEXT:    ret void
; CHECK:       bb2:
; CHECK-NEXT:    [[T:%.*]] = select i1 undef, i16 undef, i16 15
; CHECK-NEXT:    [[T3:%.*]] = sext i16 undef to i32
; CHECK-NEXT:    [[T4:%.*]] = sext i16 [[T]] to i32
; CHECK-NEXT:    [[T5:%.*]] = sub nsw i32 undef, [[T4]]
; CHECK-NEXT:    [[T6:%.*]] = sub i32 [[T5]], undef
; CHECK-NEXT:    [[T7:%.*]] = sub nsw i32 63, [[T3]]
; CHECK-NEXT:    [[T8:%.*]] = sub i32 [[T7]], undef
; CHECK-NEXT:    [[T9:%.*]] = add i32 [[T8]], undef
; CHECK-NEXT:    [[T10:%.*]] = add nsw i32 [[T6]], 15
; CHECK-NEXT:    [[T11:%.*]] = icmp sgt i32 [[T9]], [[T10]]
; CHECK-NEXT:    [[T12:%.*]] = select i1 [[T11]], i32 [[T9]], i32 [[T10]]
; CHECK-NEXT:    [[T13:%.*]] = add nsw i32 [[T6]], 31
; CHECK-NEXT:    [[T14:%.*]] = icmp sgt i32 [[T12]], [[T13]]
; CHECK-NEXT:    [[T15:%.*]] = select i1 [[T14]], i32 [[T12]], i32 [[T13]]
; CHECK-NEXT:    [[T16:%.*]] = add nsw i32 [[T6]], 47
; CHECK-NEXT:    [[T17:%.*]] = icmp sgt i32 [[T15]], [[T16]]
; CHECK-NEXT:    [[T18:%.*]] = select i1 [[T17]], i32 [[T15]], i32 [[T16]]
; CHECK-NEXT:    [[T19:%.*]] = select i1 undef, i32 [[T18]], i32 undef
; CHECK-NEXT:    [[T20:%.*]] = icmp sgt i32 [[T19]], 63
; CHECK-NEXT:    [[T21:%.*]] = sub nsw i32 undef, [[T3]]
; CHECK-NEXT:    [[T22:%.*]] = sub i32 [[T21]], undef
; CHECK-NEXT:    [[T23:%.*]] = sub nsw i32 undef, [[T4]]
; CHECK-NEXT:    [[T24:%.*]] = sub i32 [[T23]], undef
; CHECK-NEXT:    [[T25:%.*]] = add nsw i32 [[T24]], -49
; CHECK-NEXT:    [[T30:%.*]] = add nsw i32 [[T22]], -33
; CHECK-NEXT:    [[T35:%.*]] = add nsw i32 [[T24]], -33
; CHECK-NEXT:    [[T40:%.*]] = add nsw i32 [[T22]], -17
; CHECK-NEXT:    [[OP_RDX:%.*]] = icmp slt i32 undef, [[T25]]
; CHECK-NEXT:    [[OP_RDX1:%.*]] = select i1 [[OP_RDX]], i32 undef, i32 [[T25]]
; CHECK-NEXT:    [[OP_RDX2:%.*]] = icmp slt i32 [[T30]], [[T35]]
; CHECK-NEXT:    [[OP_RDX3:%.*]] = select i1 [[OP_RDX2]], i32 [[T30]], i32 [[T35]]
; CHECK-NEXT:    [[OP_RDX4:%.*]] = icmp slt i32 [[OP_RDX1]], [[OP_RDX3]]
; CHECK-NEXT:    [[OP_RDX5:%.*]] = select i1 [[OP_RDX4]], i32 [[OP_RDX1]], i32 [[OP_RDX3]]
; CHECK-NEXT:    [[OP_RDX6:%.*]] = icmp slt i32 [[OP_RDX5]], [[T40]]
; CHECK-NEXT:    [[OP_RDX7:%.*]] = select i1 [[OP_RDX6]], i32 [[OP_RDX5]], i32 [[T40]]
; CHECK-NEXT:    [[T45:%.*]] = icmp sgt i32 undef, [[OP_RDX7]]
; CHECK-NEXT:    unreachable
;
bb:
  br i1 undef, label %bb1, label %bb2

bb1:                                              ; preds = %bb
  ret void

bb2:                                              ; preds = %bb
  %t = select i1 undef, i16 undef, i16 15
  %t3 = sext i16 undef to i32
  %t4 = sext i16 %t to i32
  %t5 = sub nsw i32 undef, %t4
  %t6 = sub i32 %t5, undef
  %t7 = sub nsw i32 63, %t3
  %t8 = sub i32 %t7, undef
  %t9 = add i32 %t8, undef
  %t10 = add nsw i32 %t6, 15
  %t11 = icmp sgt i32 %t9, %t10
  %t12 = select i1 %t11, i32 %t9, i32 %t10
  %t13 = add nsw i32 %t6, 31
  %t14 = icmp sgt i32 %t12, %t13
  %t15 = select i1 %t14, i32 %t12, i32 %t13
  %t16 = add nsw i32 %t6, 47
  %t17 = icmp sgt i32 %t15, %t16
  %t18 = select i1 %t17, i32 %t15, i32 %t16
  %t19 = select i1 undef, i32 %t18, i32 undef
  %t20 = icmp sgt i32 %t19, 63
  %t21 = sub nsw i32 undef, %t3
  %t22 = sub i32 %t21, undef
  %t23 = sub nsw i32 undef, %t4
  %t24 = sub i32 %t23, undef
  %t25 = add nsw i32 %t24, -49
  %t26 = icmp sgt i32 %t25, undef
  %t27 = select i1 %t26, i32 undef, i32 %t25
  %t28 = icmp sgt i32 %t27, undef
  %t29 = select i1 %t28, i32 undef, i32 %t27
  %t30 = add nsw i32 %t22, -33
  %t31 = icmp sgt i32 %t30, undef
  %t32 = select i1 %t31, i32 undef, i32 %t30
  %t33 = icmp sgt i32 %t32, %t29
  %t34 = select i1 %t33, i32 %t29, i32 %t32
  %t35 = add nsw i32 %t24, -33
  %t36 = icmp sgt i32 %t35, undef
  %t37 = select i1 %t36, i32 undef, i32 %t35
  %t38 = icmp sgt i32 %t37, %t34
  %t39 = select i1 %t38, i32 %t34, i32 %t37
  %t40 = add nsw i32 %t22, -17
  %t41 = icmp sgt i32 %t40, undef
  %t42 = select i1 %t41, i32 undef, i32 %t40
  %t43 = icmp sgt i32 %t42, %t39
  %t44 = select i1 %t43, i32 %t39, i32 %t42
  %t45 = icmp sgt i32 undef, %t44
  unreachable
}

