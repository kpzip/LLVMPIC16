; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=amdgcn -mcpu=verde -verify-machineinstrs | FileCheck %s -check-prefix=SI
; RUN: llc < %s -mtriple=amdgcn -mcpu=hawaii -verify-machineinstrs | FileCheck %s  -check-prefix=GFX7
; RUN: llc < %s -mtriple=amdgcn -mcpu=gfx1010 -verify-machineinstrs | FileCheck %s -check-prefix=GFX10
; RUN: llc < %s -mtriple=amdgcn -mcpu=gfx1030 -verify-machineinstrs | FileCheck %s -check-prefix=GFX1030
; RUN: llc < %s -mtriple=amdgcn -mcpu=gfx1100 -verify-machineinstrs | FileCheck %s -check-prefix=GFX1100
; RUN: llc < %s -mtriple=amdgcn -mcpu=gfx1200 -verify-machineinstrs | FileCheck %s -check-prefix=GFX12

; RUN: llc < %s -global-isel -mtriple=amdgcn -mcpu=verde -verify-machineinstrs | FileCheck %s -check-prefix=G_SI
; RUN: llc < %s -global-isel -mtriple=amdgcn -mcpu=hawaii -verify-machineinstrs | FileCheck %s  -check-prefix=G_GFX7
; RUN: llc < %s -global-isel -mtriple=amdgcn -mcpu=gfx1010 -verify-machineinstrs | FileCheck %s -check-prefix=G_GFX10
; RUN: llc < %s -global-isel -mtriple=amdgcn -mcpu=gfx1030 -verify-machineinstrs | FileCheck %s -check-prefix=G_GFX1030
; RUN: llc < %s -global-isel -mtriple=amdgcn -mcpu=gfx1100 -verify-machineinstrs | FileCheck %s -check-prefix=G_GFX1100
; RUN: llc < %s -global-isel -mtriple=amdgcn -mcpu=gfx1200 -verify-machineinstrs | FileCheck %s -check-prefix=GFX12

declare float @llvm.amdgcn.raw.buffer.atomic.fmin.f32(float, <4 x i32>, i32, i32, i32 immarg)
declare float @llvm.amdgcn.raw.buffer.atomic.fmax.f32(float, <4 x i32>, i32, i32, i32 immarg)


define amdgpu_kernel void @raw_buffer_atomic_min_noret_f32(<4 x i32> inreg %rsrc, float %data, i32 %vindex) {
; SI-LABEL: raw_buffer_atomic_min_noret_f32:
; SI:       ; %bb.0: ; %main_body
; SI-NEXT:    s_load_dwordx2 s[4:5], s[2:3], 0xd
; SI-NEXT:    s_load_dwordx4 s[0:3], s[2:3], 0x9
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    v_mov_b32_e32 v0, s4
; SI-NEXT:    v_mov_b32_e32 v1, s5
; SI-NEXT:    buffer_atomic_fmin v0, v1, s[0:3], 0 offen
; SI-NEXT:    s_endpgm
;
; GFX7-LABEL: raw_buffer_atomic_min_noret_f32:
; GFX7:       ; %bb.0: ; %main_body
; GFX7-NEXT:    s_load_dwordx2 s[4:5], s[2:3], 0xd
; GFX7-NEXT:    s_load_dwordx4 s[0:3], s[2:3], 0x9
; GFX7-NEXT:    s_waitcnt lgkmcnt(0)
; GFX7-NEXT:    v_mov_b32_e32 v0, s4
; GFX7-NEXT:    v_mov_b32_e32 v1, s5
; GFX7-NEXT:    buffer_atomic_fmin v0, v1, s[0:3], 0 offen
; GFX7-NEXT:    s_endpgm
;
; GFX10-LABEL: raw_buffer_atomic_min_noret_f32:
; GFX10:       ; %bb.0: ; %main_body
; GFX10-NEXT:    s_clause 0x1
; GFX10-NEXT:    s_load_dwordx2 s[0:1], s[2:3], 0x34
; GFX10-NEXT:    s_load_dwordx4 s[4:7], s[2:3], 0x24
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    v_mov_b32_e32 v0, s0
; GFX10-NEXT:    v_mov_b32_e32 v1, s1
; GFX10-NEXT:    buffer_atomic_fmin v0, v1, s[4:7], 0 offen
; GFX10-NEXT:    s_endpgm
;
; GFX1030-LABEL: raw_buffer_atomic_min_noret_f32:
; GFX1030:       ; %bb.0: ; %main_body
; GFX1030-NEXT:    s_clause 0x1
; GFX1030-NEXT:    s_load_dwordx2 s[4:5], s[2:3], 0x34
; GFX1030-NEXT:    s_load_dwordx4 s[0:3], s[2:3], 0x24
; GFX1030-NEXT:    s_waitcnt lgkmcnt(0)
; GFX1030-NEXT:    v_mov_b32_e32 v0, s4
; GFX1030-NEXT:    v_mov_b32_e32 v1, s5
; GFX1030-NEXT:    buffer_atomic_fmin v0, v1, s[0:3], 0 offen
; GFX1030-NEXT:    s_endpgm
;
; GFX1100-LABEL: raw_buffer_atomic_min_noret_f32:
; GFX1100:       ; %bb.0: ; %main_body
; GFX1100-NEXT:    s_clause 0x1
; GFX1100-NEXT:    s_load_b64 s[4:5], s[2:3], 0x34
; GFX1100-NEXT:    s_load_b128 s[0:3], s[2:3], 0x24
; GFX1100-NEXT:    s_waitcnt lgkmcnt(0)
; GFX1100-NEXT:    v_dual_mov_b32 v0, s4 :: v_dual_mov_b32 v1, s5
; GFX1100-NEXT:    buffer_atomic_min_f32 v0, v1, s[0:3], 0 offen
; GFX1100-NEXT:    s_nop 0
; GFX1100-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX1100-NEXT:    s_endpgm
;
; GFX12-LABEL: raw_buffer_atomic_min_noret_f32:
; GFX12:       ; %bb.0: ; %main_body
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    s_load_b64 s[4:5], s[2:3], 0x34
; GFX12-NEXT:    s_load_b128 s[0:3], s[2:3], 0x24
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_dual_mov_b32 v0, s4 :: v_dual_mov_b32 v1, s5
; GFX12-NEXT:    buffer_atomic_min_num_f32 v0, v1, s[0:3], null offen
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
;
; G_SI-LABEL: raw_buffer_atomic_min_noret_f32:
; G_SI:       ; %bb.0: ; %main_body
; G_SI-NEXT:    s_load_dwordx2 s[4:5], s[2:3], 0xd
; G_SI-NEXT:    s_load_dwordx4 s[0:3], s[2:3], 0x9
; G_SI-NEXT:    s_waitcnt lgkmcnt(0)
; G_SI-NEXT:    v_mov_b32_e32 v0, s4
; G_SI-NEXT:    v_mov_b32_e32 v1, s5
; G_SI-NEXT:    buffer_atomic_fmin v0, v1, s[0:3], 0 offen
; G_SI-NEXT:    s_endpgm
;
; G_GFX7-LABEL: raw_buffer_atomic_min_noret_f32:
; G_GFX7:       ; %bb.0: ; %main_body
; G_GFX7-NEXT:    s_load_dwordx2 s[4:5], s[2:3], 0xd
; G_GFX7-NEXT:    s_load_dwordx4 s[0:3], s[2:3], 0x9
; G_GFX7-NEXT:    s_waitcnt lgkmcnt(0)
; G_GFX7-NEXT:    v_mov_b32_e32 v0, s4
; G_GFX7-NEXT:    v_mov_b32_e32 v1, s5
; G_GFX7-NEXT:    buffer_atomic_fmin v0, v1, s[0:3], 0 offen
; G_GFX7-NEXT:    s_endpgm
;
; G_GFX10-LABEL: raw_buffer_atomic_min_noret_f32:
; G_GFX10:       ; %bb.0: ; %main_body
; G_GFX10-NEXT:    s_clause 0x1
; G_GFX10-NEXT:    s_load_dwordx2 s[0:1], s[2:3], 0x34
; G_GFX10-NEXT:    s_load_dwordx4 s[4:7], s[2:3], 0x24
; G_GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; G_GFX10-NEXT:    v_mov_b32_e32 v0, s0
; G_GFX10-NEXT:    v_mov_b32_e32 v1, s1
; G_GFX10-NEXT:    buffer_atomic_fmin v0, v1, s[4:7], 0 offen
; G_GFX10-NEXT:    s_endpgm
;
; G_GFX1030-LABEL: raw_buffer_atomic_min_noret_f32:
; G_GFX1030:       ; %bb.0: ; %main_body
; G_GFX1030-NEXT:    s_clause 0x1
; G_GFX1030-NEXT:    s_load_dwordx2 s[4:5], s[2:3], 0x34
; G_GFX1030-NEXT:    s_load_dwordx4 s[0:3], s[2:3], 0x24
; G_GFX1030-NEXT:    s_waitcnt lgkmcnt(0)
; G_GFX1030-NEXT:    v_mov_b32_e32 v0, s4
; G_GFX1030-NEXT:    v_mov_b32_e32 v1, s5
; G_GFX1030-NEXT:    buffer_atomic_fmin v0, v1, s[0:3], 0 offen
; G_GFX1030-NEXT:    s_endpgm
;
; G_GFX1100-LABEL: raw_buffer_atomic_min_noret_f32:
; G_GFX1100:       ; %bb.0: ; %main_body
; G_GFX1100-NEXT:    s_clause 0x1
; G_GFX1100-NEXT:    s_load_b64 s[4:5], s[2:3], 0x34
; G_GFX1100-NEXT:    s_load_b128 s[0:3], s[2:3], 0x24
; G_GFX1100-NEXT:    s_waitcnt lgkmcnt(0)
; G_GFX1100-NEXT:    v_dual_mov_b32 v0, s4 :: v_dual_mov_b32 v1, s5
; G_GFX1100-NEXT:    buffer_atomic_min_f32 v0, v1, s[0:3], 0 offen
; G_GFX1100-NEXT:    s_nop 0
; G_GFX1100-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; G_GFX1100-NEXT:    s_endpgm
main_body:
  %ret = call float @llvm.amdgcn.raw.buffer.atomic.fmin.f32(float %data, <4 x i32> %rsrc, i32 %vindex, i32 0, i32 0)
  ret void
}

