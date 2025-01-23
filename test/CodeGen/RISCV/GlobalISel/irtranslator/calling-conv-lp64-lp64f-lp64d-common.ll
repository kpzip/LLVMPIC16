; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py UTC_ARGS: --version 3
; RUN: llc -mtriple=riscv64 \
; RUN:    -global-isel -stop-after=irtranslator -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefixes=RV64I,LP64 %s
; RUN: llc -mtriple=riscv64 -mattr=+f -target-abi lp64f \
; RUN:    -global-isel -stop-after=irtranslator -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefixes=RV64I,LP64F %s
; RUN: llc -mtriple=riscv64 -mattr=+d -target-abi lp64d \
; RUN:    -global-isel -stop-after=irtranslator -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefixes=RV64I,LP64D %s

; This file contains tests that should have identical output for the lp64,
; lp64f, and lp64d ABIs. i.e. where no arguments are passed according to
; the floating point ABI.

; Check that on RV64, i128 is passed in a pair of registers. Unlike
; the convention for varargs, this need not be an aligned pair.

define i64 @callee_i128_in_regs(i64 %a, i128 %b) nounwind {
  ; RV64I-LABEL: name: callee_i128_in_regs
  ; RV64I: bb.1 (%ir-block.0):
  ; RV64I-NEXT:   liveins: $x10, $x11, $x12
  ; RV64I-NEXT: {{  $}}
  ; RV64I-NEXT:   [[COPY:%[0-9]+]]:_(s64) = COPY $x10
  ; RV64I-NEXT:   [[COPY1:%[0-9]+]]:_(s64) = COPY $x11
  ; RV64I-NEXT:   [[COPY2:%[0-9]+]]:_(s64) = COPY $x12
  ; RV64I-NEXT:   [[MV:%[0-9]+]]:_(s128) = G_MERGE_VALUES [[COPY1]](s64), [[COPY2]](s64)
  ; RV64I-NEXT:   [[TRUNC:%[0-9]+]]:_(s64) = G_TRUNC [[MV]](s128)
  ; RV64I-NEXT:   [[ADD:%[0-9]+]]:_(s64) = G_ADD [[COPY]], [[TRUNC]]
  ; RV64I-NEXT:   $x10 = COPY [[ADD]](s64)
  ; RV64I-NEXT:   PseudoRET implicit $x10
  %b_trunc = trunc i128 %b to i64
  %1 = add i64 %a, %b_trunc
  ret i64 %1
}

define i64 @caller_i128_in_regs() nounwind {
  ; LP64-LABEL: name: caller_i128_in_regs
  ; LP64: bb.1 (%ir-block.0):
  ; LP64-NEXT:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 1
  ; LP64-NEXT:   [[C1:%[0-9]+]]:_(s128) = G_CONSTANT i128 2
  ; LP64-NEXT:   ADJCALLSTACKDOWN 0, 0, implicit-def $x2, implicit $x2
  ; LP64-NEXT:   [[UV:%[0-9]+]]:_(s64), [[UV1:%[0-9]+]]:_(s64) = G_UNMERGE_VALUES [[C1]](s128)
  ; LP64-NEXT:   $x10 = COPY [[C]](s64)
  ; LP64-NEXT:   $x11 = COPY [[UV]](s64)
  ; LP64-NEXT:   $x12 = COPY [[UV1]](s64)
  ; LP64-NEXT:   PseudoCALL target-flags(riscv-call) @callee_i128_in_regs, csr_ilp32_lp64, implicit-def $x1, implicit $x10, implicit $x11, implicit $x12, implicit-def $x10
  ; LP64-NEXT:   ADJCALLSTACKUP 0, 0, implicit-def $x2, implicit $x2
  ; LP64-NEXT:   [[COPY:%[0-9]+]]:_(s64) = COPY $x10
  ; LP64-NEXT:   $x10 = COPY [[COPY]](s64)
  ; LP64-NEXT:   PseudoRET implicit $x10
  ;
  ; LP64F-LABEL: name: caller_i128_in_regs
  ; LP64F: bb.1 (%ir-block.0):
  ; LP64F-NEXT:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 1
  ; LP64F-NEXT:   [[C1:%[0-9]+]]:_(s128) = G_CONSTANT i128 2
  ; LP64F-NEXT:   ADJCALLSTACKDOWN 0, 0, implicit-def $x2, implicit $x2
  ; LP64F-NEXT:   [[UV:%[0-9]+]]:_(s64), [[UV1:%[0-9]+]]:_(s64) = G_UNMERGE_VALUES [[C1]](s128)
  ; LP64F-NEXT:   $x10 = COPY [[C]](s64)
  ; LP64F-NEXT:   $x11 = COPY [[UV]](s64)
  ; LP64F-NEXT:   $x12 = COPY [[UV1]](s64)
  ; LP64F-NEXT:   PseudoCALL target-flags(riscv-call) @callee_i128_in_regs, csr_ilp32f_lp64f, implicit-def $x1, implicit $x10, implicit $x11, implicit $x12, implicit-def $x10
  ; LP64F-NEXT:   ADJCALLSTACKUP 0, 0, implicit-def $x2, implicit $x2
  ; LP64F-NEXT:   [[COPY:%[0-9]+]]:_(s64) = COPY $x10
  ; LP64F-NEXT:   $x10 = COPY [[COPY]](s64)
  ; LP64F-NEXT:   PseudoRET implicit $x10
  ;
  ; LP64D-LABEL: name: caller_i128_in_regs
  ; LP64D: bb.1 (%ir-block.0):
  ; LP64D-NEXT:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 1
  ; LP64D-NEXT:   [[C1:%[0-9]+]]:_(s128) = G_CONSTANT i128 2
  ; LP64D-NEXT:   ADJCALLSTACKDOWN 0, 0, implicit-def $x2, implicit $x2
  ; LP64D-NEXT:   [[UV:%[0-9]+]]:_(s64), [[UV1:%[0-9]+]]:_(s64) = G_UNMERGE_VALUES [[C1]](s128)
  ; LP64D-NEXT:   $x10 = COPY [[C]](s64)
  ; LP64D-NEXT:   $x11 = COPY [[UV]](s64)
  ; LP64D-NEXT:   $x12 = COPY [[UV1]](s64)
  ; LP64D-NEXT:   PseudoCALL target-flags(riscv-call) @callee_i128_in_regs, csr_ilp32d_lp64d, implicit-def $x1, implicit $x10, implicit $x11, implicit $x12, implicit-def $x10
  ; LP64D-NEXT:   ADJCALLSTACKUP 0, 0, implicit-def $x2, implicit $x2
  ; LP64D-NEXT:   [[COPY:%[0-9]+]]:_(s64) = COPY $x10
  ; LP64D-NEXT:   $x10 = COPY [[COPY]](s64)
  ; LP64D-NEXT:   PseudoRET implicit $x10
  %1 = call i64 @callee_i128_in_regs(i64 1, i128 2)
  ret i64 %1
}

; Check the correct handling of passing of values that are larger that 2*XLen.

