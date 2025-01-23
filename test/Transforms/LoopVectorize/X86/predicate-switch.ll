; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 5
; RUN: opt -p loop-vectorize -mtriple=x86_64-apple-macosx -mcpu=skylake-avx512 -force-vector-interleave=1 -S %s | FileCheck --check-prefixes=IC1 %s
; RUN: opt -p loop-vectorize -mtriple=x86_64-apple-macosx -mcpu=skylake-avx512 -force-vector-interleave=2 -S %s | FileCheck --check-prefixes=IC2 %s

define void @switch_default_to_latch_common_dest(ptr %start, ptr %end) {
; IC1-LABEL: define void @switch_default_to_latch_common_dest(
; IC1-SAME: ptr [[START:%.*]], ptr [[END:%.*]]) #[[ATTR0:[0-9]+]] {
; IC1-NEXT:  [[ENTRY:.*]]:
; IC1-NEXT:    br label %[[LOOP_HEADER:.*]]
; IC1:       [[LOOP_HEADER]]:
; IC1-NEXT:    [[PTR_IV:%.*]] = phi ptr [ [[START]], %[[ENTRY]] ], [ [[PTR_IV_NEXT:%.*]], %[[LOOP_LATCH:.*]] ]
; IC1-NEXT:    [[L:%.*]] = load i64, ptr [[PTR_IV]], align 1
; IC1-NEXT:    switch i64 [[L]], label %[[LOOP_LATCH]] [
; IC1-NEXT:      i64 -12, label %[[IF_THEN:.*]]
; IC1-NEXT:      i64 13, label %[[IF_THEN]]
; IC1-NEXT:    ]
; IC1:       [[IF_THEN]]:
; IC1-NEXT:    store i64 42, ptr [[PTR_IV]], align 1
; IC1-NEXT:    br label %[[LOOP_LATCH]]
; IC1:       [[LOOP_LATCH]]:
; IC1-NEXT:    [[PTR_IV_NEXT]] = getelementptr inbounds i64, ptr [[PTR_IV]], i64 1
; IC1-NEXT:    [[EC:%.*]] = icmp eq ptr [[PTR_IV_NEXT]], [[END]]
; IC1-NEXT:    br i1 [[EC]], label %[[EXIT:.*]], label %[[LOOP_HEADER]]
; IC1:       [[EXIT]]:
; IC1-NEXT:    ret void
;
; IC2-LABEL: define void @switch_default_to_latch_common_dest(
; IC2-SAME: ptr [[START:%.*]], ptr [[END:%.*]]) #[[ATTR0:[0-9]+]] {
; IC2-NEXT:  [[ENTRY:.*]]:
; IC2-NEXT:    br label %[[LOOP_HEADER:.*]]
; IC2:       [[LOOP_HEADER]]:
; IC2-NEXT:    [[PTR_IV:%.*]] = phi ptr [ [[START]], %[[ENTRY]] ], [ [[PTR_IV_NEXT:%.*]], %[[LOOP_LATCH:.*]] ]
; IC2-NEXT:    [[L:%.*]] = load i64, ptr [[PTR_IV]], align 1
; IC2-NEXT:    switch i64 [[L]], label %[[LOOP_LATCH]] [
; IC2-NEXT:      i64 -12, label %[[IF_THEN:.*]]
; IC2-NEXT:      i64 13, label %[[IF_THEN]]
; IC2-NEXT:    ]
; IC2:       [[IF_THEN]]:
; IC2-NEXT:    store i64 42, ptr [[PTR_IV]], align 1
; IC2-NEXT:    br label %[[LOOP_LATCH]]
; IC2:       [[LOOP_LATCH]]:
; IC2-NEXT:    [[PTR_IV_NEXT]] = getelementptr inbounds i64, ptr [[PTR_IV]], i64 1
; IC2-NEXT:    [[EC:%.*]] = icmp eq ptr [[PTR_IV_NEXT]], [[END]]
; IC2-NEXT:    br i1 [[EC]], label %[[EXIT:.*]], label %[[LOOP_HEADER]]
; IC2:       [[EXIT]]:
; IC2-NEXT:    ret void
;
entry:
  br label %loop.header

loop.header:
  %ptr.iv = phi ptr [ %start, %entry ], [ %ptr.iv.next, %loop.latch ]
  %l = load i64, ptr %ptr.iv, align 1
  switch i64 %l, label %loop.latch [
  i64 -12, label %if.then
  i64 13, label %if.then
  ]

if.then:
  store i64 42, ptr %ptr.iv, align 1
  br label %loop.latch

loop.latch:
  %ptr.iv.next = getelementptr inbounds i64, ptr %ptr.iv, i64 1
  %ec = icmp eq ptr %ptr.iv.next, %end
  br i1 %ec, label %exit, label %loop.header

exit:
  ret void
}

