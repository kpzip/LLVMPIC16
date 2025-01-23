; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --check-globals
; RUN: opt -S -passes="jump-threading" < %s 2>&1 | FileCheck %s

declare void @foobar()

define i32 @func0(i32 %a0, i32 %a1) !prof !0 {
; CHECK-LABEL: @func0(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP0:%.*]] = icmp ne i32 [[A0:%.*]], 0
; CHECK-NEXT:    [[CX:%.*]] = icmp eq i32 [[A0]], 42
; CHECK-NEXT:    br i1 [[CMP0]], label [[BB_JOIN:%.*]], label [[TEST2:%.*]], !prof [[PROF1:![0-9]+]]
; CHECK:       test2:
; CHECK-NEXT:    [[CMP1:%.*]] = icmp ne i32 [[A1:%.*]], 0
; CHECK-NEXT:    br i1 [[CMP1]], label [[BB_JOIN_THREAD:%.*]], label [[TEST2_FALSE:%.*]], !prof [[PROF2:![0-9]+]]
; CHECK:       test2_false:
; CHECK-NEXT:    call void @foobar()
; CHECK-NEXT:    br label [[TMP0:%.*]]
; CHECK:       bb_join:
; CHECK-NEXT:    [[C:%.*]] = phi i1 [ [[CX]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[COND_FR:%.*]] = freeze i1 [[C]]
; CHECK-NEXT:    br i1 [[COND_FR]], label [[BB_JOIN_THREAD]], label [[TMP0]], !prof [[PROF3:![0-9]+]]
; CHECK:       bb_join.thread:
; CHECK-NEXT:    br label [[TMP0]]
; CHECK:       0:
; CHECK-NEXT:    [[TMP1:%.*]] = phi i32 [ 42, [[BB_JOIN_THREAD]] ], [ 7, [[BB_JOIN]] ], [ 7, [[TEST2_FALSE]] ]
; CHECK-NEXT:    ret i32 [[TMP1]]
;
entry:
  %cmp0 = icmp ne i32 %a0, 0
  %cx = icmp eq i32 %a0, 42
  br i1 %cmp0, label %bb_join, label %test2, !prof !1

test2:
  %cmp1 = icmp ne i32 %a1, 0
  br i1 %cmp1, label %bb_join, label %test2_false, !prof !2

test2_false:
  call void @foobar()
  br label %bb_join

bb_join:
  %c = phi i1 [%cx, %entry], [true, %test2], [%cx, %test2_false]
  %val = select i1 %c, i32 42, i32 7, !prof !3
  ret i32 %val
}

!0 = !{!"function_entry_count", i64 1000}
!1 = !{!"branch_weights", i32 400, i32 600}
!2 = !{!"branch_weights", i32 300, i32 300}
!3 = !{!"branch_weights", i32 500, i32 500}
;.
; CHECK: [[META0:![0-9]+]] = !{!"function_entry_count", i64 1000}
; CHECK: [[PROF1]] = !{!"branch_weights", i32 400, i32 600}
; CHECK: [[PROF2]] = !{!"branch_weights", i32 300, i32 300}
; CHECK: [[PROF3]] = !{!"branch_weights", i32 613566756, i32 1533916892}
;.
