; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -stack-symbol-ordering=0 -mcpu=nehalem -debug-only=stackmaps < %s | FileCheck %s
; REQUIRES: asserts

target triple = "x86_64-pc-linux-gnu"

; Can we lower a single vector?
define <2 x ptr addrspace(1)> @test(<2 x ptr addrspace(1)> %obj) gc "statepoint-example" {
; CHECK-LABEL: test:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    subq $24, %rsp
; CHECK-NEXT:    .cfi_def_cfa_offset 32
; CHECK-NEXT:    movaps %xmm0, (%rsp)
; CHECK-NEXT:    callq do_safepoint@PLT
; CHECK-NEXT:  .Ltmp0:
; CHECK-NEXT:    movaps (%rsp), %xmm0
; CHECK-NEXT:    addq $24, %rsp
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
entry:
  %safepoint_token = call token (i64, i32, ptr, i32, i32, ...) @llvm.experimental.gc.statepoint.p0(i64 0, i32 0, ptr elementtype(void ()) @do_safepoint, i32 0, i32 0, i32 0, i32 0) ["gc-live" (<2 x ptr addrspace(1)> %obj)]
  %obj.relocated = call coldcc <2 x ptr addrspace(1)> @llvm.experimental.gc.relocate.v2p1(token %safepoint_token, i32 0, i32 0) ; (%obj, %obj)
  ret <2 x ptr addrspace(1)> %obj.relocated
}

; Can we lower the base, derived pairs if both are vectors?
define <2 x ptr addrspace(1)> @test2(<2 x ptr addrspace(1)> %obj, i64 %offset) gc "statepoint-example" {
; CHECK-LABEL: test2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    subq $40, %rsp
; CHECK-NEXT:    .cfi_def_cfa_offset 48
; CHECK-NEXT:    movq %rdi, %xmm1
; CHECK-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[0,1,0,1]
; CHECK-NEXT:    paddq %xmm0, %xmm1
; CHECK-NEXT:    movdqa %xmm0, (%rsp)
; CHECK-NEXT:    movdqa %xmm1, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    callq do_safepoint@PLT
; CHECK-NEXT:  .Ltmp1:
; CHECK-NEXT:    movaps {{[0-9]+}}(%rsp), %xmm0
; CHECK-NEXT:    addq $40, %rsp
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
entry:
  %derived = getelementptr i8, <2 x ptr addrspace(1)> %obj, i64 %offset
  %safepoint_token = call token (i64, i32, ptr, i32, i32, ...) @llvm.experimental.gc.statepoint.p0(i64 0, i32 0, ptr elementtype(void ()) @do_safepoint, i32 0, i32 0, i32 0, i32 0) ["gc-live" (<2 x ptr addrspace(1)> %obj, <2 x ptr addrspace(1)> %derived)]
  %derived.relocated = call coldcc <2 x ptr addrspace(1)> @llvm.experimental.gc.relocate.v2p1(token %safepoint_token, i32 0, i32 1) ; (%obj, %derived)
  ret <2 x ptr addrspace(1)> %derived.relocated
}

; Originally, this was just a variant of @test2 above, but it ends up
; covering a bunch of interesting missed optimizations.  Specifically:
; - We waste a stack slot for a value that a backend transform pass
;   CSEd to another spilled one.
; - We don't remove the testb even though it serves no purpose
; - We could in principal reuse the argument memory (%rsi) and do away
;   with stack slots entirely.
define <2 x ptr addrspace(1)> @test3(i1 %cnd, ptr %ptr) gc "statepoint-example" {
; CHECK-LABEL: test3:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    testb $1, %dil
; CHECK-NEXT:    movaps (%rsi), %xmm0
; CHECK-NEXT:    subq $40, %rsp
; CHECK-NEXT:    .cfi_def_cfa_offset 48
; CHECK-NEXT:    movaps %xmm0, (%rsp)
; CHECK-NEXT:    movaps %xmm0, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    callq do_safepoint@PLT
; CHECK-NEXT:  .Ltmp2:
; CHECK-NEXT:    movaps (%rsp), %xmm0
; CHECK-NEXT:    addq $40, %rsp
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
entry:
  br i1 %cnd, label %taken, label %untaken

taken:                                            ; preds = %entry
  %obja = load <2 x ptr addrspace(1)>, ptr %ptr
  br label %merge

untaken:                                          ; preds = %entry
  %objb = load <2 x ptr addrspace(1)>, ptr %ptr
  br label %merge

merge:                                            ; preds = %untaken, %taken
  %obj.base = phi <2 x ptr addrspace(1)> [ %obja, %taken ], [ %objb, %untaken ]
  %obj = phi <2 x ptr addrspace(1)> [ %obja, %taken ], [ %objb, %untaken ]
  %safepoint_token = call token (i64, i32, ptr, i32, i32, ...) @llvm.experimental.gc.statepoint.p0(i64 0, i32 0, ptr elementtype(void ()) @do_safepoint, i32 0, i32 0, i32 0, i32 0) ["gc-live" (<2 x ptr addrspace(1)> %obj, <2 x ptr addrspace(1)> %obj.base)]
  %obj.relocated = call coldcc <2 x ptr addrspace(1)> @llvm.experimental.gc.relocate.v2p1(token %safepoint_token, i32 1, i32 0) ; (%obj.base, %obj)
  %obj.relocated.casted = bitcast <2 x ptr addrspace(1)> %obj.relocated to <2 x ptr addrspace(1)>
  %obj.base.relocated = call coldcc <2 x ptr addrspace(1)> @llvm.experimental.gc.relocate.v2p1(token %safepoint_token, i32 1, i32 1) ; (%obj.base, %obj.base)
  %obj.base.relocated.casted = bitcast <2 x ptr addrspace(1)> %obj.base.relocated to <2 x ptr addrspace(1)>
  ret <2 x ptr addrspace(1)> %obj.relocated.casted
}

