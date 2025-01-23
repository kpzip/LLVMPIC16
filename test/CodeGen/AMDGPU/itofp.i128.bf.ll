; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 4
; RUN: llc -global-isel=0 -mtriple=amdgcn-amd-amdhsa -mcpu=gfx900 < %s | FileCheck -check-prefixes=GCN,SDAG %s
; RUN: not --crash llc -global-isel=1 -mtriple=amdgcn-amd-amdhsa -mcpu=gfx900 < %s 2>&1 | FileCheck -check-prefix=GISEL %s

; FIXME: GISEL can't handle the "fptrunc float to bfloat" that expand-large-fp-convert emits.

; GISEL: unable to translate instruction: fptrunc

define bfloat @sitofp_i128_to_bf16(i128 %x) {
; GCN-LABEL: sitofp_i128_to_bf16:
; GCN:       ; %bb.0: ; %itofp-entry
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_or_b32_e32 v5, v1, v3
; GCN-NEXT:    v_or_b32_e32 v4, v0, v2
; GCN-NEXT:    v_cmp_ne_u64_e32 vcc, 0, v[4:5]
; GCN-NEXT:    v_mov_b32_e32 v4, 0
; GCN-NEXT:    s_and_saveexec_b64 s[6:7], vcc
; GCN-NEXT:    s_cbranch_execz .LBB0_14
; GCN-NEXT:  ; %bb.1: ; %itofp-if-end
; GCN-NEXT:    v_sub_co_u32_e32 v4, vcc, 0, v0
; GCN-NEXT:    v_subb_co_u32_e32 v5, vcc, 0, v1, vcc
; GCN-NEXT:    v_subb_co_u32_e32 v6, vcc, 0, v2, vcc
; GCN-NEXT:    v_subb_co_u32_e32 v7, vcc, 0, v3, vcc
; GCN-NEXT:    v_cmp_gt_i64_e32 vcc, 0, v[2:3]
; GCN-NEXT:    ; implicit-def: $vgpr8
; GCN-NEXT:    v_cndmask_b32_e32 v0, v0, v4, vcc
; GCN-NEXT:    v_cndmask_b32_e32 v4, v2, v6, vcc
; GCN-NEXT:    v_cndmask_b32_e32 v1, v1, v5, vcc
; GCN-NEXT:    v_cndmask_b32_e32 v5, v3, v7, vcc
; GCN-NEXT:    v_ffbh_u32_e32 v2, v4
; GCN-NEXT:    v_add_u32_e32 v2, 32, v2
; GCN-NEXT:    v_ffbh_u32_e32 v6, v5
; GCN-NEXT:    v_min_u32_e32 v2, v2, v6
; GCN-NEXT:    v_ffbh_u32_e32 v6, v0
; GCN-NEXT:    v_add_u32_e32 v6, 32, v6
; GCN-NEXT:    v_ffbh_u32_e32 v7, v1
; GCN-NEXT:    v_min_u32_e32 v6, v6, v7
; GCN-NEXT:    v_cmp_ne_u64_e32 vcc, 0, v[4:5]
; GCN-NEXT:    v_add_u32_e32 v6, 64, v6
; GCN-NEXT:    v_cndmask_b32_e32 v7, v6, v2, vcc
; GCN-NEXT:    v_sub_u32_e32 v6, 0x80, v7
; GCN-NEXT:    v_sub_u32_e32 v2, 0x7f, v7
; GCN-NEXT:    v_cmp_gt_i32_e32 vcc, 25, v6
; GCN-NEXT:    s_and_saveexec_b64 s[4:5], vcc
; GCN-NEXT:    s_xor_b64 s[4:5], exec, s[4:5]
; GCN-NEXT:  ; %bb.2: ; %itofp-if-else
; GCN-NEXT:    v_add_u32_e32 v4, 0xffffff98, v7
; GCN-NEXT:    v_lshlrev_b64 v[0:1], v4, v[0:1]
; GCN-NEXT:    v_cmp_gt_u32_e32 vcc, 64, v4
; GCN-NEXT:    v_cndmask_b32_e32 v8, 0, v0, vcc
; GCN-NEXT:    ; implicit-def: $vgpr6
; GCN-NEXT:    ; implicit-def: $vgpr0_vgpr1
; GCN-NEXT:    ; implicit-def: $vgpr7
; GCN-NEXT:    ; implicit-def: $vgpr4_vgpr5
; GCN-NEXT:  ; %bb.3: ; %Flow3
; GCN-NEXT:    s_andn2_saveexec_b64 s[8:9], s[4:5]
; GCN-NEXT:    s_cbranch_execz .LBB0_13
; GCN-NEXT:  ; %bb.4: ; %NodeBlock
; GCN-NEXT:    v_cmp_lt_i32_e32 vcc, 25, v6
; GCN-NEXT:    s_and_saveexec_b64 s[4:5], vcc
; GCN-NEXT:    s_xor_b64 s[10:11], exec, s[4:5]
; GCN-NEXT:    s_cbranch_execz .LBB0_8
; GCN-NEXT:  ; %bb.5: ; %LeafBlock
; GCN-NEXT:    v_cmp_ne_u32_e32 vcc, 26, v6
; GCN-NEXT:    s_and_saveexec_b64 s[12:13], vcc
; GCN-NEXT:    s_cbranch_execz .LBB0_7
; GCN-NEXT:  ; %bb.6: ; %itofp-sw-default
; GCN-NEXT:    v_sub_u32_e32 v12, 0x66, v7
; GCN-NEXT:    v_sub_u32_e32 v10, 64, v12
; GCN-NEXT:    v_lshrrev_b64 v[8:9], v12, v[0:1]
; GCN-NEXT:    v_lshlrev_b64 v[10:11], v10, v[4:5]
; GCN-NEXT:    v_sub_u32_e32 v13, 38, v7
; GCN-NEXT:    v_or_b32_e32 v11, v9, v11
; GCN-NEXT:    v_or_b32_e32 v10, v8, v10
; GCN-NEXT:    v_lshrrev_b64 v[8:9], v13, v[4:5]
; GCN-NEXT:    v_cmp_gt_u32_e32 vcc, 64, v12
; GCN-NEXT:    v_add_u32_e32 v14, 26, v7
; GCN-NEXT:    v_cndmask_b32_e32 v9, v9, v11, vcc
; GCN-NEXT:    v_cmp_eq_u32_e64 s[4:5], 0, v12
; GCN-NEXT:    v_cndmask_b32_e32 v8, v8, v10, vcc
; GCN-NEXT:    v_lshrrev_b64 v[10:11], v13, v[0:1]
; GCN-NEXT:    v_lshlrev_b64 v[12:13], v14, v[4:5]
; GCN-NEXT:    v_subrev_u32_e32 v7, 38, v7
; GCN-NEXT:    v_cndmask_b32_e64 v15, v8, v0, s[4:5]
; GCN-NEXT:    v_lshlrev_b64 v[7:8], v7, v[0:1]
; GCN-NEXT:    v_cndmask_b32_e64 v9, v9, v1, s[4:5]
; GCN-NEXT:    v_or_b32_e32 v11, v13, v11
; GCN-NEXT:    v_or_b32_e32 v10, v12, v10
; GCN-NEXT:    v_cmp_gt_u32_e32 vcc, 64, v14
; GCN-NEXT:    v_lshlrev_b64 v[0:1], v14, v[0:1]
; GCN-NEXT:    v_cndmask_b32_e32 v8, v8, v11, vcc
; GCN-NEXT:    v_cmp_eq_u32_e64 s[4:5], 0, v14
; GCN-NEXT:    v_cndmask_b32_e32 v7, v7, v10, vcc
; GCN-NEXT:    v_cndmask_b32_e64 v5, v8, v5, s[4:5]
; GCN-NEXT:    v_cndmask_b32_e64 v4, v7, v4, s[4:5]
; GCN-NEXT:    v_cndmask_b32_e32 v1, 0, v1, vcc
; GCN-NEXT:    v_cndmask_b32_e32 v0, 0, v0, vcc
; GCN-NEXT:    v_or_b32_e32 v1, v1, v5
; GCN-NEXT:    v_or_b32_e32 v0, v0, v4
; GCN-NEXT:    v_cmp_ne_u64_e32 vcc, 0, v[0:1]
; GCN-NEXT:    v_cndmask_b32_e64 v0, 0, 1, vcc
; GCN-NEXT:    v_or_b32_e32 v8, v15, v0
; GCN-NEXT:    v_mov_b32_e32 v0, v8
; GCN-NEXT:    v_mov_b32_e32 v1, v9
; GCN-NEXT:  .LBB0_7: ; %Flow1
; GCN-NEXT:    s_or_b64 exec, exec, s[12:13]
; GCN-NEXT:  .LBB0_8: ; %Flow2
; GCN-NEXT:    s_andn2_saveexec_b64 s[4:5], s[10:11]
; GCN-NEXT:  ; %bb.9: ; %itofp-sw-bb
; GCN-NEXT:    v_lshlrev_b64 v[0:1], 1, v[0:1]
; GCN-NEXT:  ; %bb.10: ; %itofp-sw-epilog
; GCN-NEXT:    s_or_b64 exec, exec, s[4:5]
; GCN-NEXT:    v_lshrrev_b32_e32 v4, 2, v0
; GCN-NEXT:    v_and_or_b32 v0, v4, 1, v0
; GCN-NEXT:    v_add_co_u32_e32 v0, vcc, 1, v0
; GCN-NEXT:    v_addc_co_u32_e32 v1, vcc, 0, v1, vcc
; GCN-NEXT:    v_and_b32_e32 v4, 0x4000000, v0
; GCN-NEXT:    v_cmp_ne_u32_e32 vcc, 0, v4
; GCN-NEXT:    v_alignbit_b32 v8, v1, v0, 2
; GCN-NEXT:    s_and_saveexec_b64 s[4:5], vcc
; GCN-NEXT:  ; %bb.11: ; %itofp-if-then20
; GCN-NEXT:    v_alignbit_b32 v8, v1, v0, 3
; GCN-NEXT:    v_mov_b32_e32 v2, v6
; GCN-NEXT:  ; %bb.12: ; %Flow
; GCN-NEXT:    s_or_b64 exec, exec, s[4:5]
; GCN-NEXT:  .LBB0_13: ; %Flow4
; GCN-NEXT:    s_or_b64 exec, exec, s[8:9]
; GCN-NEXT:    v_and_b32_e32 v0, 0x80000000, v3
; GCN-NEXT:    v_lshl_add_u32 v1, v2, 23, 1.0
; GCN-NEXT:    v_and_b32_e32 v2, 0x7fffff, v8
; GCN-NEXT:    v_or3_b32 v0, v2, v0, v1
; GCN-NEXT:    v_bfe_u32 v1, v8, 16, 1
; GCN-NEXT:    s_movk_i32 s4, 0x7fff
; GCN-NEXT:    v_add3_u32 v1, v1, v0, s4
; GCN-NEXT:    v_or_b32_e32 v2, 0x400000, v0
; GCN-NEXT:    v_cmp_u_f32_e32 vcc, v0, v0
; GCN-NEXT:    v_cndmask_b32_e32 v0, v1, v2, vcc
; GCN-NEXT:    v_lshrrev_b32_e32 v4, 16, v0
; GCN-NEXT:  .LBB0_14: ; %Flow5
; GCN-NEXT:    s_or_b64 exec, exec, s[6:7]
; GCN-NEXT:    v_mov_b32_e32 v0, v4
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %cvt = sitofp i128 %x to bfloat
  ret bfloat %cvt
}

