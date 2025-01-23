; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -global-isel -mtriple=amdgcn -mcpu=gfx90a -verify-machineinstrs < %s | FileCheck --check-prefixes=GCN %s

declare <32 x float> @llvm.amdgcn.mfma.f32.32x32x4bf16.1k(<4 x i16>, <4 x i16>, <32 x float>, i32, i32, i32)
declare <16 x float> @llvm.amdgcn.mfma.f32.16x16x4bf16.1k(<4 x i16>, <4 x i16>, <16 x float>, i32, i32, i32)
declare <4 x float> @llvm.amdgcn.mfma.f32.4x4x4bf16.1k(<4 x i16>, <4 x i16>, <4 x float>, i32, i32, i32)
declare <16 x float> @llvm.amdgcn.mfma.f32.32x32x8bf16.1k(<4 x i16>, <4 x i16>, <16 x float>, i32, i32, i32)
declare <4 x float> @llvm.amdgcn.mfma.f32.16x16x16bf16.1k(<4 x i16>, <4 x i16>, <4 x float>, i32, i32, i32)
declare <4 x double> @llvm.amdgcn.mfma.f64.16x16x4f64(double, double, <4 x double>, i32, i32, i32)
declare double @llvm.amdgcn.mfma.f64.4x4x4f64(double, double, double, i32, i32, i32)
declare i32 @llvm.amdgcn.workitem.id.x()

define amdgpu_kernel void @test_mfma_f32_32x32x4bf16_1k(ptr addrspace(1) %arg) #0 {
; GCN-LABEL: test_mfma_f32_32x32x4bf16_1k:
; GCN:       ; %bb.0: ; %bb
; GCN-NEXT:    s_load_dwordx2 s[34:35], s[2:3], 0x24
; GCN-NEXT:    s_mov_b64 s[36:37], 1
; GCN-NEXT:    v_pk_mov_b32 v[0:1], s[36:37], s[36:37] op_sel:[0,1]
; GCN-NEXT:    s_mov_b32 s36, 2
; GCN-NEXT:    v_pk_mov_b32 v[2:3], s[36:37], s[36:37] op_sel:[0,1]
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_load_dwordx16 s[0:15], s[34:35], 0x0
; GCN-NEXT:    s_load_dwordx16 s[16:31], s[34:35], 0x40
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    v_accvgpr_write_b32 a0, s0
; GCN-NEXT:    v_accvgpr_write_b32 a1, s1
; GCN-NEXT:    v_accvgpr_write_b32 a2, s2
; GCN-NEXT:    v_accvgpr_write_b32 a3, s3
; GCN-NEXT:    v_accvgpr_write_b32 a4, s4
; GCN-NEXT:    v_accvgpr_write_b32 a5, s5
; GCN-NEXT:    v_accvgpr_write_b32 a6, s6
; GCN-NEXT:    v_accvgpr_write_b32 a7, s7
; GCN-NEXT:    v_accvgpr_write_b32 a8, s8
; GCN-NEXT:    v_accvgpr_write_b32 a9, s9
; GCN-NEXT:    v_accvgpr_write_b32 a10, s10
; GCN-NEXT:    v_accvgpr_write_b32 a11, s11
; GCN-NEXT:    v_accvgpr_write_b32 a12, s12
; GCN-NEXT:    v_accvgpr_write_b32 a13, s13
; GCN-NEXT:    v_accvgpr_write_b32 a14, s14
; GCN-NEXT:    v_accvgpr_write_b32 a15, s15
; GCN-NEXT:    v_accvgpr_write_b32 a16, s16
; GCN-NEXT:    v_accvgpr_write_b32 a17, s17
; GCN-NEXT:    v_accvgpr_write_b32 a18, s18
; GCN-NEXT:    v_accvgpr_write_b32 a19, s19
; GCN-NEXT:    v_accvgpr_write_b32 a20, s20
; GCN-NEXT:    v_accvgpr_write_b32 a21, s21
; GCN-NEXT:    v_accvgpr_write_b32 a22, s22
; GCN-NEXT:    v_accvgpr_write_b32 a23, s23
; GCN-NEXT:    v_accvgpr_write_b32 a24, s24
; GCN-NEXT:    v_accvgpr_write_b32 a25, s25
; GCN-NEXT:    v_accvgpr_write_b32 a26, s26
; GCN-NEXT:    v_accvgpr_write_b32 a27, s27
; GCN-NEXT:    v_accvgpr_write_b32 a28, s28
; GCN-NEXT:    v_accvgpr_write_b32 a29, s29
; GCN-NEXT:    v_accvgpr_write_b32 a30, s30
; GCN-NEXT:    v_accvgpr_write_b32 a31, s31
; GCN-NEXT:    s_nop 1
; GCN-NEXT:    v_mfma_f32_32x32x4bf16_1k a[0:31], v[0:1], v[2:3], a[0:31] cbsz:1 abid:2 blgp:3
; GCN-NEXT:    v_mov_b32_e32 v0, 0
; GCN-NEXT:    s_nop 7
; GCN-NEXT:    s_nop 7
; GCN-NEXT:    s_nop 1
; GCN-NEXT:    global_store_dwordx4 v0, a[0:3], s[34:35]
; GCN-NEXT:    global_store_dwordx4 v0, a[4:7], s[34:35] offset:16
; GCN-NEXT:    global_store_dwordx4 v0, a[8:11], s[34:35] offset:32
; GCN-NEXT:    global_store_dwordx4 v0, a[12:15], s[34:35] offset:48
; GCN-NEXT:    global_store_dwordx4 v0, a[16:19], s[34:35] offset:64
; GCN-NEXT:    global_store_dwordx4 v0, a[20:23], s[34:35] offset:80
; GCN-NEXT:    global_store_dwordx4 v0, a[24:27], s[34:35] offset:96
; GCN-NEXT:    global_store_dwordx4 v0, a[28:31], s[34:35] offset:112
; GCN-NEXT:    s_endpgm
bb:
  %in.1 = load <32 x float>, ptr addrspace(1) %arg
  %a = bitcast i64 1 to <4 x i16>
  %b = bitcast i64 2 to <4 x i16>
  %mai.1 = tail call <32 x float> @llvm.amdgcn.mfma.f32.32x32x4bf16.1k(<4 x i16> %a, <4 x i16> %b, <32 x float> %in.1, i32 1, i32 2, i32 3)
  store <32 x float> %mai.1, ptr addrspace(1) %arg
  ret void
}

