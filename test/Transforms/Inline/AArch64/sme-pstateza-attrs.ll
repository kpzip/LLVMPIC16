; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 2
; RUN: opt -mtriple=aarch64-unknown-linux-gnu -mattr=+sme -S -passes=inline < %s | FileCheck %s

declare void @inlined_body()

;
; Define some functions that will be called by the functions below.
; These just call a '...body()' function. If we see the call to one of
; these functions being replaced by '...body()', then we know it has been
; inlined.
;

define void @nonza_callee() {
; CHECK-LABEL: define void @nonza_callee
; CHECK-SAME: () #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    call void @inlined_body()
; CHECK-NEXT:    ret void
;
entry:
  call void @inlined_body()
  ret void
}

define void @shared_za_callee() "aarch64_inout_za" {
; CHECK-LABEL: define void @shared_za_callee
; CHECK-SAME: () #[[ATTR1:[0-9]+]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    call void @inlined_body()
; CHECK-NEXT:    ret void
;
entry:
  call void @inlined_body()
  ret void
}

define void @new_za_callee() "aarch64_new_za" {
; CHECK-LABEL: define void @new_za_callee
; CHECK-SAME: () #[[ATTR2:[0-9]+]] {
; CHECK-NEXT:    call void @inlined_body()
; CHECK-NEXT:    ret void
;
  call void @inlined_body()
  ret void
}

;
; Now test that inlining only happens when no lazy-save is needed.
; Test for a number of combinations, where:
; N   Not using ZA.
; S   Shared ZA interface
; Z   New ZA interface

; [x] N -> N
; [ ] N -> S (This combination is invalid)
; [ ] N -> Z
define void @nonza_caller_nonza_callee_inline() {
; CHECK-LABEL: define void @nonza_caller_nonza_callee_inline
; CHECK-SAME: () #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    call void @inlined_body()
; CHECK-NEXT:    ret void
;
entry:
  call void @nonza_callee()
  ret void
}

; [ ] N -> N
; [ ] N -> S (This combination is invalid)
; [x] N -> Z
define void @nonza_caller_new_za_callee_dont_inline() {
; CHECK-LABEL: define void @nonza_caller_new_za_callee_dont_inline
; CHECK-SAME: () #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    call void @new_za_callee()
; CHECK-NEXT:    ret void
;
entry:
  call void @new_za_callee()
  ret void
}

; [x] Z -> N
; [ ] Z -> S
; [ ] Z -> Z
define void @new_za_caller_nonza_callee_inline() "aarch64_new_za" {
; CHECK-LABEL: define void @new_za_caller_nonza_callee_inline
; CHECK-SAME: () #[[ATTR2]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    call void @inlined_body()
; CHECK-NEXT:    ret void
;
entry:
  call void @nonza_callee()
  ret void
}

; [ ] Z -> N
; [x] Z -> S
; [ ] Z -> Z
define void @new_za_caller_shared_za_callee_inline() "aarch64_new_za" {
; CHECK-LABEL: define void @new_za_caller_shared_za_callee_inline
; CHECK-SAME: () #[[ATTR2]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    call void @inlined_body()
; CHECK-NEXT:    ret void
;
entry:
  call void @shared_za_callee()
  ret void
}

; [ ] Z -> N
; [ ] Z -> S
; [x] Z -> Z
define void @new_za_caller_new_za_callee_dont_inline() "aarch64_new_za" {
; CHECK-LABEL: define void @new_za_caller_new_za_callee_dont_inline
; CHECK-SAME: () #[[ATTR2]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    call void @new_za_callee()
; CHECK-NEXT:    ret void
;
entry:
  call void @new_za_callee()
  ret void
}

; [x] Z -> N
; [ ] Z -> S
; [ ] Z -> Z
define void @shared_za_caller_nonza_callee_inline() "aarch64_inout_za" {
; CHECK-LABEL: define void @shared_za_caller_nonza_callee_inline
; CHECK-SAME: () #[[ATTR1]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    call void @inlined_body()
; CHECK-NEXT:    ret void
;
entry:
  call void @nonza_callee()
  ret void
}

; [ ] S -> N
; [x] S -> Z
; [ ] S -> S
define void @shared_za_caller_new_za_callee_dont_inline() "aarch64_inout_za" {
; CHECK-LABEL: define void @shared_za_caller_new_za_callee_dont_inline
; CHECK-SAME: () #[[ATTR1]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    call void @new_za_callee()
; CHECK-NEXT:    ret void
;
entry:
  call void @new_za_callee()
  ret void
}

