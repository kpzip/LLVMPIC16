; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc --mtriple=loongarch32 -mattr=+d < %s | FileCheck %s --check-prefix=LA32
; RUN: llc --mtriple=loongarch64 -mattr=+d < %s | FileCheck %s --check-prefix=LA64

define i8 @load_acquire_i8(ptr %ptr) {
; LA32-LABEL: load_acquire_i8:
; LA32:       # %bb.0:
; LA32-NEXT:    ld.b $a0, $a0, 0
; LA32-NEXT:    dbar 20
; LA32-NEXT:    ret
;
; LA64-LABEL: load_acquire_i8:
; LA64:       # %bb.0:
; LA64-NEXT:    ld.b $a0, $a0, 0
; LA64-NEXT:    dbar 20
; LA64-NEXT:    ret
  %val = load atomic i8, ptr %ptr acquire, align 1
  ret i8 %val
}

define i16 @load_acquire_i16(ptr %ptr) {
; LA32-LABEL: load_acquire_i16:
; LA32:       # %bb.0:
; LA32-NEXT:    ld.h $a0, $a0, 0
; LA32-NEXT:    dbar 20
; LA32-NEXT:    ret
;
; LA64-LABEL: load_acquire_i16:
; LA64:       # %bb.0:
; LA64-NEXT:    ld.h $a0, $a0, 0
; LA64-NEXT:    dbar 20
; LA64-NEXT:    ret
  %val = load atomic i16, ptr %ptr acquire, align 2
  ret i16 %val
}

define i32 @load_acquire_i32(ptr %ptr) {
; LA32-LABEL: load_acquire_i32:
; LA32:       # %bb.0:
; LA32-NEXT:    ld.w $a0, $a0, 0
; LA32-NEXT:    dbar 20
; LA32-NEXT:    ret
;
; LA64-LABEL: load_acquire_i32:
; LA64:       # %bb.0:
; LA64-NEXT:    ld.w $a0, $a0, 0
; LA64-NEXT:    dbar 20
; LA64-NEXT:    ret
  %val = load atomic i32, ptr %ptr acquire, align 4
  ret i32 %val
}

define i64 @load_acquire_i64(ptr %ptr) {
; LA32-LABEL: load_acquire_i64:
; LA32:       # %bb.0:
; LA32-NEXT:    addi.w $sp, $sp, -16
; LA32-NEXT:    .cfi_def_cfa_offset 16
; LA32-NEXT:    st.w $ra, $sp, 12 # 4-byte Folded Spill
; LA32-NEXT:    .cfi_offset 1, -4
; LA32-NEXT:    ori $a1, $zero, 2
; LA32-NEXT:    bl %plt(__atomic_load_8)
; LA32-NEXT:    ld.w $ra, $sp, 12 # 4-byte Folded Reload
; LA32-NEXT:    addi.w $sp, $sp, 16
; LA32-NEXT:    ret
;
; LA64-LABEL: load_acquire_i64:
; LA64:       # %bb.0:
; LA64-NEXT:    ld.d $a0, $a0, 0
; LA64-NEXT:    dbar 20
; LA64-NEXT:    ret
  %val = load atomic i64, ptr %ptr acquire, align 8
  ret i64 %val
}

define ptr @load_acquire_ptr(ptr %ptr) {
; LA32-LABEL: load_acquire_ptr:
; LA32:       # %bb.0:
; LA32-NEXT:    ld.w $a0, $a0, 0
; LA32-NEXT:    dbar 20
; LA32-NEXT:    ret
;
; LA64-LABEL: load_acquire_ptr:
; LA64:       # %bb.0:
; LA64-NEXT:    ld.d $a0, $a0, 0
; LA64-NEXT:    dbar 20
; LA64-NEXT:    ret
  %val = load atomic ptr, ptr %ptr acquire, align 8
  ret ptr %val
}

