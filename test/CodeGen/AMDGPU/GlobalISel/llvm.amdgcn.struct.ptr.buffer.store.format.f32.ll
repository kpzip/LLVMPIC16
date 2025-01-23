; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc -global-isel -mtriple=amdgcn-mesa-mesa3d -mcpu=tonga -stop-after=instruction-select -o - %s | FileCheck %s

define amdgpu_ps void @struct_ptr_buffer_store_format_f32__vgpr_val__sgpr_rsrc__vgpr_vindex__vgpr_voffset__sgpr_soffset(float %val, ptr addrspace(8) inreg %rsrc, i32 %vindex, i32 %voffset, i32 inreg %soffset) {
  ; CHECK-LABEL: name: struct_ptr_buffer_store_format_f32__vgpr_val__sgpr_rsrc__vgpr_vindex__vgpr_voffset__sgpr_soffset
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $vgpr0, $vgpr1, $vgpr2
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr3
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr4
  ; CHECK-NEXT:   [[COPY4:%[0-9]+]]:sreg_32 = COPY $sgpr5
  ; CHECK-NEXT:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; CHECK-NEXT:   [[COPY6:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; CHECK-NEXT:   [[COPY7:%[0-9]+]]:sreg_32 = COPY $sgpr6
  ; CHECK-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY1]], %subreg.sub0, [[COPY2]], %subreg.sub1, [[COPY3]], %subreg.sub2, [[COPY4]], %subreg.sub3
  ; CHECK-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:vreg_64 = REG_SEQUENCE [[COPY5]], %subreg.sub0, [[COPY6]], %subreg.sub1
  ; CHECK-NEXT:   BUFFER_STORE_FORMAT_X_BOTHEN_exact [[COPY]], [[REG_SEQUENCE1]], [[REG_SEQUENCE]], [[COPY7]], 0, 0, 0, implicit $exec :: (dereferenceable store (s32) into %ir.rsrc, align 1, addrspace 8)
  ; CHECK-NEXT:   S_ENDPGM 0
  call void @llvm.amdgcn.struct.ptr.buffer.store.format.f32(float %val, ptr addrspace(8) %rsrc, i32 %vindex, i32 %voffset, i32 %soffset, i32 0)
  ret void
}

define amdgpu_ps void @struct_ptr_buffer_store_format_v2f32__vgpr_val__sgpr_rsrc__vgpr_vindex__vgpr_voffset__sgpr_soffset(<2 x float> %val, ptr addrspace(8) inreg %rsrc, i32 %vindex, i32 %voffset, i32 inreg %soffset) {
  ; CHECK-LABEL: name: struct_ptr_buffer_store_format_v2f32__vgpr_val__sgpr_rsrc__vgpr_vindex__vgpr_voffset__sgpr_soffset
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $vgpr0, $vgpr1, $vgpr2, $vgpr3
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; CHECK-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:vreg_64 = REG_SEQUENCE [[COPY]], %subreg.sub0, [[COPY1]], %subreg.sub1
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr3
  ; CHECK-NEXT:   [[COPY4:%[0-9]+]]:sreg_32 = COPY $sgpr4
  ; CHECK-NEXT:   [[COPY5:%[0-9]+]]:sreg_32 = COPY $sgpr5
  ; CHECK-NEXT:   [[COPY6:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; CHECK-NEXT:   [[COPY7:%[0-9]+]]:vgpr_32 = COPY $vgpr3
  ; CHECK-NEXT:   [[COPY8:%[0-9]+]]:sreg_32 = COPY $sgpr6
  ; CHECK-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY2]], %subreg.sub0, [[COPY3]], %subreg.sub1, [[COPY4]], %subreg.sub2, [[COPY5]], %subreg.sub3
  ; CHECK-NEXT:   [[REG_SEQUENCE2:%[0-9]+]]:vreg_64 = REG_SEQUENCE [[COPY6]], %subreg.sub0, [[COPY7]], %subreg.sub1
  ; CHECK-NEXT:   BUFFER_STORE_FORMAT_XY_BOTHEN_exact [[REG_SEQUENCE]], [[REG_SEQUENCE2]], [[REG_SEQUENCE1]], [[COPY8]], 0, 0, 0, implicit $exec :: (dereferenceable store (<2 x s32>) into %ir.rsrc, align 1, addrspace 8)
  ; CHECK-NEXT:   S_ENDPGM 0
  call void @llvm.amdgcn.struct.ptr.buffer.store.format.v2f32(<2 x float> %val, ptr addrspace(8) %rsrc, i32 %vindex, i32 %voffset, i32 %soffset, i32 0)
  ret void
}