define void @switch_all_dests_distinct(ptr %start, ptr %end) {
; IC1-LABEL: define void @switch_all_dests_distinct(
; IC1-SAME: ptr [[START:%.*]], ptr [[END:%.*]]) #[[ATTR0]] {
; IC1-NEXT:  [[ENTRY:.*]]:
; IC1-NEXT:    br label %[[LOOP_HEADER:.*]]
; IC1:       [[LOOP_HEADER]]:
; IC1-NEXT:    [[PTR_IV:%.*]] = phi ptr [ [[START]], %[[ENTRY]] ], [ [[PTR_IV_NEXT:%.*]], %[[LOOP_LATCH:.*]] ]
; IC1-NEXT:    [[L:%.*]] = load i64, ptr [[PTR_IV]], align 1
; IC1-NEXT:    switch i64 [[L]], label %[[DEFAULT:.*]] [
; IC1-NEXT:      i64 -12, label %[[IF_THEN_1:.*]]
; IC1-NEXT:      i64 13, label %[[IF_THEN_2:.*]]
; IC1-NEXT:      i64 0, label %[[IF_THEN_3:.*]]
; IC1-NEXT:    ]
; IC1:       [[IF_THEN_1]]:
; IC1-NEXT:    store i64 42, ptr [[PTR_IV]], align 1
; IC1-NEXT:    br label %[[LOOP_LATCH]]
; IC1:       [[IF_THEN_2]]:
; IC1-NEXT:    store i64 0, ptr [[PTR_IV]], align 1
; IC1-NEXT:    br label %[[LOOP_LATCH]]
; IC1:       [[IF_THEN_3]]:
; IC1-NEXT:    store i64 1, ptr [[PTR_IV]], align 1
; IC1-NEXT:    br label %[[LOOP_LATCH]]
; IC1:       [[DEFAULT]]:
; IC1-NEXT:    store i64 2, ptr [[PTR_IV]], align 1
; IC1-NEXT:    br label %[[LOOP_LATCH]]
; IC1:       [[LOOP_LATCH]]:
; IC1-NEXT:    [[PTR_IV_NEXT]] = getelementptr inbounds i64, ptr [[PTR_IV]], i64 1
; IC1-NEXT:    [[EC:%.*]] = icmp eq ptr [[PTR_IV_NEXT]], [[END]]
; IC1-NEXT:    br i1 [[EC]], label %[[EXIT:.*]], label %[[LOOP_HEADER]]
; IC1:       [[EXIT]]:
; IC1-NEXT:    ret void
;
; IC2-LABEL: define void @switch_all_dests_distinct(
; IC2-SAME: ptr [[START:%.*]], ptr [[END:%.*]]) #[[ATTR0]] {
; IC2-NEXT:  [[ENTRY:.*]]:
; IC2-NEXT:    br label %[[LOOP_HEADER:.*]]
; IC2:       [[LOOP_HEADER]]:
; IC2-NEXT:    [[PTR_IV:%.*]] = phi ptr [ [[START]], %[[ENTRY]] ], [ [[PTR_IV_NEXT:%.*]], %[[LOOP_LATCH:.*]] ]
; IC2-NEXT:    [[L:%.*]] = load i64, ptr [[PTR_IV]], align 1
; IC2-NEXT:    switch i64 [[L]], label %[[DEFAULT:.*]] [
; IC2-NEXT:      i64 -12, label %[[IF_THEN_1:.*]]
; IC2-NEXT:      i64 13, label %[[IF_THEN_2:.*]]
; IC2-NEXT:      i64 0, label %[[IF_THEN_3:.*]]
; IC2-NEXT:    ]
; IC2:       [[IF_THEN_1]]:
; IC2-NEXT:    store i64 42, ptr [[PTR_IV]], align 1
; IC2-NEXT:    br label %[[LOOP_LATCH]]
; IC2:       [[IF_THEN_2]]:
; IC2-NEXT:    store i64 0, ptr [[PTR_IV]], align 1
; IC2-NEXT:    br label %[[LOOP_LATCH]]
; IC2:       [[IF_THEN_3]]:
; IC2-NEXT:    store i64 1, ptr [[PTR_IV]], align 1
; IC2-NEXT:    br label %[[LOOP_LATCH]]
; IC2:       [[DEFAULT]]:
; IC2-NEXT:    store i64 2, ptr [[PTR_IV]], align 1
; IC2-NEXT:    br label %[[LOOP_LATCH]]
; IC2:       [[LOOP_LATCH]]:
; IC2-NEXT:    [[PTR_IV_NEXT]] = getelementptr inbounds i64, ptr [[PTR_IV]], i64 1
; IC2-NEXT:    [[EC:%.*]] = icmp eq ptr [[PTR_IV_NEXT]], [[END]]
; IC2-NEXT:    br i1 [[EC]], label %[[EXIT:.*]], label %[[LOOP_HEADER]]
; IC2:       [[EXIT]]:
; IC2-NEXT:    ret void
;
entry:
  br label %loop.header

loop.header:
  %ptr.iv = phi ptr [ %start, %entry ], [ %ptr.iv.next, %loop.latch ]
  %l = load i64, ptr %ptr.iv, align 1
  switch i64 %l, label %default [
  i64 -12, label %if.then.1
  i64 13, label %if.then.2
  i64 0, label %if.then.3
  ]

if.then.1:
  store i64 42, ptr %ptr.iv, align 1
  br label %loop.latch

if.then.2:
  store i64 0, ptr %ptr.iv, align 1
  br label %loop.latch

if.then.3:
  store i64 1, ptr %ptr.iv, align 1
  br label %loop.latch

default:
  store i64 2, ptr %ptr.iv, align 1
  br label %loop.latch

loop.latch:
  %ptr.iv.next = getelementptr inbounds i64, ptr %ptr.iv, i64 1
  %ec = icmp eq ptr %ptr.iv.next, %end
  br i1 %ec, label %exit, label %loop.header

exit:
  ret void
}


