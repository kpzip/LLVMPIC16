; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown -mattr=+ndd -verify-machineinstrs --show-mc-encoding | FileCheck %s

define i8 @rol8m1(ptr %ptr) {
; CHECK-LABEL: rol8m1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    rolb (%rdi), %al # encoding: [0x62,0xf4,0x7c,0x18,0xd0,0x07]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %a = load i8, ptr %ptr
  %0 = shl i8 %a, 1
  %1 = lshr i8 %a, 7
  %rol = or i8 %0, %1
  ret i8 %rol
}

define i8 @rol8m1_intrinsic(ptr %ptr)  {
; CHECK-LABEL: rol8m1_intrinsic:
; CHECK:       # %bb.0:
; CHECK-NEXT:    rolb (%rdi), %al # encoding: [0x62,0xf4,0x7c,0x18,0xd0,0x07]
; CHECK-NEXT:    retq # encoding: [0xc3]
  %a = load i8, ptr %ptr
  %f = call i8 @llvm.fshr.i8(i8 %a, i8 %a, i8 7)
  ret i8 %f
}

define i16 @rol16m1(ptr %ptr) {
; CHECK-LABEL: rol16m1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    rolw (%rdi), %ax # encoding: [0x62,0xf4,0x7d,0x18,0xd1,0x07]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %a = load i16, ptr %ptr
  %0 = shl i16 %a, 1
  %1 = lshr i16 %a, 15
  %rol = or i16 %0, %1
  ret i16 %rol
}

define i16 @rol16m1_intrinsic(ptr %ptr)  {
; CHECK-LABEL: rol16m1_intrinsic:
; CHECK:       # %bb.0:
; CHECK-NEXT:    rolw (%rdi), %ax # encoding: [0x62,0xf4,0x7d,0x18,0xd1,0x07]
; CHECK-NEXT:    retq # encoding: [0xc3]
  %a = load i16, ptr %ptr
  %f = call i16 @llvm.fshr.i16(i16 %a, i16 %a, i16 15)
  ret i16 %f
}

define i32 @rol32m1(ptr %ptr) {
; CHECK-LABEL: rol32m1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    roll (%rdi), %eax # encoding: [0x62,0xf4,0x7c,0x18,0xd1,0x07]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %a = load i32, ptr %ptr
  %0 = shl i32 %a, 1
  %1 = lshr i32 %a, 31
  %rol = or i32 %0, %1
  ret i32 %rol
}

define i32 @rol32m1_intrinsic(ptr %ptr)  {
; CHECK-LABEL: rol32m1_intrinsic:
; CHECK:       # %bb.0:
; CHECK-NEXT:    roll (%rdi), %eax # encoding: [0x62,0xf4,0x7c,0x18,0xd1,0x07]
; CHECK-NEXT:    retq # encoding: [0xc3]
  %a = load i32, ptr %ptr
  %f = call i32 @llvm.fshr.i32(i32 %a, i32 %a, i32 31)
  ret i32 %f
}

define i64 @rol64m1(ptr %ptr) {
; CHECK-LABEL: rol64m1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    rolq (%rdi), %rax # encoding: [0x62,0xf4,0xfc,0x18,0xd1,0x07]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %a = load i64, ptr %ptr
  %0 = shl i64 %a, 1
  %1 = lshr i64 %a, 63
  %rol = or i64 %0, %1
  ret i64 %rol
}

define i64 @rol64m1_intrinsic(ptr %ptr)  {
; CHECK-LABEL: rol64m1_intrinsic:
; CHECK:       # %bb.0:
; CHECK-NEXT:    rolq (%rdi), %rax # encoding: [0x62,0xf4,0xfc,0x18,0xd1,0x07]
; CHECK-NEXT:    retq # encoding: [0xc3]
  %a = load i64, ptr %ptr
  %f = call i64 @llvm.fshr.i64(i64 %a, i64 %a, i64 63)
  ret i64 %f
}

define i8 @rol8mcl(ptr %ptr, i8 %cl) {
; CHECK-LABEL: rol8mcl:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movl %esi, %ecx # encoding: [0x89,0xf1]
; CHECK-NEXT:    # kill: def $cl killed $cl killed $ecx
; CHECK-NEXT:    rolb %cl, (%rdi), %al # encoding: [0x62,0xf4,0x7c,0x18,0xd2,0x07]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %a = load i8, ptr %ptr
  %0 = shl i8 %a, %cl
  %1 = sub i8 8, %cl
  %2 = lshr i8 %a, %1
  %rol = or i8 %0, %2
  ret i8 %rol
}

