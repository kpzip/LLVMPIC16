; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 3
; RUN: opt -passes='require<profile-summary>,function(codegenprepare)' -mtriple=arm64_32-apple-ios %s -S -o - | FileCheck %s

define void @test_simple_sink(ptr %base, i64 %offset) {
; CHECK-LABEL: define void @test_simple_sink(
; CHECK-SAME: ptr [[BASE:%.*]], i64 [[OFFSET:%.*]]) {
; CHECK-NEXT:    [[ADDR:%.*]] = getelementptr i1, ptr [[BASE]], i64 [[OFFSET]]
; CHECK-NEXT:    [[TST:%.*]] = load i1, ptr [[ADDR]], align 1
; CHECK-NEXT:    br i1 [[TST]], label [[NEXT:%.*]], label [[END:%.*]]
; CHECK:       next:
; CHECK-NEXT:    [[SUNKADDR:%.*]] = trunc i64 [[OFFSET]] to i32
; CHECK-NEXT:    [[SUNKADDR1:%.*]] = getelementptr i8, ptr [[BASE]], i32 [[SUNKADDR]]
; CHECK-NEXT:    [[TMP1:%.*]] = load volatile i1, ptr [[SUNKADDR1]], align 1
; CHECK-NEXT:    ret void
; CHECK:       end:
; CHECK-NEXT:    ret void
;
  %addr = getelementptr i1, ptr %base, i64 %offset
  %tst = load i1, ptr %addr
  br i1 %tst, label %next, label %end

next:
  load volatile i1, ptr %addr
  ret void

end:
  ret void
}

define void @test_inbounds_sink(ptr %base, i64 %offset) {
; CHECK-LABEL: define void @test_inbounds_sink(
; CHECK-SAME: ptr [[BASE:%.*]], i64 [[OFFSET:%.*]]) {
; CHECK-NEXT:    [[ADDR:%.*]] = getelementptr inbounds i1, ptr [[BASE]], i64 [[OFFSET]]
; CHECK-NEXT:    [[TST:%.*]] = load i1, ptr [[ADDR]], align 1
; CHECK-NEXT:    br i1 [[TST]], label [[NEXT:%.*]], label [[END:%.*]]
; CHECK:       next:
; CHECK-NEXT:    [[SUNKADDR:%.*]] = trunc i64 [[OFFSET]] to i32
; CHECK-NEXT:    [[SUNKADDR1:%.*]] = getelementptr inbounds i8, ptr [[BASE]], i32 [[SUNKADDR]]
; CHECK-NEXT:    [[TMP1:%.*]] = load volatile i1, ptr [[SUNKADDR1]], align 1
; CHECK-NEXT:    ret void
; CHECK:       end:
; CHECK-NEXT:    ret void
;
  %addr = getelementptr inbounds i1, ptr %base, i64 %offset
  %tst = load i1, ptr %addr
  br i1 %tst, label %next, label %end

next:
  load volatile i1, ptr %addr
  ret void

end:
  ret void
}

; No address derived via an add can be guaranteed inbounds
define void @test_add_sink(ptr %base, i64 %offset) {
; CHECK-LABEL: define void @test_add_sink(
; CHECK-SAME: ptr [[BASE:%.*]], i64 [[OFFSET:%.*]]) {
; CHECK-NEXT:    [[BASE64:%.*]] = ptrtoint ptr [[BASE]] to i64
; CHECK-NEXT:    [[ADDR64:%.*]] = add nuw nsw i64 [[BASE64]], [[OFFSET]]
; CHECK-NEXT:    [[ADDR:%.*]] = inttoptr i64 [[ADDR64]] to ptr
; CHECK-NEXT:    [[TST:%.*]] = load i1, ptr [[ADDR]], align 1
; CHECK-NEXT:    br i1 [[TST]], label [[NEXT:%.*]], label [[END:%.*]]
; CHECK:       next:
; CHECK-NEXT:    [[TMP1:%.*]] = inttoptr i64 [[ADDR64]] to ptr
; CHECK-NEXT:    [[TMP2:%.*]] = load volatile i1, ptr [[TMP1]], align 1
; CHECK-NEXT:    ret void
; CHECK:       end:
; CHECK-NEXT:    ret void
;
  %base64 = ptrtoint ptr %base to i64
  %addr64 = add nsw nuw i64 %base64, %offset
  %addr = inttoptr i64 %addr64 to ptr
  %tst = load i1, ptr %addr
  br i1 %tst, label %next, label %end

next:
  load volatile i1, ptr %addr
  ret void

end:
  ret void
}
