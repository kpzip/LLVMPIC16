; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=indvars < %s | FileCheck %s --check-prefixes=WIDENING_ON
; RUN: opt -S -passes=indvars -indvars-widen-indvars=false < %s | FileCheck %s --check-prefixes=WIDENING_OFF

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128-ni:1-p2:32:8:8:32-ni:2"
target triple = "x86_64-unknown-linux-gnu"

define void @test_01(i32 %start, i32 %limit) {
; WIDENING_ON-LABEL: @test_01(
; WIDENING_ON-NEXT:  bb:
; WIDENING_ON-NEXT:    [[TMP0:%.*]] = zext i32 [[START:%.*]] to i64
; WIDENING_ON-NEXT:    [[TMP1:%.*]] = add nsw i64 [[TMP0]], -1
; WIDENING_ON-NEXT:    [[TMP2:%.*]] = zext i32 [[LIMIT:%.*]] to i64
; WIDENING_ON-NEXT:    [[RANGE_CHECK_WIDE_FIRST_ITER:%.*]] = icmp ult i64 [[TMP1]], [[TMP2]]
; WIDENING_ON-NEXT:    br label [[LOOP:%.*]]
; WIDENING_ON:       loop:
; WIDENING_ON-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[INDVARS_IV_NEXT:%.*]], [[BACKEDGE:%.*]] ], [ [[TMP0]], [[BB:%.*]] ]
; WIDENING_ON-NEXT:    [[INDVARS_IV_NEXT]] = add nsw i64 [[INDVARS_IV]], -1
; WIDENING_ON-NEXT:    [[NOT_ZERO:%.*]] = icmp ne i64 [[INDVARS_IV]], 0
; WIDENING_ON-NEXT:    [[AND:%.*]] = and i1 [[NOT_ZERO]], [[RANGE_CHECK_WIDE_FIRST_ITER]]
; WIDENING_ON-NEXT:    br i1 [[AND]], label [[BACKEDGE]], label [[EXIT:%.*]]
; WIDENING_ON:       backedge:
; WIDENING_ON-NEXT:    br label [[LOOP]]
; WIDENING_ON:       exit:
; WIDENING_ON-NEXT:    ret void
;
; WIDENING_OFF-LABEL: @test_01(
; WIDENING_OFF-NEXT:  bb:
; WIDENING_OFF-NEXT:    [[TMP0:%.*]] = add i32 [[START:%.*]], -1
; WIDENING_OFF-NEXT:    [[RANGE_CHECK_FIRST_ITER:%.*]] = icmp ult i32 [[TMP0]], [[LIMIT:%.*]]
; WIDENING_OFF-NEXT:    br label [[LOOP:%.*]]
; WIDENING_OFF:       loop:
; WIDENING_OFF-NEXT:    [[IV:%.*]] = phi i32 [ [[IV_NEXT:%.*]], [[BACKEDGE:%.*]] ], [ [[START]], [[BB:%.*]] ]
; WIDENING_OFF-NEXT:    [[IV_NEXT]] = add i32 [[IV]], -1
; WIDENING_OFF-NEXT:    [[NOT_ZERO:%.*]] = icmp ne i32 [[IV]], 0
; WIDENING_OFF-NEXT:    [[AND:%.*]] = and i1 [[NOT_ZERO]], [[RANGE_CHECK_FIRST_ITER]]
; WIDENING_OFF-NEXT:    br i1 [[AND]], label [[BACKEDGE]], label [[EXIT:%.*]]
; WIDENING_OFF:       backedge:
; WIDENING_OFF-NEXT:    [[ZEXT:%.*]] = zext i32 [[IV_NEXT]] to i64
; WIDENING_OFF-NEXT:    [[GEP:%.*]] = getelementptr inbounds i32, ptr addrspace(1) poison, i64 [[ZEXT]]
; WIDENING_OFF-NEXT:    br label [[LOOP]]
; WIDENING_OFF:       exit:
; WIDENING_OFF-NEXT:    ret void
;
bb:
  br label %loop

loop:                                              ; preds = %backedge, %bb
  %iv = phi i32 [ %iv.next, %backedge ], [ %start, %bb ]
  %iv.next = add i32 %iv, -1
  %not.zero = icmp ne i32 %iv, 0
  %range.check = icmp ult i32 %iv.next, %limit
  %and = and i1 %not.zero, %range.check
  br i1 %and, label %backedge, label %exit

backedge:                                              ; preds = %loop
  %zext = zext i32 %iv.next to i64
  %gep = getelementptr inbounds i32, ptr addrspace(1) poison, i64 %zext
  br label %loop

exit:                                             ; preds = %loop
  ret void
}