define void @switch_multiple_common_dests(ptr %start, ptr %end) {
; IC1-LABEL: define void @switch_multiple_common_dests(
; IC1-SAME: ptr [[START:%.*]], ptr [[END:%.*]]) #[[ATTR0]] {
; IC1-NEXT:  [[ENTRY:.*]]:
; IC1-NEXT:    br label %[[LOOP_HEADER:.*]]
; IC1:       [[LOOP_HEADER]]:
; IC1-NEXT:    [[PTR_IV:%.*]] = phi ptr [ [[START]], %[[ENTRY]] ], [ [[PTR_IV_NEXT:%.*]], %[[LOOP_LATCH:.*]] ]
; IC1-NEXT:    [[L:%.*]] = load i64, ptr [[PTR_IV]], align 1
; IC1-NEXT:    switch i64 [[L]], label %[[DEFAULT:.*]] [
; IC1-NEXT:      i64 -12, label %[[IF_THEN_1:.*]]
; IC1-NEXT:      i64 0, label %[[IF_THEN_1]]
; IC1-NEXT:      i64 13, label %[[IF_THEN_2:.*]]
; IC1-NEXT:      i64 14, label %[[IF_THEN_2]]
; IC1-NEXT:      i64 15, label %[[IF_THEN_2]]
; IC1-NEXT:    ]
; IC1:       [[IF_THEN_1]]:
; IC1-NEXT:    store i64 42, ptr [[PTR_IV]], align 1
; IC1-NEXT:    br label %[[LOOP_LATCH]]
; IC1:       [[IF_THEN_2]]:
; IC1-NEXT:    store i64 0, ptr [[PTR_IV]], align 1
; IC1-NEXT:    br label %[[LOOP_LATCH]]
; IC1:       [[DEFAULT]]:
; IC1-NEXT:    store i64 2, ptr [[PTR_IV]], align 1
; IC1-NEXT:    br label %[[LOOP_LATCH]]
; IC1:       [[LOOP_LATCH]]:
; IC1-NEXT:    [[PTR_IV_NEXT]] = getelementptr inbounds i64, ptr [[PTR_IV]], i64 1
; IC1-NEXT:    [[EC:%.*]] = icmp eq ptr [[PTR_IV_NEXT]], [[END]]
; IC1-NEXT:    br i1 [[EC]], label %[[EXIT:.*]], label %[[LOOP_HEADER]]
; IC1:       [[EXIT]]:
; IC1-NEXT:    ret void
;
; IC2-LABEL: define void @switch_multiple_common_dests(
; IC2-SAME: ptr [[START:%.*]], ptr [[END:%.*]]) #[[ATTR0]] {
; IC2-NEXT:  [[ENTRY:.*]]:
; IC2-NEXT:    br label %[[LOOP_HEADER:.*]]
; IC2:       [[LOOP_HEADER]]:
; IC2-NEXT:    [[PTR_IV:%.*]] = phi ptr [ [[START]], %[[ENTRY]] ], [ [[PTR_IV_NEXT:%.*]], %[[LOOP_LATCH:.*]] ]
; IC2-NEXT:    [[L:%.*]] = load i64, ptr [[PTR_IV]], align 1
; IC2-NEXT:    switch i64 [[L]], label %[[DEFAULT:.*]] [
; IC2-NEXT:      i64 -12, label %[[IF_THEN_1:.*]]
; IC2-NEXT:      i64 0, label %[[IF_THEN_1]]
; IC2-NEXT:      i64 13, label %[[IF_THEN_2:.*]]
; IC2-NEXT:      i64 14, label %[[IF_THEN_2]]
; IC2-NEXT:      i64 15, label %[[IF_THEN_2]]
; IC2-NEXT:    ]
; IC2:       [[IF_THEN_1]]:
; IC2-NEXT:    store i64 42, ptr [[PTR_IV]], align 1
; IC2-NEXT:    br label %[[LOOP_LATCH]]
; IC2:       [[IF_THEN_2]]:
; IC2-NEXT:    store i64 0, ptr [[PTR_IV]], align 1
; IC2-NEXT:    br label %[[LOOP_LATCH]]
; IC2:       [[DEFAULT]]:
; IC2-NEXT:    store i64 2, ptr [[PTR_IV]], align 1
; IC2-NEXT:    br label %[[LOOP_LATCH]]
; IC2:       [[LOOP_LATCH]]:
; IC2-NEXT:    [[PTR_IV_NEXT]] = getelementptr inbounds i64, ptr [[PTR_IV]], i64 1
; IC2-NEXT:    [[EC:%.*]] = icmp eq ptr [[PTR_IV_NEXT]], [[END]]
; IC2-NEXT:    br i1 [[EC]], label %[[EXIT:.*]], label %[[LOOP_HEADER]]
; IC2:       [[EXIT]]:
; IC2-NEXT:    ret void
;
entry:
  br label %loop.header

loop.header:
  %ptr.iv = phi ptr [ %start, %entry ], [ %ptr.iv.next, %loop.latch ]
  %l = load i64, ptr %ptr.iv, align 1
  switch i64 %l, label %default [
  i64 -12, label %if.then.1
  i64 0, label %if.then.1
  i64 13, label %if.then.2
  i64 14, label %if.then.2
  i64 15, label %if.then.2
  ]

if.then.1:
  store i64 42, ptr %ptr.iv, align 1
  br label %loop.latch

if.then.2:
  store i64 0, ptr %ptr.iv, align 1
  br label %loop.latch

default:
  store i64 2, ptr %ptr.iv, align 1
  br label %loop.latch

loop.latch:
  %ptr.iv.next = getelementptr inbounds i64, ptr %ptr.iv, i64 1
  %ec = icmp eq ptr %ptr.iv.next, %end
  br i1 %ec, label %exit, label %loop.header

exit:
  ret void
}

