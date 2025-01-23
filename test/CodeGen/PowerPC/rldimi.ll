; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 3
; RUN: llc -verify-machineinstrs < %s -mtriple=powerpc64le-unknown-linux-gnu -mcpu=pwr8 | FileCheck %s
; RUN: llc -verify-machineinstrs < %s -mtriple=powerpc64-ibm-aix -mcpu=pwr8 | FileCheck %s

define i64 @rldimi1(i64 %a) {
; CHECK-LABEL: rldimi1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    rldimi 3, 3, 8, 0
; CHECK-NEXT:    blr
entry:
  %x0 = shl i64 %a, 8
  %x1 = and i64 %a, 255
  %x2 = or i64 %x0, %x1
  ret i64 %x2
}

define i64 @rldimi2(i64 %a) {
; CHECK-LABEL: rldimi2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    mr 4, 3
; CHECK-NEXT:    rlwimi 4, 3, 8, 16, 23
; CHECK-NEXT:    rlwimi 4, 3, 16, 8, 15
; CHECK-NEXT:    rldimi 4, 3, 24, 0
; CHECK-NEXT:    mr 3, 4
; CHECK-NEXT:    blr
entry:
  %x0 = shl i64 %a, 8
  %x1 = and i64 %a, 255
  %x2 = or i64 %x0, %x1
  %x3 = shl i64 %x2, 16
  %x4 = and i64 %x2, 65535
  %x5 = or i64 %x3, %x4
  ret i64 %x5
}

define i64 @rldimi3(i64 %a) {
; CHECK-LABEL: rldimi3:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    rotldi 4, 3, 32
; CHECK-NEXT:    rlwimi 4, 3, 0, 24, 31
; CHECK-NEXT:    rlwimi 4, 3, 8, 16, 23
; CHECK-NEXT:    rlwimi 4, 3, 16, 8, 15
; CHECK-NEXT:    rlwimi 4, 3, 24, 0, 7
; CHECK-NEXT:    rldimi 4, 3, 40, 16
; CHECK-NEXT:    rldimi 4, 3, 48, 8
; CHECK-NEXT:    rldimi 4, 3, 56, 0
; CHECK-NEXT:    mr 3, 4
; CHECK-NEXT:    blr
entry:
  %0 = shl i64 %a, 8
  %1 = and i64 %a, 255
  %2 = or i64 %0, %1
  %3 = shl i64 %2, 16
  %4 = and i64 %2, 65535
  %5 = or i64 %3, %4
  %6 = shl i64 %5, 32
  %7 = and i64 %5, 4294967295
  %8 = or i64 %6, %7
  ret i64 %8
}

define i64 @rldimi4(i64 %a) {
; CHECK-LABEL: rldimi4:
; CHECK:       # %bb.0:
; CHECK-NEXT:    rldimi 3, 3, 8, 0
; CHECK-NEXT:    rldimi 3, 3, 16, 0
; CHECK-NEXT:    rldimi 3, 3, 32, 0
; CHECK-NEXT:    blr
  %r1 = call i64 @llvm.ppc.rldimi(i64 %a, i64 %a, i32 8, i64 -256)
  %r2 = call i64 @llvm.ppc.rldimi(i64 %r1, i64 %r1, i32 16, i64 -65536)
  %r3 = call i64 @llvm.ppc.rldimi(i64 %r2, i64 %r2, i32 32, i64 -4294967296)
  ret i64 %r3
}

define i64 @rldimi5(i64 %a, i64 %b) {
; CHECK-LABEL: rldimi5:
; CHECK:       # %bb.0:
; CHECK-NEXT:    rldimi 4, 3, 8, 40
; CHECK-NEXT:    mr 3, 4
; CHECK-NEXT:    blr
  %r = call i64 @llvm.ppc.rldimi(i64 %a, i64 %b, i32 8, i64 16776960) ; 0xffff << 8
  ret i64 %r
}

define i64 @rldimi6(i64 %a, i64 %b) {
; CHECK-LABEL: rldimi6:
; CHECK:       # %bb.0:
; CHECK-NEXT:    rotldi 3, 3, 1
; CHECK-NEXT:    rldimi 4, 3, 7, 41
; CHECK-NEXT:    mr 3, 4
; CHECK-NEXT:    blr
  %r = call i64 @llvm.ppc.rldimi(i64 %a, i64 %b, i32 8, i64 8388480) ; 0xffff << 7
  ret i64 %r
}