define amdgpu_ps void @raw_buffer_atomic_min_rtn_f32(<4 x i32> inreg %rsrc, float %data, i32 %vindex) {
; SI-LABEL: raw_buffer_atomic_min_rtn_f32:
; SI:       ; %bb.0: ; %main_body
; SI-NEXT:    buffer_atomic_fmin v0, v1, s[0:3], 0 offen glc
; SI-NEXT:    s_mov_b32 s3, 0xf000
; SI-NEXT:    s_mov_b32 s2, -1
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; SI-NEXT:    s_endpgm
;
; GFX7-LABEL: raw_buffer_atomic_min_rtn_f32:
; GFX7:       ; %bb.0: ; %main_body
; GFX7-NEXT:    buffer_atomic_fmin v0, v1, s[0:3], 0 offen glc
; GFX7-NEXT:    s_mov_b32 s3, 0xf000
; GFX7-NEXT:    s_mov_b32 s2, -1
; GFX7-NEXT:    s_waitcnt vmcnt(0)
; GFX7-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; GFX7-NEXT:    s_endpgm
;
; GFX10-LABEL: raw_buffer_atomic_min_rtn_f32:
; GFX10:       ; %bb.0: ; %main_body
; GFX10-NEXT:    buffer_atomic_fmin v0, v1, s[0:3], 0 offen glc
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    global_store_dword v[0:1], v0, off
; GFX10-NEXT:    s_endpgm
;
; GFX1030-LABEL: raw_buffer_atomic_min_rtn_f32:
; GFX1030:       ; %bb.0: ; %main_body
; GFX1030-NEXT:    buffer_atomic_fmin v0, v1, s[0:3], 0 offen glc
; GFX1030-NEXT:    s_waitcnt vmcnt(0)
; GFX1030-NEXT:    global_store_dword v[0:1], v0, off
; GFX1030-NEXT:    s_endpgm
;
; GFX1100-LABEL: raw_buffer_atomic_min_rtn_f32:
; GFX1100:       ; %bb.0: ; %main_body
; GFX1100-NEXT:    buffer_atomic_min_f32 v0, v1, s[0:3], 0 offen glc
; GFX1100-NEXT:    s_waitcnt vmcnt(0)
; GFX1100-NEXT:    global_store_b32 v[0:1], v0, off
; GFX1100-NEXT:    s_nop 0
; GFX1100-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX1100-NEXT:    s_endpgm
;
; GFX12-LABEL: raw_buffer_atomic_min_rtn_f32:
; GFX12:       ; %bb.0: ; %main_body
; GFX12-NEXT:    buffer_atomic_min_num_f32 v0, v1, s[0:3], null offen th:TH_ATOMIC_RETURN
; GFX12-NEXT:    s_wait_loadcnt 0x0
; GFX12-NEXT:    global_store_b32 v[0:1], v0, off
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
;
; G_SI-LABEL: raw_buffer_atomic_min_rtn_f32:
; G_SI:       ; %bb.0: ; %main_body
; G_SI-NEXT:    buffer_atomic_fmin v0, v1, s[0:3], 0 offen glc
; G_SI-NEXT:    s_mov_b32 s2, -1
; G_SI-NEXT:    s_mov_b32 s3, 0xf000
; G_SI-NEXT:    s_waitcnt vmcnt(0)
; G_SI-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; G_SI-NEXT:    s_endpgm
;
; G_GFX7-LABEL: raw_buffer_atomic_min_rtn_f32:
; G_GFX7:       ; %bb.0: ; %main_body
; G_GFX7-NEXT:    buffer_atomic_fmin v0, v1, s[0:3], 0 offen glc
; G_GFX7-NEXT:    s_mov_b32 s2, -1
; G_GFX7-NEXT:    s_mov_b32 s3, 0xf000
; G_GFX7-NEXT:    s_waitcnt vmcnt(0)
; G_GFX7-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; G_GFX7-NEXT:    s_endpgm
;
; G_GFX10-LABEL: raw_buffer_atomic_min_rtn_f32:
; G_GFX10:       ; %bb.0: ; %main_body
; G_GFX10-NEXT:    buffer_atomic_fmin v0, v1, s[0:3], 0 offen glc
; G_GFX10-NEXT:    s_waitcnt vmcnt(0)
; G_GFX10-NEXT:    global_store_dword v[0:1], v0, off
; G_GFX10-NEXT:    s_endpgm
;
; G_GFX1030-LABEL: raw_buffer_atomic_min_rtn_f32:
; G_GFX1030:       ; %bb.0: ; %main_body
; G_GFX1030-NEXT:    buffer_atomic_fmin v0, v1, s[0:3], 0 offen glc
; G_GFX1030-NEXT:    s_waitcnt vmcnt(0)
; G_GFX1030-NEXT:    global_store_dword v[0:1], v0, off
; G_GFX1030-NEXT:    s_endpgm
;
; G_GFX1100-LABEL: raw_buffer_atomic_min_rtn_f32:
; G_GFX1100:       ; %bb.0: ; %main_body
; G_GFX1100-NEXT:    buffer_atomic_min_f32 v0, v1, s[0:3], 0 offen glc
; G_GFX1100-NEXT:    s_waitcnt vmcnt(0)
; G_GFX1100-NEXT:    global_store_b32 v[0:1], v0, off
; G_GFX1100-NEXT:    s_nop 0
; G_GFX1100-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; G_GFX1100-NEXT:    s_endpgm
main_body:
  %ret = call float @llvm.amdgcn.raw.buffer.atomic.fmin.f32(float %data, <4 x i32> %rsrc, i32 %vindex, i32 0, i32 0)
  store float %ret, ptr addrspace(1) undef
  ret void
}

