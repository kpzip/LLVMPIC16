; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc -amdgpu-scalarize-global-loads=false -mtriple=amdgcn -mcpu=tahiti -verify-machineinstrs < %s | FileCheck -check-prefixes=SI %s
; RUN: llc -amdgpu-scalarize-global-loads=false -mtriple=amdgcn -mcpu=fiji -mattr=-flat-for-global -verify-machineinstrs < %s | FileCheck -check-prefixes=VI %s
; RUN: llc -amdgpu-scalarize-global-loads=false -mtriple=amdgcn -mcpu=gfx1100 -mattr=+real-true16,-flat-for-global -verify-machineinstrs < %s | FileCheck -check-prefixes=GFX11 %s
; RUN: llc -amdgpu-scalarize-global-loads=false -mtriple=amdgcn -mcpu=gfx1100 -mattr=-real-true16,-flat-for-global -verify-machineinstrs < %s | FileCheck -check-prefixes=GFX11-FAKE16 %s

declare half @llvm.floor.f16(half %a)
declare <2 x half> @llvm.floor.v2f16(<2 x half> %a)

define amdgpu_kernel void @floor_f16(
; SI-LABEL: floor_f16:
; SI:       ; %bb.0: ; %entry
; SI-NEXT:    s_load_dwordx4 s[0:3], s[2:3], 0x9
; SI-NEXT:    s_mov_b32 s7, 0xf000
; SI-NEXT:    s_mov_b32 s6, -1
; SI-NEXT:    s_mov_b32 s10, s6
; SI-NEXT:    s_mov_b32 s11, s7
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_mov_b32 s8, s2
; SI-NEXT:    s_mov_b32 s9, s3
; SI-NEXT:    buffer_load_ushort v0, off, s[8:11], 0
; SI-NEXT:    s_mov_b32 s4, s0
; SI-NEXT:    s_mov_b32 s5, s1
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    v_cvt_f32_f16_e32 v0, v0
; SI-NEXT:    v_floor_f32_e32 v0, v0
; SI-NEXT:    v_cvt_f16_f32_e32 v0, v0
; SI-NEXT:    buffer_store_short v0, off, s[4:7], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: floor_f16:
; VI:       ; %bb.0: ; %entry
; VI-NEXT:    s_load_dwordx4 s[0:3], s[2:3], 0x24
; VI-NEXT:    s_mov_b32 s7, 0xf000
; VI-NEXT:    s_mov_b32 s6, -1
; VI-NEXT:    s_mov_b32 s10, s6
; VI-NEXT:    s_mov_b32 s11, s7
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_mov_b32 s8, s2
; VI-NEXT:    s_mov_b32 s9, s3
; VI-NEXT:    buffer_load_ushort v0, off, s[8:11], 0
; VI-NEXT:    s_mov_b32 s4, s0
; VI-NEXT:    s_mov_b32 s5, s1
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_floor_f16_e32 v0, v0
; VI-NEXT:    buffer_store_short v0, off, s[4:7], 0
; VI-NEXT:    s_endpgm
;
; GFX11-LABEL: floor_f16:
; GFX11:       ; %bb.0: ; %entry
; GFX11-NEXT:    s_load_b128 s[0:3], s[2:3], 0x24
; GFX11-NEXT:    s_mov_b32 s6, -1
; GFX11-NEXT:    s_mov_b32 s7, 0x31016000
; GFX11-NEXT:    s_mov_b32 s10, s6
; GFX11-NEXT:    s_mov_b32 s11, s7
; GFX11-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-NEXT:    s_mov_b32 s8, s2
; GFX11-NEXT:    s_mov_b32 s9, s3
; GFX11-NEXT:    s_mov_b32 s4, s0
; GFX11-NEXT:    buffer_load_u16 v0, off, s[8:11], 0
; GFX11-NEXT:    s_mov_b32 s5, s1
; GFX11-NEXT:    s_waitcnt vmcnt(0)
; GFX11-NEXT:    v_floor_f16_e32 v0.l, v0.l
; GFX11-NEXT:    buffer_store_b16 v0, off, s[4:7], 0
; GFX11-NEXT:    s_nop 0
; GFX11-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX11-NEXT:    s_endpgm
;
; GFX11-FAKE16-LABEL: floor_f16:
; GFX11-FAKE16:       ; %bb.0: ; %entry
; GFX11-FAKE16-NEXT:    s_load_b128 s[0:3], s[2:3], 0x24
; GFX11-FAKE16-NEXT:    s_mov_b32 s6, -1
; GFX11-FAKE16-NEXT:    s_mov_b32 s7, 0x31016000
; GFX11-FAKE16-NEXT:    s_mov_b32 s10, s6
; GFX11-FAKE16-NEXT:    s_mov_b32 s11, s7
; GFX11-FAKE16-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-FAKE16-NEXT:    s_mov_b32 s8, s2
; GFX11-FAKE16-NEXT:    s_mov_b32 s9, s3
; GFX11-FAKE16-NEXT:    s_mov_b32 s4, s0
; GFX11-FAKE16-NEXT:    buffer_load_u16 v0, off, s[8:11], 0
; GFX11-FAKE16-NEXT:    s_mov_b32 s5, s1
; GFX11-FAKE16-NEXT:    s_waitcnt vmcnt(0)
; GFX11-FAKE16-NEXT:    v_floor_f16_e32 v0, v0
; GFX11-FAKE16-NEXT:    buffer_store_b16 v0, off, s[4:7], 0
; GFX11-FAKE16-NEXT:    s_nop 0
; GFX11-FAKE16-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX11-FAKE16-NEXT:    s_endpgm
    ptr addrspace(1) %r,
    ptr addrspace(1) %a) {
entry:
  %a.val = load half, ptr addrspace(1) %a
  %r.val = call half @llvm.floor.f16(half %a.val)
  store half %r.val, ptr addrspace(1) %r
  ret void
}

