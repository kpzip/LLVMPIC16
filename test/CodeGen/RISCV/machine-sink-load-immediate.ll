; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc -mtriple=riscv64 < %s | FileCheck %s

define i1 @sink_li(ptr %text, ptr %text.addr.0) nounwind {
; CHECK-LABEL: sink_li:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    addi sp, sp, -32
; CHECK-NEXT:    sd ra, 24(sp) # 8-byte Folded Spill
; CHECK-NEXT:    sd s0, 16(sp) # 8-byte Folded Spill
; CHECK-NEXT:    sd s1, 8(sp) # 8-byte Folded Spill
; CHECK-NEXT:    sd s2, 0(sp) # 8-byte Folded Spill
; CHECK-NEXT:    mv s1, a1
; CHECK-NEXT:    mv s0, a0
; CHECK-NEXT:    call toupper
; CHECK-NEXT:    li a1, 0
; CHECK-NEXT:    beqz s0, .LBB0_26
; CHECK-NEXT:  # %bb.1: # %while.body.preheader
; CHECK-NEXT:    li a2, 1
; CHECK-NEXT:    li a3, 9
; CHECK-NEXT:    li a4, 32
; CHECK-NEXT:  .LBB0_2: # %while.body
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    bnez a2, .LBB0_4
; CHECK-NEXT:  # %bb.3: # %while.body
; CHECK-NEXT:    # in Loop: Header=BB0_2 Depth=1
; CHECK-NEXT:    bne a2, a3, .LBB0_16
; CHECK-NEXT:  .LBB0_4: # %while.body.1
; CHECK-NEXT:    # in Loop: Header=BB0_2 Depth=1
; CHECK-NEXT:    bnez a2, .LBB0_6
; CHECK-NEXT:  # %bb.5: # %while.body.1
; CHECK-NEXT:    # in Loop: Header=BB0_2 Depth=1
; CHECK-NEXT:    bne a2, a3, .LBB0_17
; CHECK-NEXT:  .LBB0_6: # %while.body.3
; CHECK-NEXT:    # in Loop: Header=BB0_2 Depth=1
; CHECK-NEXT:    bnez a2, .LBB0_8
; CHECK-NEXT:  # %bb.7: # %while.body.3
; CHECK-NEXT:    # in Loop: Header=BB0_2 Depth=1
; CHECK-NEXT:    bne a2, a4, .LBB0_19
; CHECK-NEXT:  .LBB0_8: # %while.body.4
; CHECK-NEXT:    # in Loop: Header=BB0_2 Depth=1
; CHECK-NEXT:    bnez a2, .LBB0_10
; CHECK-NEXT:  # %bb.9: # %while.body.4
; CHECK-NEXT:    # in Loop: Header=BB0_2 Depth=1
; CHECK-NEXT:    bne a2, a4, .LBB0_21
; CHECK-NEXT:  .LBB0_10: # %while.body.5
; CHECK-NEXT:    # in Loop: Header=BB0_2 Depth=1
; CHECK-NEXT:    bnez a2, .LBB0_12
; CHECK-NEXT:  # %bb.11: # %while.body.5
; CHECK-NEXT:    # in Loop: Header=BB0_2 Depth=1
; CHECK-NEXT:    bne a2, a3, .LBB0_23
; CHECK-NEXT:  .LBB0_12: # %while.body.6
; CHECK-NEXT:    # in Loop: Header=BB0_2 Depth=1
; CHECK-NEXT:    bnez a2, .LBB0_2
; CHECK-NEXT:  # %bb.13: # %while.body.6
; CHECK-NEXT:    # in Loop: Header=BB0_2 Depth=1
; CHECK-NEXT:    beq a2, a3, .LBB0_2
; CHECK-NEXT:  # %bb.14: # %while.body.6
; CHECK-NEXT:    beqz a2, .LBB0_24
; CHECK-NEXT:  # %bb.15: # %strdup.exit.split.loop.exit126
; CHECK-NEXT:    addi s0, s1, 7
; CHECK-NEXT:    j .LBB0_25
; CHECK-NEXT:  .LBB0_16: # %while.body
; CHECK-NEXT:    beqz a2, .LBB0_26
; CHECK-NEXT:    j .LBB0_18
; CHECK-NEXT:  .LBB0_17: # %while.body.1
; CHECK-NEXT:    beqz a2, .LBB0_24
; CHECK-NEXT:  .LBB0_18: # %strdup.exit.loopexit
; CHECK-NEXT:    li s0, 0
; CHECK-NEXT:    j .LBB0_25
; CHECK-NEXT:  .LBB0_19: # %while.body.3
; CHECK-NEXT:    beqz a2, .LBB0_24
; CHECK-NEXT:  # %bb.20: # %strdup.exit.split.loop.exit120
; CHECK-NEXT:    addi s0, s1, 4
; CHECK-NEXT:    j .LBB0_25
; CHECK-NEXT:  .LBB0_21: # %while.body.4
; CHECK-NEXT:    beqz a2, .LBB0_24
; CHECK-NEXT:  # %bb.22: # %strdup.exit.split.loop.exit122
; CHECK-NEXT:    addi s0, s1, 5
; CHECK-NEXT:    j .LBB0_25
; CHECK-NEXT:  .LBB0_23: # %while.body.5
; CHECK-NEXT:    bnez a2, .LBB0_25
; CHECK-NEXT:  .LBB0_24:
; CHECK-NEXT:    li a1, 0
; CHECK-NEXT:    j .LBB0_26
; CHECK-NEXT:  .LBB0_25: # %strdup.exit
; CHECK-NEXT:    li s1, 0
; CHECK-NEXT:    mv s2, a0
; CHECK-NEXT:    li a0, 0
; CHECK-NEXT:    mv a1, s0
; CHECK-NEXT:    jalr s1
; CHECK-NEXT:    li a0, 0
; CHECK-NEXT:    mv a1, s2
; CHECK-NEXT:    li a2, 0
; CHECK-NEXT:    jalr s1
; CHECK-NEXT:    li a1, 1
; CHECK-NEXT:  .LBB0_26: # %return
; CHECK-NEXT:    mv a0, a1
; CHECK-NEXT:    ld ra, 24(sp) # 8-byte Folded Reload
; CHECK-NEXT:    ld s0, 16(sp) # 8-byte Folded Reload
; CHECK-NEXT:    ld s1, 8(sp) # 8-byte Folded Reload
; CHECK-NEXT:    ld s2, 0(sp) # 8-byte Folded Reload
; CHECK-NEXT:    addi sp, sp, 32
; CHECK-NEXT:    ret
entry:
  %call = call i32 @toupper()
  %tobool.not = icmp eq ptr %text, null
  br i1 %tobool.not, label %return, label %while.body

while.body:                                       ; preds = %while.body.6, %while.body.6, %entry
  switch i8 1, label %strdup.exit.split.loop.exit114 [
    i8 1, label %while.body.1
    i8 9, label %while.body.1
    i8 0, label %return
  ]

while.body.1:                                     ; preds = %while.body, %while.body
  switch i8 1, label %strdup.exit [
    i8 1, label %while.body.3
    i8 9, label %while.body.3
    i8 0, label %return
  ]

while.body.3:                                     ; preds = %while.body.1, %while.body.1
  switch i8 1, label %strdup.exit.split.loop.exit120 [
    i8 32, label %while.body.4
    i8 1, label %while.body.4
    i8 0, label %return
  ]

while.body.4:                                     ; preds = %while.body.3, %while.body.3
  switch i8 1, label %strdup.exit.split.loop.exit122 [
    i8 32, label %while.body.5
    i8 1, label %while.body.5
    i8 0, label %return
  ]

while.body.5:                                     ; preds = %while.body.4, %while.body.4
  switch i8 1, label %strdup.exit.split.loop.exit124 [
    i8 1, label %while.body.6
    i8 9, label %while.body.6
    i8 0, label %return
  ]

while.body.6:                                     ; preds = %while.body.5, %while.body.5
  switch i8 1, label %strdup.exit.split.loop.exit126 [
    i8 1, label %while.body
    i8 9, label %while.body
    i8 0, label %return
  ]

strdup.exit.split.loop.exit114:        ; preds = %while.body
  br label %strdup.exit

strdup.exit.split.loop.exit120:        ; preds = %while.body.3
  %incdec.ptr.3.le = getelementptr i8, ptr %text.addr.0, i64 4
  br label %strdup.exit

strdup.exit.split.loop.exit122:        ; preds = %while.body.4
  %incdec.ptr.4.le = getelementptr i8, ptr %text.addr.0, i64 5
  br label %strdup.exit

strdup.exit.split.loop.exit124:        ; preds = %while.body.5
  br label %strdup.exit

strdup.exit.split.loop.exit126:        ; preds = %while.body.6
  %incdec.ptr.6.le = getelementptr i8, ptr %text.addr.0, i64 7
  br label %strdup.exit

strdup.exit:                           ; preds = %strdup.exit.split.loop.exit126, %strdup.exit.split.loop.exit124, %strdup.exit.split.loop.exit122, %strdup.exit.split.loop.exit120, %strdup.exit.split.loop.exit114, %while.body.1
  %text.addr.0.lcssa = phi ptr [ null, %strdup.exit.split.loop.exit114 ], [ %incdec.ptr.3.le, %strdup.exit.split.loop.exit120 ], [ %incdec.ptr.4.le, %strdup.exit.split.loop.exit122 ], [ %text, %strdup.exit.split.loop.exit124 ], [ %incdec.ptr.6.le, %strdup.exit.split.loop.exit126 ], [ null, %while.body.1 ]
  %call5.i = tail call ptr null(ptr null, ptr %text.addr.0.lcssa)
  %memchr64 = tail call ptr null(ptr null, i32 %call, i64 0)
  br label %return

return:                                           ; preds = %strdup.exit, %while.body.6, %while.body.5, %while.body.4, %while.body.3, %while.body.1, %while.body, %entry
  %retval.1 = phi i1 [ false, %entry ], [ true, %strdup.exit ], [ false, %while.body ], [ false, %while.body.1 ], [ false, %while.body.3 ], [ false, %while.body.4 ], [ false, %while.body.5 ], [ false, %while.body.6 ]
  ret i1 %retval.1
}

declare i32 @toupper()
