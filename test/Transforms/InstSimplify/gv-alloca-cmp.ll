; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 2
; RUN: opt < %s -passes=instsimplify -S | FileCheck %s

@gv = global i64 zeroinitializer, align 16

define i1 @cmp_gv_alloca() {
; CHECK-LABEL: define i1 @cmp_gv_alloca() {
; CHECK-NEXT:    ret i1 false
;
  %alloca = alloca i64, align 8
  %cmp = icmp eq ptr %alloca, @gv
  ret i1 %cmp
}

@gv_externally_init = externally_initialized global i64 zeroinitializer, align 16

define i1 @cmp_gv_alloca_extern_init() {
; CHECK-LABEL: define i1 @cmp_gv_alloca_extern_init() {
; CHECK-NEXT:    ret i1 false
;
  %alloca = alloca i64, align 8
  %cmp = icmp eq ptr %alloca, @gv_externally_init
  ret i1 %cmp
}

@const_gv = protected addrspace(4) externally_initialized global [4096 x i64] zeroinitializer, align 16
define i1 @cmp_gv_alloca_cast() {
; CHECK-LABEL: define i1 @cmp_gv_alloca_cast() {
; CHECK-NEXT:    ret i1 false
;
  %alloca = alloca i64, align 8, addrspace(5)
  %cast.alloca = addrspacecast ptr addrspace(5) %alloca to ptr
  %cmp = icmp eq ptr %cast.alloca, addrspacecast (ptr addrspace(4) @const_gv to ptr)
  ret i1 %cmp
}

@gv_weak = weak global i64 zeroinitializer, align 16

define i1 @cmp_gv_weak_alloca() {
; CHECK-LABEL: define i1 @cmp_gv_weak_alloca() {
; CHECK-NEXT:    ret i1 false
;
  %alloca = alloca i64, align 8
  %cmp = icmp eq ptr %alloca, @gv_weak
  ret i1 %cmp
}

%opaque = type opaque
@gv_unsized = weak global %opaque zeroinitializer, align 16

define i1 @cmp_gv_unsized_alloca() {
; CHECK-LABEL: define i1 @cmp_gv_unsized_alloca() {
; CHECK-NEXT:    [[ALLOCA:%.*]] = alloca i64, align 8
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq ptr [[ALLOCA]], @gv_unsized
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %alloca = alloca i64, align 8
  %cmp = icmp eq ptr %alloca, @gv_unsized
  ret i1 %cmp
}
