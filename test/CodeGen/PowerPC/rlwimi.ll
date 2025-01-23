; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 4
; RUN: llc -verify-machineinstrs < %s -mtriple=powerpc64le-unknown-linux-gnu | FileCheck %s

define i32 @test1(i32 %x, i32 %y) {
; CHECK-LABEL: test1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    rlwimi 4, 3, 16, 0, 15
; CHECK-NEXT:    mr 3, 4
; CHECK-NEXT:    blr
entry:
  %tmp.3 = shl i32 %x, 16
  %tmp.7 = and i32 %y, 65535
  %tmp.9 = or i32 %tmp.7, %tmp.3
  ret i32 %tmp.9
}

define i32 @test2(i32 %x, i32 %y) {
; CHECK-LABEL: test2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    rlwimi 3, 4, 16, 0, 15
; CHECK-NEXT:    blr
entry:
  %tmp.7 = and i32 %x, 65535
  %tmp.3 = shl i32 %y, 16
  %tmp.9 = or i32 %tmp.7, %tmp.3
  ret i32 %tmp.9
}

define i32 @test3(i32 %x, i32 %y) {
; CHECK-LABEL: test3:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    rlwimi 4, 3, 16, 16, 31
; CHECK-NEXT:    mr 3, 4
; CHECK-NEXT:    blr
entry:
  %tmp.3 = lshr i32 %x, 16
  %tmp.6 = and i32 %y, -65536
  %tmp.7 = or i32 %tmp.6, %tmp.3
  ret i32 %tmp.7
}

define i32 @test4(i32 %x, i32 %y) {
; CHECK-LABEL: test4:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    rlwimi 3, 4, 16, 16, 31
; CHECK-NEXT:    blr
entry:
  %tmp.6 = and i32 %x, -65536
  %tmp.3 = lshr i32 %y, 16
  %tmp.7 = or i32 %tmp.6, %tmp.3
  ret i32 %tmp.7
}

define i32 @test5(i32 %x, i32 %y) {
; CHECK-LABEL: test5:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    rlwimi 4, 3, 1, 0, 15
; CHECK-NEXT:    mr 3, 4
; CHECK-NEXT:    blr
entry:
  %tmp.3 = shl i32 %x, 1
  %tmp.4 = and i32 %tmp.3, -65536
  %tmp.7 = and i32 %y, 65535
  %tmp.9 = or i32 %tmp.4, %tmp.7
  ret i32 %tmp.9
}

define i32 @test6(i32 %x, i32 %y) {
; CHECK-LABEL: test6:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    rlwimi 3, 4, 1, 0, 15
; CHECK-NEXT:    blr
entry:
  %tmp.7 = and i32 %x, 65535
  %tmp.3 = shl i32 %y, 1
  %tmp.4 = and i32 %tmp.3, -65536
  %tmp.9 = or i32 %tmp.4, %tmp.7
  ret i32 %tmp.9
}

define i32 @test7(i32 %x, i32 %y) {
; CHECK-LABEL: test7:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    andis. 3, 3, 65535
; CHECK-NEXT:    rldimi 3, 4, 0, 48
; CHECK-NEXT:    blr
entry:
  %tmp.2 = and i32 %x, -65536
  %tmp.5 = and i32 %y, 65535
  %tmp.7 = or i32 %tmp.5, %tmp.2
  ret i32 %tmp.7
}

define i32 @test8(i32 %bar) {
; CHECK-LABEL: test8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    rlwimi 3, 3, 1, 30, 30
; CHECK-NEXT:    blr
entry:
  %tmp.3 = shl i32 %bar, 1
  %tmp.4 = and i32 %tmp.3, 2
  %tmp.6 = and i32 %bar, -3
  %tmp.7 = or i32 %tmp.4, %tmp.6
  ret i32 %tmp.7
}

define i32 @test9(i32 %a, i32 %b) {
; CHECK-LABEL: test9:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    rlwimi 4, 3, 8, 20, 26
; CHECK-NEXT:    mr 3, 4
; CHECK-NEXT:    blr
entry:
  %r = call i32 @llvm.ppc.rlwimi(i32 %a, i32 %b, i32 8, i32 4064)
  ret i32 %r
}

define i32 @test10(i32 %a, i32 %b) {
; CHECK-LABEL: test10:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    blr
entry:
  %r = call i32 @llvm.ppc.rlwimi(i32 %a, i32 %b, i32 0, i32 -1)
  ret i32 %r
}

define i32 @test11(i32 %a, i32 %b) {
; CHECK-LABEL: test11:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    rotlwi 3, 3, 8
; CHECK-NEXT:    blr
entry:
  %r = call i32 @llvm.ppc.rlwimi(i32 %a, i32 %b, i32 8, i32 -1)
  ret i32 %r
}

define i32 @test12(i32 %a, i32 %b) {
; CHECK-LABEL: test12:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    mr 3, 4
; CHECK-NEXT:    blr
entry:
  %r = call i32 @llvm.ppc.rlwimi(i32 %a, i32 %b, i32 0, i32 0)
  ret i32 %r
}

define i32 @test13(i32 %a, i32 %b) {
; CHECK-LABEL: test13:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    rlwimi 3, 4, 0, 27, 19
; CHECK-NEXT:    blr
entry:
  %r = call i32 @llvm.ppc.rlwimi(i32 %a, i32 %b, i32 0, i32 4064)
  ret i32 %r
}

declare i32 @llvm.ppc.rlwimi(i32, i32, i32 immarg, i32 immarg)