define amdgpu_ps void @struct_ptr_buffer_store_format_v3f32__vgpr_val__sgpr_rsrc__vgpr_vindex__vgpr_voffset__sgpr_soffset(<3 x float> %val, ptr addrspace(8) inreg %rsrc, i32 %vindex, i32 %voffset, i32 inreg %soffset) {
  ; CHECK-LABEL: name: struct_ptr_buffer_store_format_v3f32__vgpr_val__sgpr_rsrc__vgpr_vindex__vgpr_voffset__sgpr_soffset
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $vgpr0, $vgpr1, $vgpr2, $vgpr3, $vgpr4
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; CHECK-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:vreg_96 = REG_SEQUENCE [[COPY]], %subreg.sub0, [[COPY1]], %subreg.sub1, [[COPY2]], %subreg.sub2
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; CHECK-NEXT:   [[COPY4:%[0-9]+]]:sreg_32 = COPY $sgpr3
  ; CHECK-NEXT:   [[COPY5:%[0-9]+]]:sreg_32 = COPY $sgpr4
  ; CHECK-NEXT:   [[COPY6:%[0-9]+]]:sreg_32 = COPY $sgpr5
  ; CHECK-NEXT:   [[COPY7:%[0-9]+]]:vgpr_32 = COPY $vgpr3
  ; CHECK-NEXT:   [[COPY8:%[0-9]+]]:vgpr_32 = COPY $vgpr4
  ; CHECK-NEXT:   [[COPY9:%[0-9]+]]:sreg_32 = COPY $sgpr6
  ; CHECK-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY3]], %subreg.sub0, [[COPY4]], %subreg.sub1, [[COPY5]], %subreg.sub2, [[COPY6]], %subreg.sub3
  ; CHECK-NEXT:   [[REG_SEQUENCE2:%[0-9]+]]:vreg_64 = REG_SEQUENCE [[COPY7]], %subreg.sub0, [[COPY8]], %subreg.sub1
  ; CHECK-NEXT:   BUFFER_STORE_FORMAT_XYZ_BOTHEN_exact [[REG_SEQUENCE]], [[REG_SEQUENCE2]], [[REG_SEQUENCE1]], [[COPY9]], 0, 0, 0, implicit $exec :: (dereferenceable store (<3 x s32>) into %ir.rsrc, align 1, addrspace 8)
  ; CHECK-NEXT:   S_ENDPGM 0
  call void @llvm.amdgcn.struct.ptr.buffer.store.format.v3f32(<3 x float> %val, ptr addrspace(8) %rsrc, i32 %vindex, i32 %voffset, i32 %soffset, i32 0)
  ret void
}

define amdgpu_ps void @struct_ptr_buffer_store_format_v4f32__vgpr_val__sgpr_rsrc__vgpr_vindex__vgpr_voffset__sgpr_soffset(<4 x float> %val, ptr addrspace(8) inreg %rsrc, i32 %vindex, i32 %voffset, i32 inreg %soffset) {
  ; CHECK-LABEL: name: struct_ptr_buffer_store_format_v4f32__vgpr_val__sgpr_rsrc__vgpr_vindex__vgpr_voffset__sgpr_soffset
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $vgpr0, $vgpr1, $vgpr2, $vgpr3, $vgpr4, $vgpr5
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:vgpr_32 = COPY $vgpr3
  ; CHECK-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:vreg_128 = REG_SEQUENCE [[COPY]], %subreg.sub0, [[COPY1]], %subreg.sub1, [[COPY2]], %subreg.sub2, [[COPY3]], %subreg.sub3
  ; CHECK-NEXT:   [[COPY4:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; CHECK-NEXT:   [[COPY5:%[0-9]+]]:sreg_32 = COPY $sgpr3
  ; CHECK-NEXT:   [[COPY6:%[0-9]+]]:sreg_32 = COPY $sgpr4
  ; CHECK-NEXT:   [[COPY7:%[0-9]+]]:sreg_32 = COPY $sgpr5
  ; CHECK-NEXT:   [[COPY8:%[0-9]+]]:vgpr_32 = COPY $vgpr4
  ; CHECK-NEXT:   [[COPY9:%[0-9]+]]:vgpr_32 = COPY $vgpr5
  ; CHECK-NEXT:   [[COPY10:%[0-9]+]]:sreg_32 = COPY $sgpr6
  ; CHECK-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY4]], %subreg.sub0, [[COPY5]], %subreg.sub1, [[COPY6]], %subreg.sub2, [[COPY7]], %subreg.sub3
  ; CHECK-NEXT:   [[REG_SEQUENCE2:%[0-9]+]]:vreg_64 = REG_SEQUENCE [[COPY8]], %subreg.sub0, [[COPY9]], %subreg.sub1
  ; CHECK-NEXT:   BUFFER_STORE_FORMAT_XYZW_BOTHEN_exact [[REG_SEQUENCE]], [[REG_SEQUENCE2]], [[REG_SEQUENCE1]], [[COPY10]], 0, 0, 0, implicit $exec :: (dereferenceable store (<4 x s32>) into %ir.rsrc, align 1, addrspace 8)
  ; CHECK-NEXT:   S_ENDPGM 0
  call void @llvm.amdgcn.struct.ptr.buffer.store.format.v4f32(<4 x float> %val, ptr addrspace(8) %rsrc, i32 %vindex, i32 %voffset, i32 %soffset, i32 0)
  ret void
}