define i32 @caller_i256_indirect_reference_in_stack() {
  ; LP64-LABEL: name: caller_i256_indirect_reference_in_stack
  ; LP64: bb.1 (%ir-block.0):
  ; LP64-NEXT:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 1
  ; LP64-NEXT:   [[C1:%[0-9]+]]:_(s64) = G_CONSTANT i64 2
  ; LP64-NEXT:   [[C2:%[0-9]+]]:_(s64) = G_CONSTANT i64 3
  ; LP64-NEXT:   [[C3:%[0-9]+]]:_(s64) = G_CONSTANT i64 4
  ; LP64-NEXT:   [[C4:%[0-9]+]]:_(s64) = G_CONSTANT i64 5
  ; LP64-NEXT:   [[C5:%[0-9]+]]:_(s64) = G_CONSTANT i64 6
  ; LP64-NEXT:   [[C6:%[0-9]+]]:_(s64) = G_CONSTANT i64 7
  ; LP64-NEXT:   [[C7:%[0-9]+]]:_(s64) = G_CONSTANT i64 8
  ; LP64-NEXT:   [[C8:%[0-9]+]]:_(s256) = G_CONSTANT i256 42
  ; LP64-NEXT:   ADJCALLSTACKDOWN 8, 0, implicit-def $x2, implicit $x2
  ; LP64-NEXT:   [[FRAME_INDEX:%[0-9]+]]:_(p0) = G_FRAME_INDEX %stack.0
  ; LP64-NEXT:   G_STORE [[C8]](s256), [[FRAME_INDEX]](p0) :: (store (s256) into %stack.0, align 16)
  ; LP64-NEXT:   [[COPY:%[0-9]+]]:_(p0) = COPY $x2
  ; LP64-NEXT:   [[C9:%[0-9]+]]:_(s64) = G_CONSTANT i64 0
  ; LP64-NEXT:   [[PTR_ADD:%[0-9]+]]:_(p0) = G_PTR_ADD [[COPY]], [[C9]](s64)
  ; LP64-NEXT:   G_STORE [[FRAME_INDEX]](p0), [[PTR_ADD]](p0) :: (store (p0) into stack, align 16)
  ; LP64-NEXT:   $x10 = COPY [[C]](s64)
  ; LP64-NEXT:   $x11 = COPY [[C1]](s64)
  ; LP64-NEXT:   $x12 = COPY [[C2]](s64)
  ; LP64-NEXT:   $x13 = COPY [[C3]](s64)
  ; LP64-NEXT:   $x14 = COPY [[C4]](s64)
  ; LP64-NEXT:   $x15 = COPY [[C5]](s64)
  ; LP64-NEXT:   $x16 = COPY [[C6]](s64)
  ; LP64-NEXT:   $x17 = COPY [[C7]](s64)
  ; LP64-NEXT:   PseudoCALL target-flags(riscv-call) @callee_i256_indirect_reference_in_stack, csr_ilp32_lp64, implicit-def $x1, implicit $x10, implicit $x11, implicit $x12, implicit $x13, implicit $x14, implicit $x15, implicit $x16, implicit $x17, implicit-def $x10
  ; LP64-NEXT:   ADJCALLSTACKUP 8, 0, implicit-def $x2, implicit $x2
  ; LP64-NEXT:   [[COPY1:%[0-9]+]]:_(s64) = COPY $x10
  ; LP64-NEXT:   [[TRUNC:%[0-9]+]]:_(s32) = G_TRUNC [[COPY1]](s64)
  ; LP64-NEXT:   [[ANYEXT:%[0-9]+]]:_(s64) = G_ANYEXT [[TRUNC]](s32)
  ; LP64-NEXT:   $x10 = COPY [[ANYEXT]](s64)
  ; LP64-NEXT:   PseudoRET implicit $x10
  ;
  ; LP64F-LABEL: name: caller_i256_indirect_reference_in_stack
  ; LP64F: bb.1 (%ir-block.0):
  ; LP64F-NEXT:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 1
  ; LP64F-NEXT:   [[C1:%[0-9]+]]:_(s64) = G_CONSTANT i64 2
  ; LP64F-NEXT:   [[C2:%[0-9]+]]:_(s64) = G_CONSTANT i64 3
  ; LP64F-NEXT:   [[C3:%[0-9]+]]:_(s64) = G_CONSTANT i64 4
  ; LP64F-NEXT:   [[C4:%[0-9]+]]:_(s64) = G_CONSTANT i64 5
  ; LP64F-NEXT:   [[C5:%[0-9]+]]:_(s64) = G_CONSTANT i64 6
  ; LP64F-NEXT:   [[C6:%[0-9]+]]:_(s64) = G_CONSTANT i64 7
  ; LP64F-NEXT:   [[C7:%[0-9]+]]:_(s64) = G_CONSTANT i64 8
  ; LP64F-NEXT:   [[C8:%[0-9]+]]:_(s256) = G_CONSTANT i256 42
  ; LP64F-NEXT:   ADJCALLSTACKDOWN 8, 0, implicit-def $x2, implicit $x2
  ; LP64F-NEXT:   [[FRAME_INDEX:%[0-9]+]]:_(p0) = G_FRAME_INDEX %stack.0
  ; LP64F-NEXT:   G_STORE [[C8]](s256), [[FRAME_INDEX]](p0) :: (store (s256) into %stack.0, align 16)
  ; LP64F-NEXT:   [[COPY:%[0-9]+]]:_(p0) = COPY $x2
  ; LP64F-NEXT:   [[C9:%[0-9]+]]:_(s64) = G_CONSTANT i64 0
  ; LP64F-NEXT:   [[PTR_ADD:%[0-9]+]]:_(p0) = G_PTR_ADD [[COPY]], [[C9]](s64)
  ; LP64F-NEXT:   G_STORE [[FRAME_INDEX]](p0), [[PTR_ADD]](p0) :: (store (p0) into stack, align 16)
  ; LP64F-NEXT:   $x10 = COPY [[C]](s64)
  ; LP64F-NEXT:   $x11 = COPY [[C1]](s64)
  ; LP64F-NEXT:   $x12 = COPY [[C2]](s64)
  ; LP64F-NEXT:   $x13 = COPY [[C3]](s64)
  ; LP64F-NEXT:   $x14 = COPY [[C4]](s64)
  ; LP64F-NEXT:   $x15 = COPY [[C5]](s64)
  ; LP64F-NEXT:   $x16 = COPY [[C6]](s64)
  ; LP64F-NEXT:   $x17 = COPY [[C7]](s64)
  ; LP64F-NEXT:   PseudoCALL target-flags(riscv-call) @callee_i256_indirect_reference_in_stack, csr_ilp32f_lp64f, implicit-def $x1, implicit $x10, implicit $x11, implicit $x12, implicit $x13, implicit $x14, implicit $x15, implicit $x16, implicit $x17, implicit-def $x10
  ; LP64F-NEXT:   ADJCALLSTACKUP 8, 0, implicit-def $x2, implicit $x2
  ; LP64F-NEXT:   [[COPY1:%[0-9]+]]:_(s64) = COPY $x10
  ; LP64F-NEXT:   [[TRUNC:%[0-9]+]]:_(s32) = G_TRUNC [[COPY1]](s64)
  ; LP64F-NEXT:   [[ANYEXT:%[0-9]+]]:_(s64) = G_ANYEXT [[TRUNC]](s32)
  ; LP64F-NEXT:   $x10 = COPY [[ANYEXT]](s64)
  ; LP64F-NEXT:   PseudoRET implicit $x10
  ;
  ; LP64D-LABEL: name: caller_i256_indirect_reference_in_stack
  ; LP64D: bb.1 (%ir-block.0):
  ; LP64D-NEXT:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 1
  ; LP64D-NEXT:   [[C1:%[0-9]+]]:_(s64) = G_CONSTANT i64 2
  ; LP64D-NEXT:   [[C2:%[0-9]+]]:_(s64) = G_CONSTANT i64 3
  ; LP64D-NEXT:   [[C3:%[0-9]+]]:_(s64) = G_CONSTANT i64 4
  ; LP64D-NEXT:   [[C4:%[0-9]+]]:_(s64) = G_CONSTANT i64 5
  ; LP64D-NEXT:   [[C5:%[0-9]+]]:_(s64) = G_CONSTANT i64 6
  ; LP64D-NEXT:   [[C6:%[0-9]+]]:_(s64) = G_CONSTANT i64 7
  ; LP64D-NEXT:   [[C7:%[0-9]+]]:_(s64) = G_CONSTANT i64 8
  ; LP64D-NEXT:   [[C8:%[0-9]+]]:_(s256) = G_CONSTANT i256 42
  ; LP64D-NEXT:   ADJCALLSTACKDOWN 8, 0, implicit-def $x2, implicit $x2
  ; LP64D-NEXT:   [[FRAME_INDEX:%[0-9]+]]:_(p0) = G_FRAME_INDEX %stack.0
  ; LP64D-NEXT:   G_STORE [[C8]](s256), [[FRAME_INDEX]](p0) :: (store (s256) into %stack.0, align 16)
  ; LP64D-NEXT:   [[COPY:%[0-9]+]]:_(p0) = COPY $x2
  ; LP64D-NEXT:   [[C9:%[0-9]+]]:_(s64) = G_CONSTANT i64 0
  ; LP64D-NEXT:   [[PTR_ADD:%[0-9]+]]:_(p0) = G_PTR_ADD [[COPY]], [[C9]](s64)
  ; LP64D-NEXT:   G_STORE [[FRAME_INDEX]](p0), [[PTR_ADD]](p0) :: (store (p0) into stack, align 16)
  ; LP64D-NEXT:   $x10 = COPY [[C]](s64)
  ; LP64D-NEXT:   $x11 = COPY [[C1]](s64)
  ; LP64D-NEXT:   $x12 = COPY [[C2]](s64)
  ; LP64D-NEXT:   $x13 = COPY [[C3]](s64)
  ; LP64D-NEXT:   $x14 = COPY [[C4]](s64)
  ; LP64D-NEXT:   $x15 = COPY [[C5]](s64)
  ; LP64D-NEXT:   $x16 = COPY [[C6]](s64)
  ; LP64D-NEXT:   $x17 = COPY [[C7]](s64)
  ; LP64D-NEXT:   PseudoCALL target-flags(riscv-call) @callee_i256_indirect_reference_in_stack, csr_ilp32d_lp64d, implicit-def $x1, implicit $x10, implicit $x11, implicit $x12, implicit $x13, implicit $x14, implicit $x15, implicit $x16, implicit $x17, implicit-def $x10
  ; LP64D-NEXT:   ADJCALLSTACKUP 8, 0, implicit-def $x2, implicit $x2
  ; LP64D-NEXT:   [[COPY1:%[0-9]+]]:_(s64) = COPY $x10
  ; LP64D-NEXT:   [[TRUNC:%[0-9]+]]:_(s32) = G_TRUNC [[COPY1]](s64)
  ; LP64D-NEXT:   [[ANYEXT:%[0-9]+]]:_(s64) = G_ANYEXT [[TRUNC]](s32)
  ; LP64D-NEXT:   $x10 = COPY [[ANYEXT]](s64)
  ; LP64D-NEXT:   PseudoRET implicit $x10
  %1 = call i64 @callee_i256_indirect_reference_in_stack(i64 1, i64 2, i64 3, i64 4,i64 5,i64 6,i64 7,i64 8, i256 42)
  %2 = trunc i64 %1 to i32
  ret i32 %2
}


