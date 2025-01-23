; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -global-isel -mtriple=amdgcn -verify-machineinstrs -o - %s | FileCheck %s

define amdgpu_cs void @test1(i32 %arg1, <4 x i32> inreg %arg2, i32, ptr addrspace(6) inreg %arg3) {
; CHECK-LABEL: test1:
; CHECK:       ; %bb.0: ; %.entry
; CHECK-NEXT:    v_and_b32_e32 v3, 0x3ffffffc, v0
; CHECK-NEXT:    v_mov_b32_e32 v0, 11
; CHECK-NEXT:    v_mov_b32_e32 v1, 22
; CHECK-NEXT:    v_mov_b32_e32 v2, 33
; CHECK-NEXT:    v_lshlrev_b32_e32 v3, 2, v3
; CHECK-NEXT:    v_add_i32_e32 v4, vcc, s4, v3
; CHECK-NEXT:    v_mov_b32_e32 v3, 44
; CHECK-NEXT:    buffer_store_dwordx4 v[0:3], v4, s[0:3], 0 offen
; CHECK-NEXT:    s_endpgm
.entry:
  %bs1 = and i32 %arg1, 1073741820
  %ep1 = getelementptr i32, ptr addrspace(6) %arg3, i32 %bs1
  %ad1 = ptrtoint ptr addrspace(6) %ep1 to i32
  call void @llvm.amdgcn.raw.buffer.store.i32(i32 11, <4 x i32> %arg2, i32 %ad1, i32 0, i32 0)

  %bs2 = or disjoint i32 %bs1, 1
  %ep2 = getelementptr i32, ptr addrspace(6) %arg3, i32 %bs2
  %ad2 = ptrtoint ptr addrspace(6) %ep2 to i32
  call void @llvm.amdgcn.raw.buffer.store.i32(i32 22, <4 x i32> %arg2, i32 %ad2, i32 0, i32 0)

  %bs3 = or disjoint i32 %bs1, 2
  %ep3 = getelementptr i32, ptr addrspace(6) %arg3, i32 %bs3
  %ad3 = ptrtoint ptr addrspace(6) %ep3 to i32
  call void @llvm.amdgcn.raw.buffer.store.i32(i32 33, <4 x i32> %arg2, i32 %ad3, i32 0, i32 0)

  %bs4 = or disjoint i32 %bs1, 3
  %ep4 = getelementptr i32, ptr addrspace(6) %arg3, i32 %bs4
  %ad4 = ptrtoint ptr addrspace(6) %ep4 to i32
  call void @llvm.amdgcn.raw.buffer.store.i32(i32 44, <4 x i32> %arg2, i32 %ad4, i32 0, i32 0)

  ret void
}

define amdgpu_cs void @test1_ptr(i32 %arg1, ptr addrspace(8) inreg %arg2, i32, ptr addrspace(6) inreg %arg3) {
; CHECK-LABEL: test1_ptr:
; CHECK:       ; %bb.0: ; %.entry
; CHECK-NEXT:    v_and_b32_e32 v3, 0x3ffffffc, v0
; CHECK-NEXT:    v_mov_b32_e32 v0, 11
; CHECK-NEXT:    v_mov_b32_e32 v1, 22
; CHECK-NEXT:    v_mov_b32_e32 v2, 33
; CHECK-NEXT:    v_lshlrev_b32_e32 v3, 2, v3
; CHECK-NEXT:    v_add_i32_e32 v4, vcc, s4, v3
; CHECK-NEXT:    v_mov_b32_e32 v3, 44
; CHECK-NEXT:    buffer_store_dwordx4 v[0:3], v4, s[0:3], 0 offen
; CHECK-NEXT:    s_endpgm
.entry:
  %bs1 = and i32 %arg1, 1073741820
  %ep1 = getelementptr i32, ptr addrspace(6) %arg3, i32 %bs1
  %ad1 = ptrtoint ptr addrspace(6) %ep1 to i32
  call void @llvm.amdgcn.raw.ptr.buffer.store.i32(i32 11, ptr addrspace(8) %arg2, i32 %ad1, i32 0, i32 0)

  %bs2 = or disjoint i32 %bs1, 1
  %ep2 = getelementptr i32, ptr addrspace(6) %arg3, i32 %bs2
  %ad2 = ptrtoint ptr addrspace(6) %ep2 to i32
  call void @llvm.amdgcn.raw.ptr.buffer.store.i32(i32 22, ptr addrspace(8) %arg2, i32 %ad2, i32 0, i32 0)

  %bs3 = or disjoint i32 %bs1, 2
  %ep3 = getelementptr i32, ptr addrspace(6) %arg3, i32 %bs3
  %ad3 = ptrtoint ptr addrspace(6) %ep3 to i32
  call void @llvm.amdgcn.raw.ptr.buffer.store.i32(i32 33, ptr addrspace(8) %arg2, i32 %ad3, i32 0, i32 0)

  %bs4 = or disjoint i32 %bs1, 3
  %ep4 = getelementptr i32, ptr addrspace(6) %arg3, i32 %bs4
  %ad4 = ptrtoint ptr addrspace(6) %ep4 to i32
  call void @llvm.amdgcn.raw.ptr.buffer.store.i32(i32 44, ptr addrspace(8) %arg2, i32 %ad4, i32 0, i32 0)

  ret void
}

