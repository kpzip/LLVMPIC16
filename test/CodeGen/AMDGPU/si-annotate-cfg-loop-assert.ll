; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=amdgcn -mcpu=kaveri -verify-machineinstrs < %s | FileCheck %s

define amdgpu_kernel void @test(i32 %arg, i32 %arg1) {
; CHECK-LABEL: test:
; CHECK:       ; %bb.0: ; %bb
; CHECK-NEXT:    s_load_dwordx2 s[0:1], s[2:3], 0x9
; CHECK-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-NEXT:    s_cmp_eq_u32 s0, 0
; CHECK-NEXT:    s_cselect_b64 s[2:3], -1, 0
; CHECK-NEXT:    s_cmp_eq_u32 s1, 0
; CHECK-NEXT:    s_cselect_b64 s[0:1], -1, 0
; CHECK-NEXT:    s_or_b64 s[0:1], s[2:3], s[0:1]
; CHECK-NEXT:    s_and_b64 vcc, exec, s[0:1]
; CHECK-NEXT:    s_cbranch_vccnz .LBB0_3
; CHECK-NEXT:  ; %bb.1: ; %bb9
; CHECK-NEXT:    s_and_b64 vcc, exec, 0
; CHECK-NEXT:  .LBB0_2: ; %bb10
; CHECK-NEXT:    ; =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    s_mov_b64 vcc, vcc
; CHECK-NEXT:    s_cbranch_vccz .LBB0_2
; CHECK-NEXT:  .LBB0_3: ; %DummyReturnBlock
; CHECK-NEXT:    s_endpgm
bb:
  %tmp = icmp ne i32 %arg, 0
  %tmp7 = icmp ne i32 %arg1, 0
  %tmp8 = and i1 %tmp, %tmp7
  br i1 %tmp8, label %bb9, label %bb11

bb9:                                              ; preds = %bb
  br label %bb10

bb10:                                             ; preds = %bb10, %bb9
  br label %bb10

bb11:                                             ; preds = %bb
  ret void
}
