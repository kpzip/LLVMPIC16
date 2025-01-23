; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 3
; RUN: opt -mtriple=thumbv8.1m.main-none-none-eabi -mattr=+fp-armv8 -passes=hardware-loops %s -S -o - | FileCheck %s --check-prefixes=CHECK,CHECK-FP
; RUN: opt -mtriple=thumbv8.1m.main-none-none-eabi -mattr=+soft-float -passes=hardware-loops %s -S -o - | FileCheck %s --check-prefixes=CHECK,CHECK-SOFT

define void @test_fptosi(i32 %n, ptr %g, ptr %d) {
; CHECK-FP-LABEL: define void @test_fptosi(
; CHECK-FP-SAME: i32 [[N:%.*]], ptr [[G:%.*]], ptr [[D:%.*]]) #[[ATTR0:[0-9]+]] {
; CHECK-FP-NEXT:  entry:
; CHECK-FP-NEXT:    [[N_OFF:%.*]] = add i32 [[N]], -1
; CHECK-FP-NEXT:    [[TMP0:%.*]] = icmp ult i32 [[N_OFF]], 500
; CHECK-FP-NEXT:    br i1 [[TMP0]], label [[WHILE_BODY_LR_PH:%.*]], label [[CLEANUP:%.*]]
; CHECK-FP:       while.body.lr.ph:
; CHECK-FP-NEXT:    [[TMP1:%.*]] = load ptr, ptr [[D]], align 4
; CHECK-FP-NEXT:    [[TMP2:%.*]] = load ptr, ptr [[G]], align 4
; CHECK-FP-NEXT:    [[TMP3:%.*]] = call i32 @llvm.start.loop.iterations.i32(i32 [[N]])
; CHECK-FP-NEXT:    br label [[WHILE_BODY:%.*]]
; CHECK-FP:       while.body:
; CHECK-FP-NEXT:    [[I_012:%.*]] = phi i32 [ 0, [[WHILE_BODY_LR_PH]] ], [ [[INC:%.*]], [[IF_END4:%.*]] ]
; CHECK-FP-NEXT:    [[TMP4:%.*]] = phi i32 [ [[TMP3]], [[WHILE_BODY_LR_PH]] ], [ [[TMP6:%.*]], [[IF_END4]] ]
; CHECK-FP-NEXT:    [[REM:%.*]] = urem i32 [[I_012]], 10
; CHECK-FP-NEXT:    [[TOBOOL:%.*]] = icmp eq i32 [[REM]], 0
; CHECK-FP-NEXT:    br i1 [[TOBOOL]], label [[IF_END4]], label [[IF_THEN2:%.*]]
; CHECK-FP:       if.then2:
; CHECK-FP-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds double, ptr [[TMP1]], i32 [[I_012]]
; CHECK-FP-NEXT:    [[TMP5:%.*]] = load double, ptr [[ARRAYIDX]], align 8
; CHECK-FP-NEXT:    [[CONV:%.*]] = fptosi double [[TMP5]] to i32
; CHECK-FP-NEXT:    [[ARRAYIDX3:%.*]] = getelementptr inbounds i32, ptr [[TMP2]], i32 [[I_012]]
; CHECK-FP-NEXT:    store i32 [[CONV]], ptr [[ARRAYIDX3]], align 4
; CHECK-FP-NEXT:    br label [[IF_END4]]
; CHECK-FP:       if.end4:
; CHECK-FP-NEXT:    [[INC]] = add nuw i32 [[I_012]], 1
; CHECK-FP-NEXT:    [[TMP6]] = call i32 @llvm.loop.decrement.reg.i32(i32 [[TMP4]], i32 1)
; CHECK-FP-NEXT:    [[TMP7:%.*]] = icmp ne i32 [[TMP6]], 0
; CHECK-FP-NEXT:    br i1 [[TMP7]], label [[WHILE_BODY]], label [[CLEANUP_LOOPEXIT:%.*]]
; CHECK-FP:       cleanup.loopexit:
; CHECK-FP-NEXT:    br label [[CLEANUP]]
; CHECK-FP:       cleanup:
; CHECK-FP-NEXT:    ret void
;
; CHECK-SOFT-LABEL: define void @test_fptosi(
; CHECK-SOFT-SAME: i32 [[N:%.*]], ptr [[G:%.*]], ptr [[D:%.*]]) #[[ATTR0:[0-9]+]] {
; CHECK-SOFT-NEXT:  entry:
; CHECK-SOFT-NEXT:    [[N_OFF:%.*]] = add i32 [[N]], -1
; CHECK-SOFT-NEXT:    [[TMP0:%.*]] = icmp ult i32 [[N_OFF]], 500
; CHECK-SOFT-NEXT:    br i1 [[TMP0]], label [[WHILE_BODY_LR_PH:%.*]], label [[CLEANUP:%.*]]
; CHECK-SOFT:       while.body.lr.ph:
; CHECK-SOFT-NEXT:    [[TMP1:%.*]] = load ptr, ptr [[D]], align 4
; CHECK-SOFT-NEXT:    [[TMP2:%.*]] = load ptr, ptr [[G]], align 4
; CHECK-SOFT-NEXT:    br label [[WHILE_BODY:%.*]]
; CHECK-SOFT:       while.body:
; CHECK-SOFT-NEXT:    [[I_012:%.*]] = phi i32 [ 0, [[WHILE_BODY_LR_PH]] ], [ [[INC:%.*]], [[IF_END4:%.*]] ]
; CHECK-SOFT-NEXT:    [[REM:%.*]] = urem i32 [[I_012]], 10
; CHECK-SOFT-NEXT:    [[TOBOOL:%.*]] = icmp eq i32 [[REM]], 0
; CHECK-SOFT-NEXT:    br i1 [[TOBOOL]], label [[IF_END4]], label [[IF_THEN2:%.*]]
; CHECK-SOFT:       if.then2:
; CHECK-SOFT-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds double, ptr [[TMP1]], i32 [[I_012]]
; CHECK-SOFT-NEXT:    [[TMP3:%.*]] = load double, ptr [[ARRAYIDX]], align 8
; CHECK-SOFT-NEXT:    [[CONV:%.*]] = fptosi double [[TMP3]] to i32
; CHECK-SOFT-NEXT:    [[ARRAYIDX3:%.*]] = getelementptr inbounds i32, ptr [[TMP2]], i32 [[I_012]]
; CHECK-SOFT-NEXT:    store i32 [[CONV]], ptr [[ARRAYIDX3]], align 4
; CHECK-SOFT-NEXT:    br label [[IF_END4]]
; CHECK-SOFT:       if.end4:
; CHECK-SOFT-NEXT:    [[INC]] = add nuw i32 [[I_012]], 1
; CHECK-SOFT-NEXT:    [[CMP1:%.*]] = icmp ult i32 [[INC]], [[N]]
; CHECK-SOFT-NEXT:    br i1 [[CMP1]], label [[WHILE_BODY]], label [[CLEANUP_LOOPEXIT:%.*]]
; CHECK-SOFT:       cleanup.loopexit:
; CHECK-SOFT-NEXT:    br label [[CLEANUP]]
; CHECK-SOFT:       cleanup:
; CHECK-SOFT-NEXT:    ret void
;
entry:
  %n.off = add i32 %n, -1
  %0 = icmp ult i32 %n.off, 500
  br i1 %0, label %while.body.lr.ph, label %cleanup

while.body.lr.ph:
  %1 = load ptr, ptr %d, align 4
  %2 = load ptr, ptr %g, align 4
  br label %while.body

while.body:
  %i.012 = phi i32 [ 0, %while.body.lr.ph ], [ %inc, %if.end4 ]
  %rem = urem i32 %i.012, 10
  %tobool = icmp eq i32 %rem, 0
  br i1 %tobool, label %if.end4, label %if.then2

if.then2:
  %arrayidx = getelementptr inbounds double, ptr %1, i32 %i.012
  %3 = load double, ptr %arrayidx, align 8
  %conv = fptosi double %3 to i32
  %arrayidx3 = getelementptr inbounds i32, ptr %2, i32 %i.012
  store i32 %conv, ptr %arrayidx3, align 4
  br label %if.end4

if.end4:
  %inc = add nuw i32 %i.012, 1
  %cmp1 = icmp ult i32 %inc, %n
  br i1 %cmp1, label %while.body, label %cleanup.loopexit

cleanup.loopexit:
  br label %cleanup

cleanup:
  ret void
}

