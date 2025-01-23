; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature
; RUN: opt -passes=instcombine -S < %s  | FileCheck %s

target datalayout = "e-m:e-p200:128:128:128:64-A200-P200-G200"

define i64 @remove_malloc() addrspace(200) {
; CHECK-LABEL: define {{[^@]+}}@remove_malloc() addrspace(200) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    ret i64 0
;
entry:
  %call = call align 16 ptr addrspace(200) @malloc(i64 4)
  call void @free(ptr addrspace(200) %call)
  ret i64 0
}

define i64 @remove_calloc() addrspace(200) {
; CHECK-LABEL: define {{[^@]+}}@remove_calloc() addrspace(200) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    ret i64 0
;
entry:
  %call = call ptr addrspace(200) @calloc(i64 1, i64 4)
  call void @free(ptr addrspace(200) %call)
  ret i64 0
}
define i64 @remove_aligned_alloc() addrspace(200) {
; CHECK-LABEL: define {{[^@]+}}@remove_aligned_alloc() addrspace(200) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    ret i64 0
;
entry:
  %call = call align 4 ptr addrspace(200) @aligned_alloc(i64 4, i64 4)
  call void @free(ptr addrspace(200) %call)
  ret i64 0
}

define i64 @remove_strdup(ptr addrspace(200) %arg) addrspace(200) {
; CHECK-LABEL: define {{[^@]+}}@remove_strdup
; CHECK-SAME: (ptr addrspace(200) [[ARG:%.*]]) addrspace(200) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    ret i64 0
;
entry:
  %call = call align 4 ptr addrspace(200) @strdup(ptr addrspace(200) %arg)
  call void @free(ptr addrspace(200) %call)
  ret i64 0
}

define i64 @remove_new(ptr addrspace(200) %arg) addrspace(200) {
; CHECK-LABEL: define {{[^@]+}}@remove_new
; CHECK-SAME: (ptr addrspace(200) [[ARG:%.*]]) addrspace(200) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    ret i64 0
;
entry:
  %call = call align 4 ptr addrspace(200) @_Znwm(i64 4)
  call void @_ZdlPv(ptr addrspace(200) %call)
  ret i64 0
}

define i64 @remove_new_array(ptr addrspace(200) %arg) addrspace(200) {
; CHECK-LABEL: define {{[^@]+}}@remove_new_array
; CHECK-SAME: (ptr addrspace(200) [[ARG:%.*]]) addrspace(200) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    ret i64 0
;
entry:
  %call = call align 4 ptr addrspace(200) @_Znam(i64 4)
  call void @_ZdaPv(ptr addrspace(200) %call)
  ret i64 0
}

declare noalias ptr addrspace(200) @calloc(i64, i64) addrspace(200)  nounwind allockind("alloc,zeroed") allocsize(0,1) "alloc-family"="malloc"
declare noalias ptr addrspace(200) @malloc(i64) addrspace(200) allockind("alloc,uninitialized") allocsize(0) "alloc-family"="malloc"
declare noalias ptr addrspace(200) @aligned_alloc(i64, i64) addrspace(200) allockind("alloc,uninitialized,aligned") allocsize(1) "alloc-family"="malloc"
declare noalias ptr addrspace(200) @strdup(ptr addrspace(200) %arg) addrspace(200)
declare void @free(ptr addrspace(200)) addrspace(200) allockind("free") "alloc-family"="malloc"
; new/delete
declare noalias ptr addrspace(200) @_Znwm(i64) addrspace(200)
declare void @_ZdlPv(ptr addrspace(200)) addrspace(200)
; new[]/delete[]
declare noalias ptr addrspace(200) @_Znam(i64) addrspace(200)
declare void @_ZdaPv(ptr addrspace(200)) addrspace(200)
