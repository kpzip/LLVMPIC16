; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py UTC_ARGS: --version 5
; RUN: llc -global-isel -mtriple=amdgcn-mesa-mesa3d -mcpu=fiji -stop-after=irtranslator -o - %s | FileCheck %s

define <2 x i65> @v2i65_func_void() #0 {
  ; CHECK-LABEL: name: v2i65_func_void
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   [[DEF:%[0-9]+]]:_(p1) = G_IMPLICIT_DEF
  ; CHECK-NEXT:   [[LOAD:%[0-9]+]]:_(<2 x s65>) = G_LOAD [[DEF]](p1) :: (load (<2 x s65>) from `ptr addrspace(1) undef`, align 32, addrspace 1)
  ; CHECK-NEXT:   [[ANYEXT:%[0-9]+]]:_(<2 x s96>) = G_ANYEXT [[LOAD]](<2 x s65>)
  ; CHECK-NEXT:   [[UV:%[0-9]+]]:_(s32), [[UV1:%[0-9]+]]:_(s32), [[UV2:%[0-9]+]]:_(s32), [[UV3:%[0-9]+]]:_(s32), [[UV4:%[0-9]+]]:_(s32), [[UV5:%[0-9]+]]:_(s32) = G_UNMERGE_VALUES [[ANYEXT]](<2 x s96>)
  ; CHECK-NEXT:   $vgpr0 = COPY [[UV]](s32)
  ; CHECK-NEXT:   $vgpr1 = COPY [[UV1]](s32)
  ; CHECK-NEXT:   $vgpr2 = COPY [[UV2]](s32)
  ; CHECK-NEXT:   $vgpr3 = COPY [[UV3]](s32)
  ; CHECK-NEXT:   $vgpr4 = COPY [[UV4]](s32)
  ; CHECK-NEXT:   $vgpr5 = COPY [[UV5]](s32)
  ; CHECK-NEXT:   SI_RETURN implicit $vgpr0, implicit $vgpr1, implicit $vgpr2, implicit $vgpr3, implicit $vgpr4, implicit $vgpr5
  %val = load <2 x i65>, ptr addrspace(1) undef
  ret <2 x i65> %val
}