define i8 @load_unordered_i8(ptr %ptr) {
; LA32-LABEL: load_unordered_i8:
; LA32:       # %bb.0:
; LA32-NEXT:    ld.b $a0, $a0, 0
; LA32-NEXT:    ret
;
; LA64-LABEL: load_unordered_i8:
; LA64:       # %bb.0:
; LA64-NEXT:    ld.b $a0, $a0, 0
; LA64-NEXT:    ret
  %val = load atomic i8, ptr %ptr unordered, align 1
  ret i8 %val
}

define i16 @load_unordered_i16(ptr %ptr) {
; LA32-LABEL: load_unordered_i16:
; LA32:       # %bb.0:
; LA32-NEXT:    ld.h $a0, $a0, 0
; LA32-NEXT:    ret
;
; LA64-LABEL: load_unordered_i16:
; LA64:       # %bb.0:
; LA64-NEXT:    ld.h $a0, $a0, 0
; LA64-NEXT:    ret
  %val = load atomic i16, ptr %ptr unordered, align 2
  ret i16 %val
}

define i32 @load_unordered_i32(ptr %ptr) {
; LA32-LABEL: load_unordered_i32:
; LA32:       # %bb.0:
; LA32-NEXT:    ld.w $a0, $a0, 0
; LA32-NEXT:    ret
;
; LA64-LABEL: load_unordered_i32:
; LA64:       # %bb.0:
; LA64-NEXT:    ld.w $a0, $a0, 0
; LA64-NEXT:    ret
  %val = load atomic i32, ptr %ptr unordered, align 4
  ret i32 %val
}

define i64 @load_unordered_i64(ptr %ptr) {
; LA32-LABEL: load_unordered_i64:
; LA32:       # %bb.0:
; LA32-NEXT:    addi.w $sp, $sp, -16
; LA32-NEXT:    .cfi_def_cfa_offset 16
; LA32-NEXT:    st.w $ra, $sp, 12 # 4-byte Folded Spill
; LA32-NEXT:    .cfi_offset 1, -4
; LA32-NEXT:    move $a1, $zero
; LA32-NEXT:    bl %plt(__atomic_load_8)
; LA32-NEXT:    ld.w $ra, $sp, 12 # 4-byte Folded Reload
; LA32-NEXT:    addi.w $sp, $sp, 16
; LA32-NEXT:    ret
;
; LA64-LABEL: load_unordered_i64:
; LA64:       # %bb.0:
; LA64-NEXT:    ld.d $a0, $a0, 0
; LA64-NEXT:    ret
  %val = load atomic i64, ptr %ptr unordered, align 8
  ret i64 %val
}

define ptr @load_unordered_ptr(ptr %ptr) {
; LA32-LABEL: load_unordered_ptr:
; LA32:       # %bb.0:
; LA32-NEXT:    ld.w $a0, $a0, 0
; LA32-NEXT:    ret
;
; LA64-LABEL: load_unordered_ptr:
; LA64:       # %bb.0:
; LA64-NEXT:    ld.d $a0, $a0, 0
; LA64-NEXT:    ret
  %val = load atomic ptr, ptr %ptr unordered, align 8
  ret ptr %val
}

define i8 @load_monotonic_i8(ptr %ptr) {
; LA32-LABEL: load_monotonic_i8:
; LA32:       # %bb.0:
; LA32-NEXT:    ld.b $a0, $a0, 0
; LA32-NEXT:    ret
;
; LA64-LABEL: load_monotonic_i8:
; LA64:       # %bb.0:
; LA64-NEXT:    ld.b $a0, $a0, 0
; LA64-NEXT:    ret
  %val = load atomic i8, ptr %ptr monotonic, align 1
  ret i8 %val
}

define i16 @load_monotonic_i16(ptr %ptr) {
; LA32-LABEL: load_monotonic_i16:
; LA32:       # %bb.0:
; LA32-NEXT:    ld.h $a0, $a0, 0
; LA32-NEXT:    ret
;
; LA64-LABEL: load_monotonic_i16:
; LA64:       # %bb.0:
; LA64-NEXT:    ld.h $a0, $a0, 0
; LA64-NEXT:    ret
  %val = load atomic i16, ptr %ptr monotonic, align 2
  ret i16 %val
}

