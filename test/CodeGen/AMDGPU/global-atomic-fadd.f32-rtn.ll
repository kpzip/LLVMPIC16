; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc -mtriple=amdgcn -mcpu=gfx90a -verify-machineinstrs -stop-after=amdgpu-isel -amdgpu-atomic-optimizer-strategy=DPP < %s | FileCheck -check-prefixes=GFX90A_GFX940,GFX90A %s
; RUN: llc -mtriple=amdgcn -mcpu=gfx940 -verify-machineinstrs -stop-after=amdgpu-isel -amdgpu-atomic-optimizer-strategy=DPP < %s | FileCheck -check-prefixes=GFX90A_GFX940,GFX940 %s
; RUN: llc -mtriple=amdgcn -mcpu=gfx1100 -verify-machineinstrs -stop-after=amdgpu-isel -amdgpu-atomic-optimizer-strategy=DPP < %s | FileCheck -check-prefix=GFX11 %s
; RUN: llc -mtriple=amdgcn -mcpu=gfx1200 -verify-machineinstrs -stop-after=amdgpu-isel -amdgpu-atomic-optimizer-strategy=DPP < %s | FileCheck -check-prefix=GFX11 %s

define amdgpu_ps float @global_atomic_fadd_f32_rtn_intrinsic(ptr addrspace(1) %ptr, float %data) {
  ; GFX90A_GFX940-LABEL: name: global_atomic_fadd_f32_rtn_intrinsic
  ; GFX90A_GFX940: bb.0 (%ir-block.0):
  ; GFX90A_GFX940-NEXT:   liveins: $vgpr0, $vgpr1, $vgpr2
  ; GFX90A_GFX940-NEXT: {{  $}}
  ; GFX90A_GFX940-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; GFX90A_GFX940-NEXT:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; GFX90A_GFX940-NEXT:   [[COPY2:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sreg_64 = REG_SEQUENCE [[COPY2]], %subreg.sub0, [[COPY1]], %subreg.sub1
  ; GFX90A_GFX940-NEXT:   [[COPY3:%[0-9]+]]:vreg_64_align2 = COPY [[REG_SEQUENCE]]
  ; GFX90A_GFX940-NEXT:   [[GLOBAL_ATOMIC_ADD_F32_RTN:%[0-9]+]]:vgpr_32 = GLOBAL_ATOMIC_ADD_F32_RTN killed [[COPY3]], [[COPY]], 0, 1, implicit $exec :: (volatile dereferenceable load store (s32) on %ir.ptr, addrspace 1)
  ; GFX90A_GFX940-NEXT:   $vgpr0 = COPY [[GLOBAL_ATOMIC_ADD_F32_RTN]]
  ; GFX90A_GFX940-NEXT:   SI_RETURN_TO_EPILOG $vgpr0
  ;
  ; GFX11-LABEL: name: global_atomic_fadd_f32_rtn_intrinsic
  ; GFX11: bb.0 (%ir-block.0):
  ; GFX11-NEXT:   liveins: $vgpr0, $vgpr1, $vgpr2
  ; GFX11-NEXT: {{  $}}
  ; GFX11-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; GFX11-NEXT:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; GFX11-NEXT:   [[COPY2:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX11-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sreg_64 = REG_SEQUENCE [[COPY2]], %subreg.sub0, [[COPY1]], %subreg.sub1
  ; GFX11-NEXT:   [[COPY3:%[0-9]+]]:vreg_64 = COPY [[REG_SEQUENCE]]
  ; GFX11-NEXT:   [[GLOBAL_ATOMIC_ADD_F32_RTN:%[0-9]+]]:vgpr_32 = GLOBAL_ATOMIC_ADD_F32_RTN killed [[COPY3]], [[COPY]], 0, 1, implicit $exec :: (volatile dereferenceable load store (s32) on %ir.ptr, addrspace 1)
  ; GFX11-NEXT:   $vgpr0 = COPY [[GLOBAL_ATOMIC_ADD_F32_RTN]]
  ; GFX11-NEXT:   SI_RETURN_TO_EPILOG $vgpr0
  %ret = call float @llvm.amdgcn.global.atomic.fadd.f32.p1.f32(ptr addrspace(1) %ptr, float %data)
  ret float %ret
}

define amdgpu_ps float @global_atomic_fadd_f32_saddr_rtn_intrinsic(ptr addrspace(1) inreg %ptr, float %data) {
  ; GFX90A_GFX940-LABEL: name: global_atomic_fadd_f32_saddr_rtn_intrinsic
  ; GFX90A_GFX940: bb.0 (%ir-block.0):
  ; GFX90A_GFX940-NEXT:   liveins: $sgpr0, $sgpr1, $vgpr0
  ; GFX90A_GFX940-NEXT: {{  $}}
  ; GFX90A_GFX940-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX90A_GFX940-NEXT:   [[COPY1:%[0-9]+]]:sgpr_32 = COPY $sgpr1
  ; GFX90A_GFX940-NEXT:   [[COPY2:%[0-9]+]]:sgpr_32 = COPY $sgpr0
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_64 = REG_SEQUENCE [[COPY2]], %subreg.sub0, [[COPY1]], %subreg.sub1
  ; GFX90A_GFX940-NEXT:   [[V_MOV_B32_e32_:%[0-9]+]]:vgpr_32 = V_MOV_B32_e32 0, implicit $exec
  ; GFX90A_GFX940-NEXT:   [[GLOBAL_ATOMIC_ADD_F32_SADDR_RTN:%[0-9]+]]:vgpr_32 = GLOBAL_ATOMIC_ADD_F32_SADDR_RTN killed [[V_MOV_B32_e32_]], [[COPY]], killed [[REG_SEQUENCE]], 0, 1, implicit $exec :: (volatile dereferenceable load store (s32) on %ir.ptr, addrspace 1)
  ; GFX90A_GFX940-NEXT:   $vgpr0 = COPY [[GLOBAL_ATOMIC_ADD_F32_SADDR_RTN]]
  ; GFX90A_GFX940-NEXT:   SI_RETURN_TO_EPILOG $vgpr0
  ;
  ; GFX11-LABEL: name: global_atomic_fadd_f32_saddr_rtn_intrinsic
  ; GFX11: bb.0 (%ir-block.0):
  ; GFX11-NEXT:   liveins: $sgpr0, $sgpr1, $vgpr0
  ; GFX11-NEXT: {{  $}}
  ; GFX11-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX11-NEXT:   [[COPY1:%[0-9]+]]:sgpr_32 = COPY $sgpr1
  ; GFX11-NEXT:   [[COPY2:%[0-9]+]]:sgpr_32 = COPY $sgpr0
  ; GFX11-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_64 = REG_SEQUENCE [[COPY2]], %subreg.sub0, [[COPY1]], %subreg.sub1
  ; GFX11-NEXT:   [[V_MOV_B32_e32_:%[0-9]+]]:vgpr_32 = V_MOV_B32_e32 0, implicit $exec
  ; GFX11-NEXT:   [[GLOBAL_ATOMIC_ADD_F32_SADDR_RTN:%[0-9]+]]:vgpr_32 = GLOBAL_ATOMIC_ADD_F32_SADDR_RTN killed [[V_MOV_B32_e32_]], [[COPY]], killed [[REG_SEQUENCE]], 0, 1, implicit $exec :: (volatile dereferenceable load store (s32) on %ir.ptr, addrspace 1)
  ; GFX11-NEXT:   $vgpr0 = COPY [[GLOBAL_ATOMIC_ADD_F32_SADDR_RTN]]
  ; GFX11-NEXT:   SI_RETURN_TO_EPILOG $vgpr0
  %ret = call float @llvm.amdgcn.global.atomic.fadd.f32.p1.f32(ptr addrspace(1) inreg %ptr, float %data)
  ret float %ret
}

define amdgpu_ps float @global_atomic_fadd_f32_rtn_flat_intrinsic(ptr addrspace(1) %ptr, float %data) {
  ; GFX90A_GFX940-LABEL: name: global_atomic_fadd_f32_rtn_flat_intrinsic
  ; GFX90A_GFX940: bb.0 (%ir-block.0):
  ; GFX90A_GFX940-NEXT:   liveins: $vgpr0, $vgpr1, $vgpr2
  ; GFX90A_GFX940-NEXT: {{  $}}
  ; GFX90A_GFX940-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; GFX90A_GFX940-NEXT:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; GFX90A_GFX940-NEXT:   [[COPY2:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sreg_64 = REG_SEQUENCE [[COPY2]], %subreg.sub0, [[COPY1]], %subreg.sub1
  ; GFX90A_GFX940-NEXT:   [[COPY3:%[0-9]+]]:vreg_64_align2 = COPY [[REG_SEQUENCE]]
  ; GFX90A_GFX940-NEXT:   [[GLOBAL_ATOMIC_ADD_F32_RTN:%[0-9]+]]:vgpr_32 = GLOBAL_ATOMIC_ADD_F32_RTN killed [[COPY3]], [[COPY]], 0, 1, implicit $exec :: (volatile dereferenceable load store (s32) on %ir.ptr, addrspace 1)
  ; GFX90A_GFX940-NEXT:   $vgpr0 = COPY [[GLOBAL_ATOMIC_ADD_F32_RTN]]
  ; GFX90A_GFX940-NEXT:   SI_RETURN_TO_EPILOG $vgpr0
  ;
  ; GFX11-LABEL: name: global_atomic_fadd_f32_rtn_flat_intrinsic
  ; GFX11: bb.0 (%ir-block.0):
  ; GFX11-NEXT:   liveins: $vgpr0, $vgpr1, $vgpr2
  ; GFX11-NEXT: {{  $}}
  ; GFX11-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; GFX11-NEXT:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; GFX11-NEXT:   [[COPY2:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX11-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sreg_64 = REG_SEQUENCE [[COPY2]], %subreg.sub0, [[COPY1]], %subreg.sub1
  ; GFX11-NEXT:   [[COPY3:%[0-9]+]]:vreg_64 = COPY [[REG_SEQUENCE]]
  ; GFX11-NEXT:   [[GLOBAL_ATOMIC_ADD_F32_RTN:%[0-9]+]]:vgpr_32 = GLOBAL_ATOMIC_ADD_F32_RTN killed [[COPY3]], [[COPY]], 0, 1, implicit $exec :: (volatile dereferenceable load store (s32) on %ir.ptr, addrspace 1)
  ; GFX11-NEXT:   $vgpr0 = COPY [[GLOBAL_ATOMIC_ADD_F32_RTN]]
  ; GFX11-NEXT:   SI_RETURN_TO_EPILOG $vgpr0
  %ret = call float @llvm.amdgcn.flat.atomic.fadd.f32.p1.f32(ptr addrspace(1) %ptr, float %data)
  ret float %ret
}

define amdgpu_ps float @global_atomic_fadd_f32_saddr_rtn_flat_intrinsic(ptr addrspace(1) inreg %ptr, float %data) {
  ; GFX90A_GFX940-LABEL: name: global_atomic_fadd_f32_saddr_rtn_flat_intrinsic
  ; GFX90A_GFX940: bb.0 (%ir-block.0):
  ; GFX90A_GFX940-NEXT:   liveins: $sgpr0, $sgpr1, $vgpr0
  ; GFX90A_GFX940-NEXT: {{  $}}
  ; GFX90A_GFX940-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX90A_GFX940-NEXT:   [[COPY1:%[0-9]+]]:sgpr_32 = COPY $sgpr1
  ; GFX90A_GFX940-NEXT:   [[COPY2:%[0-9]+]]:sgpr_32 = COPY $sgpr0
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_64 = REG_SEQUENCE [[COPY2]], %subreg.sub0, [[COPY1]], %subreg.sub1
  ; GFX90A_GFX940-NEXT:   [[V_MOV_B32_e32_:%[0-9]+]]:vgpr_32 = V_MOV_B32_e32 0, implicit $exec
  ; GFX90A_GFX940-NEXT:   [[GLOBAL_ATOMIC_ADD_F32_SADDR_RTN:%[0-9]+]]:vgpr_32 = GLOBAL_ATOMIC_ADD_F32_SADDR_RTN killed [[V_MOV_B32_e32_]], [[COPY]], killed [[REG_SEQUENCE]], 0, 1, implicit $exec :: (volatile dereferenceable load store (s32) on %ir.ptr, addrspace 1)
  ; GFX90A_GFX940-NEXT:   $vgpr0 = COPY [[GLOBAL_ATOMIC_ADD_F32_SADDR_RTN]]
  ; GFX90A_GFX940-NEXT:   SI_RETURN_TO_EPILOG $vgpr0
  ;
  ; GFX11-LABEL: name: global_atomic_fadd_f32_saddr_rtn_flat_intrinsic
  ; GFX11: bb.0 (%ir-block.0):
  ; GFX11-NEXT:   liveins: $sgpr0, $sgpr1, $vgpr0
  ; GFX11-NEXT: {{  $}}
  ; GFX11-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX11-NEXT:   [[COPY1:%[0-9]+]]:sgpr_32 = COPY $sgpr1
  ; GFX11-NEXT:   [[COPY2:%[0-9]+]]:sgpr_32 = COPY $sgpr0
  ; GFX11-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_64 = REG_SEQUENCE [[COPY2]], %subreg.sub0, [[COPY1]], %subreg.sub1
  ; GFX11-NEXT:   [[V_MOV_B32_e32_:%[0-9]+]]:vgpr_32 = V_MOV_B32_e32 0, implicit $exec
  ; GFX11-NEXT:   [[GLOBAL_ATOMIC_ADD_F32_SADDR_RTN:%[0-9]+]]:vgpr_32 = GLOBAL_ATOMIC_ADD_F32_SADDR_RTN killed [[V_MOV_B32_e32_]], [[COPY]], killed [[REG_SEQUENCE]], 0, 1, implicit $exec :: (volatile dereferenceable load store (s32) on %ir.ptr, addrspace 1)
  ; GFX11-NEXT:   $vgpr0 = COPY [[GLOBAL_ATOMIC_ADD_F32_SADDR_RTN]]
  ; GFX11-NEXT:   SI_RETURN_TO_EPILOG $vgpr0
  %ret = call float @llvm.amdgcn.flat.atomic.fadd.f32.p1.f32(ptr addrspace(1) inreg %ptr, float %data)
  ret float %ret
}

define amdgpu_ps float @global_atomic_fadd_f32_rtn_atomicrmw(ptr addrspace(1) %ptr, float %data) #0 {
  ; GFX90A_GFX940-LABEL: name: global_atomic_fadd_f32_rtn_atomicrmw
  ; GFX90A_GFX940: bb.0 (%ir-block.0):
  ; GFX90A_GFX940-NEXT:   liveins: $vgpr0, $vgpr1, $vgpr2
  ; GFX90A_GFX940-NEXT: {{  $}}
  ; GFX90A_GFX940-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; GFX90A_GFX940-NEXT:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; GFX90A_GFX940-NEXT:   [[COPY2:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sreg_64 = REG_SEQUENCE [[COPY2]], %subreg.sub0, [[COPY1]], %subreg.sub1
  ; GFX90A_GFX940-NEXT:   [[COPY3:%[0-9]+]]:vreg_64_align2 = COPY [[REG_SEQUENCE]]
  ; GFX90A_GFX940-NEXT:   [[GLOBAL_ATOMIC_ADD_F32_RTN:%[0-9]+]]:vgpr_32 = GLOBAL_ATOMIC_ADD_F32_RTN killed [[COPY3]], [[COPY]], 0, 1, implicit $exec :: (load store syncscope("wavefront") monotonic (s32) on %ir.ptr, addrspace 1)
  ; GFX90A_GFX940-NEXT:   $vgpr0 = COPY [[GLOBAL_ATOMIC_ADD_F32_RTN]]
  ; GFX90A_GFX940-NEXT:   SI_RETURN_TO_EPILOG $vgpr0
  ;
  ; GFX11-LABEL: name: global_atomic_fadd_f32_rtn_atomicrmw
  ; GFX11: bb.0 (%ir-block.0):
  ; GFX11-NEXT:   liveins: $vgpr0, $vgpr1, $vgpr2
  ; GFX11-NEXT: {{  $}}
  ; GFX11-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; GFX11-NEXT:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; GFX11-NEXT:   [[COPY2:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX11-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sreg_64 = REG_SEQUENCE [[COPY2]], %subreg.sub0, [[COPY1]], %subreg.sub1
  ; GFX11-NEXT:   [[COPY3:%[0-9]+]]:vreg_64 = COPY [[REG_SEQUENCE]]
  ; GFX11-NEXT:   [[GLOBAL_ATOMIC_ADD_F32_RTN:%[0-9]+]]:vgpr_32 = GLOBAL_ATOMIC_ADD_F32_RTN killed [[COPY3]], [[COPY]], 0, 1, implicit $exec :: (load store syncscope("wavefront") monotonic (s32) on %ir.ptr, addrspace 1)
  ; GFX11-NEXT:   $vgpr0 = COPY [[GLOBAL_ATOMIC_ADD_F32_RTN]]
  ; GFX11-NEXT:   SI_RETURN_TO_EPILOG $vgpr0
  %ret = atomicrmw fadd ptr addrspace(1) %ptr, float %data syncscope("wavefront") monotonic
  ret float %ret
}

define amdgpu_ps float @global_atomic_fadd_f32_saddr_rtn_atomicrmw(ptr addrspace(1) inreg %ptr, float %data) #0 {
  ; GFX90A-LABEL: name: global_atomic_fadd_f32_saddr_rtn_atomicrmw
  ; GFX90A: bb.0 (%ir-block.0):
  ; GFX90A-NEXT:   successors: %bb.1(0x40000000), %bb.3(0x40000000)
  ; GFX90A-NEXT:   liveins: $sgpr0, $sgpr1, $vgpr0
  ; GFX90A-NEXT: {{  $}}
  ; GFX90A-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX90A-NEXT:   [[COPY1:%[0-9]+]]:sgpr_32 = COPY $sgpr1
  ; GFX90A-NEXT:   [[COPY2:%[0-9]+]]:sgpr_32 = COPY $sgpr0
  ; GFX90A-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_64 = REG_SEQUENCE [[COPY2]], %subreg.sub0, [[COPY1]], %subreg.sub1
  ; GFX90A-NEXT:   [[COPY3:%[0-9]+]]:sreg_64 = COPY [[REG_SEQUENCE]]
  ; GFX90A-NEXT:   [[SI_PS_LIVE:%[0-9]+]]:sreg_64 = SI_PS_LIVE
  ; GFX90A-NEXT:   [[DEF:%[0-9]+]]:sgpr_32 = IMPLICIT_DEF
  ; GFX90A-NEXT:   [[SI_IF:%[0-9]+]]:sreg_64 = SI_IF killed [[SI_PS_LIVE]], %bb.3, implicit-def dead $exec, implicit-def dead $scc, implicit $exec
  ; GFX90A-NEXT:   S_BRANCH %bb.1
  ; GFX90A-NEXT: {{  $}}
  ; GFX90A-NEXT: bb.1 (%ir-block.5):
  ; GFX90A-NEXT:   successors: %bb.2(0x40000000), %bb.4(0x40000000)
  ; GFX90A-NEXT: {{  $}}
  ; GFX90A-NEXT:   [[COPY4:%[0-9]+]]:sreg_64 = COPY $exec
  ; GFX90A-NEXT:   [[COPY5:%[0-9]+]]:sreg_32 = COPY [[COPY4]].sub1
  ; GFX90A-NEXT:   [[COPY6:%[0-9]+]]:sreg_32 = COPY [[COPY4]].sub0
  ; GFX90A-NEXT:   [[S_MOV_B32_:%[0-9]+]]:sreg_32 = S_MOV_B32 0
  ; GFX90A-NEXT:   [[COPY7:%[0-9]+]]:vgpr_32 = COPY [[S_MOV_B32_]]
  ; GFX90A-NEXT:   [[V_MBCNT_LO_U32_B32_e64_:%[0-9]+]]:vgpr_32 = V_MBCNT_LO_U32_B32_e64 killed [[COPY6]], [[COPY7]], implicit $exec
  ; GFX90A-NEXT:   [[V_MBCNT_HI_U32_B32_e64_:%[0-9]+]]:vgpr_32 = V_MBCNT_HI_U32_B32_e64 killed [[COPY5]], killed [[V_MBCNT_LO_U32_B32_e64_]], implicit $exec
  ; GFX90A-NEXT:   [[V_MOV_B32_e32_:%[0-9]+]]:vgpr_32 = V_MOV_B32_e32 -2147483648, implicit $exec
  ; GFX90A-NEXT:   [[V_SET_INACTIVE_B32_:%[0-9]+]]:vgpr_32 = V_SET_INACTIVE_B32 [[COPY]], [[V_MOV_B32_e32_]], implicit-def dead $scc, implicit $exec
  ; GFX90A-NEXT:   [[V_MOV_B32_dpp:%[0-9]+]]:vgpr_32 = V_MOV_B32_dpp [[V_MOV_B32_e32_]], [[V_SET_INACTIVE_B32_]], 273, 15, 15, 0, implicit $exec
  ; GFX90A-NEXT:   [[V_ADD_F32_e64_:%[0-9]+]]:vgpr_32 = nofpexcept V_ADD_F32_e64 0, [[V_SET_INACTIVE_B32_]], 0, killed [[V_MOV_B32_dpp]], 0, 0, implicit $mode, implicit $exec
  ; GFX90A-NEXT:   [[V_MOV_B32_dpp1:%[0-9]+]]:vgpr_32 = V_MOV_B32_dpp [[V_MOV_B32_e32_]], [[V_ADD_F32_e64_]], 274, 15, 15, 0, implicit $exec
  ; GFX90A-NEXT:   [[V_ADD_F32_e64_1:%[0-9]+]]:vgpr_32 = nofpexcept V_ADD_F32_e64 0, [[V_ADD_F32_e64_]], 0, killed [[V_MOV_B32_dpp1]], 0, 0, implicit $mode, implicit $exec
  ; GFX90A-NEXT:   [[V_MOV_B32_dpp2:%[0-9]+]]:vgpr_32 = V_MOV_B32_dpp [[V_MOV_B32_e32_]], [[V_ADD_F32_e64_1]], 276, 15, 15, 0, implicit $exec
  ; GFX90A-NEXT:   [[V_ADD_F32_e64_2:%[0-9]+]]:vgpr_32 = nofpexcept V_ADD_F32_e64 0, [[V_ADD_F32_e64_1]], 0, killed [[V_MOV_B32_dpp2]], 0, 0, implicit $mode, implicit $exec
  ; GFX90A-NEXT:   [[V_MOV_B32_dpp3:%[0-9]+]]:vgpr_32 = V_MOV_B32_dpp [[V_MOV_B32_e32_]], [[V_ADD_F32_e64_2]], 280, 15, 15, 0, implicit $exec
  ; GFX90A-NEXT:   [[V_ADD_F32_e64_3:%[0-9]+]]:vgpr_32 = nofpexcept V_ADD_F32_e64 0, [[V_ADD_F32_e64_2]], 0, killed [[V_MOV_B32_dpp3]], 0, 0, implicit $mode, implicit $exec
  ; GFX90A-NEXT:   [[V_MOV_B32_dpp4:%[0-9]+]]:vgpr_32 = V_MOV_B32_dpp [[V_MOV_B32_e32_]], [[V_ADD_F32_e64_3]], 322, 10, 15, 0, implicit $exec
  ; GFX90A-NEXT:   [[V_ADD_F32_e64_4:%[0-9]+]]:vgpr_32 = nofpexcept V_ADD_F32_e64 0, [[V_ADD_F32_e64_3]], 0, killed [[V_MOV_B32_dpp4]], 0, 0, implicit $mode, implicit $exec
  ; GFX90A-NEXT:   [[V_MOV_B32_dpp5:%[0-9]+]]:vgpr_32 = V_MOV_B32_dpp [[V_MOV_B32_e32_]], [[V_ADD_F32_e64_4]], 323, 12, 15, 0, implicit $exec
  ; GFX90A-NEXT:   [[V_ADD_F32_e64_5:%[0-9]+]]:vgpr_32 = nofpexcept V_ADD_F32_e64 0, [[V_ADD_F32_e64_4]], 0, killed [[V_MOV_B32_dpp5]], 0, 0, implicit $mode, implicit $exec
  ; GFX90A-NEXT:   [[V_MOV_B32_dpp6:%[0-9]+]]:vgpr_32 = V_MOV_B32_dpp [[V_MOV_B32_e32_]], [[V_ADD_F32_e64_5]], 312, 15, 15, 0, implicit $exec
  ; GFX90A-NEXT:   [[S_MOV_B32_1:%[0-9]+]]:sreg_32 = S_MOV_B32 63
  ; GFX90A-NEXT:   [[V_READLANE_B32_:%[0-9]+]]:sreg_32 = V_READLANE_B32 [[V_ADD_F32_e64_5]], killed [[S_MOV_B32_1]]
  ; GFX90A-NEXT:   early-clobber %2:sgpr_32 = STRICT_WWM killed [[V_READLANE_B32_]], implicit $exec
  ; GFX90A-NEXT:   [[V_CMP_EQ_U32_e64_:%[0-9]+]]:sreg_64 = V_CMP_EQ_U32_e64 killed [[V_MBCNT_HI_U32_B32_e64_]], [[S_MOV_B32_]], implicit $exec
  ; GFX90A-NEXT:   [[COPY8:%[0-9]+]]:vreg_1 = COPY [[V_CMP_EQ_U32_e64_]]
  ; GFX90A-NEXT:   [[DEF1:%[0-9]+]]:sgpr_32 = IMPLICIT_DEF
  ; GFX90A-NEXT:   [[SI_IF1:%[0-9]+]]:sreg_64 = SI_IF [[V_CMP_EQ_U32_e64_]], %bb.4, implicit-def dead $exec, implicit-def dead $scc, implicit $exec
  ; GFX90A-NEXT:   S_BRANCH %bb.2
  ; GFX90A-NEXT: {{  $}}
  ; GFX90A-NEXT: bb.2 (%ir-block.32):
  ; GFX90A-NEXT:   successors: %bb.4(0x80000000)
  ; GFX90A-NEXT: {{  $}}
  ; GFX90A-NEXT:   [[V_MOV_B32_e32_1:%[0-9]+]]:vgpr_32 = V_MOV_B32_e32 0, implicit $exec
  ; GFX90A-NEXT:   [[COPY9:%[0-9]+]]:vgpr_32 = COPY %2
  ; GFX90A-NEXT:   [[GLOBAL_ATOMIC_ADD_F32_SADDR_RTN:%[0-9]+]]:vgpr_32 = GLOBAL_ATOMIC_ADD_F32_SADDR_RTN killed [[V_MOV_B32_e32_1]], [[COPY9]], [[COPY3]], 0, 1, implicit $exec :: (load store syncscope("wavefront") monotonic (s32) on %ir.ptr, addrspace 1)
  ; GFX90A-NEXT:   S_BRANCH %bb.4
  ; GFX90A-NEXT: {{  $}}
  ; GFX90A-NEXT: bb.3.Flow:
  ; GFX90A-NEXT:   successors: %bb.5(0x80000000)
  ; GFX90A-NEXT: {{  $}}
  ; GFX90A-NEXT:   [[PHI:%[0-9]+]]:vgpr_32 = PHI [[DEF]], %bb.0, %8, %bb.4
  ; GFX90A-NEXT:   SI_END_CF [[SI_IF]], implicit-def dead $exec, implicit-def dead $scc, implicit $exec
  ; GFX90A-NEXT:   S_BRANCH %bb.5
  ; GFX90A-NEXT: {{  $}}
  ; GFX90A-NEXT: bb.4 (%ir-block.35):
  ; GFX90A-NEXT:   successors: %bb.3(0x80000000)
  ; GFX90A-NEXT: {{  $}}
  ; GFX90A-NEXT:   [[PHI1:%[0-9]+]]:vgpr_32 = PHI [[DEF1]], %bb.1, [[GLOBAL_ATOMIC_ADD_F32_SADDR_RTN]], %bb.2
  ; GFX90A-NEXT:   SI_END_CF [[SI_IF1]], implicit-def dead $exec, implicit-def dead $scc, implicit $exec
  ; GFX90A-NEXT:   [[V_READFIRSTLANE_B32_:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[PHI1]], implicit $exec
  ; GFX90A-NEXT:   early-clobber %45:vgpr_32 = STRICT_WWM [[V_MOV_B32_dpp6]], implicit $exec
  ; GFX90A-NEXT:   [[V_ADD_F32_e64_6:%[0-9]+]]:vgpr_32 = nofpexcept V_ADD_F32_e64 0, [[V_READFIRSTLANE_B32_]], 0, killed %45, 0, 0, implicit $mode, implicit $exec
  ; GFX90A-NEXT:   [[COPY10:%[0-9]+]]:sreg_64_xexec = COPY [[COPY8]]
  ; GFX90A-NEXT:   [[COPY11:%[0-9]+]]:vgpr_32 = COPY [[V_READFIRSTLANE_B32_]]
  ; GFX90A-NEXT:   [[V_CNDMASK_B32_e64_:%[0-9]+]]:vgpr_32 = V_CNDMASK_B32_e64 0, killed [[V_ADD_F32_e64_6]], 0, [[COPY11]], [[COPY10]], implicit $exec
  ; GFX90A-NEXT:   S_BRANCH %bb.3
  ; GFX90A-NEXT: {{  $}}
  ; GFX90A-NEXT: bb.5 (%ir-block.41):
  ; GFX90A-NEXT:   $vgpr0 = COPY [[PHI]]
  ; GFX90A-NEXT:   SI_RETURN_TO_EPILOG $vgpr0
  ;
  ; GFX940-LABEL: name: global_atomic_fadd_f32_saddr_rtn_atomicrmw
  ; GFX940: bb.0 (%ir-block.0):
  ; GFX940-NEXT:   successors: %bb.1(0x40000000), %bb.3(0x40000000)
  ; GFX940-NEXT:   liveins: $sgpr0, $sgpr1, $vgpr0
  ; GFX940-NEXT: {{  $}}
  ; GFX940-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX940-NEXT:   [[COPY1:%[0-9]+]]:sgpr_32 = COPY $sgpr1
  ; GFX940-NEXT:   [[COPY2:%[0-9]+]]:sgpr_32 = COPY $sgpr0
  ; GFX940-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_64 = REG_SEQUENCE [[COPY2]], %subreg.sub0, [[COPY1]], %subreg.sub1
  ; GFX940-NEXT:   [[COPY3:%[0-9]+]]:sreg_64 = COPY [[REG_SEQUENCE]]
  ; GFX940-NEXT:   [[SI_PS_LIVE:%[0-9]+]]:sreg_64 = SI_PS_LIVE
  ; GFX940-NEXT:   [[DEF:%[0-9]+]]:sgpr_32 = IMPLICIT_DEF
  ; GFX940-NEXT:   [[SI_IF:%[0-9]+]]:sreg_64 = SI_IF killed [[SI_PS_LIVE]], %bb.3, implicit-def dead $exec, implicit-def dead $scc, implicit $exec
  ; GFX940-NEXT:   S_BRANCH %bb.1
  ; GFX940-NEXT: {{  $}}
  ; GFX940-NEXT: bb.1 (%ir-block.5):
  ; GFX940-NEXT:   successors: %bb.2(0x40000000), %bb.4(0x40000000)
  ; GFX940-NEXT: {{  $}}
  ; GFX940-NEXT:   [[COPY4:%[0-9]+]]:sreg_64 = COPY $exec
  ; GFX940-NEXT:   [[COPY5:%[0-9]+]]:sreg_32 = COPY [[COPY4]].sub1
  ; GFX940-NEXT:   [[COPY6:%[0-9]+]]:sreg_32 = COPY [[COPY4]].sub0
  ; GFX940-NEXT:   [[S_MOV_B32_:%[0-9]+]]:sreg_32 = S_MOV_B32 0
  ; GFX940-NEXT:   [[COPY7:%[0-9]+]]:vgpr_32 = COPY [[S_MOV_B32_]]
  ; GFX940-NEXT:   [[V_MBCNT_LO_U32_B32_e64_:%[0-9]+]]:vgpr_32 = V_MBCNT_LO_U32_B32_e64 killed [[COPY6]], [[COPY7]], implicit $exec
  ; GFX940-NEXT:   [[V_MBCNT_HI_U32_B32_e64_:%[0-9]+]]:vgpr_32 = V_MBCNT_HI_U32_B32_e64 killed [[COPY5]], killed [[V_MBCNT_LO_U32_B32_e64_]], implicit $exec
  ; GFX940-NEXT:   [[V_MOV_B32_e32_:%[0-9]+]]:vgpr_32 = V_MOV_B32_e32 -2147483648, implicit $exec
  ; GFX940-NEXT:   [[V_SET_INACTIVE_B32_:%[0-9]+]]:vgpr_32 = V_SET_INACTIVE_B32 [[COPY]], [[V_MOV_B32_e32_]], implicit-def dead $scc, implicit $exec
  ; GFX940-NEXT:   [[V_MOV_B32_dpp:%[0-9]+]]:vgpr_32 = V_MOV_B32_dpp [[V_MOV_B32_e32_]], [[V_SET_INACTIVE_B32_]], 273, 15, 15, 0, implicit $exec
  ; GFX940-NEXT:   [[V_ADD_F32_e64_:%[0-9]+]]:vgpr_32 = nofpexcept V_ADD_F32_e64 0, [[V_SET_INACTIVE_B32_]], 0, killed [[V_MOV_B32_dpp]], 0, 0, implicit $mode, implicit $exec
  ; GFX940-NEXT:   [[V_MOV_B32_dpp1:%[0-9]+]]:vgpr_32 = V_MOV_B32_dpp [[V_MOV_B32_e32_]], [[V_ADD_F32_e64_]], 274, 15, 15, 0, implicit $exec
  ; GFX940-NEXT:   [[V_ADD_F32_e64_1:%[0-9]+]]:vgpr_32 = nofpexcept V_ADD_F32_e64 0, [[V_ADD_F32_e64_]], 0, killed [[V_MOV_B32_dpp1]], 0, 0, implicit $mode, implicit $exec
  ; GFX940-NEXT:   [[V_MOV_B32_dpp2:%[0-9]+]]:vgpr_32 = V_MOV_B32_dpp [[V_MOV_B32_e32_]], [[V_ADD_F32_e64_1]], 276, 15, 15, 0, implicit $exec
  ; GFX940-NEXT:   [[V_ADD_F32_e64_2:%[0-9]+]]:vgpr_32 = nofpexcept V_ADD_F32_e64 0, [[V_ADD_F32_e64_1]], 0, killed [[V_MOV_B32_dpp2]], 0, 0, implicit $mode, implicit $exec
  ; GFX940-NEXT:   [[V_MOV_B32_dpp3:%[0-9]+]]:vgpr_32 = V_MOV_B32_dpp [[V_MOV_B32_e32_]], [[V_ADD_F32_e64_2]], 280, 15, 15, 0, implicit $exec
  ; GFX940-NEXT:   [[V_ADD_F32_e64_3:%[0-9]+]]:vgpr_32 = nofpexcept V_ADD_F32_e64 0, [[V_ADD_F32_e64_2]], 0, killed [[V_MOV_B32_dpp3]], 0, 0, implicit $mode, implicit $exec
  ; GFX940-NEXT:   [[V_MOV_B32_dpp4:%[0-9]+]]:vgpr_32 = V_MOV_B32_dpp [[V_MOV_B32_e32_]], [[V_ADD_F32_e64_3]], 322, 10, 15, 0, implicit $exec
  ; GFX940-NEXT:   [[V_ADD_F32_e64_4:%[0-9]+]]:vgpr_32 = nofpexcept V_ADD_F32_e64 0, [[V_ADD_F32_e64_3]], 0, killed [[V_MOV_B32_dpp4]], 0, 0, implicit $mode, implicit $exec
  ; GFX940-NEXT:   [[V_MOV_B32_dpp5:%[0-9]+]]:vgpr_32 = V_MOV_B32_dpp [[V_MOV_B32_e32_]], [[V_ADD_F32_e64_4]], 323, 12, 15, 0, implicit $exec
  ; GFX940-NEXT:   [[V_ADD_F32_e64_5:%[0-9]+]]:vgpr_32 = nofpexcept V_ADD_F32_e64 0, [[V_ADD_F32_e64_4]], 0, killed [[V_MOV_B32_dpp5]], 0, 0, implicit $mode, implicit $exec
  ; GFX940-NEXT:   [[V_MOV_B32_dpp6:%[0-9]+]]:vgpr_32 = V_MOV_B32_dpp [[V_MOV_B32_e32_]], [[V_ADD_F32_e64_5]], 312, 15, 15, 0, implicit $exec
  ; GFX940-NEXT:   [[S_MOV_B32_1:%[0-9]+]]:sreg_32 = S_MOV_B32 63
  ; GFX940-NEXT:   [[V_READLANE_B32_:%[0-9]+]]:sreg_32 = V_READLANE_B32 [[V_ADD_F32_e64_5]], killed [[S_MOV_B32_1]]
  ; GFX940-NEXT:   early-clobber %2:sgpr_32 = STRICT_WWM killed [[V_READLANE_B32_]], implicit $exec
  ; GFX940-NEXT:   [[V_CMP_EQ_U32_e64_:%[0-9]+]]:sreg_64 = V_CMP_EQ_U32_e64 killed [[V_MBCNT_HI_U32_B32_e64_]], [[S_MOV_B32_]], implicit $exec
  ; GFX940-NEXT:   [[COPY8:%[0-9]+]]:vreg_1 = COPY [[V_CMP_EQ_U32_e64_]]
  ; GFX940-NEXT:   [[DEF1:%[0-9]+]]:sgpr_32 = IMPLICIT_DEF
  ; GFX940-NEXT:   [[SI_IF1:%[0-9]+]]:sreg_64 = SI_IF [[V_CMP_EQ_U32_e64_]], %bb.4, implicit-def dead $exec, implicit-def dead $scc, implicit $exec
  ; GFX940-NEXT:   S_BRANCH %bb.2
  ; GFX940-NEXT: {{  $}}
  ; GFX940-NEXT: bb.2 (%ir-block.32):
  ; GFX940-NEXT:   successors: %bb.4(0x80000000)
  ; GFX940-NEXT: {{  $}}
  ; GFX940-NEXT:   [[V_MOV_B32_e32_1:%[0-9]+]]:vgpr_32 = V_MOV_B32_e32 0, implicit $exec
  ; GFX940-NEXT:   [[COPY9:%[0-9]+]]:vgpr_32 = COPY %2
  ; GFX940-NEXT:   [[GLOBAL_ATOMIC_ADD_F32_SADDR_RTN:%[0-9]+]]:vgpr_32 = GLOBAL_ATOMIC_ADD_F32_SADDR_RTN killed [[V_MOV_B32_e32_1]], [[COPY9]], [[COPY3]], 0, 1, implicit $exec :: (load store syncscope("wavefront") monotonic (s32) on %ir.ptr, addrspace 1)
  ; GFX940-NEXT:   S_BRANCH %bb.4
  ; GFX940-NEXT: {{  $}}
  ; GFX940-NEXT: bb.3.Flow:
  ; GFX940-NEXT:   successors: %bb.5(0x80000000)
  ; GFX940-NEXT: {{  $}}
  ; GFX940-NEXT:   [[PHI:%[0-9]+]]:vgpr_32 = PHI [[DEF]], %bb.0, %8, %bb.4
  ; GFX940-NEXT:   SI_END_CF [[SI_IF]], implicit-def dead $exec, implicit-def dead $scc, implicit $exec
  ; GFX940-NEXT:   S_BRANCH %bb.5
  ; GFX940-NEXT: {{  $}}
  ; GFX940-NEXT: bb.4 (%ir-block.35):
  ; GFX940-NEXT:   successors: %bb.3(0x80000000)
  ; GFX940-NEXT: {{  $}}
  ; GFX940-NEXT:   [[PHI1:%[0-9]+]]:vgpr_32 = PHI [[DEF1]], %bb.1, [[GLOBAL_ATOMIC_ADD_F32_SADDR_RTN]], %bb.2
  ; GFX940-NEXT:   SI_END_CF [[SI_IF1]], implicit-def dead $exec, implicit-def dead $scc, implicit $exec
  ; GFX940-NEXT:   [[V_READFIRSTLANE_B32_:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[PHI1]], implicit $exec
  ; GFX940-NEXT:   early-clobber %44:vgpr_32 = STRICT_WWM [[V_MOV_B32_dpp6]], implicit $exec
  ; GFX940-NEXT:   [[V_ADD_F32_e64_6:%[0-9]+]]:vgpr_32 = nofpexcept V_ADD_F32_e64 0, [[V_READFIRSTLANE_B32_]], 0, killed %44, 0, 0, implicit $mode, implicit $exec
  ; GFX940-NEXT:   [[COPY10:%[0-9]+]]:sreg_64_xexec = COPY [[COPY8]]
  ; GFX940-NEXT:   [[COPY11:%[0-9]+]]:vgpr_32 = COPY [[V_READFIRSTLANE_B32_]]
  ; GFX940-NEXT:   [[V_CNDMASK_B32_e64_:%[0-9]+]]:vgpr_32 = V_CNDMASK_B32_e64 0, killed [[V_ADD_F32_e64_6]], 0, [[COPY11]], [[COPY10]], implicit $exec
  ; GFX940-NEXT:   S_BRANCH %bb.3
  ; GFX940-NEXT: {{  $}}
  ; GFX940-NEXT: bb.5 (%ir-block.41):
  ; GFX940-NEXT:   $vgpr0 = COPY [[PHI]]
  ; GFX940-NEXT:   SI_RETURN_TO_EPILOG $vgpr0
  ;
  ; GFX11-LABEL: name: global_atomic_fadd_f32_saddr_rtn_atomicrmw
  ; GFX11: bb.0 (%ir-block.0):
  ; GFX11-NEXT:   successors: %bb.1(0x40000000), %bb.3(0x40000000)
  ; GFX11-NEXT:   liveins: $sgpr0, $sgpr1, $vgpr0
  ; GFX11-NEXT: {{  $}}
  ; GFX11-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX11-NEXT:   [[COPY1:%[0-9]+]]:sgpr_32 = COPY $sgpr1
  ; GFX11-NEXT:   [[COPY2:%[0-9]+]]:sgpr_32 = COPY $sgpr0
  ; GFX11-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_64 = REG_SEQUENCE [[COPY2]], %subreg.sub0, [[COPY1]], %subreg.sub1
  ; GFX11-NEXT:   [[COPY3:%[0-9]+]]:sreg_64 = COPY [[REG_SEQUENCE]]
  ; GFX11-NEXT:   [[SI_PS_LIVE:%[0-9]+]]:sreg_32 = SI_PS_LIVE
  ; GFX11-NEXT:   [[DEF:%[0-9]+]]:sgpr_32 = IMPLICIT_DEF
  ; GFX11-NEXT:   [[SI_IF:%[0-9]+]]:sreg_32 = SI_IF killed [[SI_PS_LIVE]], %bb.3, implicit-def dead $exec, implicit-def dead $scc, implicit $exec
  ; GFX11-NEXT:   S_BRANCH %bb.1
  ; GFX11-NEXT: {{  $}}
  ; GFX11-NEXT: bb.1 (%ir-block.5):
  ; GFX11-NEXT:   successors: %bb.2(0x40000000), %bb.4(0x40000000)
  ; GFX11-NEXT: {{  $}}
  ; GFX11-NEXT:   [[COPY4:%[0-9]+]]:sreg_32 = COPY $exec_lo
  ; GFX11-NEXT:   [[S_MOV_B32_:%[0-9]+]]:sreg_32 = S_MOV_B32 0
  ; GFX11-NEXT:   [[V_MBCNT_LO_U32_B32_e64_:%[0-9]+]]:vgpr_32 = V_MBCNT_LO_U32_B32_e64 [[COPY4]], [[S_MOV_B32_]], implicit $exec
  ; GFX11-NEXT:   [[V_MOV_B32_e32_:%[0-9]+]]:vgpr_32 = V_MOV_B32_e32 -2147483648, implicit $exec
  ; GFX11-NEXT:   [[V_SET_INACTIVE_B32_:%[0-9]+]]:vgpr_32 = V_SET_INACTIVE_B32 [[COPY]], [[V_MOV_B32_e32_]], implicit-def dead $scc, implicit $exec
  ; GFX11-NEXT:   [[V_MOV_B32_dpp:%[0-9]+]]:vgpr_32 = V_MOV_B32_dpp [[V_MOV_B32_e32_]], [[V_SET_INACTIVE_B32_]], 273, 15, 15, 0, implicit $exec
  ; GFX11-NEXT:   [[V_ADD_F32_e64_:%[0-9]+]]:vgpr_32 = nofpexcept V_ADD_F32_e64 0, [[V_SET_INACTIVE_B32_]], 0, killed [[V_MOV_B32_dpp]], 0, 0, implicit $mode, implicit $exec
  ; GFX11-NEXT:   [[V_MOV_B32_dpp1:%[0-9]+]]:vgpr_32 = V_MOV_B32_dpp [[V_MOV_B32_e32_]], [[V_ADD_F32_e64_]], 274, 15, 15, 0, implicit $exec
  ; GFX11-NEXT:   [[V_ADD_F32_e64_1:%[0-9]+]]:vgpr_32 = nofpexcept V_ADD_F32_e64 0, [[V_ADD_F32_e64_]], 0, killed [[V_MOV_B32_dpp1]], 0, 0, implicit $mode, implicit $exec
  ; GFX11-NEXT:   [[V_MOV_B32_dpp2:%[0-9]+]]:vgpr_32 = V_MOV_B32_dpp [[V_MOV_B32_e32_]], [[V_ADD_F32_e64_1]], 276, 15, 15, 0, implicit $exec
  ; GFX11-NEXT:   [[V_ADD_F32_e64_2:%[0-9]+]]:vgpr_32 = nofpexcept V_ADD_F32_e64 0, [[V_ADD_F32_e64_1]], 0, killed [[V_MOV_B32_dpp2]], 0, 0, implicit $mode, implicit $exec
  ; GFX11-NEXT:   [[V_MOV_B32_dpp3:%[0-9]+]]:vgpr_32 = V_MOV_B32_dpp [[V_MOV_B32_e32_]], [[V_ADD_F32_e64_2]], 280, 15, 15, 0, implicit $exec
  ; GFX11-NEXT:   [[V_ADD_F32_e64_3:%[0-9]+]]:vgpr_32 = nofpexcept V_ADD_F32_e64 0, [[V_ADD_F32_e64_2]], 0, killed [[V_MOV_B32_dpp3]], 0, 0, implicit $mode, implicit $exec
  ; GFX11-NEXT:   [[S_MOV_B32_1:%[0-9]+]]:sreg_32 = S_MOV_B32 -1
  ; GFX11-NEXT:   [[V_PERMLANEX16_B32_e64_:%[0-9]+]]:vgpr_32 = V_PERMLANEX16_B32_e64 0, [[V_ADD_F32_e64_3]], 0, [[S_MOV_B32_1]], 0, [[S_MOV_B32_1]], [[V_ADD_F32_e64_3]], 0, implicit $exec
  ; GFX11-NEXT:   [[V_MOV_B32_dpp4:%[0-9]+]]:vgpr_32 = V_MOV_B32_dpp [[V_MOV_B32_e32_]], killed [[V_PERMLANEX16_B32_e64_]], 228, 10, 15, 0, implicit $exec
  ; GFX11-NEXT:   [[V_ADD_F32_e64_4:%[0-9]+]]:vgpr_32 = nofpexcept V_ADD_F32_e64 0, [[V_ADD_F32_e64_3]], 0, killed [[V_MOV_B32_dpp4]], 0, 0, implicit $mode, implicit $exec
  ; GFX11-NEXT:   [[V_MOV_B32_dpp5:%[0-9]+]]:vgpr_32 = V_MOV_B32_dpp [[V_MOV_B32_e32_]], [[V_ADD_F32_e64_4]], 273, 15, 15, 0, implicit $exec
  ; GFX11-NEXT:   [[S_MOV_B32_2:%[0-9]+]]:sreg_32 = S_MOV_B32 15
  ; GFX11-NEXT:   [[V_READLANE_B32_:%[0-9]+]]:sreg_32 = V_READLANE_B32 [[V_ADD_F32_e64_4]], killed [[S_MOV_B32_2]]
  ; GFX11-NEXT:   [[S_MOV_B32_3:%[0-9]+]]:sreg_32 = S_MOV_B32 16
  ; GFX11-NEXT:   [[V_WRITELANE_B32_:%[0-9]+]]:vgpr_32 = V_WRITELANE_B32 killed [[V_READLANE_B32_]], killed [[S_MOV_B32_3]], [[V_MOV_B32_dpp5]]
  ; GFX11-NEXT:   [[S_MOV_B32_4:%[0-9]+]]:sreg_32 = S_MOV_B32 31
  ; GFX11-NEXT:   [[V_READLANE_B32_1:%[0-9]+]]:sreg_32 = V_READLANE_B32 [[V_ADD_F32_e64_4]], killed [[S_MOV_B32_4]]
  ; GFX11-NEXT:   early-clobber %2:sgpr_32 = STRICT_WWM killed [[V_READLANE_B32_1]], implicit $exec
  ; GFX11-NEXT:   [[V_CMP_EQ_U32_e64_:%[0-9]+]]:sreg_32 = V_CMP_EQ_U32_e64 killed [[V_MBCNT_LO_U32_B32_e64_]], [[S_MOV_B32_]], implicit $exec
  ; GFX11-NEXT:   [[COPY5:%[0-9]+]]:vreg_1 = COPY [[V_CMP_EQ_U32_e64_]]
  ; GFX11-NEXT:   [[DEF1:%[0-9]+]]:sgpr_32 = IMPLICIT_DEF
  ; GFX11-NEXT:   [[SI_IF1:%[0-9]+]]:sreg_32 = SI_IF [[V_CMP_EQ_U32_e64_]], %bb.4, implicit-def dead $exec, implicit-def dead $scc, implicit $exec
  ; GFX11-NEXT:   S_BRANCH %bb.2
  ; GFX11-NEXT: {{  $}}
  ; GFX11-NEXT: bb.2 (%ir-block.29):
  ; GFX11-NEXT:   successors: %bb.4(0x80000000)
  ; GFX11-NEXT: {{  $}}
  ; GFX11-NEXT:   [[V_MOV_B32_e32_1:%[0-9]+]]:vgpr_32 = V_MOV_B32_e32 0, implicit $exec
  ; GFX11-NEXT:   [[COPY6:%[0-9]+]]:vgpr_32 = COPY %2
  ; GFX11-NEXT:   [[GLOBAL_ATOMIC_ADD_F32_SADDR_RTN:%[0-9]+]]:vgpr_32 = GLOBAL_ATOMIC_ADD_F32_SADDR_RTN killed [[V_MOV_B32_e32_1]], [[COPY6]], [[COPY3]], 0, 1, implicit $exec :: (load store syncscope("wavefront") monotonic (s32) on %ir.ptr, addrspace 1)
  ; GFX11-NEXT:   S_BRANCH %bb.4
  ; GFX11-NEXT: {{  $}}
  ; GFX11-NEXT: bb.3.Flow:
  ; GFX11-NEXT:   successors: %bb.5(0x80000000)
  ; GFX11-NEXT: {{  $}}
  ; GFX11-NEXT:   [[PHI:%[0-9]+]]:vgpr_32 = PHI [[DEF]], %bb.0, %8, %bb.4
  ; GFX11-NEXT:   SI_END_CF [[SI_IF]], implicit-def dead $exec, implicit-def dead $scc, implicit $exec
  ; GFX11-NEXT:   S_BRANCH %bb.5
  ; GFX11-NEXT: {{  $}}
  ; GFX11-NEXT: bb.4 (%ir-block.32):
  ; GFX11-NEXT:   successors: %bb.3(0x80000000)
  ; GFX11-NEXT: {{  $}}
  ; GFX11-NEXT:   [[PHI1:%[0-9]+]]:vgpr_32 = PHI [[DEF1]], %bb.1, [[GLOBAL_ATOMIC_ADD_F32_SADDR_RTN]], %bb.2
  ; GFX11-NEXT:   SI_END_CF [[SI_IF1]], implicit-def dead $exec, implicit-def dead $scc, implicit $exec
  ; GFX11-NEXT:   [[V_READFIRSTLANE_B32_:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[PHI1]], implicit $exec
  ; GFX11-NEXT:   early-clobber %44:vgpr_32 = STRICT_WWM [[V_WRITELANE_B32_]], implicit $exec
  ; GFX11-NEXT:   [[V_ADD_F32_e64_5:%[0-9]+]]:vgpr_32 = nofpexcept V_ADD_F32_e64 0, [[V_READFIRSTLANE_B32_]], 0, killed %44, 0, 0, implicit $mode, implicit $exec
  ; GFX11-NEXT:   [[COPY7:%[0-9]+]]:sreg_32_xm0_xexec = COPY [[COPY5]]
  ; GFX11-NEXT:   [[V_CNDMASK_B32_e64_:%[0-9]+]]:vgpr_32 = V_CNDMASK_B32_e64 0, killed [[V_ADD_F32_e64_5]], 0, [[V_READFIRSTLANE_B32_]], [[COPY7]], implicit $exec
  ; GFX11-NEXT:   S_BRANCH %bb.3
  ; GFX11-NEXT: {{  $}}
  ; GFX11-NEXT: bb.5 (%ir-block.38):
  ; GFX11-NEXT:   $vgpr0 = COPY [[PHI]]
  ; GFX11-NEXT:   SI_RETURN_TO_EPILOG $vgpr0
  %ret = atomicrmw fadd ptr addrspace(1) %ptr, float %data syncscope("wavefront") monotonic
  ret float %ret
}

declare float @llvm.amdgcn.global.atomic.fadd.f32.p1.f32(ptr addrspace(1), float)
declare float @llvm.amdgcn.flat.atomic.fadd.f32.p1.f32(ptr addrspace(1), float)

attributes #0 = {"amdgpu-unsafe-fp-atomics"="true" }