define i64 @callee_i256_indirect_reference_in_stack(i64 %x1, i64 %x2, i64 %x3, i64 %x4, i64 %x5, i64 %x6, i64 %x7, i64 %x8, i256 %y) {
  ; RV64I-LABEL: name: callee_i256_indirect_reference_in_stack
  ; RV64I: bb.1 (%ir-block.0):
  ; RV64I-NEXT:   liveins: $x10, $x11, $x12, $x13, $x14, $x15, $x16, $x17
  ; RV64I-NEXT: {{  $}}
  ; RV64I-NEXT:   [[COPY:%[0-9]+]]:_(s64) = COPY $x10
  ; RV64I-NEXT:   [[COPY1:%[0-9]+]]:_(s64) = COPY $x11
  ; RV64I-NEXT:   [[COPY2:%[0-9]+]]:_(s64) = COPY $x12
  ; RV64I-NEXT:   [[COPY3:%[0-9]+]]:_(s64) = COPY $x13
  ; RV64I-NEXT:   [[COPY4:%[0-9]+]]:_(s64) = COPY $x14
  ; RV64I-NEXT:   [[COPY5:%[0-9]+]]:_(s64) = COPY $x15
  ; RV64I-NEXT:   [[COPY6:%[0-9]+]]:_(s64) = COPY $x16
  ; RV64I-NEXT:   [[COPY7:%[0-9]+]]:_(s64) = COPY $x17
  ; RV64I-NEXT:   [[FRAME_INDEX:%[0-9]+]]:_(p0) = G_FRAME_INDEX %fixed-stack.0
  ; RV64I-NEXT:   [[LOAD:%[0-9]+]]:_(p0) = G_LOAD [[FRAME_INDEX]](p0) :: (load (p0) from %fixed-stack.0, align 16)
  ; RV64I-NEXT:   [[LOAD1:%[0-9]+]]:_(s256) = G_LOAD [[LOAD]](p0) :: (load (s256), align 16)
  ; RV64I-NEXT:   [[TRUNC:%[0-9]+]]:_(s64) = G_TRUNC [[LOAD1]](s256)
  ; RV64I-NEXT:   $x10 = COPY [[TRUNC]](s64)
  ; RV64I-NEXT:   PseudoRET implicit $x10
  %2 = trunc i256 %y to i64
  ret i64 %2
}


define i64 @callee_i256_indirect_reference_in_reg(i256 %x, i256 %y) {
  ; RV64I-LABEL: name: callee_i256_indirect_reference_in_reg
  ; RV64I: bb.1 (%ir-block.0):
  ; RV64I-NEXT:   liveins: $x10, $x11
  ; RV64I-NEXT: {{  $}}
  ; RV64I-NEXT:   [[COPY:%[0-9]+]]:_(p0) = COPY $x10
  ; RV64I-NEXT:   [[LOAD:%[0-9]+]]:_(s256) = G_LOAD [[COPY]](p0) :: (load (s256), align 16)
  ; RV64I-NEXT:   [[COPY1:%[0-9]+]]:_(p0) = COPY $x11
  ; RV64I-NEXT:   [[LOAD1:%[0-9]+]]:_(s256) = G_LOAD [[COPY1]](p0) :: (load (s256), align 16)
  ; RV64I-NEXT:   [[ADD:%[0-9]+]]:_(s256) = G_ADD [[LOAD]], [[LOAD1]]
  ; RV64I-NEXT:   [[TRUNC:%[0-9]+]]:_(s64) = G_TRUNC [[ADD]](s256)
  ; RV64I-NEXT:   $x10 = COPY [[TRUNC]](s64)
  ; RV64I-NEXT:   PseudoRET implicit $x10
  %1 = add i256 %x, %y
  %2 = trunc i256 %1 to i64
  ret i64 %2
}

define i32 @caller_i256_indirect_reference_in_reg() {
  ; LP64-LABEL: name: caller_i256_indirect_reference_in_reg
  ; LP64: bb.1 (%ir-block.0):
  ; LP64-NEXT:   [[C:%[0-9]+]]:_(s256) = G_CONSTANT i256 1
  ; LP64-NEXT:   [[C1:%[0-9]+]]:_(s256) = G_CONSTANT i256 2
  ; LP64-NEXT:   ADJCALLSTACKDOWN 0, 0, implicit-def $x2, implicit $x2
  ; LP64-NEXT:   [[FRAME_INDEX:%[0-9]+]]:_(p0) = G_FRAME_INDEX %stack.0
  ; LP64-NEXT:   G_STORE [[C]](s256), [[FRAME_INDEX]](p0) :: (store (s256) into %stack.0, align 16)
  ; LP64-NEXT:   [[FRAME_INDEX1:%[0-9]+]]:_(p0) = G_FRAME_INDEX %stack.1
  ; LP64-NEXT:   G_STORE [[C1]](s256), [[FRAME_INDEX1]](p0) :: (store (s256) into %stack.1, align 16)
  ; LP64-NEXT:   $x10 = COPY [[FRAME_INDEX]](p0)
  ; LP64-NEXT:   $x11 = COPY [[FRAME_INDEX1]](p0)
  ; LP64-NEXT:   PseudoCALL target-flags(riscv-call) @callee_i256_indirect_reference_in_reg, csr_ilp32_lp64, implicit-def $x1, implicit $x10, implicit $x11, implicit-def $x10
  ; LP64-NEXT:   ADJCALLSTACKUP 0, 0, implicit-def $x2, implicit $x2
  ; LP64-NEXT:   [[COPY:%[0-9]+]]:_(s64) = COPY $x10
  ; LP64-NEXT:   [[TRUNC:%[0-9]+]]:_(s32) = G_TRUNC [[COPY]](s64)
  ; LP64-NEXT:   [[ANYEXT:%[0-9]+]]:_(s64) = G_ANYEXT [[TRUNC]](s32)
  ; LP64-NEXT:   $x10 = COPY [[ANYEXT]](s64)
  ; LP64-NEXT:   PseudoRET implicit $x10
  ;
  ; LP64F-LABEL: name: caller_i256_indirect_reference_in_reg
  ; LP64F: bb.1 (%ir-block.0):
  ; LP64F-NEXT:   [[C:%[0-9]+]]:_(s256) = G_CONSTANT i256 1
  ; LP64F-NEXT:   [[C1:%[0-9]+]]:_(s256) = G_CONSTANT i256 2
  ; LP64F-NEXT:   ADJCALLSTACKDOWN 0, 0, implicit-def $x2, implicit $x2
  ; LP64F-NEXT:   [[FRAME_INDEX:%[0-9]+]]:_(p0) = G_FRAME_INDEX %stack.0
  ; LP64F-NEXT:   G_STORE [[C]](s256), [[FRAME_INDEX]](p0) :: (store (s256) into %stack.0, align 16)
  ; LP64F-NEXT:   [[FRAME_INDEX1:%[0-9]+]]:_(p0) = G_FRAME_INDEX %stack.1
  ; LP64F-NEXT:   G_STORE [[C1]](s256), [[FRAME_INDEX1]](p0) :: (store (s256) into %stack.1, align 16)
  ; LP64F-NEXT:   $x10 = COPY [[FRAME_INDEX]](p0)
  ; LP64F-NEXT:   $x11 = COPY [[FRAME_INDEX1]](p0)
  ; LP64F-NEXT:   PseudoCALL target-flags(riscv-call) @callee_i256_indirect_reference_in_reg, csr_ilp32f_lp64f, implicit-def $x1, implicit $x10, implicit $x11, implicit-def $x10
  ; LP64F-NEXT:   ADJCALLSTACKUP 0, 0, implicit-def $x2, implicit $x2
  ; LP64F-NEXT:   [[COPY:%[0-9]+]]:_(s64) = COPY $x10
  ; LP64F-NEXT:   [[TRUNC:%[0-9]+]]:_(s32) = G_TRUNC [[COPY]](s64)
  ; LP64F-NEXT:   [[ANYEXT:%[0-9]+]]:_(s64) = G_ANYEXT [[TRUNC]](s32)
  ; LP64F-NEXT:   $x10 = COPY [[ANYEXT]](s64)
  ; LP64F-NEXT:   PseudoRET implicit $x10
  ;
  ; LP64D-LABEL: name: caller_i256_indirect_reference_in_reg
  ; LP64D: bb.1 (%ir-block.0):
  ; LP64D-NEXT:   [[C:%[0-9]+]]:_(s256) = G_CONSTANT i256 1
  ; LP64D-NEXT:   [[C1:%[0-9]+]]:_(s256) = G_CONSTANT i256 2
  ; LP64D-NEXT:   ADJCALLSTACKDOWN 0, 0, implicit-def $x2, implicit $x2
  ; LP64D-NEXT:   [[FRAME_INDEX:%[0-9]+]]:_(p0) = G_FRAME_INDEX %stack.0
  ; LP64D-NEXT:   G_STORE [[C]](s256), [[FRAME_INDEX]](p0) :: (store (s256) into %stack.0, align 16)
  ; LP64D-NEXT:   [[FRAME_INDEX1:%[0-9]+]]:_(p0) = G_FRAME_INDEX %stack.1
  ; LP64D-NEXT:   G_STORE [[C1]](s256), [[FRAME_INDEX1]](p0) :: (store (s256) into %stack.1, align 16)
  ; LP64D-NEXT:   $x10 = COPY [[FRAME_INDEX]](p0)
  ; LP64D-NEXT:   $x11 = COPY [[FRAME_INDEX1]](p0)
  ; LP64D-NEXT:   PseudoCALL target-flags(riscv-call) @callee_i256_indirect_reference_in_reg, csr_ilp32d_lp64d, implicit-def $x1, implicit $x10, implicit $x11, implicit-def $x10
  ; LP64D-NEXT:   ADJCALLSTACKUP 0, 0, implicit-def $x2, implicit $x2
  ; LP64D-NEXT:   [[COPY:%[0-9]+]]:_(s64) = COPY $x10
  ; LP64D-NEXT:   [[TRUNC:%[0-9]+]]:_(s32) = G_TRUNC [[COPY]](s64)
  ; LP64D-NEXT:   [[ANYEXT:%[0-9]+]]:_(s64) = G_ANYEXT [[TRUNC]](s32)
  ; LP64D-NEXT:   $x10 = COPY [[ANYEXT]](s64)
  ; LP64D-NEXT:   PseudoRET implicit $x10
  %1 = call i64 @callee_i256_indirect_reference_in_reg(i256 1, i256 2)
  %2 = trunc i64 %1 to i32
  ret i32 %2
}

