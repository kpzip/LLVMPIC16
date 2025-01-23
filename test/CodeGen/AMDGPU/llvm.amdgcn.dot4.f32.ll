; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=amdgcn -mcpu=gfx1200 -verify-machineinstrs < %s | FileCheck -check-prefixes=GFX12 %s
; RUN: llc -global-isel -mtriple=amdgcn -mcpu=gfx1200 -verify-machineinstrs < %s | FileCheck -check-prefixes=GFX12 %s

define float @test_amdgcn_dot4_f32_fp8_bf8(i32 %a, i32 %b, float %c) {
; GFX12-LABEL: test_amdgcn_dot4_f32_fp8_bf8:
; GFX12:       ; %bb.0: ; %entry
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_dot4_f32_fp8_bf8 v0, v0, v1, v2
; GFX12-NEXT:    s_setpc_b64 s[30:31]
entry:
  %ret = call float @llvm.amdgcn.dot4.f32.fp8.bf8(i32 %a, i32 %b, float %c)
  ret float %ret
}

define float @test_amdgcn_dot4_f32_fp8_bf8_fabs(i32 %a, i32 %b, float %c) {
; GFX12-LABEL: test_amdgcn_dot4_f32_fp8_bf8_fabs:
; GFX12:       ; %bb.0: ; %entry
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_dot4_f32_fp8_bf8 v0, v0, v1, v2 neg_hi:[0,0,1]
; GFX12-NEXT:    s_setpc_b64 s[30:31]
entry:
  %fabs.c = call float @llvm.fabs.f32(float %c)
  %ret = call float @llvm.amdgcn.dot4.f32.fp8.bf8(i32 %a, i32 %b, float %fabs.c)
  ret float %ret
}

define float @test_amdgcn_dot4_f32_fp8_bf8_fneg(i32 %a, i32 %b, float %c) {
; GFX12-LABEL: test_amdgcn_dot4_f32_fp8_bf8_fneg:
; GFX12:       ; %bb.0: ; %entry
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_dot4_f32_fp8_bf8 v0, v0, v1, v2 neg_lo:[0,0,1]
; GFX12-NEXT:    s_setpc_b64 s[30:31]
entry:
  %fneg.c = fneg float %c
  %ret = call float @llvm.amdgcn.dot4.f32.fp8.bf8(i32 %a, i32 %b, float %fneg.c)
  ret float %ret
}

define float @test_amdgcn_dot4_f32_fp8_bf8_fabs_fneg(i32 %a, i32 %b, float %c) {
; GFX12-LABEL: test_amdgcn_dot4_f32_fp8_bf8_fabs_fneg:
; GFX12:       ; %bb.0: ; %entry
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_dot4_f32_fp8_bf8 v0, v0, v1, v2 neg_hi:[0,0,1]
; GFX12-NEXT:    s_setpc_b64 s[30:31]
entry:
  %fneg.c = fneg float %c
  %fabs.fneg.c = call float @llvm.fabs.f32(float %fneg.c)
  %ret = call float @llvm.amdgcn.dot4.f32.fp8.bf8(i32 %a, i32 %b, float %fabs.fneg.c)
  ret float %ret
}

define float @test_amdgcn_dot4_f32_fp8_bf8_fneg_fabs(i32 %a, i32 %b, float %c) {
; GFX12-LABEL: test_amdgcn_dot4_f32_fp8_bf8_fneg_fabs:
; GFX12:       ; %bb.0: ; %entry
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_dot4_f32_fp8_bf8 v0, v0, v1, v2 neg_lo:[0,0,1] neg_hi:[0,0,1]
; GFX12-NEXT:    s_setpc_b64 s[30:31]
entry:
  %fabs.c = call float @llvm.fabs.f32(float %c)
  %fneg.fabs.c = fneg float %fabs.c
  %ret = call float @llvm.amdgcn.dot4.f32.fp8.bf8(i32 %a, i32 %b, float %fneg.fabs.c)
  ret float %ret
}

define float @test_amdgcn_dot4_f32_bf8_fp8(i32 %a, i32 %b, float %c) {
; GFX12-LABEL: test_amdgcn_dot4_f32_bf8_fp8:
; GFX12:       ; %bb.0: ; %entry
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_dot4_f32_bf8_fp8 v0, v0, v1, v2
; GFX12-NEXT:    s_setpc_b64 s[30:31]
entry:
  %ret = call float @llvm.amdgcn.dot4.f32.bf8.fp8(i32 %a, i32 %b, float %c)
  ret float %ret
}

define float @test_amdgcn_dot4_f32_bf8_fp8_fabs(i32 %a, i32 %b, float %c) {
; GFX12-LABEL: test_amdgcn_dot4_f32_bf8_fp8_fabs:
; GFX12:       ; %bb.0: ; %entry
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_dot4_f32_bf8_fp8 v0, v0, v1, v2 neg_hi:[0,0,1]
; GFX12-NEXT:    s_setpc_b64 s[30:31]
entry:
  %fabs.c = call float @llvm.fabs.f32(float %c)
  %ret = call float @llvm.amdgcn.dot4.f32.bf8.fp8(i32 %a, i32 %b, float %fabs.c)
  ret float %ret
}