; Can we handle vector constants?  At the moment, we don't appear to actually
; get selection dag nodes for these.
define <2 x ptr addrspace(1)> @test4() gc "statepoint-example" {
; CHECK-LABEL: test4:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    subq $24, %rsp
; CHECK-NEXT:    .cfi_def_cfa_offset 32
; CHECK-NEXT:    xorps %xmm0, %xmm0
; CHECK-NEXT:    movaps %xmm0, (%rsp)
; CHECK-NEXT:    callq do_safepoint@PLT
; CHECK-NEXT:  .Ltmp3:
; CHECK-NEXT:    movaps (%rsp), %xmm0
; CHECK-NEXT:    addq $24, %rsp
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
entry:
  %safepoint_token = call token (i64, i32, ptr, i32, i32, ...) @llvm.experimental.gc.statepoint.p0(i64 0, i32 0, ptr elementtype(void ()) @do_safepoint, i32 0, i32 0, i32 0, i32 0) ["gc-live" (<2 x ptr addrspace(1)> zeroinitializer)]
  %obj.relocated = call coldcc <2 x ptr addrspace(1)> @llvm.experimental.gc.relocate.v2p1(token %safepoint_token, i32 0, i32 0)
  ret <2 x ptr addrspace(1)> %obj.relocated
}

; Check that we can lower a constant typed as i128 correctly.  We don't have
; a representation of larger than 64 bit constant in the StackMap format. At
; the moment, this simply means spilling them, but there's a potential
; optimization for values representable as sext(Con64).
define void @test5() gc "statepoint-example" {
; CHECK-LABEL: test5:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    subq $40, %rsp
; CHECK-NEXT:    .cfi_def_cfa_offset 48
; CHECK-NEXT:    xorps %xmm0, %xmm0
; CHECK-NEXT:    movaps %xmm0, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movq $-1, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movq $-1, (%rsp)
; CHECK-NEXT:    callq do_safepoint@PLT
; CHECK-NEXT:  .Ltmp4:
; CHECK-NEXT:    addq $40, %rsp
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
entry:
  %safepoint_token = call token (i64, i32, ptr, i32, i32, ...) @llvm.experimental.gc.statepoint.p0(i64 0, i32 0, ptr elementtype(void ()) @do_safepoint, i32 0, i32 0, i32 0, i32 0) ["deopt" (i128 0, i128 -1)]
  ret void
}

; CHECK: __LLVM_StackMaps:

; CHECK: .Ltmp0-test
; Check for the two spill slots
; Stack Maps: 		Loc 3: Indirect 7+0	[encoding: .byte 3, .byte 0, .short 16, .short 7, .short 0, .int 0]
; Stack Maps: 		Loc 4: Indirect 7+0	[encoding: .byte 3, .byte 0, .short 16, .short 7, .short 0, .int 0]
; CHECK: .byte	3
; CHECK: .byte	0
; CHECK: .short 16
; CHECK: .short	7
; CHECK: .short	0
; CHECK: .long	0
; CHECK: .byte	3
; CHECK: .byte	0
; CHECK: .short 16
; CHECK: .short	7
; CHECK: .short	0
; CHECK: .long	0

; CHECK: .Ltmp1-test2
; Check for the two spill slots
; Stack Maps: 		Loc 3: Indirect 7+16	[encoding: .byte 3, .byte 0, .short 16, .short 7, .short 0, .int 16]
; Stack Maps: 		Loc 4: Indirect 7+0	[encoding: .byte 3, .byte 0, .short 16, .short 7, .short 0, .int 0]
; CHECK: .byte	3
; CHECK: .byte	0
; CHECK: .short 16
; CHECK: .short	7
; CHECK: .short	0
; CHECK: .long	0
; CHECK: .byte	3
; CHECK: .byte	0
; CHECK: .short 16
; CHECK: .short	7
; CHECK: .short	0
; CHECK: .long	16

; CHECK: .Ltmp2-test3
; Check for the four spill slots
; Stack Maps: 		Loc 3: Indirect 7+16	[encoding: .byte 3, .byte 0, .short 16, .short 7, .short 0, .int 16]
; Stack Maps: 		Loc 4: Indirect 7+16	[encoding: .byte 3, .byte 0, .short 16, .short 7, .short 0, .int 16]
; Stack Maps: 		Loc 5: Indirect 7+16	[encoding: .byte 3, .byte 0, .short 16, .short 7, .short 0, .int 16]
; Stack Maps: 		Loc 6: Indirect 7+0	[encoding: .byte 3, .byte 0, .short 16, .short 7, .short 0, .int 0]
; CHECK: .byte	3
; CHECK: .byte	0
; CHECK: .short 16
; CHECK: .short	7
; CHECK: .short	0
; CHECK: .long	16
; CHECK: .byte	3
; CHECK: .byte	 0
; CHECK: .short 16
; CHECK: .short	7
; CHECK: .short	0
; CHECK: .long	16
; CHECK: .byte	3
; CHECK: .byte	 0
; CHECK: .short 16
; CHECK: .short	7
; CHECK: .short	0
; CHECK: .long	16
; CHECK: .byte	3
; CHECK: .byte	 0
; CHECK: .short 16
; CHECK: .short	7
; CHECK: .short	0
; CHECK: .long	0

declare void @do_safepoint()

declare token @llvm.experimental.gc.statepoint.p0(i64, i32, ptr, i32, i32, ...)
declare ptr addrspace(1) @llvm.experimental.gc.relocate.p1(token, i32, i32)
declare <2 x ptr addrspace(1)> @llvm.experimental.gc.relocate.v2p1(token, i32, i32)
