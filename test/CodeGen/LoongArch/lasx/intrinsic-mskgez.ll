; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc --mtriple=loongarch64 --mattr=+lasx < %s | FileCheck %s

declare <32 x i8> @llvm.loongarch.lasx.xvmskgez.b(<32 x i8>)

define <32 x i8> @lasx_xvmskgez_b(<32 x i8> %va) nounwind {
; CHECK-LABEL: lasx_xvmskgez_b:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvmskgez.b $xr0, $xr0
; CHECK-NEXT:    ret
entry:
  %res = call <32 x i8> @llvm.loongarch.lasx.xvmskgez.b(<32 x i8> %va)
  ret <32 x i8> %res
}
