; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -o - %s -mtriple=aarch64-none-linux-gnu | FileCheck --check-prefixes=CHECK,CHECK-FP %s
; RUN: llc -verify-machineinstrs < %s -mtriple=aarch64-none-linux-gnu -mattr=-fp-armv8 | FileCheck --check-prefixes=CHECK,CHECK-NOFP %s

@var_8bit = dso_local global i8 0
@var_16bit = dso_local global i16 0
@var_32bit = dso_local global i32 0
@var_64bit = dso_local global i64 0

@var_float = dso_local global float 0.0
@var_double = dso_local global double 0.0

define i32 @ld_s8_32() {
; CHECK-LABEL: ld_s8_32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, var_8bit
; CHECK-NEXT:    ldrsb w0, [x8, :lo12:var_8bit]
; CHECK-NEXT:    ret
   %val8_sext32 = load i8, ptr @var_8bit
   %val32_signed = sext i8 %val8_sext32 to i32
   ret i32 %val32_signed
}

define i32 @ld_u8_32() {
; CHECK-LABEL: ld_u8_32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, var_8bit
; CHECK-NEXT:    ldrb w0, [x8, :lo12:var_8bit]
; CHECK-NEXT:    ret
  %val8_zext32 = load i8, ptr @var_8bit
  %val32_unsigned = zext i8 %val8_zext32 to i32
  ret i32 %val32_unsigned
}

define i64 @ld_s8_64() {
; CHECK-LABEL: ld_s8_64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, var_8bit
; CHECK-NEXT:    ldrsb x0, [x8, :lo12:var_8bit]
; CHECK-NEXT:    ret
  %val8_sext64 = load i8, ptr @var_8bit
  %val64_signed = sext i8 %val8_sext64 to i64
  ret i64 %val64_signed
}

define i64 @ld_u8_64() {
; CHECK-LABEL: ld_u8_64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, var_8bit
; CHECK-NEXT:    ldrb w0, [x8, :lo12:var_8bit]
; CHECK-NEXT:    ret
  %val8_zext64 = load i8, ptr @var_8bit
  %val64_unsigned = zext i8 %val8_zext64 to i64
  ret i64 %val64_unsigned
}

define i8 @ld_a8_8() {
; CHECK-LABEL: ld_a8_8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, var_8bit
; CHECK-NEXT:    ldrb w8, [x8, :lo12:var_8bit]
; CHECK-NEXT:    add w0, w8, #1
; CHECK-NEXT:    ret
  %val8_anyext = load i8, ptr @var_8bit
  %newval8 = add i8 %val8_anyext, 1
  ret i8 %newval8
}

define void @st_i32_8(i32 %val32) {
; CHECK-LABEL: st_i32_8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, var_8bit
; CHECK-NEXT:    strb w0, [x8, :lo12:var_8bit]
; CHECK-NEXT:    ret
  %val8_trunc32 = trunc i32 %val32 to i8
  store i8 %val8_trunc32, ptr @var_8bit
  ret void
}

define void @st_i64_8(i64 %val64) {
; CHECK-LABEL: st_i64_8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, var_8bit
; CHECK-NEXT:    strb w0, [x8, :lo12:var_8bit]
; CHECK-NEXT:    ret
  %val8_trunc64 = trunc i64 %val64 to i8
  store i8 %val8_trunc64, ptr @var_8bit
  ret void
}


define i32 @ld_s16_32() {
; CHECK-LABEL: ld_s16_32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, var_16bit
; CHECK-NEXT:    ldrsh w0, [x8, :lo12:var_16bit]
; CHECK-NEXT:    ret
   %val16_sext32 = load i16, ptr @var_16bit
   %val32_signed = sext i16 %val16_sext32 to i32
   ret i32 %val32_signed
}

define i32 @ld_u16_32() {
; CHECK-LABEL: ld_u16_32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, var_16bit
; CHECK-NEXT:    ldrh w0, [x8, :lo12:var_16bit]
; CHECK-NEXT:    ret
  %val16_zext32 = load i16, ptr @var_16bit
  %val32_unsigned = zext i16 %val16_zext32 to i32
  ret i32 %val32_unsigned
}

define i64 @ld_s16_64() {
; CHECK-LABEL: ld_s16_64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, var_16bit
; CHECK-NEXT:    ldrsh x0, [x8, :lo12:var_16bit]
; CHECK-NEXT:    ret
  %val16_sext64 = load i16, ptr @var_16bit
  %val64_signed = sext i16 %val16_sext64 to i64
  ret i64 %val64_signed
}

