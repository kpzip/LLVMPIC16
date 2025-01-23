; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-apple-ios7.0 -aarch64-enable-sink-fold=true -o - %s | FileCheck %s
; RUN: llc -mtriple=aarch64-apple-ios7.0 -mattr=+outline-atomics -aarch64-enable-sink-fold=true -o - %s | FileCheck %s --check-prefix=OUTLINE-ATOMICS

define i32 @test_return(ptr %p, i32 %oldval, i32 %newval) {
; CHECK-LABEL: test_return:
; CHECK:       ; %bb.0:
; CHECK-NEXT:  LBB0_1: ; %cmpxchg.start
; CHECK-NEXT:    ; =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldaxr w8, [x0]
; CHECK-NEXT:    cmp w8, w1
; CHECK-NEXT:    b.ne LBB0_4
; CHECK-NEXT:  ; %bb.2: ; %cmpxchg.trystore
; CHECK-NEXT:    ; in Loop: Header=BB0_1 Depth=1
; CHECK-NEXT:    stlxr w8, w2, [x0]
; CHECK-NEXT:    cbnz w8, LBB0_1
; CHECK-NEXT:  ; %bb.3:
; CHECK-NEXT:    mov w0, #1 ; =0x1
; CHECK-NEXT:    ret
; CHECK-NEXT:  LBB0_4: ; %cmpxchg.nostore
; CHECK-NEXT:    mov w0, wzr
; CHECK-NEXT:    clrex
; CHECK-NEXT:    ret
;
; OUTLINE-ATOMICS-LABEL: test_return:
; OUTLINE-ATOMICS:       ; %bb.0:
; OUTLINE-ATOMICS-NEXT:    stp x20, x19, [sp, #-32]! ; 16-byte Folded Spill
; OUTLINE-ATOMICS-NEXT:    stp x29, x30, [sp, #16] ; 16-byte Folded Spill
; OUTLINE-ATOMICS-NEXT:    .cfi_def_cfa_offset 32
; OUTLINE-ATOMICS-NEXT:    .cfi_offset w30, -8
; OUTLINE-ATOMICS-NEXT:    .cfi_offset w29, -16
; OUTLINE-ATOMICS-NEXT:    .cfi_offset w19, -24
; OUTLINE-ATOMICS-NEXT:    .cfi_offset w20, -32
; OUTLINE-ATOMICS-NEXT:    mov x8, x0
; OUTLINE-ATOMICS-NEXT:    mov w19, w1
; OUTLINE-ATOMICS-NEXT:    mov w0, w1
; OUTLINE-ATOMICS-NEXT:    mov w1, w2
; OUTLINE-ATOMICS-NEXT:    mov x2, x8
; OUTLINE-ATOMICS-NEXT:    bl ___aarch64_cas4_acq_rel
; OUTLINE-ATOMICS-NEXT:    ldp x29, x30, [sp, #16] ; 16-byte Folded Reload
; OUTLINE-ATOMICS-NEXT:    cmp w0, w19
; OUTLINE-ATOMICS-NEXT:    cset w0, eq
; OUTLINE-ATOMICS-NEXT:    ldp x20, x19, [sp], #32 ; 16-byte Folded Reload
; OUTLINE-ATOMICS-NEXT:    ret
  %pair = cmpxchg ptr %p, i32 %oldval, i32 %newval seq_cst seq_cst
  %success = extractvalue { i32, i1 } %pair, 1
  %conv = zext i1 %success to i32
  ret i32 %conv
}

; FIXME: DAG combine should be able to deal with this EOR better.
define i1 @test_return_bool(ptr %value, i8 %oldValue, i8 %newValue) {
; CHECK-LABEL: test_return_bool:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    and w8, w1, #0xff
; CHECK-NEXT:    ; kill: def $w2 killed $w2 def $x2
; CHECK-NEXT:  LBB1_1: ; %cmpxchg.start
; CHECK-NEXT:    ; =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldaxrb w9, [x0]
; CHECK-NEXT:    cmp w9, w8
; CHECK-NEXT:    b.ne LBB1_4
; CHECK-NEXT:  ; %bb.2: ; %cmpxchg.trystore
; CHECK-NEXT:    ; in Loop: Header=BB1_1 Depth=1
; CHECK-NEXT:    stlxrb w9, w2, [x0]
; CHECK-NEXT:    cbnz w9, LBB1_1
; CHECK-NEXT:  ; %bb.3:
; CHECK-NEXT:    mov w8, #1 ; =0x1
; CHECK-NEXT:    eor w0, w8, #0x1
; CHECK-NEXT:    ret
; CHECK-NEXT:  LBB1_4: ; %cmpxchg.nostore
; CHECK-NEXT:    eor w0, wzr, #0x1
; CHECK-NEXT:    clrex
; CHECK-NEXT:    ret
;
; OUTLINE-ATOMICS-LABEL: test_return_bool:
; OUTLINE-ATOMICS:       ; %bb.0:
; OUTLINE-ATOMICS-NEXT:    stp x20, x19, [sp, #-32]! ; 16-byte Folded Spill
; OUTLINE-ATOMICS-NEXT:    stp x29, x30, [sp, #16] ; 16-byte Folded Spill
; OUTLINE-ATOMICS-NEXT:    .cfi_def_cfa_offset 32
; OUTLINE-ATOMICS-NEXT:    .cfi_offset w30, -8
; OUTLINE-ATOMICS-NEXT:    .cfi_offset w29, -16
; OUTLINE-ATOMICS-NEXT:    .cfi_offset w19, -24
; OUTLINE-ATOMICS-NEXT:    .cfi_offset w20, -32
; OUTLINE-ATOMICS-NEXT:    mov x8, x0
; OUTLINE-ATOMICS-NEXT:    mov w19, w1
; OUTLINE-ATOMICS-NEXT:    mov w0, w1
; OUTLINE-ATOMICS-NEXT:    mov w1, w2
; OUTLINE-ATOMICS-NEXT:    mov x2, x8
; OUTLINE-ATOMICS-NEXT:    bl ___aarch64_cas1_acq_rel
; OUTLINE-ATOMICS-NEXT:    cmp w0, w19, uxtb
; OUTLINE-ATOMICS-NEXT:    ldp x29, x30, [sp, #16] ; 16-byte Folded Reload
; OUTLINE-ATOMICS-NEXT:    cset w8, eq
; OUTLINE-ATOMICS-NEXT:    eor w0, w8, #0x1
; OUTLINE-ATOMICS-NEXT:    ldp x20, x19, [sp], #32 ; 16-byte Folded Reload
; OUTLINE-ATOMICS-NEXT:    ret
  %pair = cmpxchg ptr %value, i8 %oldValue, i8 %newValue acq_rel monotonic
  %success = extractvalue { i8, i1 } %pair, 1
  %failure = xor i1 %success, 1
  ret i1 %failure
}

define void @test_conditional(ptr %p, i32 %oldval, i32 %newval) {
; CHECK-LABEL: test_conditional:
; CHECK:       ; %bb.0:
; CHECK-NEXT:  LBB2_1: ; %cmpxchg.start
; CHECK-NEXT:    ; =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldaxr w8, [x0]
; CHECK-NEXT:    cmp w8, w1
; CHECK-NEXT:    b.ne LBB2_4
; CHECK-NEXT:  ; %bb.2: ; %cmpxchg.trystore
; CHECK-NEXT:    ; in Loop: Header=BB2_1 Depth=1
; CHECK-NEXT:    stlxr w8, w2, [x0]
; CHECK-NEXT:    cbnz w8, LBB2_1
; CHECK-NEXT:  ; %bb.3: ; %true
; CHECK-NEXT:    b _bar
; CHECK-NEXT:  LBB2_4: ; %cmpxchg.nostore
; CHECK-NEXT:    clrex
; CHECK-NEXT:    b _baz
;
; OUTLINE-ATOMICS-LABEL: test_conditional:
; OUTLINE-ATOMICS:       ; %bb.0:
; OUTLINE-ATOMICS-NEXT:    stp x20, x19, [sp, #-32]! ; 16-byte Folded Spill
; OUTLINE-ATOMICS-NEXT:    stp x29, x30, [sp, #16] ; 16-byte Folded Spill
; OUTLINE-ATOMICS-NEXT:    .cfi_def_cfa_offset 32
; OUTLINE-ATOMICS-NEXT:    .cfi_offset w30, -8
; OUTLINE-ATOMICS-NEXT:    .cfi_offset w29, -16
; OUTLINE-ATOMICS-NEXT:    .cfi_offset w19, -24
; OUTLINE-ATOMICS-NEXT:    .cfi_offset w20, -32
; OUTLINE-ATOMICS-NEXT:    mov x8, x0
; OUTLINE-ATOMICS-NEXT:    mov w19, w1
; OUTLINE-ATOMICS-NEXT:    mov w0, w1
; OUTLINE-ATOMICS-NEXT:    mov w1, w2
; OUTLINE-ATOMICS-NEXT:    mov x2, x8
; OUTLINE-ATOMICS-NEXT:    bl ___aarch64_cas4_acq_rel
; OUTLINE-ATOMICS-NEXT:    cmp w0, w19
; OUTLINE-ATOMICS-NEXT:    b.ne LBB2_2
; OUTLINE-ATOMICS-NEXT:  ; %bb.1: ; %true
; OUTLINE-ATOMICS-NEXT:    ldp x29, x30, [sp, #16] ; 16-byte Folded Reload
; OUTLINE-ATOMICS-NEXT:    ldp x20, x19, [sp], #32 ; 16-byte Folded Reload
; OUTLINE-ATOMICS-NEXT:    b _bar
; OUTLINE-ATOMICS-NEXT:  LBB2_2: ; %false
; OUTLINE-ATOMICS-NEXT:    ldp x29, x30, [sp, #16] ; 16-byte Folded Reload
; OUTLINE-ATOMICS-NEXT:    ldp x20, x19, [sp], #32 ; 16-byte Folded Reload
; OUTLINE-ATOMICS-NEXT:    b _baz
  %pair = cmpxchg ptr %p, i32 %oldval, i32 %newval seq_cst seq_cst
  %success = extractvalue { i32, i1 } %pair, 1
  br i1 %success, label %true, label %false

true:
  tail call void @bar() #2
  br label %end

false:
  tail call void @baz() #2
  br label %end

end:
  ret void
}

declare void @bar()
declare void @baz()

; verify the preheader is simplified by simplifycfg.
define i1 @test_conditional2(i32 %a, i32 %b, ptr %c) {
; CHECK-LABEL: test_conditional2:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    stp x22, x21, [sp, #-48]! ; 16-byte Folded Spill
; CHECK-NEXT:    stp x20, x19, [sp, #16] ; 16-byte Folded Spill
; CHECK-NEXT:    stp x29, x30, [sp, #32] ; 16-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 48
; CHECK-NEXT:    .cfi_offset w30, -8
; CHECK-NEXT:    .cfi_offset w29, -16
; CHECK-NEXT:    .cfi_offset w19, -24
; CHECK-NEXT:    .cfi_offset w20, -32
; CHECK-NEXT:    .cfi_offset w21, -40
; CHECK-NEXT:    .cfi_offset w22, -48
; CHECK-NEXT:    mov x19, x2
; CHECK-NEXT:    mov w20, w1
; CHECK-NEXT:    mov w21, w0
; CHECK-NEXT:  LBB3_1: ; %cmpxchg.start
; CHECK-NEXT:    ; =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldaxr w8, [x19]
; CHECK-NEXT:    cmp w8, w21
; CHECK-NEXT:    b.ne LBB3_4
; CHECK-NEXT:  ; %bb.2: ; %cmpxchg.trystore
; CHECK-NEXT:    ; in Loop: Header=BB3_1 Depth=1
; CHECK-NEXT:    stlxr w8, w20, [x19]
; CHECK-NEXT:    cbnz w8, LBB3_1
; CHECK-NEXT:  ; %bb.3:
; CHECK-NEXT:    mov w8, #1 ; =0x1
; CHECK-NEXT:    b LBB3_5
; CHECK-NEXT:  LBB3_4: ; %cmpxchg.nostore
; CHECK-NEXT:    mov w8, wzr
; CHECK-NEXT:    clrex
; CHECK-NEXT:  LBB3_5: ; %for.cond.preheader
; CHECK-NEXT:    mov w22, #2 ; =0x2
; CHECK-NEXT:  LBB3_6: ; %for.cond
; CHECK-NEXT:    ; =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    cbz w22, LBB3_9
; CHECK-NEXT:  ; %bb.7: ; %for.body
; CHECK-NEXT:    ; in Loop: Header=BB3_6 Depth=1
; CHECK-NEXT:    sub w22, w22, #1
; CHECK-NEXT:    orr w9, w21, w20
; CHECK-NEXT:    ldr w10, [x19, w22, sxtw #2]
; CHECK-NEXT:    cmp w9, w10
; CHECK-NEXT:    b.eq LBB3_6
; CHECK-NEXT:  ; %bb.8: ; %if.then
; CHECK-NEXT:    ; in Loop: Header=BB3_6 Depth=1
; CHECK-NEXT:    str w9, [x19, w22, sxtw #2]
; CHECK-NEXT:    bl _foo
; CHECK-NEXT:    mov w8, wzr
; CHECK-NEXT:    b LBB3_6
; CHECK-NEXT:  LBB3_9: ; %for.cond.cleanup
; CHECK-NEXT:    ldp x29, x30, [sp, #32] ; 16-byte Folded Reload
; CHECK-NEXT:    and w0, w8, #0x1
; CHECK-NEXT:    ldp x20, x19, [sp, #16] ; 16-byte Folded Reload
; CHECK-NEXT:    ldp x22, x21, [sp], #48 ; 16-byte Folded Reload
; CHECK-NEXT:    ret
;
; OUTLINE-ATOMICS-LABEL: test_conditional2:
; OUTLINE-ATOMICS:       ; %bb.0: ; %entry
; OUTLINE-ATOMICS-NEXT:    stp x22, x21, [sp, #-48]! ; 16-byte Folded Spill
; OUTLINE-ATOMICS-NEXT:    stp x20, x19, [sp, #16] ; 16-byte Folded Spill
; OUTLINE-ATOMICS-NEXT:    stp x29, x30, [sp, #32] ; 16-byte Folded Spill
; OUTLINE-ATOMICS-NEXT:    .cfi_def_cfa_offset 48
; OUTLINE-ATOMICS-NEXT:    .cfi_offset w30, -8
; OUTLINE-ATOMICS-NEXT:    .cfi_offset w29, -16
; OUTLINE-ATOMICS-NEXT:    .cfi_offset w19, -24
; OUTLINE-ATOMICS-NEXT:    .cfi_offset w20, -32
; OUTLINE-ATOMICS-NEXT:    .cfi_offset w21, -40
; OUTLINE-ATOMICS-NEXT:    .cfi_offset w22, -48
; OUTLINE-ATOMICS-NEXT:    mov x19, x2
; OUTLINE-ATOMICS-NEXT:    mov w20, w1
; OUTLINE-ATOMICS-NEXT:    mov w21, w0
; OUTLINE-ATOMICS-NEXT:    bl ___aarch64_cas4_acq_rel
; OUTLINE-ATOMICS-NEXT:    cmp w0, w21
; OUTLINE-ATOMICS-NEXT:    mov w22, #2 ; =0x2
; OUTLINE-ATOMICS-NEXT:    cset w8, eq
; OUTLINE-ATOMICS-NEXT:  LBB3_1: ; %for.cond
; OUTLINE-ATOMICS-NEXT:    ; =>This Inner Loop Header: Depth=1
; OUTLINE-ATOMICS-NEXT:    cbz w22, LBB3_4
; OUTLINE-ATOMICS-NEXT:  ; %bb.2: ; %for.body
; OUTLINE-ATOMICS-NEXT:    ; in Loop: Header=BB3_1 Depth=1
; OUTLINE-ATOMICS-NEXT:    sub w22, w22, #1
; OUTLINE-ATOMICS-NEXT:    orr w9, w21, w20
; OUTLINE-ATOMICS-NEXT:    ldr w10, [x19, w22, sxtw #2]
; OUTLINE-ATOMICS-NEXT:    cmp w9, w10
; OUTLINE-ATOMICS-NEXT:    b.eq LBB3_1
; OUTLINE-ATOMICS-NEXT:  ; %bb.3: ; %if.then
; OUTLINE-ATOMICS-NEXT:    ; in Loop: Header=BB3_1 Depth=1
; OUTLINE-ATOMICS-NEXT:    str w9, [x19, w22, sxtw #2]
; OUTLINE-ATOMICS-NEXT:    bl _foo
; OUTLINE-ATOMICS-NEXT:    mov w8, wzr
; OUTLINE-ATOMICS-NEXT:    b LBB3_1
; OUTLINE-ATOMICS-NEXT:  LBB3_4: ; %for.cond.cleanup
; OUTLINE-ATOMICS-NEXT:    ldp x29, x30, [sp, #32] ; 16-byte Folded Reload
; OUTLINE-ATOMICS-NEXT:    and w0, w8, #0x1
; OUTLINE-ATOMICS-NEXT:    ldp x20, x19, [sp, #16] ; 16-byte Folded Reload
; OUTLINE-ATOMICS-NEXT:    ldp x22, x21, [sp], #48 ; 16-byte Folded Reload
; OUTLINE-ATOMICS-NEXT:    ret
entry:
  %pair = cmpxchg ptr %c, i32 %a, i32 %b seq_cst seq_cst
  %success = extractvalue { i32, i1 } %pair, 1
  br label %for.cond

for.cond:                                         ; preds = %if.end, %entry
  %i.0 = phi i32 [ 2, %entry ], [ %dec, %if.end ]
  %changed.0.off0 = phi i1 [ %success, %entry ], [ %changed.1.off0, %if.end ]
  %dec = add nsw i32 %i.0, -1
  %tobool = icmp eq i32 %i.0, 0
  br i1 %tobool, label %for.cond.cleanup, label %for.body

for.cond.cleanup:                                 ; preds = %for.cond
  %changed.0.off0.lcssa = phi i1 [ %changed.0.off0, %for.cond ]
  ret i1 %changed.0.off0.lcssa

for.body:                                         ; preds = %for.cond
  %or = or i32 %a, %b
  %idxprom = sext i32 %dec to i64
  %arrayidx = getelementptr inbounds i32, ptr %c, i64 %idxprom
  %0 = load i32, ptr %arrayidx, align 4
  %cmp = icmp eq i32 %or, %0
  br i1 %cmp, label %if.end, label %if.then

if.then:                                          ; preds = %for.body
  store i32 %or, ptr %arrayidx, align 4
  tail call void @foo()
  br label %if.end

if.end:                                           ; preds = %for.body, %if.then
  %changed.1.off0 = phi i1 [ false, %if.then ], [ %changed.0.off0, %for.body ]
  br label %for.cond
}

declare void @foo()
