; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py
; RUN: opt < %s -disable-output "-passes=print<scalar-evolution>" -scalar-evolution-classify-expressions=0 2>&1 | FileCheck %s

; ScalarEvolution should be able to compute a loop exit value for %indvar.i8.

define void @another_count_down_signed(ptr %d, i64 %n) nounwind {
; CHECK-LABEL: 'another_count_down_signed'
; CHECK-NEXT:  Determining loop execution counts for: @another_count_down_signed
; CHECK-NEXT:  Loop %loop: backedge-taken count is (-11 + %n)
; CHECK-NEXT:  Loop %loop: constant max backedge-taken count is i64 -1
; CHECK-NEXT:  Loop %loop: symbolic max backedge-taken count is (-11 + %n)
; CHECK-NEXT:  Loop %loop: Trip multiple is 1
;
entry:
  br label %loop

loop:		; preds = %loop, %entry
  %indvar = phi i64 [ %n, %entry ], [ %indvar.next, %loop ]		; <i64> [#uses=4]
  %s0 = shl i64 %indvar, 8		; <i64> [#uses=1]
  %indvar.i8 = ashr i64 %s0, 8		; <i64> [#uses=1]
  %t0 = getelementptr double, ptr %d, i64 %indvar.i8		; <ptr> [#uses=2]
  %t1 = load double, ptr %t0		; <double> [#uses=1]
  %t2 = fmul double %t1, 1.000000e-01		; <double> [#uses=1]
  store double %t2, ptr %t0
  %indvar.next = sub i64 %indvar, 1		; <i64> [#uses=2]
  %exitcond = icmp eq i64 %indvar.next, 10		; <i1> [#uses=1]
  br i1 %exitcond, label %return, label %loop

return:		; preds = %loop
  ret void
}