; The original test with manual checks also had these NOT directives:
; COM: SI-DAG: v_lshlrev_b32_e32 v[[R_F16_HI:[0-9]+]], 16, v[[R_F16_1]]
; COM: SI-NOT: and
; COM: SI: v_or_b32_e32 v[[R_V2_F16:[0-9]+]], v[[R_F16_0]], v[[R_F16_HI]]
; COM: VI-DAG: v_floor_f16_e32 v[[R_F16_0:[0-9]+]], v[[A_V2_F16]]
; COM: VI-DAG: v_floor_f16_sdwa v[[R_F16_1:[0-9]+]], v[[A_V2_F16]] dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:WORD_1
; COM: VI-NOT: and
; COM: VI: v_or_b32_e32 v[[R_V2_F16:[0-9]+]], v[[R_F16_0]], v[[R_F16_1]]
define amdgpu_kernel void @floor_v2f16(
; SI-LABEL: floor_v2f16:
; SI:       ; %bb.0: ; %entry
; SI-NEXT:    s_load_dwordx4 s[0:3], s[2:3], 0x9
; SI-NEXT:    s_mov_b32 s7, 0xf000
; SI-NEXT:    s_mov_b32 s6, -1
; SI-NEXT:    s_mov_b32 s10, s6
; SI-NEXT:    s_mov_b32 s11, s7
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_mov_b32 s8, s2
; SI-NEXT:    s_mov_b32 s9, s3
; SI-NEXT:    buffer_load_dword v0, off, s[8:11], 0
; SI-NEXT:    s_mov_b32 s4, s0
; SI-NEXT:    s_mov_b32 s5, s1
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    v_lshrrev_b32_e32 v1, 16, v0
; SI-NEXT:    v_cvt_f32_f16_e32 v1, v1
; SI-NEXT:    v_cvt_f32_f16_e32 v0, v0
; SI-NEXT:    v_floor_f32_e32 v1, v1
; SI-NEXT:    v_cvt_f16_f32_e32 v1, v1
; SI-NEXT:    v_floor_f32_e32 v0, v0
; SI-NEXT:    v_cvt_f16_f32_e32 v0, v0
; SI-NEXT:    v_lshlrev_b32_e32 v1, 16, v1
; SI-NEXT:    v_or_b32_e32 v0, v0, v1
; SI-NEXT:    buffer_store_dword v0, off, s[4:7], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: floor_v2f16:
; VI:       ; %bb.0: ; %entry
; VI-NEXT:    s_load_dwordx4 s[0:3], s[2:3], 0x24
; VI-NEXT:    s_mov_b32 s7, 0xf000
; VI-NEXT:    s_mov_b32 s6, -1
; VI-NEXT:    s_mov_b32 s10, s6
; VI-NEXT:    s_mov_b32 s11, s7
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_mov_b32 s8, s2
; VI-NEXT:    s_mov_b32 s9, s3
; VI-NEXT:    buffer_load_dword v0, off, s[8:11], 0
; VI-NEXT:    s_mov_b32 s4, s0
; VI-NEXT:    s_mov_b32 s5, s1
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_floor_f16_sdwa v1, v0 dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:WORD_1
; VI-NEXT:    v_floor_f16_e32 v0, v0
; VI-NEXT:    v_or_b32_e32 v0, v0, v1
; VI-NEXT:    buffer_store_dword v0, off, s[4:7], 0
; VI-NEXT:    s_endpgm
;
; GFX11-LABEL: floor_v2f16:
; GFX11:       ; %bb.0: ; %entry
; GFX11-NEXT:    s_load_b128 s[0:3], s[2:3], 0x24
; GFX11-NEXT:    s_mov_b32 s6, -1
; GFX11-NEXT:    s_mov_b32 s7, 0x31016000
; GFX11-NEXT:    s_mov_b32 s10, s6
; GFX11-NEXT:    s_mov_b32 s11, s7
; GFX11-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-NEXT:    s_mov_b32 s8, s2
; GFX11-NEXT:    s_mov_b32 s9, s3
; GFX11-NEXT:    s_mov_b32 s4, s0
; GFX11-NEXT:    buffer_load_b32 v0, off, s[8:11], 0
; GFX11-NEXT:    s_mov_b32 s5, s1
; GFX11-NEXT:    s_waitcnt vmcnt(0)
; GFX11-NEXT:    v_lshrrev_b32_e32 v1, 16, v0
; GFX11-NEXT:    v_floor_f16_e32 v0.l, v0.l
; GFX11-NEXT:    s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
; GFX11-NEXT:    v_mov_b16_e32 v0.h, v1.l
; GFX11-NEXT:    v_mov_b16_e32 v1.l, v0.l
; GFX11-NEXT:    s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
; GFX11-NEXT:    v_floor_f16_e32 v0.h, v0.h
; GFX11-NEXT:    v_mov_b16_e32 v0.l, v0.h
; GFX11-NEXT:    s_delay_alu instid0(VALU_DEP_1)
; GFX11-NEXT:    v_pack_b32_f16 v0, v1, v0
; GFX11-NEXT:    buffer_store_b32 v0, off, s[4:7], 0
; GFX11-NEXT:    s_nop 0
; GFX11-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX11-NEXT:    s_endpgm
;
; GFX11-FAKE16-LABEL: floor_v2f16:
; GFX11-FAKE16:       ; %bb.0: ; %entry
; GFX11-FAKE16-NEXT:    s_load_b128 s[0:3], s[2:3], 0x24
; GFX11-FAKE16-NEXT:    s_mov_b32 s6, -1
; GFX11-FAKE16-NEXT:    s_mov_b32 s7, 0x31016000
; GFX11-FAKE16-NEXT:    s_mov_b32 s10, s6
; GFX11-FAKE16-NEXT:    s_mov_b32 s11, s7
; GFX11-FAKE16-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-FAKE16-NEXT:    s_mov_b32 s8, s2
; GFX11-FAKE16-NEXT:    s_mov_b32 s9, s3
; GFX11-FAKE16-NEXT:    s_mov_b32 s4, s0
; GFX11-FAKE16-NEXT:    buffer_load_b32 v0, off, s[8:11], 0
; GFX11-FAKE16-NEXT:    s_mov_b32 s5, s1
; GFX11-FAKE16-NEXT:    s_waitcnt vmcnt(0)
; GFX11-FAKE16-NEXT:    v_lshrrev_b32_e32 v1, 16, v0
; GFX11-FAKE16-NEXT:    v_floor_f16_e32 v0, v0
; GFX11-FAKE16-NEXT:    s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
; GFX11-FAKE16-NEXT:    v_floor_f16_e32 v1, v1
; GFX11-FAKE16-NEXT:    v_pack_b32_f16 v0, v0, v1
; GFX11-FAKE16-NEXT:    buffer_store_b32 v0, off, s[4:7], 0
; GFX11-FAKE16-NEXT:    s_nop 0
; GFX11-FAKE16-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX11-FAKE16-NEXT:    s_endpgm
    ptr addrspace(1) %r,
    ptr addrspace(1) %a) {
entry:
  %a.val = load <2 x half>, ptr addrspace(1) %a
  %r.val = call <2 x half> @llvm.floor.v2f16(<2 x half> %a.val)
  store <2 x half> %r.val, ptr addrspace(1) %r
  ret void
}
