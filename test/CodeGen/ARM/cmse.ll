; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc %s -o - -mtriple=thumbv8m.base | \
; RUN:   FileCheck %s --check-prefix=CHECK-8B
; RUN: llc %s -o - -mtriple=thumbebv8m.base | \
; RUN:   FileCheck %s --check-prefix=CHECK-8B
; RUN: llc %s -o - -mtriple=thumbv8m.main | \
; RUN:   FileCheck %s --check-prefix=CHECK-8M
; RUN: llc %s -o - -mtriple=thumbebv8m.main | \
; RUN:   FileCheck %s --check-prefix=CHECK-8M

; RUN: llc %s -o - -mtriple=thumbv8.1m.main | \
; RUN:   FileCheck %s --check-prefix=CHECK-81M
; RUN: llc %s -o - -mtriple=thumbebv8.1m.main | \
; RUN:   FileCheck %s --check-prefix=CHECK-81M

define void @func1(ptr nocapture %fptr) #0 {
; CHECK-8B-LABEL: func1:
; CHECK-8B:       @ %bb.0: @ %entry
; CHECK-8B-NEXT:    push {r7, lr}
; CHECK-8B-NEXT:    push {r4, r5, r6, r7}
; CHECK-8B-NEXT:    mov r7, r11
; CHECK-8B-NEXT:    mov r6, r10
; CHECK-8B-NEXT:    mov r5, r9
; CHECK-8B-NEXT:    mov r4, r8
; CHECK-8B-NEXT:    push {r4, r5, r6, r7}
; CHECK-8B-NEXT:    mov r1, #1
; CHECK-8B-NEXT:    bics r0, r1
; CHECK-8B-NEXT:    mov r1, r0
; CHECK-8B-NEXT:    mov r2, r0
; CHECK-8B-NEXT:    mov r3, r0
; CHECK-8B-NEXT:    mov r4, r0
; CHECK-8B-NEXT:    mov r5, r0
; CHECK-8B-NEXT:    mov r6, r0
; CHECK-8B-NEXT:    mov r7, r0
; CHECK-8B-NEXT:    mov r8, r0
; CHECK-8B-NEXT:    mov r9, r0
; CHECK-8B-NEXT:    mov r10, r0
; CHECK-8B-NEXT:    mov r11, r0
; CHECK-8B-NEXT:    mov r12, r0
; CHECK-8B-NEXT:    msr apsr, r0
; CHECK-8B-NEXT:    blxns r0
; CHECK-8B-NEXT:    pop {r4, r5, r6, r7}
; CHECK-8B-NEXT:    mov r8, r4
; CHECK-8B-NEXT:    mov r9, r5
; CHECK-8B-NEXT:    mov r10, r6
; CHECK-8B-NEXT:    mov r11, r7
; CHECK-8B-NEXT:    pop {r4, r5, r6, r7}
; CHECK-8B-NEXT:    pop {r7}
; CHECK-8B-NEXT:    pop {r0}
; CHECK-8B-NEXT:    mov lr, r0
; CHECK-8B-NEXT:    mov r0, lr
; CHECK-8B-NEXT:    mov r1, lr
; CHECK-8B-NEXT:    mov r2, lr
; CHECK-8B-NEXT:    mov r3, lr
; CHECK-8B-NEXT:    mov r12, lr
; CHECK-8B-NEXT:    msr apsr, lr
; CHECK-8B-NEXT:    bxns lr
;
; CHECK-8M-LABEL: func1:
; CHECK-8M:       @ %bb.0: @ %entry
; CHECK-8M-NEXT:    push {r7, lr}
; CHECK-8M-NEXT:    push.w {r4, r5, r6, r7, r8, r9, r10, r11}
; CHECK-8M-NEXT:    bic r0, r0, #1
; CHECK-8M-NEXT:    sub sp, #136
; CHECK-8M-NEXT:    vlstm sp
; CHECK-8M-NEXT:    mov r1, r0
; CHECK-8M-NEXT:    mov r2, r0
; CHECK-8M-NEXT:    mov r3, r0
; CHECK-8M-NEXT:    mov r4, r0
; CHECK-8M-NEXT:    mov r5, r0
; CHECK-8M-NEXT:    mov r6, r0
; CHECK-8M-NEXT:    mov r7, r0
; CHECK-8M-NEXT:    mov r8, r0
; CHECK-8M-NEXT:    mov r9, r0
; CHECK-8M-NEXT:    mov r10, r0
; CHECK-8M-NEXT:    mov r11, r0
; CHECK-8M-NEXT:    mov r12, r0
; CHECK-8M-NEXT:    msr apsr_nzcvq, r0
; CHECK-8M-NEXT:    blxns r0
; CHECK-8M-NEXT:    vlldm sp
; CHECK-8M-NEXT:    add sp, #136
; CHECK-8M-NEXT:    pop.w {r4, r5, r6, r7, r8, r9, r10, r11}
; CHECK-8M-NEXT:    pop.w {r7, lr}
; CHECK-8M-NEXT:    mov r0, lr
; CHECK-8M-NEXT:    mov r1, lr
; CHECK-8M-NEXT:    mov r2, lr
; CHECK-8M-NEXT:    mov r3, lr
; CHECK-8M-NEXT:    mov r12, lr
; CHECK-8M-NEXT:    msr apsr_nzcvq, lr
; CHECK-8M-NEXT:    bxns lr
;
; CHECK-81M-LABEL: func1:
; CHECK-81M:       @ %bb.0: @ %entry
; CHECK-81M-NEXT:    vstr fpcxtns, [sp, #-4]!
; CHECK-81M-NEXT:    push {r7, lr}
; CHECK-81M-NEXT:    sub sp, #4
; CHECK-81M-NEXT:    push.w {r4, r5, r6, r7, r8, r9, r10, r11}
; CHECK-81M-NEXT:    bic r0, r0, #1
; CHECK-81M-NEXT:    sub sp, #136
; CHECK-81M-NEXT:    vlstm sp
; CHECK-81M-NEXT:    clrm {r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, apsr}
; CHECK-81M-NEXT:    blxns r0
; CHECK-81M-NEXT:    vlldm sp
; CHECK-81M-NEXT:    add sp, #136
; CHECK-81M-NEXT:    pop.w {r4, r5, r6, r7, r8, r9, r10, r11}
; CHECK-81M-NEXT:    add sp, #4
; CHECK-81M-NEXT:    pop.w {r7, lr}
; CHECK-81M-NEXT:    vscclrm {s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, vpr}
; CHECK-81M-NEXT:    vldr fpcxtns, [sp], #4
; CHECK-81M-NEXT:    clrm {r0, r1, r2, r3, r12, apsr}
; CHECK-81M-NEXT:    bxns lr
entry:
  call void %fptr() #1
  ret void
}

