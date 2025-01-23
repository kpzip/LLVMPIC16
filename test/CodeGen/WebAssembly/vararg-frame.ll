; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -verify-machineinstrs  | FileCheck %s
; REQUIRES: webassembly-registered-target
target datalayout = "e-m:e-p:32:32-p10:8:8-p20:8:8-i64:64-n32:64-S128-ni:1:10:20"
target triple = "wasm32-unknown-unknown"

; Function Attrs: nounwind
define void @pass_s0() {
; CHECK-LABEL: pass_s0:
; CHECK:         .functype pass_s0 () -> ()
; CHECK-NEXT:  # %bb.0: # %entry
; CHECK-NEXT:    i32.const 0
; CHECK-NEXT:    call sink
; CHECK-NEXT:    # fallthrough-return
entry:
  tail call void (...) @sink()
  ret void
}

declare void @sink(...)

; Function Attrs: nounwind
define void @pass_s1(i8 %x.coerce) {
; CHECK-LABEL: pass_s1:
; CHECK:         .functype pass_s1 (i32) -> ()
; CHECK-NEXT:    .local i32
; CHECK-NEXT:  # %bb.0: # %entry
; CHECK-NEXT:    global.get __stack_pointer
; CHECK-NEXT:    i32.const 16
; CHECK-NEXT:    i32.sub
; CHECK-NEXT:    local.tee 1
; CHECK-NEXT:    global.set __stack_pointer
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    i32.store 0
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    call sink
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    i32.const 16
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    global.set __stack_pointer
; CHECK-NEXT:    # fallthrough-return
entry:
  tail call void (...) @sink(i8 %x.coerce)
  ret void
}

; Function Attrs: nounwind
define void @pass_s2(i16 %x.coerce) {
; CHECK-LABEL: pass_s2:
; CHECK:         .functype pass_s2 (i32) -> ()
; CHECK-NEXT:    .local i32
; CHECK-NEXT:  # %bb.0: # %entry
; CHECK-NEXT:    global.get __stack_pointer
; CHECK-NEXT:    i32.const 16
; CHECK-NEXT:    i32.sub
; CHECK-NEXT:    local.tee 1
; CHECK-NEXT:    global.set __stack_pointer
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    i32.store 0
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    call sink
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    i32.const 16
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    global.set __stack_pointer
; CHECK-NEXT:    # fallthrough-return
entry:
  tail call void (...) @sink(i16 %x.coerce)
  ret void
}

; Function Attrs: nounwind
define void @pass_s3(i32 %x.coerce) {
; CHECK-LABEL: pass_s3:
; CHECK:         .functype pass_s3 (i32) -> ()
; CHECK-NEXT:    .local i32
; CHECK-NEXT:  # %bb.0: # %entry
; CHECK-NEXT:    global.get __stack_pointer
; CHECK-NEXT:    i32.const 16
; CHECK-NEXT:    i32.sub
; CHECK-NEXT:    local.tee 1
; CHECK-NEXT:    global.set __stack_pointer
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    i32.store 0
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    call sink
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    i32.const 16
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    global.set __stack_pointer
; CHECK-NEXT:    # fallthrough-return
entry:
  tail call void (...) @sink(i32 %x.coerce)
  ret void
}

; Function Attrs: nounwind
define void @pass_s4(i64 %x.coerce) {
; CHECK-LABEL: pass_s4:
; CHECK:         .functype pass_s4 (i64) -> ()
; CHECK-NEXT:    .local i32
; CHECK-NEXT:  # %bb.0: # %entry
; CHECK-NEXT:    global.get __stack_pointer
; CHECK-NEXT:    i32.const 16
; CHECK-NEXT:    i32.sub
; CHECK-NEXT:    local.tee 1
; CHECK-NEXT:    global.set __stack_pointer
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    i64.store 0
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    call sink
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    i32.const 16
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    global.set __stack_pointer
; CHECK-NEXT:    # fallthrough-return
entry:
  tail call void (...) @sink(i64 %x.coerce)
  ret void
}

