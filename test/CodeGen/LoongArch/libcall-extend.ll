; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 4
; RUN: llc --mtriple=loongarch64 --target-abi=lp64s --mattr=-f < %s | FileCheck %s

define signext i32 @convert_float_to_i32(i32 %tmp, float %a) nounwind {
; CHECK-LABEL: convert_float_to_i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi.d $sp, $sp, -16
; CHECK-NEXT:    st.d $ra, $sp, 8 # 8-byte Folded Spill
; CHECK-NEXT:    move $a0, $a1
; CHECK-NEXT:    bl %plt(__fixsfsi)
; CHECK-NEXT:    ld.d $ra, $sp, 8 # 8-byte Folded Reload
; CHECK-NEXT:    addi.d $sp, $sp, 16
; CHECK-NEXT:    ret
  %1 = fptosi float %a to i32
  ret i32 %1
}

define signext i32 @convert_double_to_i32(i32 %tmp, double %a) nounwind {
; CHECK-LABEL: convert_double_to_i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi.d $sp, $sp, -16
; CHECK-NEXT:    st.d $ra, $sp, 8 # 8-byte Folded Spill
; CHECK-NEXT:    move $a0, $a1
; CHECK-NEXT:    bl %plt(__fixdfsi)
; CHECK-NEXT:    ld.d $ra, $sp, 8 # 8-byte Folded Reload
; CHECK-NEXT:    addi.d $sp, $sp, 16
; CHECK-NEXT:    ret
  %1 = fptosi double %a to i32
  ret i32 %1
}

define signext i32 @convert_fp128_to_i32(i32 %tmp, fp128 %a) nounwind {
; CHECK-LABEL: convert_fp128_to_i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi.d $sp, $sp, -16
; CHECK-NEXT:    st.d $ra, $sp, 8 # 8-byte Folded Spill
; CHECK-NEXT:    move $a0, $a1
; CHECK-NEXT:    move $a1, $a2
; CHECK-NEXT:    bl %plt(__fixtfsi)
; CHECK-NEXT:    ld.d $ra, $sp, 8 # 8-byte Folded Reload
; CHECK-NEXT:    addi.d $sp, $sp, 16
; CHECK-NEXT:    ret
  %1 = fptosi fp128 %a to i32
  ret i32 %1
}