define void @switch4_default_common_dest_with_case(ptr %start, ptr %end) {
; IC1-LABEL: define void @switch4_default_common_dest_with_case(
; IC1-SAME: ptr [[START:%.*]], ptr [[END:%.*]]) #[[ATTR0]] {
; IC1-NEXT:  [[ENTRY:.*]]:
; IC1-NEXT:    br label %[[LOOP_HEADER:.*]]
; IC1:       [[LOOP_HEADER]]:
; IC1-NEXT:    [[PTR_IV:%.*]] = phi ptr [ [[START]], %[[ENTRY]] ], [ [[PTR_IV_NEXT:%.*]], %[[LOOP_LATCH:.*]] ]
; IC1-NEXT:    [[L:%.*]] = load i64, ptr [[PTR_IV]], align 1
; IC1-NEXT:    switch i64 [[L]], label %[[DEFAULT:.*]] [
; IC1-NEXT:      i64 -12, label %[[IF_THEN_1:.*]]
; IC1-NEXT:      i64 13, label %[[IF_THEN_2:.*]]
; IC1-NEXT:      i64 0, label %[[DEFAULT]]
; IC1-NEXT:    ]
; IC1:       [[IF_THEN_1]]:
; IC1-NEXT:    store i64 42, ptr [[PTR_IV]], align 1
; IC1-NEXT:    br label %[[LOOP_LATCH]]
; IC1:       [[IF_THEN_2]]:
; IC1-NEXT:    store i64 0, ptr [[PTR_IV]], align 1
; IC1-NEXT:    br label %[[LOOP_LATCH]]
; IC1:       [[DEFAULT]]:
; IC1-NEXT:    store i64 2, ptr [[PTR_IV]], align 1
; IC1-NEXT:    br label %[[LOOP_LATCH]]
; IC1:       [[LOOP_LATCH]]:
; IC1-NEXT:    [[PTR_IV_NEXT]] = getelementptr inbounds i64, ptr [[PTR_IV]], i64 1
; IC1-NEXT:    [[EC:%.*]] = icmp eq ptr [[PTR_IV_NEXT]], [[END]]
; IC1-NEXT:    br i1 [[EC]], label %[[EXIT:.*]], label %[[LOOP_HEADER]]
; IC1:       [[EXIT]]:
; IC1-NEXT:    ret void
;
; IC2-LABEL: define void @switch4_default_common_dest_with_case(
; IC2-SAME: ptr [[START:%.*]], ptr [[END:%.*]]) #[[ATTR0]] {
; IC2-NEXT:  [[ENTRY:.*]]:
; IC2-NEXT:    br label %[[LOOP_HEADER:.*]]
; IC2:       [[LOOP_HEADER]]:
; IC2-NEXT:    [[PTR_IV:%.*]] = phi ptr [ [[START]], %[[ENTRY]] ], [ [[PTR_IV_NEXT:%.*]], %[[LOOP_LATCH:.*]] ]
; IC2-NEXT:    [[L:%.*]] = load i64, ptr [[PTR_IV]], align 1
; IC2-NEXT:    switch i64 [[L]], label %[[DEFAULT:.*]] [
; IC2-NEXT:      i64 -12, label %[[IF_THEN_1:.*]]
; IC2-NEXT:      i64 13, label %[[IF_THEN_2:.*]]
; IC2-NEXT:      i64 0, label %[[DEFAULT]]
; IC2-NEXT:    ]
; IC2:       [[IF_THEN_1]]:
; IC2-NEXT:    store i64 42, ptr [[PTR_IV]], align 1
; IC2-NEXT:    br label %[[LOOP_LATCH]]
; IC2:       [[IF_THEN_2]]:
; IC2-NEXT:    store i64 0, ptr [[PTR_IV]], align 1
; IC2-NEXT:    br label %[[LOOP_LATCH]]
; IC2:       [[DEFAULT]]:
; IC2-NEXT:    store i64 2, ptr [[PTR_IV]], align 1
; IC2-NEXT:    br label %[[LOOP_LATCH]]
; IC2:       [[LOOP_LATCH]]:
; IC2-NEXT:    [[PTR_IV_NEXT]] = getelementptr inbounds i64, ptr [[PTR_IV]], i64 1
; IC2-NEXT:    [[EC:%.*]] = icmp eq ptr [[PTR_IV_NEXT]], [[END]]
; IC2-NEXT:    br i1 [[EC]], label %[[EXIT:.*]], label %[[LOOP_HEADER]]
; IC2:       [[EXIT]]:
; IC2-NEXT:    ret void
;
entry:
  br label %loop.header

loop.header:
  %ptr.iv = phi ptr [ %start, %entry ], [ %ptr.iv.next, %loop.latch ]
  %l = load i64, ptr %ptr.iv, align 1
  switch i64 %l, label %default [
  i64 -12, label %if.then.1
  i64 13, label %if.then.2
  i64 0, label %default
  ]

if.then.1:
  store i64 42, ptr %ptr.iv, align 1
  br label %loop.latch

if.then.2:
  store i64 0, ptr %ptr.iv, align 1
  br label %loop.latch

default:
  store i64 2, ptr %ptr.iv, align 1
  br label %loop.latch

loop.latch:
  %ptr.iv.next = getelementptr inbounds i64, ptr %ptr.iv, i64 1
  %ec = icmp eq ptr %ptr.iv.next, %end
  br i1 %ec, label %exit, label %loop.header

exit:
  ret void
}

