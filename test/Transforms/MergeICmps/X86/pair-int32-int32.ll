; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes='require<domtree>,mergeicmps,verify<domtree>' -mtriple=x86_64-unknown-unknown -S | FileCheck %s --check-prefix=X86
; RUN: opt < %s -passes=mergeicmps -verify-dom-info -mtriple=x86_64-unknown-unknown -S -disable-simplify-libcalls | FileCheck %s --check-prefix=X86-NOBUILTIN

%S = type { i32, i32 }

define zeroext i1 @opeq1(
; X86-LABEL: @opeq1(
; X86-NEXT:  "entry+land.rhs.i":
; X86-NEXT:    [[MEMCMP:%.*]] = call i32 @memcmp(ptr [[A:%.*]], ptr [[B:%.*]], i64 8)
; X86-NEXT:    [[TMP0:%.*]] = icmp eq i32 [[MEMCMP]], 0
; X86-NEXT:    br label [[OPEQ1_EXIT:%.*]]
; X86:       opeq1.exit:
; X86-NEXT:    ret i1 [[TMP0]]
;
; X86-NOBUILTIN-LABEL: @opeq1(
; X86-NOBUILTIN-NEXT:  entry:
; X86-NOBUILTIN-NEXT:    [[TMP0:%.*]] = load i32, ptr [[A:%.*]], align 4
; X86-NOBUILTIN-NEXT:    [[TMP1:%.*]] = load i32, ptr [[B:%.*]], align 4
; X86-NOBUILTIN-NEXT:    [[CMP_I:%.*]] = icmp eq i32 [[TMP0]], [[TMP1]]
; X86-NOBUILTIN-NEXT:    br i1 [[CMP_I]], label [[LAND_RHS_I:%.*]], label [[OPEQ1_EXIT:%.*]]
; X86-NOBUILTIN:       land.rhs.i:
; X86-NOBUILTIN-NEXT:    [[SECOND_I:%.*]] = getelementptr inbounds [[S:%.*]], ptr [[A]], i64 0, i32 1
; X86-NOBUILTIN-NEXT:    [[TMP2:%.*]] = load i32, ptr [[SECOND_I]], align 4
; X86-NOBUILTIN-NEXT:    [[SECOND2_I:%.*]] = getelementptr inbounds [[S]], ptr [[B]], i64 0, i32 1
; X86-NOBUILTIN-NEXT:    [[TMP3:%.*]] = load i32, ptr [[SECOND2_I]], align 4
; X86-NOBUILTIN-NEXT:    [[CMP3_I:%.*]] = icmp eq i32 [[TMP2]], [[TMP3]]
; X86-NOBUILTIN-NEXT:    br label [[OPEQ1_EXIT]]
; X86-NOBUILTIN:       opeq1.exit:
; X86-NOBUILTIN-NEXT:    [[TMP4:%.*]] = phi i1 [ false, [[ENTRY:%.*]] ], [ [[CMP3_I]], [[LAND_RHS_I]] ]
; X86-NOBUILTIN-NEXT:    ret i1 [[TMP4]]
;
  ptr nocapture readonly dereferenceable(8) %a,
  ptr nocapture readonly dereferenceable(8) %b) local_unnamed_addr nofree nosync {
entry:
  %0 = load i32, ptr %a, align 4
  %1 = load i32, ptr %b, align 4
  %cmp.i = icmp eq i32 %0, %1
  br i1 %cmp.i, label %land.rhs.i, label %opeq1.exit

land.rhs.i:
  %second.i = getelementptr inbounds %S, ptr %a, i64 0, i32 1
  %2 = load i32, ptr %second.i, align 4
  %second2.i = getelementptr inbounds %S, ptr %b, i64 0, i32 1
  %3 = load i32, ptr %second2.i, align 4
  %cmp3.i = icmp eq i32 %2, %3
  br label %opeq1.exit

opeq1.exit:
  %4 = phi i1 [ false, %entry ], [ %cmp3.i, %land.rhs.i ]
  ret i1 %4
; The entry block with zero-offset GEPs is kept, loads are removed.
; The two 4 byte loads and compares are replaced with a single 8-byte memcmp.
; The branch is now a direct branch; the other block has been removed.
; The phi is updated.
}

; Same as above, but the two blocks are in inverse order.
define zeroext i1 @opeq1_inverse(
; X86-LABEL: @opeq1_inverse(
; X86-NEXT:  "land.rhs.i+entry":
; X86-NEXT:    [[MEMCMP:%.*]] = call i32 @memcmp(ptr [[A:%.*]], ptr [[B:%.*]], i64 8)
; X86-NEXT:    [[TMP0:%.*]] = icmp eq i32 [[MEMCMP]], 0
; X86-NEXT:    br label [[OPEQ1_EXIT:%.*]]
; X86:       opeq1.exit:
; X86-NEXT:    ret i1 [[TMP0]]
;
; X86-NOBUILTIN-LABEL: @opeq1_inverse(
; X86-NOBUILTIN-NEXT:  entry:
; X86-NOBUILTIN-NEXT:    [[FIRST_I:%.*]] = getelementptr inbounds [[S:%.*]], ptr [[A:%.*]], i64 0, i32 1
; X86-NOBUILTIN-NEXT:    [[TMP0:%.*]] = load i32, ptr [[FIRST_I]], align 4
; X86-NOBUILTIN-NEXT:    [[FIRST1_I:%.*]] = getelementptr inbounds [[S]], ptr [[B:%.*]], i64 0, i32 1
; X86-NOBUILTIN-NEXT:    [[TMP1:%.*]] = load i32, ptr [[FIRST1_I]], align 4
; X86-NOBUILTIN-NEXT:    [[CMP_I:%.*]] = icmp eq i32 [[TMP0]], [[TMP1]]
; X86-NOBUILTIN-NEXT:    br i1 [[CMP_I]], label [[LAND_RHS_I:%.*]], label [[OPEQ1_EXIT:%.*]]
; X86-NOBUILTIN:       land.rhs.i:
; X86-NOBUILTIN-NEXT:    [[TMP2:%.*]] = load i32, ptr [[A]], align 4
; X86-NOBUILTIN-NEXT:    [[TMP3:%.*]] = load i32, ptr [[B]], align 4
; X86-NOBUILTIN-NEXT:    [[CMP3_I:%.*]] = icmp eq i32 [[TMP2]], [[TMP3]]
; X86-NOBUILTIN-NEXT:    br label [[OPEQ1_EXIT]]
; X86-NOBUILTIN:       opeq1.exit:
; X86-NOBUILTIN-NEXT:    [[TMP4:%.*]] = phi i1 [ false, [[ENTRY:%.*]] ], [ [[CMP3_I]], [[LAND_RHS_I]] ]
; X86-NOBUILTIN-NEXT:    ret i1 [[TMP4]]
;
  ptr nocapture readonly dereferenceable(8) %a,
  ptr nocapture readonly dereferenceable(8) %b) local_unnamed_addr nofree nosync {
entry:
  %first.i = getelementptr inbounds %S, ptr %a, i64 0, i32 1
  %0 = load i32, ptr %first.i, align 4
  %first1.i = getelementptr inbounds %S, ptr %b, i64 0, i32 1
  %1 = load i32, ptr %first1.i, align 4
  %cmp.i = icmp eq i32 %0, %1
  br i1 %cmp.i, label %land.rhs.i, label %opeq1.exit

land.rhs.i:
  %2 = load i32, ptr %a, align 4
  %3 = load i32, ptr %b, align 4
  %cmp3.i = icmp eq i32 %2, %3
  br label %opeq1.exit

opeq1.exit:
  %4 = phi i1 [ false, %entry ], [ %cmp3.i, %land.rhs.i ]
  ret i1 %4
; The second block with zero-offset GEPs is kept, loads are removed.
; CHECK: land.rhs.i
; The two 4 byte loads and compares are replaced with a single 8-byte memcmp.
; The branch is now a direct branch; the other block has been removed.
; The phi is updated.
}
