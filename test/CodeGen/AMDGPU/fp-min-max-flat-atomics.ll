; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -global-isel=0 -mtriple=amdgcn -mcpu=gfx1010 -verify-machineinstrs | FileCheck %s -check-prefixes=GFX10,GFX10-SDAG
; RUN: llc < %s -global-isel=0 -mtriple=amdgcn -mcpu=gfx1100 -verify-machineinstrs | FileCheck %s -check-prefixes=GFX11,GFX11-SDAG
; RUN: llc < %s -global-isel=1 -mtriple=amdgcn -mcpu=gfx1010 -verify-machineinstrs | FileCheck %s -check-prefixes=GFX10,GFX10-GISEL
; RUN: llc < %s -global-isel=1 -mtriple=amdgcn -mcpu=gfx1100 -verify-machineinstrs | FileCheck %s -check-prefixes=GFX11,GFX11-GISEL

declare float @llvm.amdgcn.flat.atomic.fmin.f32.p1.f32(ptr %ptr, float %data)
declare float @llvm.amdgcn.flat.atomic.fmax.f32.p1.f32(ptr %ptr, float %data)

define amdgpu_cs void @flat_atomic_fmin_f32_noret(ptr %ptr, float %data) {
; GFX10-LABEL: flat_atomic_fmin_f32_noret:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    flat_atomic_fmin v[0:1], v2
; GFX10-NEXT:    s_endpgm
;
; GFX11-LABEL: flat_atomic_fmin_f32_noret:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    flat_atomic_min_f32 v[0:1], v2
; GFX11-NEXT:    s_endpgm
  %ret = call float @llvm.amdgcn.flat.atomic.fmin.f32.p1.f32(ptr %ptr, float %data)
  ret void
}

define amdgpu_cs void @flat_atomic_fmax_f32_noret(ptr %ptr, float %data) {
; GFX10-LABEL: flat_atomic_fmax_f32_noret:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    flat_atomic_fmax v[0:1], v2
; GFX10-NEXT:    s_endpgm
;
; GFX11-LABEL: flat_atomic_fmax_f32_noret:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    flat_atomic_max_f32 v[0:1], v2
; GFX11-NEXT:    s_endpgm
  %ret = call float @llvm.amdgcn.flat.atomic.fmax.f32.p1.f32(ptr %ptr, float %data)
  ret void
}

define amdgpu_cs float @flat_atomic_fmin_f32_rtn(ptr %ptr, float %data, ptr %out) {
; GFX10-LABEL: flat_atomic_fmin_f32_rtn:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    flat_atomic_fmin v0, v[0:1], v2 glc
; GFX10-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; GFX10-NEXT:    flat_store_dword v[3:4], v0
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    ; return to shader part epilog
;
; GFX11-LABEL: flat_atomic_fmin_f32_rtn:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    flat_atomic_min_f32 v0, v[0:1], v2 glc
; GFX11-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; GFX11-NEXT:    flat_store_b32 v[3:4], v0
; GFX11-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-NEXT:    ; return to shader part epilog
  %ret = call float @llvm.amdgcn.flat.atomic.fmin.f32.p1.f32(ptr %ptr, float %data)
  store float %ret, ptr %out
  ret float %ret
}

define amdgpu_cs float @flat_atomic_fmax_f32_rtn(ptr %ptr, float %data, ptr %out) {
; GFX10-LABEL: flat_atomic_fmax_f32_rtn:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    flat_atomic_fmax v0, v[0:1], v2 glc
; GFX10-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; GFX10-NEXT:    flat_store_dword v[3:4], v0
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    ; return to shader part epilog
;
; GFX11-LABEL: flat_atomic_fmax_f32_rtn:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    flat_atomic_max_f32 v0, v[0:1], v2 glc
; GFX11-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; GFX11-NEXT:    flat_store_b32 v[3:4], v0
; GFX11-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-NEXT:    ; return to shader part epilog
  %ret = call float @llvm.amdgcn.flat.atomic.fmax.f32.p1.f32(ptr %ptr, float %data)
  store float %ret, ptr %out
  ret float %ret
}
;; NOTE: These prefixes are unused and the list is autogenerated. Do not add tests below this line:
; GFX10-GISEL: {{.*}}
; GFX10-SDAG: {{.*}}
; GFX11-GISEL: {{.*}}
; GFX11-SDAG: {{.*}}