define void @test_fptoui(i32 %n, ptr %g, ptr %d) {
; CHECK-FP-LABEL: define void @test_fptoui(
; CHECK-FP-SAME: i32 [[N:%.*]], ptr [[G:%.*]], ptr [[D:%.*]]) #[[ATTR0]] {
; CHECK-FP-NEXT:  entry:
; CHECK-FP-NEXT:    [[N_OFF:%.*]] = add i32 [[N]], -1
; CHECK-FP-NEXT:    [[TMP0:%.*]] = icmp ult i32 [[N_OFF]], 500
; CHECK-FP-NEXT:    br i1 [[TMP0]], label [[WHILE_BODY_LR_PH:%.*]], label [[CLEANUP:%.*]]
; CHECK-FP:       while.body.lr.ph:
; CHECK-FP-NEXT:    [[TMP1:%.*]] = load ptr, ptr [[D]], align 4
; CHECK-FP-NEXT:    [[TMP2:%.*]] = load ptr, ptr [[G]], align 4
; CHECK-FP-NEXT:    [[TMP3:%.*]] = call i32 @llvm.start.loop.iterations.i32(i32 [[N]])
; CHECK-FP-NEXT:    br label [[WHILE_BODY:%.*]]
; CHECK-FP:       while.body:
; CHECK-FP-NEXT:    [[I_012:%.*]] = phi i32 [ 0, [[WHILE_BODY_LR_PH]] ], [ [[INC:%.*]], [[IF_END4:%.*]] ]
; CHECK-FP-NEXT:    [[TMP4:%.*]] = phi i32 [ [[TMP3]], [[WHILE_BODY_LR_PH]] ], [ [[TMP6:%.*]], [[IF_END4]] ]
; CHECK-FP-NEXT:    [[REM:%.*]] = urem i32 [[I_012]], 10
; CHECK-FP-NEXT:    [[TOBOOL:%.*]] = icmp eq i32 [[REM]], 0
; CHECK-FP-NEXT:    br i1 [[TOBOOL]], label [[IF_END4]], label [[IF_THEN2:%.*]]
; CHECK-FP:       if.then2:
; CHECK-FP-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds double, ptr [[TMP1]], i32 [[I_012]]
; CHECK-FP-NEXT:    [[TMP5:%.*]] = load double, ptr [[ARRAYIDX]], align 8
; CHECK-FP-NEXT:    [[CONV:%.*]] = fptoui double [[TMP5]] to i32
; CHECK-FP-NEXT:    [[ARRAYIDX3:%.*]] = getelementptr inbounds i32, ptr [[TMP2]], i32 [[I_012]]
; CHECK-FP-NEXT:    store i32 [[CONV]], ptr [[ARRAYIDX3]], align 4
; CHECK-FP-NEXT:    br label [[IF_END4]]
; CHECK-FP:       if.end4:
; CHECK-FP-NEXT:    [[INC]] = add nuw i32 [[I_012]], 1
; CHECK-FP-NEXT:    [[TMP6]] = call i32 @llvm.loop.decrement.reg.i32(i32 [[TMP4]], i32 1)
; CHECK-FP-NEXT:    [[TMP7:%.*]] = icmp ne i32 [[TMP6]], 0
; CHECK-FP-NEXT:    br i1 [[TMP7]], label [[WHILE_BODY]], label [[CLEANUP_LOOPEXIT:%.*]]
; CHECK-FP:       cleanup.loopexit:
; CHECK-FP-NEXT:    br label [[CLEANUP]]
; CHECK-FP:       cleanup:
; CHECK-FP-NEXT:    ret void
;
; CHECK-SOFT-LABEL: define void @test_fptoui(
; CHECK-SOFT-SAME: i32 [[N:%.*]], ptr [[G:%.*]], ptr [[D:%.*]]) #[[ATTR0]] {
; CHECK-SOFT-NEXT:  entry:
; CHECK-SOFT-NEXT:    [[N_OFF:%.*]] = add i32 [[N]], -1
; CHECK-SOFT-NEXT:    [[TMP0:%.*]] = icmp ult i32 [[N_OFF]], 500
; CHECK-SOFT-NEXT:    br i1 [[TMP0]], label [[WHILE_BODY_LR_PH:%.*]], label [[CLEANUP:%.*]]
; CHECK-SOFT:       while.body.lr.ph:
; CHECK-SOFT-NEXT:    [[TMP1:%.*]] = load ptr, ptr [[D]], align 4
; CHECK-SOFT-NEXT:    [[TMP2:%.*]] = load ptr, ptr [[G]], align 4
; CHECK-SOFT-NEXT:    br label [[WHILE_BODY:%.*]]
; CHECK-SOFT:       while.body:
; CHECK-SOFT-NEXT:    [[I_012:%.*]] = phi i32 [ 0, [[WHILE_BODY_LR_PH]] ], [ [[INC:%.*]], [[IF_END4:%.*]] ]
; CHECK-SOFT-NEXT:    [[REM:%.*]] = urem i32 [[I_012]], 10
; CHECK-SOFT-NEXT:    [[TOBOOL:%.*]] = icmp eq i32 [[REM]], 0
; CHECK-SOFT-NEXT:    br i1 [[TOBOOL]], label [[IF_END4]], label [[IF_THEN2:%.*]]
; CHECK-SOFT:       if.then2:
; CHECK-SOFT-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds double, ptr [[TMP1]], i32 [[I_012]]
; CHECK-SOFT-NEXT:    [[TMP3:%.*]] = load double, ptr [[ARRAYIDX]], align 8
; CHECK-SOFT-NEXT:    [[CONV:%.*]] = fptoui double [[TMP3]] to i32
; CHECK-SOFT-NEXT:    [[ARRAYIDX3:%.*]] = getelementptr inbounds i32, ptr [[TMP2]], i32 [[I_012]]
; CHECK-SOFT-NEXT:    store i32 [[CONV]], ptr [[ARRAYIDX3]], align 4
; CHECK-SOFT-NEXT:    br label [[IF_END4]]
; CHECK-SOFT:       if.end4:
; CHECK-SOFT-NEXT:    [[INC]] = add nuw i32 [[I_012]], 1
; CHECK-SOFT-NEXT:    [[CMP1:%.*]] = icmp ult i32 [[INC]], [[N]]
; CHECK-SOFT-NEXT:    br i1 [[CMP1]], label [[WHILE_BODY]], label [[CLEANUP_LOOPEXIT:%.*]]
; CHECK-SOFT:       cleanup.loopexit:
; CHECK-SOFT-NEXT:    br label [[CLEANUP]]
; CHECK-SOFT:       cleanup:
; CHECK-SOFT-NEXT:    ret void
;
entry:
  %n.off = add i32 %n, -1
  %0 = icmp ult i32 %n.off, 500
  br i1 %0, label %while.body.lr.ph, label %cleanup

while.body.lr.ph:
  %1 = load ptr, ptr %d, align 4
  %2 = load ptr, ptr %g, align 4
  br label %while.body

while.body:
  %i.012 = phi i32 [ 0, %while.body.lr.ph ], [ %inc, %if.end4 ]
  %rem = urem i32 %i.012, 10
  %tobool = icmp eq i32 %rem, 0
  br i1 %tobool, label %if.end4, label %if.then2

if.then2:
  %arrayidx = getelementptr inbounds double, ptr %1, i32 %i.012
  %3 = load double, ptr %arrayidx, align 8
  %conv = fptoui double %3 to i32
  %arrayidx3 = getelementptr inbounds i32, ptr %2, i32 %i.012
  store i32 %conv, ptr %arrayidx3, align 4
  br label %if.end4

if.end4:
  %inc = add nuw i32 %i.012, 1
  %cmp1 = icmp ult i32 %inc, %n
  br i1 %cmp1, label %while.body, label %cleanup.loopexit

cleanup.loopexit:
  br label %cleanup

cleanup:
  ret void
}