; Check that the stack is used once the GPRs are exhausted

define i32 @callee_many_scalars(i8 %a, i16 %b, i32 %c, i128 %d, i32 %e, i32 %f, i128 %g, i32 %h) nounwind {
  ; RV64I-LABEL: name: callee_many_scalars
  ; RV64I: bb.1 (%ir-block.0):
  ; RV64I-NEXT:   liveins: $x10, $x11, $x12, $x13, $x14, $x15, $x16, $x17
  ; RV64I-NEXT: {{  $}}
  ; RV64I-NEXT:   [[COPY:%[0-9]+]]:_(s64) = COPY $x10
  ; RV64I-NEXT:   [[TRUNC:%[0-9]+]]:_(s8) = G_TRUNC [[COPY]](s64)
  ; RV64I-NEXT:   [[COPY1:%[0-9]+]]:_(s64) = COPY $x11
  ; RV64I-NEXT:   [[TRUNC1:%[0-9]+]]:_(s16) = G_TRUNC [[COPY1]](s64)
  ; RV64I-NEXT:   [[COPY2:%[0-9]+]]:_(s64) = COPY $x12
  ; RV64I-NEXT:   [[TRUNC2:%[0-9]+]]:_(s32) = G_TRUNC [[COPY2]](s64)
  ; RV64I-NEXT:   [[COPY3:%[0-9]+]]:_(s64) = COPY $x13
  ; RV64I-NEXT:   [[COPY4:%[0-9]+]]:_(s64) = COPY $x14
  ; RV64I-NEXT:   [[MV:%[0-9]+]]:_(s128) = G_MERGE_VALUES [[COPY3]](s64), [[COPY4]](s64)
  ; RV64I-NEXT:   [[COPY5:%[0-9]+]]:_(s64) = COPY $x15
  ; RV64I-NEXT:   [[TRUNC3:%[0-9]+]]:_(s32) = G_TRUNC [[COPY5]](s64)
  ; RV64I-NEXT:   [[COPY6:%[0-9]+]]:_(s64) = COPY $x16
  ; RV64I-NEXT:   [[TRUNC4:%[0-9]+]]:_(s32) = G_TRUNC [[COPY6]](s64)
  ; RV64I-NEXT:   [[COPY7:%[0-9]+]]:_(s64) = COPY $x17
  ; RV64I-NEXT:   [[FRAME_INDEX:%[0-9]+]]:_(p0) = G_FRAME_INDEX %fixed-stack.1
  ; RV64I-NEXT:   [[LOAD:%[0-9]+]]:_(s64) = G_LOAD [[FRAME_INDEX]](p0) :: (load (s64) from %fixed-stack.1, align 16)
  ; RV64I-NEXT:   [[MV1:%[0-9]+]]:_(s128) = G_MERGE_VALUES [[COPY7]](s64), [[LOAD]](s64)
  ; RV64I-NEXT:   [[FRAME_INDEX1:%[0-9]+]]:_(p0) = G_FRAME_INDEX %fixed-stack.0
  ; RV64I-NEXT:   [[LOAD1:%[0-9]+]]:_(s64) = G_LOAD [[FRAME_INDEX1]](p0) :: (load (s64) from %fixed-stack.0)
  ; RV64I-NEXT:   [[TRUNC5:%[0-9]+]]:_(s32) = G_TRUNC [[LOAD1]](s64)
  ; RV64I-NEXT:   [[ZEXT:%[0-9]+]]:_(s32) = G_ZEXT [[TRUNC]](s8)
  ; RV64I-NEXT:   [[ZEXT1:%[0-9]+]]:_(s32) = G_ZEXT [[TRUNC1]](s16)
  ; RV64I-NEXT:   [[ADD:%[0-9]+]]:_(s32) = G_ADD [[ZEXT]], [[ZEXT1]]
  ; RV64I-NEXT:   [[ADD1:%[0-9]+]]:_(s32) = G_ADD [[ADD]], [[TRUNC2]]
  ; RV64I-NEXT:   [[ICMP:%[0-9]+]]:_(s1) = G_ICMP intpred(eq), [[MV]](s128), [[MV1]]
  ; RV64I-NEXT:   [[ZEXT2:%[0-9]+]]:_(s32) = G_ZEXT [[ICMP]](s1)
  ; RV64I-NEXT:   [[ADD2:%[0-9]+]]:_(s32) = G_ADD [[ZEXT2]], [[ADD1]]
  ; RV64I-NEXT:   [[ADD3:%[0-9]+]]:_(s32) = G_ADD [[ADD2]], [[TRUNC3]]
  ; RV64I-NEXT:   [[ADD4:%[0-9]+]]:_(s32) = G_ADD [[ADD3]], [[TRUNC4]]
  ; RV64I-NEXT:   [[ADD5:%[0-9]+]]:_(s32) = G_ADD [[ADD4]], [[TRUNC5]]
  ; RV64I-NEXT:   [[ANYEXT:%[0-9]+]]:_(s64) = G_ANYEXT [[ADD5]](s32)
  ; RV64I-NEXT:   $x10 = COPY [[ANYEXT]](s64)
  ; RV64I-NEXT:   PseudoRET implicit $x10
  %a_ext = zext i8 %a to i32
  %b_ext = zext i16 %b to i32
  %1 = add i32 %a_ext, %b_ext
  %2 = add i32 %1, %c
  %3 = icmp eq i128 %d, %g
  %4 = zext i1 %3 to i32
  %5 = add i32 %4, %2
  %6 = add i32 %5, %e
  %7 = add i32 %6, %f
  %8 = add i32 %7, %h
  ret i32 %8
}