attributes #0 = { "cmse_nonsecure_entry" nounwind }
attributes #1 = { "cmse_nonsecure_call" nounwind }

define void @func2(ptr nocapture %fptr) #2 {
; CHECK-8B-LABEL: func2:
; CHECK-8B:       @ %bb.0: @ %entry
; CHECK-8B-NEXT:    push {r7, lr}
; CHECK-8B-NEXT:    push {r4, r5, r6, r7}
; CHECK-8B-NEXT:    mov r7, r11
; CHECK-8B-NEXT:    mov r6, r10
; CHECK-8B-NEXT:    mov r5, r9
; CHECK-8B-NEXT:    mov r4, r8
; CHECK-8B-NEXT:    push {r4, r5, r6, r7}
; CHECK-8B-NEXT:    mov r1, #1
; CHECK-8B-NEXT:    bics r0, r1
; CHECK-8B-NEXT:    mov r1, r0
; CHECK-8B-NEXT:    mov r2, r0
; CHECK-8B-NEXT:    mov r3, r0
; CHECK-8B-NEXT:    mov r4, r0
; CHECK-8B-NEXT:    mov r5, r0
; CHECK-8B-NEXT:    mov r6, r0
; CHECK-8B-NEXT:    mov r7, r0
; CHECK-8B-NEXT:    mov r8, r0
; CHECK-8B-NEXT:    mov r9, r0
; CHECK-8B-NEXT:    mov r10, r0
; CHECK-8B-NEXT:    mov r11, r0
; CHECK-8B-NEXT:    mov r12, r0
; CHECK-8B-NEXT:    msr apsr, r0
; CHECK-8B-NEXT:    blxns r0
; CHECK-8B-NEXT:    pop {r4, r5, r6, r7}
; CHECK-8B-NEXT:    mov r8, r4
; CHECK-8B-NEXT:    mov r9, r5
; CHECK-8B-NEXT:    mov r10, r6
; CHECK-8B-NEXT:    mov r11, r7
; CHECK-8B-NEXT:    pop {r4, r5, r6, r7}
; CHECK-8B-NEXT:    pop {r7, pc}
;
; CHECK-8M-LABEL: func2:
; CHECK-8M:       @ %bb.0: @ %entry
; CHECK-8M-NEXT:    push {r7, lr}
; CHECK-8M-NEXT:    push.w {r4, r5, r6, r7, r8, r9, r10, r11}
; CHECK-8M-NEXT:    bic r0, r0, #1
; CHECK-8M-NEXT:    sub sp, #136
; CHECK-8M-NEXT:    vlstm sp
; CHECK-8M-NEXT:    mov r1, r0
; CHECK-8M-NEXT:    mov r2, r0
; CHECK-8M-NEXT:    mov r3, r0
; CHECK-8M-NEXT:    mov r4, r0
; CHECK-8M-NEXT:    mov r5, r0
; CHECK-8M-NEXT:    mov r6, r0
; CHECK-8M-NEXT:    mov r7, r0
; CHECK-8M-NEXT:    mov r8, r0
; CHECK-8M-NEXT:    mov r9, r0
; CHECK-8M-NEXT:    mov r10, r0
; CHECK-8M-NEXT:    mov r11, r0
; CHECK-8M-NEXT:    mov r12, r0
; CHECK-8M-NEXT:    msr apsr_nzcvq, r0
; CHECK-8M-NEXT:    blxns r0
; CHECK-8M-NEXT:    vlldm sp
; CHECK-8M-NEXT:    add sp, #136
; CHECK-8M-NEXT:    pop.w {r4, r5, r6, r7, r8, r9, r10, r11}
; CHECK-8M-NEXT:    pop {r7, pc}
;
; CHECK-81M-LABEL: func2:
; CHECK-81M:       @ %bb.0: @ %entry
; CHECK-81M-NEXT:    push {r7, lr}
; CHECK-81M-NEXT:    push.w {r4, r5, r6, r7, r8, r9, r10, r11}
; CHECK-81M-NEXT:    bic r0, r0, #1
; CHECK-81M-NEXT:    sub sp, #136
; CHECK-81M-NEXT:    vlstm sp
; CHECK-81M-NEXT:    clrm {r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, apsr}
; CHECK-81M-NEXT:    blxns r0
; CHECK-81M-NEXT:    vlldm sp
; CHECK-81M-NEXT:    add sp, #136
; CHECK-81M-NEXT:    pop.w {r4, r5, r6, r7, r8, r9, r10, r11}
; CHECK-81M-NEXT:    pop {r7, pc}
entry:
  tail call void %fptr() #3
  ret void
}