define i32 @load_monotonic_i32(ptr %ptr) {
; LA32-LABEL: load_monotonic_i32:
; LA32:       # %bb.0:
; LA32-NEXT:    ld.w $a0, $a0, 0
; LA32-NEXT:    ret
;
; LA64-LABEL: load_monotonic_i32:
; LA64:       # %bb.0:
; LA64-NEXT:    ld.w $a0, $a0, 0
; LA64-NEXT:    ret
  %val = load atomic i32, ptr %ptr monotonic, align 4
  ret i32 %val
}

define i64 @load_monotonic_i64(ptr %ptr) {
; LA32-LABEL: load_monotonic_i64:
; LA32:       # %bb.0:
; LA32-NEXT:    addi.w $sp, $sp, -16
; LA32-NEXT:    .cfi_def_cfa_offset 16
; LA32-NEXT:    st.w $ra, $sp, 12 # 4-byte Folded Spill
; LA32-NEXT:    .cfi_offset 1, -4
; LA32-NEXT:    move $a1, $zero
; LA32-NEXT:    bl %plt(__atomic_load_8)
; LA32-NEXT:    ld.w $ra, $sp, 12 # 4-byte Folded Reload
; LA32-NEXT:    addi.w $sp, $sp, 16
; LA32-NEXT:    ret
;
; LA64-LABEL: load_monotonic_i64:
; LA64:       # %bb.0:
; LA64-NEXT:    ld.d $a0, $a0, 0
; LA64-NEXT:    ret
  %val = load atomic i64, ptr %ptr monotonic, align 8
  ret i64 %val
}

define ptr @load_monotonic_ptr(ptr %ptr) {
; LA32-LABEL: load_monotonic_ptr:
; LA32:       # %bb.0:
; LA32-NEXT:    ld.w $a0, $a0, 0
; LA32-NEXT:    ret
;
; LA64-LABEL: load_monotonic_ptr:
; LA64:       # %bb.0:
; LA64-NEXT:    ld.d $a0, $a0, 0
; LA64-NEXT:    ret
  %val = load atomic ptr, ptr %ptr monotonic, align 8
  ret ptr %val
}

define i8 @load_seq_cst_i8(ptr %ptr) {
; LA32-LABEL: load_seq_cst_i8:
; LA32:       # %bb.0:
; LA32-NEXT:    ld.b $a0, $a0, 0
; LA32-NEXT:    dbar 16
; LA32-NEXT:    ret
;
; LA64-LABEL: load_seq_cst_i8:
; LA64:       # %bb.0:
; LA64-NEXT:    ld.b $a0, $a0, 0
; LA64-NEXT:    dbar 16
; LA64-NEXT:    ret
  %val = load atomic i8, ptr %ptr seq_cst, align 1
  ret i8 %val
}

define i16 @load_seq_cst_i16(ptr %ptr) {
; LA32-LABEL: load_seq_cst_i16:
; LA32:       # %bb.0:
; LA32-NEXT:    ld.h $a0, $a0, 0
; LA32-NEXT:    dbar 16
; LA32-NEXT:    ret
;
; LA64-LABEL: load_seq_cst_i16:
; LA64:       # %bb.0:
; LA64-NEXT:    ld.h $a0, $a0, 0
; LA64-NEXT:    dbar 16
; LA64-NEXT:    ret
  %val = load atomic i16, ptr %ptr seq_cst, align 2
  ret i16 %val
}