define void @load_store_float(i32 %n, ptr %d, ptr %g) {
; CHECK-LABEL: define void @load_store_float(
; CHECK-SAME: i32 [[N:%.*]], ptr [[D:%.*]], ptr [[G:%.*]]) #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[N_OFF:%.*]] = add i32 [[N]], -1
; CHECK-NEXT:    [[TMP0:%.*]] = icmp ult i32 [[N_OFF]], 500
; CHECK-NEXT:    br i1 [[TMP0]], label [[WHILE_BODY_LR_PH:%.*]], label [[CLEANUP:%.*]]
; CHECK:       while.body.lr.ph:
; CHECK-NEXT:    [[TMP1:%.*]] = load ptr, ptr [[D]], align 4
; CHECK-NEXT:    [[TMP2:%.*]] = load ptr, ptr [[G]], align 4
; CHECK-NEXT:    [[TMP3:%.*]] = call i32 @llvm.start.loop.iterations.i32(i32 [[N]])
; CHECK-NEXT:    br label [[WHILE_BODY:%.*]]
; CHECK:       while.body:
; CHECK-NEXT:    [[I_012:%.*]] = phi i32 [ 0, [[WHILE_BODY_LR_PH]] ], [ [[INC:%.*]], [[IF_END4:%.*]] ]
; CHECK-NEXT:    [[TMP4:%.*]] = phi i32 [ [[TMP3]], [[WHILE_BODY_LR_PH]] ], [ [[TMP6:%.*]], [[IF_END4]] ]
; CHECK-NEXT:    [[REM:%.*]] = urem i32 [[I_012]], 10
; CHECK-NEXT:    [[TOBOOL:%.*]] = icmp eq i32 [[REM]], 0
; CHECK-NEXT:    br i1 [[TOBOOL]], label [[IF_END4]], label [[IF_THEN2:%.*]]
; CHECK:       if.then2:
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds double, ptr [[TMP1]], i32 [[I_012]]
; CHECK-NEXT:    [[TMP5:%.*]] = load double, ptr [[ARRAYIDX]], align 8
; CHECK-NEXT:    [[ARRAYIDX3:%.*]] = getelementptr inbounds double, ptr [[TMP2]], i32 [[I_012]]
; CHECK-NEXT:    store double [[TMP5]], ptr [[ARRAYIDX3]], align 8
; CHECK-NEXT:    br label [[IF_END4]]
; CHECK:       if.end4:
; CHECK-NEXT:    [[INC]] = add nuw i32 [[I_012]], 1
; CHECK-NEXT:    [[TMP6]] = call i32 @llvm.loop.decrement.reg.i32(i32 [[TMP4]], i32 1)
; CHECK-NEXT:    [[TMP7:%.*]] = icmp ne i32 [[TMP6]], 0
; CHECK-NEXT:    br i1 [[TMP7]], label [[WHILE_BODY]], label [[CLEANUP_LOOPEXIT:%.*]]
; CHECK:       cleanup.loopexit:
; CHECK-NEXT:    br label [[CLEANUP]]
; CHECK:       cleanup:
; CHECK-NEXT:    ret void
;
entry:
  %n.off = add i32 %n, -1
  %0 = icmp ult i32 %n.off, 500
  br i1 %0, label %while.body.lr.ph, label %cleanup

while.body.lr.ph:
  %1 = load ptr, ptr %d, align 4
  %2 = load ptr, ptr %g, align 4
  br label %while.body

while.body:
  %i.012 = phi i32 [ 0, %while.body.lr.ph ], [ %inc, %if.end4 ]
  %rem = urem i32 %i.012, 10
  %tobool = icmp eq i32 %rem, 0
  br i1 %tobool, label %if.end4, label %if.then2

if.then2:
  %arrayidx = getelementptr inbounds double, ptr %1, i32 %i.012
  %3 = load double, ptr %arrayidx, align 8
  %arrayidx3 = getelementptr inbounds double, ptr %2, i32 %i.012
  store double %3, ptr %arrayidx3, align 8
  br label %if.end4

if.end4:
  %inc = add nuw i32 %i.012, 1
  %cmp1 = icmp ult i32 %inc, %n
  br i1 %cmp1, label %while.body, label %cleanup.loopexit

cleanup.loopexit:
  br label %cleanup

cleanup:
  ret void
}

