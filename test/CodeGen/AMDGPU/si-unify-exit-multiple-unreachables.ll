; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=amdgcn-amd-amdhsa -mcpu=gfx906 -stop-after=amdgpu-unify-divergent-exit-nodes | FileCheck %s --check-prefix=UNIFY
; RUN: llc < %s -mtriple=amdgcn-amd-amdhsa -mcpu=gfx906 -verify-machineinstrs | FileCheck %s

declare void @llvm.trap()
declare i32 @llvm.amdgcn.workitem.id.x()

define amdgpu_kernel void @kernel(i32 %a, ptr addrspace(1) %x, i32 noundef %n) {
; This used to bypass the structurization process because structurizer is unable to
; handle multiple-exits CFG. This should be correctly structurized.
; UNIFY-LABEL: define amdgpu_kernel void @kernel
; UNIFY-LABEL: entry:
; UNIFY:         %tid = call i32 @llvm.amdgcn.workitem.id.x()
; UNIFY-NEXT:    %cmp = icmp eq i32 %n.load, 256
; UNIFY-NEXT:    br i1 %cmp, label %if.then, label %if.else
; UNIFY-LABEL: if.then:
; UNIFY-NEXT:    %cmp1 = icmp eq i32 %a.load, 0
; UNIFY-NEXT:    br i1 %cmp1, label %if.end6.sink.split, label %cond.false
; UNIFY-LABEL: cond.false:
; UNIFY-NEXT:    call void @llvm.trap()
; UNIFY-NEXT:    br label %UnifiedUnreachableBlock
; UNIFY-LABEL: if.else:
; UNIFY-NEXT:    %cmp2 = icmp ult i32 %tid, 10
; UNIFY-NEXT:    br i1 %cmp2, label %if.then3, label %UnifiedReturnBlock
; UNIFY-LABEL: if.then3:
; UNIFY-NEXT:    %cmp1.i7 = icmp eq i32 %a.load, 0
; UNIFY-NEXT:    br i1 %cmp1.i7, label %if.end6.sink.split, label %cond.false.i8
; UNIFY-LABEL: cond.false.i8:
; UNIFY-NEXT:    call void @llvm.trap()
; UNIFY-NEXT:    br label %UnifiedUnreachableBlock
; UNIFY-LABEL: if.end6.sink.split:
; UNIFY-NEXT:    %x.kernarg.offset = getelementptr inbounds i8, ptr addrspace(4) %kernel.kernarg.segment, i64 8
; UNIFY-NEXT:    %x.load = load ptr addrspace(1), ptr addrspace(4) %x.kernarg.offset, align 8, !invariant.load !0
; UNIFY-NEXT:    %idxprom = sext i32 %tid to i64
; UNIFY-NEXT:    %x1 = getelementptr inbounds i32, ptr addrspace(1) %x.load, i64 %idxprom
; UNIFY-NEXT:    store i32 %a.load, ptr addrspace(1) %x1, align 4
; UNIFY-NEXT:    br label %UnifiedReturnBlock
; UNIFY-LABEL: UnifiedUnreachableBlock:
; UNIFY-NEXT:    call void @llvm.amdgcn.unreachable()
; UNIFY-NEXT:    br label %UnifiedReturnBlock
; UNIFY-LABEL: UnifiedReturnBlock:
; UNIFY-NEXT:    ret void

; CHECK-LABEL: kernel:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    s_load_dword s0, s[6:7], 0x10
; CHECK-NEXT:    s_load_dword s10, s[6:7], 0x0
; CHECK-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-NEXT:    s_cmpk_lg_i32 s0, 0x100
; CHECK-NEXT:    s_cbranch_scc0 .LBB0_6
; CHECK-NEXT:  ; %bb.1: ; %if.else
; CHECK-NEXT:    v_cmp_gt_u32_e32 vcc, 10, v0
; CHECK-NEXT:    s_mov_b64 s[4:5], 0
; CHECK-NEXT:    s_mov_b64 s[2:3], 0
; CHECK-NEXT:    s_mov_b64 s[0:1], 0
; CHECK-NEXT:    s_and_saveexec_b64 s[8:9], vcc
; CHECK-NEXT:    s_cbranch_execz .LBB0_5
; CHECK-NEXT:  ; %bb.2: ; %if.then3
; CHECK-NEXT:    s_cmp_lg_u32 s10, 0
; CHECK-NEXT:    s_cbranch_scc1 .LBB0_14
; CHECK-NEXT:  ; %bb.3:
; CHECK-NEXT:    s_mov_b64 s[0:1], -1
; CHECK-NEXT:  .LBB0_4: ; %Flow3
; CHECK-NEXT:    s_and_b64 s[0:1], s[0:1], exec
; CHECK-NEXT:    s_and_b64 s[2:3], s[2:3], exec
; CHECK-NEXT:  .LBB0_5: ; %Flow2
; CHECK-NEXT:    s_or_b64 exec, exec, s[8:9]
; CHECK-NEXT:    s_and_b64 vcc, exec, s[4:5]
; CHECK-NEXT:    s_cbranch_vccz .LBB0_8
; CHECK-NEXT:    s_branch .LBB0_7
; CHECK-NEXT:  .LBB0_6:
; CHECK-NEXT:    s_mov_b64 s[2:3], 0
; CHECK-NEXT:    s_mov_b64 s[0:1], 0
; CHECK-NEXT:    s_cbranch_execz .LBB0_8
; CHECK-NEXT:  .LBB0_7: ; %if.then
; CHECK-NEXT:    s_cmp_lg_u32 s10, 0
; CHECK-NEXT:    s_mov_b64 s[0:1], -1
; CHECK-NEXT:    s_cbranch_scc1 .LBB0_13
; CHECK-NEXT:  .LBB0_8: ; %Flow4
; CHECK-NEXT:    s_and_saveexec_b64 s[4:5], s[2:3]
; CHECK-NEXT:  .LBB0_9: ; %UnifiedUnreachableBlock
; CHECK-NEXT:    ; divergent unreachable
; CHECK-NEXT:  .LBB0_10: ; %Flow6
; CHECK-NEXT:    s_or_b64 exec, exec, s[4:5]
; CHECK-NEXT:    s_and_saveexec_b64 s[2:3], s[0:1]
; CHECK-NEXT:    s_cbranch_execz .LBB0_12
; CHECK-NEXT:  ; %bb.11: ; %if.end6.sink.split
; CHECK-NEXT:    s_load_dwordx2 s[0:1], s[6:7], 0x8
; CHECK-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; CHECK-NEXT:    v_mov_b32_e32 v1, s10
; CHECK-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-NEXT:    global_store_dword v0, v1, s[0:1]
; CHECK-NEXT:  .LBB0_12: ; %UnifiedReturnBlock
; CHECK-NEXT:    s_endpgm
; CHECK-NEXT:  .LBB0_13: ; %cond.false
; CHECK-NEXT:    s_mov_b64 s[0:1], 0
; CHECK-NEXT:    s_or_b64 s[2:3], s[2:3], exec
; CHECK-NEXT:    s_trap 2
; CHECK-NEXT:    s_and_saveexec_b64 s[4:5], s[2:3]
; CHECK-NEXT:    s_cbranch_execnz .LBB0_9
; CHECK-NEXT:    s_branch .LBB0_10
; CHECK-NEXT:  .LBB0_14: ; %cond.false.i8
; CHECK-NEXT:    s_mov_b64 s[2:3], -1
; CHECK-NEXT:    s_trap 2
; CHECK-NEXT:    s_branch .LBB0_4

entry:
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %cmp = icmp eq i32 %n, 256
  br i1 %cmp, label %if.then, label %if.else

if.then:
  %cmp1 = icmp eq i32 %a, 0
  br i1 %cmp1, label %if.end6.sink.split, label %cond.false

cond.false:
  call void @llvm.trap()
  unreachable

if.else:
  %cmp2 = icmp ult i32 %tid, 10
  br i1 %cmp2, label %if.then3, label %if.end6

if.then3:
  %cmp1.i7 = icmp eq i32 %a, 0
  br i1 %cmp1.i7, label %if.end6.sink.split, label %cond.false.i8

cond.false.i8:
  call void @llvm.trap()
  unreachable

if.end6.sink.split:
  %x1 = getelementptr inbounds i32, ptr addrspace(1) %x, i32 %tid
  store i32 %a, ptr addrspace(1) %x1, align 4
  br label %if.end6

if.end6:
  ret void
}