define i32 @caller_many_scalars() nounwind {
  ; LP64-LABEL: name: caller_many_scalars
  ; LP64: bb.1 (%ir-block.0):
  ; LP64-NEXT:   [[C:%[0-9]+]]:_(s8) = G_CONSTANT i8 1
  ; LP64-NEXT:   [[C1:%[0-9]+]]:_(s16) = G_CONSTANT i16 2
  ; LP64-NEXT:   [[C2:%[0-9]+]]:_(s32) = G_CONSTANT i32 3
  ; LP64-NEXT:   [[C3:%[0-9]+]]:_(s128) = G_CONSTANT i128 4
  ; LP64-NEXT:   [[C4:%[0-9]+]]:_(s32) = G_CONSTANT i32 5
  ; LP64-NEXT:   [[C5:%[0-9]+]]:_(s32) = G_CONSTANT i32 6
  ; LP64-NEXT:   [[C6:%[0-9]+]]:_(s128) = G_CONSTANT i128 7
  ; LP64-NEXT:   [[C7:%[0-9]+]]:_(s32) = G_CONSTANT i32 8
  ; LP64-NEXT:   ADJCALLSTACKDOWN 16, 0, implicit-def $x2, implicit $x2
  ; LP64-NEXT:   [[ANYEXT:%[0-9]+]]:_(s64) = G_ANYEXT [[C]](s8)
  ; LP64-NEXT:   [[ANYEXT1:%[0-9]+]]:_(s64) = G_ANYEXT [[C1]](s16)
  ; LP64-NEXT:   [[ANYEXT2:%[0-9]+]]:_(s64) = G_ANYEXT [[C2]](s32)
  ; LP64-NEXT:   [[UV:%[0-9]+]]:_(s64), [[UV1:%[0-9]+]]:_(s64) = G_UNMERGE_VALUES [[C3]](s128)
  ; LP64-NEXT:   [[ANYEXT3:%[0-9]+]]:_(s64) = G_ANYEXT [[C4]](s32)
  ; LP64-NEXT:   [[ANYEXT4:%[0-9]+]]:_(s64) = G_ANYEXT [[C5]](s32)
  ; LP64-NEXT:   [[UV2:%[0-9]+]]:_(s64), [[UV3:%[0-9]+]]:_(s64) = G_UNMERGE_VALUES [[C6]](s128)
  ; LP64-NEXT:   [[COPY:%[0-9]+]]:_(p0) = COPY $x2
  ; LP64-NEXT:   [[C8:%[0-9]+]]:_(s64) = G_CONSTANT i64 0
  ; LP64-NEXT:   [[PTR_ADD:%[0-9]+]]:_(p0) = G_PTR_ADD [[COPY]], [[C8]](s64)
  ; LP64-NEXT:   G_STORE [[UV3]](s64), [[PTR_ADD]](p0) :: (store (s64) into stack, align 16)
  ; LP64-NEXT:   [[ANYEXT5:%[0-9]+]]:_(s64) = G_ANYEXT [[C7]](s32)
  ; LP64-NEXT:   [[C9:%[0-9]+]]:_(s64) = G_CONSTANT i64 8
  ; LP64-NEXT:   [[PTR_ADD1:%[0-9]+]]:_(p0) = G_PTR_ADD [[COPY]], [[C9]](s64)
  ; LP64-NEXT:   G_STORE [[ANYEXT5]](s64), [[PTR_ADD1]](p0) :: (store (s64) into stack + 8)
  ; LP64-NEXT:   $x10 = COPY [[ANYEXT]](s64)
  ; LP64-NEXT:   $x11 = COPY [[ANYEXT1]](s64)
  ; LP64-NEXT:   $x12 = COPY [[ANYEXT2]](s64)
  ; LP64-NEXT:   $x13 = COPY [[UV]](s64)
  ; LP64-NEXT:   $x14 = COPY [[UV1]](s64)
  ; LP64-NEXT:   $x15 = COPY [[ANYEXT3]](s64)
  ; LP64-NEXT:   $x16 = COPY [[ANYEXT4]](s64)
  ; LP64-NEXT:   $x17 = COPY [[UV2]](s64)
  ; LP64-NEXT:   PseudoCALL target-flags(riscv-call) @callee_many_scalars, csr_ilp32_lp64, implicit-def $x1, implicit $x10, implicit $x11, implicit $x12, implicit $x13, implicit $x14, implicit $x15, implicit $x16, implicit $x17, implicit-def $x10
  ; LP64-NEXT:   ADJCALLSTACKUP 16, 0, implicit-def $x2, implicit $x2
  ; LP64-NEXT:   [[COPY1:%[0-9]+]]:_(s64) = COPY $x10
  ; LP64-NEXT:   [[TRUNC:%[0-9]+]]:_(s32) = G_TRUNC [[COPY1]](s64)
  ; LP64-NEXT:   [[ANYEXT6:%[0-9]+]]:_(s64) = G_ANYEXT [[TRUNC]](s32)
  ; LP64-NEXT:   $x10 = COPY [[ANYEXT6]](s64)
  ; LP64-NEXT:   PseudoRET implicit $x10
  ;
  ; LP64F-LABEL: name: caller_many_scalars
  ; LP64F: bb.1 (%ir-block.0):
  ; LP64F-NEXT:   [[C:%[0-9]+]]:_(s8) = G_CONSTANT i8 1
  ; LP64F-NEXT:   [[C1:%[0-9]+]]:_(s16) = G_CONSTANT i16 2
  ; LP64F-NEXT:   [[C2:%[0-9]+]]:_(s32) = G_CONSTANT i32 3
  ; LP64F-NEXT:   [[C3:%[0-9]+]]:_(s128) = G_CONSTANT i128 4
  ; LP64F-NEXT:   [[C4:%[0-9]+]]:_(s32) = G_CONSTANT i32 5
  ; LP64F-NEXT:   [[C5:%[0-9]+]]:_(s32) = G_CONSTANT i32 6
  ; LP64F-NEXT:   [[C6:%[0-9]+]]:_(s128) = G_CONSTANT i128 7
  ; LP64F-NEXT:   [[C7:%[0-9]+]]:_(s32) = G_CONSTANT i32 8
  ; LP64F-NEXT:   ADJCALLSTACKDOWN 16, 0, implicit-def $x2, implicit $x2
  ; LP64F-NEXT:   [[ANYEXT:%[0-9]+]]:_(s64) = G_ANYEXT [[C]](s8)
  ; LP64F-NEXT:   [[ANYEXT1:%[0-9]+]]:_(s64) = G_ANYEXT [[C1]](s16)
  ; LP64F-NEXT:   [[ANYEXT2:%[0-9]+]]:_(s64) = G_ANYEXT [[C2]](s32)
  ; LP64F-NEXT:   [[UV:%[0-9]+]]:_(s64), [[UV1:%[0-9]+]]:_(s64) = G_UNMERGE_VALUES [[C3]](s128)
  ; LP64F-NEXT:   [[ANYEXT3:%[0-9]+]]:_(s64) = G_ANYEXT [[C4]](s32)
  ; LP64F-NEXT:   [[ANYEXT4:%[0-9]+]]:_(s64) = G_ANYEXT [[C5]](s32)
  ; LP64F-NEXT:   [[UV2:%[0-9]+]]:_(s64), [[UV3:%[0-9]+]]:_(s64) = G_UNMERGE_VALUES [[C6]](s128)
  ; LP64F-NEXT:   [[COPY:%[0-9]+]]:_(p0) = COPY $x2
  ; LP64F-NEXT:   [[C8:%[0-9]+]]:_(s64) = G_CONSTANT i64 0
  ; LP64F-NEXT:   [[PTR_ADD:%[0-9]+]]:_(p0) = G_PTR_ADD [[COPY]], [[C8]](s64)
  ; LP64F-NEXT:   G_STORE [[UV3]](s64), [[PTR_ADD]](p0) :: (store (s64) into stack, align 16)
  ; LP64F-NEXT:   [[ANYEXT5:%[0-9]+]]:_(s64) = G_ANYEXT [[C7]](s32)
  ; LP64F-NEXT:   [[C9:%[0-9]+]]:_(s64) = G_CONSTANT i64 8
  ; LP64F-NEXT:   [[PTR_ADD1:%[0-9]+]]:_(p0) = G_PTR_ADD [[COPY]], [[C9]](s64)
  ; LP64F-NEXT:   G_STORE [[ANYEXT5]](s64), [[PTR_ADD1]](p0) :: (store (s64) into stack + 8)
  ; LP64F-NEXT:   $x10 = COPY [[ANYEXT]](s64)
  ; LP64F-NEXT:   $x11 = COPY [[ANYEXT1]](s64)
  ; LP64F-NEXT:   $x12 = COPY [[ANYEXT2]](s64)
  ; LP64F-NEXT:   $x13 = COPY [[UV]](s64)
  ; LP64F-NEXT:   $x14 = COPY [[UV1]](s64)
  ; LP64F-NEXT:   $x15 = COPY [[ANYEXT3]](s64)
  ; LP64F-NEXT:   $x16 = COPY [[ANYEXT4]](s64)
  ; LP64F-NEXT:   $x17 = COPY [[UV2]](s64)
  ; LP64F-NEXT:   PseudoCALL target-flags(riscv-call) @callee_many_scalars, csr_ilp32f_lp64f, implicit-def $x1, implicit $x10, implicit $x11, implicit $x12, implicit $x13, implicit $x14, implicit $x15, implicit $x16, implicit $x17, implicit-def $x10
  ; LP64F-NEXT:   ADJCALLSTACKUP 16, 0, implicit-def $x2, implicit $x2
  ; LP64F-NEXT:   [[COPY1:%[0-9]+]]:_(s64) = COPY $x10
  ; LP64F-NEXT:   [[TRUNC:%[0-9]+]]:_(s32) = G_TRUNC [[COPY1]](s64)
  ; LP64F-NEXT:   [[ANYEXT6:%[0-9]+]]:_(s64) = G_ANYEXT [[TRUNC]](s32)
  ; LP64F-NEXT:   $x10 = COPY [[ANYEXT6]](s64)
  ; LP64F-NEXT:   PseudoRET implicit $x10
  ;
  ; LP64D-LABEL: name: caller_many_scalars
  ; LP64D: bb.1 (%ir-block.0):
  ; LP64D-NEXT:   [[C:%[0-9]+]]:_(s8) = G_CONSTANT i8 1
  ; LP64D-NEXT:   [[C1:%[0-9]+]]:_(s16) = G_CONSTANT i16 2
  ; LP64D-NEXT:   [[C2:%[0-9]+]]:_(s32) = G_CONSTANT i32 3
  ; LP64D-NEXT:   [[C3:%[0-9]+]]:_(s128) = G_CONSTANT i128 4
  ; LP64D-NEXT:   [[C4:%[0-9]+]]:_(s32) = G_CONSTANT i32 5
  ; LP64D-NEXT:   [[C5:%[0-9]+]]:_(s32) = G_CONSTANT i32 6
  ; LP64D-NEXT:   [[C6:%[0-9]+]]:_(s128) = G_CONSTANT i128 7
  ; LP64D-NEXT:   [[C7:%[0-9]+]]:_(s32) = G_CONSTANT i32 8
  ; LP64D-NEXT:   ADJCALLSTACKDOWN 16, 0, implicit-def $x2, implicit $x2
  ; LP64D-NEXT:   [[ANYEXT:%[0-9]+]]:_(s64) = G_ANYEXT [[C]](s8)
  ; LP64D-NEXT:   [[ANYEXT1:%[0-9]+]]:_(s64) = G_ANYEXT [[C1]](s16)
  ; LP64D-NEXT:   [[ANYEXT2:%[0-9]+]]:_(s64) = G_ANYEXT [[C2]](s32)
  ; LP64D-NEXT:   [[UV:%[0-9]+]]:_(s64), [[UV1:%[0-9]+]]:_(s64) = G_UNMERGE_VALUES [[C3]](s128)
  ; LP64D-NEXT:   [[ANYEXT3:%[0-9]+]]:_(s64) = G_ANYEXT [[C4]](s32)
  ; LP64D-NEXT:   [[ANYEXT4:%[0-9]+]]:_(s64) = G_ANYEXT [[C5]](s32)
  ; LP64D-NEXT:   [[UV2:%[0-9]+]]:_(s64), [[UV3:%[0-9]+]]:_(s64) = G_UNMERGE_VALUES [[C6]](s128)
  ; LP64D-NEXT:   [[COPY:%[0-9]+]]:_(p0) = COPY $x2
  ; LP64D-NEXT:   [[C8:%[0-9]+]]:_(s64) = G_CONSTANT i64 0
  ; LP64D-NEXT:   [[PTR_ADD:%[0-9]+]]:_(p0) = G_PTR_ADD [[COPY]], [[C8]](s64)
  ; LP64D-NEXT:   G_STORE [[UV3]](s64), [[PTR_ADD]](p0) :: (store (s64) into stack, align 16)
  ; LP64D-NEXT:   [[ANYEXT5:%[0-9]+]]:_(s64) = G_ANYEXT [[C7]](s32)
  ; LP64D-NEXT:   [[C9:%[0-9]+]]:_(s64) = G_CONSTANT i64 8
  ; LP64D-NEXT:   [[PTR_ADD1:%[0-9]+]]:_(p0) = G_PTR_ADD [[COPY]], [[C9]](s64)
  ; LP64D-NEXT:   G_STORE [[ANYEXT5]](s64), [[PTR_ADD1]](p0) :: (store (s64) into stack + 8)
  ; LP64D-NEXT:   $x10 = COPY [[ANYEXT]](s64)
  ; LP64D-NEXT:   $x11 = COPY [[ANYEXT1]](s64)
  ; LP64D-NEXT:   $x12 = COPY [[ANYEXT2]](s64)
  ; LP64D-NEXT:   $x13 = COPY [[UV]](s64)
  ; LP64D-NEXT:   $x14 = COPY [[UV1]](s64)
  ; LP64D-NEXT:   $x15 = COPY [[ANYEXT3]](s64)
  ; LP64D-NEXT:   $x16 = COPY [[ANYEXT4]](s64)
  ; LP64D-NEXT:   $x17 = COPY [[UV2]](s64)
  ; LP64D-NEXT:   PseudoCALL target-flags(riscv-call) @callee_many_scalars, csr_ilp32d_lp64d, implicit-def $x1, implicit $x10, implicit $x11, implicit $x12, implicit $x13, implicit $x14, implicit $x15, implicit $x16, implicit $x17, implicit-def $x10
  ; LP64D-NEXT:   ADJCALLSTACKUP 16, 0, implicit-def $x2, implicit $x2
  ; LP64D-NEXT:   [[COPY1:%[0-9]+]]:_(s64) = COPY $x10
  ; LP64D-NEXT:   [[TRUNC:%[0-9]+]]:_(s32) = G_TRUNC [[COPY1]](s64)
  ; LP64D-NEXT:   [[ANYEXT6:%[0-9]+]]:_(s64) = G_ANYEXT [[TRUNC]](s32)
  ; LP64D-NEXT:   $x10 = COPY [[ANYEXT6]](s64)
  ; LP64D-NEXT:   PseudoRET implicit $x10
  %1 = call i32 @callee_many_scalars(i8 1, i16 2, i32 3, i128 4, i32 5, i32 6, i128 7, i32 8)
  ret i32 %1
}

