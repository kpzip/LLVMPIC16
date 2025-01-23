; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 4
; RUN: opt < %s -passes=newgvn -S | FileCheck %s

%struct.A = type { ptr }
@_ZTV1A = available_externally unnamed_addr constant [3 x ptr] [ptr null, ptr @_ZTI1A, ptr @_ZN1A3fooEv], align 8
@_ZTI1A = external constant ptr

@unknownPtr = external global i8

define i8 @simple() {
; CHECK-LABEL: define i8 @simple() {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[PTR:%.*]] = alloca i8, align 1
; CHECK-NEXT:    store i8 42, ptr [[PTR]], align 1, !invariant.group [[META0:![0-9]+]]
; CHECK-NEXT:    call void @foo(ptr [[PTR]])
; CHECK-NEXT:    ret i8 42
;
entry:
  %ptr = alloca i8
  store i8 42, ptr %ptr, !invariant.group !0
  call void @foo(ptr %ptr)

  %a = load i8, ptr %ptr, !invariant.group !0
  %b = load i8, ptr %ptr, !invariant.group !0
  %c = load i8, ptr %ptr, !invariant.group !0
  ret i8 %a
}

define i8 @optimizable1() {
; CHECK-LABEL: define i8 @optimizable1() {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[PTR:%.*]] = alloca i8, align 1
; CHECK-NEXT:    store i8 42, ptr [[PTR]], align 1, !invariant.group [[META0]]
; CHECK-NEXT:    [[PTR2:%.*]] = call ptr @llvm.launder.invariant.group.p0(ptr [[PTR]])
; CHECK-NEXT:    call void @foo(ptr [[PTR2]])
; CHECK-NEXT:    ret i8 42
;
entry:
  %ptr = alloca i8
  store i8 42, ptr %ptr, !invariant.group !0
  %ptr2 = call ptr @llvm.launder.invariant.group.p0(ptr %ptr)
  %a = load i8, ptr %ptr, !invariant.group !0

  call void @foo(ptr %ptr2); call to use %ptr2
  ret i8 %a
}

define i8 @optimizable2() {
; CHECK-LABEL: define i8 @optimizable2() {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[PTR:%.*]] = alloca i8, align 1
; CHECK-NEXT:    store i8 42, ptr [[PTR]], align 1, !invariant.group [[META0]]
; CHECK-NEXT:    call void @foo(ptr [[PTR]])
; CHECK-NEXT:    store i8 13, ptr [[PTR]], align 1
; CHECK-NEXT:    call void @bar(i8 13)
; CHECK-NEXT:    call void @foo(ptr [[PTR]])
; CHECK-NEXT:    ret i8 42
;
entry:
  %ptr = alloca i8
  store i8 42, ptr %ptr, !invariant.group !0
  call void @foo(ptr %ptr)

  store i8 13, ptr %ptr ; can't use this store with invariant.group
  %a = load i8, ptr %ptr
  call void @bar(i8 %a) ; call to use %a

  call void @foo(ptr %ptr)
  %b = load i8, ptr %ptr, !invariant.group !0

  ret i8 %b
}