define i64 @rldimi7(i64 %a, i64 %b) {
; CHECK-LABEL: rldimi7:
; CHECK:       # %bb.0:
; CHECK-NEXT:    rotldi 3, 3, 63
; CHECK-NEXT:    rldimi 4, 3, 9, 39
; CHECK-NEXT:    mr 3, 4
; CHECK-NEXT:    blr
  %r = call i64 @llvm.ppc.rldimi(i64 %a, i64 %b, i32 8, i64 33553920) ; 0xffff << 9
  ret i64 %r
}

define i64 @rldimi8(i64 %a, i64 %b) {
; CHECK-LABEL: rldimi8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    mr 3, 4
; CHECK-NEXT:    blr
  %r = call i64 @llvm.ppc.rldimi(i64 %a, i64 %b, i32 0, i64 0)
  ret i64 %r
}

define i64 @rldimi9(i64 %a, i64 %b) {
; CHECK-LABEL: rldimi9:
; CHECK:       # %bb.0:
; CHECK-NEXT:    mr 3, 4
; CHECK-NEXT:    blr
  %r = call i64 @llvm.ppc.rldimi(i64 %a, i64 %b, i32 63, i64 0)
  ret i64 %r
}

define i64 @rldimi10(i64 %a, i64 %b) {
; CHECK-LABEL: rldimi10:
; CHECK:       # %bb.0:
; CHECK-NEXT:    blr
  %r = call i64 @llvm.ppc.rldimi(i64 %a, i64 %b, i32 0, i64 -1)
  ret i64 %r
}

define i64 @rldimi11(i64 %a, i64 %b) {
; CHECK-LABEL: rldimi11:
; CHECK:       # %bb.0:
; CHECK-NEXT:    rotldi 3, 3, 8
; CHECK-NEXT:    blr
  %r = call i64 @llvm.ppc.rldimi(i64 %a, i64 %b, i32 8, i64 -1)
  ret i64 %r
}

define i64 @rldimi12(i64 %a, i64 %b) {
; CHECK-LABEL: rldimi12:
; CHECK:       # %bb.0:
; CHECK-NEXT:    rotldi 3, 3, 20
; CHECK-NEXT:    rldimi 4, 3, 44, 31
; CHECK-NEXT:    mr 3, 4
; CHECK-NEXT:    blr
  %r = call i64 @llvm.ppc.rldimi(i64 %a, i64 %b, i32 0, i64 18446726490113441791)
  ret i64 %r
}

define i64 @rldimi13(i64 %a, i64 %b) {
; CHECK-LABEL: rldimi13:
; CHECK:       # %bb.0:
; CHECK-NEXT:    rotldi 3, 3, 62
; CHECK-NEXT:    rldimi 4, 3, 32, 2
; CHECK-NEXT:    mr 3, 4
; CHECK-NEXT:    blr
  %r = call i64 @llvm.ppc.rldimi(i64 %a, i64 %b, i32 30, i64 4611686014132420608)
  ret i64 %r
}

define i64 @rldimi14(i64 %a, i64 %b) {
; CHECK-LABEL: rldimi14:
; CHECK:       # %bb.0:
; CHECK-NEXT:    rotldi 3, 3, 23
; CHECK-NEXT:    rldimi 4, 3, 53, 0
; CHECK-NEXT:    mr 3, 4
; CHECK-NEXT:    blr
  %r = call i64 @llvm.ppc.rldimi(i64 %a, i64 %b, i32 12, i64 18437736874454810624) ; mb=0, me=10
  ret i64 %r
}

define i64 @rldimi15(i64 %a, i64 %b) {
; CHECK-LABEL: rldimi15:
; CHECK:       # %bb.0:
; CHECK-NEXT:    rotldi 3, 3, 36
; CHECK-NEXT:    rldimi 4, 3, 40, 10
; CHECK-NEXT:    mr 3, 4
; CHECK-NEXT:    blr
  %r = call i64 @llvm.ppc.rldimi(i64 %a, i64 %b, i32 12, i64 18013298997854208) ; mb=10, me=23
  ret i64 %r
}

define i64 @rldimi16(i64 %a, i64 %b) {
; CHECK-LABEL: rldimi16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    rotldi 3, 3, 57
; CHECK-NEXT:    rldimi 4, 3, 19, 10
; CHECK-NEXT:    mr 3, 4
; CHECK-NEXT:    blr
  %r = call i64 @llvm.ppc.rldimi(i64 %a, i64 %b, i32 12, i64 18014398508957696) ; mb=10, me=44
  ret i64 %r
}

define i64 @rldimi17(i64 %a, i64 %b) {
; CHECK-LABEL: rldimi17:
; CHECK:       # %bb.0:
; CHECK-NEXT:    rotldi 3, 3, 43
; CHECK-NEXT:    rldimi 4, 3, 33, 25
; CHECK-NEXT:    mr 3, 4
; CHECK-NEXT:    blr
  %r = call i64 @llvm.ppc.rldimi(i64 %a, i64 %b, i32 12, i64 541165879296) ; mb=25, me=30
  ret i64 %r
}

