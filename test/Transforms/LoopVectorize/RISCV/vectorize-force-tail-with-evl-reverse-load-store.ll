; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=loop-vectorize \
; RUN: -force-tail-folding-style=data-with-evl \
; RUN: -prefer-predicate-over-epilogue=predicate-dont-vectorize \
; RUN: -mtriple=riscv64 -mattr=+v -S < %s | FileCheck %s --check-prefix=IF-EVL

; RUN: opt -passes=loop-vectorize \
; RUN: -force-tail-folding-style=none \
; RUN: -prefer-predicate-over-epilogue=predicate-dont-vectorize \
; RUN: -mtriple=riscv64 -mattr=+v -S < %s | FileCheck %s --check-prefix=NO-VP

define void @reverse_load_store(i64 %startval, ptr noalias %ptr, ptr noalias %ptr2) {
; IF-EVL-LABEL: @reverse_load_store(
; IF-EVL-NEXT:  entry:
; IF-EVL-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; IF-EVL:       vector.ph:
; IF-EVL-NEXT:    [[TMP0:%.*]] = call i64 @llvm.vscale.i64()
; IF-EVL-NEXT:    [[TMP1:%.*]] = mul i64 [[TMP0]], 4
; IF-EVL-NEXT:    [[TMP4:%.*]] = sub i64 [[TMP1]], 1
; IF-EVL-NEXT:    [[N_RND_UP:%.*]] = add i64 1024, [[TMP4]]
; IF-EVL-NEXT:    [[N_MOD_VF:%.*]] = urem i64 [[N_RND_UP]], [[TMP1]]
; IF-EVL-NEXT:    [[N_VEC:%.*]] = sub i64 [[N_RND_UP]], [[N_MOD_VF]]
; IF-EVL-NEXT:    [[IND_END:%.*]] = sub i64 [[STARTVAL:%.*]], [[N_VEC]]
; IF-EVL-NEXT:    [[IND_END1:%.*]] = trunc i64 [[N_VEC]] to i32
; IF-EVL-NEXT:    [[TMP5:%.*]] = call i64 @llvm.vscale.i64()
; IF-EVL-NEXT:    [[TMP6:%.*]] = mul i64 [[TMP5]], 4
; IF-EVL-NEXT:    br label [[VECTOR_BODY:%.*]]
; IF-EVL:       vector.body:
; IF-EVL-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; IF-EVL-NEXT:    [[EVL_BASED_IV:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_EVL_NEXT:%.*]], [[VECTOR_BODY]] ]
; IF-EVL-NEXT:    [[TMP7:%.*]] = sub i64 1024, [[EVL_BASED_IV]]
; IF-EVL-NEXT:    [[TMP8:%.*]] = call i32 @llvm.experimental.get.vector.length.i64(i64 [[TMP7]], i32 4, i1 true)
; IF-EVL-NEXT:    [[OFFSET_IDX:%.*]] = sub i64 [[STARTVAL]], [[EVL_BASED_IV]]
; IF-EVL-NEXT:    [[TMP9:%.*]] = add i64 [[OFFSET_IDX]], 0
; IF-EVL-NEXT:    [[TMP10:%.*]] = add i64 [[TMP9]], -1
; IF-EVL-NEXT:    [[TMP11:%.*]] = getelementptr inbounds i32, ptr [[PTR:%.*]], i64 [[TMP10]]
; IF-EVL-NEXT:    [[TMP12:%.*]] = call i64 @llvm.vscale.i64()
; IF-EVL-NEXT:    [[TMP13:%.*]] = mul i64 [[TMP12]], 4
; IF-EVL-NEXT:    [[TMP14:%.*]] = mul i64 0, [[TMP13]]
; IF-EVL-NEXT:    [[TMP15:%.*]] = sub i64 1, [[TMP13]]
; IF-EVL-NEXT:    [[TMP16:%.*]] = getelementptr inbounds i32, ptr [[TMP11]], i64 [[TMP14]]
; IF-EVL-NEXT:    [[TMP17:%.*]] = getelementptr inbounds i32, ptr [[TMP16]], i64 [[TMP15]]
; IF-EVL-NEXT:    [[VP_OP_LOAD:%.*]] = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 [[TMP17]], <vscale x 4 x i1> shufflevector (<vscale x 4 x i1> insertelement (<vscale x 4 x i1> poison, i1 true, i64 0), <vscale x 4 x i1> poison, <vscale x 4 x i32> zeroinitializer), i32 [[TMP8]])
; IF-EVL-NEXT:    [[VP_REVERSE:%.*]] = call <vscale x 4 x i32> @llvm.experimental.vp.reverse.nxv4i32(<vscale x 4 x i32> [[VP_OP_LOAD]], <vscale x 4 x i1> shufflevector (<vscale x 4 x i1> insertelement (<vscale x 4 x i1> poison, i1 true, i64 0), <vscale x 4 x i1> poison, <vscale x 4 x i32> zeroinitializer), i32 [[TMP8]])
; IF-EVL-NEXT:    [[TMP18:%.*]] = getelementptr inbounds i32, ptr [[PTR2:%.*]], i64 [[TMP10]]
; IF-EVL-NEXT:    [[TMP19:%.*]] = call i64 @llvm.vscale.i64()
; IF-EVL-NEXT:    [[TMP20:%.*]] = mul i64 [[TMP19]], 4
; IF-EVL-NEXT:    [[TMP21:%.*]] = mul i64 0, [[TMP20]]
; IF-EVL-NEXT:    [[TMP22:%.*]] = sub i64 1, [[TMP20]]
; IF-EVL-NEXT:    [[TMP23:%.*]] = getelementptr inbounds i32, ptr [[TMP18]], i64 [[TMP21]]
; IF-EVL-NEXT:    [[TMP24:%.*]] = getelementptr inbounds i32, ptr [[TMP23]], i64 [[TMP22]]
; IF-EVL-NEXT:    [[VP_REVERSE3:%.*]] = call <vscale x 4 x i32> @llvm.experimental.vp.reverse.nxv4i32(<vscale x 4 x i32> [[VP_REVERSE]], <vscale x 4 x i1> shufflevector (<vscale x 4 x i1> insertelement (<vscale x 4 x i1> poison, i1 true, i64 0), <vscale x 4 x i1> poison, <vscale x 4 x i32> zeroinitializer), i32 [[TMP8]])
; IF-EVL-NEXT:    call void @llvm.vp.store.nxv4i32.p0(<vscale x 4 x i32> [[VP_REVERSE3]], ptr align 4 [[TMP24]], <vscale x 4 x i1> shufflevector (<vscale x 4 x i1> insertelement (<vscale x 4 x i1> poison, i1 true, i64 0), <vscale x 4 x i1> poison, <vscale x 4 x i32> zeroinitializer), i32 [[TMP8]])
; IF-EVL-NEXT:    [[TMP25:%.*]] = zext i32 [[TMP8]] to i64
; IF-EVL-NEXT:    [[INDEX_EVL_NEXT]] = add i64 [[TMP25]], [[EVL_BASED_IV]]
; IF-EVL-NEXT:    [[INDEX_NEXT]] = add i64 [[INDEX]], [[TMP6]]
; IF-EVL-NEXT:    [[TMP26:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; IF-EVL-NEXT:    br i1 [[TMP26]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; IF-EVL:       middle.block:
; IF-EVL-NEXT:    br i1 true, label [[LOOPEND:%.*]], label [[SCALAR_PH]]
; IF-EVL:       scalar.ph:
; IF-EVL-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ [[IND_END]], [[MIDDLE_BLOCK]] ], [ [[STARTVAL]], [[ENTRY:%.*]] ]
; IF-EVL-NEXT:    [[BC_RESUME_VAL2:%.*]] = phi i32 [ [[IND_END1]], [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY]] ]
; IF-EVL-NEXT:    br label [[FOR_BODY:%.*]]
; IF-EVL:       for.body:
; IF-EVL-NEXT:    [[ADD_PHI:%.*]] = phi i64 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[ADD:%.*]], [[FOR_BODY]] ]
; IF-EVL-NEXT:    [[I:%.*]] = phi i32 [ [[BC_RESUME_VAL2]], [[SCALAR_PH]] ], [ [[INC:%.*]], [[FOR_BODY]] ]
; IF-EVL-NEXT:    [[ADD]] = add i64 [[ADD_PHI]], -1
; IF-EVL-NEXT:    [[GEPL:%.*]] = getelementptr inbounds i32, ptr [[PTR]], i64 [[ADD]]
; IF-EVL-NEXT:    [[TMP:%.*]] = load i32, ptr [[GEPL]], align 4
; IF-EVL-NEXT:    [[GEPS:%.*]] = getelementptr inbounds i32, ptr [[PTR2]], i64 [[ADD]]
; IF-EVL-NEXT:    store i32 [[TMP]], ptr [[GEPS]], align 4
; IF-EVL-NEXT:    [[INC]] = add i32 [[I]], 1
; IF-EVL-NEXT:    [[EXITCOND:%.*]] = icmp ne i32 [[INC]], 1024
; IF-EVL-NEXT:    br i1 [[EXITCOND]], label [[FOR_BODY]], label [[LOOPEND]], !llvm.loop [[LOOP3:![0-9]+]]
; IF-EVL:       loopend:
; IF-EVL-NEXT:    ret void
;
; NO-VP-LABEL: @reverse_load_store(
; NO-VP-NEXT:  entry:
; NO-VP-NEXT:    br label [[FOR_BODY:%.*]]
; NO-VP:       for.body:
; NO-VP-NEXT:    [[ADD_PHI:%.*]] = phi i64 [ [[STARTVAL:%.*]], [[ENTRY:%.*]] ], [ [[ADD:%.*]], [[FOR_BODY]] ]
; NO-VP-NEXT:    [[I:%.*]] = phi i32 [ 0, [[ENTRY]] ], [ [[INC:%.*]], [[FOR_BODY]] ]
; NO-VP-NEXT:    [[ADD]] = add i64 [[ADD_PHI]], -1
; NO-VP-NEXT:    [[GEPL:%.*]] = getelementptr inbounds i32, ptr [[PTR:%.*]], i64 [[ADD]]
; NO-VP-NEXT:    [[TMP:%.*]] = load i32, ptr [[GEPL]], align 4
; NO-VP-NEXT:    [[GEPS:%.*]] = getelementptr inbounds i32, ptr [[PTR2:%.*]], i64 [[ADD]]
; NO-VP-NEXT:    store i32 [[TMP]], ptr [[GEPS]], align 4
; NO-VP-NEXT:    [[INC]] = add i32 [[I]], 1
; NO-VP-NEXT:    [[EXITCOND:%.*]] = icmp ne i32 [[INC]], 1024
; NO-VP-NEXT:    br i1 [[EXITCOND]], label [[FOR_BODY]], label [[LOOPEND:%.*]]
; NO-VP:       loopend:
; NO-VP-NEXT:    ret void
;
entry:
  br label %for.body

for.body:
  %add.phi = phi i64 [ %startval, %entry ], [ %add, %for.body ]
  %i = phi i32 [ 0, %entry ], [ %inc, %for.body ]
  %add = add i64 %add.phi, -1
  %gepl = getelementptr inbounds i32, ptr %ptr, i64 %add
  %tmp = load i32, ptr %gepl, align 4
  %geps = getelementptr inbounds i32, ptr %ptr2, i64 %add
  store i32 %tmp, ptr %geps, align 4
  %inc = add i32 %i, 1
  %exitcond = icmp ne i32 %inc, 1024
  br i1 %exitcond, label %for.body, label %loopend

loopend:
  ret void
}

