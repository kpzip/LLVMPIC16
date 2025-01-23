; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=amdgcn -mcpu=gfx90a -O3 -pre-RA-sched=source < %s | FileCheck -check-prefix=RRLIST %s
; RUN: llc -mtriple=amdgcn -mcpu=gfx90a -O3 -pre-RA-sched=fast < %s | FileCheck -check-prefix=FAST %s


define protected amdgpu_kernel void @sccClobber(ptr addrspace(1) %a, ptr addrspace(1) %b, ptr addrspace(1) %e, ptr addrspace(1) %f, ptr addrspace(1) %pout.coerce) {
; RRLIST-LABEL: sccClobber:
; RRLIST:       ; %bb.0: ; %entry
; RRLIST-NEXT:    s_load_dwordx8 s[4:11], s[2:3], 0x24
; RRLIST-NEXT:    v_mov_b32_e32 v2, 0
; RRLIST-NEXT:    s_waitcnt lgkmcnt(0)
; RRLIST-NEXT:    s_load_dword s16, s[8:9], 0x0
; RRLIST-NEXT:    s_load_dwordx2 s[0:1], s[6:7], 0x0
; RRLIST-NEXT:    s_load_dwordx2 s[12:13], s[4:5], 0x0
; RRLIST-NEXT:    s_load_dwordx2 s[14:15], s[2:3], 0x44
; RRLIST-NEXT:    s_load_dword s17, s[10:11], 0x0
; RRLIST-NEXT:    s_waitcnt lgkmcnt(0)
; RRLIST-NEXT:    s_min_i32 s4, s16, 0
; RRLIST-NEXT:    v_pk_mov_b32 v[0:1], s[0:1], s[0:1] op_sel:[0,1]
; RRLIST-NEXT:    v_cmp_lt_i64_e32 vcc, s[12:13], v[0:1]
; RRLIST-NEXT:    s_and_b64 s[2:3], vcc, exec
; RRLIST-NEXT:    s_cselect_b32 s2, s16, s17
; RRLIST-NEXT:    s_cmp_eq_u64 s[12:13], s[0:1]
; RRLIST-NEXT:    s_cselect_b32 s0, s4, s2
; RRLIST-NEXT:    v_mov_b32_e32 v0, s0
; RRLIST-NEXT:    global_store_dword v2, v0, s[14:15]
; RRLIST-NEXT:    s_endpgm
;
; FAST-LABEL: sccClobber:
; FAST:       ; %bb.0: ; %entry
; FAST-NEXT:    s_load_dwordx8 s[4:11], s[2:3], 0x24
; FAST-NEXT:    v_mov_b32_e32 v2, 0
; FAST-NEXT:    s_waitcnt lgkmcnt(0)
; FAST-NEXT:    s_load_dword s16, s[8:9], 0x0
; FAST-NEXT:    s_load_dwordx2 s[0:1], s[6:7], 0x0
; FAST-NEXT:    s_load_dwordx2 s[12:13], s[4:5], 0x0
; FAST-NEXT:    s_load_dwordx2 s[14:15], s[2:3], 0x44
; FAST-NEXT:    s_load_dword s17, s[10:11], 0x0
; FAST-NEXT:    s_waitcnt lgkmcnt(0)
; FAST-NEXT:    s_min_i32 s4, s16, 0
; FAST-NEXT:    v_pk_mov_b32 v[0:1], s[0:1], s[0:1] op_sel:[0,1]
; FAST-NEXT:    v_cmp_lt_i64_e32 vcc, s[12:13], v[0:1]
; FAST-NEXT:    s_and_b64 s[2:3], vcc, exec
; FAST-NEXT:    s_cselect_b32 s2, s16, s17
; FAST-NEXT:    s_cmp_eq_u64 s[12:13], s[0:1]
; FAST-NEXT:    s_cselect_b32 s0, s4, s2
; FAST-NEXT:    v_mov_b32_e32 v0, s0
; FAST-NEXT:    global_store_dword v2, v0, s[14:15]
; FAST-NEXT:    s_endpgm
entry:
  %i = load i64, ptr addrspace(1) %a, align 8
  %i.1 = load i64, ptr addrspace(1) %b, align 8
  %i.2 = load i32, ptr addrspace(1) %e, align 4
  %i.3 = load i32, ptr addrspace(1) %f, align 4
  %cmp7.1 = icmp eq i64 %i, %i.1
  %call.1 = tail call noundef i32 @llvm.smin.i32(i32 noundef 0, i32 noundef %i.2)
  %cmp8.1 = icmp slt i64 %i, %i.1
  %cond.1 = select i1 %cmp8.1, i32 %i.2, i32 %i.3
  %cond14.1 = select i1 %cmp7.1, i32 %call.1, i32 %cond.1
  store i32 %cond14.1, ptr addrspace(1) %pout.coerce, align 4
  ret void
}

declare i32 @llvm.smin.i32(i32, i32)
