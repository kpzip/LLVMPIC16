; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -S -passes="print<assumptions>,gvn-sink,loop-unroll" -unroll-count=3 | FileCheck %s
;
; This crashed because the cached assumption was replaced and the replacement
; was then in the cache twice.
;
; PR49043

@g = external global i32

define void @main() {
; CHECK-LABEL: @main(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    br label [[BB4_I:%.*]]
; CHECK:       bb4.i:
; CHECK-NEXT:    [[I1_I:%.*]] = load volatile i32, ptr @g, align 4
; CHECK-NEXT:    [[I32_I:%.*]] = icmp eq i32 [[I1_I]], 0
; CHECK-NEXT:    call void @llvm.assume(i1 [[I32_I]])
; CHECK-NEXT:    [[I1_I_1:%.*]] = load volatile i32, ptr @g, align 4
; CHECK-NEXT:    [[I32_I_1:%.*]] = icmp eq i32 [[I1_I_1]], 0
; CHECK-NEXT:    call void @llvm.assume(i1 [[I32_I_1]])
; CHECK-NEXT:    [[I1_I_2:%.*]] = load volatile i32, ptr @g, align 4
; CHECK-NEXT:    [[I32_I_2:%.*]] = icmp eq i32 [[I1_I_2]], 0
; CHECK-NEXT:    call void @llvm.assume(i1 [[I32_I_2]])
; CHECK-NEXT:    br label [[BB4_I]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       func_1.exit:
; CHECK-NEXT:    unreachable
;
bb:
  %i1.i = load volatile i32, ptr @g
  %i32.i = icmp eq i32 %i1.i, 0
  call void @llvm.assume(i1 %i32.i) #3
  br label %bb4.i

bb4.i:                                            ; preds = %bb4.i, %bb
  %i.i = load volatile i32, ptr @g
  %i3.i = icmp eq i32 %i.i, 0
  call void @llvm.assume(i1 %i3.i) #3
  br label %bb4.i

func_1.exit:                                      ; No predecessors!
  unreachable
}

declare void @llvm.assume(i1)
