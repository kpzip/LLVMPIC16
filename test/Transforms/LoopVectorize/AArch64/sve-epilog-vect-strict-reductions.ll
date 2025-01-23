; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=loop-vectorize -mtriple aarch64-unknown-linux-gnu -mattr=+sve -epilogue-vectorization-force-VF=2 -S | FileCheck %s

;
; Strict fadd reduction with interleaving
;
define float @fadd_strict(ptr noalias nocapture readonly %a, i64 %n) {
; CHECK-LABEL: @fadd_strict(
; CHECK-NEXT:  iter.check:
; CHECK-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i64 [[N:%.*]], 2
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[VEC_EPILOG_SCALAR_PH:%.*]], label [[VECTOR_MAIN_LOOP_ITER_CHECK:%.*]]
; CHECK:       vector.main.loop.iter.check:
; CHECK-NEXT:    [[TMP0:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP1:%.*]] = mul i64 [[TMP0]], 8
; CHECK-NEXT:    [[MIN_ITERS_CHECK1:%.*]] = icmp ult i64 [[N]], [[TMP1]]
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK1]], label [[VEC_EPILOG_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[TMP2:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP3:%.*]] = mul i64 [[TMP2]], 8
; CHECK-NEXT:    [[N_MOD_VF:%.*]] = urem i64 [[N]], [[TMP3]]
; CHECK-NEXT:    [[N_VEC:%.*]] = sub i64 [[N]], [[N_MOD_VF]]
; CHECK-NEXT:    [[TMP4:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP5:%.*]] = mul i64 [[TMP4]], 8
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI:%.*]] = phi float [ 0xFFFFFFFFE0000000, [[VECTOR_PH]] ], [ [[TMP19:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP6:%.*]] = add i64 [[INDEX]], 0
; CHECK-NEXT:    [[TMP7:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP8:%.*]] = mul i64 [[TMP7]], 4
; CHECK-NEXT:    [[TMP9:%.*]] = add i64 [[TMP8]], 0
; CHECK-NEXT:    [[TMP10:%.*]] = mul i64 [[TMP9]], 1
; CHECK-NEXT:    [[TMP11:%.*]] = add i64 [[INDEX]], [[TMP10]]
; CHECK-NEXT:    [[TMP12:%.*]] = getelementptr inbounds float, ptr [[A:%.*]], i64 [[TMP6]]
; CHECK-NEXT:    [[TMP13:%.*]] = getelementptr inbounds float, ptr [[A]], i64 [[TMP11]]
; CHECK-NEXT:    [[TMP14:%.*]] = getelementptr inbounds float, ptr [[TMP12]], i32 0
; CHECK-NEXT:    [[TMP15:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP16:%.*]] = mul i64 [[TMP15]], 4
; CHECK-NEXT:    [[TMP17:%.*]] = getelementptr inbounds float, ptr [[TMP12]], i64 [[TMP16]]
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <vscale x 4 x float>, ptr [[TMP14]], align 4
; CHECK-NEXT:    [[WIDE_LOAD2:%.*]] = load <vscale x 4 x float>, ptr [[TMP17]], align 4
; CHECK-NEXT:    [[TMP18:%.*]] = call float @llvm.vector.reduce.fadd.nxv4f32(float [[VEC_PHI]], <vscale x 4 x float> [[WIDE_LOAD]])
; CHECK-NEXT:    [[TMP19]] = call float @llvm.vector.reduce.fadd.nxv4f32(float [[TMP18]], <vscale x 4 x float> [[WIDE_LOAD2]])
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], [[TMP5]]
; CHECK-NEXT:    [[TMP20:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP20]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i64 [[N]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[CMP_N]], label [[FOR_END:%.*]], label [[VEC_EPILOG_ITER_CHECK:%.*]]
; CHECK:       vec.epilog.iter.check:
; CHECK-NEXT:    [[N_VEC_REMAINING:%.*]] = sub i64 [[N]], [[N_VEC]]
; CHECK-NEXT:    [[MIN_EPILOG_ITERS_CHECK:%.*]] = icmp ult i64 [[N_VEC_REMAINING]], 2
; CHECK-NEXT:    br i1 [[MIN_EPILOG_ITERS_CHECK]], label [[VEC_EPILOG_SCALAR_PH]], label [[VEC_EPILOG_PH]]
; CHECK:       vec.epilog.ph:
; CHECK-NEXT:    [[BC_MERGE_RDX:%.*]] = phi float [ [[TMP19]], [[VEC_EPILOG_ITER_CHECK]] ], [ 0xFFFFFFFFE0000000, [[VECTOR_MAIN_LOOP_ITER_CHECK]] ]
; CHECK-NEXT:    [[VEC_EPILOG_RESUME_VAL:%.*]] = phi i64 [ [[N_VEC]], [[VEC_EPILOG_ITER_CHECK]] ], [ 0, [[VECTOR_MAIN_LOOP_ITER_CHECK]] ]
; CHECK-NEXT:    [[N_MOD_VF3:%.*]] = urem i64 [[N]], 2
; CHECK-NEXT:    [[N_VEC4:%.*]] = sub i64 [[N]], [[N_MOD_VF3]]
; CHECK-NEXT:    br label [[VEC_EPILOG_VECTOR_BODY:%.*]]
; CHECK:       vec.epilog.vector.body:
; CHECK-NEXT:    [[INDEX6:%.*]] = phi i64 [ [[VEC_EPILOG_RESUME_VAL]], [[VEC_EPILOG_PH]] ], [ [[INDEX_NEXT9:%.*]], [[VEC_EPILOG_VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI7:%.*]] = phi float [ [[BC_MERGE_RDX]], [[VEC_EPILOG_PH]] ], [ [[TMP24:%.*]], [[VEC_EPILOG_VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP21:%.*]] = add i64 [[INDEX6]], 0
; CHECK-NEXT:    [[TMP22:%.*]] = getelementptr inbounds float, ptr [[A]], i64 [[TMP21]]
; CHECK-NEXT:    [[TMP23:%.*]] = getelementptr inbounds float, ptr [[TMP22]], i32 0
; CHECK-NEXT:    [[WIDE_LOAD8:%.*]] = load <2 x float>, ptr [[TMP23]], align 4
; CHECK-NEXT:    [[TMP24]] = call float @llvm.vector.reduce.fadd.v2f32(float [[VEC_PHI7]], <2 x float> [[WIDE_LOAD8]])
; CHECK-NEXT:    [[INDEX_NEXT9]] = add nuw i64 [[INDEX6]], 2
; CHECK-NEXT:    [[TMP25:%.*]] = icmp eq i64 [[INDEX_NEXT9]], [[N_VEC4]]
; CHECK-NEXT:    br i1 [[TMP25]], label [[VEC_EPILOG_MIDDLE_BLOCK:%.*]], label [[VEC_EPILOG_VECTOR_BODY]], !llvm.loop [[LOOP3:![0-9]+]]
; CHECK:       vec.epilog.middle.block:
; CHECK-NEXT:    [[CMP_N5:%.*]] = icmp eq i64 [[N]], [[N_VEC4]]
; CHECK-NEXT:    br i1 [[CMP_N5]], label [[FOR_END]], label [[VEC_EPILOG_SCALAR_PH]]
; CHECK:       vec.epilog.scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ [[N_VEC4]], [[VEC_EPILOG_MIDDLE_BLOCK]] ], [ [[N_VEC]], [[VEC_EPILOG_ITER_CHECK]] ], [ 0, [[ITER_CHECK:%.*]] ]
; CHECK-NEXT:    [[BC_MERGE_RDX10:%.*]] = phi float [ [[TMP24]], [[VEC_EPILOG_MIDDLE_BLOCK]] ], [ 0xFFFFFFFFE0000000, [[ITER_CHECK]] ], [ [[TMP19]], [[VEC_EPILOG_ITER_CHECK]] ]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[IV:%.*]] = phi i64 [ [[BC_RESUME_VAL]], [[VEC_EPILOG_SCALAR_PH]] ], [ [[IV_NEXT:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[SUM_07:%.*]] = phi float [ [[BC_MERGE_RDX10]], [[VEC_EPILOG_SCALAR_PH]] ], [ [[ADD:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds float, ptr [[A]], i64 [[IV]]
; CHECK-NEXT:    [[TMP26:%.*]] = load float, ptr [[ARRAYIDX]], align 4
; CHECK-NEXT:    [[ADD]] = fadd float [[TMP26]], [[SUM_07]]
; CHECK-NEXT:    [[IV_NEXT]] = add nuw nsw i64 [[IV]], 1
; CHECK-NEXT:    [[EXITCOND_NOT:%.*]] = icmp eq i64 [[IV_NEXT]], [[N]]
; CHECK-NEXT:    br i1 [[EXITCOND_NOT]], label [[FOR_END]], label [[FOR_BODY]], !llvm.loop [[LOOP4:![0-9]+]]
; CHECK:       for.end:
; CHECK-NEXT:    [[ADD_LCSSA:%.*]] = phi float [ [[ADD]], [[FOR_BODY]] ], [ [[TMP19]], [[MIDDLE_BLOCK]] ], [ [[TMP24]], [[VEC_EPILOG_MIDDLE_BLOCK]] ]
; CHECK-NEXT:    ret float [[ADD_LCSSA]]
;
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %sum.07 = phi float [ 0xFFFFFFFFE0000000, %entry ], [ %add, %for.body ]
  %arrayidx = getelementptr inbounds float, ptr %a, i64 %iv
  %0 = load float, ptr %arrayidx, align 4
  %add = fadd float %0, %sum.07
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !0

for.end:
  ret float %add
}

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.interleave.count", i32 2}
!2 = !{!"llvm.loop.vectorize.scalable.enable", i1 true}
