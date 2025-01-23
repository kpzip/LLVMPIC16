; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-pc-linux-gnux32 -mattr=+ndd -verify-machineinstrs | FileCheck %s


define i32 @add32mi_SIB_ADSIZE(ptr nocapture noundef readonly %a, i32 noundef %b) {
; CHECK-LABEL: add32mi_SIB_ADSIZE:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movl 1164(%edi,%esi,4), %eax
; CHECK-NEXT:    addl $4660, %eax # imm = 0x1234
; CHECK-NEXT:    retq
entry:
  %add.ptr = getelementptr inbounds i32, ptr %a, i32 %b
  %add.ptr1 = getelementptr inbounds i8, ptr %add.ptr, i32 1164
  %0 = load i32, ptr %add.ptr1
  %add = add nsw i32 %0, 4660
  ret i32 %add
}

declare ptr @llvm.thread.pointer()

define i32 @add32mi_FS_ADSIZE(i32 %i) {
; CHECK-LABEL: add32mi_FS_ADSIZE:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movl %fs:0, %eax
; CHECK-NEXT:    addl $4660, (%eax,%edi,4), %eax # imm = 0x1234
; CHECK-NEXT:    retq
entry:
  %0 = tail call ptr @llvm.thread.pointer()
  %arrayidx = getelementptr inbounds i32, ptr %0, i32 %i
  %1 = load i32, ptr %arrayidx
  %add = add nsw i32 %1, 4660
  ret i32 %add
}

define i32 @add32mi_FS_SIB(i32 %i) {
; CHECK-LABEL: add32mi_FS_SIB:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movl %fs:0, %eax
; CHECK-NEXT:    addl $4660, %eax # imm = 0x1234
; CHECK-NEXT:    retq
entry:
  %0 = tail call ptr @llvm.thread.pointer()
  %arrayidx = getelementptr inbounds i32, ptr %0, i32 0
  %1 = load i32, ptr %arrayidx
  %add = add nsw i32 %1, 4660
  ret i32 %add
}

define i32 @add32mi_GS_ADSIZE(ptr addrspace(256) %a) {
; CHECK-LABEL: add32mi_GS_ADSIZE:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movl %gs:4936(%edi), %eax
; CHECK-NEXT:    addl $123456, %eax # imm = 0x1E240
; CHECK-NEXT:    retq
entry:
  %arrayidx = getelementptr inbounds i32, ptr addrspace(256) %a, i32 1234
  %t = load i32, ptr addrspace(256) %arrayidx
  %add = add i32 %t, 123456
  ret i32 %add
}