define amdgpu_kernel void @test_mfma_f32_16x16x4bf16_1k(ptr addrspace(1) %arg) #0 {
; GCN-LABEL: test_mfma_f32_16x16x4bf16_1k:
; GCN:       ; %bb.0: ; %bb
; GCN-NEXT:    s_load_dwordx2 s[16:17], s[2:3], 0x24
; GCN-NEXT:    s_mov_b64 s[18:19], 1
; GCN-NEXT:    v_pk_mov_b32 v[0:1], s[18:19], s[18:19] op_sel:[0,1]
; GCN-NEXT:    s_mov_b32 s18, 2
; GCN-NEXT:    v_pk_mov_b32 v[2:3], s[18:19], s[18:19] op_sel:[0,1]
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_load_dwordx16 s[0:15], s[16:17], 0x0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    v_accvgpr_write_b32 a0, s0
; GCN-NEXT:    v_accvgpr_write_b32 a1, s1
; GCN-NEXT:    v_accvgpr_write_b32 a2, s2
; GCN-NEXT:    v_accvgpr_write_b32 a3, s3
; GCN-NEXT:    v_accvgpr_write_b32 a4, s4
; GCN-NEXT:    v_accvgpr_write_b32 a5, s5
; GCN-NEXT:    v_accvgpr_write_b32 a6, s6
; GCN-NEXT:    v_accvgpr_write_b32 a7, s7
; GCN-NEXT:    v_accvgpr_write_b32 a8, s8
; GCN-NEXT:    v_accvgpr_write_b32 a9, s9
; GCN-NEXT:    v_accvgpr_write_b32 a10, s10
; GCN-NEXT:    v_accvgpr_write_b32 a11, s11
; GCN-NEXT:    v_accvgpr_write_b32 a12, s12
; GCN-NEXT:    v_accvgpr_write_b32 a13, s13
; GCN-NEXT:    v_accvgpr_write_b32 a14, s14
; GCN-NEXT:    v_accvgpr_write_b32 a15, s15
; GCN-NEXT:    s_nop 1
; GCN-NEXT:    v_mfma_f32_16x16x4bf16_1k a[0:15], v[0:1], v[2:3], a[0:15] cbsz:1 abid:2 blgp:3
; GCN-NEXT:    v_mov_b32_e32 v0, 0
; GCN-NEXT:    s_nop 7
; GCN-NEXT:    s_nop 1
; GCN-NEXT:    global_store_dwordx4 v0, a[0:3], s[16:17]
; GCN-NEXT:    global_store_dwordx4 v0, a[4:7], s[16:17] offset:16
; GCN-NEXT:    global_store_dwordx4 v0, a[8:11], s[16:17] offset:32
; GCN-NEXT:    global_store_dwordx4 v0, a[12:15], s[16:17] offset:48
; GCN-NEXT:    s_endpgm
bb:
  %in.1 = load <16 x float>, ptr addrspace(1) %arg
  %a = bitcast i64 1 to <4 x i16>
  %b = bitcast i64 2 to <4 x i16>
  %mai.1 = tail call <16 x float> @llvm.amdgcn.mfma.f32.16x16x4bf16.1k(<4 x i16> %a, <4 x i16> %b, <16 x float> %in.1, i32 1, i32 2, i32 3)
  store <16 x float> %mai.1, ptr addrspace(1) %arg
  ret void
}

