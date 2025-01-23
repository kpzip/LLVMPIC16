; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --include-generated-funcs
; RUN: opt -S -passes=verify,iroutliner -ir-outlining-no-cost < %s | FileCheck %s

; Show that we are able to propogate inputs to the region into the split PHINode
; outside of the region if necessary.

define void @function1(ptr %a, ptr %b) {
entry:
  %0 = alloca i32, align 4
  %c = load i32, ptr %0, align 4
  %z = add i32 %c, %c
  br i1 true, label %test1, label %first
test1:
  %e = load i32, ptr %0, align 4
  %1 = add i32 %c, %c
  br i1 true, label %first, label %test
test:
  %d = load i32, ptr %0, align 4
  br i1 true, label %first, label %next
dummy:
  ret void
first:
  %2 = phi i32 [ %d, %test ], [ %e, %test1 ], [ %c, %entry ]
  ret void
next:
  ret void
}

define void @function2(ptr %a, ptr %b) {
entry:
  %0 = alloca i32, align 4
  %c = load i32, ptr %0, align 4
  %z = mul i32 %c, %c
  br i1 true, label %test1, label %first
test1:
  %e = load i32, ptr %0, align 4
  %1 = add i32 %c, %c
  br i1 true, label %first, label %test
test:
  %d = load i32, ptr %0, align 4
  br i1 true, label %first, label %next
dummy:
  ret void
first:
  %2 = phi i32 [ %d, %test ], [ %e, %test1 ], [ %c, %entry ]
  ret void
next:
  ret void
}
; CHECK-LABEL: @function1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[DOTCE_LOC:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[TMP0:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[C:%.*]] = load i32, ptr [[TMP0]], align 4
; CHECK-NEXT:    [[Z:%.*]] = add i32 [[C]], [[C]]
; CHECK-NEXT:    call void @llvm.lifetime.start.p0(i64 -1, ptr [[DOTCE_LOC]])
; CHECK-NEXT:    [[TARGETBLOCK:%.*]] = call i1 @outlined_ir_func_0(ptr [[TMP0]], i32 [[C]], ptr [[DOTCE_LOC]])
; CHECK-NEXT:    [[DOTCE_RELOAD:%.*]] = load i32, ptr [[DOTCE_LOC]], align 4
; CHECK-NEXT:    call void @llvm.lifetime.end.p0(i64 -1, ptr [[DOTCE_LOC]])
; CHECK-NEXT:    br i1 [[TARGETBLOCK]], label [[FIRST:%.*]], label [[NEXT:%.*]]
; CHECK: dummy:
; CHECK-NEXT:  ret void
; CHECK:       first:
; CHECK-NEXT:    [[TMP1:%.*]] = phi i32 [ [[DOTCE_RELOAD]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    ret void
; CHECK:       next:
; CHECK-NEXT:    ret void
;
;
; CHECK-LABEL: @function2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[DOTCE_LOC:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[TMP0:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[C:%.*]] = load i32, ptr [[TMP0]], align 4
; CHECK-NEXT:    [[Z:%.*]] = mul i32 [[C]], [[C]]
; CHECK-NEXT:    call void @llvm.lifetime.start.p0(i64 -1, ptr [[DOTCE_LOC]])
; CHECK-NEXT:    [[TARGETBLOCK:%.*]] = call i1 @outlined_ir_func_0(ptr [[TMP0]], i32 [[C]], ptr [[DOTCE_LOC]])
; CHECK-NEXT:    [[DOTCE_RELOAD:%.*]] = load i32, ptr [[DOTCE_LOC]], align 4
; CHECK-NEXT:    call void @llvm.lifetime.end.p0(i64 -1, ptr [[DOTCE_LOC]])
; CHECK-NEXT:    br i1 [[TARGETBLOCK]], label [[FIRST:%.*]], label [[NEXT:%.*]]
; CHECK: dummy:
; CHECK-NEXT:  ret void
; CHECK:       first:
; CHECK-NEXT:    [[TMP1:%.*]] = phi i32 [ [[DOTCE_RELOAD]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    ret void
; CHECK:       next:
; CHECK-NEXT:    ret void
;
;
; CHECK-LABEL: define internal i1 @outlined_ir_func_0(
; CHECK-NEXT:  newFuncRoot:
; CHECK-NEXT:    br label [[ENTRY_TO_OUTLINE:%.*]]
; CHECK:       entry_to_outline:
; CHECK-NEXT:    br i1 true, label [[TEST1:%.*]], label [[FIRST_SPLIT:%.*]]
; CHECK:       test1:
; CHECK-NEXT:    [[E:%.*]] = load i32, ptr [[TMP0:%.*]], align 4
; CHECK-NEXT:    [[TMP3:%.*]] = add i32 [[TMP1:%.*]], [[TMP1]]
; CHECK-NEXT:    br i1 true, label [[FIRST_SPLIT]], label [[TEST:%.*]]
; CHECK:       test:
; CHECK-NEXT:    [[D:%.*]] = load i32, ptr [[TMP0]], align 4
; CHECK-NEXT:    br i1 true, label [[FIRST_SPLIT]], label [[NEXT_EXITSTUB:%.*]]
; CHECK:       first.split:
; CHECK-NEXT:    [[DOTCE:%.*]] = phi i32 [ [[D]], [[TEST]] ], [ [[E]], [[TEST1]] ], [ [[TMP1]], [[ENTRY_TO_OUTLINE]] ]
; CHECK-NEXT:    br label [[FIRST_EXITSTUB:%.*]]
; CHECK:       first.exitStub:
; CHECK-NEXT:    store i32 [[DOTCE]], ptr [[TMP2:%.*]], align 4
; CHECK-NEXT:    ret i1 true
; CHECK:       next.exitStub:
; CHECK-NEXT:    ret i1 false
;
