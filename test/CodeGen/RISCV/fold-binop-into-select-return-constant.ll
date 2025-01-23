; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc -mtriple=riscv64 -mattr=+m < %s  | FileCheck  %s

define i64 @fold_binop_into_select_return_constant(i1 %c) {
; CHECK-LABEL: fold_binop_into_select_return_constant:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    li a0, 0
; CHECK-NEXT:    ret
entry:
  %select1 = select i1 %c, i32 4, i32 8
  %select2 = sext i32 %select1 to i64
  %div1 = sdiv i64 %select2, -5141143369814759789
  ret i64 %div1
}
