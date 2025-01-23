; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=slp-vectorizer -slp-vectorize-non-power-of-2 -mtriple=arm64-apple-ios -S %s | FileCheck --check-prefixes=CHECK %s
; RUN: opt -passes=slp-vectorizer -slp-vectorize-non-power-of-2=false -mtriple=arm64-apple-ios -S %s | FileCheck --check-prefixes=CHECK %s

define void @vec3_vectorize_call(ptr %Colour, float %0) {
; CHECK-LABEL: @vec3_vectorize_call(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP1:%.*]] = load <2 x float>, ptr [[COLOUR:%.*]], align 4
; CHECK-NEXT:    [[TMP2:%.*]] = call <2 x float> @llvm.fmuladd.v2f32(<2 x float> [[TMP1]], <2 x float> zeroinitializer, <2 x float> zeroinitializer)
; CHECK-NEXT:    store <2 x float> [[TMP2]], ptr [[COLOUR]], align 4
; CHECK-NEXT:    [[ARRAYIDX99_I1:%.*]] = getelementptr float, ptr [[COLOUR]], i64 2
; CHECK-NEXT:    [[TMP3:%.*]] = call float @llvm.fmuladd.f32(float [[TMP0:%.*]], float 0.000000e+00, float 0.000000e+00)
; CHECK-NEXT:    store float [[TMP3]], ptr [[ARRAYIDX99_I1]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %1 = load float, ptr %Colour, align 4
  %2 = call float @llvm.fmuladd.f32(float %1, float 0.000000e+00, float 0.000000e+00)
  store float %2, ptr %Colour, align 4
  %arrayidx91.i = getelementptr float, ptr %Colour, i64 1
  %3 = load float, ptr %arrayidx91.i, align 4
  %4 = call float @llvm.fmuladd.f32(float %3, float 0.000000e+00, float 0.000000e+00)
  store float %4, ptr %arrayidx91.i, align 4
  %arrayidx99.i1 = getelementptr float, ptr %Colour, i64 2
  %5 = call float @llvm.fmuladd.f32(float %0, float 0.000000e+00, float 0.000000e+00)
  store float %5, ptr %arrayidx99.i1, align 4
  ret void
}

define void @vec3_fmuladd_64(ptr %Colour, double %0) {
; CHECK-LABEL: @vec3_fmuladd_64(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ARRAYIDX80:%.*]] = getelementptr float, ptr [[COLOUR:%.*]], i64 2
; CHECK-NEXT:    [[TMP1:%.*]] = insertelement <2 x double> poison, double [[TMP0:%.*]], i32 0
; CHECK-NEXT:    [[TMP2:%.*]] = shufflevector <2 x double> [[TMP1]], <2 x double> poison, <2 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP3:%.*]] = call <2 x double> @llvm.fmuladd.v2f64(<2 x double> [[TMP2]], <2 x double> zeroinitializer, <2 x double> zeroinitializer)
; CHECK-NEXT:    [[TMP4:%.*]] = fptrunc <2 x double> [[TMP3]] to <2 x float>
; CHECK-NEXT:    store <2 x float> [[TMP4]], ptr [[COLOUR]], align 4
; CHECK-NEXT:    [[TMP5:%.*]] = call double @llvm.fmuladd.f64(double [[TMP0]], double 0.000000e+00, double 0.000000e+00)
; CHECK-NEXT:    [[CONV82:%.*]] = fptrunc double [[TMP5]] to float
; CHECK-NEXT:    store float [[CONV82]], ptr [[ARRAYIDX80]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %arrayidx72 = getelementptr float, ptr %Colour, i64 1
  %arrayidx80 = getelementptr float, ptr %Colour, i64 2
  %1 = call double @llvm.fmuladd.f64(double %0, double 0.000000e+00, double 0.000000e+00)
  %conv66 = fptrunc double %1 to float
  store float %conv66, ptr %Colour, align 4
  %2 = call double @llvm.fmuladd.f64(double %0, double 0.000000e+00, double 0.000000e+00)
  %conv74 = fptrunc double %2 to float
  store float %conv74, ptr %arrayidx72, align 4
  %3 = call double @llvm.fmuladd.f64(double %0, double 0.000000e+00, double 0.000000e+00)
  %conv82 = fptrunc double %3 to float
  store float %conv82, ptr %arrayidx80, align 4
  ret void
}

declare float @llvm.fmuladd.f32(float, float, float)

declare double @llvm.fmuladd.f64(double, double, double)