define void @switch_under_br_default_common_dest_with_case(ptr %start, ptr %end, i64 %x) {
; IC1-LABEL: define void @switch_under_br_default_common_dest_with_case(
; IC1-SAME: ptr [[START:%.*]], ptr [[END:%.*]], i64 [[X:%.*]]) #[[ATTR0]] {
; IC1-NEXT:  [[ENTRY:.*]]:
; IC1-NEXT:    br label %[[LOOP_HEADER:.*]]
; IC1:       [[LOOP_HEADER]]:
; IC1-NEXT:    [[PTR_IV:%.*]] = phi ptr [ [[START]], %[[ENTRY]] ], [ [[PTR_IV_NEXT:%.*]], %[[LOOP_LATCH:.*]] ]
; IC1-NEXT:    [[L:%.*]] = load i64, ptr [[PTR_IV]], align 1
; IC1-NEXT:    [[C:%.*]] = icmp ule i64 [[L]], [[X]]
; IC1-NEXT:    br i1 [[C]], label %[[THEN:.*]], label %[[LOOP_LATCH]]
; IC1:       [[THEN]]:
; IC1-NEXT:    switch i64 [[L]], label %[[DEFAULT:.*]] [
; IC1-NEXT:      i64 -12, label %[[IF_THEN_1:.*]]
; IC1-NEXT:      i64 13, label %[[IF_THEN_2:.*]]
; IC1-NEXT:      i64 0, label %[[DEFAULT]]
; IC1-NEXT:    ]
; IC1:       [[IF_THEN_1]]:
; IC1-NEXT:    store i64 42, ptr [[PTR_IV]], align 1
; IC1-NEXT:    br label %[[LOOP_LATCH]]
; IC1:       [[IF_THEN_2]]:
; IC1-NEXT:    store i64 0, ptr [[PTR_IV]], align 1
; IC1-NEXT:    br label %[[LOOP_LATCH]]
; IC1:       [[DEFAULT]]:
; IC1-NEXT:    store i64 2, ptr [[PTR_IV]], align 1
; IC1-NEXT:    br label %[[LOOP_LATCH]]
; IC1:       [[LOOP_LATCH]]:
; IC1-NEXT:    [[PTR_IV_NEXT]] = getelementptr inbounds i64, ptr [[PTR_IV]], i64 1
; IC1-NEXT:    [[EC:%.*]] = icmp eq ptr [[PTR_IV_NEXT]], [[END]]
; IC1-NEXT:    br i1 [[EC]], label %[[EXIT:.*]], label %[[LOOP_HEADER]]
; IC1:       [[EXIT]]:
; IC1-NEXT:    ret void
;
; IC2-LABEL: define void @switch_under_br_default_common_dest_with_case(
; IC2-SAME: ptr [[START:%.*]], ptr [[END:%.*]], i64 [[X:%.*]]) #[[ATTR0]] {
; IC2-NEXT:  [[ENTRY:.*]]:
; IC2-NEXT:    br label %[[LOOP_HEADER:.*]]
; IC2:       [[LOOP_HEADER]]:
; IC2-NEXT:    [[PTR_IV:%.*]] = phi ptr [ [[START]], %[[ENTRY]] ], [ [[PTR_IV_NEXT:%.*]], %[[LOOP_LATCH:.*]] ]
; IC2-NEXT:    [[L:%.*]] = load i64, ptr [[PTR_IV]], align 1
; IC2-NEXT:    [[C:%.*]] = icmp ule i64 [[L]], [[X]]
; IC2-NEXT:    br i1 [[C]], label %[[THEN:.*]], label %[[LOOP_LATCH]]
; IC2:       [[THEN]]:
; IC2-NEXT:    switch i64 [[L]], label %[[DEFAULT:.*]] [
; IC2-NEXT:      i64 -12, label %[[IF_THEN_1:.*]]
; IC2-NEXT:      i64 13, label %[[IF_THEN_2:.*]]
; IC2-NEXT:      i64 0, label %[[DEFAULT]]
; IC2-NEXT:    ]
; IC2:       [[IF_THEN_1]]:
; IC2-NEXT:    store i64 42, ptr [[PTR_IV]], align 1
; IC2-NEXT:    br label %[[LOOP_LATCH]]
; IC2:       [[IF_THEN_2]]:
; IC2-NEXT:    store i64 0, ptr [[PTR_IV]], align 1
; IC2-NEXT:    br label %[[LOOP_LATCH]]
; IC2:       [[DEFAULT]]:
; IC2-NEXT:    store i64 2, ptr [[PTR_IV]], align 1
; IC2-NEXT:    br label %[[LOOP_LATCH]]
; IC2:       [[LOOP_LATCH]]:
; IC2-NEXT:    [[PTR_IV_NEXT]] = getelementptr inbounds i64, ptr [[PTR_IV]], i64 1
; IC2-NEXT:    [[EC:%.*]] = icmp eq ptr [[PTR_IV_NEXT]], [[END]]
; IC2-NEXT:    br i1 [[EC]], label %[[EXIT:.*]], label %[[LOOP_HEADER]]
; IC2:       [[EXIT]]:
; IC2-NEXT:    ret void
;
entry:
  br label %loop.header

loop.header:
  %ptr.iv = phi ptr [ %start, %entry ], [ %ptr.iv.next, %loop.latch ]
  %l = load i64, ptr %ptr.iv, align 1
  %c = icmp ule i64 %l, %x
  br i1 %c, label %then, label %loop.latch

then:
  switch i64 %l, label %default [
  i64 -12, label %if.then.1
  i64 13, label %if.then.2
  i64 0, label %default
  ]

if.then.1:
  store i64 42, ptr %ptr.iv, align 1
  br label %loop.latch

if.then.2:
  store i64 0, ptr %ptr.iv, align 1
  br label %loop.latch

default:
  store i64 2, ptr %ptr.iv, align 1
  br label %loop.latch

loop.latch:
  %ptr.iv.next = getelementptr inbounds i64, ptr %ptr.iv, i64 1
  %ec = icmp eq ptr %ptr.iv.next, %end
  br i1 %ec, label %exit, label %loop.header

exit:
  ret void
}

