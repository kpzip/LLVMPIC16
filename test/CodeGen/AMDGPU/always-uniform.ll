; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 3
; RUN: llc -mtriple amdgcn-amdhsa -mcpu=fiji -amdgpu-scalarize-global-loads -verify-machineinstrs < %s | FileCheck -check-prefix=GCN %s

declare i32 @llvm.amdgcn.workitem.id.x()
declare i32 @llvm.amdgcn.readfirstlane(i32)

define amdgpu_kernel void @readfirstlane_uniform(ptr addrspace(1) noalias nocapture readonly, ptr addrspace(1) noalias nocapture readonly) {
; GCN-LABEL: readfirstlane_uniform:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dwordx4 s[0:3], s[6:7], 0x0
; GCN-NEXT:    v_readfirstlane_b32 s4, v0
; GCN-NEXT:    s_mov_b32 s5, 0
; GCN-NEXT:    s_lshl_b64 s[4:5], s[4:5], 2
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_add_u32 s0, s0, s4
; GCN-NEXT:    s_addc_u32 s1, s1, s5
; GCN-NEXT:    s_load_dword s4, s[0:1], 0x0
; GCN-NEXT:    s_add_u32 s0, s2, 40
; GCN-NEXT:    s_addc_u32 s1, s3, 0
; GCN-NEXT:    v_mov_b32_e32 v0, s0
; GCN-NEXT:    v_mov_b32_e32 v1, s1
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    v_mov_b32_e32 v2, s4
; GCN-NEXT:    flat_store_dword v[0:1], v2
; GCN-NEXT:    s_endpgm
  %tid = tail call i32 @llvm.amdgcn.workitem.id.x()
  %scalar = tail call i32 @llvm.amdgcn.readfirstlane(i32 %tid)
  %idx = zext i32 %scalar to i64
  %gep0 = getelementptr inbounds float, ptr addrspace(1) %0, i64 %idx
  %val = load float, ptr addrspace(1) %gep0, align 4
  %gep1 = getelementptr inbounds float, ptr addrspace(1) %1, i64 10
  store float %val, ptr addrspace(1) %gep1, align 4
  ret void
}