; Function Attrs: nounwind
define void @pass_s5(<4 x i32> noundef %x) {
; CHECK-LABEL: pass_s5:
; CHECK:         .functype pass_s5 (i32, i32, i32, i32) -> ()
; CHECK-NEXT:    .local i32
; CHECK-NEXT:  # %bb.0: # %entry
; CHECK-NEXT:    global.get __stack_pointer
; CHECK-NEXT:    i32.const 16
; CHECK-NEXT:    i32.sub
; CHECK-NEXT:    local.tee 4
; CHECK-NEXT:    global.set __stack_pointer
; CHECK-NEXT:    local.get 4
; CHECK-NEXT:    local.get 3
; CHECK-NEXT:    i32.store 12
; CHECK-NEXT:    local.get 4
; CHECK-NEXT:    local.get 2
; CHECK-NEXT:    i32.store 8
; CHECK-NEXT:    local.get 4
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    i32.store 4
; CHECK-NEXT:    local.get 4
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    i32.store 0
; CHECK-NEXT:    local.get 4
; CHECK-NEXT:    call sink
; CHECK-NEXT:    local.get 4
; CHECK-NEXT:    i32.const 16
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    global.set __stack_pointer
; CHECK-NEXT:    # fallthrough-return
entry:
  tail call void (...) @sink(<4 x i32> noundef %x)
  ret void
}

; Function Attrs: nounwind
define void @pass_int_s0(i32 noundef %i) {
; CHECK-LABEL: pass_int_s0:
; CHECK:         .functype pass_int_s0 (i32) -> ()
; CHECK-NEXT:    .local i32
; CHECK-NEXT:  # %bb.0: # %entry
; CHECK-NEXT:    global.get __stack_pointer
; CHECK-NEXT:    i32.const 16
; CHECK-NEXT:    i32.sub
; CHECK-NEXT:    local.tee 1
; CHECK-NEXT:    global.set __stack_pointer
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    i32.store 0
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    call sink
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    i32.const 16
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    global.set __stack_pointer
; CHECK-NEXT:    # fallthrough-return
entry:
  tail call void (...) @sink(i32 noundef %i)
  ret void
}

; Function Attrs: nounwind
define void @pass_int_s1(i32 noundef %i, i8 %x.coerce) {
; CHECK-LABEL: pass_int_s1:
; CHECK:         .functype pass_int_s1 (i32, i32) -> ()
; CHECK-NEXT:    .local i32
; CHECK-NEXT:  # %bb.0: # %entry
; CHECK-NEXT:    global.get __stack_pointer
; CHECK-NEXT:    i32.const 16
; CHECK-NEXT:    i32.sub
; CHECK-NEXT:    local.tee 2
; CHECK-NEXT:    global.set __stack_pointer
; CHECK-NEXT:    local.get 2
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    i32.store 4
; CHECK-NEXT:    local.get 2
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    i32.store 0
; CHECK-NEXT:    local.get 2
; CHECK-NEXT:    call sink
; CHECK-NEXT:    local.get 2
; CHECK-NEXT:    i32.const 16
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    global.set __stack_pointer
; CHECK-NEXT:    # fallthrough-return
entry:
  tail call void (...) @sink(i32 noundef %i, i8 %x.coerce)
  ret void
}