define void @reverse_load_store_masked(i64 %startval, ptr noalias %ptr, ptr noalias %ptr1, ptr noalias %ptr2) {
; IF-EVL-LABEL: @reverse_load_store_masked(
; IF-EVL-NEXT:  entry:
; IF-EVL-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; IF-EVL:       vector.ph:
; IF-EVL-NEXT:    [[TMP0:%.*]] = call i64 @llvm.vscale.i64()
; IF-EVL-NEXT:    [[TMP1:%.*]] = mul i64 [[TMP0]], 4
; IF-EVL-NEXT:    [[TMP4:%.*]] = sub i64 [[TMP1]], 1
; IF-EVL-NEXT:    [[N_RND_UP:%.*]] = add i64 1024, [[TMP4]]
; IF-EVL-NEXT:    [[N_MOD_VF:%.*]] = urem i64 [[N_RND_UP]], [[TMP1]]
; IF-EVL-NEXT:    [[N_VEC:%.*]] = sub i64 [[N_RND_UP]], [[N_MOD_VF]]
; IF-EVL-NEXT:    [[IND_END:%.*]] = sub i64 [[STARTVAL:%.*]], [[N_VEC]]
; IF-EVL-NEXT:    [[IND_END1:%.*]] = trunc i64 [[N_VEC]] to i32
; IF-EVL-NEXT:    [[TMP5:%.*]] = call i64 @llvm.vscale.i64()
; IF-EVL-NEXT:    [[TMP6:%.*]] = mul i64 [[TMP5]], 4
; IF-EVL-NEXT:    br label [[VECTOR_BODY:%.*]]
; IF-EVL:       vector.body:
; IF-EVL-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; IF-EVL-NEXT:    [[EVL_BASED_IV:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_EVL_NEXT:%.*]], [[VECTOR_BODY]] ]
; IF-EVL-NEXT:    [[TMP7:%.*]] = sub i64 1024, [[EVL_BASED_IV]]
; IF-EVL-NEXT:    [[TMP8:%.*]] = call i32 @llvm.experimental.get.vector.length.i64(i64 [[TMP7]], i32 4, i1 true)
; IF-EVL-NEXT:    [[OFFSET_IDX:%.*]] = sub i64 [[STARTVAL]], [[EVL_BASED_IV]]
; IF-EVL-NEXT:    [[TMP9:%.*]] = add i64 [[OFFSET_IDX]], 0
; IF-EVL-NEXT:    [[OFFSET_IDX3:%.*]] = trunc i64 [[EVL_BASED_IV]] to i32
; IF-EVL-NEXT:    [[TMP10:%.*]] = add i32 [[OFFSET_IDX3]], 0
; IF-EVL-NEXT:    [[BROADCAST_SPLATINSERT:%.*]] = insertelement <vscale x 4 x i64> poison, i64 [[EVL_BASED_IV]], i64 0
; IF-EVL-NEXT:    [[BROADCAST_SPLAT:%.*]] = shufflevector <vscale x 4 x i64> [[BROADCAST_SPLATINSERT]], <vscale x 4 x i64> poison, <vscale x 4 x i32> zeroinitializer
; IF-EVL-NEXT:    [[TMP11:%.*]] = call <vscale x 4 x i64> @llvm.experimental.stepvector.nxv4i64()
; IF-EVL-NEXT:    [[TMP12:%.*]] = add <vscale x 4 x i64> zeroinitializer, [[TMP11]]
; IF-EVL-NEXT:    [[VEC_IV:%.*]] = add <vscale x 4 x i64> [[BROADCAST_SPLAT]], [[TMP12]]
; IF-EVL-NEXT:    [[TMP13:%.*]] = icmp ule <vscale x 4 x i64> [[VEC_IV]], shufflevector (<vscale x 4 x i64> insertelement (<vscale x 4 x i64> poison, i64 1023, i64 0), <vscale x 4 x i64> poison, <vscale x 4 x i32> zeroinitializer)
; IF-EVL-NEXT:    [[TMP14:%.*]] = add i64 [[TMP9]], -1
; IF-EVL-NEXT:    [[TMP15:%.*]] = getelementptr inbounds i32, ptr [[PTR:%.*]], i32 [[TMP10]]
; IF-EVL-NEXT:    [[TMP16:%.*]] = getelementptr inbounds i32, ptr [[TMP15]], i32 0
; IF-EVL-NEXT:    [[VP_OP_LOAD:%.*]] = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 [[TMP16]], <vscale x 4 x i1> shufflevector (<vscale x 4 x i1> insertelement (<vscale x 4 x i1> poison, i1 true, i64 0), <vscale x 4 x i1> poison, <vscale x 4 x i32> zeroinitializer), i32 [[TMP8]])
; IF-EVL-NEXT:    [[TMP17:%.*]] = icmp slt <vscale x 4 x i32> [[VP_OP_LOAD]], shufflevector (<vscale x 4 x i32> insertelement (<vscale x 4 x i32> poison, i32 100, i64 0), <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer)
; IF-EVL-NEXT:    [[TMP18:%.*]] = select <vscale x 4 x i1> [[TMP13]], <vscale x 4 x i1> [[TMP17]], <vscale x 4 x i1> zeroinitializer
; IF-EVL-NEXT:    [[TMP19:%.*]] = getelementptr i32, ptr [[PTR1:%.*]], i64 [[TMP14]]
; IF-EVL-NEXT:    [[TMP20:%.*]] = call i64 @llvm.vscale.i64()
; IF-EVL-NEXT:    [[TMP21:%.*]] = mul i64 [[TMP20]], 4
; IF-EVL-NEXT:    [[TMP22:%.*]] = mul i64 0, [[TMP21]]
; IF-EVL-NEXT:    [[TMP23:%.*]] = sub i64 1, [[TMP21]]
; IF-EVL-NEXT:    [[TMP24:%.*]] = getelementptr i32, ptr [[TMP19]], i64 [[TMP22]]
; IF-EVL-NEXT:    [[TMP25:%.*]] = getelementptr i32, ptr [[TMP24]], i64 [[TMP23]]
; IF-EVL-NEXT:    [[VP_REVERSE_MASK:%.*]] = call <vscale x 4 x i1> @llvm.experimental.vp.reverse.nxv4i1(<vscale x 4 x i1> [[TMP18]], <vscale x 4 x i1> shufflevector (<vscale x 4 x i1> insertelement (<vscale x 4 x i1> poison, i1 true, i64 0), <vscale x 4 x i1> poison, <vscale x 4 x i32> zeroinitializer), i32 [[TMP8]])
; IF-EVL-NEXT:    [[VP_OP_LOAD4:%.*]] = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 [[TMP25]], <vscale x 4 x i1> [[VP_REVERSE_MASK]], i32 [[TMP8]])
; IF-EVL-NEXT:    [[VP_REVERSE:%.*]] = call <vscale x 4 x i32> @llvm.experimental.vp.reverse.nxv4i32(<vscale x 4 x i32> [[VP_OP_LOAD4]], <vscale x 4 x i1> shufflevector (<vscale x 4 x i1> insertelement (<vscale x 4 x i1> poison, i1 true, i64 0), <vscale x 4 x i1> poison, <vscale x 4 x i32> zeroinitializer), i32 [[TMP8]])
; IF-EVL-NEXT:    [[TMP26:%.*]] = getelementptr i32, ptr [[PTR2:%.*]], i64 [[TMP14]]
; IF-EVL-NEXT:    [[TMP27:%.*]] = call i64 @llvm.vscale.i64()
; IF-EVL-NEXT:    [[TMP28:%.*]] = mul i64 [[TMP27]], 4
; IF-EVL-NEXT:    [[TMP29:%.*]] = mul i64 0, [[TMP28]]
; IF-EVL-NEXT:    [[TMP30:%.*]] = sub i64 1, [[TMP28]]
; IF-EVL-NEXT:    [[TMP31:%.*]] = getelementptr i32, ptr [[TMP26]], i64 [[TMP29]]
; IF-EVL-NEXT:    [[TMP32:%.*]] = getelementptr i32, ptr [[TMP31]], i64 [[TMP30]]
; IF-EVL-NEXT:    [[VP_REVERSE5:%.*]] = call <vscale x 4 x i32> @llvm.experimental.vp.reverse.nxv4i32(<vscale x 4 x i32> [[VP_REVERSE]], <vscale x 4 x i1> shufflevector (<vscale x 4 x i1> insertelement (<vscale x 4 x i1> poison, i1 true, i64 0), <vscale x 4 x i1> poison, <vscale x 4 x i32> zeroinitializer), i32 [[TMP8]])
; IF-EVL-NEXT:    [[VP_REVERSE_MASK6:%.*]] = call <vscale x 4 x i1> @llvm.experimental.vp.reverse.nxv4i1(<vscale x 4 x i1> [[TMP18]], <vscale x 4 x i1> shufflevector (<vscale x 4 x i1> insertelement (<vscale x 4 x i1> poison, i1 true, i64 0), <vscale x 4 x i1> poison, <vscale x 4 x i32> zeroinitializer), i32 [[TMP8]])
; IF-EVL-NEXT:    call void @llvm.vp.store.nxv4i32.p0(<vscale x 4 x i32> [[VP_REVERSE5]], ptr align 4 [[TMP32]], <vscale x 4 x i1> [[VP_REVERSE_MASK6]], i32 [[TMP8]])
; IF-EVL-NEXT:    [[TMP33:%.*]] = zext i32 [[TMP8]] to i64
; IF-EVL-NEXT:    [[INDEX_EVL_NEXT]] = add i64 [[TMP33]], [[EVL_BASED_IV]]
; IF-EVL-NEXT:    [[INDEX_NEXT]] = add i64 [[INDEX]], [[TMP6]]
; IF-EVL-NEXT:    [[TMP34:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; IF-EVL-NEXT:    br i1 [[TMP34]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP4:![0-9]+]]
; IF-EVL:       middle.block:
; IF-EVL-NEXT:    br i1 true, label [[LOOPEND:%.*]], label [[SCALAR_PH]]
; IF-EVL:       scalar.ph:
; IF-EVL-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ [[IND_END]], [[MIDDLE_BLOCK]] ], [ [[STARTVAL]], [[ENTRY:%.*]] ]
; IF-EVL-NEXT:    [[BC_RESUME_VAL2:%.*]] = phi i32 [ [[IND_END1]], [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY]] ]
; IF-EVL-NEXT:    br label [[FOR_BODY:%.*]]
; IF-EVL:       for.body:
; IF-EVL-NEXT:    [[ADD_PHI:%.*]] = phi i64 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[ADD:%.*]], [[FOR_INC:%.*]] ]
; IF-EVL-NEXT:    [[I:%.*]] = phi i32 [ [[BC_RESUME_VAL2]], [[SCALAR_PH]] ], [ [[INC:%.*]], [[FOR_INC]] ]
; IF-EVL-NEXT:    [[ADD]] = add i64 [[ADD_PHI]], -1
; IF-EVL-NEXT:    [[GEPL:%.*]] = getelementptr inbounds i32, ptr [[PTR]], i32 [[I]]
; IF-EVL-NEXT:    [[TMP:%.*]] = load i32, ptr [[GEPL]], align 4
; IF-EVL-NEXT:    [[CMP1:%.*]] = icmp slt i32 [[TMP]], 100
; IF-EVL-NEXT:    br i1 [[CMP1]], label [[IF_THEN:%.*]], label [[FOR_INC]]
; IF-EVL:       if.then:
; IF-EVL-NEXT:    [[GEPL1:%.*]] = getelementptr inbounds i32, ptr [[PTR1]], i64 [[ADD]]
; IF-EVL-NEXT:    [[V:%.*]] = load i32, ptr [[GEPL1]], align 4
; IF-EVL-NEXT:    [[GEPS:%.*]] = getelementptr inbounds i32, ptr [[PTR2]], i64 [[ADD]]
; IF-EVL-NEXT:    store i32 [[V]], ptr [[GEPS]], align 4
; IF-EVL-NEXT:    br label [[FOR_INC]]
; IF-EVL:       for.inc:
; IF-EVL-NEXT:    [[INC]] = add i32 [[I]], 1
; IF-EVL-NEXT:    [[EXITCOND:%.*]] = icmp ne i32 [[INC]], 1024
; IF-EVL-NEXT:    br i1 [[EXITCOND]], label [[FOR_BODY]], label [[LOOPEND]], !llvm.loop [[LOOP5:![0-9]+]]
; IF-EVL:       loopend:
; IF-EVL-NEXT:    ret void
;
; NO-VP-LABEL: @reverse_load_store_masked(
; NO-VP-NEXT:  entry:
; NO-VP-NEXT:    br label [[FOR_BODY:%.*]]
; NO-VP:       for.body:
; NO-VP-NEXT:    [[ADD_PHI:%.*]] = phi i64 [ [[STARTVAL:%.*]], [[ENTRY:%.*]] ], [ [[ADD:%.*]], [[FOR_INC:%.*]] ]
; NO-VP-NEXT:    [[I:%.*]] = phi i32 [ 0, [[ENTRY]] ], [ [[INC:%.*]], [[FOR_INC]] ]
; NO-VP-NEXT:    [[ADD]] = add i64 [[ADD_PHI]], -1
; NO-VP-NEXT:    [[GEPL:%.*]] = getelementptr inbounds i32, ptr [[PTR:%.*]], i32 [[I]]
; NO-VP-NEXT:    [[TMP:%.*]] = load i32, ptr [[GEPL]], align 4
; NO-VP-NEXT:    [[CMP1:%.*]] = icmp slt i32 [[TMP]], 100
; NO-VP-NEXT:    br i1 [[CMP1]], label [[IF_THEN:%.*]], label [[FOR_INC]]
; NO-VP:       if.then:
; NO-VP-NEXT:    [[GEPL1:%.*]] = getelementptr inbounds i32, ptr [[PTR1:%.*]], i64 [[ADD]]
; NO-VP-NEXT:    [[V:%.*]] = load i32, ptr [[GEPL1]], align 4
; NO-VP-NEXT:    [[GEPS:%.*]] = getelementptr inbounds i32, ptr [[PTR2:%.*]], i64 [[ADD]]
; NO-VP-NEXT:    store i32 [[V]], ptr [[GEPS]], align 4
; NO-VP-NEXT:    br label [[FOR_INC]]
; NO-VP:       for.inc:
; NO-VP-NEXT:    [[INC]] = add i32 [[I]], 1
; NO-VP-NEXT:    [[EXITCOND:%.*]] = icmp ne i32 [[INC]], 1024
; NO-VP-NEXT:    br i1 [[EXITCOND]], label [[FOR_BODY]], label [[LOOPEND:%.*]]
; NO-VP:       loopend:
; NO-VP-NEXT:    ret void
;
entry:
  br label %for.body

for.body:
  %add.phi = phi i64 [ %startval, %entry ], [ %add, %for.inc ]
  %i = phi i32 [ 0, %entry ], [ %inc, %for.inc ]
  %add = add i64 %add.phi, -1
  %gepl = getelementptr inbounds i32, ptr %ptr, i32 %i
  %tmp = load i32, ptr %gepl, align 4
  %cmp1 = icmp slt i32 %tmp, 100
  br i1 %cmp1, label %if.then, label %for.inc

if.then:
  %gepl1 = getelementptr inbounds i32, ptr %ptr1, i64 %add
  %v = load i32, ptr %gepl1, align 4
  %geps = getelementptr inbounds i32, ptr %ptr2, i64 %add
  store i32 %v, ptr %geps, align 4
  br label %for.inc

for.inc:
  %inc = add i32 %i, 1
  %exitcond = icmp ne i32 %inc, 1024
  br i1 %exitcond, label %for.body, label %loopend

loopend:
  ret void
}

