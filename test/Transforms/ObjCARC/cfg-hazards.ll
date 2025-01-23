; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=objc-arc < %s | FileCheck %s
; rdar://9503416

; Detect loop boundaries and don't move retains and releases
; across them.

declare void @use_pointer(ptr)
declare ptr @llvm.objc.retain(ptr)
declare void @llvm.objc.release(ptr)
declare void @callee()
declare void @block_callee(ptr)

define void @test0(ptr %digits) {
; CHECK-LABEL: @test0(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP1:%.*]] = tail call ptr @llvm.objc.retain(ptr [[DIGITS:%.*]]) #[[ATTR0:[0-9]+]]
; CHECK-NEXT:    call void @use_pointer(ptr [[DIGITS]])
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[UPCDIGITINDEX_01:%.*]] = phi i64 [ 2, [[ENTRY:%.*]] ], [ [[INC:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    call void @use_pointer(ptr [[DIGITS]])
; CHECK-NEXT:    [[INC]] = add i64 [[UPCDIGITINDEX_01]], 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i64 [[INC]], 12
; CHECK-NEXT:    br i1 [[CMP]], label [[FOR_BODY]], label [[FOR_END:%.*]]
; CHECK:       for.end:
; CHECK-NEXT:    call void @llvm.objc.release(ptr [[DIGITS]]) #[[ATTR0]], !clang.imprecise_release !0
; CHECK-NEXT:    ret void
;
entry:
  %tmp1 = call ptr @llvm.objc.retain(ptr %digits) nounwind
  call void @use_pointer(ptr %digits)
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %upcDigitIndex.01 = phi i64 [ 2, %entry ], [ %inc, %for.body ]
  call void @use_pointer(ptr %digits)
  %inc = add i64 %upcDigitIndex.01, 1
  %cmp = icmp ult i64 %inc, 12
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %for.body
  call void @llvm.objc.release(ptr %digits) nounwind, !clang.imprecise_release !0
  ret void
}

define void @test1(ptr %digits) {
; CHECK-LABEL: @test1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP1:%.*]] = tail call ptr @llvm.objc.retain(ptr [[DIGITS:%.*]]) #[[ATTR0]]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[UPCDIGITINDEX_01:%.*]] = phi i64 [ 2, [[ENTRY:%.*]] ], [ [[INC:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    call void @use_pointer(ptr [[DIGITS]])
; CHECK-NEXT:    call void @use_pointer(ptr [[DIGITS]])
; CHECK-NEXT:    [[INC]] = add i64 [[UPCDIGITINDEX_01]], 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i64 [[INC]], 12
; CHECK-NEXT:    br i1 [[CMP]], label [[FOR_BODY]], label [[FOR_END:%.*]]
; CHECK:       for.end:
; CHECK-NEXT:    call void @llvm.objc.release(ptr [[DIGITS]]) #[[ATTR0]], !clang.imprecise_release !0
; CHECK-NEXT:    ret void
;
entry:
  %tmp1 = call ptr @llvm.objc.retain(ptr %digits) nounwind
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %upcDigitIndex.01 = phi i64 [ 2, %entry ], [ %inc, %for.body ]
  call void @use_pointer(ptr %digits)
  call void @use_pointer(ptr %digits)
  %inc = add i64 %upcDigitIndex.01, 1
  %cmp = icmp ult i64 %inc, 12
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %for.body
  call void @llvm.objc.release(ptr %digits) nounwind, !clang.imprecise_release !0
  ret void
}

define void @test2(ptr %digits) {
; CHECK-LABEL: @test2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP1:%.*]] = tail call ptr @llvm.objc.retain(ptr [[DIGITS:%.*]]) #[[ATTR0]]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[UPCDIGITINDEX_01:%.*]] = phi i64 [ 2, [[ENTRY:%.*]] ], [ [[INC:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    call void @use_pointer(ptr [[DIGITS]])
; CHECK-NEXT:    [[INC]] = add i64 [[UPCDIGITINDEX_01]], 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i64 [[INC]], 12
; CHECK-NEXT:    br i1 [[CMP]], label [[FOR_BODY]], label [[FOR_END:%.*]]
; CHECK:       for.end:
; CHECK-NEXT:    call void @use_pointer(ptr [[DIGITS]])
; CHECK-NEXT:    call void @llvm.objc.release(ptr [[DIGITS]]) #[[ATTR0]], !clang.imprecise_release !0
; CHECK-NEXT:    ret void
;
entry:
  %tmp1 = call ptr @llvm.objc.retain(ptr %digits) nounwind
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %upcDigitIndex.01 = phi i64 [ 2, %entry ], [ %inc, %for.body ]
  call void @use_pointer(ptr %digits)
  %inc = add i64 %upcDigitIndex.01, 1
  %cmp = icmp ult i64 %inc, 12
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %for.body
  call void @use_pointer(ptr %digits)
  call void @llvm.objc.release(ptr %digits) nounwind, !clang.imprecise_release !0
  ret void
}

