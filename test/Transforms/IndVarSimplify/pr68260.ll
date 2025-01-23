; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 3
; RUN: opt -S -passes='print<scalar-evolution>,loop(loop-unroll-full,indvars)' < %s 2>/dev/null | FileCheck %s
@g = constant [5 x i32] [i32 0, i32 1, i32 2, i32 3, i32 4]

declare void @use(i32)

define void @test() {
; CHECK-LABEL: define void @test() {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    br label [[LOOP2:%.*]]
; CHECK:       loop2:
; CHECK-NEXT:    br i1 false, label [[LOOP2]], label [[LOOP_LATCH:%.*]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       loop.latch:
; CHECK-NEXT:    call void @use(i32 3)
; CHECK-NEXT:    br label [[LOOP2_1:%.*]]
; CHECK:       loop2.1:
; CHECK-NEXT:    br i1 false, label [[LOOP2_1]], label [[LOOP_LATCH_1:%.*]], !llvm.loop [[LOOP0]]
; CHECK:       loop.latch.1:
; CHECK-NEXT:    call void @use(i32 4)
; CHECK-NEXT:    ret void
;
entry:
  br label %loop

loop:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop.latch ]
  %iv.next = add i64 %iv, 1
  br label %loop2

loop2:
  %iv2 = phi i64 [ 0, %loop ], [ %iv2.next, %loop2 ]
  %iv2.next = add i64 %iv2, 1
  %idx = add i64 %iv, %iv2
  %gep = getelementptr i32, ptr @g, i64 %idx
  %load = load i32, ptr %gep
  %cmp2 = icmp ne i64 %iv2, 3
  br i1 %cmp2, label %loop2, label %loop.latch, !llvm.loop !0

loop.latch:
  %load.lcssa = phi i32 [ %load, %loop2 ]
  call void @use(i32 %load)
  %cmp = icmp ne i64 %iv, 1
  br i1 %cmp, label %loop, label %exit

exit:
  ret void
}

!0 = distinct !{!0, !1}
!1 = !{!"llvm.loop.unroll.disable", i1 true}
