; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=licm < %s | FileCheck %s

define i16 @test(ptr %in) {
; CHECK-LABEL: @test(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[I:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[I_NEXT:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[I_NEXT]] = add i32 [[I]], 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i32 [[I_NEXT]], 10
; CHECK-NEXT:    br i1 [[CMP]], label [[LOOP]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    [[I_LCSSA:%.*]] = phi i32 [ [[I]], [[LOOP]] ]
; CHECK-NEXT:    [[GEP_LE:%.*]] = getelementptr <4 x i16>, ptr [[IN:%.*]], i32 [[I_LCSSA]]
; CHECK-NEXT:    [[LOAD_LE:%.*]] = call <4 x i16> @llvm.masked.load.v4i16.p0(ptr [[GEP_LE]], i32 2, <4 x i1> <i1 true, i1 false, i1 true, i1 false>, <4 x i16> <i16 0, i16 poison, i16 0, i16 poison>), !alias.scope [[META0:![0-9]+]], !noalias [[META0]]
; CHECK-NEXT:    [[REDUCE_LE:%.*]] = call i16 @llvm.vector.reduce.add.v4i16(<4 x i16> [[LOAD_LE]])
; CHECK-NEXT:    ret i16 [[REDUCE_LE]]
;
entry:
  br label %loop

loop:                              ; preds = %loop, %entry
  %i = phi i32 [ 0, %entry ], [ %i.next, %loop ]
  %gep = getelementptr <4 x i16>, ptr %in, i32 %i
  %load = call <4 x i16> @llvm.masked.load.v4i16.p0(ptr %gep, i32 2, <4 x i1> <i1 true, i1 false, i1 true, i1 false>, <4 x i16> <i16 0, i16 poison, i16 0, i16 poison>), !alias.scope !2, !noalias !2
  %reduce = call i16 @llvm.vector.reduce.add.v4i16(<4 x i16> %load)
  %i.next = add i32 %i, 1
  %cmp = icmp ult i32 %i.next, 10
  br i1 %cmp, label %loop, label %exit

exit:                               ; preds = %loop
  ret i16 %reduce
}

!0 = !{!0}
!1 = !{!1, !0}
!2 = !{!1}