define void @br_under_switch_default_common_dest_with_case(ptr %start, ptr %end, i64 %x) {
; IC1-LABEL: define void @br_under_switch_default_common_dest_with_case(
; IC1-SAME: ptr [[START:%.*]], ptr [[END:%.*]], i64 [[X:%.*]]) #[[ATTR0]] {
; IC1-NEXT:  [[ENTRY:.*]]:
; IC1-NEXT:    br label %[[LOOP_HEADER:.*]]
; IC1:       [[LOOP_HEADER]]:
; IC1-NEXT:    [[PTR_IV:%.*]] = phi ptr [ [[START]], %[[ENTRY]] ], [ [[PTR_IV_NEXT:%.*]], %[[LOOP_LATCH:.*]] ]
; IC1-NEXT:    [[L:%.*]] = load i64, ptr [[PTR_IV]], align 1
; IC1-NEXT:    switch i64 [[L]], label %[[DEFAULT:.*]] [
; IC1-NEXT:      i64 -12, label %[[IF_THEN_1:.*]]
; IC1-NEXT:      i64 13, label %[[IF_THEN_2:.*]]
; IC1-NEXT:      i64 0, label %[[DEFAULT]]
; IC1-NEXT:    ]
; IC1:       [[IF_THEN_1]]:
; IC1-NEXT:    [[C:%.*]] = icmp ule i64 [[L]], [[X]]
; IC1-NEXT:    br i1 [[C]], label %[[THEN:.*]], label %[[IF_THEN_2]]
; IC1:       [[THEN]]:
; IC1-NEXT:    store i64 42, ptr [[PTR_IV]], align 1
; IC1-NEXT:    br label %[[DEFAULT]]
; IC1:       [[IF_THEN_2]]:
; IC1-NEXT:    store i64 0, ptr [[PTR_IV]], align 1
; IC1-NEXT:    br label %[[LOOP_LATCH]]
; IC1:       [[DEFAULT]]:
; IC1-NEXT:    store i64 2, ptr [[PTR_IV]], align 1
; IC1-NEXT:    br label %[[LOOP_LATCH]]
; IC1:       [[LOOP_LATCH]]:
; IC1-NEXT:    [[PTR_IV_NEXT]] = getelementptr inbounds i64, ptr [[PTR_IV]], i64 1
; IC1-NEXT:    [[EC:%.*]] = icmp eq ptr [[PTR_IV_NEXT]], [[END]]
; IC1-NEXT:    br i1 [[EC]], label %[[EXIT:.*]], label %[[LOOP_HEADER]]
; IC1:       [[EXIT]]:
; IC1-NEXT:    ret void
;
; IC2-LABEL: define void @br_under_switch_default_common_dest_with_case(
; IC2-SAME: ptr [[START:%.*]], ptr [[END:%.*]], i64 [[X:%.*]]) #[[ATTR0]] {
; IC2-NEXT:  [[ENTRY:.*]]:
; IC2-NEXT:    br label %[[LOOP_HEADER:.*]]
; IC2:       [[LOOP_HEADER]]:
; IC2-NEXT:    [[PTR_IV:%.*]] = phi ptr [ [[START]], %[[ENTRY]] ], [ [[PTR_IV_NEXT:%.*]], %[[LOOP_LATCH:.*]] ]
; IC2-NEXT:    [[L:%.*]] = load i64, ptr [[PTR_IV]], align 1
; IC2-NEXT:    switch i64 [[L]], label %[[DEFAULT:.*]] [
; IC2-NEXT:      i64 -12, label %[[IF_THEN_1:.*]]
; IC2-NEXT:      i64 13, label %[[IF_THEN_2:.*]]
; IC2-NEXT:      i64 0, label %[[DEFAULT]]
; IC2-NEXT:    ]
; IC2:       [[IF_THEN_1]]:
; IC2-NEXT:    [[C:%.*]] = icmp ule i64 [[L]], [[X]]
; IC2-NEXT:    br i1 [[C]], label %[[THEN:.*]], label %[[IF_THEN_2]]
; IC2:       [[THEN]]:
; IC2-NEXT:    store i64 42, ptr [[PTR_IV]], align 1
; IC2-NEXT:    br label %[[DEFAULT]]
; IC2:       [[IF_THEN_2]]:
; IC2-NEXT:    store i64 0, ptr [[PTR_IV]], align 1
; IC2-NEXT:    br label %[[LOOP_LATCH]]
; IC2:       [[DEFAULT]]:
; IC2-NEXT:    store i64 2, ptr [[PTR_IV]], align 1
; IC2-NEXT:    br label %[[LOOP_LATCH]]
; IC2:       [[LOOP_LATCH]]:
; IC2-NEXT:    [[PTR_IV_NEXT]] = getelementptr inbounds i64, ptr [[PTR_IV]], i64 1
; IC2-NEXT:    [[EC:%.*]] = icmp eq ptr [[PTR_IV_NEXT]], [[END]]
; IC2-NEXT:    br i1 [[EC]], label %[[EXIT:.*]], label %[[LOOP_HEADER]]
; IC2:       [[EXIT]]:
; IC2-NEXT:    ret void
;
entry:
  br label %loop.header

loop.header:
  %ptr.iv = phi ptr [ %start, %entry ], [ %ptr.iv.next, %loop.latch ]
  %l = load i64, ptr %ptr.iv, align 1
  switch i64 %l, label %default [
  i64 -12, label %if.then.1
  i64 13, label %if.then.2
  i64 0, label %default
  ]

if.then.1:
  %c = icmp ule i64 %l, %x
  br i1 %c, label %then, label %if.then.2

then:
  store i64 42, ptr %ptr.iv, align 1
  br label %default

if.then.2:
  store i64 0, ptr %ptr.iv, align 1
  br label %loop.latch

default:
  store i64 2, ptr %ptr.iv, align 1
  br label %loop.latch

loop.latch:
  %ptr.iv.next = getelementptr inbounds i64, ptr %ptr.iv, i64 1
  %ec = icmp eq ptr %ptr.iv.next, %end
  br i1 %ec, label %exit, label %loop.header

exit:
  ret void
}
