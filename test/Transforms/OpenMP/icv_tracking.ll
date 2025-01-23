; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature
; RUN: opt -S -openmp-deduce-icv-values -passes=openmp-opt < %s | FileCheck %s

%struct.ident_t = type { i32, i32, i32, i32, ptr }

@.str = private unnamed_addr constant [23 x i8] c";unknown;unknown;0;0;;\00", align 1
@0 = private unnamed_addr global %struct.ident_t { i32 0, i32 2, i32 0, i32 0, ptr @.str }, align 8

; doesn't modify any ICVs.
define i32 @icv_free_use(i32 %0) {
; CHECK-LABEL: define {{[^@]+}}@icv_free_use
; CHECK-SAME: (i32 [[TMP0:%.*]]) {
; CHECK-NEXT:    [[TMP2:%.*]] = add nsw i32 [[TMP0]], 1
; CHECK-NEXT:    ret i32 [[TMP2]]
;
  %2 = add nsw i32 %0, 1
  ret i32 %2
}

define i32 @bad_use(i32 %0) {
; CHECK-LABEL: define {{[^@]+}}@bad_use
; CHECK-SAME: (i32 [[TMP0:%.*]]) {
; CHECK-NEXT:    tail call void @use(i32 [[TMP0]])
; CHECK-NEXT:    [[TMP2:%.*]] = add nsw i32 [[TMP0]], 1
; CHECK-NEXT:    ret i32 [[TMP2]]
;
  tail call void @use(i32 %0)
  %2 = add nsw i32 %0, 1
  ret i32 %2
}

define i32 @ok_use_assume(i32 %0) {
; CHECK-LABEL: define {{[^@]+}}@ok_use_assume
; CHECK-SAME: (i32 [[TMP0:%.*]]) {
; CHECK-NEXT:    call void @use(i32 [[TMP0]]) #[[ATTR1:[0-9]+]]
; CHECK-NEXT:    call void @use(i32 [[TMP0]]) #[[ATTR2:[0-9]+]]
; CHECK-NEXT:    call void @no_openmp_use(i32 [[TMP0]])
; CHECK-NEXT:    [[TMP2:%.*]] = add nsw i32 [[TMP0]], 1
; CHECK-NEXT:    ret i32 [[TMP2]]
;
  call void @use(i32 %0) "no_openmp"
  call void @use(i32 %0) "no_openmp_routines"
  call void @no_openmp_use(i32 %0)
  %2 = add nsw i32 %0, 1
  ret i32 %2
}

define void @indirect_call(ptr %0) {
; CHECK-LABEL: define {{[^@]+}}@indirect_call
; CHECK-SAME: (ptr [[TMP0:%.*]]) {
; CHECK-NEXT:    call void @omp_set_num_threads(i32 4)
; CHECK-NEXT:    tail call void [[TMP0]]()
; CHECK-NEXT:    [[TMP2:%.*]] = tail call i32 @omp_get_max_threads()
; CHECK-NEXT:    tail call void @use(i32 [[TMP2]])
; CHECK-NEXT:    ret void
;
  call void @omp_set_num_threads(i32 4)
  tail call void %0()
  %2 = tail call i32 @omp_get_max_threads()
  tail call void @use(i32 %2)
  ret void
}

define dso_local i32 @foo(i32 %0, i32 %1) {
; CHECK-LABEL: define {{[^@]+}}@foo
; CHECK-SAME: (i32 [[TMP0:%.*]], i32 [[TMP1:%.*]]) {
; CHECK-NEXT:    tail call void @omp_set_num_threads(i32 [[TMP0]])
; CHECK-NEXT:    tail call void @omp_set_num_threads(i32 [[TMP1]])
; CHECK-NEXT:    tail call void @use(i32 [[TMP1]])
; CHECK-NEXT:    tail call void @use(i32 [[TMP1]])
; CHECK-NEXT:    tail call void (ptr, i32, ptr, ...) @__kmpc_fork_call(ptr nonnull @[[GLOB0:[0-9]+]], i32 0, ptr @.omp_outlined.)
; CHECK-NEXT:    [[TMP3:%.*]] = tail call i32 @omp_get_max_threads()
; CHECK-NEXT:    tail call void @use(i32 [[TMP3]])
; CHECK-NEXT:    ret i32 0
;
  tail call void @omp_set_num_threads(i32 %0)
  %3 = tail call i32 @omp_get_max_threads()
; FIXME: this value should be tracked and the rest of the getters deduplicated and replaced with it.
  tail call void @omp_set_num_threads(i32 %1)
  %4 = tail call i32 @omp_get_max_threads()
  %5 = tail call i32 @omp_get_max_threads()
  %6 = tail call i32 @omp_get_max_threads()
  tail call void @use(i32 %4)
  tail call void @use(i32 %5)
  tail call void (ptr, i32, ptr, ...) @__kmpc_fork_call(ptr nonnull @0, i32 0, ptr @.omp_outlined.)
  %7 = tail call i32 @omp_get_max_threads()
  tail call void @use(i32 %7)
  ret i32 0
}

declare dso_local void @omp_set_num_threads(i32)

declare dso_local i32 @omp_get_max_threads()

declare dso_local void @use(i32)
declare dso_local void @no_openmp_use(i32) "no_openmp"

define internal void @.omp_outlined.(ptr %0, ptr %1) {
; CHECK-LABEL: define {{[^@]+}}@.omp_outlined.
; CHECK-SAME: (ptr [[TMP0:%.*]], ptr [[TMP1:%.*]]) {
; CHECK-NEXT:    [[TMP3:%.*]] = tail call i32 @omp_get_max_threads()
; CHECK-NEXT:    [[TMP4:%.*]] = tail call i32 @omp_get_max_threads()
; CHECK-NEXT:    tail call void @use(i32 [[TMP4]])
; CHECK-NEXT:    tail call void @omp_set_num_threads(i32 10)
; CHECK-NEXT:    tail call void @use(i32 10)
; CHECK-NEXT:    ret void
;
; FIXME: this value should be tracked and the rest of the getters deduplicated and replaced with it.
  %3 = tail call i32 @omp_get_max_threads()
  %4 = tail call i32 @omp_get_max_threads()
  tail call void @use(i32 %4)
  tail call void @omp_set_num_threads(i32 10)
  %5 = tail call i32 @omp_get_max_threads()
  tail call void @use(i32 %5)
  ret void
}

declare !callback !0 void @__kmpc_fork_call(ptr, i32, ptr, ...)

define dso_local i32 @bar(i32 %0, i32 %1) {
; CHECK-LABEL: define {{[^@]+}}@bar
; CHECK-SAME: (i32 [[TMP0:%.*]], i32 [[TMP1:%.*]]) {
; CHECK-NEXT:    [[TMP3:%.*]] = icmp sgt i32 [[TMP0]], [[TMP1]]
; CHECK-NEXT:    [[TMP4:%.*]] = select i1 [[TMP3]], i32 [[TMP0]], i32 [[TMP1]]
; CHECK-NEXT:    tail call void @omp_set_num_threads(i32 [[TMP4]])
; CHECK-NEXT:    tail call void (ptr, i32, ptr, ...) @__kmpc_fork_call(ptr nonnull @[[GLOB0]], i32 0, ptr @.omp_outlined..1)
; CHECK-NEXT:    [[TMP5:%.*]] = tail call i32 @omp_get_max_threads()
; CHECK-NEXT:    tail call void @use(i32 [[TMP5]])
; CHECK-NEXT:    ret i32 0
;
  %3 = icmp sgt i32 %0, %1
  %4 = select i1 %3, i32 %0, i32 %1
; FIXME: getters can be replaced with %4
  tail call void @omp_set_num_threads(i32 %4)
  %5 = tail call i32 @omp_get_max_threads()
  tail call void (ptr, i32, ptr, ...) @__kmpc_fork_call(ptr nonnull @0, i32 0, ptr @.omp_outlined..1)
  %6 = tail call i32 @omp_get_max_threads()
  tail call void @use(i32 %6)
  ret i32 0
}

define internal void @.omp_outlined..1(ptr %0, ptr  %1) {
; CHECK-LABEL: define {{[^@]+}}@.omp_outlined..1
; CHECK-SAME: (ptr [[TMP0:%.*]], ptr [[TMP1:%.*]]) {
; CHECK-NEXT:    [[TMP3:%.*]] = tail call i32 @omp_get_max_threads()
; CHECK-NEXT:    tail call void @use(i32 [[TMP3]])
; CHECK-NEXT:    tail call void @omp_set_num_threads(i32 10)
; CHECK-NEXT:    tail call void @use(i32 10)
; CHECK-NEXT:    [[TMP4:%.*]] = tail call i32 @omp_get_max_threads()
; CHECK-NEXT:    tail call void @use(i32 [[TMP4]])
; CHECK-NEXT:    ret void
;
  %3 = tail call i32 @omp_get_max_threads()
  tail call void @use(i32 %3)
  tail call void @omp_set_num_threads(i32 10)
  %4 = tail call i32 @omp_get_max_threads()
  tail call void @use(i32 %4)
  %5 = tail call i32 @omp_get_max_threads()
  tail call void @use(i32 %5)
  ret void
}

define dso_local i32 @bar1(i32 %0, i32 %1) {
; CHECK-LABEL: define {{[^@]+}}@bar1
; CHECK-SAME: (i32 [[TMP0:%.*]], i32 [[TMP1:%.*]]) {
; CHECK-NEXT:    [[TMP3:%.*]] = icmp sgt i32 [[TMP0]], [[TMP1]]
; CHECK-NEXT:    [[TMP4:%.*]] = select i1 [[TMP3]], i32 [[TMP0]], i32 [[TMP1]]
; CHECK-NEXT:    tail call void @omp_set_num_threads(i32 [[TMP4]])
; CHECK-NEXT:    tail call void (ptr, i32, ptr, ...) @__kmpc_fork_call(ptr nonnull @[[GLOB0]], i32 0, ptr @.omp_outlined..2)
; CHECK-NEXT:    [[TMP5:%.*]] = tail call i32 @omp_get_max_threads()
; CHECK-NEXT:    tail call void @use(i32 [[TMP5]])
; CHECK-NEXT:    ret i32 0
;
  %3 = icmp sgt i32 %0, %1
  %4 = select i1 %3, i32 %0, i32 %1
  tail call void @omp_set_num_threads(i32 %4)
  %5 = tail call i32 @omp_get_max_threads()
  tail call void (ptr, i32, ptr, ...) @__kmpc_fork_call(ptr nonnull @0, i32 0, ptr @.omp_outlined..2)
  %6 = tail call i32 @omp_get_max_threads()
  tail call void @use(i32 %6)
  ret i32 0
}

define internal void @.omp_outlined..2(ptr %0, ptr  %1) {
; CHECK-LABEL: define {{[^@]+}}@.omp_outlined..2
; CHECK-SAME: (ptr [[TMP0:%.*]], ptr [[TMP1:%.*]]) {
; CHECK-NEXT:    [[TMP3:%.*]] = tail call i32 @omp_get_max_threads()
; CHECK-NEXT:    [[TMP4:%.*]] = tail call i32 @icv_free_use(i32 [[TMP3]])
; CHECK-NEXT:    tail call void @omp_set_num_threads(i32 10)
; CHECK-NEXT:    [[TMP5:%.*]] = tail call i32 @icv_free_use(i32 10)
; CHECK-NEXT:    [[TMP6:%.*]] = tail call i32 @icv_free_use(i32 10)
; CHECK-NEXT:    ret void
;
  %3 = tail call i32 @omp_get_max_threads()
  %4 = tail call i32 @icv_free_use(i32 %3)
  tail call void @omp_set_num_threads(i32 10)
  %5 = tail call i32 @omp_get_max_threads()
  %6 = tail call i32 @icv_free_use(i32 %5)
  %7 = tail call i32 @omp_get_max_threads()
  %8 = tail call i32 @icv_free_use(i32 %7)
  ret void
}
define void @test(i1 %0) {
; CHECK-LABEL: define {{[^@]+}}@test
; CHECK-SAME: (i1 [[TMP0:%.*]]) {
; CHECK-NEXT:    call void @omp_set_num_threads(i32 2)
; CHECK-NEXT:    [[TMP2:%.*]] = icmp eq i1 [[TMP0]], false
; CHECK-NEXT:    br i1 [[TMP2]], label [[TMP4:%.*]], label [[TMP3:%.*]]
; CHECK:       3:
; CHECK-NEXT:    call void @use(i32 10)
; CHECK-NEXT:    br label [[TMP4]]
; CHECK:       4:
; CHECK-NEXT:    [[TMP5:%.*]] = call i32 @omp_get_max_threads()
; CHECK-NEXT:    call void @use(i32 [[TMP5]])
; CHECK-NEXT:    ret void
;
  call void @omp_set_num_threads(i32 2)
  %2 = icmp eq i1 %0, 0
  br i1 %2, label %4, label %3

3:                                                ; preds = %1
  call void @use(i32 10)
  br label %4

4:                                                ; preds = %3, %1
  %5 = call i32 @omp_get_max_threads()
  call void @use(i32 %5)
  ret void
}

define void @test1(i1 %0) {
; CHECK-LABEL: define {{[^@]+}}@test1
; CHECK-SAME: (i1 [[TMP0:%.*]]) {
; CHECK-NEXT:    call void @omp_set_num_threads(i32 2)
; CHECK-NEXT:    [[TMP2:%.*]] = icmp eq i1 [[TMP0]], false
; CHECK-NEXT:    br i1 [[TMP2]], label [[TMP5:%.*]], label [[TMP3:%.*]]
; CHECK:       3:
; CHECK-NEXT:    [[TMP4:%.*]] = call i32 @icv_free_use(i32 10)
; CHECK-NEXT:    br label [[TMP5]]
; CHECK:       5:
; CHECK-NEXT:    call void @use(i32 2)
; CHECK-NEXT:    ret void
;
  call void @omp_set_num_threads(i32 2)
  %2 = icmp eq i1 %0, 0
  br i1 %2, label %5, label %3

3:                                                ; preds = %1
  %4 = call i32 @icv_free_use(i32 10)
  br label %5

5:                                                ; preds = %3, %1
  %6 = call i32 @omp_get_max_threads()
  call void @use(i32 %6)
  ret void
}

define void @bad_use_test(i1 %0) {
; CHECK-LABEL: define {{[^@]+}}@bad_use_test
; CHECK-SAME: (i1 [[TMP0:%.*]]) {
; CHECK-NEXT:    call void @omp_set_num_threads(i32 2)
; CHECK-NEXT:    [[TMP2:%.*]] = icmp eq i1 [[TMP0]], false
; CHECK-NEXT:    br i1 [[TMP2]], label [[TMP5:%.*]], label [[TMP3:%.*]]
; CHECK:       3:
; CHECK-NEXT:    [[TMP4:%.*]] = call i32 @bad_use(i32 10)
; CHECK-NEXT:    br label [[TMP5]]
; CHECK:       5:
; CHECK-NEXT:    [[TMP6:%.*]] = call i32 @omp_get_max_threads()
; CHECK-NEXT:    call void @use(i32 [[TMP6]])
; CHECK-NEXT:    ret void
;
  call void @omp_set_num_threads(i32 2)
  %2 = icmp eq i1 %0, 0
  br i1 %2, label %5, label %3

3:                                                ; preds = %1
  %4 = call i32 @bad_use(i32 10)
  br label %5

5:                                                ; preds = %3, %1
  %6 = call i32 @omp_get_max_threads()
  call void @use(i32 %6)
  ret void
}

define void @ok_use_assume_test(i1 %0) {
; CHECK-LABEL: define {{[^@]+}}@ok_use_assume_test
; CHECK-SAME: (i1 [[TMP0:%.*]]) {
; CHECK-NEXT:    call void @omp_set_num_threads(i32 2)
; CHECK-NEXT:    [[TMP2:%.*]] = icmp eq i1 [[TMP0]], false
; CHECK-NEXT:    br i1 [[TMP2]], label [[TMP5:%.*]], label [[TMP3:%.*]]
; CHECK:       3:
; CHECK-NEXT:    [[TMP4:%.*]] = call i32 @ok_use_assume(i32 10)
; CHECK-NEXT:    br label [[TMP5]]
; CHECK:       5:
; CHECK-NEXT:    call void @use(i32 2)
; CHECK-NEXT:    ret void
;
  call void @omp_set_num_threads(i32 2)
  %2 = icmp eq i1 %0, 0
  br i1 %2, label %5, label %3

3:                                                ; preds = %1
  %4 = call i32 @ok_use_assume(i32 10)
  br label %5

5:                                                ; preds = %3, %1
  %6 = call i32 @omp_get_max_threads()
  call void @use(i32 %6)
  ret void
}

define weak void @weak_known_unique_icv(i1 %0) {
; CHECK-LABEL: define {{[^@]+}}@weak_known_unique_icv
; CHECK-SAME: (i1 [[TMP0:%.*]]) {
; CHECK-NEXT:    call void @omp_set_num_threads(i32 2)
; CHECK-NEXT:    [[TMP2:%.*]] = icmp eq i1 [[TMP0]], false
; CHECK-NEXT:    br i1 [[TMP2]], label [[TMP5:%.*]], label [[TMP3:%.*]]
; CHECK:       3:
; CHECK-NEXT:    [[TMP4:%.*]] = call i32 @icv_free_use(i32 10)
; CHECK-NEXT:    br label [[TMP5]]
; CHECK:       5:
; CHECK-NEXT:    [[TMP6:%.*]] = call i32 @omp_get_max_threads()
; CHECK-NEXT:    [[TMP7:%.*]] = call i32 @icv_free_use(i32 [[TMP6]])
; CHECK-NEXT:    ret void
;
  call void @omp_set_num_threads(i32 2)
  %2 = icmp eq i1 %0, 0
  br i1 %2, label %5, label %3

3:                                                ; preds = %1
  %4 = call i32 @icv_free_use(i32 10)
  br label %5

5:                                                ; preds = %3, %1
  %6 = call i32 @omp_get_max_threads()
  %7 = call i32 @icv_free_use(i32 %6)
  ret void
}

define void @known_unique_icv(i1 %0) {
; CHECK-LABEL: define {{[^@]+}}@known_unique_icv
; CHECK-SAME: (i1 [[TMP0:%.*]]) {
; CHECK-NEXT:    call void @omp_set_num_threads(i32 2)
; CHECK-NEXT:    [[TMP2:%.*]] = icmp eq i1 [[TMP0]], false
; CHECK-NEXT:    br i1 [[TMP2]], label [[TMP5:%.*]], label [[TMP3:%.*]]
; CHECK:       3:
; CHECK-NEXT:    [[TMP4:%.*]] = call i32 @icv_free_use(i32 10)
; CHECK-NEXT:    br label [[TMP5]]
; CHECK:       5:
; CHECK-NEXT:    [[TMP6:%.*]] = call i32 @icv_free_use(i32 2)
; CHECK-NEXT:    ret void
;
  call void @omp_set_num_threads(i32 2)
  %2 = icmp eq i1 %0, 0
  br i1 %2, label %5, label %3

3:                                                ; preds = %1
  %4 = call i32 @icv_free_use(i32 10)
  br label %5

5:                                                ; preds = %3, %1
  %6 = call i32 @omp_get_max_threads()
  %7 = call i32 @icv_free_use(i32 %6)
  ret void
}

define i32 @no_unique_icv(i1 %0) {
; CHECK-LABEL: define {{[^@]+}}@no_unique_icv
; CHECK-SAME: (i1 [[TMP0:%.*]]) {
; CHECK-NEXT:    call void @omp_set_num_threads(i32 4)
; CHECK-NEXT:    br i1 [[TMP0]], label [[TMP3:%.*]], label [[TMP2:%.*]]
; CHECK:       2:
; CHECK-NEXT:    call void @omp_set_num_threads(i32 2)
; CHECK-NEXT:    br label [[TMP3]]
; CHECK:       3:
; CHECK-NEXT:    [[TMP4:%.*]] = call i32 @omp_get_max_threads()
; CHECK-NEXT:    ret i32 [[TMP4]]
;
  call void @omp_set_num_threads(i32 4)
  br i1 %0, label %3, label %2

2:                                                ; preds = %1
  call void @omp_set_num_threads(i32 2)
  br label %3

3:                                                ; preds = %1, %2
  %4 = call i32 @omp_get_max_threads()
  ret i32 %4
}

define void @test2(i1 %0) {
; CHECK-LABEL: define {{[^@]+}}@test2
; CHECK-SAME: (i1 [[TMP0:%.*]]) {
; CHECK-NEXT:    [[TMP2:%.*]] = icmp eq i1 [[TMP0]], false
; CHECK-NEXT:    br i1 [[TMP2]], label [[TMP4:%.*]], label [[TMP3:%.*]]
; CHECK:       3:
; CHECK-NEXT:    call void @omp_set_num_threads(i32 4)
; CHECK-NEXT:    br label [[TMP4]]
; CHECK:       4:
; CHECK-NEXT:    [[TMP5:%.*]] = call i32 @omp_get_max_threads()
; CHECK-NEXT:    call void @use(i32 [[TMP5]])
; CHECK-NEXT:    ret void
;
  %2 = icmp eq i1 %0, 0
  br i1 %2, label %4, label %3

3:                                                ; preds = %1
  call void @omp_set_num_threads(i32 4)
  br label %4

4:                                                ; preds = %3, %1
  %5 = call i32 @omp_get_max_threads()
  call void @use(i32 %5)
  ret void
}

define void @test3(i1 %0) {
; CHECK-LABEL: define {{[^@]+}}@test3
; CHECK-SAME: (i1 [[TMP0:%.*]]) {
; CHECK-NEXT:    [[TMP2:%.*]] = icmp eq i1 [[TMP0]], false
; CHECK-NEXT:    br i1 [[TMP2]], label [[TMP4:%.*]], label [[TMP3:%.*]]
; CHECK:       3:
; CHECK-NEXT:    call void @omp_set_num_threads(i32 4)
; CHECK-NEXT:    br label [[TMP4]]
; CHECK:       4:
; CHECK-NEXT:    call void @weak_known_unique_icv(i1 [[TMP0]])
; CHECK-NEXT:    [[TMP5:%.*]] = call i32 @omp_get_max_threads()
; CHECK-NEXT:    [[TMP6:%.*]] = call i32 @icv_free_use(i32 [[TMP5]])
; CHECK-NEXT:    ret void
;
  %2 = icmp eq i1 %0, 0
  br i1 %2, label %4, label %3

3:                                                ; preds = %1
  call void @omp_set_num_threads(i32 4)
  br label %4

4:                                                ; preds = %3, %1
  call void @weak_known_unique_icv(i1 %0)
  %5 = call i32 @omp_get_max_threads()
  %6 = call i32 @icv_free_use(i32 %5)
  ret void
}

declare void @__cxa_rethrow()

define i32 @maybe_throw(i1 zeroext %0) {
; CHECK-LABEL: define {{[^@]+}}@maybe_throw
; CHECK-SAME: (i1 zeroext [[TMP0:%.*]]) {
; CHECK-NEXT:    call void @omp_set_num_threads(i32 4) #[[ATTR0:[0-9]+]]
; CHECK-NEXT:    br i1 [[TMP0]], label [[TMP2:%.*]], label [[TMP3:%.*]]
; CHECK:       2:
; CHECK-NEXT:    tail call void @__cxa_rethrow()
; CHECK-NEXT:    unreachable
; CHECK:       3:
; CHECK-NEXT:    ret i32 -1
;
  call void @omp_set_num_threads(i32 4)
  br i1 %0, label %2, label %3

2:                                                ; preds = %1
  tail call void @__cxa_rethrow() #1
  unreachable

3:                                                ; preds = %1
  ret i32 -1
}

define void @test4(i1 %0) {
; CHECK-LABEL: define {{[^@]+}}@test4
; CHECK-SAME: (i1 [[TMP0:%.*]]) {
; CHECK-NEXT:    call void @known_unique_icv(i1 [[TMP0]])
; CHECK-NEXT:    [[TMP2:%.*]] = icmp eq i1 [[TMP0]], false
; CHECK-NEXT:    br i1 [[TMP2]], label [[TMP4:%.*]], label [[TMP3:%.*]]
; CHECK:       3:
; CHECK-NEXT:    [[VAL:%.*]] = call i32 @icv_free_use(i32 10)
; CHECK-NEXT:    br label [[TMP4]]
; CHECK:       4:
; CHECK-NEXT:    call void @use(i32 2)
; CHECK-NEXT:    [[TMP5:%.*]] = call i32 @omp_get_max_threads()
; CHECK-NEXT:    [[TMP6:%.*]] = call i32 @no_unique_icv(i1 [[TMP0]])
; CHECK-NEXT:    call void @use(i32 [[TMP5]])
; CHECK-NEXT:    ret void
;
  call void @known_unique_icv(i1 %0)
  %2 = icmp eq i1 %0, 0
  br i1 %2, label %4, label %3

3:                                                ; preds = %1
  %val = call i32 @icv_free_use(i32 10)
  br label %4

4:                                                ; preds = %3, %1
  %5 = call i32 @omp_get_max_threads()
  call void @use(i32 %5)
  %6 = call i32 @omp_get_max_threads()
  call i32 @no_unique_icv(i1 %0)
  call void @use(i32 %6)
  ret void
}

define void @test4_invoke(i1 %0) personality ptr @__gxx_personality_v0 {
; CHECK-LABEL: define {{[^@]+}}@test4_invoke
; CHECK-SAME: (i1 [[TMP0:%.*]]) personality ptr @__gxx_personality_v0 {
; CHECK-NEXT:    call void @known_unique_icv(i1 [[TMP0]])
; CHECK-NEXT:    [[TMP2:%.*]] = invoke i32 @maybe_throw(i1 zeroext [[TMP0]])
; CHECK-NEXT:            to label [[CONT:%.*]] unwind label [[EXC:%.*]]
; CHECK:       cont:
; CHECK-NEXT:    [[TMP3:%.*]] = icmp eq i1 [[TMP0]], false
; CHECK-NEXT:    br i1 [[TMP3]], label [[TMP5:%.*]], label [[TMP4:%.*]]
; CHECK:       exc:
; CHECK-NEXT:    [[LP:%.*]] = landingpad { ptr, i32 }
; CHECK-NEXT:            filter [0 x ptr] zeroinitializer
; CHECK-NEXT:    unreachable
; CHECK:       4:
; CHECK-NEXT:    [[VAL:%.*]] = call i32 @icv_free_use(i32 10)
; CHECK-NEXT:    br label [[TMP5]]
; CHECK:       5:
; CHECK-NEXT:    call void @use(i32 2)
; CHECK-NEXT:    ret void
;
  call void @known_unique_icv(i1 %0)
  invoke i32 @maybe_throw(i1 zeroext %0)
  to label %cont unwind label %exc

cont:
  %3 = icmp eq i1 %0, 0
  br i1 %3, label %5, label %4

exc:
  %lp = landingpad { ptr, i32 }
  filter [0 x ptr] zeroinitializer
  unreachable

4:                                                ; preds = %1
  %val = call i32 @icv_free_use(i32 10)
  br label %5

5:                                                ; preds = %3, %1
  %6 = call i32 @omp_get_max_threads()
  call void @use(i32 %6)
  ret void
}

define i32 @test5(i32 %0)  #0 {
; CHECK-LABEL: define {{[^@]+}}@test5
; CHECK-SAME: (i32 [[TMP0:%.*]]) {
; CHECK-NEXT:    call void @omp_set_num_threads(i32 4)
; CHECK-NEXT:    [[TMP2:%.*]] = icmp sgt i32 [[TMP0]], 3
; CHECK-NEXT:    br i1 [[TMP2]], label [[TMP3:%.*]], label [[TMP4:%.*]]
; CHECK:       3:
; CHECK-NEXT:    call void @use(i32 4)
; CHECK-NEXT:    br label [[TMP12:%.*]]
; CHECK:       4:
; CHECK-NEXT:    [[TMP5:%.*]] = icmp sgt i32 [[TMP0]], 0
; CHECK-NEXT:    br i1 [[TMP5]], label [[TMP6:%.*]], label [[TMP8:%.*]]
; CHECK:       6:
; CHECK-NEXT:    [[TMP7:%.*]] = call i32 @icv_free_use(i32 [[TMP0]])
; CHECK-NEXT:    br label [[TMP15:%.*]]
; CHECK:       8:
; CHECK-NEXT:    [[TMP9:%.*]] = icmp eq i32 [[TMP0]], 0
; CHECK-NEXT:    br i1 [[TMP9]], label [[TMP10:%.*]], label [[TMP12]]
; CHECK:       10:
; CHECK-NEXT:    [[TMP11:%.*]] = call i32 @icv_free_use(i32 10)
; CHECK-NEXT:    br label [[TMP15]]
; CHECK:       12:
; CHECK-NEXT:    [[TMP13:%.*]] = add nsw i32 [[TMP0]], 1
; CHECK-NEXT:    [[TMP14:%.*]] = call i32 @icv_free_use(i32 [[TMP13]])
; CHECK-NEXT:    br label [[TMP15]]
; CHECK:       15:
; CHECK-NEXT:    [[TMP16:%.*]] = call i32 @omp_get_max_threads()
; CHECK-NEXT:    [[TMP17:%.*]] = call i32 @icv_free_use(i32 [[TMP16]])
; CHECK-NEXT:    ret i32 [[TMP17]]
;
  call void @omp_set_num_threads(i32 4)
  %2 = icmp sgt i32 %0, 3
  br i1 %2, label %3, label %5

3:
  %4 = call i32 @omp_get_max_threads()
  call void @use(i32 %4)
  br label %13

5:
  %6 = icmp sgt i32 %0, 0
  br i1 %6, label %7, label %9

7:
  %8 = call i32 @icv_free_use(i32 %0)
  br label %16

9:
  %10 = icmp eq i32 %0, 0
  br i1 %10, label %11, label %13

11:
  %12 = call i32 @icv_free_use(i32 10)
  br label %16

13:
  %14 = add nsw i32 %0, 1
  %15 = call i32 @icv_free_use(i32 %14)
  br label %16

16:
  %17 = call i32 @omp_get_max_threads()
  %18 = call i32 @icv_free_use(i32 %17)
  ret i32 %18
}

define i32 @test6(i32 %0) {
; CHECK-LABEL: define {{[^@]+}}@test6
; CHECK-SAME: (i32 [[TMP0:%.*]]) {
; CHECK-NEXT:    call void @omp_set_num_threads(i32 4)
; CHECK-NEXT:    [[TMP2:%.*]] = icmp sgt i32 [[TMP0]], 3
; CHECK-NEXT:    br i1 [[TMP2]], label [[TMP3:%.*]], label [[TMP5:%.*]]
; CHECK:       3:
; CHECK-NEXT:    [[TMP4:%.*]] = call i32 @icv_free_use(i32 10)
; CHECK-NEXT:    br label [[TMP16:%.*]]
; CHECK:       5:
; CHECK-NEXT:    [[TMP6:%.*]] = icmp sgt i32 [[TMP0]], 0
; CHECK-NEXT:    br i1 [[TMP6]], label [[TMP7:%.*]], label [[TMP9:%.*]]
; CHECK:       7:
; CHECK-NEXT:    [[TMP8:%.*]] = call i32 @icv_free_use(i32 [[TMP0]])
; CHECK-NEXT:    br label [[TMP16]]
; CHECK:       9:
; CHECK-NEXT:    [[TMP10:%.*]] = icmp eq i32 [[TMP0]], 0
; CHECK-NEXT:    br i1 [[TMP10]], label [[TMP11:%.*]], label [[TMP13:%.*]]
; CHECK:       11:
; CHECK-NEXT:    [[TMP12:%.*]] = call i32 @icv_free_use(i32 5)
; CHECK-NEXT:    br label [[TMP16]]
; CHECK:       13:
; CHECK-NEXT:    [[TMP14:%.*]] = add nsw i32 [[TMP0]], 1
; CHECK-NEXT:    [[TMP15:%.*]] = call i32 @icv_free_use(i32 [[TMP14]])
; CHECK-NEXT:    br label [[TMP16]]
; CHECK:       16:
; CHECK-NEXT:    [[TMP17:%.*]] = call i32 @icv_free_use(i32 4)
; CHECK-NEXT:    ret i32 [[TMP17]]
;
  call void @omp_set_num_threads(i32 4)
  %2 = icmp sgt i32 %0, 3
  br i1 %2, label %3, label %5

3:                                                ; preds = %1
  %4 = call i32 @icv_free_use(i32 10)
  br label %16

5:                                                ; preds = %1
  %6 = icmp sgt i32 %0, 0
  br i1 %6, label %7, label %9

7:                                                ; preds = %5
  %8 = call i32 @icv_free_use(i32 %0)
  br label %16

9:                                                ; preds = %5
  %10 = icmp eq i32 %0, 0
  br i1 %10, label %11, label %13

11:                                               ; preds = %9
  %12 = call i32 @icv_free_use(i32 5)
  br label %16

13:                                               ; preds = %9
  %14 = add nsw i32 %0, 1
  %15 = call i32 @icv_free_use(i32 %14)
  br label %16

16:                                               ; preds = %7, %13, %11, %3
  %17 = call i32 @omp_get_max_threads()
  %18 = call i32 @icv_free_use(i32 %17)
  ret i32 %18
}

declare i32 @__gxx_personality_v0(...)

!llvm.module.flags = !{!2}

!0 = !{!1}
!1 = !{i64 2, i64 -1, i64 -1, i1 true}
!2 = !{i32 7, !"openmp", i32 50}
