; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --scrub-attributes --check-globals
; call site specific analysis is enabled

; RUN: opt -aa-pipeline=basic-aa -passes=attributor -attributor-enable-call-site-specific-deduction=true -attributor-manifest-internal  -attributor-annotate-decl-cs  -S < %s | FileCheck %s --check-prefixes=CHECK,TUNIT

; RUN: opt -aa-pipeline=basic-aa -passes=attributor-cgscc -attributor-enable-call-site-specific-deduction=true -attributor-manifest-internal  -attributor-annotate-decl-cs -S < %s | FileCheck %s --check-prefixes=CHECK,CGSCC

define i32 @test_range(i32 %unknown) {
; CHECK-LABEL: define {{[^@]+}}@test_range
; CHECK-SAME: (i32 [[UNKNOWN:%.*]]) #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:    [[TMP1:%.*]] = icmp sgt i32 [[UNKNOWN]], 100
; CHECK-NEXT:    [[TMP2:%.*]] = select i1 [[TMP1]], i32 100, i32 0
; CHECK-NEXT:    ret i32 [[TMP2]]
;
  %1 = icmp sgt i32 %unknown, 100
  %2 = select i1 %1, i32 100, i32 0
  ret i32 %2
}

define i32 @test1(i32 %unknown, i32 %b) {
; TUNIT-LABEL: define {{[^@]+}}@test1
; TUNIT-SAME: (i32 [[UNKNOWN:%.*]], i32 [[B:%.*]]) #[[ATTR0]] {
; TUNIT-NEXT:    [[TMP1:%.*]] = call i32 @test_range(i32 [[UNKNOWN]])
; TUNIT-NEXT:    [[TMP2:%.*]] = sub nsw i32 [[TMP1]], [[B]]
; TUNIT-NEXT:    ret i32 [[TMP2]]
;
; CGSCC-LABEL: define {{[^@]+}}@test1
; CGSCC-SAME: (i32 [[UNKNOWN:%.*]], i32 [[B:%.*]]) #[[ATTR1:[0-9]+]] {
; CGSCC-NEXT:    [[TMP1:%.*]] = call i32 @test_range(i32 [[UNKNOWN]])
; CGSCC-NEXT:    [[TMP2:%.*]] = sub nsw i32 [[TMP1]], [[B]]
; CGSCC-NEXT:    ret i32 [[TMP2]]
;
  %1 = call i32 @test_range(i32 %unknown)
  %2 = sub nsw i32 %1, %b
  ret i32 %2
}

define i32 @test2(i32 %unknown, i32 %b) {
; TUNIT-LABEL: define {{[^@]+}}@test2
; TUNIT-SAME: (i32 [[UNKNOWN:%.*]], i32 [[B:%.*]]) #[[ATTR0]] {
; TUNIT-NEXT:    [[TMP1:%.*]] = call i32 @test_range(i32 [[UNKNOWN]])
; TUNIT-NEXT:    [[TMP2:%.*]] = add nsw i32 [[TMP1]], [[B]]
; TUNIT-NEXT:    ret i32 [[TMP2]]
;
; CGSCC-LABEL: define {{[^@]+}}@test2
; CGSCC-SAME: (i32 [[UNKNOWN:%.*]], i32 [[B:%.*]]) #[[ATTR1]] {
; CGSCC-NEXT:    [[TMP1:%.*]] = call i32 @test_range(i32 [[UNKNOWN]])
; CGSCC-NEXT:    [[TMP2:%.*]] = add nsw i32 [[TMP1]], [[B]]
; CGSCC-NEXT:    ret i32 [[TMP2]]
;
  %1 = call i32 @test_range(i32 %unknown)
  %2 = add nsw i32 %1, %b
  ret i32 %2
}

; Positive checks

; FIXME: AAValueSimplify preserves the context but simplifies to a value in the other function, I think.
;        Either way, as we settle on the new AAValueSimplifyReturned scheme that replaces AAReturnedValues
;        we need to look into this again. For the purpose of making some progress we take this regression
;        for now, call site contexts are not on by default anyway (yet).
define i32 @test1_pcheck(i32 %unknown) {
; TUNIT-LABEL: define {{[^@]+}}@test1_pcheck
; TUNIT-SAME: (i32 [[UNKNOWN:%.*]]) #[[ATTR0]] {
; TUNIT-NEXT:    [[TMP1:%.*]] = call i32 @test1(i32 [[UNKNOWN]], i32 noundef 20)
; TUNIT-NEXT:    [[TMP2:%.*]] = icmp sle i32 [[TMP1]], 90
; TUNIT-NEXT:    [[TMP3:%.*]] = zext i1 [[TMP2]] to i32
; TUNIT-NEXT:    ret i32 [[TMP3]]
;
; CGSCC-LABEL: define {{[^@]+}}@test1_pcheck
; CGSCC-SAME: (i32 [[UNKNOWN:%.*]]) #[[ATTR1]] {
; CGSCC-NEXT:    [[TMP1:%.*]] = call i32 @test1(i32 [[UNKNOWN]], i32 noundef 20)
; CGSCC-NEXT:    [[TMP2:%.*]] = icmp sle i32 [[TMP1]], 90
; CGSCC-NEXT:    [[TMP3:%.*]] = zext i1 [[TMP2]] to i32
; CGSCC-NEXT:    ret i32 [[TMP3]]
;
  %1 = call i32 @test1(i32 %unknown, i32 20)
  %2 = icmp sle i32 %1, 90
  %3 = zext i1 %2 to i32
  ret i32 %3
}