define i1 @proveEqualityForStrip(ptr %a) {
; CHECK-LABEL: define i1 @proveEqualityForStrip(
; CHECK-SAME: ptr [[A:%.*]]) {
; CHECK-NEXT:    ret i1 true
;
  %b1 = call ptr @llvm.strip.invariant.group.p0(ptr %a)
  %b2 = call ptr @llvm.strip.invariant.group.p0(ptr %a)
  %r = icmp eq ptr %b1, %b2
  ret i1 %r
}

define i8 @unoptimizable1() {
; CHECK-LABEL: define i8 @unoptimizable1() {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[PTR:%.*]] = alloca i8, align 1
; CHECK-NEXT:    store i8 42, ptr [[PTR]], align 1
; CHECK-NEXT:    call void @foo(ptr [[PTR]])
; CHECK-NEXT:    [[A:%.*]] = load i8, ptr [[PTR]], align 1, !invariant.group [[META0]]
; CHECK-NEXT:    ret i8 [[A]]
;
entry:
  %ptr = alloca i8
  store i8 42, ptr %ptr
  call void @foo(ptr %ptr)
  %a = load i8, ptr %ptr, !invariant.group !0
  ret i8 %a
}

; NewGVN doesn't support assumes.
define void @indirectLoads() {
; CHECK-LABEL: define void @indirectLoads() {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A:%.*]] = alloca ptr, align 8
; CHECK-NEXT:    [[CALL:%.*]] = call ptr @getPointer(ptr null)
; CHECK-NEXT:    call void @_ZN1AC1Ev(ptr [[CALL]])
; CHECK-NEXT:    [[VTABLE:%.*]] = load ptr, ptr [[CALL]], align 8, !invariant.group [[META0]]
; CHECK-NEXT:    [[CMP_VTABLES:%.*]] = icmp eq ptr [[VTABLE]], getelementptr inbounds ([3 x ptr], ptr @_ZTV1A, i64 0, i64 2)
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP_VTABLES]])
; CHECK-NEXT:    store ptr [[CALL]], ptr [[A]], align 8
; CHECK-NEXT:    [[TMP0:%.*]] = load ptr, ptr [[VTABLE]], align 8
; CHECK-NEXT:    call void [[TMP0]](ptr [[CALL]])
; CHECK-NEXT:    [[VTABLE2:%.*]] = load ptr, ptr [[CALL]], align 8, !invariant.group [[META0]]
; CHECK-NEXT:    [[TMP1:%.*]] = load ptr, ptr [[VTABLE2]], align 8
; CHECK-NEXT:    call void [[TMP1]](ptr [[CALL]])
; CHECK-NEXT:    [[VTABLE4:%.*]] = load ptr, ptr [[CALL]], align 8, !invariant.group [[META0]]
; CHECK-NEXT:    [[TMP2:%.*]] = load ptr, ptr [[VTABLE4]], align 8
; CHECK-NEXT:    call void [[TMP2]](ptr [[CALL]])
; CHECK-NEXT:    [[TMP3:%.*]] = load ptr, ptr [[VTABLE]], align 8
; CHECK-NEXT:    call void [[TMP3]](ptr [[CALL]])
; CHECK-NEXT:    ret void
;
entry:
  %a = alloca ptr, align 8

  %call = call ptr @getPointer(ptr null)
  call void @_ZN1AC1Ev(ptr %call)

  %vtable = load ptr, ptr %call, align 8, !invariant.group !0
  %cmp.vtables = icmp eq ptr %vtable, getelementptr inbounds ([3 x ptr], ptr @_ZTV1A, i64 0, i64 2)
  call void @llvm.assume(i1 %cmp.vtables)

  store ptr %call, ptr %a, align 8
  %0 = load ptr, ptr %a, align 8

