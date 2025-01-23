; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 5
; RUN: opt < %s -passes=simplifycfg -simplifycfg-require-and-preserve-domtree=1 -S | FileCheck %s

define void @fold_nested_branch(i1 %cond1, i1 %cond2) {
; CHECK-LABEL: define void @fold_nested_branch(
; CHECK-SAME: i1 [[COND1:%.*]], i1 [[COND2:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    [[TMP0:%.*]] = xor i1 [[COND1]], [[COND2]]
; CHECK-NEXT:    br i1 [[TMP0]], label %[[BB4:.*]], label %[[BB3:.*]]
; CHECK:       [[COMMON_RET:.*]]:
; CHECK-NEXT:    ret void
; CHECK:       [[BB3]]:
; CHECK-NEXT:    call void @sideeffect1()
; CHECK-NEXT:    br label %[[COMMON_RET]]
; CHECK:       [[BB4]]:
; CHECK-NEXT:    call void @sideeffect2()
; CHECK-NEXT:    br label %[[COMMON_RET]]
;
entry:
  br i1 %cond1, label %bb1, label %bb2

bb1:
  br i1 %cond2, label %bb3, label %bb4

bb2:
  br i1 %cond2, label %bb4, label %bb3

bb3:
  call void @sideeffect1()
  ret void

bb4:
  call void @sideeffect2()
  ret void
}

define void @fold_nested_branch_extra_predecessors(i1 %cond0, i1 %cond1, i1 %cond2) {
; CHECK-LABEL: define void @fold_nested_branch_extra_predecessors(
; CHECK-SAME: i1 [[COND0:%.*]], i1 [[COND1:%.*]], i1 [[COND2:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    br i1 [[COND0]], label %[[BB0:.*]], label %[[BB1_PRED:.*]]
; CHECK:       [[BB1_PRED]]:
; CHECK-NEXT:    call void @sideeffect1()
; CHECK-NEXT:    br i1 [[COND2]], label %[[BB3:.*]], label %[[BB4:.*]]
; CHECK:       [[BB0]]:
; CHECK-NEXT:    [[TMP0:%.*]] = xor i1 [[COND1]], [[COND2]]
; CHECK-NEXT:    br i1 [[TMP0]], label %[[BB4]], label %[[BB3]]
; CHECK:       [[COMMON_RET:.*]]:
; CHECK-NEXT:    ret void
; CHECK:       [[BB3]]:
; CHECK-NEXT:    call void @sideeffect1()
; CHECK-NEXT:    br label %[[COMMON_RET]]
; CHECK:       [[BB4]]:
; CHECK-NEXT:    call void @sideeffect2()
; CHECK-NEXT:    br label %[[COMMON_RET]]
;
entry:
  br i1 %cond0, label %bb0, label %bb1_pred

bb1_pred:
  call void @sideeffect1()
  br label %bb1

bb0:
  br i1 %cond1, label %bb1, label %bb2

bb1:
  br i1 %cond2, label %bb3, label %bb4

bb2:
  br i1 %cond2, label %bb4, label %bb3

bb3:
  call void @sideeffect1()
  ret void

bb4:
  call void @sideeffect2()
  ret void
}

; Negative tests

define void @fold_nested_branch_cfg_mismatch(i1 %cond1, i1 %cond2) {
; CHECK-LABEL: define void @fold_nested_branch_cfg_mismatch(
; CHECK-SAME: i1 [[COND1:%.*]], i1 [[COND2:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    br i1 [[COND1]], label %[[BB1:.*]], label %[[BB2:.*]]
; CHECK:       [[BB1]]:
; CHECK-NEXT:    br i1 [[COND2]], label %[[BB3:.*]], label %[[COMMON_RET:.*]]
; CHECK:       [[BB2]]:
; CHECK-NEXT:    br i1 [[COND2]], label %[[BB4:.*]], label %[[BB3]]
; CHECK:       [[COMMON_RET]]:
; CHECK-NEXT:    ret void
; CHECK:       [[BB3]]:
; CHECK-NEXT:    call void @sideeffect1()
; CHECK-NEXT:    br label %[[COMMON_RET]]
; CHECK:       [[BB4]]:
; CHECK-NEXT:    call void @sideeffect2()
; CHECK-NEXT:    br label %[[COMMON_RET]]
;
entry:
  br i1 %cond1, label %bb1, label %bb2

bb1:
  br i1 %cond2, label %bb3, label %bb5

bb2:
  br i1 %cond2, label %bb4, label %bb3

bb3:
  call void @sideeffect1()
  ret void

bb4:
  call void @sideeffect2()
  ret void

bb5:
  ret void
}

define void @fold_nested_branch_cond_mismatch(i1 %cond1, i1 %cond2, i1 %cond3) {
; CHECK-LABEL: define void @fold_nested_branch_cond_mismatch(
; CHECK-SAME: i1 [[COND1:%.*]], i1 [[COND2:%.*]], i1 [[COND3:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    br i1 [[COND1]], label %[[BB1:.*]], label %[[BB2:.*]]
; CHECK:       [[BB1]]:
; CHECK-NEXT:    br i1 [[COND2]], label %[[BB3:.*]], label %[[BB4:.*]]
; CHECK:       [[BB2]]:
; CHECK-NEXT:    br i1 [[COND3]], label %[[BB4]], label %[[BB3]]
; CHECK:       [[COMMON_RET:.*]]:
; CHECK-NEXT:    ret void
; CHECK:       [[BB3]]:
; CHECK-NEXT:    call void @sideeffect1()
; CHECK-NEXT:    br label %[[COMMON_RET]]
; CHECK:       [[BB4]]:
; CHECK-NEXT:    call void @sideeffect2()
; CHECK-NEXT:    br label %[[COMMON_RET]]
;
entry:
  br i1 %cond1, label %bb1, label %bb2

bb1:
  br i1 %cond2, label %bb3, label %bb4

bb2:
  br i1 %cond3, label %bb4, label %bb3

bb3:
  call void @sideeffect1()
  ret void

bb4:
  call void @sideeffect2()
  ret void
}

define void @fold_nested_branch_non_trivial_succ(i1 %cond1, i1 %cond2) {
; CHECK-LABEL: define void @fold_nested_branch_non_trivial_succ(
; CHECK-SAME: i1 [[COND1:%.*]], i1 [[COND2:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    br i1 [[COND1]], label %[[BB1:.*]], label %[[BB2:.*]]
; CHECK:       [[BB1]]:
; CHECK-NEXT:    call void @sideeffect1()
; CHECK-NEXT:    br i1 [[COND2]], label %[[BB3:.*]], label %[[BB4:.*]]
; CHECK:       [[BB2]]:
; CHECK-NEXT:    br i1 [[COND2]], label %[[BB4]], label %[[BB3]]
; CHECK:       [[COMMON_RET:.*]]:
; CHECK-NEXT:    ret void
; CHECK:       [[BB3]]:
; CHECK-NEXT:    call void @sideeffect1()
; CHECK-NEXT:    br label %[[COMMON_RET]]
; CHECK:       [[BB4]]:
; CHECK-NEXT:    call void @sideeffect2()
; CHECK-NEXT:    br label %[[COMMON_RET]]
;
entry:
  br i1 %cond1, label %bb1, label %bb2

bb1:
  call void @sideeffect1()
  br i1 %cond2, label %bb3, label %bb4

bb2:
  br i1 %cond2, label %bb4, label %bb3

bb3:
  call void @sideeffect1()
  ret void

bb4:
  call void @sideeffect2()
  ret void
}

define i32 @fold_nested_branch_with_phi(i1 %cond1, i1 %cond2, i32 %x) {
; CHECK-LABEL: define i32 @fold_nested_branch_with_phi(
; CHECK-SAME: i1 [[COND1:%.*]], i1 [[COND2:%.*]], i32 [[X:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    br i1 [[COND1]], label %[[BB1:.*]], label %[[BB2:.*]]
; CHECK:       [[BB1]]:
; CHECK-NEXT:    br i1 [[COND2]], label %[[COMMON_RET:.*]], label %[[BB4:.*]]
; CHECK:       [[BB2]]:
; CHECK-NEXT:    br i1 [[COND2]], label %[[BB4]], label %[[COMMON_RET]]
; CHECK:       [[COMMON_RET]]:
; CHECK-NEXT:    [[COMMON_RET_OP:%.*]] = phi i32 [ 0, %[[BB4]] ], [ 0, %[[BB1]] ], [ [[X]], %[[BB2]] ]
; CHECK-NEXT:    ret i32 [[COMMON_RET_OP]]
; CHECK:       [[BB4]]:
; CHECK-NEXT:    call void @sideeffect2()
; CHECK-NEXT:    br label %[[COMMON_RET]]
;
entry:
  br i1 %cond1, label %bb1, label %bb2

bb1:
  br i1 %cond2, label %bb3, label %bb4

bb2:
  br i1 %cond2, label %bb4, label %bb3

bb3:
  %ret = phi i32 [ 0, %bb1 ], [ %x, %bb2 ]
  ret i32 %ret

bb4:
  call void @sideeffect2()
  ret i32 0
}

define void @fold_nested_branch_loop1(i1 %cond1, i1 %cond2) {
; CHECK-LABEL: define void @fold_nested_branch_loop1(
; CHECK-SAME: i1 [[COND1:%.*]], i1 [[COND2:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    [[COND1_NOT:%.*]] = xor i1 [[COND1]], true
; CHECK-NEXT:    [[BRMERGE:%.*]] = select i1 [[COND1_NOT]], i1 true, i1 [[COND2]]
; CHECK-NEXT:    br i1 [[BRMERGE]], label %[[BB3:.*]], label %[[BB4:.*]]
; CHECK:       [[COMMON_RET:.*]]:
; CHECK-NEXT:    ret void
; CHECK:       [[BB3]]:
; CHECK-NEXT:    call void @sideeffect1()
; CHECK-NEXT:    br label %[[COMMON_RET]]
; CHECK:       [[BB4]]:
; CHECK-NEXT:    call void @sideeffect2()
; CHECK-NEXT:    br label %[[COMMON_RET]]
;
entry:
  br i1 %cond1, label %bb1, label %bb2

bb1:
  br i1 %cond2, label %bb3, label %bb4

bb2:
  br i1 %cond2, label %bb1, label %bb3

bb3:
  call void @sideeffect1()
  ret void

bb4:
  call void @sideeffect2()
  ret void
}

define void @fold_nested_branch_loop2(i1 %cond1, i1 %cond2) {
; CHECK-LABEL: define void @fold_nested_branch_loop2(
; CHECK-SAME: i1 [[COND1:%.*]], i1 [[COND2:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    br label %[[BB0:.*]]
; CHECK:       [[BB0]]:
; CHECK-NEXT:    br i1 [[COND1]], label %[[BB1:.*]], label %[[BB2:.*]]
; CHECK:       [[BB1]]:
; CHECK-NEXT:    br i1 [[COND2]], label %[[BB3:.*]], label %[[BB4:.*]]
; CHECK:       [[BB2]]:
; CHECK-NEXT:    br i1 [[COND2]], label %[[BB0]], label %[[BB3]]
; CHECK:       [[COMMON_RET:.*]]:
; CHECK-NEXT:    ret void
; CHECK:       [[BB3]]:
; CHECK-NEXT:    call void @sideeffect1()
; CHECK-NEXT:    br label %[[COMMON_RET]]
; CHECK:       [[BB4]]:
; CHECK-NEXT:    call void @sideeffect2()
; CHECK-NEXT:    br label %[[COMMON_RET]]
;
entry:
  br label %bb0

bb0:
  br i1 %cond1, label %bb1, label %bb2

bb1:
  br i1 %cond2, label %bb3, label %bb4

bb2:
  br i1 %cond2, label %bb0, label %bb3

bb3:
  call void @sideeffect1()
  ret void

bb4:
  call void @sideeffect2()
  ret void
}

; Make sure that branch weights are correctly preserved
; freq(bb4) = 1 * 4 + 2 * 5 = 14
; freq(bb3) = 1 * 3 + 2 * 6 = 15
define void @fold_nested_branch_prof(i1 %cond1, i1 %cond2) {
; CHECK-LABEL: define void @fold_nested_branch_prof(
; CHECK-SAME: i1 [[COND1:%.*]], i1 [[COND2:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    [[TMP0:%.*]] = xor i1 [[COND1]], [[COND2]]
; CHECK-NEXT:    br i1 [[TMP0]], label %[[BB4:.*]], label %[[BB3:.*]], !prof [[PROF0:![0-9]+]]
; CHECK:       [[COMMON_RET:.*]]:
; CHECK-NEXT:    ret void
; CHECK:       [[BB3]]:
; CHECK-NEXT:    call void @sideeffect1()
; CHECK-NEXT:    br label %[[COMMON_RET]]
; CHECK:       [[BB4]]:
; CHECK-NEXT:    call void @sideeffect2()
; CHECK-NEXT:    br label %[[COMMON_RET]]
;
entry:
  br i1 %cond1, label %bb1, label %bb2, !prof !0 ; 1:2

bb1:
  br i1 %cond2, label %bb3, label %bb4, !prof !1 ; 3:4

bb2:
  br i1 %cond2, label %bb4, label %bb3, !prof !2 ; 5:6

bb3:
  call void @sideeffect1()
  ret void

bb4:
  call void @sideeffect2()
  ret void
}

!0 = !{!"branch_weights", i32 1, i32 2}
!1 = !{!"branch_weights", i32 3, i32 4}
!2 = !{!"branch_weights", i32 5, i32 6}


declare void @sideeffect1()
declare void @sideeffect2()
;.
; CHECK: [[PROF0]] = !{!"branch_weights", i32 14, i32 15}
;.