define amdgpu_ps void @struct_ptr_buffer_store_format_f32__sgpr_val__vgpr_rsrc__sgpr_vindex__sgpr_voffset__vgpr_soffset(float inreg %val, ptr addrspace(8) %rsrc, i32 inreg %vindex, i32 inreg %voffset, i32 %soffset) {
  ; CHECK-LABEL: name: struct_ptr_buffer_store_format_f32__sgpr_val__vgpr_rsrc__sgpr_vindex__sgpr_voffset__vgpr_soffset
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   successors: %bb.2(0x80000000)
  ; CHECK-NEXT:   liveins: $sgpr2, $sgpr3, $sgpr4, $vgpr0, $vgpr1, $vgpr2, $vgpr3, $vgpr4
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; CHECK-NEXT:   [[COPY4:%[0-9]+]]:vgpr_32 = COPY $vgpr3
  ; CHECK-NEXT:   [[COPY5:%[0-9]+]]:sreg_32 = COPY $sgpr3
  ; CHECK-NEXT:   [[COPY6:%[0-9]+]]:sreg_32 = COPY $sgpr4
  ; CHECK-NEXT:   [[COPY7:%[0-9]+]]:vgpr_32 = COPY $vgpr4
  ; CHECK-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:vreg_128 = REG_SEQUENCE [[COPY1]], %subreg.sub0, [[COPY2]], %subreg.sub1, [[COPY3]], %subreg.sub2, [[COPY4]], %subreg.sub3
  ; CHECK-NEXT:   [[COPY8:%[0-9]+]]:vgpr_32 = COPY [[COPY]]
  ; CHECK-NEXT:   [[COPY9:%[0-9]+]]:vgpr_32 = COPY [[COPY5]]
  ; CHECK-NEXT:   [[COPY10:%[0-9]+]]:vgpr_32 = COPY [[COPY6]]
  ; CHECK-NEXT:   [[S_MOV_B64_:%[0-9]+]]:sreg_64_xexec = S_MOV_B64 $exec
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.2:
  ; CHECK-NEXT:   successors: %bb.3(0x80000000)
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[V_READFIRSTLANE_B32_:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[COPY1]], implicit $exec
  ; CHECK-NEXT:   [[V_READFIRSTLANE_B32_1:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[COPY2]], implicit $exec
  ; CHECK-NEXT:   [[V_READFIRSTLANE_B32_2:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[COPY3]], implicit $exec
  ; CHECK-NEXT:   [[V_READFIRSTLANE_B32_3:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[COPY4]], implicit $exec
  ; CHECK-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[V_READFIRSTLANE_B32_]], %subreg.sub0, [[V_READFIRSTLANE_B32_1]], %subreg.sub1, [[V_READFIRSTLANE_B32_2]], %subreg.sub2, [[V_READFIRSTLANE_B32_3]], %subreg.sub3
  ; CHECK-NEXT:   [[COPY11:%[0-9]+]]:vreg_64 = COPY [[REG_SEQUENCE]].sub0_sub1
  ; CHECK-NEXT:   [[COPY12:%[0-9]+]]:vreg_64 = COPY [[REG_SEQUENCE]].sub2_sub3
  ; CHECK-NEXT:   [[COPY13:%[0-9]+]]:sreg_64 = COPY [[REG_SEQUENCE1]].sub0_sub1
  ; CHECK-NEXT:   [[COPY14:%[0-9]+]]:sreg_64 = COPY [[REG_SEQUENCE1]].sub2_sub3
  ; CHECK-NEXT:   [[V_CMP_EQ_U64_e64_:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U64_e64 [[COPY13]], [[COPY11]], implicit $exec
  ; CHECK-NEXT:   [[V_CMP_EQ_U64_e64_1:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U64_e64 [[COPY14]], [[COPY12]], implicit $exec
  ; CHECK-NEXT:   [[S_AND_B64_:%[0-9]+]]:sreg_64_xexec = S_AND_B64 [[V_CMP_EQ_U64_e64_]], [[V_CMP_EQ_U64_e64_1]], implicit-def dead $scc
  ; CHECK-NEXT:   [[V_READFIRSTLANE_B32_4:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[COPY7]], implicit $exec
  ; CHECK-NEXT:   [[V_CMP_EQ_U32_e64_:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U32_e64 [[V_READFIRSTLANE_B32_4]], [[COPY7]], implicit $exec
  ; CHECK-NEXT:   [[S_AND_B64_1:%[0-9]+]]:sreg_64_xexec = S_AND_B64 [[S_AND_B64_]], [[V_CMP_EQ_U32_e64_]], implicit-def dead $scc
  ; CHECK-NEXT:   [[S_AND_SAVEEXEC_B64_:%[0-9]+]]:sreg_64_xexec = S_AND_SAVEEXEC_B64 killed [[S_AND_B64_1]], implicit-def $exec, implicit-def $scc, implicit $exec
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.3:
  ; CHECK-NEXT:   successors: %bb.4(0x40000000), %bb.2(0x40000000)
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[REG_SEQUENCE2:%[0-9]+]]:vreg_64 = REG_SEQUENCE [[COPY9]], %subreg.sub0, [[COPY10]], %subreg.sub1
  ; CHECK-NEXT:   BUFFER_STORE_FORMAT_X_BOTHEN_exact [[COPY8]], [[REG_SEQUENCE2]], [[REG_SEQUENCE1]], [[V_READFIRSTLANE_B32_4]], 0, 0, 0, implicit $exec :: (dereferenceable store (s32) into %ir.rsrc, align 1, addrspace 8)
  ; CHECK-NEXT:   $exec = S_XOR_B64_term $exec, [[S_AND_SAVEEXEC_B64_]], implicit-def $scc
  ; CHECK-NEXT:   SI_WATERFALL_LOOP %bb.2, implicit $exec
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.4:
  ; CHECK-NEXT:   successors: %bb.5(0x80000000)
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   $exec = S_MOV_B64_term [[S_MOV_B64_]]
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.5:
  ; CHECK-NEXT:   S_ENDPGM 0
  call void @llvm.amdgcn.struct.ptr.buffer.store.format.f32(float %val, ptr addrspace(8) %rsrc, i32 %vindex, i32 %voffset, i32 %soffset, i32 0)
  ret void
}

define amdgpu_ps void @struct_ptr_buffer_store_format_i32__vgpr_val__sgpr_rsrc__vgpr_vindex__vgpr_voffset__sgpr_soffset(i32 %val, ptr addrspace(8) inreg %rsrc, i32 %vindex, i32 %voffset, i32 inreg %soffset) {
  ; CHECK-LABEL: name: struct_ptr_buffer_store_format_i32__vgpr_val__sgpr_rsrc__vgpr_vindex__vgpr_voffset__sgpr_soffset
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $vgpr0, $vgpr1, $vgpr2
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr3
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr4
  ; CHECK-NEXT:   [[COPY4:%[0-9]+]]:sreg_32 = COPY $sgpr5
  ; CHECK-NEXT:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; CHECK-NEXT:   [[COPY6:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; CHECK-NEXT:   [[COPY7:%[0-9]+]]:sreg_32 = COPY $sgpr6
  ; CHECK-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY1]], %subreg.sub0, [[COPY2]], %subreg.sub1, [[COPY3]], %subreg.sub2, [[COPY4]], %subreg.sub3
  ; CHECK-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:vreg_64 = REG_SEQUENCE [[COPY5]], %subreg.sub0, [[COPY6]], %subreg.sub1
  ; CHECK-NEXT:   BUFFER_STORE_FORMAT_X_BOTHEN_exact [[COPY]], [[REG_SEQUENCE1]], [[REG_SEQUENCE]], [[COPY7]], 0, 0, 0, implicit $exec :: (dereferenceable store (s32) into %ir.rsrc, align 1, addrspace 8)
  ; CHECK-NEXT:   S_ENDPGM 0
  call void @llvm.amdgcn.struct.ptr.buffer.store.format.i32(i32 %val, ptr addrspace(8) %rsrc, i32 %vindex, i32 %voffset, i32 %soffset, i32 0)
  ret void
}

declare void @llvm.amdgcn.struct.ptr.buffer.store.format.f32(float, ptr addrspace(8), i32, i32, i32, i32 immarg)
declare void @llvm.amdgcn.struct.ptr.buffer.store.format.v2f32(<2 x float>, ptr addrspace(8), i32, i32, i32, i32 immarg)
declare void @llvm.amdgcn.struct.ptr.buffer.store.format.v3f32(<3 x float>, ptr addrspace(8), i32, i32, i32, i32 immarg)
declare void @llvm.amdgcn.struct.ptr.buffer.store.format.v4f32(<4 x float>, ptr addrspace(8), i32, i32, i32, i32 immarg)
declare void @llvm.amdgcn.struct.ptr.buffer.store.format.i32(i32, ptr addrspace(8), i32, i32, i32, i32 immarg)
