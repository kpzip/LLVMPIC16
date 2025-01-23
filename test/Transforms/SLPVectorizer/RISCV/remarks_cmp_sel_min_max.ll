; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=slp-vectorizer -S -mtriple=riscv64-unknown-linux -mattr=+v -pass-remarks-output=%t | FileCheck %s
; RUN: FileCheck %s --check-prefix=YAML < %t

; YAML-LABEL: --- !Passed
; YAML-NEXT:  Pass:            slp-vectorizer
; YAML-NEXT:  Name:            StoresVectorized
; YAML-NEXT:  Function:        min_double
; YAML-NEXT:  Args:
; YAML-NEXT:    - String:          'Stores SLP vectorized with cost '
; YAML-NEXT:    - Cost:            '-1'
; YAML-NEXT:    - String:          ' and with tree size '
; YAML-NEXT:    - TreeSize:        '6'
define i32 @min_double(ptr noalias nocapture %A, ptr noalias nocapture %B) {
; CHECK-LABEL: @min_double(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds double, ptr [[B:%.*]], i64 10
; CHECK-NEXT:    [[TMP0:%.*]] = load <2 x double>, ptr [[ARRAYIDX]], align 8
; CHECK-NEXT:    [[TMP1:%.*]] = fcmp olt <2 x double> [[TMP0]], zeroinitializer
; CHECK-NEXT:    [[TMP2:%.*]] = select <2 x i1> [[TMP1]], <2 x double> [[TMP0]], <2 x double> zeroinitializer
; CHECK-NEXT:    store <2 x double> [[TMP2]], ptr [[A:%.*]], align 8
; CHECK-NEXT:    ret i32 undef
;
entry:
  %arrayidx = getelementptr inbounds double, ptr %B, i64 10
  %0 = load double, ptr %arrayidx, align 8
  %tobool = fcmp olt double %0, 0.000000e+00
  %cond = select i1 %tobool, double %0, double 0.000000e+00
  store double %cond, ptr %A, align 8
  %arrayidx2 = getelementptr inbounds double, ptr %B, i64 11
  %1 = load double, ptr %arrayidx2, align 8
  %tobool3 = fcmp olt double %1, 0.000000e+00
  %cond7 = select i1 %tobool3, double %1, double 0.000000e+00
  %arrayidx8 = getelementptr inbounds double, ptr %A, i64 1
  store double %cond7, ptr %arrayidx8, align 8
  ret i32 undef
}

; YAML-LABEL: --- !Passed
; YAML-NEXT:  Pass:            slp-vectorizer
; YAML-NEXT:  Name:            StoresVectorized
; YAML-NEXT:  Function:        min_float
; YAML-NEXT:  Args:
; YAML-NEXT:    - String:          'Stores SLP vectorized with cost '
; YAML-NEXT:    - Cost:            '-2'
; YAML-NEXT:    - String:          ' and with tree size '
; YAML-NEXT:    - TreeSize:        '6'
define i32 @min_float(ptr noalias nocapture %A, ptr noalias nocapture %B) {
; CHECK-LABEL: @min_float(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds float, ptr [[B:%.*]], i64 10
; CHECK-NEXT:    [[TMP0:%.*]] = load <2 x float>, ptr [[ARRAYIDX]], align 8
; CHECK-NEXT:    [[TMP1:%.*]] = fcmp ule <2 x float> [[TMP0]], zeroinitializer
; CHECK-NEXT:    [[TMP2:%.*]] = select <2 x i1> [[TMP1]], <2 x float> [[TMP0]], <2 x float> zeroinitializer
; CHECK-NEXT:    store <2 x float> [[TMP2]], ptr [[A:%.*]], align 8
; CHECK-NEXT:    ret i32 undef
;
entry:
  %arrayidx = getelementptr inbounds float, ptr %B, i64 10
  %0 = load float, ptr %arrayidx, align 8
  %tobool = fcmp ule float %0, 0.000000e+00
  %cond = select i1 %tobool, float %0, float 0.000000e+00
  store float %cond, ptr %A, align 8
  %arrayidx2 = getelementptr inbounds float, ptr %B, i64 11
  %1 = load float, ptr %arrayidx2, align 8
  %tobool3 = fcmp ule float %1, 0.000000e+00
  %cond7 = select i1 %tobool3, float %1, float 0.000000e+00
  %arrayidx8 = getelementptr inbounds float, ptr %A, i64 1
  store float %cond7, ptr %arrayidx8, align 8
  ret i32 undef
}

; YAML-LABEL: --- !Passed
; YAML-NEXT:  Pass:            slp-vectorizer
; YAML-NEXT:  Name:            StoresVectorized
; YAML-NEXT:  Function:        max_double
; YAML-NEXT:  Args:
; YAML-NEXT:    - String:          'Stores SLP vectorized with cost '
; YAML-NEXT:    - Cost:            '-1'
; YAML-NEXT:    - String:          ' and with tree size '
; YAML-NEXT:    - TreeSize:        '6'
define i32 @max_double(ptr noalias nocapture %A, ptr noalias nocapture %B) {
; CHECK-LABEL: @max_double(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds double, ptr [[B:%.*]], i64 10
; CHECK-NEXT:    [[TMP0:%.*]] = load <2 x double>, ptr [[ARRAYIDX]], align 8
; CHECK-NEXT:    [[TMP1:%.*]] = fcmp ogt <2 x double> [[TMP0]], zeroinitializer
; CHECK-NEXT:    [[TMP2:%.*]] = select <2 x i1> [[TMP1]], <2 x double> [[TMP0]], <2 x double> zeroinitializer
; CHECK-NEXT:    store <2 x double> [[TMP2]], ptr [[A:%.*]], align 8
; CHECK-NEXT:    ret i32 undef
;
entry:
  %arrayidx = getelementptr inbounds double, ptr %B, i64 10
  %0 = load double, ptr %arrayidx, align 8
  %tobool = fcmp ogt double %0, 0.000000e+00
  %cond = select i1 %tobool, double %0, double 0.000000e+00
  store double %cond, ptr %A, align 8
  %arrayidx2 = getelementptr inbounds double, ptr %B, i64 11
  %1 = load double, ptr %arrayidx2, align 8
  %tobool3 = fcmp ogt double %1, 0.000000e+00
  %cond7 = select i1 %tobool3, double %1, double 0.000000e+00
  %arrayidx8 = getelementptr inbounds double, ptr %A, i64 1
  store double %cond7, ptr %arrayidx8, align 8
  ret i32 undef
}

; YAML-LABEL: --- !Passed
; YAML-NEXT:  Pass:            slp-vectorizer
; YAML-NEXT:  Name:            StoresVectorized
; YAML-NEXT:  Function:        max_float
; YAML-NEXT:  Args:
; YAML-NEXT:    - String:          'Stores SLP vectorized with cost '
; YAML-NEXT:    - Cost:            '-2'
; YAML-NEXT:    - String:          ' and with tree size '
; YAML-NEXT:    - TreeSize:        '6'
define i32 @max_float(ptr noalias nocapture %A, ptr noalias nocapture %B) {
; CHECK-LABEL: @max_float(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds float, ptr [[B:%.*]], i64 10
; CHECK-NEXT:    [[TMP0:%.*]] = load <2 x float>, ptr [[ARRAYIDX]], align 8
; CHECK-NEXT:    [[TMP1:%.*]] = fcmp uge <2 x float> [[TMP0]], zeroinitializer
; CHECK-NEXT:    [[TMP2:%.*]] = select <2 x i1> [[TMP1]], <2 x float> [[TMP0]], <2 x float> zeroinitializer
; CHECK-NEXT:    store <2 x float> [[TMP2]], ptr [[A:%.*]], align 8
; CHECK-NEXT:    ret i32 undef
;
entry:
  %arrayidx = getelementptr inbounds float, ptr %B, i64 10
  %0 = load float, ptr %arrayidx, align 8
  %tobool = fcmp uge float %0, 0.000000e+00
  %cond = select i1 %tobool, float %0, float 0.000000e+00
  store float %cond, ptr %A, align 8
  %arrayidx2 = getelementptr inbounds float, ptr %B, i64 11
  %1 = load float, ptr %arrayidx2, align 8
  %tobool3 = fcmp uge float %1, 0.000000e+00
  %cond7 = select i1 %tobool3, float %1, float 0.000000e+00
  %arrayidx8 = getelementptr inbounds float, ptr %A, i64 1
  store float %cond7, ptr %arrayidx8, align 8
  ret i32 undef
}

