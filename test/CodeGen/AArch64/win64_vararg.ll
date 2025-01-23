; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=aarch64-pc-win32 | FileCheck %s

define void @pass_va(i32 %count, ...) nounwind {
; CHECK-LABEL: pass_va:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    str x30, [sp, #-80]! // 8-byte Folded Spill
; CHECK-NEXT:    add x8, sp, #24
; CHECK-NEXT:    add x0, sp, #24
; CHECK-NEXT:    stp x1, x2, [sp, #24]
; CHECK-NEXT:    stp x3, x4, [sp, #40]
; CHECK-NEXT:    stp x5, x6, [sp, #56]
; CHECK-NEXT:    str x7, [sp, #72]
; CHECK-NEXT:    str x8, [sp, #8]
; CHECK-NEXT:    bl other_func
; CHECK-NEXT:    ldr x30, [sp], #80 // 8-byte Folded Reload
; CHECK-NEXT:    ret
entry:
  %ap = alloca ptr, align 8
  call void @llvm.va_start(ptr %ap)
  %ap2 = load ptr, ptr %ap, align 8
  call void @other_func(ptr %ap2)
  ret void
}

declare void @other_func(ptr) local_unnamed_addr

declare void @llvm.va_start(ptr) nounwind
declare void @llvm.va_copy(ptr, ptr) nounwind

define ptr @f9(i64 %a0, i64 %a1, i64 %a2, i64 %a3, i64 %a4, i64 %a5, i64 %a6, i64 %a7, i64 %a8, ...) nounwind {
; CHECK-LABEL: f9:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sub sp, sp, #16
; CHECK-NEXT:    add x8, sp, #24
; CHECK-NEXT:    add x0, sp, #24
; CHECK-NEXT:    str x8, [sp, #8]
; CHECK-NEXT:    add sp, sp, #16
; CHECK-NEXT:    ret
entry:
  %ap = alloca ptr, align 8
  call void @llvm.va_start(ptr %ap)
  %ap2 = load ptr, ptr %ap, align 8
  ret ptr %ap2
}

define ptr @f8(i64 %a0, i64 %a1, i64 %a2, i64 %a3, i64 %a4, i64 %a5, i64 %a6, i64 %a7, ...) nounwind {
; CHECK-LABEL: f8:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sub sp, sp, #16
; CHECK-NEXT:    add x8, sp, #16
; CHECK-NEXT:    add x0, sp, #16
; CHECK-NEXT:    str x8, [sp, #8]
; CHECK-NEXT:    add sp, sp, #16
; CHECK-NEXT:    ret
entry:
  %ap = alloca ptr, align 8
  call void @llvm.va_start(ptr %ap)
  %ap2 = load ptr, ptr %ap, align 8
  ret ptr %ap2
}

define ptr @f7(i64 %a0, i64 %a1, i64 %a2, i64 %a3, i64 %a4, i64 %a5, i64 %a6, ...) nounwind {
; CHECK-LABEL: f7:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sub sp, sp, #32
; CHECK-NEXT:    add x8, sp, #24
; CHECK-NEXT:    add x0, sp, #24
; CHECK-NEXT:    str x7, [sp, #24]
; CHECK-NEXT:    str x8, [sp, #8]
; CHECK-NEXT:    add sp, sp, #32
; CHECK-NEXT:    ret
entry:
  %ap = alloca ptr, align 8
  call void @llvm.va_start(ptr %ap)
  %ap2 = load ptr, ptr %ap, align 8
  ret ptr %ap2
}

define void @copy1(i64 %a0, ...) nounwind {
; CHECK-LABEL: copy1:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sub sp, sp, #80
; CHECK-NEXT:    add x8, sp, #24
; CHECK-NEXT:    stp x1, x2, [sp, #24]
; CHECK-NEXT:    stp x3, x4, [sp, #40]
; CHECK-NEXT:    stp x5, x6, [sp, #56]
; CHECK-NEXT:    str x7, [sp, #72]
; CHECK-NEXT:    stp x8, x8, [sp], #80
; CHECK-NEXT:    ret
entry:
  %ap = alloca ptr, align 8
  %cp = alloca ptr, align 8
  call void @llvm.va_start(ptr %ap)
  call void @llvm.va_copy(ptr %cp, ptr %ap)
  ret void
}

declare void @llvm.va_end(ptr)
declare void @llvm.lifetime.start.p0(i64, ptr nocapture) #1
declare void @llvm.lifetime.end.p0(i64, ptr nocapture) #1

declare i32 @__stdio_common_vsprintf(i64, ptr, i64, ptr, ptr, ptr) local_unnamed_addr #3
declare ptr @__local_stdio_printf_options() local_unnamed_addr #4

define i32 @fp(ptr, i64, ptr, ...) local_unnamed_addr #6 {
; CHECK-LABEL: fp:
; CHECK:       .seh_proc fp
; CHECK-NEXT:  // %bb.0:
; CHECK-NEXT:    stp x19, x20, [sp, #-96]! // 16-byte Folded Spill
; CHECK-NEXT:    .seh_save_regp_x x19, 96
; CHECK-NEXT:    str x21, [sp, #16] // 8-byte Folded Spill
; CHECK-NEXT:    .seh_save_reg x21, 16
; CHECK-NEXT:    stp x29, x30, [sp, #24] // 16-byte Folded Spill
; CHECK-NEXT:    .seh_save_fplr 24
; CHECK-NEXT:    add x29, sp, #24
; CHECK-NEXT:    .seh_add_fp 24
; CHECK-NEXT:    .seh_endprologue
; CHECK-NEXT:    add x8, x29, #32
; CHECK-NEXT:    mov x19, x2
; CHECK-NEXT:    mov x20, x1
; CHECK-NEXT:    mov x21, x0
; CHECK-NEXT:    stp x3, x4, [x29, #32]
; CHECK-NEXT:    stp x5, x6, [x29, #48]
; CHECK-NEXT:    str x7, [x29, #64]
; CHECK-NEXT:    str x8, [x29, #16]
; CHECK-NEXT:    bl __local_stdio_printf_options
; CHECK-NEXT:    ldr x8, [x0]
; CHECK-NEXT:    add x5, x29, #32
; CHECK-NEXT:    mov x1, x21
; CHECK-NEXT:    mov x2, x20
; CHECK-NEXT:    mov x3, x19
; CHECK-NEXT:    mov x4, xzr
; CHECK-NEXT:    orr x0, x8, #0x2
; CHECK-NEXT:    bl __stdio_common_vsprintf
; CHECK-NEXT:    cmp w0, #0
; CHECK-NEXT:    csinv w0, w0, wzr, ge
; CHECK-NEXT:    .seh_startepilogue
; CHECK-NEXT:    ldp x29, x30, [sp, #24] // 16-byte Folded Reload
; CHECK-NEXT:    .seh_save_fplr 24
; CHECK-NEXT:    ldr x21, [sp, #16] // 8-byte Folded Reload
; CHECK-NEXT:    .seh_save_reg x21, 16
; CHECK-NEXT:    ldp x19, x20, [sp], #96 // 16-byte Folded Reload
; CHECK-NEXT:    .seh_save_regp_x x19, 96
; CHECK-NEXT:    .seh_endepilogue
; CHECK-NEXT:    ret
; CHECK-NEXT:    .seh_endfunclet
; CHECK-NEXT:    .seh_endproc
  %4 = alloca ptr, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %4) #2
  call void @llvm.va_start(ptr nonnull %4)
  %5 = load ptr, ptr %4, align 8
  %6 = call ptr @__local_stdio_printf_options() #2
  %7 = load i64, ptr %6, align 8
  %8 = or i64 %7, 2
  %9 = call i32 @__stdio_common_vsprintf(i64 %8, ptr %0, i64 %1, ptr %2, ptr null, ptr %5) #2
  %10 = icmp sgt i32 %9, -1
  %11 = select i1 %10, i32 %9, i32 -1
  call void @llvm.va_end(ptr nonnull %4)
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %4) #2
  ret i32 %11
}

attributes #6 = { "frame-pointer"="all" }

define void @vla(i32, ptr, ...) local_unnamed_addr {
; CHECK-LABEL: vla:
; CHECK:       .seh_proc vla
; CHECK-NEXT:  // %bb.0:
; CHECK-NEXT:    stp x19, x20, [sp, #-112]! // 16-byte Folded Spill
; CHECK-NEXT:    .seh_save_regp_x x19, 112
; CHECK-NEXT:    stp x21, x22, [sp, #16] // 16-byte Folded Spill
; CHECK-NEXT:    .seh_save_regp x21, 16
; CHECK-NEXT:    str x23, [sp, #32] // 8-byte Folded Spill
; CHECK-NEXT:    .seh_save_reg x23, 32
; CHECK-NEXT:    stp x29, x30, [sp, #40] // 16-byte Folded Spill
; CHECK-NEXT:    .seh_save_fplr 40
; CHECK-NEXT:    add x29, sp, #40
; CHECK-NEXT:    .seh_add_fp 40
; CHECK-NEXT:    .seh_endprologue
; CHECK-NEXT:    // kill: def $w0 killed $w0 def $x0
; CHECK-NEXT:    add x8, x29, #24
; CHECK-NEXT:    mov w9, w0
; CHECK-NEXT:    mov x19, x1
; CHECK-NEXT:    str x8, [x29, #16]
; CHECK-NEXT:    add x8, x9, #15
; CHECK-NEXT:    mov x23, sp
; CHECK-NEXT:    lsr x15, x8, #4
; CHECK-NEXT:    stp x2, x3, [x29, #24]
; CHECK-NEXT:    stp x4, x5, [x29, #40]
; CHECK-NEXT:    stp x6, x7, [x29, #56]
; CHECK-NEXT:    bl __chkstk
; CHECK-NEXT:    sub x20, sp, x15, lsl #4
; CHECK-NEXT:    mov sp, x20
; CHECK-NEXT:    ldr x21, [x29, #16]
; CHECK-NEXT:    sxtw x22, w0
; CHECK-NEXT:    bl __local_stdio_printf_options
; CHECK-NEXT:    ldr x8, [x0]
; CHECK-NEXT:    mov x1, x20
; CHECK-NEXT:    mov x2, x22
; CHECK-NEXT:    mov x3, x19
; CHECK-NEXT:    mov x4, xzr
; CHECK-NEXT:    mov x5, x21
; CHECK-NEXT:    orr x0, x8, #0x2
; CHECK-NEXT:    bl __stdio_common_vsprintf
; CHECK-NEXT:    mov sp, x23
; CHECK-NEXT:    .seh_startepilogue
; CHECK-NEXT:    sub sp, x29, #40
; CHECK-NEXT:    .seh_add_fp 40
; CHECK-NEXT:    ldp x29, x30, [sp, #40] // 16-byte Folded Reload
; CHECK-NEXT:    .seh_save_fplr 40
; CHECK-NEXT:    ldr x23, [sp, #32] // 8-byte Folded Reload
; CHECK-NEXT:    .seh_save_reg x23, 32
; CHECK-NEXT:    ldp x21, x22, [sp, #16] // 16-byte Folded Reload
; CHECK-NEXT:    .seh_save_regp x21, 16
; CHECK-NEXT:    ldp x19, x20, [sp], #112 // 16-byte Folded Reload
; CHECK-NEXT:    .seh_save_regp_x x19, 112
; CHECK-NEXT:    .seh_endepilogue
; CHECK-NEXT:    ret
; CHECK-NEXT:    .seh_endfunclet
; CHECK-NEXT:    .seh_endproc
  %3 = alloca ptr, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %3) #5
  call void @llvm.va_start(ptr nonnull %3)
  %4 = zext i32 %0 to i64
  %5 = call ptr @llvm.stacksave()
  %6 = alloca i8, i64 %4, align 1
  %7 = load ptr, ptr %3, align 8
  %8 = sext i32 %0 to i64
  %9 = call ptr @__local_stdio_printf_options()
  %10 = load i64, ptr %9, align 8
  %11 = or i64 %10, 2
  %12 = call i32 @__stdio_common_vsprintf(i64 %11, ptr nonnull %6, i64 %8, ptr %1, ptr null, ptr %7)
  call void @llvm.va_end(ptr nonnull %3)
  call void @llvm.stackrestore(ptr %5)
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %3) #5
  ret void
}

declare ptr @llvm.stacksave()
declare void @llvm.stackrestore(ptr)

define i32 @snprintf(ptr, i64, ptr, ...) local_unnamed_addr #5 {
; CHECK-LABEL: snprintf:
; CHECK:       .seh_proc snprintf
; CHECK-NEXT:  // %bb.0:
; CHECK-NEXT:    sub sp, sp, #96
; CHECK-NEXT:    .seh_stackalloc 96
; CHECK-NEXT:    stp x19, x20, [sp, #16] // 16-byte Folded Spill
; CHECK-NEXT:    .seh_save_regp x19, 16
; CHECK-NEXT:    stp x21, x30, [sp, #32] // 16-byte Folded Spill
; CHECK-NEXT:    .seh_save_lrpair x21, 32
; CHECK-NEXT:    .seh_endprologue
; CHECK-NEXT:    add x8, sp, #56
; CHECK-NEXT:    mov x19, x2
; CHECK-NEXT:    mov x20, x1
; CHECK-NEXT:    mov x21, x0
; CHECK-NEXT:    stp x3, x4, [sp, #56]
; CHECK-NEXT:    stp x5, x6, [sp, #72]
; CHECK-NEXT:    str x7, [sp, #88]
; CHECK-NEXT:    str x8, [sp, #8]
; CHECK-NEXT:    bl __local_stdio_printf_options
; CHECK-NEXT:    ldr x8, [x0]
; CHECK-NEXT:    add x5, sp, #56
; CHECK-NEXT:    mov x1, x21
; CHECK-NEXT:    mov x2, x20
; CHECK-NEXT:    mov x3, x19
; CHECK-NEXT:    mov x4, xzr
; CHECK-NEXT:    orr x0, x8, #0x2
; CHECK-NEXT:    bl __stdio_common_vsprintf
; CHECK-NEXT:    cmp w0, #0
; CHECK-NEXT:    csinv w0, w0, wzr, ge
; CHECK-NEXT:    .seh_startepilogue
; CHECK-NEXT:    ldp x21, x30, [sp, #32] // 16-byte Folded Reload
; CHECK-NEXT:    .seh_save_lrpair x21, 32
; CHECK-NEXT:    ldp x19, x20, [sp, #16] // 16-byte Folded Reload
; CHECK-NEXT:    .seh_save_regp x19, 16
; CHECK-NEXT:    add sp, sp, #96
; CHECK-NEXT:    .seh_stackalloc 96
; CHECK-NEXT:    .seh_endepilogue
; CHECK-NEXT:    ret
; CHECK-NEXT:    .seh_endfunclet
; CHECK-NEXT:    .seh_endproc
  %4 = alloca ptr, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %4) #2
  call void @llvm.va_start(ptr nonnull %4)
  %5 = load ptr, ptr %4, align 8
  %6 = call ptr @__local_stdio_printf_options() #2
  %7 = load i64, ptr %6, align 8
  %8 = or i64 %7, 2
  %9 = call i32 @__stdio_common_vsprintf(i64 %8, ptr %0, i64 %1, ptr %2, ptr null, ptr %5) #2
  %10 = icmp sgt i32 %9, -1
  %11 = select i1 %10, i32 %9, i32 -1
  call void @llvm.va_end(ptr nonnull %4)
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %4) #2
  ret i32 %11
}

define void @fixed_params(i32, double, i32, double, i32, double, i32, double, i32, double) nounwind {
; CHECK-LABEL: fixed_params:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub sp, sp, #32
; CHECK-NEXT:    mov w8, w4
; CHECK-NEXT:    mov w6, w3
; CHECK-NEXT:    mov w4, w2
; CHECK-NEXT:    mov w2, w1
; CHECK-NEXT:    fmov x1, d0
; CHECK-NEXT:    fmov x3, d1
; CHECK-NEXT:    fmov x5, d2
; CHECK-NEXT:    fmov x7, d3
; CHECK-NEXT:    str x30, [sp, #16] // 8-byte Folded Spill
; CHECK-NEXT:    str d4, [sp, #8]
; CHECK-NEXT:    str w8, [sp]
; CHECK-NEXT:    bl varargs
; CHECK-NEXT:    ldr x30, [sp, #16] // 8-byte Folded Reload
; CHECK-NEXT:    add sp, sp, #32
; CHECK-NEXT:    ret
  tail call void (i32, ...) @varargs(i32 %0, double %1, i32 %2, double %3, i32 %4, double %5, i32 %6, double %7, i32 %8, double %9)
  ret void
}

declare void @varargs(i32, ...) local_unnamed_addr