define amdgpu_kernel void @raw_buffer_atomic_min_rtn_f32_off4_slc(<4 x i32> inreg %rsrc, float %data, i32 %vindex, ptr addrspace(3) %out) {
; SI-LABEL: raw_buffer_atomic_min_rtn_f32_off4_slc:
; SI:       ; %bb.0: ; %main_body
; SI-NEXT:    s_load_dwordx2 s[0:1], s[2:3], 0xd
; SI-NEXT:    s_load_dwordx4 s[4:7], s[2:3], 0x9
; SI-NEXT:    s_mov_b32 m0, -1
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    v_mov_b32_e32 v0, s0
; SI-NEXT:    v_mov_b32_e32 v1, s1
; SI-NEXT:    buffer_atomic_fmin v0, v1, s[4:7], 4 offen glc slc
; SI-NEXT:    s_load_dword s0, s[2:3], 0xf
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    v_mov_b32_e32 v1, s0
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    ds_write_b32 v1, v0
; SI-NEXT:    s_endpgm
;
; GFX7-LABEL: raw_buffer_atomic_min_rtn_f32_off4_slc:
; GFX7:       ; %bb.0: ; %main_body
; GFX7-NEXT:    s_load_dwordx8 s[0:7], s[2:3], 0x9
; GFX7-NEXT:    s_mov_b32 m0, -1
; GFX7-NEXT:    s_waitcnt lgkmcnt(0)
; GFX7-NEXT:    v_mov_b32_e32 v0, s4
; GFX7-NEXT:    v_mov_b32_e32 v1, s5
; GFX7-NEXT:    buffer_atomic_fmin v0, v1, s[0:3], 4 offen glc slc
; GFX7-NEXT:    v_mov_b32_e32 v1, s6
; GFX7-NEXT:    s_waitcnt vmcnt(0)
; GFX7-NEXT:    ds_write_b32 v1, v0
; GFX7-NEXT:    s_endpgm
;
; GFX10-LABEL: raw_buffer_atomic_min_rtn_f32_off4_slc:
; GFX10:       ; %bb.0: ; %main_body
; GFX10-NEXT:    s_load_dwordx8 s[4:11], s[2:3], 0x24
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    v_mov_b32_e32 v0, s8
; GFX10-NEXT:    v_mov_b32_e32 v1, s9
; GFX10-NEXT:    buffer_atomic_fmin v0, v1, s[4:7], 4 offen glc slc
; GFX10-NEXT:    v_mov_b32_e32 v1, s10
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    ds_write_b32 v1, v0
; GFX10-NEXT:    s_endpgm
;
; GFX1030-LABEL: raw_buffer_atomic_min_rtn_f32_off4_slc:
; GFX1030:       ; %bb.0: ; %main_body
; GFX1030-NEXT:    s_load_dwordx8 s[0:7], s[2:3], 0x24
; GFX1030-NEXT:    s_waitcnt lgkmcnt(0)
; GFX1030-NEXT:    v_mov_b32_e32 v0, s4
; GFX1030-NEXT:    v_mov_b32_e32 v1, s5
; GFX1030-NEXT:    buffer_atomic_fmin v0, v1, s[0:3], 4 offen glc slc
; GFX1030-NEXT:    v_mov_b32_e32 v1, s6
; GFX1030-NEXT:    s_waitcnt vmcnt(0)
; GFX1030-NEXT:    ds_write_b32 v1, v0
; GFX1030-NEXT:    s_endpgm
;
; GFX1100-LABEL: raw_buffer_atomic_min_rtn_f32_off4_slc:
; GFX1100:       ; %bb.0: ; %main_body
; GFX1100-NEXT:    s_load_b256 s[0:7], s[2:3], 0x24
; GFX1100-NEXT:    s_waitcnt lgkmcnt(0)
; GFX1100-NEXT:    v_dual_mov_b32 v0, s4 :: v_dual_mov_b32 v1, s5
; GFX1100-NEXT:    buffer_atomic_min_f32 v0, v1, s[0:3], 4 offen glc slc
; GFX1100-NEXT:    v_mov_b32_e32 v1, s6
; GFX1100-NEXT:    s_waitcnt vmcnt(0)
; GFX1100-NEXT:    ds_store_b32 v1, v0
; GFX1100-NEXT:    s_endpgm
;
; GFX12-LABEL: raw_buffer_atomic_min_rtn_f32_off4_slc:
; GFX12:       ; %bb.0: ; %main_body
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    s_load_b96 s[4:6], s[2:3], 0x34
; GFX12-NEXT:    s_load_b128 s[0:3], s[2:3], 0x24
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_dual_mov_b32 v0, s4 :: v_dual_mov_b32 v1, s5
; GFX12-NEXT:    s_mov_b32 s4, 4
; GFX12-NEXT:    buffer_atomic_min_num_f32 v0, v1, s[0:3], s4 offen th:TH_ATOMIC_NT_RETURN
; GFX12-NEXT:    v_mov_b32_e32 v1, s6
; GFX12-NEXT:    s_wait_loadcnt 0x0
; GFX12-NEXT:    ds_store_b32 v1, v0
; GFX12-NEXT:    s_endpgm
;
; G_SI-LABEL: raw_buffer_atomic_min_rtn_f32_off4_slc:
; G_SI:       ; %bb.0: ; %main_body
; G_SI-NEXT:    s_load_dwordx2 s[0:1], s[2:3], 0xd
; G_SI-NEXT:    s_load_dwordx4 s[4:7], s[2:3], 0x9
; G_SI-NEXT:    s_mov_b32 m0, -1
; G_SI-NEXT:    s_waitcnt lgkmcnt(0)
; G_SI-NEXT:    v_mov_b32_e32 v0, s0
; G_SI-NEXT:    v_mov_b32_e32 v1, s1
; G_SI-NEXT:    buffer_atomic_fmin v0, v1, s[4:7], 4 offen glc slc
; G_SI-NEXT:    s_load_dword s0, s[2:3], 0xf
; G_SI-NEXT:    s_waitcnt lgkmcnt(0)
; G_SI-NEXT:    v_mov_b32_e32 v1, s0
; G_SI-NEXT:    s_waitcnt vmcnt(0)
; G_SI-NEXT:    ds_write_b32 v1, v0
; G_SI-NEXT:    s_endpgm
;
; G_GFX7-LABEL: raw_buffer_atomic_min_rtn_f32_off4_slc:
; G_GFX7:       ; %bb.0: ; %main_body
; G_GFX7-NEXT:    s_load_dwordx2 s[0:1], s[2:3], 0xd
; G_GFX7-NEXT:    s_load_dwordx4 s[4:7], s[2:3], 0x9
; G_GFX7-NEXT:    s_mov_b32 m0, -1
; G_GFX7-NEXT:    s_waitcnt lgkmcnt(0)
; G_GFX7-NEXT:    v_mov_b32_e32 v0, s0
; G_GFX7-NEXT:    v_mov_b32_e32 v1, s1
; G_GFX7-NEXT:    buffer_atomic_fmin v0, v1, s[4:7], 4 offen glc slc
; G_GFX7-NEXT:    s_load_dword s0, s[2:3], 0xf
; G_GFX7-NEXT:    s_waitcnt lgkmcnt(0)
; G_GFX7-NEXT:    v_mov_b32_e32 v1, s0
; G_GFX7-NEXT:    s_waitcnt vmcnt(0)
; G_GFX7-NEXT:    ds_write_b32 v1, v0
; G_GFX7-NEXT:    s_endpgm
;
; G_GFX10-LABEL: raw_buffer_atomic_min_rtn_f32_off4_slc:
; G_GFX10:       ; %bb.0: ; %main_body
; G_GFX10-NEXT:    s_clause 0x1
; G_GFX10-NEXT:    s_load_dwordx2 s[0:1], s[2:3], 0x34
; G_GFX10-NEXT:    s_load_dwordx4 s[4:7], s[2:3], 0x24
; G_GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; G_GFX10-NEXT:    v_mov_b32_e32 v0, s0
; G_GFX10-NEXT:    v_mov_b32_e32 v1, s1
; G_GFX10-NEXT:    s_load_dword s0, s[2:3], 0x3c
; G_GFX10-NEXT:    buffer_atomic_fmin v0, v1, s[4:7], 4 offen glc slc
; G_GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; G_GFX10-NEXT:    v_mov_b32_e32 v1, s0
; G_GFX10-NEXT:    s_waitcnt vmcnt(0)
; G_GFX10-NEXT:    ds_write_b32 v1, v0
; G_GFX10-NEXT:    s_endpgm
;
; G_GFX1030-LABEL: raw_buffer_atomic_min_rtn_f32_off4_slc:
; G_GFX1030:       ; %bb.0: ; %main_body
; G_GFX1030-NEXT:    s_clause 0x1
; G_GFX1030-NEXT:    s_load_dwordx2 s[0:1], s[2:3], 0x34
; G_GFX1030-NEXT:    s_load_dwordx4 s[4:7], s[2:3], 0x24
; G_GFX1030-NEXT:    s_waitcnt lgkmcnt(0)
; G_GFX1030-NEXT:    v_mov_b32_e32 v0, s0
; G_GFX1030-NEXT:    v_mov_b32_e32 v1, s1
; G_GFX1030-NEXT:    s_load_dword s0, s[2:3], 0x3c
; G_GFX1030-NEXT:    buffer_atomic_fmin v0, v1, s[4:7], 4 offen glc slc
; G_GFX1030-NEXT:    s_waitcnt lgkmcnt(0)
; G_GFX1030-NEXT:    v_mov_b32_e32 v1, s0
; G_GFX1030-NEXT:    s_waitcnt vmcnt(0)
; G_GFX1030-NEXT:    ds_write_b32 v1, v0
; G_GFX1030-NEXT:    s_endpgm
;
; G_GFX1100-LABEL: raw_buffer_atomic_min_rtn_f32_off4_slc:
; G_GFX1100:       ; %bb.0: ; %main_body
; G_GFX1100-NEXT:    s_clause 0x1
; G_GFX1100-NEXT:    s_load_b64 s[0:1], s[2:3], 0x34
; G_GFX1100-NEXT:    s_load_b128 s[4:7], s[2:3], 0x24
; G_GFX1100-NEXT:    s_waitcnt lgkmcnt(0)
; G_GFX1100-NEXT:    v_dual_mov_b32 v0, s0 :: v_dual_mov_b32 v1, s1
; G_GFX1100-NEXT:    s_load_b32 s0, s[2:3], 0x3c
; G_GFX1100-NEXT:    buffer_atomic_min_f32 v0, v1, s[4:7], 4 offen glc slc
; G_GFX1100-NEXT:    s_waitcnt lgkmcnt(0)
; G_GFX1100-NEXT:    v_mov_b32_e32 v1, s0
; G_GFX1100-NEXT:    s_waitcnt vmcnt(0)
; G_GFX1100-NEXT:    ds_store_b32 v1, v0
; G_GFX1100-NEXT:    s_endpgm
main_body:
  %ret = call float @llvm.amdgcn.raw.buffer.atomic.fmin.f32(float %data, <4 x i32> %rsrc, i32 %vindex, i32 4, i32 2)
  store float %ret, ptr addrspace(3) %out, align 8
  ret void
}

