; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 4
; RUN: llc --mtriple aarch64-none-eabi < %s -mattr=-fp-armv8 | FileCheck %s

; See also clang/test/CodeGen/aarch64-soft-float-abi.c, which tests the clang
; parts of the soft-float ABI.

; FP types up to 64-bit are passed in a general purpose register.
define half @test0(half %a, half %b)  {
; CHECK-LABEL: test0:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov w0, w1
; CHECK-NEXT:    ret
entry:
  ret half %b
}

define bfloat @test1(i32 %a, bfloat %b) {
; CHECK-LABEL: test1:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov w0, w1
; CHECK-NEXT:    ret
entry:
  ret bfloat %b
}

define float @test2(i64 %a, float %b) {
; CHECK-LABEL: test2:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov w0, w1
; CHECK-NEXT:    ret
entry:
  ret float %b
}

define double @test3(half %a, double %b) {
; CHECK-LABEL: test3:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov x0, x1
; CHECK-NEXT:    ret
entry:
  ret double %b
}

; fp128 is passed in a pair of GPRs.
define fp128 @test4(fp128 %a, fp128 %b) {
; CHECK-LABEL: test4:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov x1, x3
; CHECK-NEXT:    mov x0, x2
; CHECK-NEXT:    ret
entry:
  ret fp128 %b
}

; fp128 is passed in an aligned pair of GPRs, leaving one register unused is
; necessary.
define fp128 @test5(float %a, fp128 %b) {
; CHECK-LABEL: test5:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov x1, x3
; CHECK-NEXT:    mov x0, x2
; CHECK-NEXT:    ret
entry:
  ret fp128 %b
}

; If the alignment of an fp128 leaves a register unused, it remains unused even
; if a later argument could fit in it.
define i64 @test6(i64 %a, fp128 %b, i64 %c) {
; CHECK-LABEL: test6:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov x0, x4
; CHECK-NEXT:    ret
entry:
  ret i64 %c
}

; HFAs are all bit-casted to integer types in the frontend when using the
; soft-float ABI, so they get passed in the same way as non-homeogeneous
; aggregates. The IR is identical to the equivalent integer types, so nothing
; to test here.

; The PCS for vector and HVA types is not defined by the soft-float ABI because
; these types are only defined by the ACLE when vector hardware is available,
; so nothing to test here.

; The front-end generates IR for va_arg which always reads from the integer
; register save area, and never the floating-point register save area. The
; layout of the va_list type remains the same, the floating-point related
; fields are unused. The only change needed in the backend is  in va_start, to
; not attempt to save the floating-point registers or set the FP fields in the
; va_list.
%struct.__va_list = type { ptr, ptr, ptr, i32, i32 }
declare void @llvm.va_start(ptr)
define double @test20(i32 %a, ...) {
; CHECK-LABEL: test20:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sub sp, sp, #96
; CHECK-NEXT:    .cfi_def_cfa_offset 96
; CHECK-NEXT:    mov w8, #-56 // =0xffffffc8
; CHECK-NEXT:    add x10, sp, #8
; CHECK-NEXT:    add x9, sp, #96
; CHECK-NEXT:    str x8, [sp, #88]
; CHECK-NEXT:    add x10, x10, #56
; CHECK-NEXT:    ldrsw x8, [sp, #88]
; CHECK-NEXT:    stp x1, x2, [sp, #8]
; CHECK-NEXT:    stp x3, x4, [sp, #24]
; CHECK-NEXT:    stp x5, x6, [sp, #40]
; CHECK-NEXT:    stp x7, x9, [sp, #56]
; CHECK-NEXT:    str x10, [sp, #72]
; CHECK-NEXT:    tbz w8, #31, .LBB7_3
; CHECK-NEXT:  // %bb.1: // %vaarg.maybe_reg
; CHECK-NEXT:    add w9, w8, #8
; CHECK-NEXT:    cmn w8, #8
; CHECK-NEXT:    str w9, [sp, #88]
; CHECK-NEXT:    b.gt .LBB7_3
; CHECK-NEXT:  // %bb.2: // %vaarg.in_reg
; CHECK-NEXT:    ldr x9, [sp, #72]
; CHECK-NEXT:    add x8, x9, x8
; CHECK-NEXT:    b .LBB7_4
; CHECK-NEXT:  .LBB7_3: // %vaarg.on_stack
; CHECK-NEXT:    ldr x8, [sp, #64]
; CHECK-NEXT:    add x9, x8, #8
; CHECK-NEXT:    str x9, [sp, #64]
; CHECK-NEXT:  .LBB7_4: // %vaarg.end
; CHECK-NEXT:    ldr x0, [x8]
; CHECK-NEXT:    add sp, sp, #96
; CHECK-NEXT:    ret
entry:
  %vl = alloca %struct.__va_list, align 8
  call void @llvm.va_start(ptr nonnull %vl)
  %gr_offs_p = getelementptr inbounds %struct.__va_list, ptr %vl, i64 0, i32 3
  %gr_offs = load i32, ptr %gr_offs_p, align 8
  %0 = icmp sgt i32 %gr_offs, -1
  br i1 %0, label %vaarg.on_stack, label %vaarg.maybe_reg

vaarg.maybe_reg:                                  ; preds = %entry
  %new_reg_offs = add nsw i32 %gr_offs, 8
  store i32 %new_reg_offs, ptr %gr_offs_p, align 8
  %inreg = icmp slt i32 %gr_offs, -7
  br i1 %inreg, label %vaarg.in_reg, label %vaarg.on_stack

vaarg.in_reg:                                     ; preds = %vaarg.maybe_reg
  %reg_top_p = getelementptr inbounds %struct.__va_list, ptr %vl, i64 0, i32 1
  %reg_top = load ptr, ptr %reg_top_p, align 8
  %1 = sext i32 %gr_offs to i64
  %2 = getelementptr inbounds i8, ptr %reg_top, i64 %1
  br label %vaarg.end

vaarg.on_stack:                                   ; preds = %vaarg.maybe_reg, %entry
  %stack = load ptr, ptr %vl, align 8
  %new_stack = getelementptr inbounds i8, ptr %stack, i64 8
  store ptr %new_stack, ptr %vl, align 8
  br label %vaarg.end

vaarg.end:                                        ; preds = %vaarg.on_stack, %vaarg.in_reg
  %vaargs.addr = phi ptr [ %2, %vaarg.in_reg ], [ %stack, %vaarg.on_stack ]
  %3 = load double, ptr %vaargs.addr, align 8
  ret double %3
}