define i16 @rol16mcl(ptr %ptr, i16 %cl) {
; CHECK-LABEL: rol16mcl:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movl %esi, %ecx # encoding: [0x89,0xf1]
; CHECK-NEXT:    # kill: def $cl killed $cl killed $ecx
; CHECK-NEXT:    rolw %cl, (%rdi), %ax # encoding: [0x62,0xf4,0x7d,0x18,0xd3,0x07]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %a = load i16, ptr %ptr
  %0 = shl i16 %a, %cl
  %1 = sub i16 16, %cl
  %2 = lshr i16 %a, %1
  %rol = or i16 %0, %2
  ret i16 %rol
}

define i32 @rol32mcl(ptr %ptr, i32 %cl) {
; CHECK-LABEL: rol32mcl:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movl %esi, %ecx # encoding: [0x89,0xf1]
; CHECK-NEXT:    # kill: def $cl killed $cl killed $ecx
; CHECK-NEXT:    roll %cl, (%rdi), %eax # encoding: [0x62,0xf4,0x7c,0x18,0xd3,0x07]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %a = load i32, ptr %ptr
  %0 = shl i32 %a, %cl
  %1 = sub i32 32, %cl
  %2 = lshr i32 %a, %1
  %rol = or i32 %0, %2
  ret i32 %rol
}

define i64 @rol64mcl(ptr %ptr, i64 %cl) {
; CHECK-LABEL: rol64mcl:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movq %rsi, %rcx # encoding: [0x48,0x89,0xf1]
; CHECK-NEXT:    # kill: def $cl killed $cl killed $rcx
; CHECK-NEXT:    rolq %cl, (%rdi), %rax # encoding: [0x62,0xf4,0xfc,0x18,0xd3,0x07]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %a = load i64, ptr %ptr
  %0 = shl i64 %a, %cl
  %1 = sub i64 64, %cl
  %2 = lshr i64 %a, %1
  %rol = or i64 %0, %2
  ret i64 %rol
}

define i8 @rol8mi(ptr %ptr) {
; CHECK-LABEL: rol8mi:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    rolb $3, (%rdi), %al # encoding: [0x62,0xf4,0x7c,0x18,0xc0,0x07,0x03]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %a = load i8, ptr %ptr
  %0 = shl i8 %a, 3
  %1 = lshr i8 %a, 5
  %rol = or i8 %0, %1
  ret i8 %rol
}

define i16 @rol16mi(ptr %ptr) {
; CHECK-LABEL: rol16mi:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    rolw $3, (%rdi), %ax # encoding: [0x62,0xf4,0x7d,0x18,0xc1,0x07,0x03]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %a = load i16, ptr %ptr
  %0 = shl i16 %a, 3
  %1 = lshr i16 %a, 13
  %rol = or i16 %0, %1
  ret i16 %rol
}

define i32 @rol32mi(ptr %ptr) {
; CHECK-LABEL: rol32mi:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    roll $3, (%rdi), %eax # encoding: [0x62,0xf4,0x7c,0x18,0xc1,0x07,0x03]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %a = load i32, ptr %ptr
  %0 = shl i32 %a, 3
  %1 = lshr i32 %a, 29
  %rol = or i32 %0, %1
  ret i32 %rol
}

define i64 @rol64mi(ptr %ptr) {
; CHECK-LABEL: rol64mi:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    rolq $3, (%rdi), %rax # encoding: [0x62,0xf4,0xfc,0x18,0xc1,0x07,0x03]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %a = load i64, ptr %ptr
  %0 = shl i64 %a, 3
  %1 = lshr i64 %a, 61
  %rol = or i64 %0, %1
  ret i64 %rol
}

define i8 @rol8r1(i8 noundef %a) {
; CHECK-LABEL: rol8r1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    rolb %dil, %al # encoding: [0x62,0xf4,0x7c,0x18,0xd0,0xc7]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %0 = shl i8 %a, 1
  %1 = lshr i8 %a, 7
  %rol = or i8 %0, %1
  ret i8 %rol
}