; Check return of 2x xlen scalars

define i128 @callee_small_scalar_ret() nounwind {
  ; RV64I-LABEL: name: callee_small_scalar_ret
  ; RV64I: bb.1 (%ir-block.0):
  ; RV64I-NEXT:   [[C:%[0-9]+]]:_(s128) = G_CONSTANT i128 -1
  ; RV64I-NEXT:   [[UV:%[0-9]+]]:_(s64), [[UV1:%[0-9]+]]:_(s64) = G_UNMERGE_VALUES [[C]](s128)
  ; RV64I-NEXT:   $x10 = COPY [[UV]](s64)
  ; RV64I-NEXT:   $x11 = COPY [[UV1]](s64)
  ; RV64I-NEXT:   PseudoRET implicit $x10, implicit $x11
  ret i128 -1
}

define i64 @caller_small_scalar_ret() nounwind {
  ; LP64-LABEL: name: caller_small_scalar_ret
  ; LP64: bb.1 (%ir-block.0):
  ; LP64-NEXT:   [[C:%[0-9]+]]:_(s128) = G_CONSTANT i128 -2
  ; LP64-NEXT:   ADJCALLSTACKDOWN 0, 0, implicit-def $x2, implicit $x2
  ; LP64-NEXT:   PseudoCALL target-flags(riscv-call) @callee_small_scalar_ret, csr_ilp32_lp64, implicit-def $x1, implicit-def $x10, implicit-def $x11
  ; LP64-NEXT:   ADJCALLSTACKUP 0, 0, implicit-def $x2, implicit $x2
  ; LP64-NEXT:   [[COPY:%[0-9]+]]:_(s64) = COPY $x10
  ; LP64-NEXT:   [[COPY1:%[0-9]+]]:_(s64) = COPY $x11
  ; LP64-NEXT:   [[MV:%[0-9]+]]:_(s128) = G_MERGE_VALUES [[COPY]](s64), [[COPY1]](s64)
  ; LP64-NEXT:   [[ICMP:%[0-9]+]]:_(s1) = G_ICMP intpred(eq), [[C]](s128), [[MV]]
  ; LP64-NEXT:   [[ZEXT:%[0-9]+]]:_(s64) = G_ZEXT [[ICMP]](s1)
  ; LP64-NEXT:   $x10 = COPY [[ZEXT]](s64)
  ; LP64-NEXT:   PseudoRET implicit $x10
  ;
  ; LP64F-LABEL: name: caller_small_scalar_ret
  ; LP64F: bb.1 (%ir-block.0):
  ; LP64F-NEXT:   [[C:%[0-9]+]]:_(s128) = G_CONSTANT i128 -2
  ; LP64F-NEXT:   ADJCALLSTACKDOWN 0, 0, implicit-def $x2, implicit $x2
  ; LP64F-NEXT:   PseudoCALL target-flags(riscv-call) @callee_small_scalar_ret, csr_ilp32f_lp64f, implicit-def $x1, implicit-def $x10, implicit-def $x11
  ; LP64F-NEXT:   ADJCALLSTACKUP 0, 0, implicit-def $x2, implicit $x2
  ; LP64F-NEXT:   [[COPY:%[0-9]+]]:_(s64) = COPY $x10
  ; LP64F-NEXT:   [[COPY1:%[0-9]+]]:_(s64) = COPY $x11
  ; LP64F-NEXT:   [[MV:%[0-9]+]]:_(s128) = G_MERGE_VALUES [[COPY]](s64), [[COPY1]](s64)
  ; LP64F-NEXT:   [[ICMP:%[0-9]+]]:_(s1) = G_ICMP intpred(eq), [[C]](s128), [[MV]]
  ; LP64F-NEXT:   [[ZEXT:%[0-9]+]]:_(s64) = G_ZEXT [[ICMP]](s1)
  ; LP64F-NEXT:   $x10 = COPY [[ZEXT]](s64)
  ; LP64F-NEXT:   PseudoRET implicit $x10
  ;
  ; LP64D-LABEL: name: caller_small_scalar_ret
  ; LP64D: bb.1 (%ir-block.0):
  ; LP64D-NEXT:   [[C:%[0-9]+]]:_(s128) = G_CONSTANT i128 -2
  ; LP64D-NEXT:   ADJCALLSTACKDOWN 0, 0, implicit-def $x2, implicit $x2
  ; LP64D-NEXT:   PseudoCALL target-flags(riscv-call) @callee_small_scalar_ret, csr_ilp32d_lp64d, implicit-def $x1, implicit-def $x10, implicit-def $x11
  ; LP64D-NEXT:   ADJCALLSTACKUP 0, 0, implicit-def $x2, implicit $x2
  ; LP64D-NEXT:   [[COPY:%[0-9]+]]:_(s64) = COPY $x10
  ; LP64D-NEXT:   [[COPY1:%[0-9]+]]:_(s64) = COPY $x11
  ; LP64D-NEXT:   [[MV:%[0-9]+]]:_(s128) = G_MERGE_VALUES [[COPY]](s64), [[COPY1]](s64)
  ; LP64D-NEXT:   [[ICMP:%[0-9]+]]:_(s1) = G_ICMP intpred(eq), [[C]](s128), [[MV]]
  ; LP64D-NEXT:   [[ZEXT:%[0-9]+]]:_(s64) = G_ZEXT [[ICMP]](s1)
  ; LP64D-NEXT:   $x10 = COPY [[ZEXT]](s64)
  ; LP64D-NEXT:   PseudoRET implicit $x10
  %1 = call i128 @callee_small_scalar_ret()
  %2 = icmp eq i128 -2, %1
  %3 = zext i1 %2 to i64
  ret i64 %3
}