define float @test_amdgcn_dot4_f32_bf8_fp8_fneg(i32 %a, i32 %b, float %c) {
; GFX12-LABEL: test_amdgcn_dot4_f32_bf8_fp8_fneg:
; GFX12:       ; %bb.0: ; %entry
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_dot4_f32_bf8_fp8 v0, v0, v1, v2 neg_lo:[0,0,1]
; GFX12-NEXT:    s_setpc_b64 s[30:31]
entry:
  %fneg.c = fneg float %c
  %ret = call float @llvm.amdgcn.dot4.f32.bf8.fp8(i32 %a, i32 %b, float %fneg.c)
  ret float %ret
}

define float @test_amdgcn_dot4_f32_bf8_fp8_fabs_fneg(i32 %a, i32 %b, float %c) {
; GFX12-LABEL: test_amdgcn_dot4_f32_bf8_fp8_fabs_fneg:
; GFX12:       ; %bb.0: ; %entry
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_dot4_f32_bf8_fp8 v0, v0, v1, v2 neg_hi:[0,0,1]
; GFX12-NEXT:    s_setpc_b64 s[30:31]
entry:
  %fneg.c = fneg float %c
  %fabs.fneg.c = call float @llvm.fabs.f32(float %fneg.c)
  %ret = call float @llvm.amdgcn.dot4.f32.bf8.fp8(i32 %a, i32 %b, float %fabs.fneg.c)
  ret float %ret
}

define float @test_amdgcn_dot4_f32_bf8_fp8_fneg_fabs(i32 %a, i32 %b, float %c) {
; GFX12-LABEL: test_amdgcn_dot4_f32_bf8_fp8_fneg_fabs:
; GFX12:       ; %bb.0: ; %entry
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_dot4_f32_bf8_fp8 v0, v0, v1, v2 neg_lo:[0,0,1] neg_hi:[0,0,1]
; GFX12-NEXT:    s_setpc_b64 s[30:31]
entry:
  %fabs.c = call float @llvm.fabs.f32(float %c)
  %fneg.fabs.c = fneg float %fabs.c
  %ret = call float @llvm.amdgcn.dot4.f32.bf8.fp8(i32 %a, i32 %b, float %fneg.fabs.c)
  ret float %ret
}

define float @test_amdgcn_dot4_f32_fp8_fp8(i32 %a, i32 %b, float %c) {
; GFX12-LABEL: test_amdgcn_dot4_f32_fp8_fp8:
; GFX12:       ; %bb.0: ; %entry
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_dot4_f32_fp8_fp8 v0, v0, v1, v2
; GFX12-NEXT:    s_setpc_b64 s[30:31]
entry:
  %ret = call float @llvm.amdgcn.dot4.f32.fp8.fp8(i32 %a, i32 %b, float %c)
  ret float %ret
}

define float @test_amdgcn_dot4_f32_fp8_fp8_fabs(i32 %a, i32 %b, float %c) {
; GFX12-LABEL: test_amdgcn_dot4_f32_fp8_fp8_fabs:
; GFX12:       ; %bb.0: ; %entry
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_dot4_f32_fp8_fp8 v0, v0, v1, v2 neg_hi:[0,0,1]
; GFX12-NEXT:    s_setpc_b64 s[30:31]
entry:
  %fabs.c = call float @llvm.fabs.f32(float %c)
  %ret = call float @llvm.amdgcn.dot4.f32.fp8.fp8(i32 %a, i32 %b, float %fabs.c)
  ret float %ret
}

define float @test_amdgcn_dot4_f32_fp8_fp8_fneg(i32 %a, i32 %b, float %c) {
; GFX12-LABEL: test_amdgcn_dot4_f32_fp8_fp8_fneg:
; GFX12:       ; %bb.0: ; %entry
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_dot4_f32_fp8_fp8 v0, v0, v1, v2 neg_lo:[0,0,1]
; GFX12-NEXT:    s_setpc_b64 s[30:31]
entry:
  %fneg.c = fneg float %c
  %ret = call float @llvm.amdgcn.dot4.f32.fp8.fp8(i32 %a, i32 %b, float %fneg.c)
  ret float %ret
}

define float @test_amdgcn_dot4_f32_fp8_fp8_fabs_fneg(i32 %a, i32 %b, float %c) {
; GFX12-LABEL: test_amdgcn_dot4_f32_fp8_fp8_fabs_fneg:
; GFX12:       ; %bb.0: ; %entry
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_dot4_f32_fp8_fp8 v0, v0, v1, v2 neg_hi:[0,0,1]
; GFX12-NEXT:    s_setpc_b64 s[30:31]
entry:
  %fneg.c = fneg float %c
  %fabs.fneg.c = call float @llvm.fabs.f32(float %fneg.c)
  %ret = call float @llvm.amdgcn.dot4.f32.fp8.fp8(i32 %a, i32 %b, float %fabs.fneg.c)
  ret float %ret
}