define i32 @test2_pcheck(i32 %unknown) {
; TUNIT-LABEL: define {{[^@]+}}@test2_pcheck
; TUNIT-SAME: (i32 [[UNKNOWN:%.*]]) #[[ATTR0]] {
; TUNIT-NEXT:    [[TMP1:%.*]] = call i32 @test2(i32 [[UNKNOWN]], i32 noundef 20)
; TUNIT-NEXT:    [[TMP2:%.*]] = icmp sge i32 [[TMP1]], 20
; TUNIT-NEXT:    [[TMP3:%.*]] = zext i1 [[TMP2]] to i32
; TUNIT-NEXT:    ret i32 [[TMP3]]
;
; CGSCC-LABEL: define {{[^@]+}}@test2_pcheck
; CGSCC-SAME: (i32 [[UNKNOWN:%.*]]) #[[ATTR1]] {
; CGSCC-NEXT:    [[TMP1:%.*]] = call i32 @test2(i32 [[UNKNOWN]], i32 noundef 20)
; CGSCC-NEXT:    [[TMP2:%.*]] = icmp sge i32 [[TMP1]], 20
; CGSCC-NEXT:    [[TMP3:%.*]] = zext i1 [[TMP2]] to i32
; CGSCC-NEXT:    ret i32 [[TMP3]]
;
  %1 = call i32 @test2(i32 %unknown, i32 20)
  %2 = icmp sge i32 %1, 20
  %3 = zext i1 %2 to i32
  ret i32 %3
}

; Negative checks

define i32 @test1_ncheck(i32 %unknown) {
; TUNIT-LABEL: define {{[^@]+}}@test1_ncheck
; TUNIT-SAME: (i32 [[UNKNOWN:%.*]]) #[[ATTR0]] {
; TUNIT-NEXT:    [[TMP1:%.*]] = call i32 @test1(i32 [[UNKNOWN]], i32 noundef 20)
; TUNIT-NEXT:    [[TMP2:%.*]] = icmp sle i32 [[TMP1]], 10
; TUNIT-NEXT:    [[TMP3:%.*]] = zext i1 [[TMP2]] to i32
; TUNIT-NEXT:    ret i32 [[TMP3]]
;
; CGSCC-LABEL: define {{[^@]+}}@test1_ncheck
; CGSCC-SAME: (i32 [[UNKNOWN:%.*]]) #[[ATTR1]] {
; CGSCC-NEXT:    [[TMP1:%.*]] = call i32 @test1(i32 [[UNKNOWN]], i32 noundef 20)
; CGSCC-NEXT:    [[TMP2:%.*]] = icmp sle i32 [[TMP1]], 10
; CGSCC-NEXT:    [[TMP3:%.*]] = zext i1 [[TMP2]] to i32
; CGSCC-NEXT:    ret i32 [[TMP3]]
;
  %1 = call i32 @test1(i32 %unknown, i32 20)
  %2 = icmp sle i32 %1, 10
  %3 = zext i1 %2 to i32
  ret i32 %3
}

define i32 @test2_ncheck(i32 %unknown) {
; TUNIT-LABEL: define {{[^@]+}}@test2_ncheck
; TUNIT-SAME: (i32 [[UNKNOWN:%.*]]) #[[ATTR0]] {
; TUNIT-NEXT:    [[TMP1:%.*]] = call i32 @test2(i32 [[UNKNOWN]], i32 noundef 20)
; TUNIT-NEXT:    [[TMP2:%.*]] = icmp sge i32 [[TMP1]], 30
; TUNIT-NEXT:    [[TMP3:%.*]] = zext i1 [[TMP2]] to i32
; TUNIT-NEXT:    ret i32 [[TMP3]]
;
; CGSCC-LABEL: define {{[^@]+}}@test2_ncheck
; CGSCC-SAME: (i32 [[UNKNOWN:%.*]]) #[[ATTR1]] {
; CGSCC-NEXT:    [[TMP1:%.*]] = call i32 @test2(i32 [[UNKNOWN]], i32 noundef 20)
; CGSCC-NEXT:    [[TMP2:%.*]] = icmp sge i32 [[TMP1]], 30
; CGSCC-NEXT:    [[TMP3:%.*]] = zext i1 [[TMP2]] to i32
; CGSCC-NEXT:    ret i32 [[TMP3]]
;
  %1 = call i32 @test2(i32 %unknown, i32 20)
  %2 = icmp sge i32 %1, 30
  %3 = zext i1 %2 to i32
  ret i32 %3
}
;.
; TUNIT: attributes #[[ATTR0]] = { mustprogress nofree norecurse nosync nounwind willreturn memory(none) }
; TUNIT: attributes #[[ATTR1:[0-9]+]] = { nofree nosync nounwind willreturn memory(none) }
;.
; CGSCC: attributes #[[ATTR0]] = { mustprogress nofree norecurse nosync nounwind willreturn memory(none) }
; CGSCC: attributes #[[ATTR1]] = { mustprogress nofree nosync nounwind willreturn memory(none) }
; CGSCC: attributes #[[ATTR2:[0-9]+]] = { nofree nosync willreturn }
;.