define amdgpu_kernel void @raw_buffer_atomic_max_noret_f32(<4 x i32> inreg %rsrc, float %data, i32 %vindex) {
; SI-LABEL: raw_buffer_atomic_max_noret_f32:
; SI:       ; %bb.0: ; %main_body
; SI-NEXT:    s_load_dwordx2 s[4:5], s[2:3], 0xd
; SI-NEXT:    s_load_dwordx4 s[0:3], s[2:3], 0x9
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    v_mov_b32_e32 v0, s4
; SI-NEXT:    v_mov_b32_e32 v1, s5
; SI-NEXT:    buffer_atomic_fmax v0, v1, s[0:3], 0 offen
; SI-NEXT:    s_endpgm
;
; GFX7-LABEL: raw_buffer_atomic_max_noret_f32:
; GFX7:       ; %bb.0: ; %main_body
; GFX7-NEXT:    s_load_dwordx2 s[4:5], s[2:3], 0xd
; GFX7-NEXT:    s_load_dwordx4 s[0:3], s[2:3], 0x9
; GFX7-NEXT:    s_waitcnt lgkmcnt(0)
; GFX7-NEXT:    v_mov_b32_e32 v0, s4
; GFX7-NEXT:    v_mov_b32_e32 v1, s5
; GFX7-NEXT:    buffer_atomic_fmax v0, v1, s[0:3], 0 offen
; GFX7-NEXT:    s_endpgm
;
; GFX10-LABEL: raw_buffer_atomic_max_noret_f32:
; GFX10:       ; %bb.0: ; %main_body
; GFX10-NEXT:    s_clause 0x1
; GFX10-NEXT:    s_load_dwordx2 s[0:1], s[2:3], 0x34
; GFX10-NEXT:    s_load_dwordx4 s[4:7], s[2:3], 0x24
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    v_mov_b32_e32 v0, s0
; GFX10-NEXT:    v_mov_b32_e32 v1, s1
; GFX10-NEXT:    buffer_atomic_fmax v0, v1, s[4:7], 0 offen
; GFX10-NEXT:    s_endpgm
;
; GFX1030-LABEL: raw_buffer_atomic_max_noret_f32:
; GFX1030:       ; %bb.0: ; %main_body
; GFX1030-NEXT:    s_clause 0x1
; GFX1030-NEXT:    s_load_dwordx2 s[4:5], s[2:3], 0x34
; GFX1030-NEXT:    s_load_dwordx4 s[0:3], s[2:3], 0x24
; GFX1030-NEXT:    s_waitcnt lgkmcnt(0)
; GFX1030-NEXT:    v_mov_b32_e32 v0, s4
; GFX1030-NEXT:    v_mov_b32_e32 v1, s5
; GFX1030-NEXT:    buffer_atomic_fmax v0, v1, s[0:3], 0 offen
; GFX1030-NEXT:    s_endpgm
;
; GFX1100-LABEL: raw_buffer_atomic_max_noret_f32:
; GFX1100:       ; %bb.0: ; %main_body
; GFX1100-NEXT:    s_clause 0x1
; GFX1100-NEXT:    s_load_b64 s[4:5], s[2:3], 0x34
; GFX1100-NEXT:    s_load_b128 s[0:3], s[2:3], 0x24
; GFX1100-NEXT:    s_waitcnt lgkmcnt(0)
; GFX1100-NEXT:    v_dual_mov_b32 v0, s4 :: v_dual_mov_b32 v1, s5
; GFX1100-NEXT:    buffer_atomic_max_f32 v0, v1, s[0:3], 0 offen
; GFX1100-NEXT:    s_nop 0
; GFX1100-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX1100-NEXT:    s_endpgm
;
; GFX12-LABEL: raw_buffer_atomic_max_noret_f32:
; GFX12:       ; %bb.0: ; %main_body
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    s_load_b64 s[4:5], s[2:3], 0x34
; GFX12-NEXT:    s_load_b128 s[0:3], s[2:3], 0x24
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_dual_mov_b32 v0, s4 :: v_dual_mov_b32 v1, s5
; GFX12-NEXT:    buffer_atomic_max_num_f32 v0, v1, s[0:3], null offen
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
;
; G_SI-LABEL: raw_buffer_atomic_max_noret_f32:
; G_SI:       ; %bb.0: ; %main_body
; G_SI-NEXT:    s_load_dwordx2 s[4:5], s[2:3], 0xd
; G_SI-NEXT:    s_load_dwordx4 s[0:3], s[2:3], 0x9
; G_SI-NEXT:    s_waitcnt lgkmcnt(0)
; G_SI-NEXT:    v_mov_b32_e32 v0, s4
; G_SI-NEXT:    v_mov_b32_e32 v1, s5
; G_SI-NEXT:    buffer_atomic_fmax v0, v1, s[0:3], 0 offen
; G_SI-NEXT:    s_endpgm
;
; G_GFX7-LABEL: raw_buffer_atomic_max_noret_f32:
; G_GFX7:       ; %bb.0: ; %main_body
; G_GFX7-NEXT:    s_load_dwordx2 s[4:5], s[2:3], 0xd
; G_GFX7-NEXT:    s_load_dwordx4 s[0:3], s[2:3], 0x9
; G_GFX7-NEXT:    s_waitcnt lgkmcnt(0)
; G_GFX7-NEXT:    v_mov_b32_e32 v0, s4
; G_GFX7-NEXT:    v_mov_b32_e32 v1, s5
; G_GFX7-NEXT:    buffer_atomic_fmax v0, v1, s[0:3], 0 offen
; G_GFX7-NEXT:    s_endpgm
;
; G_GFX10-LABEL: raw_buffer_atomic_max_noret_f32:
; G_GFX10:       ; %bb.0: ; %main_body
; G_GFX10-NEXT:    s_clause 0x1
; G_GFX10-NEXT:    s_load_dwordx2 s[0:1], s[2:3], 0x34
; G_GFX10-NEXT:    s_load_dwordx4 s[4:7], s[2:3], 0x24
; G_GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; G_GFX10-NEXT:    v_mov_b32_e32 v0, s0
; G_GFX10-NEXT:    v_mov_b32_e32 v1, s1
; G_GFX10-NEXT:    buffer_atomic_fmax v0, v1, s[4:7], 0 offen
; G_GFX10-NEXT:    s_endpgm
;
; G_GFX1030-LABEL: raw_buffer_atomic_max_noret_f32:
; G_GFX1030:       ; %bb.0: ; %main_body
; G_GFX1030-NEXT:    s_clause 0x1
; G_GFX1030-NEXT:    s_load_dwordx2 s[4:5], s[2:3], 0x34
; G_GFX1030-NEXT:    s_load_dwordx4 s[0:3], s[2:3], 0x24
; G_GFX1030-NEXT:    s_waitcnt lgkmcnt(0)
; G_GFX1030-NEXT:    v_mov_b32_e32 v0, s4
; G_GFX1030-NEXT:    v_mov_b32_e32 v1, s5
; G_GFX1030-NEXT:    buffer_atomic_fmax v0, v1, s[0:3], 0 offen
; G_GFX1030-NEXT:    s_endpgm
;
; G_GFX1100-LABEL: raw_buffer_atomic_max_noret_f32:
; G_GFX1100:       ; %bb.0: ; %main_body
; G_GFX1100-NEXT:    s_clause 0x1
; G_GFX1100-NEXT:    s_load_b64 s[4:5], s[2:3], 0x34
; G_GFX1100-NEXT:    s_load_b128 s[0:3], s[2:3], 0x24
; G_GFX1100-NEXT:    s_waitcnt lgkmcnt(0)
; G_GFX1100-NEXT:    v_dual_mov_b32 v0, s4 :: v_dual_mov_b32 v1, s5
; G_GFX1100-NEXT:    buffer_atomic_max_f32 v0, v1, s[0:3], 0 offen
; G_GFX1100-NEXT:    s_nop 0
; G_GFX1100-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; G_GFX1100-NEXT:    s_endpgm
main_body:
  %ret = call float @llvm.amdgcn.raw.buffer.atomic.fmax.f32(float %data, <4 x i32> %rsrc, i32 %vindex, i32 0, i32 0)
  ret void
}

