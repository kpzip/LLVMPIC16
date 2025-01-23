; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=gvn -S < %s | FileCheck %s

; Check that PRE-LOAD across backedge does not
; result in invalid dominator tree.
declare void @use(i32)

define void @test1(i1 %c, i32 %arg) {
; CHECK-LABEL: @test1(
; CHECK-NEXT:    br i1 [[C:%.*]], label [[BB1:%.*]], label [[DOTBB2_CRIT_EDGE:%.*]]
; CHECK:       .bb2_crit_edge:
; CHECK-NEXT:    [[DOTPRE:%.*]] = shl i32 [[ARG:%.*]], 2
; CHECK-NEXT:    br label [[BB2:%.*]]
; CHECK:       bb1:
; CHECK-NEXT:    [[SHL1:%.*]] = shl i32 [[ARG]], 2
; CHECK-NEXT:    br label [[BB3:%.*]]
; CHECK:       bb2:
; CHECK-NEXT:    [[SHL2_PRE_PHI:%.*]] = phi i32 [ [[DOTPRE]], [[DOTBB2_CRIT_EDGE]] ], [ [[SHL3:%.*]], [[BB3]] ]
; CHECK-NEXT:    call void @use(i32 [[SHL2_PRE_PHI]])
; CHECK-NEXT:    br label [[BB3]]
; CHECK:       bb3:
; CHECK-NEXT:    [[SHL3]] = shl i32 [[ARG]], 2
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr i32, ptr null, i32 [[SHL3]]
; CHECK-NEXT:    [[V:%.*]] = load i32, ptr [[GEP]], align 4
; CHECK-NEXT:    call void @use(i32 [[V]])
; CHECK-NEXT:    br label [[BB2]]
;
  br i1 %c, label %bb1, label %bb2

bb1:
  %shl1 = shl i32 %arg, 2
  br label %bb3

bb2:
  %shl2 = shl i32 %arg, 2
  call void @use(i32 %shl2)
  br label %bb3

bb3:
  %shl3 = shl i32 %arg, 2
  %gep = getelementptr i32, ptr null, i32 %shl3
  %v = load i32, ptr %gep, align 4
  call void @use(i32 %v)
  br label %bb2
}