define i8 @rol8r1_intrinsic(i8 noundef %a)  {
; CHECK-LABEL: rol8r1_intrinsic:
; CHECK:       # %bb.0:
; CHECK-NEXT:    rolb %dil, %al # encoding: [0x62,0xf4,0x7c,0x18,0xd0,0xc7]
; CHECK-NEXT:    retq # encoding: [0xc3]
  %f = call i8 @llvm.fshr.i8(i8 %a, i8 %a, i8 7)
  ret i8 %f
}

define i16 @rol16r1(i16 noundef %a) {
; CHECK-LABEL: rol16r1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    rolw %di, %ax # encoding: [0x62,0xf4,0x7d,0x18,0xd1,0xc7]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %0 = shl i16 %a, 1
  %1 = lshr i16 %a, 15
  %rol = or i16 %0, %1
  ret i16 %rol
}

define i16 @rol16r1_intrinsic(i16 noundef %a)  {
; CHECK-LABEL: rol16r1_intrinsic:
; CHECK:       # %bb.0:
; CHECK-NEXT:    rolw %di, %ax # encoding: [0x62,0xf4,0x7d,0x18,0xd1,0xc7]
; CHECK-NEXT:    retq # encoding: [0xc3]
  %f = call i16 @llvm.fshr.i16(i16 %a, i16 %a, i16 15)
  ret i16 %f
}

define i32 @rol32r1(i32 noundef %a) {
; CHECK-LABEL: rol32r1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    roll %edi, %eax # encoding: [0x62,0xf4,0x7c,0x18,0xd1,0xc7]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %0 = shl i32 %a, 1
  %1 = lshr i32 %a, 31
  %rol = or i32 %0, %1
  ret i32 %rol
}

define i32 @rol32r1_intrinsic(i32 noundef %a)  {
; CHECK-LABEL: rol32r1_intrinsic:
; CHECK:       # %bb.0:
; CHECK-NEXT:    roll %edi, %eax # encoding: [0x62,0xf4,0x7c,0x18,0xd1,0xc7]
; CHECK-NEXT:    retq # encoding: [0xc3]
  %f = call i32 @llvm.fshr.i32(i32 %a, i32 %a, i32 31)
  ret i32 %f
}

define i64 @rol64r1(i64 noundef %a) {
; CHECK-LABEL: rol64r1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    rolq %rdi, %rax # encoding: [0x62,0xf4,0xfc,0x18,0xd1,0xc7]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %0 = shl i64 %a, 1
  %1 = lshr i64 %a, 63
  %rol = or i64 %0, %1
  ret i64 %rol
}

define i64 @rol64r1_intrinsic(i64 noundef %a)  {
; CHECK-LABEL: rol64r1_intrinsic:
; CHECK:       # %bb.0:
; CHECK-NEXT:    rolq %rdi, %rax # encoding: [0x62,0xf4,0xfc,0x18,0xd1,0xc7]
; CHECK-NEXT:    retq # encoding: [0xc3]
  %f = call i64 @llvm.fshr.i64(i64 %a, i64 %a, i64 63)
  ret i64 %f
}

define i8 @rol8rcl(i8 noundef %a, i8 %cl) {
; CHECK-LABEL: rol8rcl:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movl %esi, %ecx # encoding: [0x89,0xf1]
; CHECK-NEXT:    # kill: def $cl killed $cl killed $ecx
; CHECK-NEXT:    rolb %cl, %dil, %al # encoding: [0x62,0xf4,0x7c,0x18,0xd2,0xc7]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %0 = shl i8 %a, %cl
  %1 = sub i8 8, %cl
  %2 = lshr i8 %a, %1
  %rol = or i8 %0, %2
  ret i8 %rol
}

define i16 @rol16rcl(i16 noundef %a, i16 %cl) {
; CHECK-LABEL: rol16rcl:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movl %esi, %ecx # encoding: [0x89,0xf1]
; CHECK-NEXT:    # kill: def $cl killed $cl killed $ecx
; CHECK-NEXT:    rolw %cl, %di, %ax # encoding: [0x62,0xf4,0x7d,0x18,0xd3,0xc7]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %0 = shl i16 %a, %cl
  %1 = sub i16 16, %cl
  %2 = lshr i16 %a, %1
  %rol = or i16 %0, %2
  ret i16 %rol
}

