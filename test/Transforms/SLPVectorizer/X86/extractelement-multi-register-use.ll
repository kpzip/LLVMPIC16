; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 4
; RUN: opt -passes=slp-vectorizer -S -mtriple=x86_64-unknown-linux-gnu -mcpu=x86-64-v3 < %s | FileCheck %s

define void @test(double %i) {
; CHECK-LABEL: define void @test(
; CHECK-SAME: double [[I:%.*]]) #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[TMP0:%.*]] = insertelement <2 x double> poison, double [[I]], i32 0
; CHECK-NEXT:    [[TMP1:%.*]] = fsub <2 x double> zeroinitializer, [[TMP0]]
; CHECK-NEXT:    [[TMP2:%.*]] = insertelement <2 x double> <double 0.000000e+00, double poison>, double [[I]], i32 1
; CHECK-NEXT:    [[TMP3:%.*]] = fsub <2 x double> zeroinitializer, [[TMP2]]
; CHECK-NEXT:    [[TMP4:%.*]] = extractelement <2 x double> [[TMP3]], i32 1
; CHECK-NEXT:    [[TMP5:%.*]] = fsub <2 x double> [[TMP0]], zeroinitializer
; CHECK-NEXT:    [[TMP6:%.*]] = shufflevector <2 x double> [[TMP5]], <2 x double> [[TMP3]], <4 x i32> <i32 poison, i32 poison, i32 0, i32 3>
; CHECK-NEXT:    [[TMP7:%.*]] = shufflevector <2 x double> [[TMP1]], <2 x double> [[TMP5]], <4 x i32> <i32 poison, i32 0, i32 2, i32 poison>
; CHECK-NEXT:    [[TMP8:%.*]] = shufflevector <4 x double> [[TMP6]], <4 x double> [[TMP7]], <8 x i32> <i32 poison, i32 poison, i32 2, i32 3, i32 poison, i32 5, i32 6, i32 poison>
; CHECK-NEXT:    [[TMP9:%.*]] = shufflevector <8 x double> [[TMP8]], <8 x double> <double 0.000000e+00, double 0.000000e+00, double poison, double poison, double 0.000000e+00, double poison, double poison, double poison>, <8 x i32> <i32 8, i32 9, i32 2, i32 3, i32 12, i32 5, i32 6, i32 poison>
; CHECK-NEXT:    [[TMP10:%.*]] = insertelement <8 x double> [[TMP9]], double [[TMP4]], i32 7
; CHECK-NEXT:    [[TMP11:%.*]] = fmul <8 x double> zeroinitializer, [[TMP10]]
; CHECK-NEXT:    [[TMP12:%.*]] = fadd <8 x double> zeroinitializer, [[TMP11]]
; CHECK-NEXT:    [[TMP13:%.*]] = fadd <8 x double> [[TMP12]], zeroinitializer
; CHECK-NEXT:    [[TMP14:%.*]] = fcmp ult <8 x double> [[TMP13]], zeroinitializer
; CHECK-NEXT:    br label [[BB116:%.*]]
; CHECK:       bb116:
; CHECK-NEXT:    [[TMP15:%.*]] = fmul <2 x double> zeroinitializer, [[TMP5]]
; CHECK-NEXT:    [[TMP16:%.*]] = extractelement <2 x double> [[TMP15]], i32 0
; CHECK-NEXT:    [[TMP17:%.*]] = extractelement <2 x double> [[TMP15]], i32 1
; CHECK-NEXT:    [[I120:%.*]] = fadd double [[TMP16]], [[TMP17]]
; CHECK-NEXT:    [[TMP18:%.*]] = fmul <2 x double> zeroinitializer, [[TMP1]]
; CHECK-NEXT:    [[TMP19:%.*]] = fmul <2 x double> zeroinitializer, [[TMP3]]
; CHECK-NEXT:    [[TMP20:%.*]] = extractelement <2 x double> [[TMP18]], i32 0
; CHECK-NEXT:    [[TMP21:%.*]] = extractelement <2 x double> [[TMP18]], i32 1
; CHECK-NEXT:    [[I128:%.*]] = fadd double [[TMP20]], [[TMP21]]
; CHECK-NEXT:    [[I139:%.*]] = call double @llvm.maxnum.f64(double [[I128]], double 0.000000e+00)
; CHECK-NEXT:    [[TMP22:%.*]] = fadd <2 x double> [[TMP19]], zeroinitializer
; CHECK-NEXT:    [[TMP23:%.*]] = call <2 x double> @llvm.maxnum.v2f64(<2 x double> [[TMP22]], <2 x double> zeroinitializer)
; CHECK-NEXT:    [[TMP24:%.*]] = fmul <2 x double> [[TMP23]], zeroinitializer
; CHECK-NEXT:    [[TMP25:%.*]] = fptosi <2 x double> [[TMP24]] to <2 x i32>
; CHECK-NEXT:    [[TMP26:%.*]] = sub <2 x i32> zeroinitializer, [[TMP25]]
; CHECK-NEXT:    [[TMP27:%.*]] = icmp sgt <2 x i32> [[TMP26]], zeroinitializer
; CHECK-NEXT:    [[I147:%.*]] = fcmp ogt double [[I120]], 0.000000e+00
; CHECK-NEXT:    ret void
;
bb:
  %i74 = fsub double 0.000000e+00, poison
  %i75 = fsub double 0.000000e+00, %i
  %i76 = fmul double 0.000000e+00, %i75
  %i77 = fadd double %i76, 0.000000e+00
  %i78 = fadd double %i77, 0.000000e+00
  %i79 = fcmp ult double %i78, 0.000000e+00
  %i81 = fsub double %i, 0.000000e+00
  %i82 = fmul double 0.000000e+00, %i81
  %i83 = fadd double 0.000000e+00, %i82
  %i84 = fadd double %i83, 0.000000e+00
  %i85 = fcmp ult double %i84, 0.000000e+00
  %i86 = fsub double 0.000000e+00, %i
  %i87 = fmul double 0.000000e+00, %i86
  %i88 = fadd double %i87, 0.000000e+00
  %i89 = fadd double %i88, 0.000000e+00
  %i90 = fcmp ult double %i89, 0.000000e+00
  %i91 = fsub double 0.000000e+00, 0.000000e+00
  %i92 = fmul double 0.000000e+00, 0.000000e+00
  %i93 = fadd double %i92, 0.000000e+00
  %i94 = fadd double %i93, 0.000000e+00
  %i95 = fcmp ult double %i94, 0.000000e+00
  %i96 = fsub double poison, 0.000000e+00
  %i97 = fadd double %i77, 0.000000e+00
  %i98 = fcmp ult double %i97, 0.000000e+00
  %i99 = fadd double %i83, 0.000000e+00
  %i100 = fcmp ult double %i99, 0.000000e+00
  %i101 = fmul double 0.000000e+00, 0.000000e+00
  %i102 = fadd double %i101, 0.000000e+00
  %i103 = fadd double %i102, 0.000000e+00
  %i104 = fcmp ult double %i103, 0.000000e+00
  %i105 = fmul double 0.000000e+00, 0.000000e+00
  %i106 = fadd double %i105, 0.000000e+00
  %i107 = fadd double %i106, 0.000000e+00
  %i108 = fcmp ult double %i107, 0.000000e+00
  br label %bb116

bb116:
  %i117 = fmul double 0.000000e+00, %i81
  %i119 = fmul double 0.000000e+00, %i96
  %i120 = fadd double %i117, %i119
  %i121 = fmul double 0.000000e+00, %i74
  %i122 = fmul double 0.000000e+00, %i75
  %i123 = fadd double %i122, 0.000000e+00
  %i124 = fmul double 0.000000e+00, %i91
  %i125 = fadd double %i124, 0.000000e+00
  %i127 = fmul double 0.000000e+00, %i86
  %i128 = fadd double %i127, %i121
  %i133 = call double @llvm.maxnum.f64(double %i123, double 0.000000e+00)
  %i134 = fmul double %i133, 0.000000e+00
  %i135 = fptosi double %i134 to i32
  %i136 = sub i32 0, %i135
  %i137 = icmp sgt i32 %i136, 0
  %i139 = call double @llvm.maxnum.f64(double %i128, double 0.000000e+00)
  %i142 = call double @llvm.maxnum.f64(double %i125, double 0.000000e+00)
  %i143 = fmul double %i142, 0.000000e+00
  %i144 = fptosi double %i143 to i32
  %i145 = sub i32 0, %i144
  %i146 = icmp sgt i32 %i145, 0
  %i147 = fcmp ogt double %i120, 0.000000e+00
  ret void
}

declare double @llvm.maxnum.f64(double, double)