define i32 @load_seq_cst_i32(ptr %ptr) {
; LA32-LABEL: load_seq_cst_i32:
; LA32:       # %bb.0:
; LA32-NEXT:    ld.w $a0, $a0, 0
; LA32-NEXT:    dbar 16
; LA32-NEXT:    ret
;
; LA64-LABEL: load_seq_cst_i32:
; LA64:       # %bb.0:
; LA64-NEXT:    ld.w $a0, $a0, 0
; LA64-NEXT:    dbar 16
; LA64-NEXT:    ret
  %val = load atomic i32, ptr %ptr seq_cst, align 4
  ret i32 %val
}

define i64 @load_seq_cst_i64(ptr %ptr) {
; LA32-LABEL: load_seq_cst_i64:
; LA32:       # %bb.0:
; LA32-NEXT:    addi.w $sp, $sp, -16
; LA32-NEXT:    .cfi_def_cfa_offset 16
; LA32-NEXT:    st.w $ra, $sp, 12 # 4-byte Folded Spill
; LA32-NEXT:    .cfi_offset 1, -4
; LA32-NEXT:    ori $a1, $zero, 5
; LA32-NEXT:    bl %plt(__atomic_load_8)
; LA32-NEXT:    ld.w $ra, $sp, 12 # 4-byte Folded Reload
; LA32-NEXT:    addi.w $sp, $sp, 16
; LA32-NEXT:    ret
;
; LA64-LABEL: load_seq_cst_i64:
; LA64:       # %bb.0:
; LA64-NEXT:    ld.d $a0, $a0, 0
; LA64-NEXT:    dbar 16
; LA64-NEXT:    ret
  %val = load atomic i64, ptr %ptr seq_cst, align 8
  ret i64 %val
}

define ptr @load_seq_cst_ptr(ptr %ptr) {
; LA32-LABEL: load_seq_cst_ptr:
; LA32:       # %bb.0:
; LA32-NEXT:    ld.w $a0, $a0, 0
; LA32-NEXT:    dbar 16
; LA32-NEXT:    ret
;
; LA64-LABEL: load_seq_cst_ptr:
; LA64:       # %bb.0:
; LA64-NEXT:    ld.d $a0, $a0, 0
; LA64-NEXT:    dbar 16
; LA64-NEXT:    ret
  %val = load atomic ptr, ptr %ptr seq_cst, align 8
  ret ptr %val
}

define void @store_release_i8(ptr %ptr, i8 signext %v) {
; LA32-LABEL: store_release_i8:
; LA32:       # %bb.0:
; LA32-NEXT:    dbar 18
; LA32-NEXT:    st.b $a1, $a0, 0
; LA32-NEXT:    ret
;
; LA64-LABEL: store_release_i8:
; LA64:       # %bb.0:
; LA64-NEXT:    dbar 18
; LA64-NEXT:    st.b $a1, $a0, 0
; LA64-NEXT:    ret
  store atomic i8 %v, ptr %ptr release, align 1
  ret void
}

define void @store_release_i16(ptr %ptr, i16 signext %v) {
; LA32-LABEL: store_release_i16:
; LA32:       # %bb.0:
; LA32-NEXT:    dbar 18
; LA32-NEXT:    st.h $a1, $a0, 0
; LA32-NEXT:    ret
;
; LA64-LABEL: store_release_i16:
; LA64:       # %bb.0:
; LA64-NEXT:    dbar 18
; LA64-NEXT:    st.h $a1, $a0, 0
; LA64-NEXT:    ret
  store atomic i16 %v, ptr %ptr release, align 2
  ret void
}

define void @store_release_i32(ptr %ptr, i32 signext %v) {
; LA32-LABEL: store_release_i32:
; LA32:       # %bb.0:
; LA32-NEXT:    dbar 18
; LA32-NEXT:    st.w $a1, $a0, 0
; LA32-NEXT:    ret
;
; LA64-LABEL: store_release_i32:
; LA64:       # %bb.0:
; LA64-NEXT:    amswap_db.w $zero, $a1, $a0
; LA64-NEXT:    ret
  store atomic i32 %v, ptr %ptr release, align 4
  ret void
}