define amdgpu_cs void @test2(i32 %arg1, <4 x i32> inreg %arg2) {
; CHECK-LABEL: test2:
; CHECK:       ; %bb.0: ; %.entry
; CHECK-NEXT:    v_and_b32_e32 v3, 0x3ffffffc, v0
; CHECK-NEXT:    v_mov_b32_e32 v0, 11
; CHECK-NEXT:    v_mov_b32_e32 v1, 22
; CHECK-NEXT:    v_mov_b32_e32 v2, 33
; CHECK-NEXT:    v_lshlrev_b32_e32 v4, 2, v3
; CHECK-NEXT:    v_mov_b32_e32 v3, 44
; CHECK-NEXT:    buffer_store_dwordx4 v[0:3], v4, s[0:3], 0 offen
; CHECK-NEXT:    s_endpgm
.entry:
  %bs1 = and i32 %arg1, 1073741820
  %ep1 = getelementptr <{ [64 x i32] }>, ptr addrspace(6) null, i32 0, i32 0, i32 %bs1
  %ad1 = ptrtoint ptr addrspace(6) %ep1 to i32
  call void @llvm.amdgcn.raw.buffer.store.i32(i32 11, <4 x i32> %arg2, i32 %ad1, i32 0, i32 0)

  %bs2 = or disjoint i32 %bs1, 1
  %ep2 = getelementptr <{ [64 x i32] }>, ptr addrspace(6) null, i32 0, i32 0, i32 %bs2
  %ad2 = ptrtoint ptr addrspace(6) %ep2 to i32
  call void @llvm.amdgcn.raw.buffer.store.i32(i32 22, <4 x i32> %arg2, i32 %ad2, i32 0, i32 0)

  %bs3 = or disjoint i32 %bs1, 2
  %ep3 = getelementptr <{ [64 x i32] }>, ptr addrspace(6) null, i32 0, i32 0, i32 %bs3
  %ad3 = ptrtoint ptr addrspace(6) %ep3 to i32
  call void @llvm.amdgcn.raw.buffer.store.i32(i32 33, <4 x i32> %arg2, i32 %ad3, i32 0, i32 0)

  %bs4 = or disjoint i32 %bs1, 3
  %ep4 = getelementptr <{ [64 x i32] }>, ptr addrspace(6) null, i32 0, i32 0, i32 %bs4
  %ad4 = ptrtoint ptr addrspace(6) %ep4 to i32
  call void @llvm.amdgcn.raw.buffer.store.i32(i32 44, <4 x i32> %arg2, i32 %ad4, i32 0, i32 0)

  ret void
}

define amdgpu_cs void @test2_ptr(i32 %arg1, ptr addrspace(8) inreg %arg2) {
; CHECK-LABEL: test2_ptr:
; CHECK:       ; %bb.0: ; %.entry
; CHECK-NEXT:    v_and_b32_e32 v3, 0x3ffffffc, v0
; CHECK-NEXT:    v_mov_b32_e32 v0, 11
; CHECK-NEXT:    v_mov_b32_e32 v1, 22
; CHECK-NEXT:    v_mov_b32_e32 v2, 33
; CHECK-NEXT:    v_lshlrev_b32_e32 v4, 2, v3
; CHECK-NEXT:    v_mov_b32_e32 v3, 44
; CHECK-NEXT:    buffer_store_dwordx4 v[0:3], v4, s[0:3], 0 offen
; CHECK-NEXT:    s_endpgm
.entry:
  %bs1 = and i32 %arg1, 1073741820
  %ep1 = getelementptr <{ [64 x i32] }>, ptr addrspace(6) null, i32 0, i32 0, i32 %bs1
  %ad1 = ptrtoint ptr addrspace(6) %ep1 to i32
  call void @llvm.amdgcn.raw.ptr.buffer.store.i32(i32 11, ptr addrspace(8) %arg2, i32 %ad1, i32 0, i32 0)

  %bs2 = or disjoint i32 %bs1, 1
  %ep2 = getelementptr <{ [64 x i32] }>, ptr addrspace(6) null, i32 0, i32 0, i32 %bs2
  %ad2 = ptrtoint ptr addrspace(6) %ep2 to i32
  call void @llvm.amdgcn.raw.ptr.buffer.store.i32(i32 22, ptr addrspace(8) %arg2, i32 %ad2, i32 0, i32 0)

  %bs3 = or disjoint i32 %bs1, 2
  %ep3 = getelementptr <{ [64 x i32] }>, ptr addrspace(6) null, i32 0, i32 0, i32 %bs3
  %ad3 = ptrtoint ptr addrspace(6) %ep3 to i32
  call void @llvm.amdgcn.raw.ptr.buffer.store.i32(i32 33, ptr addrspace(8) %arg2, i32 %ad3, i32 0, i32 0)

  %bs4 = or disjoint i32 %bs1, 3
  %ep4 = getelementptr <{ [64 x i32] }>, ptr addrspace(6) null, i32 0, i32 0, i32 %bs4
  %ad4 = ptrtoint ptr addrspace(6) %ep4 to i32
  call void @llvm.amdgcn.raw.ptr.buffer.store.i32(i32 44, ptr addrspace(8) %arg2, i32 %ad4, i32 0, i32 0)

  ret void
}

declare void @llvm.amdgcn.raw.buffer.store.i32(i32, <4 x i32>, i32, i32, i32 immarg)
declare void @llvm.amdgcn.raw.ptr.buffer.store.i32(i32, ptr addrspace(8), i32, i32, i32 immarg)