attributes #2 = { nounwind }
attributes #3 = { "cmse_nonsecure_call" nounwind }

define void @func3() #4 {
; CHECK-8B-LABEL: func3:
; CHECK-8B:       @ %bb.0: @ %entry
; CHECK-8B-NEXT:    mov r0, lr
; CHECK-8B-NEXT:    mov r1, lr
; CHECK-8B-NEXT:    mov r2, lr
; CHECK-8B-NEXT:    mov r3, lr
; CHECK-8B-NEXT:    mov r12, lr
; CHECK-8B-NEXT:    msr apsr, lr
; CHECK-8B-NEXT:    bxns lr
;
; CHECK-8M-LABEL: func3:
; CHECK-8M:       @ %bb.0: @ %entry
; CHECK-8M-NEXT:    mov r0, lr
; CHECK-8M-NEXT:    mov r1, lr
; CHECK-8M-NEXT:    mov r2, lr
; CHECK-8M-NEXT:    mov r3, lr
; CHECK-8M-NEXT:    mov r12, lr
; CHECK-8M-NEXT:    msr apsr_nzcvq, lr
; CHECK-8M-NEXT:    bxns lr
;
; CHECK-81M-LABEL: func3:
; CHECK-81M:       @ %bb.0: @ %entry
; CHECK-81M-NEXT:    vstr fpcxtns, [sp, #-4]!
; CHECK-81M-NEXT:    vscclrm {s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, vpr}
; CHECK-81M-NEXT:    vldr fpcxtns, [sp], #4
; CHECK-81M-NEXT:    clrm {r0, r1, r2, r3, r12, apsr}
; CHECK-81M-NEXT:    bxns lr
entry:
  ret void
}