define void @store_release_i64(ptr %ptr, i64 %v) {
; LA32-LABEL: store_release_i64:
; LA32:       # %bb.0:
; LA32-NEXT:    addi.w $sp, $sp, -16
; LA32-NEXT:    .cfi_def_cfa_offset 16
; LA32-NEXT:    st.w $ra, $sp, 12 # 4-byte Folded Spill
; LA32-NEXT:    .cfi_offset 1, -4
; LA32-NEXT:    ori $a3, $zero, 3
; LA32-NEXT:    bl %plt(__atomic_store_8)
; LA32-NEXT:    ld.w $ra, $sp, 12 # 4-byte Folded Reload
; LA32-NEXT:    addi.w $sp, $sp, 16
; LA32-NEXT:    ret
;
; LA64-LABEL: store_release_i64:
; LA64:       # %bb.0:
; LA64-NEXT:    amswap_db.d $zero, $a1, $a0
; LA64-NEXT:    ret
  store atomic i64 %v, ptr %ptr release, align 8
  ret void
}

define void @store_release_ptr(ptr %ptr, ptr %v) {
; LA32-LABEL: store_release_ptr:
; LA32:       # %bb.0:
; LA32-NEXT:    dbar 18
; LA32-NEXT:    st.w $a1, $a0, 0
; LA32-NEXT:    ret
;
; LA64-LABEL: store_release_ptr:
; LA64:       # %bb.0:
; LA64-NEXT:    amswap_db.d $zero, $a1, $a0
; LA64-NEXT:    ret
  store atomic ptr %v, ptr %ptr release, align 8
  ret void
}

define void @store_unordered_i8(ptr %ptr, i8 signext %v) {
; LA32-LABEL: store_unordered_i8:
; LA32:       # %bb.0:
; LA32-NEXT:    st.b $a1, $a0, 0
; LA32-NEXT:    ret
;
; LA64-LABEL: store_unordered_i8:
; LA64:       # %bb.0:
; LA64-NEXT:    st.b $a1, $a0, 0
; LA64-NEXT:    ret
  store atomic i8 %v, ptr %ptr unordered, align 1
  ret void
}

define void @store_unordered_i16(ptr %ptr, i16 signext %v) {
; LA32-LABEL: store_unordered_i16:
; LA32:       # %bb.0:
; LA32-NEXT:    st.h $a1, $a0, 0
; LA32-NEXT:    ret
;
; LA64-LABEL: store_unordered_i16:
; LA64:       # %bb.0:
; LA64-NEXT:    st.h $a1, $a0, 0
; LA64-NEXT:    ret
  store atomic i16 %v, ptr %ptr unordered, align 2
  ret void
}

define void @store_unordered_i32(ptr %ptr, i32 signext %v) {
; LA32-LABEL: store_unordered_i32:
; LA32:       # %bb.0:
; LA32-NEXT:    st.w $a1, $a0, 0
; LA32-NEXT:    ret
;
; LA64-LABEL: store_unordered_i32:
; LA64:       # %bb.0:
; LA64-NEXT:    st.w $a1, $a0, 0
; LA64-NEXT:    ret
  store atomic i32 %v, ptr %ptr unordered, align 4
  ret void
}

define void @store_unordered_i64(ptr %ptr, i64 %v) {
; LA32-LABEL: store_unordered_i64:
; LA32:       # %bb.0:
; LA32-NEXT:    addi.w $sp, $sp, -16
; LA32-NEXT:    .cfi_def_cfa_offset 16
; LA32-NEXT:    st.w $ra, $sp, 12 # 4-byte Folded Spill
; LA32-NEXT:    .cfi_offset 1, -4
; LA32-NEXT:    move $a3, $zero
; LA32-NEXT:    bl %plt(__atomic_store_8)
; LA32-NEXT:    ld.w $ra, $sp, 12 # 4-byte Folded Reload
; LA32-NEXT:    addi.w $sp, $sp, 16
; LA32-NEXT:    ret
;
; LA64-LABEL: store_unordered_i64:
; LA64:       # %bb.0:
; LA64-NEXT:    st.d $a1, $a0, 0
; LA64-NEXT:    ret
  store atomic i64 %v, ptr %ptr unordered, align 8
  ret void
}