define i64 @ld_u16_64() {
; CHECK-LABEL: ld_u16_64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, var_16bit
; CHECK-NEXT:    ldrh w0, [x8, :lo12:var_16bit]
; CHECK-NEXT:    ret
  %val16_zext64 = load i16, ptr @var_16bit
  %val64_unsigned = zext i16 %val16_zext64 to i64
  ret i64 %val64_unsigned
}

define i16 @ld_a16_16() {
; CHECK-LABEL: ld_a16_16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, var_16bit
; CHECK-NEXT:    ldrh w8, [x8, :lo12:var_16bit]
; CHECK-NEXT:    add w0, w8, #1
; CHECK-NEXT:    ret
  %val16_anyext = load i16, ptr @var_16bit
  %newval16 = add i16 %val16_anyext, 1
  ret i16 %newval16
}

define void @st_i32_16(i32 %val32) {
; CHECK-LABEL: st_i32_16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, var_16bit
; CHECK-NEXT:    strh w0, [x8, :lo12:var_16bit]
; CHECK-NEXT:    ret
  %val16_trunc32 = trunc i32 %val32 to i16
  store i16 %val16_trunc32, ptr @var_16bit
  ret void
}

define void @st_i64_16(i64 %val64) {
; CHECK-LABEL: st_i64_16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, var_16bit
; CHECK-NEXT:    strh w0, [x8, :lo12:var_16bit]
; CHECK-NEXT:    ret
  %val16_trunc64 = trunc i64 %val64 to i16
  store i16 %val16_trunc64, ptr @var_16bit
  ret void
}


define i64 @ld_s32_64() {
; CHECK-LABEL: ld_s32_64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, var_32bit
; CHECK-NEXT:    ldrsw x0, [x8, :lo12:var_32bit]
; CHECK-NEXT:    ret
  %val32_sext64 = load i32, ptr @var_32bit
  %val64_signed = sext i32 %val32_sext64 to i64
  ret i64 %val64_signed
}

define i64 @ld_u32_64() {
; CHECK-LABEL: ld_u32_64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, var_32bit
; CHECK-NEXT:    ldr w0, [x8, :lo12:var_32bit]
; CHECK-NEXT:    ret
  %val32_zext64 = load i32, ptr @var_32bit
  %val64_unsigned = zext i32 %val32_zext64 to i64
  ret i64 %val64_unsigned
}

define i32 @ld_a32_32() {
; CHECK-LABEL: ld_a32_32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, var_32bit
; CHECK-NEXT:    ldr w8, [x8, :lo12:var_32bit]
; CHECK-NEXT:    add w0, w8, #1
; CHECK-NEXT:    ret
  %val32_anyext = load i32, ptr @var_32bit
  %newval32 = add i32 %val32_anyext, 1
  ret i32 %newval32
}

define void @st_i64_32(i64 %val64) {
; CHECK-LABEL: st_i64_32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, var_32bit
; CHECK-NEXT:    str w0, [x8, :lo12:var_32bit]
; CHECK-NEXT:    ret
  %val32_trunc64 = trunc i64 %val64 to i32
  store i32 %val32_trunc64, ptr @var_32bit
  ret void
}


@arr8 = dso_local global ptr null
@arr16 = dso_local global ptr null
@arr32 = dso_local global ptr null
@arr64 = dso_local global ptr null

; Now check that our selection copes with accesses more complex than a
; single symbol. Permitted offsets should be folded into the loads and
; stores. Since all forms use the same Operand it's only necessary to
; check the various access-sizes involved.

