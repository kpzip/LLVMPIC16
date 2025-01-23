; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=loop-vectorize -prefer-predicate-over-epilogue=predicate-else-scalar-epilogue -force-vector-interleave=4 -force-vector-width=4 < %s | FileCheck %s

target triple = "aarch64-unknown-linux-gnu"


define void @simple_memset(i32 %val, ptr %ptr, i64 %n) #0 {
; CHECK-LABEL: @simple_memset(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[UMAX:%.*]] = call i64 @llvm.umax.i64(i64 [[N:%.*]], i64 1)
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[TMP0:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP1:%.*]] = mul i64 [[TMP0]], 16
; CHECK-NEXT:    [[TMP4:%.*]] = sub i64 [[TMP1]], 1
; CHECK-NEXT:    [[N_RND_UP:%.*]] = add i64 [[UMAX]], [[TMP4]]
; CHECK-NEXT:    [[N_MOD_VF:%.*]] = urem i64 [[N_RND_UP]], [[TMP1]]
; CHECK-NEXT:    [[N_VEC:%.*]] = sub i64 [[N_RND_UP]], [[N_MOD_VF]]
; CHECK-NEXT:    [[TMP61:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP62:%.*]] = mul i64 [[TMP61]], 16
; CHECK-NEXT:    [[TMP5:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP6:%.*]] = mul i64 [[TMP5]], 16
; CHECK-NEXT:    [[TMP7:%.*]] = sub i64 [[UMAX]], [[TMP6]]
; CHECK-NEXT:    [[TMP8:%.*]] = icmp ugt i64 [[UMAX]], [[TMP6]]
; CHECK-NEXT:    [[TMP9:%.*]] = select i1 [[TMP8]], i64 [[TMP7]], i64 0
; CHECK-NEXT:    [[TMP25:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP26:%.*]] = mul i64 [[TMP25]], 4
; CHECK-NEXT:    [[INDEX_PART_NEXT:%.*]] = add i64 0, [[TMP26]]
; CHECK-NEXT:    [[TMP27:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP28:%.*]] = mul i64 [[TMP27]], 8
; CHECK-NEXT:    [[INDEX_PART_NEXT1:%.*]] = add i64 0, [[TMP28]]
; CHECK-NEXT:    [[TMP29:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP30:%.*]] = mul i64 [[TMP29]], 12
; CHECK-NEXT:    [[INDEX_PART_NEXT2:%.*]] = add i64 0, [[TMP30]]
; CHECK-NEXT:    [[ACTIVE_LANE_MASK_ENTRY:%.*]] = call <vscale x 4 x i1> @llvm.get.active.lane.mask.nxv4i1.i64(i64 0, i64 [[UMAX]])
; CHECK-NEXT:    [[ACTIVE_LANE_MASK_ENTRY3:%.*]] = call <vscale x 4 x i1> @llvm.get.active.lane.mask.nxv4i1.i64(i64 [[INDEX_PART_NEXT]], i64 [[UMAX]])
; CHECK-NEXT:    [[ACTIVE_LANE_MASK_ENTRY4:%.*]] = call <vscale x 4 x i1> @llvm.get.active.lane.mask.nxv4i1.i64(i64 [[INDEX_PART_NEXT1]], i64 [[UMAX]])
; CHECK-NEXT:    [[ACTIVE_LANE_MASK_ENTRY5:%.*]] = call <vscale x 4 x i1> @llvm.get.active.lane.mask.nxv4i1.i64(i64 [[INDEX_PART_NEXT2]], i64 [[UMAX]])
; CHECK-NEXT:    [[BROADCAST_SPLATINSERT:%.*]] = insertelement <vscale x 4 x i32> poison, i32 [[VAL:%.*]], i64 0
; CHECK-NEXT:    [[BROADCAST_SPLAT:%.*]] = shufflevector <vscale x 4 x i32> [[BROADCAST_SPLATINSERT]], <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX6:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT10:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[ACTIVE_LANE_MASK:%.*]] = phi <vscale x 4 x i1> [ [[ACTIVE_LANE_MASK_ENTRY]], [[VECTOR_PH]] ], [ [[ACTIVE_LANE_MASK_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[ACTIVE_LANE_MASK7:%.*]] = phi <vscale x 4 x i1> [ [[ACTIVE_LANE_MASK_ENTRY3]], [[VECTOR_PH]] ], [ [[ACTIVE_LANE_MASK_NEXT11:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[ACTIVE_LANE_MASK8:%.*]] = phi <vscale x 4 x i1> [ [[ACTIVE_LANE_MASK_ENTRY4]], [[VECTOR_PH]] ], [ [[ACTIVE_LANE_MASK_NEXT12:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[ACTIVE_LANE_MASK9:%.*]] = phi <vscale x 4 x i1> [ [[ACTIVE_LANE_MASK_ENTRY5]], [[VECTOR_PH]] ], [ [[ACTIVE_LANE_MASK_NEXT13:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP31:%.*]] = add i64 [[INDEX6]], 0
; CHECK-NEXT:    [[TMP32:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP33:%.*]] = mul i64 [[TMP32]], 4
; CHECK-NEXT:    [[TMP34:%.*]] = add i64 [[TMP33]], 0
; CHECK-NEXT:    [[TMP35:%.*]] = mul i64 [[TMP34]], 1
; CHECK-NEXT:    [[TMP36:%.*]] = add i64 [[INDEX6]], [[TMP35]]
; CHECK-NEXT:    [[TMP37:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP38:%.*]] = mul i64 [[TMP37]], 8
; CHECK-NEXT:    [[TMP39:%.*]] = add i64 [[TMP38]], 0
; CHECK-NEXT:    [[TMP40:%.*]] = mul i64 [[TMP39]], 1
; CHECK-NEXT:    [[TMP41:%.*]] = add i64 [[INDEX6]], [[TMP40]]
; CHECK-NEXT:    [[TMP42:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP43:%.*]] = mul i64 [[TMP42]], 12
; CHECK-NEXT:    [[TMP44:%.*]] = add i64 [[TMP43]], 0
; CHECK-NEXT:    [[TMP45:%.*]] = mul i64 [[TMP44]], 1
; CHECK-NEXT:    [[TMP46:%.*]] = add i64 [[INDEX6]], [[TMP45]]
; CHECK-NEXT:    [[TMP47:%.*]] = getelementptr i32, ptr [[PTR:%.*]], i64 [[TMP31]]
; CHECK-NEXT:    [[TMP48:%.*]] = getelementptr i32, ptr [[PTR]], i64 [[TMP36]]
; CHECK-NEXT:    [[TMP49:%.*]] = getelementptr i32, ptr [[PTR]], i64 [[TMP41]]
; CHECK-NEXT:    [[TMP50:%.*]] = getelementptr i32, ptr [[PTR]], i64 [[TMP46]]
; CHECK-NEXT:    [[TMP51:%.*]] = getelementptr i32, ptr [[TMP47]], i32 0
; CHECK-NEXT:    [[TMP52:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP53:%.*]] = mul i64 [[TMP52]], 4
; CHECK-NEXT:    [[TMP54:%.*]] = getelementptr i32, ptr [[TMP47]], i64 [[TMP53]]
; CHECK-NEXT:    [[TMP55:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP56:%.*]] = mul i64 [[TMP55]], 8
; CHECK-NEXT:    [[TMP57:%.*]] = getelementptr i32, ptr [[TMP47]], i64 [[TMP56]]
; CHECK-NEXT:    [[TMP58:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP59:%.*]] = mul i64 [[TMP58]], 12
; CHECK-NEXT:    [[TMP60:%.*]] = getelementptr i32, ptr [[TMP47]], i64 [[TMP59]]
; CHECK-NEXT:    call void @llvm.masked.store.nxv4i32.p0(<vscale x 4 x i32> [[BROADCAST_SPLAT]], ptr [[TMP51]], i32 4, <vscale x 4 x i1> [[ACTIVE_LANE_MASK]])
; CHECK-NEXT:    call void @llvm.masked.store.nxv4i32.p0(<vscale x 4 x i32> [[BROADCAST_SPLAT]], ptr [[TMP54]], i32 4, <vscale x 4 x i1> [[ACTIVE_LANE_MASK7]])
; CHECK-NEXT:    call void @llvm.masked.store.nxv4i32.p0(<vscale x 4 x i32> [[BROADCAST_SPLAT]], ptr [[TMP57]], i32 4, <vscale x 4 x i1> [[ACTIVE_LANE_MASK8]])
; CHECK-NEXT:    call void @llvm.masked.store.nxv4i32.p0(<vscale x 4 x i32> [[BROADCAST_SPLAT]], ptr [[TMP60]], i32 4, <vscale x 4 x i1> [[ACTIVE_LANE_MASK9]])
; CHECK-NEXT:    [[INDEX_NEXT10]] = add i64 [[INDEX6]], [[TMP62]]
; CHECK-NEXT:    [[TMP63:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP64:%.*]] = mul i64 [[TMP63]], 4
; CHECK-NEXT:    [[TMP65:%.*]] = add i64 [[INDEX6]], [[TMP64]]
; CHECK-NEXT:    [[TMP66:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP67:%.*]] = mul i64 [[TMP66]], 8
; CHECK-NEXT:    [[TMP68:%.*]] = add i64 [[INDEX6]], [[TMP67]]
; CHECK-NEXT:    [[TMP69:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP70:%.*]] = mul i64 [[TMP69]], 12
; CHECK-NEXT:    [[TMP71:%.*]] = add i64 [[INDEX6]], [[TMP70]]
; CHECK-NEXT:    [[ACTIVE_LANE_MASK_NEXT]] = call <vscale x 4 x i1> @llvm.get.active.lane.mask.nxv4i1.i64(i64 [[INDEX6]], i64 [[TMP9]])
; CHECK-NEXT:    [[ACTIVE_LANE_MASK_NEXT11]] = call <vscale x 4 x i1> @llvm.get.active.lane.mask.nxv4i1.i64(i64 [[TMP65]], i64 [[TMP9]])
; CHECK-NEXT:    [[ACTIVE_LANE_MASK_NEXT12]] = call <vscale x 4 x i1> @llvm.get.active.lane.mask.nxv4i1.i64(i64 [[TMP68]], i64 [[TMP9]])
; CHECK-NEXT:    [[ACTIVE_LANE_MASK_NEXT13]] = call <vscale x 4 x i1> @llvm.get.active.lane.mask.nxv4i1.i64(i64 [[TMP71]], i64 [[TMP9]])
; CHECK-NEXT:    [[TMP72:%.*]] = xor <vscale x 4 x i1> [[ACTIVE_LANE_MASK_NEXT]], shufflevector (<vscale x 4 x i1> insertelement (<vscale x 4 x i1> poison, i1 true, i64 0), <vscale x 4 x i1> poison, <vscale x 4 x i32> zeroinitializer)
; CHECK-NEXT:    [[TMP76:%.*]] = extractelement <vscale x 4 x i1> [[TMP72]], i32 0
; CHECK-NEXT:    br i1 [[TMP76]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    br i1 true, label [[WHILE_END_LOOPEXIT:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ [[N_VEC]], [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    br label [[WHILE_BODY:%.*]]
; CHECK:       while.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ [[INDEX_NEXT:%.*]], [[WHILE_BODY]] ], [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ]
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr i32, ptr [[PTR]], i64 [[INDEX]]
; CHECK-NEXT:    store i32 [[VAL]], ptr [[GEP]], align 4
; CHECK-NEXT:    [[INDEX_NEXT]] = add nsw i64 [[INDEX]], 1
; CHECK-NEXT:    [[CMP10:%.*]] = icmp ult i64 [[INDEX_NEXT]], [[N]]
; CHECK-NEXT:    br i1 [[CMP10]], label [[WHILE_BODY]], label [[WHILE_END_LOOPEXIT]], !llvm.loop [[LOOP3:![0-9]+]]
; CHECK:       while.end.loopexit:
; CHECK-NEXT:    ret void
;
entry:
  br label %while.body

while.body:                                       ; preds = %while.body, %entry
  %index = phi i64 [ %index.next, %while.body ], [ 0, %entry ]
  %gep = getelementptr i32, ptr %ptr, i64 %index
  store i32 %val, ptr %gep
  %index.next = add nsw i64 %index, 1
  %cmp10 = icmp ult i64 %index.next, %n
  br i1 %cmp10, label %while.body, label %while.end.loopexit, !llvm.loop !0

while.end.loopexit:                               ; preds = %while.body
  ret void
}

define void @cond_memset(i32 %val, ptr noalias readonly %cond_ptr, ptr noalias %ptr, i64 %n) #0 {
; CHECK-LABEL: @cond_memset(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[UMAX:%.*]] = call i64 @llvm.umax.i64(i64 [[N:%.*]], i64 1)
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[TMP0:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP1:%.*]] = mul i64 [[TMP0]], 16
; CHECK-NEXT:    [[TMP4:%.*]] = sub i64 [[TMP1]], 1
; CHECK-NEXT:    [[N_RND_UP:%.*]] = add i64 [[UMAX]], [[TMP4]]
; CHECK-NEXT:    [[N_MOD_VF:%.*]] = urem i64 [[N_RND_UP]], [[TMP1]]
; CHECK-NEXT:    [[N_VEC:%.*]] = sub i64 [[N_RND_UP]], [[N_MOD_VF]]
; CHECK-NEXT:    [[TMP83:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP84:%.*]] = mul i64 [[TMP83]], 16
; CHECK-NEXT:    [[TMP5:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP6:%.*]] = mul i64 [[TMP5]], 16
; CHECK-NEXT:    [[TMP7:%.*]] = sub i64 [[UMAX]], [[TMP6]]
; CHECK-NEXT:    [[TMP8:%.*]] = icmp ugt i64 [[UMAX]], [[TMP6]]
; CHECK-NEXT:    [[TMP9:%.*]] = select i1 [[TMP8]], i64 [[TMP7]], i64 0
; CHECK-NEXT:    [[TMP25:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP26:%.*]] = mul i64 [[TMP25]], 4
; CHECK-NEXT:    [[INDEX_PART_NEXT:%.*]] = add i64 0, [[TMP26]]
; CHECK-NEXT:    [[TMP27:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP28:%.*]] = mul i64 [[TMP27]], 8
; CHECK-NEXT:    [[INDEX_PART_NEXT1:%.*]] = add i64 0, [[TMP28]]
; CHECK-NEXT:    [[TMP29:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP30:%.*]] = mul i64 [[TMP29]], 12
; CHECK-NEXT:    [[INDEX_PART_NEXT2:%.*]] = add i64 0, [[TMP30]]
; CHECK-NEXT:    [[ACTIVE_LANE_MASK_ENTRY:%.*]] = call <vscale x 4 x i1> @llvm.get.active.lane.mask.nxv4i1.i64(i64 0, i64 [[UMAX]])
; CHECK-NEXT:    [[ACTIVE_LANE_MASK_ENTRY3:%.*]] = call <vscale x 4 x i1> @llvm.get.active.lane.mask.nxv4i1.i64(i64 [[INDEX_PART_NEXT]], i64 [[UMAX]])
; CHECK-NEXT:    [[ACTIVE_LANE_MASK_ENTRY4:%.*]] = call <vscale x 4 x i1> @llvm.get.active.lane.mask.nxv4i1.i64(i64 [[INDEX_PART_NEXT1]], i64 [[UMAX]])
; CHECK-NEXT:    [[ACTIVE_LANE_MASK_ENTRY5:%.*]] = call <vscale x 4 x i1> @llvm.get.active.lane.mask.nxv4i1.i64(i64 [[INDEX_PART_NEXT2]], i64 [[UMAX]])
; CHECK-NEXT:    [[BROADCAST_SPLATINSERT:%.*]] = insertelement <vscale x 4 x i32> poison, i32 [[VAL:%.*]], i64 0
; CHECK-NEXT:    [[BROADCAST_SPLAT:%.*]] = shufflevector <vscale x 4 x i32> [[BROADCAST_SPLATINSERT]], <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX6:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT13:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[ACTIVE_LANE_MASK:%.*]] = phi <vscale x 4 x i1> [ [[ACTIVE_LANE_MASK_ENTRY]], [[VECTOR_PH]] ], [ [[ACTIVE_LANE_MASK_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[ACTIVE_LANE_MASK7:%.*]] = phi <vscale x 4 x i1> [ [[ACTIVE_LANE_MASK_ENTRY3]], [[VECTOR_PH]] ], [ [[ACTIVE_LANE_MASK_NEXT14:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[ACTIVE_LANE_MASK8:%.*]] = phi <vscale x 4 x i1> [ [[ACTIVE_LANE_MASK_ENTRY4]], [[VECTOR_PH]] ], [ [[ACTIVE_LANE_MASK_NEXT15:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[ACTIVE_LANE_MASK9:%.*]] = phi <vscale x 4 x i1> [ [[ACTIVE_LANE_MASK_ENTRY5]], [[VECTOR_PH]] ], [ [[ACTIVE_LANE_MASK_NEXT16:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP31:%.*]] = add i64 [[INDEX6]], 0
; CHECK-NEXT:    [[TMP32:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP33:%.*]] = mul i64 [[TMP32]], 4
; CHECK-NEXT:    [[TMP34:%.*]] = add i64 [[TMP33]], 0
; CHECK-NEXT:    [[TMP35:%.*]] = mul i64 [[TMP34]], 1
; CHECK-NEXT:    [[TMP36:%.*]] = add i64 [[INDEX6]], [[TMP35]]
; CHECK-NEXT:    [[TMP37:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP38:%.*]] = mul i64 [[TMP37]], 8
; CHECK-NEXT:    [[TMP39:%.*]] = add i64 [[TMP38]], 0
; CHECK-NEXT:    [[TMP40:%.*]] = mul i64 [[TMP39]], 1
; CHECK-NEXT:    [[TMP41:%.*]] = add i64 [[INDEX6]], [[TMP40]]
; CHECK-NEXT:    [[TMP42:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP43:%.*]] = mul i64 [[TMP42]], 12
; CHECK-NEXT:    [[TMP44:%.*]] = add i64 [[TMP43]], 0
; CHECK-NEXT:    [[TMP45:%.*]] = mul i64 [[TMP44]], 1
; CHECK-NEXT:    [[TMP46:%.*]] = add i64 [[INDEX6]], [[TMP45]]
; CHECK-NEXT:    [[TMP47:%.*]] = getelementptr i32, ptr [[COND_PTR:%.*]], i64 [[TMP31]]
; CHECK-NEXT:    [[TMP48:%.*]] = getelementptr i32, ptr [[COND_PTR]], i64 [[TMP36]]
; CHECK-NEXT:    [[TMP49:%.*]] = getelementptr i32, ptr [[COND_PTR]], i64 [[TMP41]]
; CHECK-NEXT:    [[TMP50:%.*]] = getelementptr i32, ptr [[COND_PTR]], i64 [[TMP46]]
; CHECK-NEXT:    [[TMP51:%.*]] = getelementptr i32, ptr [[TMP47]], i32 0
; CHECK-NEXT:    [[TMP52:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP53:%.*]] = mul i64 [[TMP52]], 4
; CHECK-NEXT:    [[TMP54:%.*]] = getelementptr i32, ptr [[TMP47]], i64 [[TMP53]]
; CHECK-NEXT:    [[TMP55:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP56:%.*]] = mul i64 [[TMP55]], 8
; CHECK-NEXT:    [[TMP57:%.*]] = getelementptr i32, ptr [[TMP47]], i64 [[TMP56]]
; CHECK-NEXT:    [[TMP58:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP59:%.*]] = mul i64 [[TMP58]], 12
; CHECK-NEXT:    [[TMP60:%.*]] = getelementptr i32, ptr [[TMP47]], i64 [[TMP59]]
; CHECK-NEXT:    [[WIDE_MASKED_LOAD:%.*]] = call <vscale x 4 x i32> @llvm.masked.load.nxv4i32.p0(ptr [[TMP51]], i32 4, <vscale x 4 x i1> [[ACTIVE_LANE_MASK]], <vscale x 4 x i32> poison)
; CHECK-NEXT:    [[WIDE_MASKED_LOAD10:%.*]] = call <vscale x 4 x i32> @llvm.masked.load.nxv4i32.p0(ptr [[TMP54]], i32 4, <vscale x 4 x i1> [[ACTIVE_LANE_MASK7]], <vscale x 4 x i32> poison)
; CHECK-NEXT:    [[WIDE_MASKED_LOAD11:%.*]] = call <vscale x 4 x i32> @llvm.masked.load.nxv4i32.p0(ptr [[TMP57]], i32 4, <vscale x 4 x i1> [[ACTIVE_LANE_MASK8]], <vscale x 4 x i32> poison)
; CHECK-NEXT:    [[WIDE_MASKED_LOAD12:%.*]] = call <vscale x 4 x i32> @llvm.masked.load.nxv4i32.p0(ptr [[TMP60]], i32 4, <vscale x 4 x i1> [[ACTIVE_LANE_MASK9]], <vscale x 4 x i32> poison)
; CHECK-NEXT:    [[TMP61:%.*]] = icmp ne <vscale x 4 x i32> [[WIDE_MASKED_LOAD]], zeroinitializer
; CHECK-NEXT:    [[TMP62:%.*]] = icmp ne <vscale x 4 x i32> [[WIDE_MASKED_LOAD10]], zeroinitializer
; CHECK-NEXT:    [[TMP63:%.*]] = icmp ne <vscale x 4 x i32> [[WIDE_MASKED_LOAD11]], zeroinitializer
; CHECK-NEXT:    [[TMP64:%.*]] = icmp ne <vscale x 4 x i32> [[WIDE_MASKED_LOAD12]], zeroinitializer
; CHECK-NEXT:    [[TMP69:%.*]] = select <vscale x 4 x i1> [[ACTIVE_LANE_MASK]], <vscale x 4 x i1> [[TMP61]], <vscale x 4 x i1> zeroinitializer
; CHECK-NEXT:    [[TMP70:%.*]] = select <vscale x 4 x i1> [[ACTIVE_LANE_MASK7]], <vscale x 4 x i1> [[TMP62]], <vscale x 4 x i1> zeroinitializer
; CHECK-NEXT:    [[TMP71:%.*]] = select <vscale x 4 x i1> [[ACTIVE_LANE_MASK8]], <vscale x 4 x i1> [[TMP63]], <vscale x 4 x i1> zeroinitializer
; CHECK-NEXT:    [[TMP72:%.*]] = select <vscale x 4 x i1> [[ACTIVE_LANE_MASK9]], <vscale x 4 x i1> [[TMP64]], <vscale x 4 x i1> zeroinitializer
; CHECK-NEXT:    [[TMP65:%.*]] = getelementptr i32, ptr [[PTR:%.*]], i64 [[TMP31]]
; CHECK-NEXT:    [[TMP66:%.*]] = getelementptr i32, ptr [[PTR]], i64 [[TMP36]]
; CHECK-NEXT:    [[TMP67:%.*]] = getelementptr i32, ptr [[PTR]], i64 [[TMP41]]
; CHECK-NEXT:    [[TMP68:%.*]] = getelementptr i32, ptr [[PTR]], i64 [[TMP46]]
; CHECK-NEXT:    [[TMP73:%.*]] = getelementptr i32, ptr [[TMP65]], i32 0
; CHECK-NEXT:    [[TMP74:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP75:%.*]] = mul i64 [[TMP74]], 4
; CHECK-NEXT:    [[TMP76:%.*]] = getelementptr i32, ptr [[TMP65]], i64 [[TMP75]]
; CHECK-NEXT:    [[TMP77:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP78:%.*]] = mul i64 [[TMP77]], 8
; CHECK-NEXT:    [[TMP79:%.*]] = getelementptr i32, ptr [[TMP65]], i64 [[TMP78]]
; CHECK-NEXT:    [[TMP80:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP81:%.*]] = mul i64 [[TMP80]], 12
; CHECK-NEXT:    [[TMP82:%.*]] = getelementptr i32, ptr [[TMP65]], i64 [[TMP81]]
; CHECK-NEXT:    call void @llvm.masked.store.nxv4i32.p0(<vscale x 4 x i32> [[BROADCAST_SPLAT]], ptr [[TMP73]], i32 4, <vscale x 4 x i1> [[TMP69]])
; CHECK-NEXT:    call void @llvm.masked.store.nxv4i32.p0(<vscale x 4 x i32> [[BROADCAST_SPLAT]], ptr [[TMP76]], i32 4, <vscale x 4 x i1> [[TMP70]])
; CHECK-NEXT:    call void @llvm.masked.store.nxv4i32.p0(<vscale x 4 x i32> [[BROADCAST_SPLAT]], ptr [[TMP79]], i32 4, <vscale x 4 x i1> [[TMP71]])
; CHECK-NEXT:    call void @llvm.masked.store.nxv4i32.p0(<vscale x 4 x i32> [[BROADCAST_SPLAT]], ptr [[TMP82]], i32 4, <vscale x 4 x i1> [[TMP72]])
; CHECK-NEXT:    [[INDEX_NEXT13]] = add i64 [[INDEX6]], [[TMP84]]
; CHECK-NEXT:    [[TMP85:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP86:%.*]] = mul i64 [[TMP85]], 4
; CHECK-NEXT:    [[TMP87:%.*]] = add i64 [[INDEX6]], [[TMP86]]
; CHECK-NEXT:    [[TMP88:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP89:%.*]] = mul i64 [[TMP88]], 8
; CHECK-NEXT:    [[TMP90:%.*]] = add i64 [[INDEX6]], [[TMP89]]
; CHECK-NEXT:    [[TMP91:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP92:%.*]] = mul i64 [[TMP91]], 12
; CHECK-NEXT:    [[TMP93:%.*]] = add i64 [[INDEX6]], [[TMP92]]
; CHECK-NEXT:    [[ACTIVE_LANE_MASK_NEXT]] = call <vscale x 4 x i1> @llvm.get.active.lane.mask.nxv4i1.i64(i64 [[INDEX6]], i64 [[TMP9]])
; CHECK-NEXT:    [[ACTIVE_LANE_MASK_NEXT14]] = call <vscale x 4 x i1> @llvm.get.active.lane.mask.nxv4i1.i64(i64 [[TMP87]], i64 [[TMP9]])
; CHECK-NEXT:    [[ACTIVE_LANE_MASK_NEXT15]] = call <vscale x 4 x i1> @llvm.get.active.lane.mask.nxv4i1.i64(i64 [[TMP90]], i64 [[TMP9]])
; CHECK-NEXT:    [[ACTIVE_LANE_MASK_NEXT16]] = call <vscale x 4 x i1> @llvm.get.active.lane.mask.nxv4i1.i64(i64 [[TMP93]], i64 [[TMP9]])
; CHECK-NEXT:    [[TMP94:%.*]] = xor <vscale x 4 x i1> [[ACTIVE_LANE_MASK_NEXT]], shufflevector (<vscale x 4 x i1> insertelement (<vscale x 4 x i1> poison, i1 true, i64 0), <vscale x 4 x i1> poison, <vscale x 4 x i32> zeroinitializer)
; CHECK-NEXT:    [[TMP98:%.*]] = extractelement <vscale x 4 x i1> [[TMP94]], i32 0
; CHECK-NEXT:    br i1 [[TMP98]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP4:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    br i1 true, label [[WHILE_END_LOOPEXIT:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ [[N_VEC]], [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    br label [[WHILE_BODY:%.*]]
; CHECK:       while.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ [[INDEX_NEXT:%.*]], [[WHILE_END:%.*]] ], [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ]
; CHECK-NEXT:    [[COND_GEP:%.*]] = getelementptr i32, ptr [[COND_PTR]], i64 [[INDEX]]
; CHECK-NEXT:    [[COND_I32:%.*]] = load i32, ptr [[COND_GEP]], align 4
; CHECK-NEXT:    [[COND_I1:%.*]] = icmp ne i32 [[COND_I32]], 0
; CHECK-NEXT:    br i1 [[COND_I1]], label [[DO_STORE:%.*]], label [[WHILE_END]]
; CHECK:       do.store:
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr i32, ptr [[PTR]], i64 [[INDEX]]
; CHECK-NEXT:    store i32 [[VAL]], ptr [[GEP]], align 4
; CHECK-NEXT:    br label [[WHILE_END]]
; CHECK:       while.end:
; CHECK-NEXT:    [[INDEX_NEXT]] = add nsw i64 [[INDEX]], 1
; CHECK-NEXT:    [[CMP10:%.*]] = icmp ult i64 [[INDEX_NEXT]], [[N]]
; CHECK-NEXT:    br i1 [[CMP10]], label [[WHILE_BODY]], label [[WHILE_END_LOOPEXIT]], !llvm.loop [[LOOP5:![0-9]+]]
; CHECK:       while.end.loopexit:
; CHECK-NEXT:    ret void
;
entry:
  br label %while.body

while.body:                                       ; preds = %while.body, %entry
  %index = phi i64 [ %index.next, %while.end ], [ 0, %entry ]
  %cond_gep = getelementptr i32, ptr %cond_ptr, i64 %index
  %cond_i32 = load i32, ptr %cond_gep
  %cond_i1 = icmp ne i32 %cond_i32, 0
  br i1 %cond_i1, label %do.store, label %while.end

do.store:
  %gep = getelementptr i32, ptr %ptr, i64 %index
  store i32 %val, ptr %gep
  br label %while.end

while.end:
  %index.next = add nsw i64 %index, 1
  %cmp10 = icmp ult i64 %index.next, %n
  br i1 %cmp10, label %while.body, label %while.end.loopexit, !llvm.loop !0

while.end.loopexit:                               ; preds = %while.body
  ret void
}

!0 = distinct !{!0, !1}
!1 = !{!"llvm.loop.vectorize.scalable.enable", i1 true}

attributes #0 = { "target-features"="+sve" }