; Function Attrs: nounwind
define void @pass_int_s2(i32 noundef %i, i16 %x.coerce) {
; CHECK-LABEL: pass_int_s2:
; CHECK:         .functype pass_int_s2 (i32, i32) -> ()
; CHECK-NEXT:    .local i32
; CHECK-NEXT:  # %bb.0: # %entry
; CHECK-NEXT:    global.get __stack_pointer
; CHECK-NEXT:    i32.const 16
; CHECK-NEXT:    i32.sub
; CHECK-NEXT:    local.tee 2
; CHECK-NEXT:    global.set __stack_pointer
; CHECK-NEXT:    local.get 2
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    i32.store 4
; CHECK-NEXT:    local.get 2
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    i32.store 0
; CHECK-NEXT:    local.get 2
; CHECK-NEXT:    call sink
; CHECK-NEXT:    local.get 2
; CHECK-NEXT:    i32.const 16
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    global.set __stack_pointer
; CHECK-NEXT:    # fallthrough-return
entry:
  tail call void (...) @sink(i32 noundef %i, i16 %x.coerce)
  ret void
}

; Function Attrs: nounwind
define void @pass_int_s3(i32 noundef %i, i32 %x.coerce) {
; CHECK-LABEL: pass_int_s3:
; CHECK:         .functype pass_int_s3 (i32, i32) -> ()
; CHECK-NEXT:    .local i32
; CHECK-NEXT:  # %bb.0: # %entry
; CHECK-NEXT:    global.get __stack_pointer
; CHECK-NEXT:    i32.const 16
; CHECK-NEXT:    i32.sub
; CHECK-NEXT:    local.tee 2
; CHECK-NEXT:    global.set __stack_pointer
; CHECK-NEXT:    local.get 2
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    i32.store 4
; CHECK-NEXT:    local.get 2
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    i32.store 0
; CHECK-NEXT:    local.get 2
; CHECK-NEXT:    call sink
; CHECK-NEXT:    local.get 2
; CHECK-NEXT:    i32.const 16
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    global.set __stack_pointer
; CHECK-NEXT:    # fallthrough-return
entry:
  tail call void (...) @sink(i32 noundef %i, i32 %x.coerce)
  ret void
}

; Function Attrs: nounwind
define void @pass_int_s4(i32 noundef %i, i64 %x.coerce) {
; CHECK-LABEL: pass_int_s4:
; CHECK:         .functype pass_int_s4 (i32, i64) -> ()
; CHECK-NEXT:    .local i32
; CHECK-NEXT:  # %bb.0: # %entry
; CHECK-NEXT:    global.get __stack_pointer
; CHECK-NEXT:    i32.const 16
; CHECK-NEXT:    i32.sub
; CHECK-NEXT:    local.tee 2
; CHECK-NEXT:    global.set __stack_pointer
; CHECK-NEXT:    local.get 2
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    i64.store 8
; CHECK-NEXT:    local.get 2
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    i32.store 0
; CHECK-NEXT:    local.get 2
; CHECK-NEXT:    call sink
; CHECK-NEXT:    local.get 2
; CHECK-NEXT:    i32.const 16
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    global.set __stack_pointer
; CHECK-NEXT:    # fallthrough-return
entry:
  tail call void (...) @sink(i32 noundef %i, i64 %x.coerce)
  ret void
}

; Function Attrs: nounwind
define void @pass_int_s5(i32 noundef %i, <4 x i32> noundef %x) {
; CHECK-LABEL: pass_int_s5:
; CHECK:         .functype pass_int_s5 (i32, i32, i32, i32, i32) -> ()
; CHECK-NEXT:    .local i32
; CHECK-NEXT:  # %bb.0: # %entry
; CHECK-NEXT:    global.get __stack_pointer
; CHECK-NEXT:    i32.const 32
; CHECK-NEXT:    i32.sub
; CHECK-NEXT:    local.tee 5
; CHECK-NEXT:    global.set __stack_pointer
; CHECK-NEXT:    local.get 5
; CHECK-NEXT:    i32.const 28
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 4
; CHECK-NEXT:    i32.store 0
; CHECK-NEXT:    local.get 5
; CHECK-NEXT:    i32.const 24
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 3
; CHECK-NEXT:    i32.store 0
; CHECK-NEXT:    local.get 5
; CHECK-NEXT:    i32.const 20
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 2
; CHECK-NEXT:    i32.store 0
; CHECK-NEXT:    local.get 5
; CHECK-NEXT:    i32.const 16
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    i32.store 0
; CHECK-NEXT:    local.get 5
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    i32.store 0
; CHECK-NEXT:    local.get 5
; CHECK-NEXT:    call sink
; CHECK-NEXT:    local.get 5
; CHECK-NEXT:    i32.const 32
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    global.set __stack_pointer
; CHECK-NEXT:    # fallthrough-return
entry:
  tail call void (...) @sink(i32 noundef %i, <4 x i32> noundef %x)
  ret void
}

