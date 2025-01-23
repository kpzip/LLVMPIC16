; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=sccp -S | FileCheck %s

declare void @use.i32(i32)
declare void @use.i1(i1)

define void @and_constexpr(i32 %a) {
; CHECK-LABEL: @and_constexpr(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    call void @use.i32(i32 0)
; CHECK-NEXT:    [[AND_2:%.*]] = and i32 20, [[A:%.*]]
; CHECK-NEXT:    call void @use.i32(i32 [[AND_2]])
; CHECK-NEXT:    call void @use.i1(i1 true)
; CHECK-NEXT:    call void @use.i1(i1 false)
; CHECK-NEXT:    [[COND_1:%.*]] = icmp eq i32 [[AND_2]], 10
; CHECK-NEXT:    call void @use.i1(i1 [[COND_1]])
; CHECK-NEXT:    call void @use.i32(i32 4)
; CHECK-NEXT:    ret void
;
entry:
  %and.1 = and i32 ptrtoint (ptr inttoptr (i32 0 to ptr) to i32), %a
  call void @use.i32(i32 %and.1)
  %and.2 = and i32 ptrtoint (ptr inttoptr (i32 20 to ptr) to i32), %a
  call void @use.i32(i32 %and.2)
  %true.1 = icmp ne i32 %and.2, 100
  call void @use.i1(i1 %true.1)
  %false.1 = icmp eq i32 %and.2, 100
  call void @use.i1(i1 %false.1)
  %cond.1 = icmp eq i32 %and.2, 10
  call void @use.i1(i1 %cond.1)
  %and.3 = and i32 ptrtoint (ptr inttoptr (i32 20 to ptr) to i32), ptrtoint (ptr inttoptr (i32 100 to ptr) to i32)
  call void @use.i32(i32 %and.3)
  ret void
}

define void @add_constexpr(i32 %a) {
; CHECK-LABEL: @add_constexpr(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD_1:%.*]] = add nuw nsw i32 0, [[A:%.*]]
; CHECK-NEXT:    call void @use.i32(i32 [[ADD_1]])
; CHECK-NEXT:    [[ADD_2:%.*]] = add i32 20, [[A]]
; CHECK-NEXT:    call void @use.i32(i32 [[ADD_2]])
; CHECK-NEXT:    [[COND_1:%.*]] = icmp ne i32 [[ADD_2]], 100
; CHECK-NEXT:    call void @use.i1(i1 [[COND_1]])
; CHECK-NEXT:    [[COND_2:%.*]] = icmp eq i32 [[ADD_2]], 100
; CHECK-NEXT:    call void @use.i1(i1 [[COND_2]])
; CHECK-NEXT:    [[COND_3:%.*]] = icmp eq i32 [[ADD_2]], 10
; CHECK-NEXT:    call void @use.i1(i1 [[COND_3]])
; CHECK-NEXT:    call void @use.i32(i32 120)
; CHECK-NEXT:    ret void
;
entry:
  %add.1 = add i32 ptrtoint (ptr inttoptr (i32 0 to ptr) to i32), %a
  call void @use.i32(i32 %add.1)
  %add.2 = add i32 ptrtoint (ptr inttoptr (i32 20 to ptr) to i32), %a
  call void @use.i32(i32 %add.2)
  %cond.1 = icmp ne i32 %add.2, 100
  call void @use.i1(i1 %cond.1)
  %cond.2 = icmp eq i32 %add.2, 100
  call void @use.i1(i1 %cond.2)
  %cond.3 = icmp eq i32 %add.2, 10
  call void @use.i1(i1 %cond.3)
  %add.3 = add i32 ptrtoint (ptr inttoptr (i32 20 to ptr) to i32), ptrtoint (ptr inttoptr (i32 100 to ptr) to i32)
  call void @use.i32(i32 %add.3)
  ret void
}

define void @mul_constexpr(i32 %a) {
; CHECK-LABEL: @mul_constexpr(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    call void @use.i32(i32 0)
; CHECK-NEXT:    [[MUL_2:%.*]] = mul i32 20, [[A:%.*]]
; CHECK-NEXT:    call void @use.i32(i32 [[MUL_2]])
; CHECK-NEXT:    [[COND_1:%.*]] = icmp ne i32 [[MUL_2]], 100
; CHECK-NEXT:    call void @use.i1(i1 [[COND_1]])
; CHECK-NEXT:    [[COND_2:%.*]] = icmp eq i32 [[MUL_2]], 100
; CHECK-NEXT:    call void @use.i1(i1 [[COND_2]])
; CHECK-NEXT:    [[COND_3:%.*]] = icmp eq i32 [[MUL_2]], 10
; CHECK-NEXT:    call void @use.i1(i1 [[COND_3]])
; CHECK-NEXT:    call void @use.i32(i32 2000)
; CHECK-NEXT:    ret void
;
entry:
  %mul.1 = mul i32 ptrtoint (ptr inttoptr (i32 0 to ptr) to i32), %a
  call void @use.i32(i32 %mul.1)
  %mul.2 = mul i32 ptrtoint (ptr inttoptr (i32 20 to ptr) to i32), %a
  call void @use.i32(i32 %mul.2)
  %cond.1 = icmp ne i32 %mul.2, 100
  call void @use.i1(i1 %cond.1)
  %cond.2 = icmp eq i32 %mul.2, 100
  call void @use.i1(i1 %cond.2)
  %cond.3 = icmp eq i32 %mul.2, 10
  call void @use.i1(i1 %cond.3)
  %mul.3 = mul i32 ptrtoint (ptr inttoptr (i32 20 to ptr) to i32), ptrtoint (ptr inttoptr (i32 100 to ptr) to i32)
  call void @use.i32(i32 %mul.3)
  ret void
}

define void @udiv_constexpr(i32 %a) {
; CHECK-LABEL: @udiv_constexpr(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    call void @use.i32(i32 0)
; CHECK-NEXT:    [[UDIV_2:%.*]] = udiv i32 20, [[A:%.*]]
; CHECK-NEXT:    call void @use.i32(i32 [[UDIV_2]])
; CHECK-NEXT:    call void @use.i1(i1 true)
; CHECK-NEXT:    call void @use.i1(i1 false)
; CHECK-NEXT:    [[COND_1:%.*]] = icmp eq i32 [[UDIV_2]], 10
; CHECK-NEXT:    call void @use.i1(i1 [[COND_1]])
; CHECK-NEXT:    call void @use.i32(i32 0)
; CHECK-NEXT:    ret void
;
entry:
  %udiv.1 = udiv i32 ptrtoint (ptr inttoptr (i32 0 to ptr) to i32), %a
  call void @use.i32(i32 %udiv.1)
  %udiv.2 = udiv i32 ptrtoint (ptr inttoptr (i32 20 to ptr) to i32), %a
  call void @use.i32(i32 %udiv.2)
  %true.1 = icmp ne i32 %udiv.2, 100
  call void @use.i1(i1 %true.1)
  %false.1 = icmp eq i32 %udiv.2, 50
  call void @use.i1(i1 %false.1)
  %cond.1 = icmp eq i32 %udiv.2, 10
  call void @use.i1(i1 %cond.1)
  %udiv.3 = udiv i32 ptrtoint (ptr inttoptr (i32 20 to ptr) to i32), ptrtoint (ptr inttoptr (i32 100 to ptr) to i32)
  call void @use.i32(i32 %udiv.3)
  ret void
}