define i32 @rol32rcl(i32 noundef %a, i32 %cl) {
; CHECK-LABEL: rol32rcl:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movl %esi, %ecx # encoding: [0x89,0xf1]
; CHECK-NEXT:    # kill: def $cl killed $cl killed $ecx
; CHECK-NEXT:    roll %cl, %edi, %eax # encoding: [0x62,0xf4,0x7c,0x18,0xd3,0xc7]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %0 = shl i32 %a, %cl
  %1 = sub i32 32, %cl
  %2 = lshr i32 %a, %1
  %rol = or i32 %0, %2
  ret i32 %rol
}

define i64 @rol64rcl(i64 noundef %a, i64 %cl) {
; CHECK-LABEL: rol64rcl:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movq %rsi, %rcx # encoding: [0x48,0x89,0xf1]
; CHECK-NEXT:    # kill: def $cl killed $cl killed $rcx
; CHECK-NEXT:    rolq %cl, %rdi, %rax # encoding: [0x62,0xf4,0xfc,0x18,0xd3,0xc7]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %0 = shl i64 %a, %cl
  %1 = sub i64 64, %cl
  %2 = lshr i64 %a, %1
  %rol = or i64 %0, %2
  ret i64 %rol
}

define i8 @rol8ri(i8 noundef %a) {
; CHECK-LABEL: rol8ri:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    rolb $3, %dil, %al # encoding: [0x62,0xf4,0x7c,0x18,0xc0,0xc7,0x03]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %0 = shl i8 %a, 3
  %1 = lshr i8 %a, 5
  %rol = or i8 %0, %1
  ret i8 %rol
}

define i16 @rol16ri(i16 noundef %a) {
; CHECK-LABEL: rol16ri:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    rolw $3, %di, %ax # encoding: [0x62,0xf4,0x7d,0x18,0xc1,0xc7,0x03]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %0 = shl i16 %a, 3
  %1 = lshr i16 %a, 13
  %rol = or i16 %0, %1
  ret i16 %rol
}

define i32 @rol32ri(i32 noundef %a) {
; CHECK-LABEL: rol32ri:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    roll $3, %edi, %eax # encoding: [0x62,0xf4,0x7c,0x18,0xc1,0xc7,0x03]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %0 = shl i32 %a, 3
  %1 = lshr i32 %a, 29
  %rol = or i32 %0, %1
  ret i32 %rol
}

define i64 @rol64ri(i64 noundef %a) {
; CHECK-LABEL: rol64ri:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    rolq $3, %rdi, %rax # encoding: [0x62,0xf4,0xfc,0x18,0xc1,0xc7,0x03]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %0 = shl i64 %a, 3
  %1 = lshr i64 %a, 61
  %rol = or i64 %0, %1
  ret i64 %rol
}

define void @rol8m1_legacy(ptr %ptr) {
; CHECK-LABEL: rol8m1_legacy:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    rolb (%rdi) # encoding: [0xd0,0x07]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %a = load i8, ptr %ptr
  %0 = shl i8 %a, 1
  %1 = lshr i8 %a, 7
  %rol = or i8 %0, %1
  store i8 %rol, ptr %ptr
  ret void
}

define void @rol16m1_legacy(ptr %ptr) {
; CHECK-LABEL: rol16m1_legacy:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    rolw (%rdi) # encoding: [0x66,0xd1,0x07]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %a = load i16, ptr %ptr
  %0 = shl i16 %a, 1
  %1 = lshr i16 %a, 15
  %rol = or i16 %0, %1
  store i16 %rol, ptr %ptr
  ret void
}

define void @rol32m1_legacy(ptr %ptr) {
; CHECK-LABEL: rol32m1_legacy:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    roll (%rdi) # encoding: [0xd1,0x07]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %a = load i32, ptr %ptr
  %0 = shl i32 %a, 1
  %1 = lshr i32 %a, 31
  %rol = or i32 %0, %1
  store i32 %rol, ptr %ptr
  ret void
}

define void @rol64m1_legacy(ptr %ptr) {
; CHECK-LABEL: rol64m1_legacy:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    rolq (%rdi) # encoding: [0x48,0xd1,0x07]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %a = load i64, ptr %ptr
  %0 = shl i64 %a, 1
  %1 = lshr i64 %a, 63
  %rol = or i64 %0, %1
  store i64 %rol, ptr %ptr
  ret void
}

