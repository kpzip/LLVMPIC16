; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=rewrite-statepoints-for-gc -S 2>&1 | FileCheck %s

; derived %merged_value base %base_obj
define ptr addrspace(1) @test(ptr addrspace(1) %base_obj, i1 %runtime_condition) gc "statepoint-example" {
; CHECK-LABEL: @test(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[RUNTIME_CONDITION:%.*]], label [[MERGE:%.*]], label [[THERE:%.*]]
; CHECK:       there:
; CHECK-NEXT:    [[DERIVED_OBJ:%.*]] = getelementptr i64, ptr addrspace(1) [[BASE_OBJ:%.*]], i32 1
; CHECK-NEXT:    br label [[MERGE]]
; CHECK:       merge:
; CHECK-NEXT:    [[MERGED_VALUE:%.*]] = phi ptr addrspace(1) [ [[BASE_OBJ]], [[ENTRY:%.*]] ], [ [[DERIVED_OBJ]], [[THERE]] ]
; CHECK-NEXT:    [[STATEPOINT_TOKEN:%.*]] = call token (i64, i32, ptr, i32, i32, ...) @llvm.experimental.gc.statepoint.p0(i64 2882400000, i32 0, ptr elementtype(void ()) @foo, i32 0, i32 0, i32 0, i32 0) [ "deopt"(i32 0, i32 -1, i32 0, i32 0, i32 0), "gc-live"(ptr addrspace(1) [[MERGED_VALUE]], ptr addrspace(1) [[BASE_OBJ]]) ]
; CHECK-NEXT:    [[MERGED_VALUE_RELOCATED:%.*]] = call coldcc ptr addrspace(1) @llvm.experimental.gc.relocate.p1(token [[STATEPOINT_TOKEN]], i32 1, i32 0)
; CHECK-NEXT:    [[BASE_OBJ_RELOCATED:%.*]] = call coldcc ptr addrspace(1) @llvm.experimental.gc.relocate.p1(token [[STATEPOINT_TOKEN]], i32 1, i32 1)
; CHECK-NEXT:    ret ptr addrspace(1) [[MERGED_VALUE_RELOCATED]]
;
entry:
  br i1 %runtime_condition, label %merge, label %there

there:                                            ; preds = %entry
  %derived_obj = getelementptr i64, ptr addrspace(1) %base_obj, i32 1
  br label %merge

merge:                                            ; preds = %there, %entry
  %merged_value = phi ptr addrspace(1) [ %base_obj, %entry ], [ %derived_obj, %there ]
  call void @foo() [ "deopt"(i32 0, i32 -1, i32 0, i32 0, i32 0) ]
  ret ptr addrspace(1) %merged_value
}

declare void @foo()
