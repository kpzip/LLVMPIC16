; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --check-globals --version 2
; RUN: opt -S -vector-library=ArmPL -replace-with-veclib < %s | FileCheck %s

target triple = "aarch64-unknown-linux-gnu"

;
; The replace-with-veclib pass does not work with scalable types, thus
; the mappings aren't utilised. Tests will need to be regenerated when the
; pass is improved.
;

declare <2 x double> @llvm.cos.v2f64(<2 x double>)
declare <4 x float> @llvm.cos.v4f32(<4 x float>)
declare <vscale x 2 x double> @llvm.cos.nxv2f64(<vscale x 2 x double>)
declare <vscale x 4 x float> @llvm.cos.nxv4f32(<vscale x 4 x float>)

;.
; CHECK: @llvm.compiler.used = appending global [60 x ptr] [ptr @armpl_vcosq_f64, ptr @armpl_vcosq_f32, ptr @armpl_svcos_f64_x, ptr @armpl_svcos_f32_x, ptr @armpl_vexpq_f64, ptr @armpl_vexpq_f32, ptr @armpl_svexp_f64_x, ptr @armpl_svexp_f32_x, ptr @armpl_vexp10q_f64, ptr @armpl_vexp10q_f32, ptr @armpl_svexp10_f64_x, ptr @armpl_svexp10_f32_x, ptr @armpl_vexp2q_f64, ptr @armpl_vexp2q_f32, ptr @armpl_svexp2_f64_x, ptr @armpl_svexp2_f32_x, ptr @armpl_vlogq_f64, ptr @armpl_vlogq_f32, ptr @armpl_svlog_f64_x, ptr @armpl_svlog_f32_x, ptr @armpl_vlog10q_f64, ptr @armpl_vlog10q_f32, ptr @armpl_svlog10_f64_x, ptr @armpl_svlog10_f32_x, ptr @armpl_vlog2q_f64, ptr @armpl_vlog2q_f32, ptr @armpl_svlog2_f64_x, ptr @armpl_svlog2_f32_x, ptr @armpl_vsinq_f64, ptr @armpl_vsinq_f32, ptr @armpl_svsin_f64_x, ptr @armpl_svsin_f32_x, ptr @armpl_vtanq_f64, ptr @armpl_vtanq_f32, ptr @armpl_svtan_f64_x, ptr @armpl_svtan_f32_x, ptr @armpl_vacosq_f64, ptr @armpl_vacosq_f32, ptr @armpl_svacos_f64_x, ptr @armpl_svacos_f32_x, ptr @armpl_vasinq_f64, ptr @armpl_vasinq_f32, ptr @armpl_svasin_f64_x, ptr @armpl_svasin_f32_x, ptr @armpl_vatanq_f64, ptr @armpl_vatanq_f32, ptr @armpl_svatan_f64_x, ptr @armpl_svatan_f32_x, ptr @armpl_vcoshq_f64, ptr @armpl_vcoshq_f32, ptr @armpl_svcosh_f64_x, ptr @armpl_svcosh_f32_x, ptr @armpl_vsinhq_f64, ptr @armpl_vsinhq_f32, ptr @armpl_svsinh_f64_x, ptr @armpl_svsinh_f32_x, ptr @armpl_vtanhq_f64, ptr @armpl_vtanhq_f32, ptr @armpl_svtanh_f64_x, ptr @armpl_svtanh_f32_x], section "llvm.metadata"