define amdgpu_ps void @raw_buffer_atomic_max_rtn_f32(<4 x i32> inreg %rsrc, float %data, i32 %vindex) {
; SI-LABEL: raw_buffer_atomic_max_rtn_f32:
; SI:       ; %bb.0: ; %main_body
; SI-NEXT:    buffer_atomic_fmax v0, v1, s[0:3], 0 offen glc
; SI-NEXT:    s_mov_b32 s3, 0xf000
; SI-NEXT:    s_mov_b32 s2, -1
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; SI-NEXT:    s_endpgm
;
; GFX7-LABEL: raw_buffer_atomic_max_rtn_f32:
; GFX7:       ; %bb.0: ; %main_body
; GFX7-NEXT:    buffer_atomic_fmax v0, v1, s[0:3], 0 offen glc
; GFX7-NEXT:    s_mov_b32 s3, 0xf000
; GFX7-NEXT:    s_mov_b32 s2, -1
; GFX7-NEXT:    s_waitcnt vmcnt(0)
; GFX7-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; GFX7-NEXT:    s_endpgm
;
; GFX10-LABEL: raw_buffer_atomic_max_rtn_f32:
; GFX10:       ; %bb.0: ; %main_body
; GFX10-NEXT:    buffer_atomic_fmax v0, v1, s[0:3], 0 offen glc
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    global_store_dword v[0:1], v0, off
; GFX10-NEXT:    s_endpgm
;
; GFX1030-LABEL: raw_buffer_atomic_max_rtn_f32:
; GFX1030:       ; %bb.0: ; %main_body
; GFX1030-NEXT:    buffer_atomic_fmax v0, v1, s[0:3], 0 offen glc
; GFX1030-NEXT:    s_waitcnt vmcnt(0)
; GFX1030-NEXT:    global_store_dword v[0:1], v0, off
; GFX1030-NEXT:    s_endpgm
;
; GFX1100-LABEL: raw_buffer_atomic_max_rtn_f32:
; GFX1100:       ; %bb.0: ; %main_body
; GFX1100-NEXT:    buffer_atomic_max_f32 v0, v1, s[0:3], 0 offen glc
; GFX1100-NEXT:    s_waitcnt vmcnt(0)
; GFX1100-NEXT:    global_store_b32 v[0:1], v0, off
; GFX1100-NEXT:    s_nop 0
; GFX1100-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX1100-NEXT:    s_endpgm
;
; GFX12-LABEL: raw_buffer_atomic_max_rtn_f32:
; GFX12:       ; %bb.0: ; %main_body
; GFX12-NEXT:    buffer_atomic_max_num_f32 v0, v1, s[0:3], null offen th:TH_ATOMIC_RETURN
; GFX12-NEXT:    s_wait_loadcnt 0x0
; GFX12-NEXT:    global_store_b32 v[0:1], v0, off
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
;
; G_SI-LABEL: raw_buffer_atomic_max_rtn_f32:
; G_SI:       ; %bb.0: ; %main_body
; G_SI-NEXT:    buffer_atomic_fmax v0, v1, s[0:3], 0 offen glc
; G_SI-NEXT:    s_mov_b32 s2, -1
; G_SI-NEXT:    s_mov_b32 s3, 0xf000
; G_SI-NEXT:    s_waitcnt vmcnt(0)
; G_SI-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; G_SI-NEXT:    s_endpgm
;
; G_GFX7-LABEL: raw_buffer_atomic_max_rtn_f32:
; G_GFX7:       ; %bb.0: ; %main_body
; G_GFX7-NEXT:    buffer_atomic_fmax v0, v1, s[0:3], 0 offen glc
; G_GFX7-NEXT:    s_mov_b32 s2, -1
; G_GFX7-NEXT:    s_mov_b32 s3, 0xf000
; G_GFX7-NEXT:    s_waitcnt vmcnt(0)
; G_GFX7-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; G_GFX7-NEXT:    s_endpgm
;
; G_GFX10-LABEL: raw_buffer_atomic_max_rtn_f32:
; G_GFX10:       ; %bb.0: ; %main_body
; G_GFX10-NEXT:    buffer_atomic_fmax v0, v1, s[0:3], 0 offen glc
; G_GFX10-NEXT:    s_waitcnt vmcnt(0)
; G_GFX10-NEXT:    global_store_dword v[0:1], v0, off
; G_GFX10-NEXT:    s_endpgm
;
; G_GFX1030-LABEL: raw_buffer_atomic_max_rtn_f32:
; G_GFX1030:       ; %bb.0: ; %main_body
; G_GFX1030-NEXT:    buffer_atomic_fmax v0, v1, s[0:3], 0 offen glc
; G_GFX1030-NEXT:    s_waitcnt vmcnt(0)
; G_GFX1030-NEXT:    global_store_dword v[0:1], v0, off
; G_GFX1030-NEXT:    s_endpgm
;
; G_GFX1100-LABEL: raw_buffer_atomic_max_rtn_f32:
; G_GFX1100:       ; %bb.0: ; %main_body
; G_GFX1100-NEXT:    buffer_atomic_max_f32 v0, v1, s[0:3], 0 offen glc
; G_GFX1100-NEXT:    s_waitcnt vmcnt(0)
; G_GFX1100-NEXT:    global_store_b32 v[0:1], v0, off
; G_GFX1100-NEXT:    s_nop 0
; G_GFX1100-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; G_GFX1100-NEXT:    s_endpgm
main_body:
  %ret = call float @llvm.amdgcn.raw.buffer.atomic.fmax.f32(float %data, <4 x i32> %rsrc, i32 %vindex, i32 0, i32 0)
  store float %ret, ptr addrspace(1) undef
  ret void
}