define void @store_unordered_ptr(ptr %ptr, ptr %v) {
; LA32-LABEL: store_unordered_ptr:
; LA32:       # %bb.0:
; LA32-NEXT:    st.w $a1, $a0, 0
; LA32-NEXT:    ret
;
; LA64-LABEL: store_unordered_ptr:
; LA64:       # %bb.0:
; LA64-NEXT:    st.d $a1, $a0, 0
; LA64-NEXT:    ret
  store atomic ptr %v, ptr %ptr unordered, align 8
  ret void
}

define void @store_monotonic_i8(ptr %ptr, i8 signext %v) {
; LA32-LABEL: store_monotonic_i8:
; LA32:       # %bb.0:
; LA32-NEXT:    st.b $a1, $a0, 0
; LA32-NEXT:    ret
;
; LA64-LABEL: store_monotonic_i8:
; LA64:       # %bb.0:
; LA64-NEXT:    st.b $a1, $a0, 0
; LA64-NEXT:    ret
  store atomic i8 %v, ptr %ptr monotonic, align 1
  ret void
}

define void @store_monotonic_i16(ptr %ptr, i16 signext %v) {
; LA32-LABEL: store_monotonic_i16:
; LA32:       # %bb.0:
; LA32-NEXT:    st.h $a1, $a0, 0
; LA32-NEXT:    ret
;
; LA64-LABEL: store_monotonic_i16:
; LA64:       # %bb.0:
; LA64-NEXT:    st.h $a1, $a0, 0
; LA64-NEXT:    ret
  store atomic i16 %v, ptr %ptr monotonic, align 2
  ret void
}

define void @store_monotonic_i32(ptr %ptr, i32 signext %v) {
; LA32-LABEL: store_monotonic_i32:
; LA32:       # %bb.0:
; LA32-NEXT:    st.w $a1, $a0, 0
; LA32-NEXT:    ret
;
; LA64-LABEL: store_monotonic_i32:
; LA64:       # %bb.0:
; LA64-NEXT:    st.w $a1, $a0, 0
; LA64-NEXT:    ret
  store atomic i32 %v, ptr %ptr monotonic, align 4
  ret void
}

define void @store_monotonic_i64(ptr %ptr, i64 %v) {
; LA32-LABEL: store_monotonic_i64:
; LA32:       # %bb.0:
; LA32-NEXT:    addi.w $sp, $sp, -16
; LA32-NEXT:    .cfi_def_cfa_offset 16
; LA32-NEXT:    st.w $ra, $sp, 12 # 4-byte Folded Spill
; LA32-NEXT:    .cfi_offset 1, -4
; LA32-NEXT:    move $a3, $zero
; LA32-NEXT:    bl %plt(__atomic_store_8)
; LA32-NEXT:    ld.w $ra, $sp, 12 # 4-byte Folded Reload
; LA32-NEXT:    addi.w $sp, $sp, 16
; LA32-NEXT:    ret
;
; LA64-LABEL: store_monotonic_i64:
; LA64:       # %bb.0:
; LA64-NEXT:    st.d $a1, $a0, 0
; LA64-NEXT:    ret
  store atomic i64 %v, ptr %ptr monotonic, align 8
  ret void
}

define void @store_monotonic_ptr(ptr %ptr, ptr %v) {
; LA32-LABEL: store_monotonic_ptr:
; LA32:       # %bb.0:
; LA32-NEXT:    st.w $a1, $a0, 0
; LA32-NEXT:    ret
;
; LA64-LABEL: store_monotonic_ptr:
; LA64:       # %bb.0:
; LA64-NEXT:    st.d $a1, $a0, 0
; LA64-NEXT:    ret
  store atomic ptr %v, ptr %ptr monotonic, align 8
  ret void
}