define void @func4() #4 {
; CHECK-8B-LABEL: func4:
; CHECK-8B:       @ %bb.0: @ %entry
; CHECK-8B-NEXT:    push {r7, lr}
; CHECK-8B-NEXT:    bl func3
; CHECK-8B-NEXT:    pop {r7}
; CHECK-8B-NEXT:    pop {r0}
; CHECK-8B-NEXT:    mov lr, r0
; CHECK-8B-NEXT:    mov r0, lr
; CHECK-8B-NEXT:    mov r1, lr
; CHECK-8B-NEXT:    mov r2, lr
; CHECK-8B-NEXT:    mov r3, lr
; CHECK-8B-NEXT:    mov r12, lr
; CHECK-8B-NEXT:    msr apsr, lr
; CHECK-8B-NEXT:    bxns lr
;
; CHECK-8M-LABEL: func4:
; CHECK-8M:       @ %bb.0: @ %entry
; CHECK-8M-NEXT:    push {r7, lr}
; CHECK-8M-NEXT:    bl func3
; CHECK-8M-NEXT:    pop.w {r7, lr}
; CHECK-8M-NEXT:    mov r0, lr
; CHECK-8M-NEXT:    mov r1, lr
; CHECK-8M-NEXT:    mov r2, lr
; CHECK-8M-NEXT:    mov r3, lr
; CHECK-8M-NEXT:    mov r12, lr
; CHECK-8M-NEXT:    msr apsr_nzcvq, lr
; CHECK-8M-NEXT:    bxns lr
;
; CHECK-81M-LABEL: func4:
; CHECK-81M:       @ %bb.0: @ %entry
; CHECK-81M-NEXT:    vstr fpcxtns, [sp, #-4]!
; CHECK-81M-NEXT:    push {r7, lr}
; CHECK-81M-NEXT:    sub sp, #4
; CHECK-81M-NEXT:    bl func3
; CHECK-81M-NEXT:    add sp, #4
; CHECK-81M-NEXT:    pop.w {r7, lr}
; CHECK-81M-NEXT:    vscclrm {s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, vpr}
; CHECK-81M-NEXT:    vldr fpcxtns, [sp], #4
; CHECK-81M-NEXT:    clrm {r0, r1, r2, r3, r12, apsr}
; CHECK-81M-NEXT:    bxns lr
entry:
  tail call void @func3() #5
  ret void
}

declare void @func51(ptr);