;.
define <2 x double> @llvm_cos_f64(<2 x double> %in) {
; CHECK-LABEL: define <2 x double> @llvm_cos_f64
; CHECK-SAME: (<2 x double> [[IN:%.*]]) {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <2 x double> @armpl_vcosq_f64(<2 x double> [[IN]])
; CHECK-NEXT:    ret <2 x double> [[TMP1]]
;
  %1 = call fast <2 x double> @llvm.cos.v2f64(<2 x double> %in)
  ret <2 x double> %1
}

define <4 x float> @llvm_cos_f32(<4 x float> %in) {
; CHECK-LABEL: define <4 x float> @llvm_cos_f32
; CHECK-SAME: (<4 x float> [[IN:%.*]]) {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <4 x float> @armpl_vcosq_f32(<4 x float> [[IN]])
; CHECK-NEXT:    ret <4 x float> [[TMP1]]
;
  %1 = call fast <4 x float> @llvm.cos.v4f32(<4 x float> %in)
  ret <4 x float> %1
}

define <vscale x 2 x double> @llvm_cos_vscale_f64(<vscale x 2 x double> %in) #0 {
; CHECK-LABEL: define <vscale x 2 x double> @llvm_cos_vscale_f64
; CHECK-SAME: (<vscale x 2 x double> [[IN:%.*]]) #[[ATTR1:[0-9]+]] {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <vscale x 2 x double> @armpl_svcos_f64_x(<vscale x 2 x double> [[IN]], <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> poison, i1 true, i64 0), <vscale x 2 x i1> poison, <vscale x 2 x i32> zeroinitializer))
; CHECK-NEXT:    ret <vscale x 2 x double> [[TMP1]]
;
  %1 = call fast <vscale x 2 x double> @llvm.cos.nxv2f64(<vscale x 2 x double> %in)
  ret <vscale x 2 x double> %1
}

define <vscale x 4 x float> @llvm_cos_vscale_f32(<vscale x 4 x float> %in) #0 {
; CHECK-LABEL: define <vscale x 4 x float> @llvm_cos_vscale_f32
; CHECK-SAME: (<vscale x 4 x float> [[IN:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <vscale x 4 x float> @armpl_svcos_f32_x(<vscale x 4 x float> [[IN]], <vscale x 4 x i1> shufflevector (<vscale x 4 x i1> insertelement (<vscale x 4 x i1> poison, i1 true, i64 0), <vscale x 4 x i1> poison, <vscale x 4 x i32> zeroinitializer))
; CHECK-NEXT:    ret <vscale x 4 x float> [[TMP1]]
;
  %1 = call fast <vscale x 4 x float> @llvm.cos.nxv4f32(<vscale x 4 x float> %in)
  ret <vscale x 4 x float> %1
}

declare <2 x double> @llvm.exp.v2f64(<2 x double>)
declare <4 x float> @llvm.exp.v4f32(<4 x float>)
declare <vscale x 2 x double> @llvm.exp.nxv2f64(<vscale x 2 x double>)
declare <vscale x 4 x float> @llvm.exp.nxv4f32(<vscale x 4 x float>)

define <2 x double> @llvm_exp_f64(<2 x double> %in) {
; CHECK-LABEL: define <2 x double> @llvm_exp_f64
; CHECK-SAME: (<2 x double> [[IN:%.*]]) {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <2 x double> @armpl_vexpq_f64(<2 x double> [[IN]])
; CHECK-NEXT:    ret <2 x double> [[TMP1]]
;
  %1 = call fast <2 x double> @llvm.exp.v2f64(<2 x double> %in)
  ret <2 x double> %1
}

define <4 x float> @llvm_exp_f32(<4 x float> %in) {
; CHECK-LABEL: define <4 x float> @llvm_exp_f32
; CHECK-SAME: (<4 x float> [[IN:%.*]]) {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <4 x float> @armpl_vexpq_f32(<4 x float> [[IN]])
; CHECK-NEXT:    ret <4 x float> [[TMP1]]
;
  %1 = call fast <4 x float> @llvm.exp.v4f32(<4 x float> %in)
  ret <4 x float> %1
}

define <vscale x 2 x double> @llvm_exp_vscale_f64(<vscale x 2 x double> %in) #0 {
; CHECK-LABEL: define <vscale x 2 x double> @llvm_exp_vscale_f64
; CHECK-SAME: (<vscale x 2 x double> [[IN:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <vscale x 2 x double> @armpl_svexp_f64_x(<vscale x 2 x double> [[IN]], <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> poison, i1 true, i64 0), <vscale x 2 x i1> poison, <vscale x 2 x i32> zeroinitializer))
; CHECK-NEXT:    ret <vscale x 2 x double> [[TMP1]]
;
  %1 = call fast <vscale x 2 x double> @llvm.exp.nxv2f64(<vscale x 2 x double> %in)
  ret <vscale x 2 x double> %1
}

define <vscale x 4 x float> @llvm_exp_vscale_f32(<vscale x 4 x float> %in) #0 {
; CHECK-LABEL: define <vscale x 4 x float> @llvm_exp_vscale_f32
; CHECK-SAME: (<vscale x 4 x float> [[IN:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <vscale x 4 x float> @armpl_svexp_f32_x(<vscale x 4 x float> [[IN]], <vscale x 4 x i1> shufflevector (<vscale x 4 x i1> insertelement (<vscale x 4 x i1> poison, i1 true, i64 0), <vscale x 4 x i1> poison, <vscale x 4 x i32> zeroinitializer))
; CHECK-NEXT:    ret <vscale x 4 x float> [[TMP1]]
;
  %1 = call fast <vscale x 4 x float> @llvm.exp.nxv4f32(<vscale x 4 x float> %in)
  ret <vscale x 4 x float> %1
}

declare <2 x double> @llvm.exp10.v2f64(<2 x double>)
declare <4 x float> @llvm.exp10.v4f32(<4 x float>)
declare <vscale x 2 x double> @llvm.exp10.nxv2f64(<vscale x 2 x double>)
declare <vscale x 4 x float> @llvm.exp10.nxv4f32(<vscale x 4 x float>)

define <2 x double> @llvm_exp10_f64(<2 x double> %in) {
; CHECK-LABEL: define <2 x double> @llvm_exp10_f64
; CHECK-SAME: (<2 x double> [[IN:%.*]]) {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <2 x double> @armpl_vexp10q_f64(<2 x double> [[IN]])
; CHECK-NEXT:    ret <2 x double> [[TMP1]]
;
  %1 = call fast <2 x double> @llvm.exp10.v2f64(<2 x double> %in)
  ret <2 x double> %1
}

define <4 x float> @llvm_exp10_f32(<4 x float> %in) {
; CHECK-LABEL: define <4 x float> @llvm_exp10_f32
; CHECK-SAME: (<4 x float> [[IN:%.*]]) {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <4 x float> @armpl_vexp10q_f32(<4 x float> [[IN]])
; CHECK-NEXT:    ret <4 x float> [[TMP1]]
;
  %1 = call fast <4 x float> @llvm.exp10.v4f32(<4 x float> %in)
  ret <4 x float> %1
}

define <vscale x 2 x double> @llvm_exp10_vscale_f64(<vscale x 2 x double> %in) #0 {
; CHECK-LABEL: define <vscale x 2 x double> @llvm_exp10_vscale_f64
; CHECK-SAME: (<vscale x 2 x double> [[IN:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <vscale x 2 x double> @armpl_svexp10_f64_x(<vscale x 2 x double> [[IN]], <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> poison, i1 true, i64 0), <vscale x 2 x i1> poison, <vscale x 2 x i32> zeroinitializer))
; CHECK-NEXT:    ret <vscale x 2 x double> [[TMP1]]
;
  %1 = call fast <vscale x 2 x double> @llvm.exp10.nxv2f64(<vscale x 2 x double> %in)
  ret <vscale x 2 x double> %1
}

define <vscale x 4 x float> @llvm_exp10_vscale_f32(<vscale x 4 x float> %in) #0 {
; CHECK-LABEL: define <vscale x 4 x float> @llvm_exp10_vscale_f32
; CHECK-SAME: (<vscale x 4 x float> [[IN:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <vscale x 4 x float> @armpl_svexp10_f32_x(<vscale x 4 x float> [[IN]], <vscale x 4 x i1> shufflevector (<vscale x 4 x i1> insertelement (<vscale x 4 x i1> poison, i1 true, i64 0), <vscale x 4 x i1> poison, <vscale x 4 x i32> zeroinitializer))
; CHECK-NEXT:    ret <vscale x 4 x float> [[TMP1]]
;
  %1 = call fast <vscale x 4 x float> @llvm.exp10.nxv4f32(<vscale x 4 x float> %in)
  ret <vscale x 4 x float> %1
}

declare <2 x double> @llvm.exp2.v2f64(<2 x double>)
declare <4 x float> @llvm.exp2.v4f32(<4 x float>)
declare <vscale x 2 x double> @llvm.exp2.nxv2f64(<vscale x 2 x double>)
declare <vscale x 4 x float> @llvm.exp2.nxv4f32(<vscale x 4 x float>)

define <2 x double> @llvm_exp2_f64(<2 x double> %in) {
; CHECK-LABEL: define <2 x double> @llvm_exp2_f64
; CHECK-SAME: (<2 x double> [[IN:%.*]]) {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <2 x double> @armpl_vexp2q_f64(<2 x double> [[IN]])
; CHECK-NEXT:    ret <2 x double> [[TMP1]]
;
  %1 = call fast <2 x double> @llvm.exp2.v2f64(<2 x double> %in)
  ret <2 x double> %1
}

define <4 x float> @llvm_exp2_f32(<4 x float> %in) {
; CHECK-LABEL: define <4 x float> @llvm_exp2_f32
; CHECK-SAME: (<4 x float> [[IN:%.*]]) {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <4 x float> @armpl_vexp2q_f32(<4 x float> [[IN]])
; CHECK-NEXT:    ret <4 x float> [[TMP1]]
;
  %1 = call fast <4 x float> @llvm.exp2.v4f32(<4 x float> %in)
  ret <4 x float> %1
}

define <vscale x 2 x double> @llvm_exp2_vscale_f64(<vscale x 2 x double> %in) #0 {
; CHECK-LABEL: define <vscale x 2 x double> @llvm_exp2_vscale_f64
; CHECK-SAME: (<vscale x 2 x double> [[IN:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <vscale x 2 x double> @armpl_svexp2_f64_x(<vscale x 2 x double> [[IN]], <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> poison, i1 true, i64 0), <vscale x 2 x i1> poison, <vscale x 2 x i32> zeroinitializer))
; CHECK-NEXT:    ret <vscale x 2 x double> [[TMP1]]
;
  %1 = call fast <vscale x 2 x double> @llvm.exp2.nxv2f64(<vscale x 2 x double> %in)
  ret <vscale x 2 x double> %1
}

define <vscale x 4 x float> @llvm_exp2_vscale_f32(<vscale x 4 x float> %in) #0 {
; CHECK-LABEL: define <vscale x 4 x float> @llvm_exp2_vscale_f32
; CHECK-SAME: (<vscale x 4 x float> [[IN:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <vscale x 4 x float> @armpl_svexp2_f32_x(<vscale x 4 x float> [[IN]], <vscale x 4 x i1> shufflevector (<vscale x 4 x i1> insertelement (<vscale x 4 x i1> poison, i1 true, i64 0), <vscale x 4 x i1> poison, <vscale x 4 x i32> zeroinitializer))
; CHECK-NEXT:    ret <vscale x 4 x float> [[TMP1]]
;
  %1 = call fast <vscale x 4 x float> @llvm.exp2.nxv4f32(<vscale x 4 x float> %in)
  ret <vscale x 4 x float> %1
}

declare <2 x double> @llvm.log.v2f64(<2 x double>)
declare <4 x float> @llvm.log.v4f32(<4 x float>)
declare <vscale x 2 x double> @llvm.log.nxv2f64(<vscale x 2 x double>)
declare <vscale x 4 x float> @llvm.log.nxv4f32(<vscale x 4 x float>)

define <2 x double> @llvm_log_f64(<2 x double> %in) {
; CHECK-LABEL: define <2 x double> @llvm_log_f64
; CHECK-SAME: (<2 x double> [[IN:%.*]]) {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <2 x double> @armpl_vlogq_f64(<2 x double> [[IN]])
; CHECK-NEXT:    ret <2 x double> [[TMP1]]
;
  %1 = call fast <2 x double> @llvm.log.v2f64(<2 x double> %in)
  ret <2 x double> %1
}

define <4 x float> @llvm_log_f32(<4 x float> %in) {
; CHECK-LABEL: define <4 x float> @llvm_log_f32
; CHECK-SAME: (<4 x float> [[IN:%.*]]) {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <4 x float> @armpl_vlogq_f32(<4 x float> [[IN]])
; CHECK-NEXT:    ret <4 x float> [[TMP1]]
;
  %1 = call fast <4 x float> @llvm.log.v4f32(<4 x float> %in)
  ret <4 x float> %1
}

define <vscale x 2 x double> @llvm_log_vscale_f64(<vscale x 2 x double> %in) #0 {
; CHECK-LABEL: define <vscale x 2 x double> @llvm_log_vscale_f64
; CHECK-SAME: (<vscale x 2 x double> [[IN:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <vscale x 2 x double> @armpl_svlog_f64_x(<vscale x 2 x double> [[IN]], <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> poison, i1 true, i64 0), <vscale x 2 x i1> poison, <vscale x 2 x i32> zeroinitializer))
; CHECK-NEXT:    ret <vscale x 2 x double> [[TMP1]]
;
  %1 = call fast <vscale x 2 x double> @llvm.log.nxv2f64(<vscale x 2 x double> %in)
  ret <vscale x 2 x double> %1
}

define <vscale x 4 x float> @llvm_log_vscale_f32(<vscale x 4 x float> %in) #0 {
; CHECK-LABEL: define <vscale x 4 x float> @llvm_log_vscale_f32
; CHECK-SAME: (<vscale x 4 x float> [[IN:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <vscale x 4 x float> @armpl_svlog_f32_x(<vscale x 4 x float> [[IN]], <vscale x 4 x i1> shufflevector (<vscale x 4 x i1> insertelement (<vscale x 4 x i1> poison, i1 true, i64 0), <vscale x 4 x i1> poison, <vscale x 4 x i32> zeroinitializer))
; CHECK-NEXT:    ret <vscale x 4 x float> [[TMP1]]
;
  %1 = call fast <vscale x 4 x float> @llvm.log.nxv4f32(<vscale x 4 x float> %in)
  ret <vscale x 4 x float> %1
}

declare <2 x double> @llvm.log10.v2f64(<2 x double>)
declare <4 x float> @llvm.log10.v4f32(<4 x float>)
declare <vscale x 2 x double> @llvm.log10.nxv2f64(<vscale x 2 x double>)
declare <vscale x 4 x float> @llvm.log10.nxv4f32(<vscale x 4 x float>)

define <2 x double> @llvm_log10_f64(<2 x double> %in) {
; CHECK-LABEL: define <2 x double> @llvm_log10_f64
; CHECK-SAME: (<2 x double> [[IN:%.*]]) {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <2 x double> @armpl_vlog10q_f64(<2 x double> [[IN]])
; CHECK-NEXT:    ret <2 x double> [[TMP1]]
;
  %1 = call fast <2 x double> @llvm.log10.v2f64(<2 x double> %in)
  ret <2 x double> %1
}

define <4 x float> @llvm_log10_f32(<4 x float> %in) {
; CHECK-LABEL: define <4 x float> @llvm_log10_f32
; CHECK-SAME: (<4 x float> [[IN:%.*]]) {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <4 x float> @armpl_vlog10q_f32(<4 x float> [[IN]])
; CHECK-NEXT:    ret <4 x float> [[TMP1]]
;
  %1 = call fast <4 x float> @llvm.log10.v4f32(<4 x float> %in)
  ret <4 x float> %1
}

define <vscale x 2 x double> @llvm_log10_vscale_f64(<vscale x 2 x double> %in) #0 {
; CHECK-LABEL: define <vscale x 2 x double> @llvm_log10_vscale_f64
; CHECK-SAME: (<vscale x 2 x double> [[IN:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <vscale x 2 x double> @armpl_svlog10_f64_x(<vscale x 2 x double> [[IN]], <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> poison, i1 true, i64 0), <vscale x 2 x i1> poison, <vscale x 2 x i32> zeroinitializer))
; CHECK-NEXT:    ret <vscale x 2 x double> [[TMP1]]
;
  %1 = call fast <vscale x 2 x double> @llvm.log10.nxv2f64(<vscale x 2 x double> %in)
  ret <vscale x 2 x double> %1
}

define <vscale x 4 x float> @llvm_log10_vscale_f32(<vscale x 4 x float> %in) #0 {
; CHECK-LABEL: define <vscale x 4 x float> @llvm_log10_vscale_f32
; CHECK-SAME: (<vscale x 4 x float> [[IN:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <vscale x 4 x float> @armpl_svlog10_f32_x(<vscale x 4 x float> [[IN]], <vscale x 4 x i1> shufflevector (<vscale x 4 x i1> insertelement (<vscale x 4 x i1> poison, i1 true, i64 0), <vscale x 4 x i1> poison, <vscale x 4 x i32> zeroinitializer))
; CHECK-NEXT:    ret <vscale x 4 x float> [[TMP1]]
;
  %1 = call fast <vscale x 4 x float> @llvm.log10.nxv4f32(<vscale x 4 x float> %in)
  ret <vscale x 4 x float> %1
}

declare <2 x double> @llvm.log2.v2f64(<2 x double>)
declare <4 x float> @llvm.log2.v4f32(<4 x float>)
declare <vscale x 2 x double> @llvm.log2.nxv2f64(<vscale x 2 x double>)
declare <vscale x 4 x float> @llvm.log2.nxv4f32(<vscale x 4 x float>)

define <2 x double> @llvm_log2_f64(<2 x double> %in) {
; CHECK-LABEL: define <2 x double> @llvm_log2_f64
; CHECK-SAME: (<2 x double> [[IN:%.*]]) {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <2 x double> @armpl_vlog2q_f64(<2 x double> [[IN]])
; CHECK-NEXT:    ret <2 x double> [[TMP1]]
;
  %1 = call fast <2 x double> @llvm.log2.v2f64(<2 x double> %in)
  ret <2 x double> %1
}

define <4 x float> @llvm_log2_f32(<4 x float> %in) {
; CHECK-LABEL: define <4 x float> @llvm_log2_f32
; CHECK-SAME: (<4 x float> [[IN:%.*]]) {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <4 x float> @armpl_vlog2q_f32(<4 x float> [[IN]])
; CHECK-NEXT:    ret <4 x float> [[TMP1]]
;
  %1 = call fast <4 x float> @llvm.log2.v4f32(<4 x float> %in)
  ret <4 x float> %1
}

define <vscale x 2 x double> @llvm_log2_vscale_f64(<vscale x 2 x double> %in) #0 {
; CHECK-LABEL: define <vscale x 2 x double> @llvm_log2_vscale_f64
; CHECK-SAME: (<vscale x 2 x double> [[IN:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <vscale x 2 x double> @armpl_svlog2_f64_x(<vscale x 2 x double> [[IN]], <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> poison, i1 true, i64 0), <vscale x 2 x i1> poison, <vscale x 2 x i32> zeroinitializer))
; CHECK-NEXT:    ret <vscale x 2 x double> [[TMP1]]
;
  %1 = call fast <vscale x 2 x double> @llvm.log2.nxv2f64(<vscale x 2 x double> %in)
  ret <vscale x 2 x double> %1
}

define <vscale x 4 x float> @llvm_log2_vscale_f32(<vscale x 4 x float> %in) #0 {
; CHECK-LABEL: define <vscale x 4 x float> @llvm_log2_vscale_f32
; CHECK-SAME: (<vscale x 4 x float> [[IN:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <vscale x 4 x float> @armpl_svlog2_f32_x(<vscale x 4 x float> [[IN]], <vscale x 4 x i1> shufflevector (<vscale x 4 x i1> insertelement (<vscale x 4 x i1> poison, i1 true, i64 0), <vscale x 4 x i1> poison, <vscale x 4 x i32> zeroinitializer))
; CHECK-NEXT:    ret <vscale x 4 x float> [[TMP1]]
;
  %1 = call fast <vscale x 4 x float> @llvm.log2.nxv4f32(<vscale x 4 x float> %in)
  ret <vscale x 4 x float> %1
}

declare <2 x double> @llvm.pow.v2f64(<2 x double>, <2 x double>)
declare <4 x float> @llvm.pow.v4f32(<4 x float>, <4 x float>)
declare <vscale x 2 x double> @llvm.pow.nxv2f64(<vscale x 2 x double>, <vscale x 2 x double>)
declare <vscale x 4 x float> @llvm.pow.nxv4f32(<vscale x 4 x float>, <vscale x 4 x float>)

;
; There is a bug in the replace-with-veclib pass, and for intrinsics which take
; more than one arguments, but has just one overloaded type, it incorrectly
; reconstructs the scalar name, for pow specifically it is searching for:
; llvm.pow.f64.f64 and llvm.pow.f32.f32
;

define <2 x double> @llvm_pow_f64(<2 x double> %in, <2 x double> %power) {
; CHECK-LABEL: define <2 x double> @llvm_pow_f64
; CHECK-SAME: (<2 x double> [[IN:%.*]], <2 x double> [[POWER:%.*]]) {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <2 x double> @llvm.pow.v2f64(<2 x double> [[IN]], <2 x double> [[POWER]])
; CHECK-NEXT:    ret <2 x double> [[TMP1]]
;
  %1 = call fast <2 x double> @llvm.pow.v2f64(<2 x double> %in, <2 x double> %power)
  ret <2 x double> %1
}

define <4 x float> @llvm_pow_f32(<4 x float> %in, <4 x float> %power) {
; CHECK-LABEL: define <4 x float> @llvm_pow_f32
; CHECK-SAME: (<4 x float> [[IN:%.*]], <4 x float> [[POWER:%.*]]) {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <4 x float> @llvm.pow.v4f32(<4 x float> [[IN]], <4 x float> [[POWER]])
; CHECK-NEXT:    ret <4 x float> [[TMP1]]
;
  %1 = call fast <4 x float> @llvm.pow.v4f32(<4 x float> %in, <4 x float> %power)
  ret <4 x float> %1
}

define <vscale x 2 x double> @llvm_pow_vscale_f64(<vscale x 2 x double> %in, <vscale x 2 x double> %power) #0 {
; CHECK-LABEL: define <vscale x 2 x double> @llvm_pow_vscale_f64
; CHECK-SAME: (<vscale x 2 x double> [[IN:%.*]], <vscale x 2 x double> [[POWER:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <vscale x 2 x double> @llvm.pow.nxv2f64(<vscale x 2 x double> [[IN]], <vscale x 2 x double> [[POWER]])
; CHECK-NEXT:    ret <vscale x 2 x double> [[TMP1]]
;
  %1 = call fast <vscale x 2 x double> @llvm.pow.nxv2f64(<vscale x 2 x double> %in, <vscale x 2 x double> %power)
  ret <vscale x 2 x double> %1
}

define <vscale x 4 x float> @llvm_pow_vscale_f32(<vscale x 4 x float> %in, <vscale x 4 x float> %power) #0 {
; CHECK-LABEL: define <vscale x 4 x float> @llvm_pow_vscale_f32
; CHECK-SAME: (<vscale x 4 x float> [[IN:%.*]], <vscale x 4 x float> [[POWER:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <vscale x 4 x float> @llvm.pow.nxv4f32(<vscale x 4 x float> [[IN]], <vscale x 4 x float> [[POWER]])
; CHECK-NEXT:    ret <vscale x 4 x float> [[TMP1]]
;
  %1 = call fast <vscale x 4 x float> @llvm.pow.nxv4f32(<vscale x 4 x float> %in, <vscale x 4 x float> %power)
  ret <vscale x 4 x float> %1
}

declare <2 x double> @llvm.sin.v2f64(<2 x double>)
declare <4 x float> @llvm.sin.v4f32(<4 x float>)
declare <vscale x 2 x double> @llvm.sin.nxv2f64(<vscale x 2 x double>)
declare <vscale x 4 x float> @llvm.sin.nxv4f32(<vscale x 4 x float>)

define <2 x double> @llvm_sin_f64(<2 x double> %in) {
; CHECK-LABEL: define <2 x double> @llvm_sin_f64
; CHECK-SAME: (<2 x double> [[IN:%.*]]) {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <2 x double> @armpl_vsinq_f64(<2 x double> [[IN]])
; CHECK-NEXT:    ret <2 x double> [[TMP1]]
;
  %1 = call fast <2 x double> @llvm.sin.v2f64(<2 x double> %in)
  ret <2 x double> %1
}

define <4 x float> @llvm_sin_f32(<4 x float> %in) {
; CHECK-LABEL: define <4 x float> @llvm_sin_f32
; CHECK-SAME: (<4 x float> [[IN:%.*]]) {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <4 x float> @armpl_vsinq_f32(<4 x float> [[IN]])
; CHECK-NEXT:    ret <4 x float> [[TMP1]]
;
  %1 = call fast <4 x float> @llvm.sin.v4f32(<4 x float> %in)
  ret <4 x float> %1
}

define <vscale x 2 x double> @llvm_sin_vscale_f64(<vscale x 2 x double> %in) #0 {
; CHECK-LABEL: define <vscale x 2 x double> @llvm_sin_vscale_f64
; CHECK-SAME: (<vscale x 2 x double> [[IN:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <vscale x 2 x double> @armpl_svsin_f64_x(<vscale x 2 x double> [[IN]], <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> poison, i1 true, i64 0), <vscale x 2 x i1> poison, <vscale x 2 x i32> zeroinitializer))
; CHECK-NEXT:    ret <vscale x 2 x double> [[TMP1]]
;
  %1 = call fast <vscale x 2 x double> @llvm.sin.nxv2f64(<vscale x 2 x double> %in)
  ret <vscale x 2 x double> %1
}

define <vscale x 4 x float> @llvm_sin_vscale_f32(<vscale x 4 x float> %in) #0 {
; CHECK-LABEL: define <vscale x 4 x float> @llvm_sin_vscale_f32
; CHECK-SAME: (<vscale x 4 x float> [[IN:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <vscale x 4 x float> @armpl_svsin_f32_x(<vscale x 4 x float> [[IN]], <vscale x 4 x i1> shufflevector (<vscale x 4 x i1> insertelement (<vscale x 4 x i1> poison, i1 true, i64 0), <vscale x 4 x i1> poison, <vscale x 4 x i32> zeroinitializer))
; CHECK-NEXT:    ret <vscale x 4 x float> [[TMP1]]
;
  %1 = call fast <vscale x 4 x float> @llvm.sin.nxv4f32(<vscale x 4 x float> %in)
  ret <vscale x 4 x float> %1
}

declare <2 x double> @llvm.tan.v2f64(<2 x double>)
declare <4 x float> @llvm.tan.v4f32(<4 x float>)
declare <vscale x 2 x double> @llvm.tan.nxv2f64(<vscale x 2 x double>)
declare <vscale x 4 x float> @llvm.tan.nxv4f32(<vscale x 4 x float>)

define <2 x double> @llvm_tan_f64(<2 x double> %in) {
; CHECK-LABEL: define <2 x double> @llvm_tan_f64
; CHECK-SAME: (<2 x double> [[IN:%.*]]) {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <2 x double> @armpl_vtanq_f64(<2 x double> [[IN]])
; CHECK-NEXT:    ret <2 x double> [[TMP1]]
;
  %1 = call fast <2 x double> @llvm.tan.v2f64(<2 x double> %in)
  ret <2 x double> %1
}

define <4 x float> @llvm_tan_f32(<4 x float> %in) {
; CHECK-LABEL: define <4 x float> @llvm_tan_f32
; CHECK-SAME: (<4 x float> [[IN:%.*]]) {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <4 x float> @armpl_vtanq_f32(<4 x float> [[IN]])
; CHECK-NEXT:    ret <4 x float> [[TMP1]]
;
  %1 = call fast <4 x float> @llvm.tan.v4f32(<4 x float> %in)
  ret <4 x float> %1
}

define <vscale x 2 x double> @llvm_tan_vscale_f64(<vscale x 2 x double> %in) #0 {
; CHECK-LABEL: define <vscale x 2 x double> @llvm_tan_vscale_f64
; CHECK-SAME: (<vscale x 2 x double> [[IN:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <vscale x 2 x double> @armpl_svtan_f64_x(<vscale x 2 x double> [[IN]], <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> poison, i1 true, i64 0), <vscale x 2 x i1> poison, <vscale x 2 x i32> zeroinitializer))
; CHECK-NEXT:    ret <vscale x 2 x double> [[TMP1]]
;
  %1 = call fast <vscale x 2 x double> @llvm.tan.nxv2f64(<vscale x 2 x double> %in)
  ret <vscale x 2 x double> %1
}

define <vscale x 4 x float> @llvm_tan_vscale_f32(<vscale x 4 x float> %in) #0 {
; CHECK-LABEL: define <vscale x 4 x float> @llvm_tan_vscale_f32
; CHECK-SAME: (<vscale x 4 x float> [[IN:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <vscale x 4 x float> @armpl_svtan_f32_x(<vscale x 4 x float> [[IN]], <vscale x 4 x i1> shufflevector (<vscale x 4 x i1> insertelement (<vscale x 4 x i1> poison, i1 true, i64 0), <vscale x 4 x i1> poison, <vscale x 4 x i32> zeroinitializer))
; CHECK-NEXT:    ret <vscale x 4 x float> [[TMP1]]
;
  %1 = call fast <vscale x 4 x float> @llvm.tan.nxv4f32(<vscale x 4 x float> %in)
  ret <vscale x 4 x float> %1
}

declare <2 x double> @llvm.acos.v2f64(<2 x double>)
declare <4 x float> @llvm.acos.v4f32(<4 x float>)
declare <vscale x 2 x double> @llvm.acos.nxv2f64(<vscale x 2 x double>)
declare <vscale x 4 x float> @llvm.acos.nxv4f32(<vscale x 4 x float>)

define <2 x double> @llvm_acos_f64(<2 x double> %in) {
; CHECK-LABEL: define <2 x double> @llvm_acos_f64
; CHECK-SAME: (<2 x double> [[IN:%.*]]) {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <2 x double> @armpl_vacosq_f64(<2 x double> [[IN]])
; CHECK-NEXT:    ret <2 x double> [[TMP1]]
;
  %1 = call fast <2 x double> @llvm.acos.v2f64(<2 x double> %in)
  ret <2 x double> %1
}

define <4 x float> @llvm_acos_f32(<4 x float> %in) {
; CHECK-LABEL: define <4 x float> @llvm_acos_f32
; CHECK-SAME: (<4 x float> [[IN:%.*]]) {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <4 x float> @armpl_vacosq_f32(<4 x float> [[IN]])
; CHECK-NEXT:    ret <4 x float> [[TMP1]]
;
  %1 = call fast <4 x float> @llvm.acos.v4f32(<4 x float> %in)
  ret <4 x float> %1
}

define <vscale x 2 x double> @llvm_acos_vscale_f64(<vscale x 2 x double> %in) #0 {
; CHECK-LABEL: define <vscale x 2 x double> @llvm_acos_vscale_f64
; CHECK-SAME: (<vscale x 2 x double> [[IN:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <vscale x 2 x double> @armpl_svacos_f64_x(<vscale x 2 x double> [[IN]], <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> poison, i1 true, i64 0), <vscale x 2 x i1> poison, <vscale x 2 x i32> zeroinitializer))
; CHECK-NEXT:    ret <vscale x 2 x double> [[TMP1]]
;
  %1 = call fast <vscale x 2 x double> @llvm.acos.nxv2f64(<vscale x 2 x double> %in)
  ret <vscale x 2 x double> %1
}

define <vscale x 4 x float> @llvm_acos_vscale_f32(<vscale x 4 x float> %in) #0 {
; CHECK-LABEL: define <vscale x 4 x float> @llvm_acos_vscale_f32
; CHECK-SAME: (<vscale x 4 x float> [[IN:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <vscale x 4 x float> @armpl_svacos_f32_x(<vscale x 4 x float> [[IN]], <vscale x 4 x i1> shufflevector (<vscale x 4 x i1> insertelement (<vscale x 4 x i1> poison, i1 true, i64 0), <vscale x 4 x i1> poison, <vscale x 4 x i32> zeroinitializer))
; CHECK-NEXT:    ret <vscale x 4 x float> [[TMP1]]
;
  %1 = call fast <vscale x 4 x float> @llvm.acos.nxv4f32(<vscale x 4 x float> %in)
  ret <vscale x 4 x float> %1
}

declare <2 x double> @llvm.asin.v2f64(<2 x double>)
declare <4 x float> @llvm.asin.v4f32(<4 x float>)
declare <vscale x 2 x double> @llvm.asin.nxv2f64(<vscale x 2 x double>)
declare <vscale x 4 x float> @llvm.asin.nxv4f32(<vscale x 4 x float>)

define <2 x double> @llvm_asin_f64(<2 x double> %in) {
; CHECK-LABEL: define <2 x double> @llvm_asin_f64
; CHECK-SAME: (<2 x double> [[IN:%.*]]) {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <2 x double> @armpl_vasinq_f64(<2 x double> [[IN]])
; CHECK-NEXT:    ret <2 x double> [[TMP1]]
;
  %1 = call fast <2 x double> @llvm.asin.v2f64(<2 x double> %in)
  ret <2 x double> %1
}

define <4 x float> @llvm_asin_f32(<4 x float> %in) {
; CHECK-LABEL: define <4 x float> @llvm_asin_f32
; CHECK-SAME: (<4 x float> [[IN:%.*]]) {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <4 x float> @armpl_vasinq_f32(<4 x float> [[IN]])
; CHECK-NEXT:    ret <4 x float> [[TMP1]]
;
  %1 = call fast <4 x float> @llvm.asin.v4f32(<4 x float> %in)
  ret <4 x float> %1
}

define <vscale x 2 x double> @llvm_asin_vscale_f64(<vscale x 2 x double> %in) #0 {
; CHECK-LABEL: define <vscale x 2 x double> @llvm_asin_vscale_f64
; CHECK-SAME: (<vscale x 2 x double> [[IN:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <vscale x 2 x double> @armpl_svasin_f64_x(<vscale x 2 x double> [[IN]], <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> poison, i1 true, i64 0), <vscale x 2 x i1> poison, <vscale x 2 x i32> zeroinitializer))
; CHECK-NEXT:    ret <vscale x 2 x double> [[TMP1]]
;
  %1 = call fast <vscale x 2 x double> @llvm.asin.nxv2f64(<vscale x 2 x double> %in)
  ret <vscale x 2 x double> %1
}

define <vscale x 4 x float> @llvm_asin_vscale_f32(<vscale x 4 x float> %in) #0 {
; CHECK-LABEL: define <vscale x 4 x float> @llvm_asin_vscale_f32
; CHECK-SAME: (<vscale x 4 x float> [[IN:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <vscale x 4 x float> @armpl_svasin_f32_x(<vscale x 4 x float> [[IN]], <vscale x 4 x i1> shufflevector (<vscale x 4 x i1> insertelement (<vscale x 4 x i1> poison, i1 true, i64 0), <vscale x 4 x i1> poison, <vscale x 4 x i32> zeroinitializer))
; CHECK-NEXT:    ret <vscale x 4 x float> [[TMP1]]
;
  %1 = call fast <vscale x 4 x float> @llvm.asin.nxv4f32(<vscale x 4 x float> %in)
  ret <vscale x 4 x float> %1
}

declare <2 x double> @llvm.atan.v2f64(<2 x double>)
declare <4 x float> @llvm.atan.v4f32(<4 x float>)
declare <vscale x 2 x double> @llvm.atan.nxv2f64(<vscale x 2 x double>)
declare <vscale x 4 x float> @llvm.atan.nxv4f32(<vscale x 4 x float>)

define <2 x double> @llvm_atan_f64(<2 x double> %in) {
; CHECK-LABEL: define <2 x double> @llvm_atan_f64
; CHECK-SAME: (<2 x double> [[IN:%.*]]) {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <2 x double> @armpl_vatanq_f64(<2 x double> [[IN]])
; CHECK-NEXT:    ret <2 x double> [[TMP1]]
;
  %1 = call fast <2 x double> @llvm.atan.v2f64(<2 x double> %in)
  ret <2 x double> %1
}

define <4 x float> @llvm_atan_f32(<4 x float> %in) {
; CHECK-LABEL: define <4 x float> @llvm_atan_f32
; CHECK-SAME: (<4 x float> [[IN:%.*]]) {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <4 x float> @armpl_vatanq_f32(<4 x float> [[IN]])
; CHECK-NEXT:    ret <4 x float> [[TMP1]]
;
  %1 = call fast <4 x float> @llvm.atan.v4f32(<4 x float> %in)
  ret <4 x float> %1
}

define <vscale x 2 x double> @llvm_atan_vscale_f64(<vscale x 2 x double> %in) #0 {
; CHECK-LABEL: define <vscale x 2 x double> @llvm_atan_vscale_f64
; CHECK-SAME: (<vscale x 2 x double> [[IN:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <vscale x 2 x double> @armpl_svatan_f64_x(<vscale x 2 x double> [[IN]], <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> poison, i1 true, i64 0), <vscale x 2 x i1> poison, <vscale x 2 x i32> zeroinitializer))
; CHECK-NEXT:    ret <vscale x 2 x double> [[TMP1]]
;
  %1 = call fast <vscale x 2 x double> @llvm.atan.nxv2f64(<vscale x 2 x double> %in)
  ret <vscale x 2 x double> %1
}

define <vscale x 4 x float> @llvm_atan_vscale_f32(<vscale x 4 x float> %in) #0 {
; CHECK-LABEL: define <vscale x 4 x float> @llvm_atan_vscale_f32
; CHECK-SAME: (<vscale x 4 x float> [[IN:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <vscale x 4 x float> @armpl_svatan_f32_x(<vscale x 4 x float> [[IN]], <vscale x 4 x i1> shufflevector (<vscale x 4 x i1> insertelement (<vscale x 4 x i1> poison, i1 true, i64 0), <vscale x 4 x i1> poison, <vscale x 4 x i32> zeroinitializer))
; CHECK-NEXT:    ret <vscale x 4 x float> [[TMP1]]
;
  %1 = call fast <vscale x 4 x float> @llvm.atan.nxv4f32(<vscale x 4 x float> %in)
  ret <vscale x 4 x float> %1
}

declare <2 x double> @llvm.cosh.v2f64(<2 x double>)
declare <4 x float> @llvm.cosh.v4f32(<4 x float>)
declare <vscale x 2 x double> @llvm.cosh.nxv2f64(<vscale x 2 x double>)
declare <vscale x 4 x float> @llvm.cosh.nxv4f32(<vscale x 4 x float>)

define <2 x double> @llvm_cosh_f64(<2 x double> %in) {
; CHECK-LABEL: define <2 x double> @llvm_cosh_f64
; CHECK-SAME: (<2 x double> [[IN:%.*]]) {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <2 x double> @armpl_vcoshq_f64(<2 x double> [[IN]])
; CHECK-NEXT:    ret <2 x double> [[TMP1]]
;
  %1 = call fast <2 x double> @llvm.cosh.v2f64(<2 x double> %in)
  ret <2 x double> %1
}

define <4 x float> @llvm_cosh_f32(<4 x float> %in) {
; CHECK-LABEL: define <4 x float> @llvm_cosh_f32
; CHECK-SAME: (<4 x float> [[IN:%.*]]) {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <4 x float> @armpl_vcoshq_f32(<4 x float> [[IN]])
; CHECK-NEXT:    ret <4 x float> [[TMP1]]
;
  %1 = call fast <4 x float> @llvm.cosh.v4f32(<4 x float> %in)
  ret <4 x float> %1
}

define <vscale x 2 x double> @llvm_cosh_vscale_f64(<vscale x 2 x double> %in) #0 {
; CHECK-LABEL: define <vscale x 2 x double> @llvm_cosh_vscale_f64
; CHECK-SAME: (<vscale x 2 x double> [[IN:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <vscale x 2 x double> @armpl_svcosh_f64_x(<vscale x 2 x double> [[IN]], <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> poison, i1 true, i64 0), <vscale x 2 x i1> poison, <vscale x 2 x i32> zeroinitializer))
; CHECK-NEXT:    ret <vscale x 2 x double> [[TMP1]]
;
  %1 = call fast <vscale x 2 x double> @llvm.cosh.nxv2f64(<vscale x 2 x double> %in)
  ret <vscale x 2 x double> %1
}

define <vscale x 4 x float> @llvm_cosh_vscale_f32(<vscale x 4 x float> %in) #0 {
; CHECK-LABEL: define <vscale x 4 x float> @llvm_cosh_vscale_f32
; CHECK-SAME: (<vscale x 4 x float> [[IN:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <vscale x 4 x float> @armpl_svcosh_f32_x(<vscale x 4 x float> [[IN]], <vscale x 4 x i1> shufflevector (<vscale x 4 x i1> insertelement (<vscale x 4 x i1> poison, i1 true, i64 0), <vscale x 4 x i1> poison, <vscale x 4 x i32> zeroinitializer))
; CHECK-NEXT:    ret <vscale x 4 x float> [[TMP1]]
;
  %1 = call fast <vscale x 4 x float> @llvm.cosh.nxv4f32(<vscale x 4 x float> %in)
  ret <vscale x 4 x float> %1
}

declare <2 x double> @llvm.sinh.v2f64(<2 x double>)
declare <4 x float> @llvm.sinh.v4f32(<4 x float>)
declare <vscale x 2 x double> @llvm.sinh.nxv2f64(<vscale x 2 x double>)
declare <vscale x 4 x float> @llvm.sinh.nxv4f32(<vscale x 4 x float>)

define <2 x double> @llvm_sinh_f64(<2 x double> %in) {
; CHECK-LABEL: define <2 x double> @llvm_sinh_f64
; CHECK-SAME: (<2 x double> [[IN:%.*]]) {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <2 x double> @armpl_vsinhq_f64(<2 x double> [[IN]])
; CHECK-NEXT:    ret <2 x double> [[TMP1]]
;
  %1 = call fast <2 x double> @llvm.sinh.v2f64(<2 x double> %in)
  ret <2 x double> %1
}

define <4 x float> @llvm_sinh_f32(<4 x float> %in) {
; CHECK-LABEL: define <4 x float> @llvm_sinh_f32
; CHECK-SAME: (<4 x float> [[IN:%.*]]) {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <4 x float> @armpl_vsinhq_f32(<4 x float> [[IN]])
; CHECK-NEXT:    ret <4 x float> [[TMP1]]
;
  %1 = call fast <4 x float> @llvm.sinh.v4f32(<4 x float> %in)
  ret <4 x float> %1
}

define <vscale x 2 x double> @llvm_sinh_vscale_f64(<vscale x 2 x double> %in) #0 {
; CHECK-LABEL: define <vscale x 2 x double> @llvm_sinh_vscale_f64
; CHECK-SAME: (<vscale x 2 x double> [[IN:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <vscale x 2 x double> @armpl_svsinh_f64_x(<vscale x 2 x double> [[IN]], <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> poison, i1 true, i64 0), <vscale x 2 x i1> poison, <vscale x 2 x i32> zeroinitializer))
; CHECK-NEXT:    ret <vscale x 2 x double> [[TMP1]]
;
  %1 = call fast <vscale x 2 x double> @llvm.sinh.nxv2f64(<vscale x 2 x double> %in)
  ret <vscale x 2 x double> %1
}

define <vscale x 4 x float> @llvm_sinh_vscale_f32(<vscale x 4 x float> %in) #0 {
; CHECK-LABEL: define <vscale x 4 x float> @llvm_sinh_vscale_f32
; CHECK-SAME: (<vscale x 4 x float> [[IN:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <vscale x 4 x float> @armpl_svsinh_f32_x(<vscale x 4 x float> [[IN]], <vscale x 4 x i1> shufflevector (<vscale x 4 x i1> insertelement (<vscale x 4 x i1> poison, i1 true, i64 0), <vscale x 4 x i1> poison, <vscale x 4 x i32> zeroinitializer))
; CHECK-NEXT:    ret <vscale x 4 x float> [[TMP1]]
;
  %1 = call fast <vscale x 4 x float> @llvm.sinh.nxv4f32(<vscale x 4 x float> %in)
  ret <vscale x 4 x float> %1
}

declare <2 x double> @llvm.tanh.v2f64(<2 x double>)
declare <4 x float> @llvm.tanh.v4f32(<4 x float>)
declare <vscale x 2 x double> @llvm.tanh.nxv2f64(<vscale x 2 x double>)
declare <vscale x 4 x float> @llvm.tanh.nxv4f32(<vscale x 4 x float>)

define <2 x double> @llvm_tanh_f64(<2 x double> %in) {
; CHECK-LABEL: define <2 x double> @llvm_tanh_f64
; CHECK-SAME: (<2 x double> [[IN:%.*]]) {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <2 x double> @armpl_vtanhq_f64(<2 x double> [[IN]])
; CHECK-NEXT:    ret <2 x double> [[TMP1]]
;
  %1 = call fast <2 x double> @llvm.tanh.v2f64(<2 x double> %in)
  ret <2 x double> %1
}

define <4 x float> @llvm_tanh_f32(<4 x float> %in) {
; CHECK-LABEL: define <4 x float> @llvm_tanh_f32
; CHECK-SAME: (<4 x float> [[IN:%.*]]) {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <4 x float> @armpl_vtanhq_f32(<4 x float> [[IN]])
; CHECK-NEXT:    ret <4 x float> [[TMP1]]
;
  %1 = call fast <4 x float> @llvm.tanh.v4f32(<4 x float> %in)
  ret <4 x float> %1
}

define <vscale x 2 x double> @llvm_tanh_vscale_f64(<vscale x 2 x double> %in) #0 {
; CHECK-LABEL: define <vscale x 2 x double> @llvm_tanh_vscale_f64
; CHECK-SAME: (<vscale x 2 x double> [[IN:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <vscale x 2 x double> @armpl_svtanh_f64_x(<vscale x 2 x double> [[IN]], <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> poison, i1 true, i64 0), <vscale x 2 x i1> poison, <vscale x 2 x i32> zeroinitializer))
; CHECK-NEXT:    ret <vscale x 2 x double> [[TMP1]]
;
  %1 = call fast <vscale x 2 x double> @llvm.tanh.nxv2f64(<vscale x 2 x double> %in)
  ret <vscale x 2 x double> %1
}

define <vscale x 4 x float> @llvm_tanh_vscale_f32(<vscale x 4 x float> %in) #0 {
; CHECK-LABEL: define <vscale x 4 x float> @llvm_tanh_vscale_f32
; CHECK-SAME: (<vscale x 4 x float> [[IN:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <vscale x 4 x float> @armpl_svtanh_f32_x(<vscale x 4 x float> [[IN]], <vscale x 4 x i1> shufflevector (<vscale x 4 x i1> insertelement (<vscale x 4 x i1> poison, i1 true, i64 0), <vscale x 4 x i1> poison, <vscale x 4 x i32> zeroinitializer))
; CHECK-NEXT:    ret <vscale x 4 x float> [[TMP1]]
;
  %1 = call fast <vscale x 4 x float> @llvm.tanh.nxv4f32(<vscale x 4 x float> %in)
  ret <vscale x 4 x float> %1
}

attributes #0 = { "target-features"="+sve" }
;.
; CHECK: attributes #[[ATTR0:[0-9]+]] = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
; CHECK: attributes #[[ATTR1]] = { "target-features"="+sve" }
;.