define void @store_seq_cst_i8(ptr %ptr, i8 signext %v) {
; LA32-LABEL: store_seq_cst_i8:
; LA32:       # %bb.0:
; LA32-NEXT:    dbar 16
; LA32-NEXT:    st.b $a1, $a0, 0
; LA32-NEXT:    dbar 16
; LA32-NEXT:    ret
;
; LA64-LABEL: store_seq_cst_i8:
; LA64:       # %bb.0:
; LA64-NEXT:    dbar 16
; LA64-NEXT:    st.b $a1, $a0, 0
; LA64-NEXT:    dbar 16
; LA64-NEXT:    ret
  store atomic i8 %v, ptr %ptr seq_cst, align 1
  ret void
}

define void @store_seq_cst_i16(ptr %ptr, i16 signext %v) {
; LA32-LABEL: store_seq_cst_i16:
; LA32:       # %bb.0:
; LA32-NEXT:    dbar 16
; LA32-NEXT:    st.h $a1, $a0, 0
; LA32-NEXT:    dbar 16
; LA32-NEXT:    ret
;
; LA64-LABEL: store_seq_cst_i16:
; LA64:       # %bb.0:
; LA64-NEXT:    dbar 16
; LA64-NEXT:    st.h $a1, $a0, 0
; LA64-NEXT:    dbar 16
; LA64-NEXT:    ret
  store atomic i16 %v, ptr %ptr seq_cst, align 2
  ret void
}

define void @store_seq_cst_i32(ptr %ptr, i32 signext %v) {
; LA32-LABEL: store_seq_cst_i32:
; LA32:       # %bb.0:
; LA32-NEXT:    dbar 16
; LA32-NEXT:    st.w $a1, $a0, 0
; LA32-NEXT:    dbar 16
; LA32-NEXT:    ret
;
; LA64-LABEL: store_seq_cst_i32:
; LA64:       # %bb.0:
; LA64-NEXT:    amswap_db.w $zero, $a1, $a0
; LA64-NEXT:    ret
  store atomic i32 %v, ptr %ptr seq_cst, align 4
  ret void
}

define void @store_seq_cst_i64(ptr %ptr, i64 %v) {
; LA32-LABEL: store_seq_cst_i64:
; LA32:       # %bb.0:
; LA32-NEXT:    addi.w $sp, $sp, -16
; LA32-NEXT:    .cfi_def_cfa_offset 16
; LA32-NEXT:    st.w $ra, $sp, 12 # 4-byte Folded Spill
; LA32-NEXT:    .cfi_offset 1, -4
; LA32-NEXT:    ori $a3, $zero, 5
; LA32-NEXT:    bl %plt(__atomic_store_8)
; LA32-NEXT:    ld.w $ra, $sp, 12 # 4-byte Folded Reload
; LA32-NEXT:    addi.w $sp, $sp, 16
; LA32-NEXT:    ret
;
; LA64-LABEL: store_seq_cst_i64:
; LA64:       # %bb.0:
; LA64-NEXT:    amswap_db.d $zero, $a1, $a0
; LA64-NEXT:    ret
  store atomic i64 %v, ptr %ptr seq_cst, align 8
  ret void
}

define void @store_seq_cst_ptr(ptr %ptr, ptr %v) {
; LA32-LABEL: store_seq_cst_ptr:
; LA32:       # %bb.0:
; LA32-NEXT:    dbar 16
; LA32-NEXT:    st.w $a1, $a0, 0
; LA32-NEXT:    dbar 16
; LA32-NEXT:    ret
;
; LA64-LABEL: store_seq_cst_ptr:
; LA64:       # %bb.0:
; LA64-NEXT:    amswap_db.d $zero, $a1, $a0
; LA64-NEXT:    ret
  store atomic ptr %v, ptr %ptr seq_cst, align 8
  ret void
}
