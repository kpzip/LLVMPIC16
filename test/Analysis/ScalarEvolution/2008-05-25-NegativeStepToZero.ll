; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py UTC_ARGS: --version 4
; RUN: opt < %s -disable-output "-passes=print<scalar-evolution>" -scalar-evolution-max-iterations=0 -scalar-evolution-classify-expressions=0 2>&1 | FileCheck %s
; PR2364


define i32 @func_6() nounwind  {
; CHECK-LABEL: 'func_6'
; CHECK-NEXT:  Determining loop execution counts for: @func_6
; CHECK-NEXT:  Loop %bb5: backedge-taken count is i8 61
; CHECK-NEXT:  Loop %bb5: constant max backedge-taken count is i8 61
; CHECK-NEXT:  Loop %bb5: symbolic max backedge-taken count is i8 61
; CHECK-NEXT:  Loop %bb5: Trip multiple is 62
;
entry:
	br label %bb5

bb:		; preds = %bb5
	%tmp2 = add i32 %i.0, 1		; <i32> [#uses=1]
	%tmp4 = add i8 %x.0, -4		; <i8> [#uses=1]
	br label %bb5

bb5:		; preds = %bb, %entry
	%x.0 = phi i8 [ 0, %entry ], [ %tmp4, %bb ]		; <i8> [#uses=2]
	%i.0 = phi i32 [ 0, %entry ], [ %tmp2, %bb ]		; <i32> [#uses=2]
	%tmp7 = icmp eq i8 %x.0, 12		; <i1> [#uses=1]
	br i1 %tmp7, label %return, label %bb

return:		; preds = %bb5
	ret i32 %i.0
}