define i8 @ld_i8_1(ptr %arr8_addr) {
; CHECK-LABEL: ld_i8_1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldrb w0, [x0, #1]
; CHECK-NEXT:    ret
  %arr8_sub1_addr = getelementptr i8, ptr %arr8_addr, i64 1
  %arr8_sub1 = load volatile i8, ptr %arr8_sub1_addr
  ret i8 %arr8_sub1
}

define i8 @ld_i8_4095(ptr %arr8_addr) {
; CHECK-LABEL: ld_i8_4095:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldrb w0, [x0, #4095]
; CHECK-NEXT:    ret
  %arr8_sub4095_addr = getelementptr i8, ptr %arr8_addr, i64 4095
  %arr8_sub4095 = load volatile i8, ptr %arr8_sub4095_addr
  ret i8 %arr8_sub4095
}

define i16 @ld_i16_1(ptr %arr16_addr) {
; CHECK-LABEL: ld_i16_1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldrh w0, [x0, #2]
; CHECK-NEXT:    ret
  %arr16_sub1_addr = getelementptr i16, ptr %arr16_addr, i64 1
  %arr16_sub1 = load volatile i16, ptr %arr16_sub1_addr
  ret i16 %arr16_sub1
}

define i16 @ld_i16_4095(ptr %arr16_addr) {
; CHECK-LABEL: ld_i16_4095:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldrh w0, [x0, #8190]
; CHECK-NEXT:    ret
  %arr16_sub4095_addr = getelementptr i16, ptr %arr16_addr, i64 4095
  %arr16_sub4095 = load volatile i16, ptr %arr16_sub4095_addr
  ret i16 %arr16_sub4095
}

define i32 @ld_i32_1(ptr %arr32_addr) {
; CHECK-LABEL: ld_i32_1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr w0, [x0, #4]
; CHECK-NEXT:    ret
  %arr32_sub1_addr = getelementptr i32, ptr %arr32_addr, i64 1
  %arr32_sub1 = load volatile i32, ptr %arr32_sub1_addr
  ret i32 %arr32_sub1
}

define i32 @ld_i32_4095(ptr %arr32_addr) {
; CHECK-LABEL: ld_i32_4095:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr w0, [x0, #16380]
; CHECK-NEXT:    ret
  %arr32_sub4095_addr = getelementptr i32, ptr %arr32_addr, i64 4095
  %arr32_sub4095 = load volatile i32, ptr %arr32_sub4095_addr
  ret i32 %arr32_sub4095
}

define i64 @ld_i64_1(ptr %arr64_addr) {
; CHECK-LABEL: ld_i64_1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr x0, [x0, #8]
; CHECK-NEXT:    ret
  %arr64_sub1_addr = getelementptr i64, ptr %arr64_addr, i64 1
  %arr64_sub1 = load volatile i64, ptr %arr64_sub1_addr
  ret i64 %arr64_sub1
}

define i64 @ld_i64_4095(ptr %arr64_addr) {
; CHECK-LABEL: ld_i64_4095:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr x0, [x0, #32760]
; CHECK-NEXT:    ret
  %arr64_sub4095_addr = getelementptr i64, ptr %arr64_addr, i64 4095
  %arr64_sub4095 = load volatile i64, ptr %arr64_sub4095_addr
  ret i64 %arr64_sub4095
}

define dso_local void @ldst_float() {
; CHECK-FP-LABEL: ldst_float:
; CHECK-FP:       // %bb.0:
; CHECK-FP-NEXT:    adrp x8, var_float
; CHECK-FP-NEXT:    ldr s0, [x8, :lo12:var_float]
; CHECK-FP-NEXT:    str s0, [x8, :lo12:var_float]
; CHECK-FP-NEXT:    ret
;
; CHECK-NOFP-LABEL: ldst_float:
; CHECK-NOFP:       // %bb.0:
; CHECK-NOFP-NEXT:    adrp x8, var_float
; CHECK-NOFP-NEXT:    ldr w9, [x8, :lo12:var_float]
; CHECK-NOFP-NEXT:    str w9, [x8, :lo12:var_float]
; CHECK-NOFP-NEXT:    ret
  %valfp = load volatile float, ptr @var_float
  store volatile float %valfp, ptr @var_float
  ret void
}

define dso_local void @ldst_double() {
; CHECK-FP-LABEL: ldst_double:
; CHECK-FP:       // %bb.0:
; CHECK-FP-NEXT:    adrp x8, var_double
; CHECK-FP-NEXT:    ldr d0, [x8, :lo12:var_double]
; CHECK-FP-NEXT:    str d0, [x8, :lo12:var_double]
; CHECK-FP-NEXT:    ret
;
; CHECK-NOFP-LABEL: ldst_double:
; CHECK-NOFP:       // %bb.0:
; CHECK-NOFP-NEXT:    adrp x8, var_double
; CHECK-NOFP-NEXT:    ldr x9, [x8, :lo12:var_double]
; CHECK-NOFP-NEXT:    str x9, [x8, :lo12:var_double]
; CHECK-NOFP-NEXT:    ret
  %valfp = load volatile double, ptr @var_double
  store volatile double %valfp, ptr @var_double
  ret void
}