define bfloat @uitofp_i128_to_bf16(i128 %x) {
; GCN-LABEL: uitofp_i128_to_bf16:
; GCN:       ; %bb.0: ; %itofp-entry
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_or_b32_e32 v5, v1, v3
; GCN-NEXT:    v_or_b32_e32 v4, v0, v2
; GCN-NEXT:    v_cmp_ne_u64_e32 vcc, 0, v[4:5]
; GCN-NEXT:    v_mov_b32_e32 v4, 0
; GCN-NEXT:    s_and_saveexec_b64 s[6:7], vcc
; GCN-NEXT:    s_cbranch_execz .LBB1_14
; GCN-NEXT:  ; %bb.1: ; %itofp-if-end
; GCN-NEXT:    v_ffbh_u32_e32 v4, v2
; GCN-NEXT:    v_add_u32_e32 v4, 32, v4
; GCN-NEXT:    v_ffbh_u32_e32 v5, v3
; GCN-NEXT:    v_min_u32_e32 v4, v4, v5
; GCN-NEXT:    v_ffbh_u32_e32 v5, v0
; GCN-NEXT:    v_add_u32_e32 v5, 32, v5
; GCN-NEXT:    v_ffbh_u32_e32 v6, v1
; GCN-NEXT:    v_min_u32_e32 v5, v5, v6
; GCN-NEXT:    v_cmp_ne_u64_e32 vcc, 0, v[2:3]
; GCN-NEXT:    v_add_u32_e32 v5, 64, v5
; GCN-NEXT:    v_cndmask_b32_e32 v6, v5, v4, vcc
; GCN-NEXT:    v_sub_u32_e32 v5, 0x80, v6
; GCN-NEXT:    v_sub_u32_e32 v4, 0x7f, v6
; GCN-NEXT:    v_cmp_gt_i32_e32 vcc, 25, v5
; GCN-NEXT:    ; implicit-def: $vgpr7
; GCN-NEXT:    s_and_saveexec_b64 s[4:5], vcc
; GCN-NEXT:    s_xor_b64 s[4:5], exec, s[4:5]
; GCN-NEXT:  ; %bb.2: ; %itofp-if-else
; GCN-NEXT:    v_add_u32_e32 v2, 0xffffff98, v6
; GCN-NEXT:    v_lshlrev_b64 v[0:1], v2, v[0:1]
; GCN-NEXT:    v_cmp_gt_u32_e32 vcc, 64, v2
; GCN-NEXT:    v_cndmask_b32_e32 v7, 0, v0, vcc
; GCN-NEXT:    ; implicit-def: $vgpr5
; GCN-NEXT:    ; implicit-def: $vgpr0_vgpr1
; GCN-NEXT:    ; implicit-def: $vgpr6
; GCN-NEXT:    ; implicit-def: $vgpr2_vgpr3
; GCN-NEXT:  ; %bb.3: ; %Flow3
; GCN-NEXT:    s_andn2_saveexec_b64 s[8:9], s[4:5]
; GCN-NEXT:    s_cbranch_execz .LBB1_13
; GCN-NEXT:  ; %bb.4: ; %NodeBlock
; GCN-NEXT:    v_cmp_lt_i32_e32 vcc, 25, v5
; GCN-NEXT:    s_and_saveexec_b64 s[4:5], vcc
; GCN-NEXT:    s_xor_b64 s[10:11], exec, s[4:5]
; GCN-NEXT:    s_cbranch_execz .LBB1_8
; GCN-NEXT:  ; %bb.5: ; %LeafBlock
; GCN-NEXT:    v_cmp_ne_u32_e32 vcc, 26, v5
; GCN-NEXT:    s_and_saveexec_b64 s[12:13], vcc
; GCN-NEXT:    s_cbranch_execz .LBB1_7
; GCN-NEXT:  ; %bb.6: ; %itofp-sw-default
; GCN-NEXT:    v_sub_u32_e32 v11, 0x66, v6
; GCN-NEXT:    v_sub_u32_e32 v9, 64, v11
; GCN-NEXT:    v_lshrrev_b64 v[7:8], v11, v[0:1]
; GCN-NEXT:    v_lshlrev_b64 v[9:10], v9, v[2:3]
; GCN-NEXT:    v_sub_u32_e32 v12, 38, v6
; GCN-NEXT:    v_or_b32_e32 v10, v8, v10
; GCN-NEXT:    v_or_b32_e32 v9, v7, v9
; GCN-NEXT:    v_lshrrev_b64 v[7:8], v12, v[2:3]
; GCN-NEXT:    v_cmp_gt_u32_e32 vcc, 64, v11
; GCN-NEXT:    v_add_u32_e32 v13, 26, v6
; GCN-NEXT:    v_cndmask_b32_e32 v8, v8, v10, vcc
; GCN-NEXT:    v_cmp_eq_u32_e64 s[4:5], 0, v11
; GCN-NEXT:    v_cndmask_b32_e32 v7, v7, v9, vcc
; GCN-NEXT:    v_lshrrev_b64 v[9:10], v12, v[0:1]
; GCN-NEXT:    v_lshlrev_b64 v[11:12], v13, v[2:3]
; GCN-NEXT:    v_subrev_u32_e32 v6, 38, v6
; GCN-NEXT:    v_cndmask_b32_e64 v14, v7, v0, s[4:5]
; GCN-NEXT:    v_lshlrev_b64 v[6:7], v6, v[0:1]
; GCN-NEXT:    v_cndmask_b32_e64 v8, v8, v1, s[4:5]
; GCN-NEXT:    v_or_b32_e32 v10, v12, v10
; GCN-NEXT:    v_or_b32_e32 v9, v11, v9
; GCN-NEXT:    v_cmp_gt_u32_e32 vcc, 64, v13
; GCN-NEXT:    v_lshlrev_b64 v[0:1], v13, v[0:1]
; GCN-NEXT:    v_cndmask_b32_e32 v7, v7, v10, vcc
; GCN-NEXT:    v_cmp_eq_u32_e64 s[4:5], 0, v13
; GCN-NEXT:    v_cndmask_b32_e32 v6, v6, v9, vcc
; GCN-NEXT:    v_cndmask_b32_e64 v3, v7, v3, s[4:5]
; GCN-NEXT:    v_cndmask_b32_e64 v2, v6, v2, s[4:5]
; GCN-NEXT:    v_cndmask_b32_e32 v1, 0, v1, vcc
; GCN-NEXT:    v_cndmask_b32_e32 v0, 0, v0, vcc
; GCN-NEXT:    v_or_b32_e32 v1, v1, v3
; GCN-NEXT:    v_or_b32_e32 v0, v0, v2
; GCN-NEXT:    v_cmp_ne_u64_e32 vcc, 0, v[0:1]
; GCN-NEXT:    v_cndmask_b32_e64 v0, 0, 1, vcc
; GCN-NEXT:    v_or_b32_e32 v7, v14, v0
; GCN-NEXT:    v_mov_b32_e32 v0, v7
; GCN-NEXT:    v_mov_b32_e32 v1, v8
; GCN-NEXT:  .LBB1_7: ; %Flow1
; GCN-NEXT:    s_or_b64 exec, exec, s[12:13]
; GCN-NEXT:  .LBB1_8: ; %Flow2
; GCN-NEXT:    s_andn2_saveexec_b64 s[4:5], s[10:11]
; GCN-NEXT:  ; %bb.9: ; %itofp-sw-bb
; GCN-NEXT:    v_lshlrev_b64 v[0:1], 1, v[0:1]
; GCN-NEXT:  ; %bb.10: ; %itofp-sw-epilog
; GCN-NEXT:    s_or_b64 exec, exec, s[4:5]
; GCN-NEXT:    v_lshrrev_b32_e32 v2, 2, v0
; GCN-NEXT:    v_and_or_b32 v0, v2, 1, v0
; GCN-NEXT:    v_add_co_u32_e32 v0, vcc, 1, v0
; GCN-NEXT:    v_addc_co_u32_e32 v1, vcc, 0, v1, vcc
; GCN-NEXT:    v_and_b32_e32 v2, 0x4000000, v0
; GCN-NEXT:    v_cmp_ne_u32_e32 vcc, 0, v2
; GCN-NEXT:    v_alignbit_b32 v7, v1, v0, 2
; GCN-NEXT:    s_and_saveexec_b64 s[4:5], vcc
; GCN-NEXT:  ; %bb.11: ; %itofp-if-then20
; GCN-NEXT:    v_alignbit_b32 v7, v1, v0, 3
; GCN-NEXT:    v_mov_b32_e32 v4, v5
; GCN-NEXT:  ; %bb.12: ; %Flow
; GCN-NEXT:    s_or_b64 exec, exec, s[4:5]
; GCN-NEXT:  .LBB1_13: ; %Flow4
; GCN-NEXT:    s_or_b64 exec, exec, s[8:9]
; GCN-NEXT:    v_and_b32_e32 v0, 0x7fffff, v7
; GCN-NEXT:    v_lshl_or_b32 v0, v4, 23, v0
; GCN-NEXT:    v_add_u32_e32 v0, 1.0, v0
; GCN-NEXT:    v_bfe_u32 v1, v0, 16, 1
; GCN-NEXT:    s_movk_i32 s4, 0x7fff
; GCN-NEXT:    v_add3_u32 v1, v1, v0, s4
; GCN-NEXT:    v_or_b32_e32 v2, 0x400000, v0
; GCN-NEXT:    v_cmp_u_f32_e32 vcc, v0, v0
; GCN-NEXT:    v_cndmask_b32_e32 v0, v1, v2, vcc
; GCN-NEXT:    v_lshrrev_b32_e32 v4, 16, v0
; GCN-NEXT:  .LBB1_14: ; %Flow5
; GCN-NEXT:    s_or_b64 exec, exec, s[6:7]
; GCN-NEXT:    v_mov_b32_e32 v0, v4
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %cvt = uitofp i128 %x to bfloat
  ret bfloat %cvt
}
;; NOTE: These prefixes are unused and the list is autogenerated. Do not add tests below this line:
; SDAG: {{.*}}