; Delete nested retain+release pairs around loops.
define void @test3(ptr %a) nounwind {
; CHECK-LABEL: @test3(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[OUTER:%.*]] = tail call ptr @llvm.objc.retain(ptr [[A:%.*]]) #[[ATTR0]]
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    call void @callee()
; CHECK-NEXT:    store i8 0, ptr [[A]], align 1
; CHECK-NEXT:    br i1 undef, label [[LOOP]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    call void @llvm.objc.release(ptr [[A]]) #[[ATTR0]], !clang.imprecise_release !0
; CHECK-NEXT:    ret void
;
entry:
  %outer = call ptr @llvm.objc.retain(ptr %a) nounwind
  %inner = call ptr @llvm.objc.retain(ptr %a) nounwind
  br label %loop

loop:
  call void @callee()
  store i8 0, ptr %a
  br i1 undef, label %loop, label %exit

exit:
  call void @llvm.objc.release(ptr %a) nounwind
  call void @llvm.objc.release(ptr %a) nounwind, !clang.imprecise_release !0
  ret void
}

define void @test4(ptr %a) nounwind {
; CHECK-LABEL: @test4(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[OUTER:%.*]] = tail call ptr @llvm.objc.retain(ptr [[A:%.*]]) #[[ATTR0]]
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    br label [[MORE:%.*]]
; CHECK:       more:
; CHECK-NEXT:    call void @callee()
; CHECK-NEXT:    call void @callee()
; CHECK-NEXT:    store i8 0, ptr [[A]], align 1
; CHECK-NEXT:    br i1 undef, label [[LOOP]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    call void @llvm.objc.release(ptr [[A]]) #[[ATTR0]], !clang.imprecise_release !0
; CHECK-NEXT:    ret void
;
entry:
  %outer = call ptr @llvm.objc.retain(ptr %a) nounwind
  %inner = call ptr @llvm.objc.retain(ptr %a) nounwind
  br label %loop

loop:
  br label %more

more:
  call void @callee()
  call void @callee()
  store i8 0, ptr %a
  br i1 undef, label %loop, label %exit

exit:
  call void @llvm.objc.release(ptr %a) nounwind
  call void @llvm.objc.release(ptr %a) nounwind, !clang.imprecise_release !0
  ret void
}

define void @test5(ptr %a) nounwind {
; CHECK-LABEL: @test5(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[OUTER:%.*]] = tail call ptr @llvm.objc.retain(ptr [[A:%.*]]) #[[ATTR0]]
; CHECK-NEXT:    call void @callee()
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    br i1 undef, label [[TRUE:%.*]], label [[MORE:%.*]]
; CHECK:       true:
; CHECK-NEXT:    br label [[MORE]]
; CHECK:       more:
; CHECK-NEXT:    br i1 undef, label [[EXIT:%.*]], label [[LOOP]]
; CHECK:       exit:
; CHECK-NEXT:    call void @use_pointer(ptr [[A]])
; CHECK-NEXT:    call void @llvm.objc.release(ptr [[A]]) #[[ATTR0]], !clang.imprecise_release !0
; CHECK-NEXT:    ret void
;
entry:
  %outer = tail call ptr @llvm.objc.retain(ptr %a) nounwind
  %inner = tail call ptr @llvm.objc.retain(ptr %a) nounwind
  call void @callee()
  br label %loop

loop:
  br i1 undef, label %true, label %more

true:
  br label %more

more:
  br i1 undef, label %exit, label %loop

exit:
  call void @use_pointer(ptr %a)
  call void @llvm.objc.release(ptr %a) nounwind
  call void @llvm.objc.release(ptr %a) nounwind, !clang.imprecise_release !0
  ret void
}

define void @test6(ptr %a) nounwind {
; CHECK-LABEL: @test6(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[OUTER:%.*]] = tail call ptr @llvm.objc.retain(ptr [[A:%.*]]) #[[ATTR0]]
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    br i1 undef, label [[TRUE:%.*]], label [[MORE:%.*]]
; CHECK:       true:
; CHECK-NEXT:    call void @callee()
; CHECK-NEXT:    br label [[MORE]]
; CHECK:       more:
; CHECK-NEXT:    br i1 undef, label [[EXIT:%.*]], label [[LOOP]]
; CHECK:       exit:
; CHECK-NEXT:    call void @use_pointer(ptr [[A]])
; CHECK-NEXT:    call void @llvm.objc.release(ptr [[A]]) #[[ATTR0]], !clang.imprecise_release !0
; CHECK-NEXT:    ret void
;
entry:
  %outer = tail call ptr @llvm.objc.retain(ptr %a) nounwind
  %inner = tail call ptr @llvm.objc.retain(ptr %a) nounwind
  br label %loop

loop:
  br i1 undef, label %true, label %more

true:
  call void @callee()
  br label %more

more:
  br i1 undef, label %exit, label %loop

exit:
  call void @use_pointer(ptr %a)
  call void @llvm.objc.release(ptr %a) nounwind
  call void @llvm.objc.release(ptr %a) nounwind, !clang.imprecise_release !0
  ret void
}

define void @test7(ptr %a) nounwind {
; CHECK-LABEL: @test7(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[OUTER:%.*]] = tail call ptr @llvm.objc.retain(ptr [[A:%.*]]) #[[ATTR0]]
; CHECK-NEXT:    call void @callee()
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    br i1 undef, label [[TRUE:%.*]], label [[MORE:%.*]]
; CHECK:       true:
; CHECK-NEXT:    call void @use_pointer(ptr [[A]])
; CHECK-NEXT:    br label [[MORE]]
; CHECK:       more:
; CHECK-NEXT:    br i1 undef, label [[EXIT:%.*]], label [[LOOP]]
; CHECK:       exit:
; CHECK-NEXT:    call void @llvm.objc.release(ptr [[A]]) #[[ATTR0]], !clang.imprecise_release !0
; CHECK-NEXT:    ret void
;
entry:
  %outer = tail call ptr @llvm.objc.retain(ptr %a) nounwind
  %inner = tail call ptr @llvm.objc.retain(ptr %a) nounwind
  call void @callee()
  br label %loop

loop:
  br i1 undef, label %true, label %more

true:
  call void @use_pointer(ptr %a)
  br label %more

more:
  br i1 undef, label %exit, label %loop

exit:
  call void @llvm.objc.release(ptr %a) nounwind
  call void @llvm.objc.release(ptr %a) nounwind, !clang.imprecise_release !0
  ret void
}

define void @test8(ptr %a) nounwind {
; CHECK-LABEL: @test8(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[OUTER:%.*]] = tail call ptr @llvm.objc.retain(ptr [[A:%.*]]) #[[ATTR0]]
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    br i1 undef, label [[TRUE:%.*]], label [[MORE:%.*]]
; CHECK:       true:
; CHECK-NEXT:    call void @callee()
; CHECK-NEXT:    call void @use_pointer(ptr [[A]])
; CHECK-NEXT:    br label [[MORE]]
; CHECK:       more:
; CHECK-NEXT:    br i1 undef, label [[EXIT:%.*]], label [[LOOP]]
; CHECK:       exit:
; CHECK-NEXT:    call void @llvm.objc.release(ptr [[A]]) #[[ATTR0]], !clang.imprecise_release !0
; CHECK-NEXT:    ret void
;
entry:
  %outer = tail call ptr @llvm.objc.retain(ptr %a) nounwind
  %inner = tail call ptr @llvm.objc.retain(ptr %a) nounwind
  br label %loop

loop:
  br i1 undef, label %true, label %more

true:
  call void @callee()
  call void @use_pointer(ptr %a)
  br label %more

more:
  br i1 undef, label %exit, label %loop

exit:
  call void @llvm.objc.release(ptr %a) nounwind
  call void @llvm.objc.release(ptr %a) nounwind, !clang.imprecise_release !0
  ret void
}

define void @test9(ptr %a) nounwind {
; CHECK-LABEL: @test9(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    br i1 undef, label [[TRUE:%.*]], label [[MORE:%.*]]
; CHECK:       true:
; CHECK-NEXT:    call void @use_pointer(ptr [[A:%.*]])
; CHECK-NEXT:    br label [[MORE]]
; CHECK:       more:
; CHECK-NEXT:    br i1 undef, label [[EXIT:%.*]], label [[LOOP]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  %outer = tail call ptr @llvm.objc.retain(ptr %a) nounwind
  %inner = tail call ptr @llvm.objc.retain(ptr %a) nounwind
  br label %loop

loop:
  br i1 undef, label %true, label %more

true:
  call void @use_pointer(ptr %a)
  br label %more

more:
  br i1 undef, label %exit, label %loop

exit:
  call void @llvm.objc.release(ptr %a) nounwind
  call void @llvm.objc.release(ptr %a) nounwind, !clang.imprecise_release !0
  ret void
}

define void @test10(ptr %a) nounwind {
; CHECK-LABEL: @test10(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    br i1 undef, label [[TRUE:%.*]], label [[MORE:%.*]]
; CHECK:       true:
; CHECK-NEXT:    call void @callee()
; CHECK-NEXT:    br label [[MORE]]
; CHECK:       more:
; CHECK-NEXT:    br i1 undef, label [[EXIT:%.*]], label [[LOOP]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  %outer = tail call ptr @llvm.objc.retain(ptr %a) nounwind
  %inner = tail call ptr @llvm.objc.retain(ptr %a) nounwind
  br label %loop

loop:
  br i1 undef, label %true, label %more

true:
  call void @callee()
  br label %more

more:
  br i1 undef, label %exit, label %loop

exit:
  call void @llvm.objc.release(ptr %a) nounwind
  call void @llvm.objc.release(ptr %a) nounwind, !clang.imprecise_release !0
  ret void
}

define void @test11(ptr %a) nounwind {
; CHECK-LABEL: @test11(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    br i1 undef, label [[TRUE:%.*]], label [[MORE:%.*]]
; CHECK:       true:
; CHECK-NEXT:    br label [[MORE]]
; CHECK:       more:
; CHECK-NEXT:    br i1 undef, label [[EXIT:%.*]], label [[LOOP]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  %outer = tail call ptr @llvm.objc.retain(ptr %a) nounwind
  %inner = tail call ptr @llvm.objc.retain(ptr %a) nounwind
  br label %loop

loop:
  br i1 undef, label %true, label %more

true:
  br label %more

more:
  br i1 undef, label %exit, label %loop

exit:
  call void @llvm.objc.release(ptr %a) nounwind
  call void @llvm.objc.release(ptr %a) nounwind, !clang.imprecise_release !0
  ret void
}

; Don't delete anything if they're not balanced.

define void @test12(ptr %a) nounwind {
; CHECK-LABEL: @test12(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[OUTER:%.*]] = tail call ptr @llvm.objc.retain(ptr [[A:%.*]]) #[[ATTR0]]
; CHECK-NEXT:    [[INNER:%.*]] = tail call ptr @llvm.objc.retain(ptr [[A]]) #[[ATTR0]]
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    br i1 undef, label [[TRUE:%.*]], label [[MORE:%.*]]
; CHECK:       true:
; CHECK-NEXT:    ret void
; CHECK:       more:
; CHECK-NEXT:    br i1 undef, label [[EXIT:%.*]], label [[LOOP]]
; CHECK:       exit:
; CHECK-NEXT:    call void @llvm.objc.release(ptr [[A]]) #[[ATTR0]]
; CHECK-NEXT:    call void @llvm.objc.release(ptr [[A]]) #[[ATTR0]], !clang.imprecise_release !0
; CHECK-NEXT:    ret void
;
entry:
  %outer = tail call ptr @llvm.objc.retain(ptr %a) nounwind
  %inner = tail call ptr @llvm.objc.retain(ptr %a) nounwind
  br label %loop

loop:
  br i1 undef, label %true, label %more

true:
  ret void

more:
  br i1 undef, label %exit, label %loop

exit:
  call void @llvm.objc.release(ptr %a) nounwind
  call void @llvm.objc.release(ptr %a) nounwind, !clang.imprecise_release !0
  ret void
}

; Do not improperly pair retains in a for loop with releases outside of a for
; loop when the proper pairing is disguised by a separate provenance represented
; by an alloca.
; rdar://12969722

define void @test13(ptr %a) nounwind {
; CHECK-LABEL: @test13(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[BLOCK:%.*]] = alloca ptr, align 8
; CHECK-NEXT:    [[A1:%.*]] = tail call ptr @llvm.objc.retain(ptr [[A:%.*]]) #[[ATTR0]]
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[A2:%.*]] = tail call ptr @llvm.objc.retain(ptr [[A]]) #[[ATTR0]]
; CHECK-NEXT:    store ptr [[A]], ptr [[BLOCK]], align 8
; CHECK-NEXT:    call void @block_callee(ptr [[BLOCK]])
; CHECK-NEXT:    [[RELOADED_A:%.*]] = load ptr, ptr [[BLOCK]], align 8
; CHECK-NEXT:    call void @llvm.objc.release(ptr [[RELOADED_A]]) #[[ATTR0]], !clang.imprecise_release !0
; CHECK-NEXT:    br i1 undef, label [[LOOP]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    call void @llvm.objc.release(ptr [[A]]) #[[ATTR0]], !clang.imprecise_release !0
; CHECK-NEXT:    ret void
;
entry:
  %block = alloca ptr
  %a1 = tail call ptr @llvm.objc.retain(ptr %a) nounwind
  br label %loop

loop:
  %a2 = tail call ptr @llvm.objc.retain(ptr %a) nounwind
  store ptr %a, ptr %block, align 8
  call void @block_callee(ptr %block)
  %reloaded_a = load ptr, ptr %block, align 8
  call void @llvm.objc.release(ptr %reloaded_a) nounwind, !clang.imprecise_release !0
  br i1 undef, label %loop, label %exit

exit:
  call void @llvm.objc.release(ptr %a) nounwind, !clang.imprecise_release !0
  ret void
}

; The retain call in the entry block shouldn't be moved to the loop body.

define void @test14(ptr %val0, i8 %val1) {
; CHECK-LABEL: @test14(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[V1:%.*]] = tail call ptr @llvm.objc.retain(ptr [[VAL0:%.*]]) #[[ATTR0]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq ptr [[VAL0]], null
; CHECK-NEXT:    br i1 [[CMP]], label [[IF_END27:%.*]], label [[IF_THEN:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    [[TOBOOL:%.*]] = icmp eq i8 [[VAL1:%.*]], 1
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.cond:
; CHECK-NEXT:    [[CMP6:%.*]] = icmp eq i8 [[VAL1]], 2
; CHECK-NEXT:    br i1 [[CMP6]], label [[FOR_BODY]], label [[FOR_END_LOOPEXIT:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    call void @callee()
; CHECK-NEXT:    [[TOBOOL9:%.*]] = icmp eq i8 [[VAL1]], 0
; CHECK-NEXT:    br i1 [[TOBOOL9]], label [[FOR_COND:%.*]], label [[IF_THEN10:%.*]]
; CHECK:       if.then10:
; CHECK-NEXT:    br label [[FOR_END:%.*]]
; CHECK:       for.end.loopexit:
; CHECK-NEXT:    br label [[FOR_END]]
; CHECK:       for.end:
; CHECK-NEXT:    call void @callee()
; CHECK-NEXT:    call void @use_pointer(ptr [[V1]])
; CHECK-NEXT:    br label [[IF_END27]]
; CHECK:       if.end27:
; CHECK-NEXT:    call void @llvm.objc.release(ptr [[V1]]) #[[ATTR0]], !clang.imprecise_release !0
; CHECK-NEXT:    ret void
;
entry:
  %v1 = tail call ptr @llvm.objc.retain(ptr %val0)
  %cmp = icmp eq ptr %val0, null
  br i1 %cmp, label %if.end27, label %if.then

if.then:
  %tobool = icmp eq i8 %val1, 1
  br label %for.body

for.cond:
  %cmp6 = icmp eq i8 %val1, 2
  br i1 %cmp6, label %for.body, label %for.end.loopexit

for.body:
  call void @callee()
  %tobool9 = icmp eq i8 %val1, 0
  br i1 %tobool9, label %for.cond, label %if.then10

if.then10:
  br label %for.end

for.end.loopexit:
  br label %for.end

for.end:
  call void @callee()
  call void @use_pointer(ptr %v1)
  br label %if.end27

if.end27:
  call void @llvm.objc.release(ptr %v1) #0, !clang.imprecise_release !0
  ret void
}


!0 = !{}