define amdgpu_kernel void @test_mfma_f32_4x4x4bf16_1k(ptr addrspace(1) %arg) #0 {
; GCN-LABEL: test_mfma_f32_4x4x4bf16_1k:
; GCN:       ; %bb.0: ; %bb
; GCN-NEXT:    s_load_dwordx2 s[4:5], s[2:3], 0x24
; GCN-NEXT:    s_mov_b64 s[6:7], 1
; GCN-NEXT:    v_pk_mov_b32 v[0:1], s[6:7], s[6:7] op_sel:[0,1]
; GCN-NEXT:    s_mov_b32 s6, 2
; GCN-NEXT:    v_pk_mov_b32 v[2:3], s[6:7], s[6:7] op_sel:[0,1]
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_load_dwordx4 s[0:3], s[4:5], 0x0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    v_accvgpr_write_b32 a0, s0
; GCN-NEXT:    v_accvgpr_write_b32 a1, s1
; GCN-NEXT:    v_accvgpr_write_b32 a2, s2
; GCN-NEXT:    v_accvgpr_write_b32 a3, s3
; GCN-NEXT:    s_nop 1
; GCN-NEXT:    v_mfma_f32_4x4x4bf16_1k a[0:3], v[0:1], v[2:3], a[0:3] cbsz:1 abid:2 blgp:3
; GCN-NEXT:    v_mov_b32_e32 v0, 0
; GCN-NEXT:    s_nop 3
; GCN-NEXT:    global_store_dwordx4 v0, a[0:3], s[4:5]
; GCN-NEXT:    s_endpgm
bb:
  %in.1 = load <4 x float>, ptr addrspace(1) %arg
  %a = bitcast i64 1 to <4 x i16>
  %b = bitcast i64 2 to <4 x i16>
  %mai.1 = tail call <4 x float> @llvm.amdgcn.mfma.f32.4x4x4bf16.1k(<4 x i16> %a, <4 x i16> %b, <4 x float> %in.1, i32 1, i32 2, i32 3)
  store <4 x float> %mai.1, ptr addrspace(1) %arg
  ret void
}