; [ ] S -> N
; [ ] S -> Z
; [x] S -> S
define void @shared_za_caller_shared_za_callee_inline() "aarch64_inout_za" {
; CHECK-LABEL: define void @shared_za_caller_shared_za_callee_inline
; CHECK-SAME: () #[[ATTR1]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    call void @inlined_body()
; CHECK-NEXT:    ret void
;
entry:
  call void @shared_za_callee()
  ret void
}

define void @private_za_callee_call_za_disable() {
; CHECK-LABEL: define void @private_za_callee_call_za_disable
; CHECK-SAME: () #[[ATTR0]] {
; CHECK-NEXT:    call void @__arm_za_disable()
; CHECK-NEXT:    ret void
;
  call void @__arm_za_disable()
  ret void
}

define void @shared_za_caller_private_za_callee_call_za_disable() "aarch64_inout_za" {
; CHECK-LABEL: define void @shared_za_caller_private_za_callee_call_za_disable
; CHECK-SAME: () #[[ATTR1]] {
; CHECK-NEXT:    call void @private_za_callee_call_za_disable()
; CHECK-NEXT:    ret void
;
  call void @private_za_callee_call_za_disable()
  ret void
}

define void @private_za_callee_call_tpidr2_save() {
; CHECK-LABEL: define void @private_za_callee_call_tpidr2_save
; CHECK-SAME: () #[[ATTR0]] {
; CHECK-NEXT:    call void @__arm_tpidr2_save()
; CHECK-NEXT:    ret void
;
  call void @__arm_tpidr2_save()
  ret void
}

define void @shared_za_caller_private_za_callee_call_tpidr2_save_dont_inline() "aarch64_inout_za" {
; CHECK-LABEL: define void @shared_za_caller_private_za_callee_call_tpidr2_save_dont_inline
; CHECK-SAME: () #[[ATTR1]] {
; CHECK-NEXT:    call void @private_za_callee_call_tpidr2_save()
; CHECK-NEXT:    ret void
;
  call void @private_za_callee_call_tpidr2_save()
  ret void
}

define void @private_za_callee_call_tpidr2_restore(ptr %ptr) {
; CHECK-LABEL: define void @private_za_callee_call_tpidr2_restore
; CHECK-SAME: (ptr [[PTR:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:    call void @__arm_tpidr2_restore(ptr [[PTR]])
; CHECK-NEXT:    ret void
;
  call void @__arm_tpidr2_restore(ptr %ptr)
  ret void
}

define void @shared_za_caller_private_za_callee_call_tpidr2_restore_dont_inline(ptr %ptr) "aarch64_inout_za" {
; CHECK-LABEL: define void @shared_za_caller_private_za_callee_call_tpidr2_restore_dont_inline
; CHECK-SAME: (ptr [[PTR:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    call void @private_za_callee_call_tpidr2_restore(ptr [[PTR]])
; CHECK-NEXT:    ret void
;
  call void @private_za_callee_call_tpidr2_restore(ptr %ptr)
  ret void
}

define void @nonzt0_callee() {
; CHECK-LABEL: define void @nonzt0_callee
; CHECK-SAME: () #[[ATTR0]] {
; CHECK-NEXT:    call void asm sideeffect "
; CHECK-NEXT:    call void @inlined_body()
; CHECK-NEXT:    ret void
;
  call void asm sideeffect "; inlineasm", ""()
  call void @inlined_body()
  ret void
}

define void @shared_zt0_caller_nonzt0_callee_dont_inline() "aarch64_inout_zt0" {
; CHECK-LABEL: define void @shared_zt0_caller_nonzt0_callee_dont_inline
; CHECK-SAME: () #[[ATTR3:[0-9]+]] {
; CHECK-NEXT:    call void @nonzt0_callee()
; CHECK-NEXT:    ret void
;
  call void @nonzt0_callee()
  ret void
}

define void @shared_zt0_callee() "aarch64_inout_zt0" {
; CHECK-LABEL: define void @shared_zt0_callee
; CHECK-SAME: () #[[ATTR3]] {
; CHECK-NEXT:    call void asm sideeffect "
; CHECK-NEXT:    call void @inlined_body()
; CHECK-NEXT:    ret void
;
  call void asm sideeffect "; inlineasm", ""()
  call void @inlined_body()
  ret void
}

define void @shared_zt0_caller_shared_zt0_callee_inline() "aarch64_inout_zt0" {
; CHECK-LABEL: define void @shared_zt0_caller_shared_zt0_callee_inline
; CHECK-SAME: () #[[ATTR3]] {
; CHECK-NEXT:    call void asm sideeffect "
; CHECK-NEXT:    call void @inlined_body()
; CHECK-NEXT:    ret void
;
  call void @shared_zt0_callee()
  ret void
}

declare void @__arm_za_disable()
declare void @__arm_tpidr2_save()
declare void @__arm_tpidr2_restore(ptr)