; Function Attrs: nounwind
define void @pass_asc(i8 %x1.coerce, i16 %x2.coerce, i32 %x3.coerce, i64 %x4.coerce, <4 x i32> noundef %x5) {
; CHECK-LABEL: pass_asc:
; CHECK:         .functype pass_asc (i32, i32, i32, i64, i32, i32, i32, i32) -> ()
; CHECK-NEXT:    .local i32
; CHECK-NEXT:  # %bb.0: # %entry
; CHECK-NEXT:    global.get __stack_pointer
; CHECK-NEXT:    i32.const 48
; CHECK-NEXT:    i32.sub
; CHECK-NEXT:    local.tee 8
; CHECK-NEXT:    global.set __stack_pointer
; CHECK-NEXT:    local.get 8
; CHECK-NEXT:    i32.const 44
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 7
; CHECK-NEXT:    i32.store 0
; CHECK-NEXT:    local.get 8
; CHECK-NEXT:    i32.const 40
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 6
; CHECK-NEXT:    i32.store 0
; CHECK-NEXT:    local.get 8
; CHECK-NEXT:    i32.const 36
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 5
; CHECK-NEXT:    i32.store 0
; CHECK-NEXT:    local.get 8
; CHECK-NEXT:    i32.const 32
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 4
; CHECK-NEXT:    i32.store 0
; CHECK-NEXT:    local.get 8
; CHECK-NEXT:    i32.const 16
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 3
; CHECK-NEXT:    i64.store 0
; CHECK-NEXT:    local.get 8
; CHECK-NEXT:    local.get 2
; CHECK-NEXT:    i32.store 8
; CHECK-NEXT:    local.get 8
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    i32.store 4
; CHECK-NEXT:    local.get 8
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    i32.store 0
; CHECK-NEXT:    local.get 8
; CHECK-NEXT:    call sink
; CHECK-NEXT:    local.get 8
; CHECK-NEXT:    i32.const 48
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    global.set __stack_pointer
; CHECK-NEXT:    # fallthrough-return
entry:
  tail call void (...) @sink(i8 %x1.coerce, i16 %x2.coerce, i32 %x3.coerce, i64 %x4.coerce, <4 x i32> noundef %x5)
  ret void
}