define amdgpu_kernel void @test_mfma_f32_32x32x8bf16_1k(ptr addrspace(1) %arg) #0 {
; GCN-LABEL: test_mfma_f32_32x32x8bf16_1k:
; GCN:       ; %bb.0: ; %bb
; GCN-NEXT:    s_load_dwordx2 s[16:17], s[2:3], 0x24
; GCN-NEXT:    s_mov_b64 s[18:19], 1
; GCN-NEXT:    v_pk_mov_b32 v[0:1], s[18:19], s[18:19] op_sel:[0,1]
; GCN-NEXT:    s_mov_b32 s18, 2
; GCN-NEXT:    v_pk_mov_b32 v[2:3], s[18:19], s[18:19] op_sel:[0,1]
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_load_dwordx16 s[0:15], s[16:17], 0x0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    v_accvgpr_write_b32 a0, s0
; GCN-NEXT:    v_accvgpr_write_b32 a1, s1
; GCN-NEXT:    v_accvgpr_write_b32 a2, s2
; GCN-NEXT:    v_accvgpr_write_b32 a3, s3
; GCN-NEXT:    v_accvgpr_write_b32 a4, s4
; GCN-NEXT:    v_accvgpr_write_b32 a5, s5
; GCN-NEXT:    v_accvgpr_write_b32 a6, s6
; GCN-NEXT:    v_accvgpr_write_b32 a7, s7
; GCN-NEXT:    v_accvgpr_write_b32 a8, s8
; GCN-NEXT:    v_accvgpr_write_b32 a9, s9
; GCN-NEXT:    v_accvgpr_write_b32 a10, s10
; GCN-NEXT:    v_accvgpr_write_b32 a11, s11
; GCN-NEXT:    v_accvgpr_write_b32 a12, s12
; GCN-NEXT:    v_accvgpr_write_b32 a13, s13
; GCN-NEXT:    v_accvgpr_write_b32 a14, s14
; GCN-NEXT:    v_accvgpr_write_b32 a15, s15
; GCN-NEXT:    s_nop 1
; GCN-NEXT:    v_mfma_f32_32x32x8bf16_1k a[0:15], v[0:1], v[2:3], a[0:15] cbsz:1 abid:2 blgp:3
; GCN-NEXT:    v_mov_b32_e32 v0, 0
; GCN-NEXT:    s_nop 7
; GCN-NEXT:    s_nop 7
; GCN-NEXT:    s_nop 1
; GCN-NEXT:    global_store_dwordx4 v0, a[0:3], s[16:17]
; GCN-NEXT:    global_store_dwordx4 v0, a[4:7], s[16:17] offset:16
; GCN-NEXT:    global_store_dwordx4 v0, a[8:11], s[16:17] offset:32
; GCN-NEXT:    global_store_dwordx4 v0, a[12:15], s[16:17] offset:48
; GCN-NEXT:    s_endpgm
bb:
  %in.1 = load <16 x float>, ptr addrspace(1) %arg
  %a = bitcast i64 1 to <4 x i16>
  %b = bitcast i64 2 to <4 x i16>
  %mai.1 = tail call <16 x float> @llvm.amdgcn.mfma.f32.32x32x8bf16.1k(<4 x i16> %a, <4 x i16> %b, <16 x float> %in.1, i32 1, i32 2, i32 3)
  store <16 x float> %mai.1, ptr addrspace(1) %arg
  ret void
}

define amdgpu_kernel void @test_mfma_f32_16x16x16bf16_1k(ptr addrspace(1) %arg) #0 {
; GCN-LABEL: test_mfma_f32_16x16x16bf16_1k:
; GCN:       ; %bb.0: ; %bb
; GCN-NEXT:    s_load_dwordx2 s[4:5], s[2:3], 0x24
; GCN-NEXT:    s_mov_b64 s[6:7], 1
; GCN-NEXT:    v_pk_mov_b32 v[0:1], s[6:7], s[6:7] op_sel:[0,1]
; GCN-NEXT:    s_mov_b32 s6, 2
; GCN-NEXT:    v_pk_mov_b32 v[2:3], s[6:7], s[6:7] op_sel:[0,1]
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_load_dwordx4 s[0:3], s[4:5], 0x0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    v_accvgpr_write_b32 a0, s0
; GCN-NEXT:    v_accvgpr_write_b32 a1, s1
; GCN-NEXT:    v_accvgpr_write_b32 a2, s2
; GCN-NEXT:    v_accvgpr_write_b32 a3, s3
; GCN-NEXT:    s_nop 1
; GCN-NEXT:    v_mfma_f32_16x16x16bf16_1k a[0:3], v[0:1], v[2:3], a[0:3] cbsz:1 abid:2 blgp:3
; GCN-NEXT:    v_mov_b32_e32 v0, 0
; GCN-NEXT:    s_nop 7
; GCN-NEXT:    s_nop 1
; GCN-NEXT:    global_store_dwordx4 v0, a[0:3], s[4:5]
; GCN-NEXT:    s_endpgm
bb:
  %in.1 = load <4 x float>, ptr addrspace(1) %arg
  %a = bitcast i64 1 to <4 x i16>
  %b = bitcast i64 2 to <4 x i16>
  %mai.1 = tail call <4 x float> @llvm.amdgcn.mfma.f32.16x16x16bf16.1k(<4 x i16> %a, <4 x i16> %b, <4 x float> %in.1, i32 1, i32 2, i32 3)
  store <4 x float> %mai.1, ptr addrspace(1) %arg
  ret void
}

