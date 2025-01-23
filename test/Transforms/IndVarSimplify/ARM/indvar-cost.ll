; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=indvars -mtriple=thumbv8m.base -S %s -o - | FileCheck %s --check-prefix=CHECK-T1
; RUN: opt -passes=indvars -mtriple=thumbv8m.main -S %s -o - | FileCheck %s --check-prefix=CHECK-T2

define dso_local arm_aapcscc void @arm_conv_fast_q15(ptr %pSrcA, i32 %srcALen, ptr %pSrcB, i32 %srcBLen, ptr %pDst, ptr %store.px, ptr %store.py, ptr %store.res) local_unnamed_addr {
; CHECK-T1-LABEL: @arm_conv_fast_q15(
; CHECK-T1-NEXT:  entry:
; CHECK-T1-NEXT:    [[CMP:%.*]] = icmp ult i32 [[SRCALEN:%.*]], [[SRCBLEN:%.*]]
; CHECK-T1-NEXT:    [[SRCALEN_SRCBLEN:%.*]] = select i1 [[CMP]], i32 [[SRCALEN]], i32 [[SRCBLEN]]
; CHECK-T1-NEXT:    [[PSRCB_PSRCA:%.*]] = select i1 [[CMP]], ptr [[PSRCB:%.*]], ptr [[PSRCA:%.*]]
; CHECK-T1-NEXT:    [[PSRCA_PSRCB:%.*]] = select i1 [[CMP]], ptr [[PSRCA]], ptr [[PSRCB]]
; CHECK-T1-NEXT:    [[SUB:%.*]] = add i32 [[SRCALEN_SRCBLEN]], -1
; CHECK-T1-NEXT:    [[CMP41080:%.*]] = icmp eq i32 [[SUB]], 0
; CHECK-T1-NEXT:    br i1 [[CMP41080]], label [[WHILE_END13:%.*]], label [[WHILE_COND5_PREHEADER_PREHEADER:%.*]]
; CHECK-T1:       while.cond5.preheader.preheader:
; CHECK-T1-NEXT:    [[TMP0:%.*]] = add i32 [[SRCALEN_SRCBLEN]], -2
; CHECK-T1-NEXT:    [[UMIN:%.*]] = call i32 @llvm.umin.i32(i32 [[TMP0]], i32 2)
; CHECK-T1-NEXT:    [[TMP1:%.*]] = add nuw nsw i32 [[UMIN]], 2
; CHECK-T1-NEXT:    br label [[WHILE_COND5_PREHEADER:%.*]]
; CHECK-T1:       while.cond5.preheader:
; CHECK-T1-NEXT:    [[COUNT_01084:%.*]] = phi i32 [ [[INC:%.*]], [[WHILE_END:%.*]] ], [ 1, [[WHILE_COND5_PREHEADER_PREHEADER]] ]
; CHECK-T1-NEXT:    [[BLOCKSIZE1_01083:%.*]] = phi i32 [ [[DEC12:%.*]], [[WHILE_END]] ], [ [[SUB]], [[WHILE_COND5_PREHEADER_PREHEADER]] ]
; CHECK-T1-NEXT:    [[PY_01082:%.*]] = phi ptr [ [[ADD_PTR:%.*]], [[WHILE_END]] ], [ [[PSRCA_PSRCB]], [[WHILE_COND5_PREHEADER_PREHEADER]] ]
; CHECK-T1-NEXT:    [[POUT_01081:%.*]] = phi ptr [ [[INCDEC_PTR11:%.*]], [[WHILE_END]] ], [ [[PDST:%.*]], [[WHILE_COND5_PREHEADER_PREHEADER]] ]
; CHECK-T1-NEXT:    br label [[WHILE_BODY7:%.*]]
; CHECK-T1:       while.body7:
; CHECK-T1-NEXT:    [[K_01078:%.*]] = phi i32 [ [[DEC:%.*]], [[WHILE_BODY7]] ], [ [[COUNT_01084]], [[WHILE_COND5_PREHEADER]] ]
; CHECK-T1-NEXT:    [[SUM_01077:%.*]] = phi i32 [ [[ADD6_I:%.*]], [[WHILE_BODY7]] ], [ 0, [[WHILE_COND5_PREHEADER]] ]
; CHECK-T1-NEXT:    [[PY_11076:%.*]] = phi ptr [ [[INCDEC_PTR8:%.*]], [[WHILE_BODY7]] ], [ [[PY_01082]], [[WHILE_COND5_PREHEADER]] ]
; CHECK-T1-NEXT:    [[PX_11075:%.*]] = phi ptr [ [[INCDEC_PTR:%.*]], [[WHILE_BODY7]] ], [ [[PSRCB_PSRCA]], [[WHILE_COND5_PREHEADER]] ]
; CHECK-T1-NEXT:    [[INCDEC_PTR]] = getelementptr inbounds i16, ptr [[PX_11075]], i32 1
; CHECK-T1-NEXT:    [[TMP2:%.*]] = load i16, ptr [[PX_11075]], align 2
; CHECK-T1-NEXT:    [[CONV:%.*]] = sext i16 [[TMP2]] to i32
; CHECK-T1-NEXT:    [[INCDEC_PTR8]] = getelementptr inbounds i16, ptr [[PY_11076]], i32 -1
; CHECK-T1-NEXT:    [[TMP3:%.*]] = load i16, ptr [[PY_11076]], align 2
; CHECK-T1-NEXT:    [[CONV9:%.*]] = sext i16 [[TMP3]] to i32
; CHECK-T1-NEXT:    [[MUL_I:%.*]] = mul nsw i32 [[CONV9]], [[CONV]]
; CHECK-T1-NEXT:    [[SHR3_I:%.*]] = ashr i32 [[CONV]], 16
; CHECK-T1-NEXT:    [[SHR4_I:%.*]] = ashr i32 [[CONV9]], 16
; CHECK-T1-NEXT:    [[MUL5_I:%.*]] = mul nsw i32 [[SHR4_I]], [[SHR3_I]]
; CHECK-T1-NEXT:    [[ADD_I:%.*]] = add i32 [[MUL_I]], [[SUM_01077]]
; CHECK-T1-NEXT:    [[ADD6_I]] = add i32 [[ADD_I]], [[MUL5_I]]
; CHECK-T1-NEXT:    [[DEC]] = add nsw i32 [[K_01078]], -1
; CHECK-T1-NEXT:    [[CMP6:%.*]] = icmp eq i32 [[DEC]], 0
; CHECK-T1-NEXT:    br i1 [[CMP6]], label [[WHILE_END]], label [[WHILE_BODY7]]
; CHECK-T1:       while.end:
; CHECK-T1-NEXT:    [[ADD6_I_LCSSA:%.*]] = phi i32 [ [[ADD6_I]], [[WHILE_BODY7]] ]
; CHECK-T1-NEXT:    [[TMP4:%.*]] = lshr i32 [[ADD6_I_LCSSA]], 15
; CHECK-T1-NEXT:    [[CONV10:%.*]] = trunc i32 [[TMP4]] to i16
; CHECK-T1-NEXT:    [[INCDEC_PTR11]] = getelementptr inbounds i16, ptr [[POUT_01081]], i32 1
; CHECK-T1-NEXT:    store i16 [[CONV10]], ptr [[POUT_01081]], align 2
; CHECK-T1-NEXT:    [[ADD_PTR]] = getelementptr inbounds i16, ptr [[PSRCA_PSRCB]], i32 [[COUNT_01084]]
; CHECK-T1-NEXT:    [[INC]] = add nuw nsw i32 [[COUNT_01084]], 1
; CHECK-T1-NEXT:    [[DEC12]] = add i32 [[BLOCKSIZE1_01083]], -1
; CHECK-T1-NEXT:    [[EXITCOND:%.*]] = icmp ne i32 [[INC]], [[TMP1]]
; CHECK-T1-NEXT:    br i1 [[EXITCOND]], label [[WHILE_COND5_PREHEADER]], label [[WHILE_END13_LOOPEXIT:%.*]]
; CHECK-T1:       while.end13.loopexit:
; CHECK-T1-NEXT:    [[INCDEC_PTR11_LCSSA:%.*]] = phi ptr [ [[INCDEC_PTR11]], [[WHILE_END]] ]
; CHECK-T1-NEXT:    [[ADD_PTR_LCSSA:%.*]] = phi ptr [ [[ADD_PTR]], [[WHILE_END]] ]
; CHECK-T1-NEXT:    [[INC_LCSSA:%.*]] = phi i32 [ [[INC]], [[WHILE_END]] ]
; CHECK-T1-NEXT:    [[DEC12_LCSSA:%.*]] = phi i32 [ [[DEC12]], [[WHILE_END]] ]
; CHECK-T1-NEXT:    br label [[WHILE_END13]]
; CHECK-T1:       while.end13:
; CHECK-T1-NEXT:    [[POUT_0_LCSSA:%.*]] = phi ptr [ [[PDST]], [[ENTRY:%.*]] ], [ [[INCDEC_PTR11_LCSSA]], [[WHILE_END13_LOOPEXIT]] ]
; CHECK-T1-NEXT:    [[PY_0_LCSSA:%.*]] = phi ptr [ [[PSRCA_PSRCB]], [[ENTRY]] ], [ [[ADD_PTR_LCSSA]], [[WHILE_END13_LOOPEXIT]] ]
; CHECK-T1-NEXT:    [[BLOCKSIZE1_0_LCSSA:%.*]] = phi i32 [ [[SUB]], [[ENTRY]] ], [ [[DEC12_LCSSA]], [[WHILE_END13_LOOPEXIT]] ]
; CHECK-T1-NEXT:    [[COUNT_0_LCSSA:%.*]] = phi i32 [ 1, [[ENTRY]] ], [ [[INC_LCSSA]], [[WHILE_END13_LOOPEXIT]] ]
; CHECK-T1-NEXT:    [[CMP161068:%.*]] = icmp eq i32 [[BLOCKSIZE1_0_LCSSA]], 0
; CHECK-T1-NEXT:    br i1 [[CMP161068]], label [[EXIT:%.*]], label [[WHILE_BODY18_PREHEADER:%.*]]
; CHECK-T1:       while.body18.preheader:
; CHECK-T1-NEXT:    [[ADD_PTR14:%.*]] = getelementptr inbounds i16, ptr [[PY_0_LCSSA]], i32 -1
; CHECK-T1-NEXT:    br label [[WHILE_BODY18:%.*]]
; CHECK-T1:       while.body18:
; CHECK-T1-NEXT:    [[COUNT_11072:%.*]] = phi i32 [ [[INC49:%.*]], [[WHILE_END43:%.*]] ], [ [[COUNT_0_LCSSA]], [[WHILE_BODY18_PREHEADER]] ]
; CHECK-T1-NEXT:    [[BLOCKSIZE1_11071:%.*]] = phi i32 [ [[DEC50:%.*]], [[WHILE_END43]] ], [ [[BLOCKSIZE1_0_LCSSA]], [[WHILE_BODY18_PREHEADER]] ]
; CHECK-T1-NEXT:    [[PY_21070:%.*]] = phi ptr [ [[ADD_PTR48:%.*]], [[WHILE_END43]] ], [ [[ADD_PTR14]], [[WHILE_BODY18_PREHEADER]] ]
; CHECK-T1-NEXT:    [[POUT_11069:%.*]] = phi ptr [ [[INCDEC_PTR46:%.*]], [[WHILE_END43]] ], [ [[POUT_0_LCSSA]], [[WHILE_BODY18_PREHEADER]] ]
; CHECK-T1-NEXT:    [[SHR19:%.*]] = lshr i32 [[COUNT_11072]], 2
; CHECK-T1-NEXT:    [[CMP211054:%.*]] = icmp eq i32 [[SHR19]], 0
; CHECK-T1-NEXT:    br i1 [[CMP211054]], label [[WHILE_END31:%.*]], label [[WHILE_BODY23_PREHEADER:%.*]]
; CHECK-T1:       while.body23.preheader:
; CHECK-T1-NEXT:    br label [[WHILE_BODY23:%.*]]
; CHECK-T1:       while.body23:
; CHECK-T1-NEXT:    [[K_11058:%.*]] = phi i32 [ [[DEC30:%.*]], [[WHILE_BODY23]] ], [ [[SHR19]], [[WHILE_BODY23_PREHEADER]] ]
; CHECK-T1-NEXT:    [[SUM_11057:%.*]] = phi i32 [ [[ADD6_I878:%.*]], [[WHILE_BODY23]] ], [ 0, [[WHILE_BODY23_PREHEADER]] ]
; CHECK-T1-NEXT:    [[PY_31056:%.*]] = phi ptr [ [[ADD_PTR_I884:%.*]], [[WHILE_BODY23]] ], [ [[PY_21070]], [[WHILE_BODY23_PREHEADER]] ]
; CHECK-T1-NEXT:    [[PX_31055:%.*]] = phi ptr [ [[ADD_PTR_I890:%.*]], [[WHILE_BODY23]] ], [ [[PSRCB_PSRCA]], [[WHILE_BODY23_PREHEADER]] ]
; CHECK-T1-NEXT:    [[ARRAYIDX_I907:%.*]] = getelementptr inbounds i16, ptr [[PX_31055]], i32 1
; CHECK-T1-NEXT:    [[TMP5:%.*]] = load i16, ptr [[ARRAYIDX_I907]], align 2
; CHECK-T1-NEXT:    [[TMP6:%.*]] = load i16, ptr [[PX_31055]], align 2
; CHECK-T1-NEXT:    [[ADD_PTR_I912:%.*]] = getelementptr inbounds i16, ptr [[PX_31055]], i32 2
; CHECK-T1-NEXT:    [[ARRAYIDX_I901:%.*]] = getelementptr inbounds i16, ptr [[PY_31056]], i32 1
; CHECK-T1-NEXT:    [[TMP7:%.*]] = load i16, ptr [[ARRAYIDX_I901]], align 2
; CHECK-T1-NEXT:    [[TMP8:%.*]] = load i16, ptr [[PY_31056]], align 2
; CHECK-T1-NEXT:    [[ADD_PTR_I906:%.*]] = getelementptr inbounds i16, ptr [[PY_31056]], i32 -2
; CHECK-T1-NEXT:    [[SHR_I892:%.*]] = sext i16 [[TMP6]] to i32
; CHECK-T1-NEXT:    [[SHR1_I893:%.*]] = sext i16 [[TMP7]] to i32
; CHECK-T1-NEXT:    [[MUL_I894:%.*]] = mul nsw i32 [[SHR1_I893]], [[SHR_I892]]
; CHECK-T1-NEXT:    [[SHR2_I895:%.*]] = sext i16 [[TMP5]] to i32
; CHECK-T1-NEXT:    [[SHR4_I897:%.*]] = sext i16 [[TMP8]] to i32
; CHECK-T1-NEXT:    [[MUL5_I898:%.*]] = mul nsw i32 [[SHR4_I897]], [[SHR2_I895]]
; CHECK-T1-NEXT:    [[ADD_I899:%.*]] = add i32 [[MUL_I894]], [[SUM_11057]]
; CHECK-T1-NEXT:    [[ADD6_I900:%.*]] = add i32 [[ADD_I899]], [[MUL5_I898]]
; CHECK-T1-NEXT:    [[ARRAYIDX_I885:%.*]] = getelementptr inbounds i16, ptr [[PX_31055]], i32 3
; CHECK-T1-NEXT:    [[TMP9:%.*]] = load i16, ptr [[ARRAYIDX_I885]], align 2
; CHECK-T1-NEXT:    [[TMP10:%.*]] = load i16, ptr [[ADD_PTR_I912]], align 2
; CHECK-T1-NEXT:    [[ADD_PTR_I890]] = getelementptr inbounds i16, ptr [[PX_31055]], i32 4
; CHECK-T1-NEXT:    [[ARRAYIDX_I879:%.*]] = getelementptr inbounds i16, ptr [[PY_31056]], i32 -1
; CHECK-T1-NEXT:    [[TMP11:%.*]] = load i16, ptr [[ARRAYIDX_I879]], align 2
; CHECK-T1-NEXT:    [[TMP12:%.*]] = load i16, ptr [[ADD_PTR_I906]], align 2
; CHECK-T1-NEXT:    [[ADD_PTR_I884]] = getelementptr inbounds i16, ptr [[PY_31056]], i32 -4
; CHECK-T1-NEXT:    [[SHR_I870:%.*]] = sext i16 [[TMP10]] to i32
; CHECK-T1-NEXT:    [[SHR1_I871:%.*]] = sext i16 [[TMP11]] to i32
; CHECK-T1-NEXT:    [[MUL_I872:%.*]] = mul nsw i32 [[SHR1_I871]], [[SHR_I870]]
; CHECK-T1-NEXT:    [[SHR2_I873:%.*]] = sext i16 [[TMP9]] to i32
; CHECK-T1-NEXT:    [[SHR4_I875:%.*]] = sext i16 [[TMP12]] to i32
; CHECK-T1-NEXT:    [[MUL5_I876:%.*]] = mul nsw i32 [[SHR4_I875]], [[SHR2_I873]]
; CHECK-T1-NEXT:    [[ADD_I877:%.*]] = add i32 [[ADD6_I900]], [[MUL_I872]]
; CHECK-T1-NEXT:    [[ADD6_I878]] = add i32 [[ADD_I877]], [[MUL5_I876]]
; CHECK-T1-NEXT:    [[DEC30]] = add nsw i32 [[K_11058]], -1
; CHECK-T1-NEXT:    [[CMP21:%.*]] = icmp eq i32 [[DEC30]], 0
; CHECK-T1-NEXT:    br i1 [[CMP21]], label [[WHILE_END31_LOOPEXIT:%.*]], label [[WHILE_BODY23]]
; CHECK-T1:       while.end31.loopexit:
; CHECK-T1-NEXT:    [[ADD_PTR_I890_LCSSA:%.*]] = phi ptr [ [[ADD_PTR_I890]], [[WHILE_BODY23]] ]
; CHECK-T1-NEXT:    [[ADD_PTR_I884_LCSSA:%.*]] = phi ptr [ [[ADD_PTR_I884]], [[WHILE_BODY23]] ]
; CHECK-T1-NEXT:    [[ADD6_I878_LCSSA:%.*]] = phi i32 [ [[ADD6_I878]], [[WHILE_BODY23]] ]
; CHECK-T1-NEXT:    br label [[WHILE_END31]]
; CHECK-T1:       while.end31:
; CHECK-T1-NEXT:    [[PX_3_LCSSA:%.*]] = phi ptr [ [[PSRCB_PSRCA]], [[WHILE_BODY18]] ], [ [[ADD_PTR_I890_LCSSA]], [[WHILE_END31_LOOPEXIT]] ]
; CHECK-T1-NEXT:    [[PY_3_LCSSA:%.*]] = phi ptr [ [[PY_21070]], [[WHILE_BODY18]] ], [ [[ADD_PTR_I884_LCSSA]], [[WHILE_END31_LOOPEXIT]] ]
; CHECK-T1-NEXT:    [[SUM_1_LCSSA:%.*]] = phi i32 [ 0, [[WHILE_BODY18]] ], [ [[ADD6_I878_LCSSA]], [[WHILE_END31_LOOPEXIT]] ]
; CHECK-T1-NEXT:    [[REM:%.*]] = and i32 [[COUNT_11072]], 3
; CHECK-T1-NEXT:    [[CMP341062:%.*]] = icmp eq i32 [[REM]], 0
; CHECK-T1-NEXT:    br i1 [[CMP341062]], label [[WHILE_END43]], label [[WHILE_BODY36_PREHEADER:%.*]]
; CHECK-T1:       while.body36.preheader:
; CHECK-T1-NEXT:    [[ADD_PTR32:%.*]] = getelementptr inbounds i16, ptr [[PY_3_LCSSA]], i32 1
; CHECK-T1-NEXT:    br label [[WHILE_BODY36:%.*]]
; CHECK-T1:       while.body36:
; CHECK-T1-NEXT:    [[K_21066:%.*]] = phi i32 [ [[DEC42:%.*]], [[WHILE_BODY36]] ], [ [[REM]], [[WHILE_BODY36_PREHEADER]] ]
; CHECK-T1-NEXT:    [[SUM_21065:%.*]] = phi i32 [ [[ADD6_I868:%.*]], [[WHILE_BODY36]] ], [ [[SUM_1_LCSSA]], [[WHILE_BODY36_PREHEADER]] ]
; CHECK-T1-NEXT:    [[PY_41064:%.*]] = phi ptr [ [[INCDEC_PTR39:%.*]], [[WHILE_BODY36]] ], [ [[ADD_PTR32]], [[WHILE_BODY36_PREHEADER]] ]
; CHECK-T1-NEXT:    [[PX_41063:%.*]] = phi ptr [ [[INCDEC_PTR37:%.*]], [[WHILE_BODY36]] ], [ [[PX_3_LCSSA]], [[WHILE_BODY36_PREHEADER]] ]
; CHECK-T1-NEXT:    [[INCDEC_PTR37]] = getelementptr inbounds i16, ptr [[PX_41063]], i32 1
; CHECK-T1-NEXT:    [[TMP13:%.*]] = load i16, ptr [[PX_41063]], align 2
; CHECK-T1-NEXT:    [[CONV38:%.*]] = sext i16 [[TMP13]] to i32
; CHECK-T1-NEXT:    [[INCDEC_PTR39]] = getelementptr inbounds i16, ptr [[PY_41064]], i32 -1
; CHECK-T1-NEXT:    [[TMP14:%.*]] = load i16, ptr [[PY_41064]], align 2
; CHECK-T1-NEXT:    [[CONV40:%.*]] = sext i16 [[TMP14]] to i32
; CHECK-T1-NEXT:    [[MUL_I863:%.*]] = mul nsw i32 [[CONV40]], [[CONV38]]
; CHECK-T1-NEXT:    [[SHR3_I864:%.*]] = ashr i32 [[CONV38]], 16
; CHECK-T1-NEXT:    [[SHR4_I865:%.*]] = ashr i32 [[CONV40]], 16
; CHECK-T1-NEXT:    [[MUL5_I866:%.*]] = mul nsw i32 [[SHR4_I865]], [[SHR3_I864]]
; CHECK-T1-NEXT:    [[ADD_I867:%.*]] = add i32 [[MUL_I863]], [[SUM_21065]]
; CHECK-T1-NEXT:    [[ADD6_I868]] = add i32 [[ADD_I867]], [[MUL5_I866]]
; CHECK-T1-NEXT:    [[DEC42]] = add nsw i32 [[K_21066]], -1
; CHECK-T1-NEXT:    [[CMP34:%.*]] = icmp eq i32 [[DEC42]], 0
; CHECK-T1-NEXT:    br i1 [[CMP34]], label [[WHILE_END43_LOOPEXIT:%.*]], label [[WHILE_BODY36]]
; CHECK-T1:       while.end43.loopexit:
; CHECK-T1-NEXT:    [[ADD6_I868_LCSSA:%.*]] = phi i32 [ [[ADD6_I868]], [[WHILE_BODY36]] ]
; CHECK-T1-NEXT:    br label [[WHILE_END43]]
; CHECK-T1:       while.end43:
; CHECK-T1-NEXT:    [[SUM_2_LCSSA:%.*]] = phi i32 [ [[SUM_1_LCSSA]], [[WHILE_END31]] ], [ [[ADD6_I868_LCSSA]], [[WHILE_END43_LOOPEXIT]] ]
; CHECK-T1-NEXT:    [[TMP15:%.*]] = lshr i32 [[SUM_2_LCSSA]], 15
; CHECK-T1-NEXT:    [[CONV45:%.*]] = trunc i32 [[TMP15]] to i16
; CHECK-T1-NEXT:    [[INCDEC_PTR46]] = getelementptr inbounds i16, ptr [[POUT_11069]], i32 1
; CHECK-T1-NEXT:    store i16 [[CONV45]], ptr [[POUT_11069]], align 2
; CHECK-T1-NEXT:    [[SUB47:%.*]] = add i32 [[COUNT_11072]], -1
; CHECK-T1-NEXT:    [[ADD_PTR48]] = getelementptr inbounds i16, ptr [[PSRCA_PSRCB]], i32 [[SUB47]]
; CHECK-T1-NEXT:    [[INC49]] = add i32 [[COUNT_11072]], 1
; CHECK-T1-NEXT:    [[DEC50]] = add i32 [[BLOCKSIZE1_11071]], -1
; CHECK-T1-NEXT:    [[CMP16:%.*]] = icmp eq i32 [[DEC50]], 0
; CHECK-T1-NEXT:    br i1 [[CMP16]], label [[EXIT_LOOPEXIT:%.*]], label [[WHILE_BODY18]]
; CHECK-T1:       exit.loopexit:
; CHECK-T1-NEXT:    br label [[EXIT]]
; CHECK-T1:       exit:
; CHECK-T1-NEXT:    ret void
;
; CHECK-T2-LABEL: @arm_conv_fast_q15(
; CHECK-T2-NEXT:  entry:
; CHECK-T2-NEXT:    [[CMP:%.*]] = icmp ult i32 [[SRCALEN:%.*]], [[SRCBLEN:%.*]]
; CHECK-T2-NEXT:    [[SRCALEN_SRCBLEN:%.*]] = select i1 [[CMP]], i32 [[SRCALEN]], i32 [[SRCBLEN]]
; CHECK-T2-NEXT:    [[PSRCB_PSRCA:%.*]] = select i1 [[CMP]], ptr [[PSRCB:%.*]], ptr [[PSRCA:%.*]]
; CHECK-T2-NEXT:    [[PSRCA_PSRCB:%.*]] = select i1 [[CMP]], ptr [[PSRCA]], ptr [[PSRCB]]
; CHECK-T2-NEXT:    [[SUB:%.*]] = add i32 [[SRCALEN_SRCBLEN]], -1
; CHECK-T2-NEXT:    [[CMP41080:%.*]] = icmp eq i32 [[SUB]], 0
; CHECK-T2-NEXT:    br i1 [[CMP41080]], label [[WHILE_END13:%.*]], label [[WHILE_COND5_PREHEADER_PREHEADER:%.*]]
; CHECK-T2:       while.cond5.preheader.preheader:
; CHECK-T2-NEXT:    [[TMP0:%.*]] = add i32 [[SRCALEN_SRCBLEN]], -2
; CHECK-T2-NEXT:    [[UMIN:%.*]] = call i32 @llvm.umin.i32(i32 [[TMP0]], i32 2)
; CHECK-T2-NEXT:    [[TMP1:%.*]] = add nuw nsw i32 [[UMIN]], 2
; CHECK-T2-NEXT:    br label [[WHILE_COND5_PREHEADER:%.*]]
; CHECK-T2:       while.cond5.preheader:
; CHECK-T2-NEXT:    [[COUNT_01084:%.*]] = phi i32 [ [[INC:%.*]], [[WHILE_END:%.*]] ], [ 1, [[WHILE_COND5_PREHEADER_PREHEADER]] ]
; CHECK-T2-NEXT:    [[BLOCKSIZE1_01083:%.*]] = phi i32 [ [[DEC12:%.*]], [[WHILE_END]] ], [ [[SUB]], [[WHILE_COND5_PREHEADER_PREHEADER]] ]
; CHECK-T2-NEXT:    [[PY_01082:%.*]] = phi ptr [ [[ADD_PTR:%.*]], [[WHILE_END]] ], [ [[PSRCA_PSRCB]], [[WHILE_COND5_PREHEADER_PREHEADER]] ]
; CHECK-T2-NEXT:    [[POUT_01081:%.*]] = phi ptr [ [[INCDEC_PTR11:%.*]], [[WHILE_END]] ], [ [[PDST:%.*]], [[WHILE_COND5_PREHEADER_PREHEADER]] ]
; CHECK-T2-NEXT:    br label [[WHILE_BODY7:%.*]]
; CHECK-T2:       while.body7:
; CHECK-T2-NEXT:    [[K_01078:%.*]] = phi i32 [ [[DEC:%.*]], [[WHILE_BODY7]] ], [ [[COUNT_01084]], [[WHILE_COND5_PREHEADER]] ]
; CHECK-T2-NEXT:    [[SUM_01077:%.*]] = phi i32 [ [[ADD6_I:%.*]], [[WHILE_BODY7]] ], [ 0, [[WHILE_COND5_PREHEADER]] ]
; CHECK-T2-NEXT:    [[PY_11076:%.*]] = phi ptr [ [[INCDEC_PTR8:%.*]], [[WHILE_BODY7]] ], [ [[PY_01082]], [[WHILE_COND5_PREHEADER]] ]
; CHECK-T2-NEXT:    [[PX_11075:%.*]] = phi ptr [ [[INCDEC_PTR:%.*]], [[WHILE_BODY7]] ], [ [[PSRCB_PSRCA]], [[WHILE_COND5_PREHEADER]] ]
; CHECK-T2-NEXT:    [[INCDEC_PTR]] = getelementptr inbounds i16, ptr [[PX_11075]], i32 1
; CHECK-T2-NEXT:    [[TMP2:%.*]] = load i16, ptr [[PX_11075]], align 2
; CHECK-T2-NEXT:    [[CONV:%.*]] = sext i16 [[TMP2]] to i32
; CHECK-T2-NEXT:    [[INCDEC_PTR8]] = getelementptr inbounds i16, ptr [[PY_11076]], i32 -1
; CHECK-T2-NEXT:    [[TMP3:%.*]] = load i16, ptr [[PY_11076]], align 2
; CHECK-T2-NEXT:    [[CONV9:%.*]] = sext i16 [[TMP3]] to i32
; CHECK-T2-NEXT:    [[MUL_I:%.*]] = mul nsw i32 [[CONV9]], [[CONV]]
; CHECK-T2-NEXT:    [[SHR3_I:%.*]] = ashr i32 [[CONV]], 16
; CHECK-T2-NEXT:    [[SHR4_I:%.*]] = ashr i32 [[CONV9]], 16
; CHECK-T2-NEXT:    [[MUL5_I:%.*]] = mul nsw i32 [[SHR4_I]], [[SHR3_I]]
; CHECK-T2-NEXT:    [[ADD_I:%.*]] = add i32 [[MUL_I]], [[SUM_01077]]
; CHECK-T2-NEXT:    [[ADD6_I]] = add i32 [[ADD_I]], [[MUL5_I]]
; CHECK-T2-NEXT:    [[DEC]] = add nsw i32 [[K_01078]], -1
; CHECK-T2-NEXT:    [[CMP6:%.*]] = icmp eq i32 [[DEC]], 0
; CHECK-T2-NEXT:    br i1 [[CMP6]], label [[WHILE_END]], label [[WHILE_BODY7]]
; CHECK-T2:       while.end:
; CHECK-T2-NEXT:    [[ADD6_I_LCSSA:%.*]] = phi i32 [ [[ADD6_I]], [[WHILE_BODY7]] ]
; CHECK-T2-NEXT:    [[TMP4:%.*]] = lshr i32 [[ADD6_I_LCSSA]], 15
; CHECK-T2-NEXT:    [[CONV10:%.*]] = trunc i32 [[TMP4]] to i16
; CHECK-T2-NEXT:    [[INCDEC_PTR11]] = getelementptr inbounds i16, ptr [[POUT_01081]], i32 1
; CHECK-T2-NEXT:    store i16 [[CONV10]], ptr [[POUT_01081]], align 2
; CHECK-T2-NEXT:    [[ADD_PTR]] = getelementptr inbounds i16, ptr [[PSRCA_PSRCB]], i32 [[COUNT_01084]]
; CHECK-T2-NEXT:    [[INC]] = add nuw nsw i32 [[COUNT_01084]], 1
; CHECK-T2-NEXT:    [[DEC12]] = add i32 [[BLOCKSIZE1_01083]], -1
; CHECK-T2-NEXT:    [[EXITCOND:%.*]] = icmp ne i32 [[INC]], [[TMP1]]
; CHECK-T2-NEXT:    br i1 [[EXITCOND]], label [[WHILE_COND5_PREHEADER]], label [[WHILE_END13_LOOPEXIT:%.*]]
; CHECK-T2:       while.end13.loopexit:
; CHECK-T2-NEXT:    [[INCDEC_PTR11_LCSSA:%.*]] = phi ptr [ [[INCDEC_PTR11]], [[WHILE_END]] ]
; CHECK-T2-NEXT:    [[ADD_PTR_LCSSA:%.*]] = phi ptr [ [[ADD_PTR]], [[WHILE_END]] ]
; CHECK-T2-NEXT:    [[INC_LCSSA:%.*]] = phi i32 [ [[INC]], [[WHILE_END]] ]
; CHECK-T2-NEXT:    [[DEC12_LCSSA:%.*]] = phi i32 [ [[DEC12]], [[WHILE_END]] ]
; CHECK-T2-NEXT:    br label [[WHILE_END13]]
; CHECK-T2:       while.end13:
; CHECK-T2-NEXT:    [[POUT_0_LCSSA:%.*]] = phi ptr [ [[PDST]], [[ENTRY:%.*]] ], [ [[INCDEC_PTR11_LCSSA]], [[WHILE_END13_LOOPEXIT]] ]
; CHECK-T2-NEXT:    [[PY_0_LCSSA:%.*]] = phi ptr [ [[PSRCA_PSRCB]], [[ENTRY]] ], [ [[ADD_PTR_LCSSA]], [[WHILE_END13_LOOPEXIT]] ]
; CHECK-T2-NEXT:    [[BLOCKSIZE1_0_LCSSA:%.*]] = phi i32 [ [[SUB]], [[ENTRY]] ], [ [[DEC12_LCSSA]], [[WHILE_END13_LOOPEXIT]] ]
; CHECK-T2-NEXT:    [[COUNT_0_LCSSA:%.*]] = phi i32 [ 1, [[ENTRY]] ], [ [[INC_LCSSA]], [[WHILE_END13_LOOPEXIT]] ]
; CHECK-T2-NEXT:    [[CMP161068:%.*]] = icmp eq i32 [[BLOCKSIZE1_0_LCSSA]], 0
; CHECK-T2-NEXT:    br i1 [[CMP161068]], label [[EXIT:%.*]], label [[WHILE_BODY18_PREHEADER:%.*]]
; CHECK-T2:       while.body18.preheader:
; CHECK-T2-NEXT:    [[ADD_PTR14:%.*]] = getelementptr inbounds i16, ptr [[PY_0_LCSSA]], i32 -1
; CHECK-T2-NEXT:    br label [[WHILE_BODY18:%.*]]
; CHECK-T2:       while.body18:
; CHECK-T2-NEXT:    [[COUNT_11072:%.*]] = phi i32 [ [[INC49:%.*]], [[WHILE_END43:%.*]] ], [ [[COUNT_0_LCSSA]], [[WHILE_BODY18_PREHEADER]] ]
; CHECK-T2-NEXT:    [[BLOCKSIZE1_11071:%.*]] = phi i32 [ [[DEC50:%.*]], [[WHILE_END43]] ], [ [[BLOCKSIZE1_0_LCSSA]], [[WHILE_BODY18_PREHEADER]] ]
; CHECK-T2-NEXT:    [[PY_21070:%.*]] = phi ptr [ [[ADD_PTR48:%.*]], [[WHILE_END43]] ], [ [[ADD_PTR14]], [[WHILE_BODY18_PREHEADER]] ]
; CHECK-T2-NEXT:    [[POUT_11069:%.*]] = phi ptr [ [[INCDEC_PTR46:%.*]], [[WHILE_END43]] ], [ [[POUT_0_LCSSA]], [[WHILE_BODY18_PREHEADER]] ]
; CHECK-T2-NEXT:    [[SHR19:%.*]] = lshr i32 [[COUNT_11072]], 2
; CHECK-T2-NEXT:    [[CMP211054:%.*]] = icmp eq i32 [[SHR19]], 0
; CHECK-T2-NEXT:    br i1 [[CMP211054]], label [[WHILE_END31:%.*]], label [[WHILE_BODY23_PREHEADER:%.*]]
; CHECK-T2:       while.body23.preheader:
; CHECK-T2-NEXT:    br label [[WHILE_BODY23:%.*]]
; CHECK-T2:       while.body23:
; CHECK-T2-NEXT:    [[K_11058:%.*]] = phi i32 [ [[DEC30:%.*]], [[WHILE_BODY23]] ], [ [[SHR19]], [[WHILE_BODY23_PREHEADER]] ]
; CHECK-T2-NEXT:    [[SUM_11057:%.*]] = phi i32 [ [[ADD6_I878:%.*]], [[WHILE_BODY23]] ], [ 0, [[WHILE_BODY23_PREHEADER]] ]
; CHECK-T2-NEXT:    [[PY_31056:%.*]] = phi ptr [ [[ADD_PTR_I884:%.*]], [[WHILE_BODY23]] ], [ [[PY_21070]], [[WHILE_BODY23_PREHEADER]] ]
; CHECK-T2-NEXT:    [[PX_31055:%.*]] = phi ptr [ [[ADD_PTR_I890:%.*]], [[WHILE_BODY23]] ], [ [[PSRCB_PSRCA]], [[WHILE_BODY23_PREHEADER]] ]
; CHECK-T2-NEXT:    [[ARRAYIDX_I907:%.*]] = getelementptr inbounds i16, ptr [[PX_31055]], i32 1
; CHECK-T2-NEXT:    [[TMP5:%.*]] = load i16, ptr [[ARRAYIDX_I907]], align 2
; CHECK-T2-NEXT:    [[TMP6:%.*]] = load i16, ptr [[PX_31055]], align 2
; CHECK-T2-NEXT:    [[ADD_PTR_I912:%.*]] = getelementptr inbounds i16, ptr [[PX_31055]], i32 2
; CHECK-T2-NEXT:    [[ARRAYIDX_I901:%.*]] = getelementptr inbounds i16, ptr [[PY_31056]], i32 1
; CHECK-T2-NEXT:    [[TMP7:%.*]] = load i16, ptr [[ARRAYIDX_I901]], align 2
; CHECK-T2-NEXT:    [[TMP8:%.*]] = load i16, ptr [[PY_31056]], align 2
; CHECK-T2-NEXT:    [[ADD_PTR_I906:%.*]] = getelementptr inbounds i16, ptr [[PY_31056]], i32 -2
; CHECK-T2-NEXT:    [[SHR_I892:%.*]] = sext i16 [[TMP6]] to i32
; CHECK-T2-NEXT:    [[SHR1_I893:%.*]] = sext i16 [[TMP7]] to i32
; CHECK-T2-NEXT:    [[MUL_I894:%.*]] = mul nsw i32 [[SHR1_I893]], [[SHR_I892]]
; CHECK-T2-NEXT:    [[SHR2_I895:%.*]] = sext i16 [[TMP5]] to i32
; CHECK-T2-NEXT:    [[SHR4_I897:%.*]] = sext i16 [[TMP8]] to i32
; CHECK-T2-NEXT:    [[MUL5_I898:%.*]] = mul nsw i32 [[SHR4_I897]], [[SHR2_I895]]
; CHECK-T2-NEXT:    [[ADD_I899:%.*]] = add i32 [[MUL_I894]], [[SUM_11057]]
; CHECK-T2-NEXT:    [[ADD6_I900:%.*]] = add i32 [[ADD_I899]], [[MUL5_I898]]
; CHECK-T2-NEXT:    [[ARRAYIDX_I885:%.*]] = getelementptr inbounds i16, ptr [[PX_31055]], i32 3
; CHECK-T2-NEXT:    [[TMP9:%.*]] = load i16, ptr [[ARRAYIDX_I885]], align 2
; CHECK-T2-NEXT:    [[TMP10:%.*]] = load i16, ptr [[ADD_PTR_I912]], align 2
; CHECK-T2-NEXT:    [[ADD_PTR_I890]] = getelementptr inbounds i16, ptr [[PX_31055]], i32 4
; CHECK-T2-NEXT:    [[ARRAYIDX_I879:%.*]] = getelementptr inbounds i16, ptr [[PY_31056]], i32 -1
; CHECK-T2-NEXT:    [[TMP11:%.*]] = load i16, ptr [[ARRAYIDX_I879]], align 2
; CHECK-T2-NEXT:    [[TMP12:%.*]] = load i16, ptr [[ADD_PTR_I906]], align 2
; CHECK-T2-NEXT:    [[ADD_PTR_I884]] = getelementptr inbounds i16, ptr [[PY_31056]], i32 -4
; CHECK-T2-NEXT:    [[SHR_I870:%.*]] = sext i16 [[TMP10]] to i32
; CHECK-T2-NEXT:    [[SHR1_I871:%.*]] = sext i16 [[TMP11]] to i32
; CHECK-T2-NEXT:    [[MUL_I872:%.*]] = mul nsw i32 [[SHR1_I871]], [[SHR_I870]]
; CHECK-T2-NEXT:    [[SHR2_I873:%.*]] = sext i16 [[TMP9]] to i32
; CHECK-T2-NEXT:    [[SHR4_I875:%.*]] = sext i16 [[TMP12]] to i32
; CHECK-T2-NEXT:    [[MUL5_I876:%.*]] = mul nsw i32 [[SHR4_I875]], [[SHR2_I873]]
; CHECK-T2-NEXT:    [[ADD_I877:%.*]] = add i32 [[ADD6_I900]], [[MUL_I872]]
; CHECK-T2-NEXT:    [[ADD6_I878]] = add i32 [[ADD_I877]], [[MUL5_I876]]
; CHECK-T2-NEXT:    [[DEC30]] = add nsw i32 [[K_11058]], -1
; CHECK-T2-NEXT:    [[CMP21:%.*]] = icmp eq i32 [[DEC30]], 0
; CHECK-T2-NEXT:    br i1 [[CMP21]], label [[WHILE_END31_LOOPEXIT:%.*]], label [[WHILE_BODY23]]
; CHECK-T2:       while.end31.loopexit:
; CHECK-T2-NEXT:    [[ADD_PTR_I890_LCSSA:%.*]] = phi ptr [ [[ADD_PTR_I890]], [[WHILE_BODY23]] ]
; CHECK-T2-NEXT:    [[ADD_PTR_I884_LCSSA:%.*]] = phi ptr [ [[ADD_PTR_I884]], [[WHILE_BODY23]] ]
; CHECK-T2-NEXT:    [[ADD6_I878_LCSSA:%.*]] = phi i32 [ [[ADD6_I878]], [[WHILE_BODY23]] ]
; CHECK-T2-NEXT:    br label [[WHILE_END31]]
; CHECK-T2:       while.end31:
; CHECK-T2-NEXT:    [[PX_3_LCSSA:%.*]] = phi ptr [ [[PSRCB_PSRCA]], [[WHILE_BODY18]] ], [ [[ADD_PTR_I890_LCSSA]], [[WHILE_END31_LOOPEXIT]] ]
; CHECK-T2-NEXT:    [[PY_3_LCSSA:%.*]] = phi ptr [ [[PY_21070]], [[WHILE_BODY18]] ], [ [[ADD_PTR_I884_LCSSA]], [[WHILE_END31_LOOPEXIT]] ]
; CHECK-T2-NEXT:    [[SUM_1_LCSSA:%.*]] = phi i32 [ 0, [[WHILE_BODY18]] ], [ [[ADD6_I878_LCSSA]], [[WHILE_END31_LOOPEXIT]] ]
; CHECK-T2-NEXT:    [[REM:%.*]] = and i32 [[COUNT_11072]], 3
; CHECK-T2-NEXT:    [[CMP341062:%.*]] = icmp eq i32 [[REM]], 0
; CHECK-T2-NEXT:    br i1 [[CMP341062]], label [[WHILE_END43]], label [[WHILE_BODY36_PREHEADER:%.*]]
; CHECK-T2:       while.body36.preheader:
; CHECK-T2-NEXT:    [[ADD_PTR32:%.*]] = getelementptr inbounds i16, ptr [[PY_3_LCSSA]], i32 1
; CHECK-T2-NEXT:    br label [[WHILE_BODY36:%.*]]
; CHECK-T2:       while.body36:
; CHECK-T2-NEXT:    [[K_21066:%.*]] = phi i32 [ [[DEC42:%.*]], [[WHILE_BODY36]] ], [ [[REM]], [[WHILE_BODY36_PREHEADER]] ]
; CHECK-T2-NEXT:    [[SUM_21065:%.*]] = phi i32 [ [[ADD6_I868:%.*]], [[WHILE_BODY36]] ], [ [[SUM_1_LCSSA]], [[WHILE_BODY36_PREHEADER]] ]
; CHECK-T2-NEXT:    [[PY_41064:%.*]] = phi ptr [ [[INCDEC_PTR39:%.*]], [[WHILE_BODY36]] ], [ [[ADD_PTR32]], [[WHILE_BODY36_PREHEADER]] ]
; CHECK-T2-NEXT:    [[PX_41063:%.*]] = phi ptr [ [[INCDEC_PTR37:%.*]], [[WHILE_BODY36]] ], [ [[PX_3_LCSSA]], [[WHILE_BODY36_PREHEADER]] ]
; CHECK-T2-NEXT:    [[INCDEC_PTR37]] = getelementptr inbounds i16, ptr [[PX_41063]], i32 1
; CHECK-T2-NEXT:    [[TMP13:%.*]] = load i16, ptr [[PX_41063]], align 2
; CHECK-T2-NEXT:    [[CONV38:%.*]] = sext i16 [[TMP13]] to i32
; CHECK-T2-NEXT:    [[INCDEC_PTR39]] = getelementptr inbounds i16, ptr [[PY_41064]], i32 -1
; CHECK-T2-NEXT:    [[TMP14:%.*]] = load i16, ptr [[PY_41064]], align 2
; CHECK-T2-NEXT:    [[CONV40:%.*]] = sext i16 [[TMP14]] to i32
; CHECK-T2-NEXT:    [[MUL_I863:%.*]] = mul nsw i32 [[CONV40]], [[CONV38]]
; CHECK-T2-NEXT:    [[SHR3_I864:%.*]] = ashr i32 [[CONV38]], 16
; CHECK-T2-NEXT:    [[SHR4_I865:%.*]] = ashr i32 [[CONV40]], 16
; CHECK-T2-NEXT:    [[MUL5_I866:%.*]] = mul nsw i32 [[SHR4_I865]], [[SHR3_I864]]
; CHECK-T2-NEXT:    [[ADD_I867:%.*]] = add i32 [[MUL_I863]], [[SUM_21065]]
; CHECK-T2-NEXT:    [[ADD6_I868]] = add i32 [[ADD_I867]], [[MUL5_I866]]
; CHECK-T2-NEXT:    [[DEC42]] = add nsw i32 [[K_21066]], -1
; CHECK-T2-NEXT:    [[CMP34:%.*]] = icmp eq i32 [[DEC42]], 0
; CHECK-T2-NEXT:    br i1 [[CMP34]], label [[WHILE_END43_LOOPEXIT:%.*]], label [[WHILE_BODY36]]
; CHECK-T2:       while.end43.loopexit:
; CHECK-T2-NEXT:    [[ADD6_I868_LCSSA:%.*]] = phi i32 [ [[ADD6_I868]], [[WHILE_BODY36]] ]
; CHECK-T2-NEXT:    br label [[WHILE_END43]]
; CHECK-T2:       while.end43:
; CHECK-T2-NEXT:    [[SUM_2_LCSSA:%.*]] = phi i32 [ [[SUM_1_LCSSA]], [[WHILE_END31]] ], [ [[ADD6_I868_LCSSA]], [[WHILE_END43_LOOPEXIT]] ]
; CHECK-T2-NEXT:    [[TMP15:%.*]] = lshr i32 [[SUM_2_LCSSA]], 15
; CHECK-T2-NEXT:    [[CONV45:%.*]] = trunc i32 [[TMP15]] to i16
; CHECK-T2-NEXT:    [[INCDEC_PTR46]] = getelementptr inbounds i16, ptr [[POUT_11069]], i32 1
; CHECK-T2-NEXT:    store i16 [[CONV45]], ptr [[POUT_11069]], align 2
; CHECK-T2-NEXT:    [[SUB47:%.*]] = add i32 [[COUNT_11072]], -1
; CHECK-T2-NEXT:    [[ADD_PTR48]] = getelementptr inbounds i16, ptr [[PSRCA_PSRCB]], i32 [[SUB47]]
; CHECK-T2-NEXT:    [[INC49]] = add i32 [[COUNT_11072]], 1
; CHECK-T2-NEXT:    [[DEC50]] = add i32 [[BLOCKSIZE1_11071]], -1
; CHECK-T2-NEXT:    [[CMP16:%.*]] = icmp eq i32 [[DEC50]], 0
; CHECK-T2-NEXT:    br i1 [[CMP16]], label [[EXIT_LOOPEXIT:%.*]], label [[WHILE_BODY18]]
; CHECK-T2:       exit.loopexit:
; CHECK-T2-NEXT:    br label [[EXIT]]
; CHECK-T2:       exit:
; CHECK-T2-NEXT:    ret void
;
entry:
  %cmp = icmp ult i32 %srcALen, %srcBLen
  %srcALen.srcBLen = select i1 %cmp, i32 %srcALen, i32 %srcBLen
  %pSrcB.pSrcA = select i1 %cmp, ptr %pSrcB, ptr %pSrcA
  %pSrcA.pSrcB = select i1 %cmp, ptr %pSrcA, ptr %pSrcB
  %sub = add i32 %srcALen.srcBLen, -1
  %cmp41080 = icmp eq i32 %sub, 0
  br i1 %cmp41080, label %while.end13, label %while.cond5.preheader

while.cond5.preheader:                            ; preds = %while.end, %entry
  %count.01084 = phi i32 [ %inc, %while.end ], [ 1, %entry ]
  %blockSize1.01083 = phi i32 [ %dec12, %while.end ], [ %sub, %entry ]
  %py.01082 = phi ptr [ %add.ptr, %while.end ], [ %pSrcA.pSrcB, %entry ]
  %pOut.01081 = phi ptr [ %incdec.ptr11, %while.end ], [ %pDst, %entry ]
  br label %while.body7

while.body7:                                      ; preds = %while.body7, %while.cond5.preheader
  %k.01078 = phi i32 [ %dec, %while.body7 ], [ %count.01084, %while.cond5.preheader ]
  %sum.01077 = phi i32 [ %add6.i, %while.body7 ], [ 0, %while.cond5.preheader ]
  %py.11076 = phi ptr [ %incdec.ptr8, %while.body7 ], [ %py.01082, %while.cond5.preheader ]
  %px.11075 = phi ptr [ %incdec.ptr, %while.body7 ], [ %pSrcB.pSrcA, %while.cond5.preheader ]
  %incdec.ptr = getelementptr inbounds i16, ptr %px.11075, i32 1
  %0 = load i16, ptr %px.11075, align 2
  %conv = sext i16 %0 to i32
  %incdec.ptr8 = getelementptr inbounds i16, ptr %py.11076, i32 -1
  %1 = load i16, ptr %py.11076, align 2
  %conv9 = sext i16 %1 to i32
  %mul.i = mul nsw i32 %conv9, %conv
  %shr3.i = ashr i32 %conv, 16
  %shr4.i = ashr i32 %conv9, 16
  %mul5.i = mul nsw i32 %shr4.i, %shr3.i
  %add.i = add i32 %mul.i, %sum.01077
  %add6.i = add i32 %add.i, %mul5.i
  %dec = add nsw i32 %k.01078, -1
  %cmp6 = icmp eq i32 %dec, 0
  br i1 %cmp6, label %while.end, label %while.body7

while.end:                                        ; preds = %while.body7
  %2 = lshr i32 %add6.i, 15
  %conv10 = trunc i32 %2 to i16
  %incdec.ptr11 = getelementptr inbounds i16, ptr %pOut.01081, i32 1
  store i16 %conv10, ptr %pOut.01081, align 2
  %add.ptr = getelementptr inbounds i16, ptr %pSrcA.pSrcB, i32 %count.01084
  %inc = add nuw nsw i32 %count.01084, 1
  %dec12 = add i32 %blockSize1.01083, -1
  %cmp3 = icmp ult i32 %count.01084, 3
  %cmp4 = icmp ne i32 %dec12, 0
  %3 = and i1 %cmp4, %cmp3
  br i1 %3, label %while.cond5.preheader, label %while.end13

while.end13:                                      ; preds = %while.end, %entry
  %pOut.0.lcssa = phi ptr [ %pDst, %entry ], [ %incdec.ptr11, %while.end ]
  %py.0.lcssa = phi ptr [ %pSrcA.pSrcB, %entry ], [ %add.ptr, %while.end ]
  %blockSize1.0.lcssa = phi i32 [ %sub, %entry ], [ %dec12, %while.end ]
  %count.0.lcssa = phi i32 [ 1, %entry ], [ %inc, %while.end ]
  %cmp161068 = icmp eq i32 %blockSize1.0.lcssa, 0
  br i1 %cmp161068, label %exit, label %while.body18.preheader

while.body18.preheader:                           ; preds = %while.end13
  %add.ptr14 = getelementptr inbounds i16, ptr %py.0.lcssa, i32 -1
  br label %while.body18

while.body18:                                     ; preds = %while.end43, %while.body18.preheader
  %count.11072 = phi i32 [ %inc49, %while.end43 ], [ %count.0.lcssa, %while.body18.preheader ]
  %blockSize1.11071 = phi i32 [ %dec50, %while.end43 ], [ %blockSize1.0.lcssa, %while.body18.preheader ]
  %py.21070 = phi ptr [ %add.ptr48, %while.end43 ], [ %add.ptr14, %while.body18.preheader ]
  %pOut.11069 = phi ptr [ %incdec.ptr46, %while.end43 ], [ %pOut.0.lcssa, %while.body18.preheader ]
  %shr19 = lshr i32 %count.11072, 2
  %cmp211054 = icmp eq i32 %shr19, 0
  br i1 %cmp211054, label %while.end31, label %while.body23

while.body23:                                     ; preds = %while.body23, %while.body18
  %k.11058 = phi i32 [ %dec30, %while.body23 ], [ %shr19, %while.body18 ]
  %sum.11057 = phi i32 [ %add6.i878, %while.body23 ], [ 0, %while.body18 ]
  %py.31056 = phi ptr [ %add.ptr.i884, %while.body23 ], [ %py.21070, %while.body18 ]
  %px.31055 = phi ptr [ %add.ptr.i890, %while.body23 ], [ %pSrcB.pSrcA, %while.body18 ]
  %arrayidx.i907 = getelementptr inbounds i16, ptr %px.31055, i32 1
  %4 = load i16, ptr %arrayidx.i907, align 2
  %5 = load i16, ptr %px.31055, align 2
  %add.ptr.i912 = getelementptr inbounds i16, ptr %px.31055, i32 2
  %arrayidx.i901 = getelementptr inbounds i16, ptr %py.31056, i32 1
  %6 = load i16, ptr %arrayidx.i901, align 2
  %7 = load i16, ptr %py.31056, align 2
  %add.ptr.i906 = getelementptr inbounds i16, ptr %py.31056, i32 -2
  %shr.i892 = sext i16 %5 to i32
  %shr1.i893 = sext i16 %6 to i32
  %mul.i894 = mul nsw i32 %shr1.i893, %shr.i892
  %shr2.i895 = sext i16 %4 to i32
  %shr4.i897 = sext i16 %7 to i32
  %mul5.i898 = mul nsw i32 %shr4.i897, %shr2.i895
  %add.i899 = add i32 %mul.i894, %sum.11057
  %add6.i900 = add i32 %add.i899, %mul5.i898
  %arrayidx.i885 = getelementptr inbounds i16, ptr %px.31055, i32 3
  %8 = load i16, ptr %arrayidx.i885, align 2
  %9 = load i16, ptr %add.ptr.i912, align 2
  %add.ptr.i890 = getelementptr inbounds i16, ptr %px.31055, i32 4
  %arrayidx.i879 = getelementptr inbounds i16, ptr %py.31056, i32 -1
  %10 = load i16, ptr %arrayidx.i879, align 2
  %11 = load i16, ptr %add.ptr.i906, align 2
  %add.ptr.i884 = getelementptr inbounds i16, ptr %py.31056, i32 -4
  %shr.i870 = sext i16 %9 to i32
  %shr1.i871 = sext i16 %10 to i32
  %mul.i872 = mul nsw i32 %shr1.i871, %shr.i870
  %shr2.i873 = sext i16 %8 to i32
  %shr4.i875 = sext i16 %11 to i32
  %mul5.i876 = mul nsw i32 %shr4.i875, %shr2.i873
  %add.i877 = add i32 %add6.i900, %mul.i872
  %add6.i878 = add i32 %add.i877, %mul5.i876
  %dec30 = add nsw i32 %k.11058, -1
  %cmp21 = icmp eq i32 %dec30, 0
  br i1 %cmp21, label %while.end31, label %while.body23

while.end31:                                      ; preds = %while.body23, %while.body18
  %px.3.lcssa = phi ptr [ %pSrcB.pSrcA, %while.body18 ], [ %add.ptr.i890, %while.body23 ]
  %py.3.lcssa = phi ptr [ %py.21070, %while.body18 ], [ %add.ptr.i884, %while.body23 ]
  %sum.1.lcssa = phi i32 [ 0, %while.body18 ], [ %add6.i878, %while.body23 ]
  %rem = and i32 %count.11072, 3
  %cmp341062 = icmp eq i32 %rem, 0
  br i1 %cmp341062, label %while.end43, label %while.body36.preheader

while.body36.preheader:                           ; preds = %while.end31
  %add.ptr32 = getelementptr inbounds i16, ptr %py.3.lcssa, i32 1
  br label %while.body36

while.body36:                                     ; preds = %while.body36, %while.body36.preheader
  %k.21066 = phi i32 [ %dec42, %while.body36 ], [ %rem, %while.body36.preheader ]
  %sum.21065 = phi i32 [ %add6.i868, %while.body36 ], [ %sum.1.lcssa, %while.body36.preheader ]
  %py.41064 = phi ptr [ %incdec.ptr39, %while.body36 ], [ %add.ptr32, %while.body36.preheader ]
  %px.41063 = phi ptr [ %incdec.ptr37, %while.body36 ], [ %px.3.lcssa, %while.body36.preheader ]
  %incdec.ptr37 = getelementptr inbounds i16, ptr %px.41063, i32 1
  %12 = load i16, ptr %px.41063, align 2
  %conv38 = sext i16 %12 to i32
  %incdec.ptr39 = getelementptr inbounds i16, ptr %py.41064, i32 -1
  %13 = load i16, ptr %py.41064, align 2
  %conv40 = sext i16 %13 to i32
  %mul.i863 = mul nsw i32 %conv40, %conv38
  %shr3.i864 = ashr i32 %conv38, 16
  %shr4.i865 = ashr i32 %conv40, 16
  %mul5.i866 = mul nsw i32 %shr4.i865, %shr3.i864
  %add.i867 = add i32 %mul.i863, %sum.21065
  %add6.i868 = add i32 %add.i867, %mul5.i866
  %dec42 = add nsw i32 %k.21066, -1
  %cmp34 = icmp eq i32 %dec42, 0
  br i1 %cmp34, label %while.end43, label %while.body36

while.end43:                                      ; preds = %while.body36, %while.end31
  %sum.2.lcssa = phi i32 [ %sum.1.lcssa, %while.end31 ], [ %add6.i868, %while.body36 ]
  %14 = lshr i32 %sum.2.lcssa, 15
  %conv45 = trunc i32 %14 to i16
  %incdec.ptr46 = getelementptr inbounds i16, ptr %pOut.11069, i32 1
  store i16 %conv45, ptr %pOut.11069, align 2
  %sub47 = add i32 %count.11072, -1
  %add.ptr48 = getelementptr inbounds i16, ptr %pSrcA.pSrcB, i32 %sub47
  %inc49 = add i32 %count.11072, 1
  %dec50 = add i32 %blockSize1.11071, -1
  %cmp16 = icmp eq i32 %dec50, 0
  br i1 %cmp16, label %exit, label %while.body18

exit:                                             ; preds = %while.end43, %while.end13
  ret void
}