define float @test_amdgcn_dot4_f32_fp8_fp8_fneg_fabs(i32 %a, i32 %b, float %c) {
; GFX12-LABEL: test_amdgcn_dot4_f32_fp8_fp8_fneg_fabs:
; GFX12:       ; %bb.0: ; %entry
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_dot4_f32_fp8_fp8 v0, v0, v1, v2 neg_lo:[0,0,1] neg_hi:[0,0,1]
; GFX12-NEXT:    s_setpc_b64 s[30:31]
entry:
  %fabs.c = call float @llvm.fabs.f32(float %c)
  %fneg.fabs.c = fneg float %fabs.c
  %ret = call float @llvm.amdgcn.dot4.f32.fp8.fp8(i32 %a, i32 %b, float %fneg.fabs.c)
  ret float %ret
}

define float @test_amdgcn_dot4_f32_bf8_bf8(i32 %a, i32 %b, float %c) {
; GFX12-LABEL: test_amdgcn_dot4_f32_bf8_bf8:
; GFX12:       ; %bb.0: ; %entry
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_dot4_f32_bf8_bf8 v0, v0, v1, v2
; GFX12-NEXT:    s_setpc_b64 s[30:31]
entry:
  %ret = call float @llvm.amdgcn.dot4.f32.bf8.bf8(i32 %a, i32 %b, float %c)
  ret float %ret
}

define float @test_amdgcn_dot4_f32_bf8_bf8_fabs(i32 %a, i32 %b, float %c) {
; GFX12-LABEL: test_amdgcn_dot4_f32_bf8_bf8_fabs:
; GFX12:       ; %bb.0: ; %entry
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_dot4_f32_bf8_bf8 v0, v0, v1, v2 neg_hi:[0,0,1]
; GFX12-NEXT:    s_setpc_b64 s[30:31]
entry:
  %fabs.c = call float @llvm.fabs.f32(float %c)
  %ret = call float @llvm.amdgcn.dot4.f32.bf8.bf8(i32 %a, i32 %b, float %fabs.c)
  ret float %ret
}

define float @test_amdgcn_dot4_f32_bf8_bf8_fneg(i32 %a, i32 %b, float %c) {
; GFX12-LABEL: test_amdgcn_dot4_f32_bf8_bf8_fneg:
; GFX12:       ; %bb.0: ; %entry
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_dot4_f32_bf8_bf8 v0, v0, v1, v2 neg_lo:[0,0,1]
; GFX12-NEXT:    s_setpc_b64 s[30:31]
entry:
  %fneg.c = fneg float %c
  %ret = call float @llvm.amdgcn.dot4.f32.bf8.bf8(i32 %a, i32 %b, float %fneg.c)
  ret float %ret
}

define float @test_amdgcn_dot4_f32_bf8_bf8_fabs_fneg(i32 %a, i32 %b, float %c) {
; GFX12-LABEL: test_amdgcn_dot4_f32_bf8_bf8_fabs_fneg:
; GFX12:       ; %bb.0: ; %entry
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_dot4_f32_bf8_bf8 v0, v0, v1, v2 neg_hi:[0,0,1]
; GFX12-NEXT:    s_setpc_b64 s[30:31]
entry:
  %fneg.c = fneg float %c
  %fabs.fneg.c = call float @llvm.fabs.f32(float %fneg.c)
  %ret = call float @llvm.amdgcn.dot4.f32.bf8.bf8(i32 %a, i32 %b, float %fabs.fneg.c)
  ret float %ret
}

define float @test_amdgcn_dot4_f32_bf8_bf8_fneg_fabs(i32 %a, i32 %b, float %c) {
; GFX12-LABEL: test_amdgcn_dot4_f32_bf8_bf8_fneg_fabs:
; GFX12:       ; %bb.0: ; %entry
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_dot4_f32_bf8_bf8 v0, v0, v1, v2 neg_lo:[0,0,1] neg_hi:[0,0,1]
; GFX12-NEXT:    s_setpc_b64 s[30:31]
entry:
  %fabs.c = call float @llvm.fabs.f32(float %c)
  %fneg.fabs.c = fneg float %fabs.c
  %ret = call float @llvm.amdgcn.dot4.f32.bf8.bf8(i32 %a, i32 %b, float %fneg.fabs.c)
  ret float %ret
}

declare float @llvm.amdgcn.dot4.f32.fp8.bf8(i32 %a, i32 %b, float %c)
declare float @llvm.amdgcn.dot4.f32.bf8.fp8(i32 %a, i32 %b, float %c)
declare float @llvm.amdgcn.dot4.f32.fp8.fp8(i32 %a, i32 %b, float %c)
declare float @llvm.amdgcn.dot4.f32.bf8.bf8(i32 %a, i32 %b, float %c)

declare float @llvm.fabs.f32(float %a)