define void @func5() #4 {
; CHECK-8B-LABEL: func5:
; CHECK-8B:       @ %bb.0:
; CHECK-8B-NEXT:    push {r4, r6, r7, lr}
; CHECK-8B-NEXT:    add r7, sp, #8
; CHECK-8B-NEXT:    sub sp, #16
; CHECK-8B-NEXT:    mov r4, sp
; CHECK-8B-NEXT:    lsrs r4, r4, #4
; CHECK-8B-NEXT:    lsls r4, r4, #4
; CHECK-8B-NEXT:    mov sp, r4
; CHECK-8B-NEXT:    mov r0, sp
; CHECK-8B-NEXT:    bl func51
; CHECK-8B-NEXT:    subs r6, r7, #7
; CHECK-8B-NEXT:    subs r6, #1
; CHECK-8B-NEXT:    mov sp, r6
; CHECK-8B-NEXT:    pop {r4, r6, r7}
; CHECK-8B-NEXT:    pop {r0}
; CHECK-8B-NEXT:    mov lr, r0
; CHECK-8B-NEXT:    mov r0, lr
; CHECK-8B-NEXT:    mov r1, lr
; CHECK-8B-NEXT:    mov r2, lr
; CHECK-8B-NEXT:    mov r3, lr
; CHECK-8B-NEXT:    mov r12, lr
; CHECK-8B-NEXT:    msr apsr, lr
; CHECK-8B-NEXT:    bxns lr
;
; CHECK-8M-LABEL: func5:
; CHECK-8M:       @ %bb.0:
; CHECK-8M-NEXT:    push {r4, r6, r7, lr}
; CHECK-8M-NEXT:    add r7, sp, #8
; CHECK-8M-NEXT:    sub sp, #16
; CHECK-8M-NEXT:    mov r4, sp
; CHECK-8M-NEXT:    bfc r4, #0, #4
; CHECK-8M-NEXT:    mov sp, r4
; CHECK-8M-NEXT:    mov r0, sp
; CHECK-8M-NEXT:    bl func51
; CHECK-8M-NEXT:    sub.w r4, r7, #8
; CHECK-8M-NEXT:    mov sp, r4
; CHECK-8M-NEXT:    pop.w {r4, r6, r7, lr}
; CHECK-8M-NEXT:    mov r0, lr
; CHECK-8M-NEXT:    mov r1, lr
; CHECK-8M-NEXT:    mov r2, lr
; CHECK-8M-NEXT:    mov r3, lr
; CHECK-8M-NEXT:    mov r12, lr
; CHECK-8M-NEXT:    msr apsr_nzcvq, lr
; CHECK-8M-NEXT:    bxns lr
;
; CHECK-81M-LABEL: func5:
; CHECK-81M:       @ %bb.0:
; CHECK-81M-NEXT:    vstr fpcxtns, [sp, #-4]!
; CHECK-81M-NEXT:    push {r4, r6, r7, lr}
; CHECK-81M-NEXT:    add r7, sp, #8
; CHECK-81M-NEXT:    sub sp, #12
; CHECK-81M-NEXT:    mov r4, sp
; CHECK-81M-NEXT:    bfc r4, #0, #4
; CHECK-81M-NEXT:    mov sp, r4
; CHECK-81M-NEXT:    mov r0, sp
; CHECK-81M-NEXT:    bl func51
; CHECK-81M-NEXT:    sub.w r4, r7, #8
; CHECK-81M-NEXT:    mov sp, r4
; CHECK-81M-NEXT:    pop.w {r4, r6, r7, lr}
; CHECK-81M-NEXT:    vscclrm {s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, vpr}
; CHECK-81M-NEXT:    vldr fpcxtns, [sp], #4
; CHECK-81M-NEXT:    clrm {r0, r1, r2, r3, r12, apsr}
; CHECK-81M-NEXT:    bxns lr
  %1 = alloca i8, align 16
  call void @func51(ptr nonnull %1) #5
  ret void
}


attributes #4 = { "cmse_nonsecure_entry" nounwind }
attributes #5 = { nounwind }