define amdgpu_kernel void @test_mfma_f64_4x4x4f64(ptr addrspace(1) %arg, double %a, double %b) #0 {
; GCN-LABEL: test_mfma_f64_4x4x4f64:
; GCN:       ; %bb.0: ; %bb
; GCN-NEXT:    s_load_dwordx4 s[4:7], s[2:3], 0x24
; GCN-NEXT:    s_load_dwordx2 s[0:1], s[2:3], 0x34
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    v_pk_mov_b32 v[0:1], s[6:7], s[6:7] op_sel:[0,1]
; GCN-NEXT:    v_pk_mov_b32 v[2:3], s[0:1], s[0:1] op_sel:[0,1]
; GCN-NEXT:    s_nop 1
; GCN-NEXT:    v_mfma_f64_4x4x4f64 a[0:1], v[0:1], v[2:3], 0
; GCN-NEXT:    s_nop 3
; GCN-NEXT:    v_mfma_f64_4x4x4f64 a[0:1], v[0:1], v[2:3], a[0:1] cbsz:1 abid:2 blgp:3
; GCN-NEXT:    v_mov_b32_e32 v0, 0
; GCN-NEXT:    s_nop 7
; GCN-NEXT:    global_store_dwordx2 v0, a[0:1], s[4:5]
; GCN-NEXT:    s_endpgm
bb:
  %mai.1 = tail call double @llvm.amdgcn.mfma.f64.4x4x4f64(double %a, double %b, double 0.0, i32 0, i32 0, i32 0)
  %mai.2 = tail call double @llvm.amdgcn.mfma.f64.4x4x4f64(double %a, double %b, double %mai.1, i32 1, i32 2, i32 3)
  store double %mai.2, ptr addrspace(1) %arg
  ret void
}

define amdgpu_kernel void @test_mfma_f64_16x16x4f64(ptr addrspace(1) %arg, double %a, double %b) #0 {
; GCN-LABEL: test_mfma_f64_16x16x4f64:
; GCN:       ; %bb.0: ; %bb
; GCN-NEXT:    s_load_dwordx4 s[8:11], s[2:3], 0x24
; GCN-NEXT:    s_load_dwordx2 s[12:13], s[2:3], 0x34
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    v_pk_mov_b32 v[0:1], s[10:11], s[10:11] op_sel:[0,1]
; GCN-NEXT:    s_load_dwordx8 s[0:7], s[8:9], 0x0
; GCN-NEXT:    v_pk_mov_b32 v[2:3], s[12:13], s[12:13] op_sel:[0,1]
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    v_accvgpr_write_b32 a0, s0
; GCN-NEXT:    v_accvgpr_write_b32 a1, s1
; GCN-NEXT:    v_accvgpr_write_b32 a2, s2
; GCN-NEXT:    v_accvgpr_write_b32 a3, s3
; GCN-NEXT:    v_accvgpr_write_b32 a4, s4
; GCN-NEXT:    v_accvgpr_write_b32 a5, s5
; GCN-NEXT:    v_accvgpr_write_b32 a6, s6
; GCN-NEXT:    v_accvgpr_write_b32 a7, s7
; GCN-NEXT:    s_nop 1
; GCN-NEXT:    v_mfma_f64_16x16x4f64 a[0:7], v[0:1], v[2:3], a[0:7] cbsz:1 abid:2 blgp:3
; GCN-NEXT:    v_mov_b32_e32 v0, 0
; GCN-NEXT:    s_nop 7
; GCN-NEXT:    s_nop 7
; GCN-NEXT:    s_nop 0
; GCN-NEXT:    global_store_dwordx4 v0, a[0:3], s[8:9]
; GCN-NEXT:    global_store_dwordx4 v0, a[4:7], s[8:9] offset:16
; GCN-NEXT:    s_endpgm
bb:
  %in.1 = load <4 x double>, ptr addrspace(1) %arg
  %mai.1 = tail call <4 x double> @llvm.amdgcn.mfma.f64.16x16x4f64(double %a, double %b, <4 x double> %in.1, i32 1, i32 2, i32 3)
  store <4 x double> %mai.1, ptr addrspace(1) %arg
  ret void
}