define void @fp_add(i32 %n, ptr %d, ptr %g) {
; CHECK-FP-LABEL: define void @fp_add(
; CHECK-FP-SAME: i32 [[N:%.*]], ptr [[D:%.*]], ptr [[G:%.*]]) #[[ATTR0]] {
; CHECK-FP-NEXT:  entry:
; CHECK-FP-NEXT:    [[N_OFF:%.*]] = add i32 [[N]], -1
; CHECK-FP-NEXT:    [[TMP0:%.*]] = icmp ult i32 [[N_OFF]], 500
; CHECK-FP-NEXT:    br i1 [[TMP0]], label [[WHILE_BODY_LR_PH:%.*]], label [[CLEANUP:%.*]]
; CHECK-FP:       while.body.lr.ph:
; CHECK-FP-NEXT:    [[TMP1:%.*]] = load ptr, ptr [[D]], align 4
; CHECK-FP-NEXT:    [[TMP2:%.*]] = load ptr, ptr [[G]], align 4
; CHECK-FP-NEXT:    [[TMP3:%.*]] = call i32 @llvm.start.loop.iterations.i32(i32 [[N]])
; CHECK-FP-NEXT:    br label [[WHILE_BODY:%.*]]
; CHECK-FP:       while.body:
; CHECK-FP-NEXT:    [[I_012:%.*]] = phi i32 [ 0, [[WHILE_BODY_LR_PH]] ], [ [[INC:%.*]], [[IF_END4:%.*]] ]
; CHECK-FP-NEXT:    [[TMP4:%.*]] = phi i32 [ [[TMP3]], [[WHILE_BODY_LR_PH]] ], [ [[TMP7:%.*]], [[IF_END4]] ]
; CHECK-FP-NEXT:    [[REM:%.*]] = urem i32 [[I_012]], 10
; CHECK-FP-NEXT:    [[TOBOOL:%.*]] = icmp eq i32 [[REM]], 0
; CHECK-FP-NEXT:    br i1 [[TOBOOL]], label [[IF_END4]], label [[IF_THEN2:%.*]]
; CHECK-FP:       if.then2:
; CHECK-FP-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds float, ptr [[TMP1]], i32 [[I_012]]
; CHECK-FP-NEXT:    [[TMP5:%.*]] = load float, ptr [[ARRAYIDX]], align 4
; CHECK-FP-NEXT:    [[ARRAYIDX3:%.*]] = getelementptr inbounds float, ptr [[TMP2]], i32 [[I_012]]
; CHECK-FP-NEXT:    [[TMP6:%.*]] = load float, ptr [[ARRAYIDX3]], align 4
; CHECK-FP-NEXT:    [[ADD:%.*]] = fadd float [[TMP5]], [[TMP6]]
; CHECK-FP-NEXT:    store float [[ADD]], ptr [[ARRAYIDX3]], align 4
; CHECK-FP-NEXT:    br label [[IF_END4]]
; CHECK-FP:       if.end4:
; CHECK-FP-NEXT:    [[INC]] = add nuw i32 [[I_012]], 1
; CHECK-FP-NEXT:    [[TMP7]] = call i32 @llvm.loop.decrement.reg.i32(i32 [[TMP4]], i32 1)
; CHECK-FP-NEXT:    [[TMP8:%.*]] = icmp ne i32 [[TMP7]], 0
; CHECK-FP-NEXT:    br i1 [[TMP8]], label [[WHILE_BODY]], label [[CLEANUP_LOOPEXIT:%.*]]
; CHECK-FP:       cleanup.loopexit:
; CHECK-FP-NEXT:    br label [[CLEANUP]]
; CHECK-FP:       cleanup:
; CHECK-FP-NEXT:    ret void
;
; CHECK-SOFT-LABEL: define void @fp_add(
; CHECK-SOFT-SAME: i32 [[N:%.*]], ptr [[D:%.*]], ptr [[G:%.*]]) #[[ATTR0]] {
; CHECK-SOFT-NEXT:  entry:
; CHECK-SOFT-NEXT:    [[N_OFF:%.*]] = add i32 [[N]], -1
; CHECK-SOFT-NEXT:    [[TMP0:%.*]] = icmp ult i32 [[N_OFF]], 500
; CHECK-SOFT-NEXT:    br i1 [[TMP0]], label [[WHILE_BODY_LR_PH:%.*]], label [[CLEANUP:%.*]]
; CHECK-SOFT:       while.body.lr.ph:
; CHECK-SOFT-NEXT:    [[TMP1:%.*]] = load ptr, ptr [[D]], align 4
; CHECK-SOFT-NEXT:    [[TMP2:%.*]] = load ptr, ptr [[G]], align 4
; CHECK-SOFT-NEXT:    br label [[WHILE_BODY:%.*]]
; CHECK-SOFT:       while.body:
; CHECK-SOFT-NEXT:    [[I_012:%.*]] = phi i32 [ 0, [[WHILE_BODY_LR_PH]] ], [ [[INC:%.*]], [[IF_END4:%.*]] ]
; CHECK-SOFT-NEXT:    [[REM:%.*]] = urem i32 [[I_012]], 10
; CHECK-SOFT-NEXT:    [[TOBOOL:%.*]] = icmp eq i32 [[REM]], 0
; CHECK-SOFT-NEXT:    br i1 [[TOBOOL]], label [[IF_END4]], label [[IF_THEN2:%.*]]
; CHECK-SOFT:       if.then2:
; CHECK-SOFT-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds float, ptr [[TMP1]], i32 [[I_012]]
; CHECK-SOFT-NEXT:    [[TMP3:%.*]] = load float, ptr [[ARRAYIDX]], align 4
; CHECK-SOFT-NEXT:    [[ARRAYIDX3:%.*]] = getelementptr inbounds float, ptr [[TMP2]], i32 [[I_012]]
; CHECK-SOFT-NEXT:    [[TMP4:%.*]] = load float, ptr [[ARRAYIDX3]], align 4
; CHECK-SOFT-NEXT:    [[ADD:%.*]] = fadd float [[TMP3]], [[TMP4]]
; CHECK-SOFT-NEXT:    store float [[ADD]], ptr [[ARRAYIDX3]], align 4
; CHECK-SOFT-NEXT:    br label [[IF_END4]]
; CHECK-SOFT:       if.end4:
; CHECK-SOFT-NEXT:    [[INC]] = add nuw i32 [[I_012]], 1
; CHECK-SOFT-NEXT:    [[CMP1:%.*]] = icmp ult i32 [[INC]], [[N]]
; CHECK-SOFT-NEXT:    br i1 [[CMP1]], label [[WHILE_BODY]], label [[CLEANUP_LOOPEXIT:%.*]]
; CHECK-SOFT:       cleanup.loopexit:
; CHECK-SOFT-NEXT:    br label [[CLEANUP]]
; CHECK-SOFT:       cleanup:
; CHECK-SOFT-NEXT:    ret void
;
entry:
  %n.off = add i32 %n, -1
  %0 = icmp ult i32 %n.off, 500
  br i1 %0, label %while.body.lr.ph, label %cleanup

while.body.lr.ph:
  %1 = load ptr, ptr %d, align 4
  %2 = load ptr, ptr %g, align 4
  br label %while.body

while.body:
  %i.012 = phi i32 [ 0, %while.body.lr.ph ], [ %inc, %if.end4 ]
  %rem = urem i32 %i.012, 10
  %tobool = icmp eq i32 %rem, 0
  br i1 %tobool, label %if.end4, label %if.then2

if.then2:
  %arrayidx = getelementptr inbounds float, ptr %1, i32 %i.012
  %3 = load float, ptr %arrayidx, align 4
  %arrayidx3 = getelementptr inbounds float, ptr %2, i32 %i.012
  %4 = load float, ptr %arrayidx3, align 4
  %add = fadd float %3, %4
  store float %add, ptr %arrayidx3, align 4
  br label %if.end4

if.end4:
  %inc = add nuw i32 %i.012, 1
  %cmp1 = icmp ult i32 %inc, %n
  br i1 %cmp1, label %while.body, label %cleanup.loopexit

cleanup.loopexit:
  br label %cleanup

cleanup:
  ret void
}