; Function Attrs: nounwind
define void @pass_dsc(<4 x i32> noundef %x0, i64 %x1.coerce, i32 %x2.coerce, i16 %x3.coerce, i8 %x4.coerce) {
; CHECK-LABEL: pass_dsc:
; CHECK:         .functype pass_dsc (i32, i32, i32, i32, i64, i32, i32, i32) -> ()
; CHECK-NEXT:    .local i32
; CHECK-NEXT:  # %bb.0: # %entry
; CHECK-NEXT:    global.get __stack_pointer
; CHECK-NEXT:    i32.const 48
; CHECK-NEXT:    i32.sub
; CHECK-NEXT:    local.tee 8
; CHECK-NEXT:    global.set __stack_pointer
; CHECK-NEXT:    local.get 8
; CHECK-NEXT:    i32.const 32
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 7
; CHECK-NEXT:    i32.store 0
; CHECK-NEXT:    local.get 8
; CHECK-NEXT:    i32.const 28
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 6
; CHECK-NEXT:    i32.store 0
; CHECK-NEXT:    local.get 8
; CHECK-NEXT:    i32.const 24
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 5
; CHECK-NEXT:    i32.store 0
; CHECK-NEXT:    local.get 8
; CHECK-NEXT:    i32.const 16
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 4
; CHECK-NEXT:    i64.store 0
; CHECK-NEXT:    local.get 8
; CHECK-NEXT:    local.get 3
; CHECK-NEXT:    i32.store 12
; CHECK-NEXT:    local.get 8
; CHECK-NEXT:    local.get 2
; CHECK-NEXT:    i32.store 8
; CHECK-NEXT:    local.get 8
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    i32.store 4
; CHECK-NEXT:    local.get 8
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    i32.store 0
; CHECK-NEXT:    local.get 8
; CHECK-NEXT:    call sink
; CHECK-NEXT:    local.get 8
; CHECK-NEXT:    i32.const 48
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    global.set __stack_pointer
; CHECK-NEXT:    # fallthrough-return
entry:
  tail call void (...) @sink(<4 x i32> noundef %x0, i64 %x1.coerce, i32 %x2.coerce, i16 %x3.coerce, i8 %x4.coerce)
  ret void
}

; Function Attrs: nounwind
define void @pass_multiple(i32 noundef %i, i8 %x1.coerce, i16 %x2.coerce, i32 %x3.coerce, i64 %x4.coerce, <4 x i32> noundef %x5) {
; CHECK-LABEL: pass_multiple:
; CHECK:         .functype pass_multiple (i32, i32, i32, i32, i64, i32, i32, i32, i32) -> ()
; CHECK-NEXT:    .local i32
; CHECK-NEXT:  # %bb.0: # %entry
; CHECK-NEXT:    global.get __stack_pointer
; CHECK-NEXT:    i32.const 48
; CHECK-NEXT:    i32.sub
; CHECK-NEXT:    local.tee 9
; CHECK-NEXT:    global.set __stack_pointer
; CHECK-NEXT:    local.get 9
; CHECK-NEXT:    local.get 4
; CHECK-NEXT:    i64.store 40
; CHECK-NEXT:    local.get 9
; CHECK-NEXT:    local.get 2
; CHECK-NEXT:    i32.store 36
; CHECK-NEXT:    local.get 9
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    i32.store 32
; CHECK-NEXT:    local.get 9
; CHECK-NEXT:    i32.const 32
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    call sink
; CHECK-NEXT:    local.get 9
; CHECK-NEXT:    i32.const 28
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 8
; CHECK-NEXT:    i32.store 0
; CHECK-NEXT:    local.get 9
; CHECK-NEXT:    i32.const 24
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 7
; CHECK-NEXT:    i32.store 0
; CHECK-NEXT:    local.get 9
; CHECK-NEXT:    i32.const 20
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 6
; CHECK-NEXT:    i32.store 0
; CHECK-NEXT:    local.get 9
; CHECK-NEXT:    i32.const 16
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    local.get 5
; CHECK-NEXT:    i32.store 0
; CHECK-NEXT:    local.get 9
; CHECK-NEXT:    local.get 3
; CHECK-NEXT:    i32.store 8
; CHECK-NEXT:    local.get 9
; CHECK-NEXT:    local.get 1
; CHECK-NEXT:    i32.store 4
; CHECK-NEXT:    local.get 9
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    i32.store 0
; CHECK-NEXT:    local.get 9
; CHECK-NEXT:    call sink
; CHECK-NEXT:    local.get 9
; CHECK-NEXT:    i32.const 48
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    global.set __stack_pointer
; CHECK-NEXT:    # fallthrough-return
entry:
  tail call void (...) @sink(i32 noundef %i, i16 %x2.coerce, i64 %x4.coerce)
  tail call void (...) @sink(i32 noundef %i, i8 %x1.coerce, i32 %x3.coerce, <4 x i32> noundef %x5)
  ret void
}

