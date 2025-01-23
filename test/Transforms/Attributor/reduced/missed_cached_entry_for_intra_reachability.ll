; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --scrub-attributes --check-attributes --check-globals
; RUN: opt -aa-pipeline=basic-aa -passes=attributor -attributor-manifest-internal  -attributor-annotate-decl-cs  -S < %s | FileCheck %s --check-prefixes=CHECK,TUNIT
; RUN: opt -aa-pipeline=basic-aa -passes=attributor-cgscc -attributor-manifest-internal  -attributor-annotate-decl-cs -S < %s | FileCheck %s --check-prefixes=CHECK,CGSCC

; We did not properly cache the intra procedural reachability queries which lead
; to the removal of stores that are actually needed.

; Reported as part of https://github.com/llvm/llvm-project/issues/61883

@random = external global i1, align 4

;.
; CHECK: @random = external global i1, align 4
;.
define void @widget(ptr %arg1, float %arg2, i64 %idx1, i64 %idx2, i32 %limit) {
; CHECK: Function Attrs: nofree norecurse nounwind
; CHECK-LABEL: define {{[^@]+}}@widget
; CHECK-SAME: (ptr nocapture nofree writeonly [[ARG1:%.*]], float [[ARG2:%.*]], i64 [[IDX1:%.*]], i64 [[IDX2:%.*]], i32 [[LIMIT:%.*]]) #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[ALLOCA:%.*]] = alloca [128 x float], i32 0, align 4
; CHECK-NEXT:    [[ALLOCA3:%.*]] = alloca [81 x float], i32 0, align 4
; CHECK-NEXT:    store float 0.000000e+00, ptr [[ALLOCA3]], align 4
; CHECK-NEXT:    br label [[BB4:%.*]]
; CHECK:       bb4:
; CHECK-NEXT:    [[C1:%.*]] = load volatile i1, ptr @random, align 4
; CHECK-NEXT:    br i1 [[C1]], label [[BB5:%.*]], label [[BB7:%.*]]
; CHECK:       bb5:
; CHECK-NEXT:    store float [[ARG2]], ptr [[ALLOCA3]], align 4
; CHECK-NEXT:    br label [[BB4]]
; CHECK:       bb7:
; CHECK-NEXT:    [[PHI:%.*]] = phi i32 [ [[ADD:%.*]], [[BB11:%.*]] ], [ 0, [[BB4]] ]
; CHECK-NEXT:    [[ICMP:%.*]] = icmp slt i32 [[PHI]], 5
; CHECK-NEXT:    br i1 [[ICMP]], label [[BB8:%.*]], label [[BB12:%.*]]
; CHECK:       bb8:
; CHECK-NEXT:    [[C2:%.*]] = load volatile i1, ptr @random, align 4
; CHECK-NEXT:    br i1 [[C2]], label [[BB9:%.*]], label [[BB11]]
; CHECK:       bb9:
; CHECK-NEXT:    [[SEXT:%.*]] = sext i32 [[PHI]] to i64
; CHECK-NEXT:    [[GETELEMENTPTR10:%.*]] = getelementptr [128 x float], ptr [[ALLOCA]], i64 0, i64 [[SEXT]]
; CHECK-NEXT:    store float 1.000000e+00, ptr [[GETELEMENTPTR10]], align 4
; CHECK-NEXT:    br label [[BB8]]
; CHECK:       bb11:
; CHECK-NEXT:    [[ADD]] = add i32 1, [[PHI]]
; CHECK-NEXT:    br label [[BB7]]
; CHECK:       bb12:
; CHECK-NEXT:    [[C3:%.*]] = load volatile i1, ptr @random, align 4
; CHECK-NEXT:    br i1 [[C3]], label [[BB13:%.*]], label [[BB19:%.*]]
; CHECK:       bb13:
; CHECK-NEXT:    [[LOAD:%.*]] = load float, ptr [[ALLOCA3]], align 4
; CHECK-NEXT:    br label [[BB14:%.*]]
; CHECK:       bb14:
; CHECK-NEXT:    [[PHI15:%.*]] = phi i32 [ 0, [[BB13]] ], [ 1, [[BB17:%.*]] ]
; CHECK-NEXT:    [[ICMP16:%.*]] = icmp slt i32 [[PHI15]], 1
; CHECK-NEXT:    br i1 [[ICMP16]], label [[BB17]], label [[BB19]]
; CHECK:       bb17:
; CHECK-NEXT:    [[C4:%.*]] = load volatile i1, ptr @random, align 4
; CHECK-NEXT:    br i1 [[C4]], label [[BB18:%.*]], label [[BB14]]
; CHECK:       bb18:
; CHECK-NEXT:    store float [[LOAD]], ptr [[ALLOCA]], align 4
; CHECK-NEXT:    br label [[BB17]]
; CHECK:       bb19:
; CHECK-NEXT:    [[SEXT20:%.*]] = sext i32 0 to i64
; CHECK-NEXT:    [[LOAD22:%.*]] = load float, ptr [[ALLOCA]], align 4
; CHECK-NEXT:    store float [[LOAD22]], ptr [[ARG1]], align 4
; CHECK-NEXT:    ret void
;
bb:
  %alloca = alloca [128 x float], i32 0, align 4
  %alloca3 = alloca [81 x float], i32 0, align 4
; store is removed
  store float 0.0e+00, ptr %alloca3, align 4
  br label %bb4

bb4:                                              ; preds = %bb5, %bb
  %c1 = load volatile i1, ptr @random
  br i1 %c1, label %bb5, label %bb7

bb5:                                              ; preds = %bb4
; store is removed
  store float %arg2, ptr %alloca3, align 4
  br label %bb4

bb7:                                              ; preds = %bb11, %bb4
  %phi = phi i32 [ %add, %bb11 ], [ 0, %bb4 ]
  %icmp = icmp slt i32 %phi, 5
  br i1 %icmp, label %bb8, label %bb12

bb8:                                              ; preds = %bb9, %bb7
  %c2 = load volatile i1, ptr @random
  br i1 %c2, label %bb9, label %bb11

bb9:                                              ; preds = %bb8
  %sext = sext i32 %phi to i64
  %getelementptr10 = getelementptr [128 x float], ptr %alloca, i64 0, i64 %sext
  store float 1.000000e+00, ptr %getelementptr10, align 4
  br label %bb8

bb11:                                             ; preds = %bb8
  %add = add i32 1, %phi
  br label %bb7

bb12:                                             ; preds = %bb7
  %c3 = load volatile i1, ptr @random
  br i1 %c3, label %bb13, label %bb19

bb13:                                             ; preds = %bb12
  %load = load float, ptr %alloca3, align 4
  br label %bb14

bb14:                                             ; preds = %bb17, %bb13
  %phi15 = phi i32 [ 0, %bb13 ], [ 1, %bb17 ]
  %icmp16 = icmp slt i32 %phi15, 1
  br i1 %icmp16, label %bb17, label %bb19

bb17:                                             ; preds = %bb18, %bb14
  %c4 = load volatile i1, ptr @random
  br i1 %c4, label %bb18, label %bb14

bb18:                                             ; preds = %bb17
  store float %load, ptr %alloca, align 4
  br label %bb17

bb19:                                             ; preds = %bb14, %bb12
  %sext20 = sext i32 0 to i64
  %load22 = load float, ptr %alloca, align 4
; Loaded value could be either 0.0,1.0,%arg2, or undef.
  store float %load22, ptr %arg1, align 4
  ret void
}
;.
; CHECK: attributes #[[ATTR0]] = { nofree norecurse nounwind }
;.
;; NOTE: These prefixes are unused and the list is autogenerated. Do not add tests below this line:
; CGSCC: {{.*}}
; TUNIT: {{.*}}