define amdgpu_kernel void @test_mfma_f64_16x16x4f64_splat_imm(ptr addrspace(1) %arg, double %a, double %b) #0 {
; GCN-LABEL: test_mfma_f64_16x16x4f64_splat_imm:
; GCN:       ; %bb.0: ; %bb
; GCN-NEXT:    s_load_dwordx4 s[4:7], s[2:3], 0x24
; GCN-NEXT:    s_load_dwordx2 s[0:1], s[2:3], 0x34
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    v_pk_mov_b32 v[0:1], s[6:7], s[6:7] op_sel:[0,1]
; GCN-NEXT:    v_pk_mov_b32 v[2:3], s[0:1], s[0:1] op_sel:[0,1]
; GCN-NEXT:    s_nop 1
; GCN-NEXT:    v_mfma_f64_16x16x4f64 a[0:7], v[0:1], v[2:3], 0
; GCN-NEXT:    v_mfma_f64_16x16x4f64 a[0:7], v[0:1], v[2:3], a[0:7] cbsz:1 abid:2 blgp:3
; GCN-NEXT:    v_mov_b32_e32 v0, 0
; GCN-NEXT:    s_nop 7
; GCN-NEXT:    s_nop 7
; GCN-NEXT:    s_nop 0
; GCN-NEXT:    global_store_dwordx4 v0, a[0:3], s[4:5]
; GCN-NEXT:    global_store_dwordx4 v0, a[4:7], s[4:5] offset:16
; GCN-NEXT:    s_endpgm
bb:
  %mai.1 = tail call <4 x double> @llvm.amdgcn.mfma.f64.16x16x4f64(double %a, double %b, <4 x double> <double 0.0, double 0.0, double 0.0, double 0.0>, i32 0, i32 0, i32 0)
  %mai.2 = tail call <4 x double> @llvm.amdgcn.mfma.f64.16x16x4f64(double %a, double %b, <4 x double> %mai.1, i32 1, i32 2, i32 3)
  store <4 x double> %mai.2, ptr addrspace(1) %arg
  ret void
}