; Check return of 2x xlen structs

%struct.small = type { i64, ptr }

define %struct.small @callee_small_struct_ret() nounwind {
  ; RV64I-LABEL: name: callee_small_struct_ret
  ; RV64I: bb.1 (%ir-block.0):
  ; RV64I-NEXT:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 1
  ; RV64I-NEXT:   [[C1:%[0-9]+]]:_(p0) = G_CONSTANT i64 0
  ; RV64I-NEXT:   $x10 = COPY [[C]](s64)
  ; RV64I-NEXT:   $x11 = COPY [[C1]](p0)
  ; RV64I-NEXT:   PseudoRET implicit $x10, implicit $x11
  ret %struct.small { i64 1, ptr null }
}

define i64 @caller_small_struct_ret() nounwind {
  ; LP64-LABEL: name: caller_small_struct_ret
  ; LP64: bb.1 (%ir-block.0):
  ; LP64-NEXT:   ADJCALLSTACKDOWN 0, 0, implicit-def $x2, implicit $x2
  ; LP64-NEXT:   PseudoCALL target-flags(riscv-call) @callee_small_struct_ret, csr_ilp32_lp64, implicit-def $x1, implicit-def $x10, implicit-def $x11
  ; LP64-NEXT:   ADJCALLSTACKUP 0, 0, implicit-def $x2, implicit $x2
  ; LP64-NEXT:   [[COPY:%[0-9]+]]:_(s64) = COPY $x10
  ; LP64-NEXT:   [[COPY1:%[0-9]+]]:_(p0) = COPY $x11
  ; LP64-NEXT:   [[PTRTOINT:%[0-9]+]]:_(s64) = G_PTRTOINT [[COPY1]](p0)
  ; LP64-NEXT:   [[ADD:%[0-9]+]]:_(s64) = G_ADD [[COPY]], [[PTRTOINT]]
  ; LP64-NEXT:   $x10 = COPY [[ADD]](s64)
  ; LP64-NEXT:   PseudoRET implicit $x10
  ;
  ; LP64F-LABEL: name: caller_small_struct_ret
  ; LP64F: bb.1 (%ir-block.0):
  ; LP64F-NEXT:   ADJCALLSTACKDOWN 0, 0, implicit-def $x2, implicit $x2
  ; LP64F-NEXT:   PseudoCALL target-flags(riscv-call) @callee_small_struct_ret, csr_ilp32f_lp64f, implicit-def $x1, implicit-def $x10, implicit-def $x11
  ; LP64F-NEXT:   ADJCALLSTACKUP 0, 0, implicit-def $x2, implicit $x2
  ; LP64F-NEXT:   [[COPY:%[0-9]+]]:_(s64) = COPY $x10
  ; LP64F-NEXT:   [[COPY1:%[0-9]+]]:_(p0) = COPY $x11
  ; LP64F-NEXT:   [[PTRTOINT:%[0-9]+]]:_(s64) = G_PTRTOINT [[COPY1]](p0)
  ; LP64F-NEXT:   [[ADD:%[0-9]+]]:_(s64) = G_ADD [[COPY]], [[PTRTOINT]]
  ; LP64F-NEXT:   $x10 = COPY [[ADD]](s64)
  ; LP64F-NEXT:   PseudoRET implicit $x10
  ;
  ; LP64D-LABEL: name: caller_small_struct_ret
  ; LP64D: bb.1 (%ir-block.0):
  ; LP64D-NEXT:   ADJCALLSTACKDOWN 0, 0, implicit-def $x2, implicit $x2
  ; LP64D-NEXT:   PseudoCALL target-flags(riscv-call) @callee_small_struct_ret, csr_ilp32d_lp64d, implicit-def $x1, implicit-def $x10, implicit-def $x11
  ; LP64D-NEXT:   ADJCALLSTACKUP 0, 0, implicit-def $x2, implicit $x2
  ; LP64D-NEXT:   [[COPY:%[0-9]+]]:_(s64) = COPY $x10
  ; LP64D-NEXT:   [[COPY1:%[0-9]+]]:_(p0) = COPY $x11
  ; LP64D-NEXT:   [[PTRTOINT:%[0-9]+]]:_(s64) = G_PTRTOINT [[COPY1]](p0)
  ; LP64D-NEXT:   [[ADD:%[0-9]+]]:_(s64) = G_ADD [[COPY]], [[PTRTOINT]]
  ; LP64D-NEXT:   $x10 = COPY [[ADD]](s64)
  ; LP64D-NEXT:   PseudoRET implicit $x10
  %1 = call %struct.small @callee_small_struct_ret()
  %2 = extractvalue %struct.small %1, 0
  %3 = extractvalue %struct.small %1, 1
  %4 = ptrtoint ptr %3 to i64
  %5 = add i64 %2, %4
  ret i64 %5
}