; FIXME: call void @_ZN1A3fooEv(
  %vtable1 = load ptr, ptr %0, align 8, !invariant.group !0
  %1 = load ptr, ptr %vtable1, align 8
  call void %1(ptr %0)
  %2 = load ptr, ptr %a, align 8

; FIXME: call void @_ZN1A3fooEv(
  %vtable2 = load ptr, ptr %2, align 8, !invariant.group !0
  %3 = load ptr, ptr %vtable2, align 8

  call void %3(ptr %2)
  %4 = load ptr, ptr %a, align 8

  %vtable4 = load ptr, ptr %4, align 8, !invariant.group !0
  %5 = load ptr, ptr %vtable4, align 8
; FIXME: call void @_ZN1A3fooEv(
  call void %5(ptr %4)

  %vtable5 = load ptr, ptr %call, align 8, !invariant.group !0
  %6 = load ptr, ptr %vtable5, align 8
; FIXME: call void @_ZN1A3fooEv(
  call void %6(ptr %4)

  ret void
}

; NewGVN won't CSE loads with different pointee types.
define void @combiningBitCastWithLoad() {
; CHECK-LABEL: define void @combiningBitCastWithLoad() {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A:%.*]] = alloca ptr, align 8
; CHECK-NEXT:    [[CALL:%.*]] = call ptr @getPointer(ptr null)
; CHECK-NEXT:    call void @_ZN1AC1Ev(ptr [[CALL]])
; CHECK-NEXT:    [[VTABLE:%.*]] = load ptr, ptr [[CALL]], align 8, !invariant.group [[META0]]
; CHECK-NEXT:    store ptr [[CALL]], ptr [[A]], align 8
; CHECK-NEXT:    [[TMP0:%.*]] = load ptr, ptr [[VTABLE]], align 8
; CHECK-NEXT:    call void [[TMP0]](ptr [[CALL]])
; CHECK-NEXT:    ret void
;
entry:
  %a = alloca ptr, align 8

  %call = call ptr @getPointer(ptr null)
  call void @_ZN1AC1Ev(ptr %call)

  %vtable = load ptr, ptr %call, align 8, !invariant.group !0
  %cmp.vtables = icmp eq ptr %vtable, getelementptr inbounds ([3 x ptr], ptr @_ZTV1A, i64 0, i64 2)

  store ptr %call, ptr %a, align 8
; FIXME-NOT: !invariant.group
  %0 = load ptr, ptr %a, align 8

  %vtable1 = load ptr, ptr %0, align 8, !invariant.group !0
  %1 = load ptr, ptr %vtable1, align 8
  call void %1(ptr %0)

  ret void
}

define void @loadCombine() {
; CHECK-LABEL: define void @loadCombine() {
; CHECK-NEXT:  enter:
; CHECK-NEXT:    [[PTR:%.*]] = alloca i8, align 1
; CHECK-NEXT:    store i8 42, ptr [[PTR]], align 1
; CHECK-NEXT:    call void @foo(ptr [[PTR]])
; CHECK-NEXT:    [[A:%.*]] = load i8, ptr [[PTR]], align 1, !invariant.group [[META0]]
; CHECK-NEXT:    call void @bar(i8 [[A]])
; CHECK-NEXT:    call void @bar(i8 [[A]])
; CHECK-NEXT:    ret void
;
enter:
  %ptr = alloca i8
  store i8 42, ptr %ptr
  call void @foo(ptr %ptr)
  %a = load i8, ptr %ptr, !invariant.group !0
  %b = load i8, ptr %ptr, !invariant.group !0
  call void @bar(i8 %a)
  call void @bar(i8 %b)
  ret void
}

define void @loadCombine1() {
; CHECK-LABEL: define void @loadCombine1() {
; CHECK-NEXT:  enter:
; CHECK-NEXT:    [[PTR:%.*]] = alloca i8, align 1
; CHECK-NEXT:    store i8 42, ptr [[PTR]], align 1
; CHECK-NEXT:    call void @foo(ptr [[PTR]])
; CHECK-NEXT:    [[C:%.*]] = load i8, ptr [[PTR]], align 1, !invariant.group [[META0]]
; CHECK-NEXT:    call void @bar(i8 [[C]])
; CHECK-NEXT:    call void @bar(i8 [[C]])
; CHECK-NEXT:    ret void
;
enter:
  %ptr = alloca i8
  store i8 42, ptr %ptr
  call void @foo(ptr %ptr)
  %c = load i8, ptr %ptr
  %d = load i8, ptr %ptr, !invariant.group !0
  call void @bar(i8 %c)
  call void @bar(i8 %d)
  ret void
}

define void @loadCombine2() {
; CHECK-LABEL: define void @loadCombine2() {
; CHECK-NEXT:  enter:
; CHECK-NEXT:    [[PTR:%.*]] = alloca i8, align 1
; CHECK-NEXT:    store i8 42, ptr [[PTR]], align 1
; CHECK-NEXT:    call void @foo(ptr [[PTR]])
; CHECK-NEXT:    [[E:%.*]] = load i8, ptr [[PTR]], align 1, !invariant.group [[META0]]
; CHECK-NEXT:    call void @bar(i8 [[E]])
; CHECK-NEXT:    call void @bar(i8 [[E]])
; CHECK-NEXT:    ret void
;
enter:
  %ptr = alloca i8
  store i8 42, ptr %ptr
  call void @foo(ptr %ptr)
  %e = load i8, ptr %ptr, !invariant.group !0
  %f = load i8, ptr %ptr
  call void @bar(i8 %e)
  call void @bar(i8 %f)
  ret void
}

define void @loadCombine3() {
; CHECK-LABEL: define void @loadCombine3() {
; CHECK-NEXT:  enter:
; CHECK-NEXT:    [[PTR:%.*]] = alloca i8, align 1
; CHECK-NEXT:    store i8 42, ptr [[PTR]], align 1
; CHECK-NEXT:    call void @foo(ptr [[PTR]])
; CHECK-NEXT:    [[E:%.*]] = load i8, ptr [[PTR]], align 1, !invariant.group [[META0]]
; CHECK-NEXT:    call void @bar(i8 [[E]])
; CHECK-NEXT:    call void @bar(i8 [[E]])
; CHECK-NEXT:    ret void
;
enter:
  %ptr = alloca i8
  store i8 42, ptr %ptr
  call void @foo(ptr %ptr)
  %e = load i8, ptr %ptr, !invariant.group !0
  %f = load i8, ptr %ptr, !invariant.group !0
  call void @bar(i8 %e)
  call void @bar(i8 %f)
  ret void
}

define i8 @unoptimizable2() {
; CHECK-LABEL: define i8 @unoptimizable2() {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[PTR:%.*]] = alloca i8, align 1
; CHECK-NEXT:    store i8 42, ptr [[PTR]], align 1
; CHECK-NEXT:    call void @foo(ptr [[PTR]])
; CHECK-NEXT:    [[A:%.*]] = load i8, ptr [[PTR]], align 1
; CHECK-NEXT:    call void @foo(ptr [[PTR]])
; CHECK-NEXT:    ret i8 [[A]]
;
entry:
  %ptr = alloca i8
  store i8 42, ptr %ptr
  call void @foo(ptr %ptr)
  %a = load i8, ptr %ptr
  call void @foo(ptr %ptr)
  %b = load i8, ptr %ptr, !invariant.group !0

  ret i8 %a
}

define i8 @unoptimizable3() {
; CHECK-LABEL: define i8 @unoptimizable3() {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[PTR:%.*]] = alloca i8, align 1
; CHECK-NEXT:    store i8 42, ptr [[PTR]], align 1, !invariant.group [[META0]]
; CHECK-NEXT:    [[PTR2:%.*]] = call ptr @getPointer(ptr [[PTR]])
; CHECK-NEXT:    [[A:%.*]] = load i8, ptr [[PTR2]], align 1, !invariant.group [[META0]]
; CHECK-NEXT:    ret i8 [[A]]
;
entry:
  %ptr = alloca i8
  store i8 42, ptr %ptr, !invariant.group !0
  %ptr2 = call ptr @getPointer(ptr %ptr)
  %a = load i8, ptr %ptr2, !invariant.group !0

  ret i8 %a
}

; NewGVN cares about the launder for some reason.
define i8 @optimizable4() {
; CHECK-LABEL: define i8 @optimizable4() {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[PTR:%.*]] = alloca i8, align 1
; CHECK-NEXT:    store i8 42, ptr [[PTR]], align 1
; CHECK-NEXT:    [[PTR2:%.*]] = call ptr @llvm.launder.invariant.group.p0(ptr [[PTR]])
; CHECK-NEXT:    [[A:%.*]] = load i8, ptr [[PTR2]], align 1
; CHECK-NEXT:    ret i8 [[A]]
;
entry:
  %ptr = alloca i8
  store i8 42, ptr %ptr
  %ptr2 = call ptr @llvm.launder.invariant.group.p0(ptr %ptr)
; FIXME-NOT: load
  %a = load i8, ptr %ptr2

; FIXME: ret i8 42
  ret i8 %a
}

define i8 @volatile1() {
; CHECK-LABEL: define i8 @volatile1() {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[PTR:%.*]] = alloca i8, align 1
; CHECK-NEXT:    store i8 42, ptr [[PTR]], align 1, !invariant.group [[META0]]
; CHECK-NEXT:    call void @foo(ptr [[PTR]])
; CHECK-NEXT:    [[B:%.*]] = load volatile i8, ptr [[PTR]], align 1
; CHECK-NEXT:    call void @bar(i8 [[B]])
; CHECK-NEXT:    [[C:%.*]] = load volatile i8, ptr [[PTR]], align 1, !invariant.group [[META0]]
; CHECK-NEXT:    call void @bar(i8 [[C]])
; CHECK-NEXT:    ret i8 42
;
entry:
  %ptr = alloca i8
  store i8 42, ptr %ptr, !invariant.group !0
  call void @foo(ptr %ptr)
  %a = load i8, ptr %ptr, !invariant.group !0
  %b = load volatile i8, ptr %ptr
  call void @bar(i8 %b)

  %c = load volatile i8, ptr %ptr, !invariant.group !0
; We might be able to optimize this, but nobody cares
  call void @bar(i8 %c)
  ret i8 %a
}

define i8 @volatile2() {
; CHECK-LABEL: define i8 @volatile2() {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[PTR:%.*]] = alloca i8, align 1
; CHECK-NEXT:    store i8 42, ptr [[PTR]], align 1, !invariant.group [[META0]]
; CHECK-NEXT:    call void @foo(ptr [[PTR]])
; CHECK-NEXT:    [[B:%.*]] = load volatile i8, ptr [[PTR]], align 1
; CHECK-NEXT:    call void @bar(i8 [[B]])
; CHECK-NEXT:    [[C:%.*]] = load volatile i8, ptr [[PTR]], align 1, !invariant.group [[META0]]
; CHECK-NEXT:    call void @bar(i8 [[C]])
; CHECK-NEXT:    ret i8 42
;
entry:
  %ptr = alloca i8
  store i8 42, ptr %ptr, !invariant.group !0
  call void @foo(ptr %ptr)
  %a = load i8, ptr %ptr, !invariant.group !0
  %b = load volatile i8, ptr %ptr
  call void @bar(i8 %b)

  %c = load volatile i8, ptr %ptr, !invariant.group !0
; We might be able to optimize this, but nobody cares
  call void @bar(i8 %c)
  ret i8 %a
}

define void @fun() {
; CHECK-LABEL: define void @fun() {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[PTR:%.*]] = alloca i8, align 1
; CHECK-NEXT:    store i8 42, ptr [[PTR]], align 1, !invariant.group [[META0]]
; CHECK-NEXT:    call void @foo(ptr [[PTR]])
; CHECK-NEXT:    call void @bar(i8 42)
; CHECK-NEXT:    ret void
;
entry:
  %ptr = alloca i8
  store i8 42, ptr %ptr, !invariant.group !0
  call void @foo(ptr %ptr)

  %a = load i8, ptr %ptr, !invariant.group !0 ; Can assume that value under %ptr didn't change
  call void @bar(i8 %a)

  ret void
}

; FIXME: NewGVN doesn't run instsimplify on a load from a vtable definition?
; This test checks if invariant.group understands gep with zeros
define void @testGEP0() {
; CHECK-LABEL: define void @testGEP0() {
; CHECK-NEXT:    [[A:%.*]] = alloca [[STRUCT_A:%.*]], align 8
; CHECK-NEXT:    store ptr getelementptr inbounds ([3 x ptr], ptr @_ZTV1A, i64 0, i64 2), ptr [[A]], align 8, !invariant.group [[META0]]
; CHECK-NEXT:    call void @_ZN1A3fooEv(ptr nonnull dereferenceable(8) [[A]])
; CHECK-NEXT:    [[TMP1:%.*]] = load i8, ptr @unknownPtr, align 4
; CHECK-NEXT:    [[TMP2:%.*]] = icmp eq i8 [[TMP1]], 0
; CHECK-NEXT:    br i1 [[TMP2]], label [[_Z1GR1A_EXIT:%.*]], label [[TMP3:%.*]]
; CHECK:       3:
; CHECK-NEXT:    [[TMP4:%.*]] = load ptr, ptr getelementptr inbounds ([3 x ptr], ptr @_ZTV1A, i64 0, i64 2), align 8
; CHECK-NEXT:    call void [[TMP4]](ptr nonnull [[A]])
; CHECK-NEXT:    br label [[_Z1GR1A_EXIT]]
; CHECK:       _Z1gR1A.exit:
; CHECK-NEXT:    ret void
;
  %a = alloca %struct.A, align 8
  store ptr getelementptr inbounds ([3 x ptr], ptr @_ZTV1A, i64 0, i64 2), ptr %a, align 8, !invariant.group !0
  call void @_ZN1A3fooEv(ptr nonnull dereferenceable(8) %a) ; This call may change vptr
  %1 = load i8, ptr @unknownPtr, align 4
  %2 = icmp eq i8 %1, 0
  br i1 %2, label %_Z1gR1A.exit, label %3

; This should be devirtualized by invariant.group
  %4 = load ptr, ptr %a, align 8, !invariant.group !0
  %5 = load ptr, ptr %4, align 8
; FIXME: call void @_ZN1A3fooEv(ptr nonnull %a)
  call void %5(ptr nonnull %a)
  br label %_Z1gR1A.exit

_Z1gR1A.exit:                                     ; preds = %0, %3
  ret void
}

; Check if no optimizations are performed with global pointers.
; FIXME: we could do the optimizations if we would check if dependency comes
; from the same function.
define void @testGlobal() {
; CHECK-LABEL: define void @testGlobal() {
; CHECK-NEXT:    [[A:%.*]] = load i8, ptr @unknownPtr, align 1, !invariant.group [[META0]]
; CHECK-NEXT:    call void @foo2(ptr @unknownPtr, i8 [[A]])
; CHECK-NEXT:    [[TMP1:%.*]] = load i8, ptr @unknownPtr, align 1, !invariant.group [[META0]]
; CHECK-NEXT:    call void @bar(i8 [[TMP1]])
; CHECK-NEXT:    call void @fooBit(ptr @unknownPtr, i1 true)
; CHECK-NEXT:    [[TMP2:%.*]] = load i1, ptr @unknownPtr, align 1, !invariant.group [[META0]]
; CHECK-NEXT:    call void @fooBit(ptr @unknownPtr, i1 [[TMP2]])
; CHECK-NEXT:    [[TMP3:%.*]] = load i1, ptr @unknownPtr, align 1, !invariant.group [[META0]]
; CHECK-NEXT:    call void @fooBit(ptr @unknownPtr, i1 [[TMP3]])
; CHECK-NEXT:    ret void
;
  %a = load i8, ptr @unknownPtr, !invariant.group !0
  call void @foo2(ptr @unknownPtr, i8 %a)
  %1 = load i8, ptr @unknownPtr, !invariant.group !0
  call void @bar(i8 %1)

  call void @fooBit(ptr @unknownPtr, i1 1)
; Adding regex because of canonicalization of bitcasts
  %2 = load i1, ptr @unknownPtr, !invariant.group !0
  call void @fooBit(ptr @unknownPtr, i1 %2)
  %3 = load i1, ptr @unknownPtr, !invariant.group !0
  call void @fooBit(ptr @unknownPtr, i1 %3)
  ret void
}

; Might be similar to above where NewGVN doesn't handle loads of different types from the same location.
; Not super important anyway.
define void @testTrunc() {
; CHECK-LABEL: define void @testTrunc() {
; CHECK-NEXT:    [[A:%.*]] = alloca i8, align 1
; CHECK-NEXT:    call void @foo(ptr [[A]])
; CHECK-NEXT:    [[B:%.*]] = load i8, ptr [[A]], align 1, !invariant.group [[META0]]
; CHECK-NEXT:    call void @foo2(ptr [[A]], i8 [[B]])
; CHECK-NEXT:    call void @bar(i8 [[B]])
; CHECK-NEXT:    call void @fooBit(ptr [[A]], i1 true)
; CHECK-NEXT:    [[TMP1:%.*]] = load i1, ptr [[A]], align 1, !invariant.group [[META0]]
; CHECK-NEXT:    call void @fooBit(ptr [[A]], i1 [[TMP1]])
; CHECK-NEXT:    call void @fooBit(ptr [[A]], i1 [[TMP1]])
; CHECK-NEXT:    ret void
;
  %a = alloca i8
  call void @foo(ptr %a)
  %b = load i8, ptr %a, !invariant.group !0
  call void @foo2(ptr %a, i8 %b)

  %1 = load i8, ptr %a, !invariant.group !0
  call void @bar(i8 %1)

  call void @fooBit(ptr %a, i1 1)
; FIXME: %1 = trunc i8 %b to i1
  %2 = load i1, ptr %a, !invariant.group !0
; FIXME-NEXT: call void @fooBit(ptr %a, i1 %1)
  call void @fooBit(ptr %a, i1 %2)
  %3 = load i1, ptr %a, !invariant.group !0
; FIXME-NEXT: call void @fooBit(ptr %a, i1 %1)
  call void @fooBit(ptr %a, i1 %3)
  ret void
}

; See comment in @testGEP0 on what NewGVN is lacking.
define void @handling_loops() {
; CHECK-LABEL: define void @handling_loops() {
; CHECK-NEXT:    [[A:%.*]] = alloca [[STRUCT_A:%.*]], align 8
; CHECK-NEXT:    store ptr getelementptr inbounds ([3 x ptr], ptr @_ZTV1A, i64 0, i64 2), ptr [[A]], align 8, !invariant.group [[META0]]
; CHECK-NEXT:    [[TMP1:%.*]] = load i8, ptr @unknownPtr, align 4
; CHECK-NEXT:    [[TMP2:%.*]] = icmp sgt i8 [[TMP1]], 0
; CHECK-NEXT:    br i1 [[TMP2]], label [[DOTLR_PH_I:%.*]], label [[_Z2G2R1A_EXIT:%.*]]
; CHECK:       .lr.ph.i:
; CHECK-NEXT:    [[TMP3:%.*]] = icmp sgt i8 [[TMP1]], 1
; CHECK-NEXT:    br i1 [[TMP3]], label [[DOT_CRIT_EDGE_PREHEADER:%.*]], label [[_Z2G2R1A_EXIT]]
; CHECK:       ._crit_edge.preheader:
; CHECK-NEXT:    br label [[DOT_CRIT_EDGE:%.*]]
; CHECK:       ._crit_edge:
; CHECK-NEXT:    [[TMP4:%.*]] = phi i8 [ [[TMP6:%.*]], [[DOT_CRIT_EDGE]] ], [ 1, [[DOT_CRIT_EDGE_PREHEADER]] ]
; CHECK-NEXT:    [[TMP5:%.*]] = load ptr, ptr getelementptr inbounds ([3 x ptr], ptr @_ZTV1A, i64 0, i64 2), align 8
; CHECK-NEXT:    call void [[TMP5]](ptr nonnull [[A]])
; CHECK-NEXT:    [[TMP6]] = add nuw nsw i8 [[TMP4]], 1
; CHECK-NEXT:    [[TMP7:%.*]] = load i8, ptr @unknownPtr, align 4
; CHECK-NEXT:    [[TMP8:%.*]] = icmp slt i8 [[TMP6]], [[TMP7]]
; CHECK-NEXT:    br i1 [[TMP8]], label [[DOT_CRIT_EDGE]], label [[_Z2G2R1A_EXIT_LOOPEXIT:%.*]]
; CHECK:       _Z2g2R1A.exit.loopexit:
; CHECK-NEXT:    br label [[_Z2G2R1A_EXIT]]
; CHECK:       _Z2g2R1A.exit:
; CHECK-NEXT:    ret void
;
  %a = alloca %struct.A, align 8
  store ptr getelementptr inbounds ([3 x ptr], ptr @_ZTV1A, i64 0, i64 2), ptr %a, align 8, !invariant.group !0
  %1 = load i8, ptr @unknownPtr, align 4
  %2 = icmp sgt i8 %1, 0
  br i1 %2, label %.lr.ph.i, label %_Z2g2R1A.exit

.lr.ph.i:                                         ; preds = %0
  %3 = load i8, ptr @unknownPtr, align 4
  %4 = icmp sgt i8 %3, 1
  br i1 %4, label %._crit_edge.preheader, label %_Z2g2R1A.exit

._crit_edge.preheader:                            ; preds = %.lr.ph.i
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.preheader, %._crit_edge
  %5 = phi i8 [ %7, %._crit_edge ], [ 1, %._crit_edge.preheader ]
  %.pre = load ptr, ptr %a, align 8, !invariant.group !0
  %6 = load ptr, ptr %.pre, align 8
  ; FIXME: call void @_ZN1A3fooEv(ptr nonnull %a)
  call void %6(ptr nonnull %a) #3
  ; FIXME-NOT: call void %
  %7 = add nuw nsw i8 %5, 1
  %8 = load i8, ptr @unknownPtr, align 4
  %9 = icmp slt i8 %7, %8
  br i1 %9, label %._crit_edge, label %_Z2g2R1A.exit.loopexit

_Z2g2R1A.exit.loopexit:                           ; preds = %._crit_edge
  br label %_Z2g2R1A.exit

_Z2g2R1A.exit:                                    ; preds = %_Z2g2R1A.exit.loopexit, %.lr.ph.i, %0
  ret void
}


declare void @foo(ptr)
declare void @foo2(ptr, i8)
declare void @bar(i8)
declare ptr @getPointer(ptr)
declare void @_ZN1A3fooEv(ptr)
declare void @_ZN1AC1Ev(ptr)
declare void @fooBit(ptr, i1)

declare ptr @llvm.launder.invariant.group.p0(ptr)
declare ptr @llvm.strip.invariant.group.p0(ptr)

; Function Attrs: nounwind
declare void @llvm.assume(i1 %cmp.vtables) #0


attributes #0 = { nounwind }
!0 = !{}
;.
; CHECK: [[META0]] = !{}
;.