define amdgpu_kernel void @test_mfma_f64_16x16x4f64_imm(ptr addrspace(1) %arg, double %a, double %b) #0 {
; GCN-LABEL: test_mfma_f64_16x16x4f64_imm:
; GCN:       ; %bb.0: ; %bb
; GCN-NEXT:    s_load_dwordx4 s[8:11], s[2:3], 0x24
; GCN-NEXT:    s_load_dwordx2 s[12:13], s[2:3], 0x34
; GCN-NEXT:    s_mov_b64 s[0:1], 0
; GCN-NEXT:    s_mov_b64 s[6:7], 1.0
; GCN-NEXT:    s_mov_b64 s[2:3], s[0:1]
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    v_pk_mov_b32 v[0:1], s[10:11], s[10:11] op_sel:[0,1]
; GCN-NEXT:    s_mov_b64 s[4:5], s[0:1]
; GCN-NEXT:    v_accvgpr_write_b32 a0, s0
; GCN-NEXT:    v_pk_mov_b32 v[2:3], s[12:13], s[12:13] op_sel:[0,1]
; GCN-NEXT:    v_accvgpr_write_b32 a1, s1
; GCN-NEXT:    v_accvgpr_write_b32 a2, s2
; GCN-NEXT:    v_accvgpr_write_b32 a3, s3
; GCN-NEXT:    v_accvgpr_write_b32 a4, s4
; GCN-NEXT:    v_accvgpr_write_b32 a5, s5
; GCN-NEXT:    v_accvgpr_write_b32 a6, s6
; GCN-NEXT:    v_accvgpr_write_b32 a7, s7
; GCN-NEXT:    s_nop 1
; GCN-NEXT:    v_mfma_f64_16x16x4f64 a[0:7], v[0:1], v[2:3], a[0:7]
; GCN-NEXT:    v_mov_b32_e32 v0, 0
; GCN-NEXT:    s_nop 7
; GCN-NEXT:    s_nop 7
; GCN-NEXT:    s_nop 0
; GCN-NEXT:    global_store_dwordx4 v0, a[0:3], s[8:9]
; GCN-NEXT:    global_store_dwordx4 v0, a[4:7], s[8:9] offset:16
; GCN-NEXT:    s_endpgm
bb:
  %mai.1 = tail call <4 x double> @llvm.amdgcn.mfma.f64.16x16x4f64(double %a, double %b, <4 x double> <double 0.0, double 0.0, double 0.0, double 1.0>, i32 0, i32 0, i32 0)
  store <4 x double> %mai.1, ptr addrspace(1) %arg
  ret void
}

define amdgpu_kernel void @test_mfma_f64_16x16x4f64_splat_lit(ptr addrspace(1) %arg, double %a, double %b) #0 {
; GCN-LABEL: test_mfma_f64_16x16x4f64_splat_lit:
; GCN:       ; %bb.0: ; %bb
; GCN-NEXT:    s_load_dwordx4 s[12:15], s[2:3], 0x24
; GCN-NEXT:    s_load_dwordx2 s[0:1], s[2:3], 0x34
; GCN-NEXT:    s_mov_b32 s4, 0
; GCN-NEXT:    s_mov_b32 s5, 0x405ec000
; GCN-NEXT:    s_mov_b64 s[6:7], s[4:5]
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    v_pk_mov_b32 v[0:1], s[14:15], s[14:15] op_sel:[0,1]
; GCN-NEXT:    s_mov_b64 s[8:9], s[4:5]
; GCN-NEXT:    s_mov_b64 s[10:11], s[4:5]
; GCN-NEXT:    v_accvgpr_write_b32 a0, s4
; GCN-NEXT:    v_accvgpr_write_b32 a1, s5
; GCN-NEXT:    v_accvgpr_write_b32 a2, s6
; GCN-NEXT:    v_accvgpr_write_b32 a3, s7
; GCN-NEXT:    v_accvgpr_write_b32 a4, s8
; GCN-NEXT:    v_accvgpr_write_b32 a5, s9
; GCN-NEXT:    v_accvgpr_write_b32 a6, s10
; GCN-NEXT:    v_accvgpr_write_b32 a7, s11
; GCN-NEXT:    v_pk_mov_b32 v[2:3], s[0:1], s[0:1] op_sel:[0,1]
; GCN-NEXT:    s_nop 1
; GCN-NEXT:    v_mfma_f64_16x16x4f64 a[0:7], v[0:1], v[2:3], a[0:7]
; GCN-NEXT:    v_mov_b32_e32 v0, 0
; GCN-NEXT:    s_nop 7
; GCN-NEXT:    s_nop 7
; GCN-NEXT:    s_nop 0
; GCN-NEXT:    global_store_dwordx4 v0, a[0:3], s[12:13]
; GCN-NEXT:    global_store_dwordx4 v0, a[4:7], s[12:13] offset:16
; GCN-NEXT:    s_endpgm
bb:
  %mai.1 = tail call <4 x double> @llvm.amdgcn.mfma.f64.16x16x4f64(double %a, double %b, <4 x double> <double 123.0, double 123.0, double 123.0, double 123.0>, i32 0, i32 0, i32 0)
  store <4 x double> %mai.1, ptr addrspace(1) %arg
  ret void
}

attributes #0 = { "amdgpu-flat-work-group-size"="1,256" }