define i64 @rldimi18(i64 %a, i64 %b) {
; CHECK-LABEL: rldimi18:
; CHECK:       # %bb.0:
; CHECK-NEXT:    rotldi 3, 3, 57
; CHECK-NEXT:    rldimi 4, 3, 19, 25
; CHECK-NEXT:    mr 3, 4
; CHECK-NEXT:    blr
  %r = call i64 @llvm.ppc.rldimi(i64 %a, i64 %b, i32 12, i64 549755289600) ; mb=25, me=44
  ret i64 %r
}

define i64 @rldimi19(i64 %a, i64 %b) {
; CHECK-LABEL: rldimi19:
; CHECK:       # %bb.0:
; CHECK-NEXT:    rotldi 3, 3, 57
; CHECK-NEXT:    rldimi 4, 3, 19, 33
; CHECK-NEXT:    mr 3, 4
; CHECK-NEXT:    blr
  %r = call i64 @llvm.ppc.rldimi(i64 %a, i64 %b, i32 12, i64 2146959360) ; mb=33, me=44
  ret i64 %r
}

define i64 @rldimi20(i64 %a, i64 %b) {
; CHECK-LABEL: rldimi20:
; CHECK:       # %bb.0:
; CHECK-NEXT:    rotldi 3, 3, 23
; CHECK-NEXT:    rldimi 4, 3, 53, 15
; CHECK-NEXT:    mr 3, 4
; CHECK-NEXT:    blr
  %r = call i64 @llvm.ppc.rldimi(i64 %a, i64 %b, i32 12, i64 18438299824408231935) ; mb=15, me=10
  ret i64 %r
}

define i64 @rldimi21(i64 %a, i64 %b) {
; CHECK-LABEL: rldimi21:
; CHECK:       # %bb.0:
; CHECK-NEXT:    rotldi 3, 3, 23
; CHECK-NEXT:    rldimi 4, 3, 53, 25
; CHECK-NEXT:    mr 3, 4
; CHECK-NEXT:    blr
  %r = call i64 @llvm.ppc.rldimi(i64 %a, i64 %b, i32 12, i64 18437737424210624511) ; mb=25, me=10
  ret i64 %r
}

define i64 @rldimi22(i64 %a, i64 %b) {
; CHECK-LABEL: rldimi22:
; CHECK:       # %bb.0:
; CHECK-NEXT:    rotldi 3, 3, 34
; CHECK-NEXT:    rldimi 4, 3, 42, 25
; CHECK-NEXT:    mr 3, 4
; CHECK-NEXT:    blr
  %r = call i64 @llvm.ppc.rldimi(i64 %a, i64 %b, i32 12, i64 18446740225418854399) ; mb=25, me=21
  ret i64 %r
}

define i64 @rldimi23(i64 %a, i64 %b) {
; CHECK-LABEL: rldimi23:
; CHECK:       # %bb.0:
; CHECK-NEXT:    rotldi 3, 3, 23
; CHECK-NEXT:    rldimi 4, 3, 53, 44
; CHECK-NEXT:    mr 3, 4
; CHECK-NEXT:    blr
  %r = call i64 @llvm.ppc.rldimi(i64 %a, i64 %b, i32 12, i64 18437736874455859199) ; mb=44, me=10
  ret i64 %r
}

define i64 @rldimi24(i64 %a, i64 %b) {
; CHECK-LABEL: rldimi24:
; CHECK:       # %bb.0:
; CHECK-NEXT:    rotldi 3, 3, 38
; CHECK-NEXT:    rldimi 4, 3, 38, 44
; CHECK-NEXT:    mr 3, 4
; CHECK-NEXT:    blr
  %r = call i64 @llvm.ppc.rldimi(i64 %a, i64 %b, i32 12, i64 18446743798832693247) ; mb=44, me=25
  ret i64 %r
}

define i64 @rldimi25(i64 %a, i64 %b) {
; CHECK-LABEL: rldimi25:
; CHECK:       # %bb.0:
; CHECK-NEXT:    rotldi 3, 3, 48
; CHECK-NEXT:    rldimi 4, 3, 28, 44
; CHECK-NEXT:    mr 3, 4
; CHECK-NEXT:    blr
  %r = call i64 @llvm.ppc.rldimi(i64 %a, i64 %b, i32 12, i64 18446744073442164735) ; mb=44, me=35
  ret i64 %r
}

declare i64 @llvm.ppc.rldimi(i64, i64, i32 immarg, i64 immarg)
