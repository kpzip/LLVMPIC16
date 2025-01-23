; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 3
; RUN: llc -mtriple=amdgcn -mcpu=gfx1100 -o - < %s | FileCheck --check-prefixes=CHECK %s

define amdgpu_gfx void @example(<4 x i32> inreg %rsrc, ptr addrspace(5) %src, i32 %dst) {
; CHECK-LABEL: example:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-NEXT:    v_add_nc_u32_e32 v3, 4, v0
; CHECK-NEXT:    s_clause 0x1
; CHECK-NEXT:    scratch_load_b32 v2, v0, off
; CHECK-NEXT:    scratch_load_b32 v3, v3, off
; CHECK-NEXT:    s_waitcnt vmcnt(0)
; CHECK-NEXT:    buffer_store_b64 v[2:3], v1, s[4:7], 0 offen
; CHECK-NEXT:    s_setpc_b64 s[30:31]

  %x0 = load i32, ptr addrspace(5) %src
  call void @llvm.amdgcn.raw.buffer.store.i32(i32 %x0, <4 x i32> %rsrc, i32 %dst, i32 0, i32 0)
  %src1 = getelementptr i8, ptr addrspace(5) %src, i32 4
  %x1 = load i32, ptr addrspace(5) %src1
  %dst1 = add i32 %dst, 4
  call void @llvm.amdgcn.raw.buffer.store.i32(i32 %x1, <4 x i32> %rsrc, i32 %dst1, i32 0, i32 0)
  ret void
}

declare void @llvm.amdgcn.raw.buffer.store.i32(i32, <4 x i32>, i32, i32, i32)