define void @rol8mcl_legacy(ptr %ptr, i8 %cl) {
; CHECK-LABEL: rol8mcl_legacy:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movl %esi, %ecx # encoding: [0x89,0xf1]
; CHECK-NEXT:    # kill: def $cl killed $cl killed $ecx
; CHECK-NEXT:    rolb %cl, (%rdi) # encoding: [0xd2,0x07]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %a = load i8, ptr %ptr
  %0 = shl i8 %a, %cl
  %1 = sub i8 8, %cl
  %2 = lshr i8 %a, %1
  %rol = or i8 %0, %2
  store i8 %rol, ptr %ptr
  ret void
}

define void @rol16mcl_legacy(ptr %ptr, i16 %cl) {
; CHECK-LABEL: rol16mcl_legacy:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movl %esi, %ecx # encoding: [0x89,0xf1]
; CHECK-NEXT:    # kill: def $cl killed $cl killed $ecx
; CHECK-NEXT:    rolw %cl, (%rdi) # encoding: [0x66,0xd3,0x07]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %a = load i16, ptr %ptr
  %0 = shl i16 %a, %cl
  %1 = sub i16 16, %cl
  %2 = lshr i16 %a, %1
  %rol = or i16 %0, %2
  store i16 %rol, ptr %ptr
  ret void
}

define void @rol32mcl_legacy(ptr %ptr, i32 %cl) {
; CHECK-LABEL: rol32mcl_legacy:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movl %esi, %ecx # encoding: [0x89,0xf1]
; CHECK-NEXT:    # kill: def $cl killed $cl killed $ecx
; CHECK-NEXT:    roll %cl, (%rdi) # encoding: [0xd3,0x07]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %a = load i32, ptr %ptr
  %0 = shl i32 %a, %cl
  %1 = sub i32 32, %cl
  %2 = lshr i32 %a, %1
  %rol = or i32 %0, %2
  store i32 %rol, ptr %ptr
  ret void
}

define void @rol64mcl_legacy(ptr %ptr, i64 %cl) {
; CHECK-LABEL: rol64mcl_legacy:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movq %rsi, %rcx # encoding: [0x48,0x89,0xf1]
; CHECK-NEXT:    # kill: def $cl killed $cl killed $rcx
; CHECK-NEXT:    rolq %cl, (%rdi) # encoding: [0x48,0xd3,0x07]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %a = load i64, ptr %ptr
  %0 = shl i64 %a, %cl
  %1 = sub i64 64, %cl
  %2 = lshr i64 %a, %1
  %rol = or i64 %0, %2
  store i64 %rol, ptr %ptr
  ret void
}

define void @rol8mi_legacy(ptr %ptr) {
; CHECK-LABEL: rol8mi_legacy:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    rolb $3, (%rdi) # encoding: [0xc0,0x07,0x03]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %a = load i8, ptr %ptr
  %0 = shl i8 %a, 3
  %1 = lshr i8 %a, 5
  %rol = or i8 %0, %1
  store i8 %rol, ptr %ptr
  ret void
}

define void @rol16mi_legacy(ptr %ptr) {
; CHECK-LABEL: rol16mi_legacy:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    rolw $3, (%rdi) # encoding: [0x66,0xc1,0x07,0x03]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %a = load i16, ptr %ptr
  %0 = shl i16 %a, 3
  %1 = lshr i16 %a, 13
  %rol = or i16 %0, %1
  store i16 %rol, ptr %ptr
  ret void
}

define void @rol32mi_legacy(ptr %ptr) {
; CHECK-LABEL: rol32mi_legacy:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    roll $3, (%rdi) # encoding: [0xc1,0x07,0x03]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %a = load i32, ptr %ptr
  %0 = shl i32 %a, 3
  %1 = lshr i32 %a, 29
  %rol = or i32 %0, %1
  store i32 %rol, ptr %ptr
  ret void
}

define void @rol64mi_legacy(ptr %ptr) {
; CHECK-LABEL: rol64mi_legacy:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    rolq $3, (%rdi) # encoding: [0x48,0xc1,0x07,0x03]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %a = load i64, ptr %ptr
  %0 = shl i64 %a, 3
  %1 = lshr i64 %a, 61
  %rol = or i64 %0, %1
  store i64 %rol, ptr %ptr
  ret void
}