define amdgpu_kernel void @raw_buffer_atomic_max_rtn_f32_off4_slc(<4 x i32> inreg %rsrc, float %data, i32 %vindex, ptr addrspace(1) %out) {
; SI-LABEL: raw_buffer_atomic_max_rtn_f32_off4_slc:
; SI:       ; %bb.0: ; %main_body
; SI-NEXT:    s_load_dwordx8 s[0:7], s[2:3], 0x9
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    v_mov_b32_e32 v0, s4
; SI-NEXT:    v_mov_b32_e32 v1, s5
; SI-NEXT:    buffer_atomic_fmax v0, v1, s[0:3], 4 offen glc slc
; SI-NEXT:    s_mov_b32 s3, 0xf000
; SI-NEXT:    s_mov_b32 s2, -1
; SI-NEXT:    s_mov_b32 s0, s6
; SI-NEXT:    s_mov_b32 s1, s7
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; SI-NEXT:    s_endpgm
;
; GFX7-LABEL: raw_buffer_atomic_max_rtn_f32_off4_slc:
; GFX7:       ; %bb.0: ; %main_body
; GFX7-NEXT:    s_load_dwordx8 s[0:7], s[2:3], 0x9
; GFX7-NEXT:    s_waitcnt lgkmcnt(0)
; GFX7-NEXT:    v_mov_b32_e32 v0, s4
; GFX7-NEXT:    v_mov_b32_e32 v1, s5
; GFX7-NEXT:    buffer_atomic_fmax v0, v1, s[0:3], 4 offen glc slc
; GFX7-NEXT:    s_mov_b32 s3, 0xf000
; GFX7-NEXT:    s_mov_b32 s2, -1
; GFX7-NEXT:    s_mov_b32 s0, s6
; GFX7-NEXT:    s_mov_b32 s1, s7
; GFX7-NEXT:    s_waitcnt vmcnt(0)
; GFX7-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; GFX7-NEXT:    s_endpgm
;
; GFX10-LABEL: raw_buffer_atomic_max_rtn_f32_off4_slc:
; GFX10:       ; %bb.0: ; %main_body
; GFX10-NEXT:    s_load_dwordx8 s[4:11], s[2:3], 0x24
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    v_mov_b32_e32 v0, s8
; GFX10-NEXT:    v_mov_b32_e32 v1, s9
; GFX10-NEXT:    buffer_atomic_fmax v0, v1, s[4:7], 4 offen glc slc
; GFX10-NEXT:    v_mov_b32_e32 v1, 0
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    global_store_dword v1, v0, s[10:11]
; GFX10-NEXT:    s_endpgm
;
; GFX1030-LABEL: raw_buffer_atomic_max_rtn_f32_off4_slc:
; GFX1030:       ; %bb.0: ; %main_body
; GFX1030-NEXT:    s_load_dwordx8 s[0:7], s[2:3], 0x24
; GFX1030-NEXT:    s_waitcnt lgkmcnt(0)
; GFX1030-NEXT:    v_mov_b32_e32 v0, s4
; GFX1030-NEXT:    v_mov_b32_e32 v1, s5
; GFX1030-NEXT:    buffer_atomic_fmax v0, v1, s[0:3], 4 offen glc slc
; GFX1030-NEXT:    v_mov_b32_e32 v1, 0
; GFX1030-NEXT:    s_waitcnt vmcnt(0)
; GFX1030-NEXT:    global_store_dword v1, v0, s[6:7]
; GFX1030-NEXT:    s_endpgm
;
; GFX1100-LABEL: raw_buffer_atomic_max_rtn_f32_off4_slc:
; GFX1100:       ; %bb.0: ; %main_body
; GFX1100-NEXT:    s_load_b256 s[0:7], s[2:3], 0x24
; GFX1100-NEXT:    s_waitcnt lgkmcnt(0)
; GFX1100-NEXT:    v_dual_mov_b32 v0, s4 :: v_dual_mov_b32 v1, s5
; GFX1100-NEXT:    buffer_atomic_max_f32 v0, v1, s[0:3], 4 offen glc slc
; GFX1100-NEXT:    v_mov_b32_e32 v1, 0
; GFX1100-NEXT:    s_waitcnt vmcnt(0)
; GFX1100-NEXT:    global_store_b32 v1, v0, s[6:7]
; GFX1100-NEXT:    s_nop 0
; GFX1100-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX1100-NEXT:    s_endpgm
;
; GFX12-LABEL: raw_buffer_atomic_max_rtn_f32_off4_slc:
; GFX12:       ; %bb.0: ; %main_body
; GFX12-NEXT:    s_load_b256 s[0:7], s[2:3], 0x24
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_dual_mov_b32 v0, s4 :: v_dual_mov_b32 v1, s5
; GFX12-NEXT:    s_mov_b32 s4, 4
; GFX12-NEXT:    buffer_atomic_max_num_f32 v0, v1, s[0:3], s4 offen th:TH_ATOMIC_NT_RETURN
; GFX12-NEXT:    v_mov_b32_e32 v1, 0
; GFX12-NEXT:    s_wait_loadcnt 0x0
; GFX12-NEXT:    global_store_b32 v1, v0, s[6:7]
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
;
; G_SI-LABEL: raw_buffer_atomic_max_rtn_f32_off4_slc:
; G_SI:       ; %bb.0: ; %main_body
; G_SI-NEXT:    s_load_dwordx8 s[0:7], s[2:3], 0x9
; G_SI-NEXT:    s_waitcnt lgkmcnt(0)
; G_SI-NEXT:    v_mov_b32_e32 v0, s4
; G_SI-NEXT:    v_mov_b32_e32 v1, s5
; G_SI-NEXT:    buffer_atomic_fmax v0, v1, s[0:3], 4 offen glc slc
; G_SI-NEXT:    s_mov_b32 s2, -1
; G_SI-NEXT:    s_mov_b32 s3, 0xf000
; G_SI-NEXT:    s_mov_b64 s[0:1], s[6:7]
; G_SI-NEXT:    s_waitcnt vmcnt(0)
; G_SI-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; G_SI-NEXT:    s_endpgm
;
; G_GFX7-LABEL: raw_buffer_atomic_max_rtn_f32_off4_slc:
; G_GFX7:       ; %bb.0: ; %main_body
; G_GFX7-NEXT:    s_load_dwordx8 s[0:7], s[2:3], 0x9
; G_GFX7-NEXT:    s_waitcnt lgkmcnt(0)
; G_GFX7-NEXT:    v_mov_b32_e32 v0, s4
; G_GFX7-NEXT:    v_mov_b32_e32 v1, s5
; G_GFX7-NEXT:    buffer_atomic_fmax v0, v1, s[0:3], 4 offen glc slc
; G_GFX7-NEXT:    s_mov_b32 s2, -1
; G_GFX7-NEXT:    s_mov_b32 s3, 0xf000
; G_GFX7-NEXT:    s_mov_b64 s[0:1], s[6:7]
; G_GFX7-NEXT:    s_waitcnt vmcnt(0)
; G_GFX7-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; G_GFX7-NEXT:    s_endpgm
;
; G_GFX10-LABEL: raw_buffer_atomic_max_rtn_f32_off4_slc:
; G_GFX10:       ; %bb.0: ; %main_body
; G_GFX10-NEXT:    s_load_dwordx8 s[4:11], s[2:3], 0x24
; G_GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; G_GFX10-NEXT:    v_mov_b32_e32 v0, s8
; G_GFX10-NEXT:    v_mov_b32_e32 v1, s9
; G_GFX10-NEXT:    buffer_atomic_fmax v0, v1, s[4:7], 4 offen glc slc
; G_GFX10-NEXT:    v_mov_b32_e32 v1, 0
; G_GFX10-NEXT:    s_waitcnt vmcnt(0)
; G_GFX10-NEXT:    global_store_dword v1, v0, s[10:11]
; G_GFX10-NEXT:    s_endpgm
;
; G_GFX1030-LABEL: raw_buffer_atomic_max_rtn_f32_off4_slc:
; G_GFX1030:       ; %bb.0: ; %main_body
; G_GFX1030-NEXT:    s_load_dwordx8 s[0:7], s[2:3], 0x24
; G_GFX1030-NEXT:    s_waitcnt lgkmcnt(0)
; G_GFX1030-NEXT:    v_mov_b32_e32 v0, s4
; G_GFX1030-NEXT:    v_mov_b32_e32 v1, s5
; G_GFX1030-NEXT:    buffer_atomic_fmax v0, v1, s[0:3], 4 offen glc slc
; G_GFX1030-NEXT:    v_mov_b32_e32 v1, 0
; G_GFX1030-NEXT:    s_waitcnt vmcnt(0)
; G_GFX1030-NEXT:    global_store_dword v1, v0, s[6:7]
; G_GFX1030-NEXT:    s_endpgm
;
; G_GFX1100-LABEL: raw_buffer_atomic_max_rtn_f32_off4_slc:
; G_GFX1100:       ; %bb.0: ; %main_body
; G_GFX1100-NEXT:    s_load_b256 s[0:7], s[2:3], 0x24
; G_GFX1100-NEXT:    s_waitcnt lgkmcnt(0)
; G_GFX1100-NEXT:    v_dual_mov_b32 v0, s4 :: v_dual_mov_b32 v1, s5
; G_GFX1100-NEXT:    buffer_atomic_max_f32 v0, v1, s[0:3], 4 offen glc slc
; G_GFX1100-NEXT:    v_mov_b32_e32 v1, 0
; G_GFX1100-NEXT:    s_waitcnt vmcnt(0)
; G_GFX1100-NEXT:    global_store_b32 v1, v0, s[6:7]
; G_GFX1100-NEXT:    s_nop 0
; G_GFX1100-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; G_GFX1100-NEXT:    s_endpgm
main_body:
  %ret = call float @llvm.amdgcn.raw.buffer.atomic.fmax.f32(float %data, <4 x i32> %rsrc, i32 %vindex, i32 4, i32 2)
  store float %ret, ptr addrspace(1) %out, align 8
  ret void
}