define i32 @test_02(i32 %start, i32 %limit) {
; WIDENING_ON-LABEL: @test_02(
; WIDENING_ON-NEXT:  bb:
; WIDENING_ON-NEXT:    [[TMP0:%.*]] = zext i32 [[START:%.*]] to i64
; WIDENING_ON-NEXT:    br label [[LOOP:%.*]]
; WIDENING_ON:       loop:
; WIDENING_ON-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[INDVARS_IV_NEXT:%.*]], [[BACKEDGE:%.*]] ], [ [[TMP0]], [[BB:%.*]] ]
; WIDENING_ON-NEXT:    [[CANONICAL_IV:%.*]] = phi i32 [ [[CANONICAL_IV_NEXT:%.*]], [[BACKEDGE]] ], [ 0, [[BB]] ]
; WIDENING_ON-NEXT:    [[EXITCOND:%.*]] = icmp ne i32 [[CANONICAL_IV]], 65635
; WIDENING_ON-NEXT:    br i1 [[EXITCOND]], label [[CHECKED:%.*]], label [[FAILED:%.*]]
; WIDENING_ON:       checked:
; WIDENING_ON-NEXT:    [[TMP1:%.*]] = add nsw i64 [[INDVARS_IV]], -1
; WIDENING_ON-NEXT:    [[INDVARS_IV_NEXT]] = add nsw i64 [[INDVARS_IV]], -1
; WIDENING_ON-NEXT:    [[NOT_ZERO:%.*]] = icmp ne i64 [[INDVARS_IV]], 0
; WIDENING_ON-NEXT:    [[TMP2:%.*]] = zext i32 [[LIMIT:%.*]] to i64
; WIDENING_ON-NEXT:    [[RANGE_CHECK_WIDE:%.*]] = icmp ult i64 [[TMP1]], [[TMP2]]
; WIDENING_ON-NEXT:    [[AND:%.*]] = and i1 [[NOT_ZERO]], [[RANGE_CHECK_WIDE]]
; WIDENING_ON-NEXT:    br i1 [[AND]], label [[BACKEDGE]], label [[EXIT:%.*]]
; WIDENING_ON:       backedge:
; WIDENING_ON-NEXT:    [[CANONICAL_IV_NEXT]] = add nuw nsw i32 [[CANONICAL_IV]], 1
; WIDENING_ON-NEXT:    br label [[LOOP]]
; WIDENING_ON:       exit:
; WIDENING_ON-NEXT:    ret i32 0
; WIDENING_ON:       failed:
; WIDENING_ON-NEXT:    ret i32 1
;
; WIDENING_OFF-LABEL: @test_02(
; WIDENING_OFF-NEXT:  bb:
; WIDENING_OFF-NEXT:    br label [[LOOP:%.*]]
; WIDENING_OFF:       loop:
; WIDENING_OFF-NEXT:    [[CANONICAL_IV:%.*]] = phi i32 [ [[CANONICAL_IV_NEXT:%.*]], [[BACKEDGE:%.*]] ], [ 0, [[BB:%.*]] ]
; WIDENING_OFF-NEXT:    [[IV:%.*]] = phi i32 [ [[IV_NEXT:%.*]], [[BACKEDGE]] ], [ [[START:%.*]], [[BB]] ]
; WIDENING_OFF-NEXT:    [[EXITCOND:%.*]] = icmp ne i32 [[CANONICAL_IV]], 65635
; WIDENING_OFF-NEXT:    br i1 [[EXITCOND]], label [[CHECKED:%.*]], label [[FAILED:%.*]]
; WIDENING_OFF:       checked:
; WIDENING_OFF-NEXT:    [[IV_NEXT]] = add i32 [[IV]], -1
; WIDENING_OFF-NEXT:    [[NOT_ZERO:%.*]] = icmp ne i32 [[IV]], 0
; WIDENING_OFF-NEXT:    [[RANGE_CHECK:%.*]] = icmp ult i32 [[IV_NEXT]], [[LIMIT:%.*]]
; WIDENING_OFF-NEXT:    [[AND:%.*]] = and i1 [[NOT_ZERO]], [[RANGE_CHECK]]
; WIDENING_OFF-NEXT:    br i1 [[AND]], label [[BACKEDGE]], label [[EXIT:%.*]]
; WIDENING_OFF:       backedge:
; WIDENING_OFF-NEXT:    [[ZEXT:%.*]] = zext i32 [[IV_NEXT]] to i64
; WIDENING_OFF-NEXT:    [[GEP:%.*]] = getelementptr inbounds i32, ptr addrspace(1) poison, i64 [[ZEXT]]
; WIDENING_OFF-NEXT:    [[CANONICAL_IV_NEXT]] = add nuw nsw i32 [[CANONICAL_IV]], 1
; WIDENING_OFF-NEXT:    br label [[LOOP]]
; WIDENING_OFF:       exit:
; WIDENING_OFF-NEXT:    ret i32 0
; WIDENING_OFF:       failed:
; WIDENING_OFF-NEXT:    ret i32 1
;
bb:
  br label %loop

loop:                                              ; preds = %backedge, %bb
  %canonical_iv = phi i32 [ %canonical_iv.next, %backedge ], [ 0, %bb ]
  %iv = phi i32 [ %iv.next, %backedge ], [ %start, %bb ]
  %canonical_iv_check = icmp ult i32 %canonical_iv, 65635
  br i1 %canonical_iv_check, label %checked, label %failed

checked:
  %iv.next = add i32 %iv, -1
  %not.zero = icmp ne i32 %iv, 0
  %range.check = icmp ult i32 %iv.next, %limit
  %and = and i1 %not.zero, %range.check
  br i1 %and, label %backedge, label %exit

backedge:                                              ; preds = %loop
  %zext = zext i32 %iv.next to i64
  %gep = getelementptr inbounds i32, ptr addrspace(1) poison, i64 %zext
  %canonical_iv.next = add i32 %canonical_iv, 1
  br label %loop

exit:                                             ; preds = %loop
  ret i32 0

failed:
  ret i32 1
}