; Check return of >2x xlen structs

%struct.large = type { i64, i64, i64, i64 }

define void @callee_large_struct_ret(ptr noalias sret(%struct.large) %agg.result) nounwind {
  ; RV64I-LABEL: name: callee_large_struct_ret
  ; RV64I: bb.1 (%ir-block.0):
  ; RV64I-NEXT:   liveins: $x10
  ; RV64I-NEXT: {{  $}}
  ; RV64I-NEXT:   [[COPY:%[0-9]+]]:_(p0) = COPY $x10
  ; RV64I-NEXT:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 1
  ; RV64I-NEXT:   [[C1:%[0-9]+]]:_(s64) = G_CONSTANT i64 2
  ; RV64I-NEXT:   [[C2:%[0-9]+]]:_(s64) = G_CONSTANT i64 3
  ; RV64I-NEXT:   [[C3:%[0-9]+]]:_(s64) = G_CONSTANT i64 4
  ; RV64I-NEXT:   G_STORE [[C]](s64), [[COPY]](p0) :: (store (s64) into %ir.agg.result, align 4)
  ; RV64I-NEXT:   [[C4:%[0-9]+]]:_(s64) = G_CONSTANT i64 8
  ; RV64I-NEXT:   %3:_(p0) = nuw nusw G_PTR_ADD [[COPY]], [[C4]](s64)
  ; RV64I-NEXT:   G_STORE [[C1]](s64), %3(p0) :: (store (s64) into %ir.b, align 4)
  ; RV64I-NEXT:   [[C5:%[0-9]+]]:_(s64) = G_CONSTANT i64 16
  ; RV64I-NEXT:   %6:_(p0) = nuw nusw G_PTR_ADD [[COPY]], [[C5]](s64)
  ; RV64I-NEXT:   G_STORE [[C2]](s64), %6(p0) :: (store (s64) into %ir.c, align 4)
  ; RV64I-NEXT:   [[C6:%[0-9]+]]:_(s64) = G_CONSTANT i64 24
  ; RV64I-NEXT:   %9:_(p0) = nuw nusw G_PTR_ADD [[COPY]], [[C6]](s64)
  ; RV64I-NEXT:   G_STORE [[C3]](s64), %9(p0) :: (store (s64) into %ir.d, align 4)
  ; RV64I-NEXT:   PseudoRET
  store i64 1, ptr %agg.result, align 4
  %b = getelementptr inbounds %struct.large, ptr %agg.result, i64 0, i32 1
  store i64 2, ptr %b, align 4
  %c = getelementptr inbounds %struct.large, ptr %agg.result, i64 0, i32 2
  store i64 3, ptr %c, align 4
  %d = getelementptr inbounds %struct.large, ptr %agg.result, i64 0, i32 3
  store i64 4, ptr %d, align 4
  ret void
}

define i64 @caller_large_struct_ret() nounwind {
  ; LP64-LABEL: name: caller_large_struct_ret
  ; LP64: bb.1 (%ir-block.0):
  ; LP64-NEXT:   [[FRAME_INDEX:%[0-9]+]]:_(p0) = G_FRAME_INDEX %stack.0
  ; LP64-NEXT:   ADJCALLSTACKDOWN 0, 0, implicit-def $x2, implicit $x2
  ; LP64-NEXT:   $x10 = COPY [[FRAME_INDEX]](p0)
  ; LP64-NEXT:   PseudoCALL target-flags(riscv-call) @callee_large_struct_ret, csr_ilp32_lp64, implicit-def $x1, implicit $x10
  ; LP64-NEXT:   ADJCALLSTACKUP 0, 0, implicit-def $x2, implicit $x2
  ; LP64-NEXT:   [[LOAD:%[0-9]+]]:_(s64) = G_LOAD [[FRAME_INDEX]](p0) :: (dereferenceable load (s64) from %ir.1)
  ; LP64-NEXT:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 24
  ; LP64-NEXT:   %3:_(p0) = nuw nusw G_PTR_ADD [[FRAME_INDEX]], [[C]](s64)
  ; LP64-NEXT:   [[LOAD1:%[0-9]+]]:_(s64) = G_LOAD %3(p0) :: (dereferenceable load (s64) from %ir.3)
  ; LP64-NEXT:   [[ADD:%[0-9]+]]:_(s64) = G_ADD [[LOAD]], [[LOAD1]]
  ; LP64-NEXT:   $x10 = COPY [[ADD]](s64)
  ; LP64-NEXT:   PseudoRET implicit $x10
  ;
  ; LP64F-LABEL: name: caller_large_struct_ret
  ; LP64F: bb.1 (%ir-block.0):
  ; LP64F-NEXT:   [[FRAME_INDEX:%[0-9]+]]:_(p0) = G_FRAME_INDEX %stack.0
  ; LP64F-NEXT:   ADJCALLSTACKDOWN 0, 0, implicit-def $x2, implicit $x2
  ; LP64F-NEXT:   $x10 = COPY [[FRAME_INDEX]](p0)
  ; LP64F-NEXT:   PseudoCALL target-flags(riscv-call) @callee_large_struct_ret, csr_ilp32f_lp64f, implicit-def $x1, implicit $x10
  ; LP64F-NEXT:   ADJCALLSTACKUP 0, 0, implicit-def $x2, implicit $x2
  ; LP64F-NEXT:   [[LOAD:%[0-9]+]]:_(s64) = G_LOAD [[FRAME_INDEX]](p0) :: (dereferenceable load (s64) from %ir.1)
  ; LP64F-NEXT:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 24
  ; LP64F-NEXT:   %3:_(p0) = nuw nusw G_PTR_ADD [[FRAME_INDEX]], [[C]](s64)
  ; LP64F-NEXT:   [[LOAD1:%[0-9]+]]:_(s64) = G_LOAD %3(p0) :: (dereferenceable load (s64) from %ir.3)
  ; LP64F-NEXT:   [[ADD:%[0-9]+]]:_(s64) = G_ADD [[LOAD]], [[LOAD1]]
  ; LP64F-NEXT:   $x10 = COPY [[ADD]](s64)
  ; LP64F-NEXT:   PseudoRET implicit $x10
  ;
  ; LP64D-LABEL: name: caller_large_struct_ret
  ; LP64D: bb.1 (%ir-block.0):
  ; LP64D-NEXT:   [[FRAME_INDEX:%[0-9]+]]:_(p0) = G_FRAME_INDEX %stack.0
  ; LP64D-NEXT:   ADJCALLSTACKDOWN 0, 0, implicit-def $x2, implicit $x2
  ; LP64D-NEXT:   $x10 = COPY [[FRAME_INDEX]](p0)
  ; LP64D-NEXT:   PseudoCALL target-flags(riscv-call) @callee_large_struct_ret, csr_ilp32d_lp64d, implicit-def $x1, implicit $x10
  ; LP64D-NEXT:   ADJCALLSTACKUP 0, 0, implicit-def $x2, implicit $x2
  ; LP64D-NEXT:   [[LOAD:%[0-9]+]]:_(s64) = G_LOAD [[FRAME_INDEX]](p0) :: (dereferenceable load (s64) from %ir.1)
  ; LP64D-NEXT:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 24
  ; LP64D-NEXT:   %3:_(p0) = nuw nusw G_PTR_ADD [[FRAME_INDEX]], [[C]](s64)
  ; LP64D-NEXT:   [[LOAD1:%[0-9]+]]:_(s64) = G_LOAD %3(p0) :: (dereferenceable load (s64) from %ir.3)
  ; LP64D-NEXT:   [[ADD:%[0-9]+]]:_(s64) = G_ADD [[LOAD]], [[LOAD1]]
  ; LP64D-NEXT:   $x10 = COPY [[ADD]](s64)
  ; LP64D-NEXT:   PseudoRET implicit $x10
  %1 = alloca %struct.large
  call void @callee_large_struct_ret(ptr sret(%struct.large) %1)
  %2 = load i64, ptr %1
  %3 = getelementptr inbounds %struct.large, ptr %1, i64 0, i32 3
  %4 = load i64, ptr %3
  %5 = add i64 %2, %4
  ret i64 %5
}
