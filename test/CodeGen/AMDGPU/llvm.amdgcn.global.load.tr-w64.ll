; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -global-isel=0 -mtriple=amdgcn -mcpu=gfx1200 -verify-machineinstrs -mattr=-wavefrontsize32,+wavefrontsize64 < %s | FileCheck -check-prefix=GFX12 %s
; RUN: llc -global-isel=1 -mtriple=amdgcn -mcpu=gfx1200 -verify-machineinstrs -mattr=-wavefrontsize32,+wavefrontsize64 < %s | FileCheck -check-prefix=GFX12 %s

declare i32 @llvm.amdgcn.global.load.tr.b64.i32.p1(ptr addrspace(1))
declare <4 x i16> @llvm.amdgcn.global.load.tr.b128.v4i16.p1(ptr addrspace(1))
declare <4 x half> @llvm.amdgcn.global.load.tr.b128.v4f16.p1(ptr addrspace(1))
declare <4 x bfloat> @llvm.amdgcn.global.load.tr.b128.v4bf16.p1(ptr addrspace(1))

define amdgpu_kernel void @global_load_tr_b64_i32(ptr addrspace(1) %addr, ptr addrspace(1) %use) {
; GFX12-LABEL: global_load_tr_b64_i32:
; GFX12:       ; %bb.0: ; %entry
; GFX12-NEXT:    s_load_b128 s[0:3], s[2:3], 0x24
; GFX12-NEXT:    v_mov_b32_e32 v0, 0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    global_load_tr_b64 v1, v0, s[0:1] offset:32
; GFX12-NEXT:    s_wait_loadcnt 0x0
; GFX12-NEXT:    global_store_b32 v0, v1, s[2:3]
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
entry:
  %gep = getelementptr i64, ptr addrspace(1) %addr, i32 4
  %val = call i32 @llvm.amdgcn.global.load.tr.b64.i32.p1(ptr addrspace(1) %gep)
  store i32 %val, ptr addrspace(1) %use
  ret void
}

define amdgpu_kernel void @global_load_tr_b128_v4i16(ptr addrspace(1) %addr, ptr addrspace(1) %use) {
; GFX12-LABEL: global_load_tr_b128_v4i16:
; GFX12:       ; %bb.0: ; %entry
; GFX12-NEXT:    s_load_b128 s[0:3], s[2:3], 0x24
; GFX12-NEXT:    v_mov_b32_e32 v2, 0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    global_load_tr_b128 v[0:1], v2, s[0:1] offset:32
; GFX12-NEXT:    s_wait_loadcnt 0x0
; GFX12-NEXT:    global_store_b64 v2, v[0:1], s[2:3]
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
entry:
  %gep = getelementptr i64, ptr addrspace(1) %addr, i32 4
  %val = call <4 x i16> @llvm.amdgcn.global.load.tr.b128.v4i16.p1(ptr addrspace(1) %gep)
  store <4 x i16> %val, ptr addrspace(1) %use
  ret void
}

define amdgpu_kernel void @global_load_tr_b128_v4f16(ptr addrspace(1) %addr, ptr addrspace(1) %use) {
; GFX12-LABEL: global_load_tr_b128_v4f16:
; GFX12:       ; %bb.0: ; %entry
; GFX12-NEXT:    s_load_b128 s[0:3], s[2:3], 0x24
; GFX12-NEXT:    v_mov_b32_e32 v2, 0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    global_load_tr_b128 v[0:1], v2, s[0:1] offset:32
; GFX12-NEXT:    s_wait_loadcnt 0x0
; GFX12-NEXT:    global_store_b64 v2, v[0:1], s[2:3]
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
entry:
  %gep = getelementptr i64, ptr addrspace(1) %addr, i32 4
  %val = call <4 x half> @llvm.amdgcn.global.load.tr.b128.v4f16.p1(ptr addrspace(1) %gep)
  store <4 x half> %val, ptr addrspace(1) %use
  ret void
}

define amdgpu_kernel void @global_load_tr_b128_v4bf16(ptr addrspace(1) %addr, ptr addrspace(1) %use) {
; GFX12-LABEL: global_load_tr_b128_v4bf16:
; GFX12:       ; %bb.0: ; %entry
; GFX12-NEXT:    s_load_b128 s[0:3], s[2:3], 0x24
; GFX12-NEXT:    v_mov_b32_e32 v2, 0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    global_load_tr_b128 v[0:1], v2, s[0:1] offset:32
; GFX12-NEXT:    s_wait_loadcnt 0x0
; GFX12-NEXT:    global_store_b64 v2, v[0:1], s[2:3]
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
entry:
  %gep = getelementptr i64, ptr addrspace(1) %addr, i32 4
  %val = call <4 x bfloat> @llvm.amdgcn.global.load.tr.b128.v4bf16.p1(ptr addrspace(1) %gep)
  store <4 x bfloat> %val, ptr addrspace(1) %use
  ret void
}
