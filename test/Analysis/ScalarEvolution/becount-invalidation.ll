; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py
; RUN: opt -disable-output "-passes=print<scalar-evolution>" < %s 2>&1 | FileCheck %s

; This tests an invalidation issue during BECount calculation. %ptr1.dummy has
; the same SCEV as %ptr1.next, but we should not remove a symbolic name
; placeholder for %ptr1.next when invalidating SCEVs after BECount calculation.

define void @test(ptr %arg) {
; CHECK-LABEL: 'test'
; CHECK-NEXT:  Classifying expressions for: @test
; CHECK-NEXT:    %ptr1 = phi ptr [ %ptr1.next, %loop.latch ], [ null, %entry ]
; CHECK-NEXT:    --> %ptr1 U: full-set S: full-set Exits: <<Unknown>> LoopDispositions: { %loop.header: Variant, %loop2.header: Invariant }
; CHECK-NEXT:    %ptr2 = phi ptr [ %ptr2.next, %loop.latch ], [ null, %entry ]
; CHECK-NEXT:    --> %ptr2 U: full-set S: full-set Exits: <<Unknown>> LoopDispositions: { %loop.header: Variant, %loop2.header: Invariant }
; CHECK-NEXT:    %ptr1.next = phi ptr [ %ptr2, %loop.header ], [ %ptr1.next.next, %loop2.latch ]
; CHECK-NEXT:    --> {%ptr2,+,8}<nuw><%loop2.header> U: full-set S: full-set Exits: <<Unknown>> LoopDispositions: { %loop2.header: Computable, %loop.header: Variant }
; CHECK-NEXT:    %iv = phi i64 [ 0, %loop.header ], [ %iv.next, %loop2.latch ]
; CHECK-NEXT:    --> {0,+,1}<nuw><nsw><%loop2.header> U: [0,1) S: [0,1) Exits: <<Unknown>> LoopDispositions: { %loop2.header: Computable, %loop.header: Variant }
; CHECK-NEXT:    %ptr1.dummy = getelementptr inbounds i64, ptr %ptr1.next, i64 0
; CHECK-NEXT:    --> {%ptr2,+,8}<nuw><%loop2.header> U: full-set S: full-set Exits: <<Unknown>> LoopDispositions: { %loop2.header: Computable, %loop.header: Variant }
; CHECK-NEXT:    %val = load i64, ptr %ptr1.dummy, align 8
; CHECK-NEXT:    --> %val U: full-set S: full-set Exits: <<Unknown>> LoopDispositions: { %loop2.header: Variant, %loop.header: Variant }
; CHECK-NEXT:    %ptr1.next.next = getelementptr inbounds i64, ptr %ptr1.next, i64 1
; CHECK-NEXT:    --> {(8 + %ptr2),+,8}<nw><%loop2.header> U: full-set S: full-set Exits: <<Unknown>> LoopDispositions: { %loop2.header: Computable, %loop.header: Variant }
; CHECK-NEXT:    %iv.next = add i64 %iv, 1
; CHECK-NEXT:    --> {1,+,1}<nuw><nsw><%loop2.header> U: [1,2) S: [1,2) Exits: <<Unknown>> LoopDispositions: { %loop2.header: Computable, %loop.header: Variant }
; CHECK-NEXT:    %ptr2.next = phi ptr [ %ptr1, %if ], [ %arg, %else ]
; CHECK-NEXT:    --> %ptr2.next U: full-set S: full-set Exits: <<Unknown>> LoopDispositions: { %loop.header: Variant, %loop2.header: Invariant }
; CHECK-NEXT:  Determining loop execution counts for: @test
; CHECK-NEXT:  Loop %loop2.header: <multiple exits> Unpredictable backedge-taken count.
; CHECK-NEXT:    exit count for loop2.header: ***COULDNOTCOMPUTE***
; CHECK-NEXT:    exit count for loop2.latch: i1 false
; CHECK-NEXT:  Loop %loop2.header: constant max backedge-taken count is i1 false
; CHECK-NEXT:  Loop %loop2.header: symbolic max backedge-taken count is i1 false
; CHECK-NEXT:    symbolic max exit count for loop2.header: ***COULDNOTCOMPUTE***
; CHECK-NEXT:    symbolic max exit count for loop2.latch: i1 false
; CHECK-NEXT:  Loop %loop.header: Unpredictable backedge-taken count.
; CHECK-NEXT:  Loop %loop.header: Unpredictable constant max backedge-taken count.
; CHECK-NEXT:  Loop %loop.header: Unpredictable symbolic max backedge-taken count.
;
entry:
  br label %loop.header

loop.header:
  %ptr1 = phi ptr [ %ptr1.next, %loop.latch ], [ null, %entry ]
  %ptr2 = phi ptr [ %ptr2.next, %loop.latch ], [ null, %entry ]
  br label %loop2.header

loop2.header:
  %ptr1.next = phi ptr [ %ptr2, %loop.header ], [ %ptr1.next.next, %loop2.latch ]
  %iv = phi i64 [ 0, %loop.header ], [ %iv.next, %loop2.latch ]
  %ptr1.dummy = getelementptr inbounds i64, ptr %ptr1.next, i64 0
  %val = load i64, ptr %ptr1.dummy, align 8
  %cmp = icmp ne i64 %val, 0
  br i1 %cmp, label %loop2.exit, label %loop2.latch

loop2.latch:
  %ptr1.next.next = getelementptr inbounds i64, ptr %ptr1.next, i64 1
  %iv.next = add i64 %iv, 1
  br i1 true, label %return, label %loop2.header

loop2.exit:
  %cmp2 = icmp sgt i64 %iv, 0
  br i1 %cmp2, label %if, label %else

if:
  br label %loop.latch

else:
  br label %loop.latch

loop.latch:
  %ptr2.next = phi ptr [ %ptr1, %if ], [ %arg, %else ]
  br label %loop.header

return:
  ret void
}
