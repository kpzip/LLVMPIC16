; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc -mtriple=powerpc64le-unknown-linux-gnu -global-isel \
; RUN:     -verify-machineinstrs -stop-after=irtranslator < %s | FileCheck %s

; Mixed parameter passing involving integers, floats, vectors (all in registers).
define void @test_mixed_arg1(i32 %a, i32 %b, i32 %c, <4 x i32> %d) {
  ; CHECK-LABEL: name: test_mixed_arg1
  ; CHECK: bb.1.entry:
  ; CHECK-NEXT:   liveins: $v2, $x3, $x4, $x5
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(s64) = COPY $x3
  ; CHECK-NEXT:   [[TRUNC:%[0-9]+]]:_(s32) = G_TRUNC [[COPY]](s64)
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(s64) = COPY $x4
  ; CHECK-NEXT:   [[TRUNC1:%[0-9]+]]:_(s32) = G_TRUNC [[COPY1]](s64)
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(s64) = COPY $x5
  ; CHECK-NEXT:   [[TRUNC2:%[0-9]+]]:_(s32) = G_TRUNC [[COPY2]](s64)
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:_(<4 x s32>) = COPY $v2
  ; CHECK-NEXT:   BLR8 implicit $lr8, implicit $rm
entry:
  ret void
}

define void @test_mixed_arg2(i32 %a, i32 %b, <4 x i32> %c, i32 %d) {
  ; CHECK-LABEL: name: test_mixed_arg2
  ; CHECK: bb.1.entry:
  ; CHECK-NEXT:   liveins: $v2, $x3, $x4, $x7
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(s64) = COPY $x3
  ; CHECK-NEXT:   [[TRUNC:%[0-9]+]]:_(s32) = G_TRUNC [[COPY]](s64)
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(s64) = COPY $x4
  ; CHECK-NEXT:   [[TRUNC1:%[0-9]+]]:_(s32) = G_TRUNC [[COPY1]](s64)
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(<4 x s32>) = COPY $v2
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:_(s64) = COPY $x7
  ; CHECK-NEXT:   [[TRUNC2:%[0-9]+]]:_(s32) = G_TRUNC [[COPY3]](s64)
  ; CHECK-NEXT:   BLR8 implicit $lr8, implicit $rm
entry:
  ret void
}

define void @test_mixed_arg3(i32 %a, i32 %b, i32 %c, <4 x i32> %d, i32 %e) {
  ; CHECK-LABEL: name: test_mixed_arg3
  ; CHECK: bb.1.entry:
  ; CHECK-NEXT:   liveins: $v2, $x3, $x4, $x5, $x9
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(s64) = COPY $x3
  ; CHECK-NEXT:   [[TRUNC:%[0-9]+]]:_(s32) = G_TRUNC [[COPY]](s64)
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(s64) = COPY $x4
  ; CHECK-NEXT:   [[TRUNC1:%[0-9]+]]:_(s32) = G_TRUNC [[COPY1]](s64)
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(s64) = COPY $x5
  ; CHECK-NEXT:   [[TRUNC2:%[0-9]+]]:_(s32) = G_TRUNC [[COPY2]](s64)
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:_(<4 x s32>) = COPY $v2
  ; CHECK-NEXT:   [[COPY4:%[0-9]+]]:_(s64) = COPY $x9
  ; CHECK-NEXT:   [[TRUNC3:%[0-9]+]]:_(s32) = G_TRUNC [[COPY4]](s64)
  ; CHECK-NEXT:   BLR8 implicit $lr8, implicit $rm
entry:
  ret void
}

define void @test_mixed_arg4(<2 x double> %a, <4 x i32> %b, <4 x i32> %c, i32 %d, i64 %e, double %f) {
  ; CHECK-LABEL: name: test_mixed_arg4
  ; CHECK: bb.1.entry:
  ; CHECK-NEXT:   liveins: $f1, $v2, $v3, $v4, $x9, $x10
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(<2 x s64>) = COPY $v2
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(<4 x s32>) = COPY $v3
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(<4 x s32>) = COPY $v4
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:_(s64) = COPY $x9
  ; CHECK-NEXT:   [[TRUNC:%[0-9]+]]:_(s32) = G_TRUNC [[COPY3]](s64)
  ; CHECK-NEXT:   [[COPY4:%[0-9]+]]:_(s64) = COPY $x10
  ; CHECK-NEXT:   [[COPY5:%[0-9]+]]:_(s64) = COPY $f1
  ; CHECK-NEXT:   BLR8 implicit $lr8, implicit $rm
entry:
  ret void
}

define void @test_mixed_arg5(float %a, i32 %b, <2 x i64> %c, i64 %d, double %e, <4 x float> %f) {
  ; CHECK-LABEL: name: test_mixed_arg5
  ; CHECK: bb.1.entry:
  ; CHECK-NEXT:   liveins: $f1, $f2, $v2, $v3, $x4, $x7
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(s32) = COPY $f1
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(s64) = COPY $x4
  ; CHECK-NEXT:   [[TRUNC:%[0-9]+]]:_(s32) = G_TRUNC [[COPY1]](s64)
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(<2 x s64>) = COPY $v2
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:_(s64) = COPY $x7
  ; CHECK-NEXT:   [[COPY4:%[0-9]+]]:_(s64) = COPY $f2
  ; CHECK-NEXT:   [[COPY5:%[0-9]+]]:_(<4 x s32>) = COPY $v3
  ; CHECK-NEXT:   BLR8 implicit $lr8, implicit $rm
entry:
  ret void
}

define void @test_mixed_arg6(i64 %a, double %b, i32 %c, i32 %d, <2 x i64> %e, <4 x i32> %f, <4 x i32> %g, <4 x float> %h) {
  ; CHECK-LABEL: name: test_mixed_arg6
  ; CHECK: bb.1.entry:
  ; CHECK-NEXT:   liveins: $f1, $v2, $v3, $v4, $v5, $x3, $x5, $x6
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(s64) = COPY $x3
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(s64) = COPY $f1
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(s64) = COPY $x5
  ; CHECK-NEXT:   [[TRUNC:%[0-9]+]]:_(s32) = G_TRUNC [[COPY2]](s64)
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:_(s64) = COPY $x6
  ; CHECK-NEXT:   [[TRUNC1:%[0-9]+]]:_(s32) = G_TRUNC [[COPY3]](s64)
  ; CHECK-NEXT:   [[COPY4:%[0-9]+]]:_(<2 x s64>) = COPY $v2
  ; CHECK-NEXT:   [[COPY5:%[0-9]+]]:_(<4 x s32>) = COPY $v3
  ; CHECK-NEXT:   [[COPY6:%[0-9]+]]:_(<4 x s32>) = COPY $v4
  ; CHECK-NEXT:   [[COPY7:%[0-9]+]]:_(<4 x s32>) = COPY $v5
  ; CHECK-NEXT:   BLR8 implicit $lr8, implicit $rm
entry:
  ret void
}

define void @test_mixed_arg7(i32 %a, float %b, i32 %c, float %d, <4 x float> %e, <4 x i32> %f) {
  ; CHECK-LABEL: name: test_mixed_arg7
  ; CHECK: bb.1.entry:
  ; CHECK-NEXT:   liveins: $f1, $f2, $v2, $v3, $x3, $x5
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(s64) = COPY $x3
  ; CHECK-NEXT:   [[TRUNC:%[0-9]+]]:_(s32) = G_TRUNC [[COPY]](s64)
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(s32) = COPY $f1
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(s64) = COPY $x5
  ; CHECK-NEXT:   [[TRUNC1:%[0-9]+]]:_(s32) = G_TRUNC [[COPY2]](s64)
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:_(s32) = COPY $f2
  ; CHECK-NEXT:   [[COPY4:%[0-9]+]]:_(<4 x s32>) = COPY $v2
  ; CHECK-NEXT:   [[COPY5:%[0-9]+]]:_(<4 x s32>) = COPY $v3
  ; CHECK-NEXT:   BLR8 implicit $lr8, implicit $rm
entry:
  ret void
}

define void @test_mixed_arg8(<4 x i32> %a, float %b, i32 %c, i64 %d, <2 x double> %e, double %f) {
  ; CHECK-LABEL: name: test_mixed_arg8
  ; CHECK: bb.1.entry:
  ; CHECK-NEXT:   liveins: $f1, $f2, $v2, $v3, $x6, $x7
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(<4 x s32>) = COPY $v2
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(s32) = COPY $f1
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(s64) = COPY $x6
  ; CHECK-NEXT:   [[TRUNC:%[0-9]+]]:_(s32) = G_TRUNC [[COPY2]](s64)
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:_(s64) = COPY $x7
  ; CHECK-NEXT:   [[COPY4:%[0-9]+]]:_(<2 x s64>) = COPY $v3
  ; CHECK-NEXT:   [[COPY5:%[0-9]+]]:_(s64) = COPY $f2
  ; CHECK-NEXT:   BLR8 implicit $lr8, implicit $rm
entry:
  ret void
}

define void @test_mixed_arg9(<4 x float> %a, i32 %b, i32 %c, <4 x i32> %d, i32 %e, double %f) {
  ; CHECK-LABEL: name: test_mixed_arg9
  ; CHECK: bb.1.entry:
  ; CHECK-NEXT:   liveins: $f1, $v2, $v3, $x5, $x6, $x9
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(<4 x s32>) = COPY $v2
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(s64) = COPY $x5
  ; CHECK-NEXT:   [[TRUNC:%[0-9]+]]:_(s32) = G_TRUNC [[COPY1]](s64)
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(s64) = COPY $x6
  ; CHECK-NEXT:   [[TRUNC1:%[0-9]+]]:_(s32) = G_TRUNC [[COPY2]](s64)
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:_(<4 x s32>) = COPY $v3
  ; CHECK-NEXT:   [[COPY4:%[0-9]+]]:_(s64) = COPY $x9
  ; CHECK-NEXT:   [[TRUNC2:%[0-9]+]]:_(s32) = G_TRUNC [[COPY4]](s64)
  ; CHECK-NEXT:   [[COPY5:%[0-9]+]]:_(s64) = COPY $f1
  ; CHECK-NEXT:   BLR8 implicit $lr8, implicit $rm
entry:
  ret void
}

define void @test_mixed_arg10(i32 %a, float %b, i64 %c, <2 x double> %d, <4 x float> %e, double %f) {
  ; CHECK-LABEL: name: test_mixed_arg10
  ; CHECK: bb.1.entry:
  ; CHECK-NEXT:   liveins: $f1, $f2, $v2, $v3, $x3, $x5
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(s64) = COPY $x3
  ; CHECK-NEXT:   [[TRUNC:%[0-9]+]]:_(s32) = G_TRUNC [[COPY]](s64)
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(s32) = COPY $f1
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(s64) = COPY $x5
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:_(<2 x s64>) = COPY $v2
  ; CHECK-NEXT:   [[COPY4:%[0-9]+]]:_(<4 x s32>) = COPY $v3
  ; CHECK-NEXT:   [[COPY5:%[0-9]+]]:_(s64) = COPY $f2
  ; CHECK-NEXT:   BLR8 implicit $lr8, implicit $rm
entry:
  ret void
}

define void @test_mixed_arg11(double %a, float %b, i32 %c, i64 %d, i32 %e, double %f, <4 x i32> %g) {
  ; CHECK-LABEL: name: test_mixed_arg11
  ; CHECK: bb.1.entry:
  ; CHECK-NEXT:   liveins: $f1, $f2, $f3, $v2, $x5, $x6, $x7
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(s64) = COPY $f1
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(s32) = COPY $f2
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(s64) = COPY $x5
  ; CHECK-NEXT:   [[TRUNC:%[0-9]+]]:_(s32) = G_TRUNC [[COPY2]](s64)
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:_(s64) = COPY $x6
  ; CHECK-NEXT:   [[COPY4:%[0-9]+]]:_(s64) = COPY $x7
  ; CHECK-NEXT:   [[TRUNC1:%[0-9]+]]:_(s32) = G_TRUNC [[COPY4]](s64)
  ; CHECK-NEXT:   [[COPY5:%[0-9]+]]:_(s64) = COPY $f3
  ; CHECK-NEXT:   [[COPY6:%[0-9]+]]:_(<4 x s32>) = COPY $v2
  ; CHECK-NEXT:   BLR8 implicit $lr8, implicit $rm
entry:
  ret void
}

define void @test_mixed_arg12(<2 x double> %a, <4 x i32> %b, i32 %c, i32 %d, i64 %e, float %f) {
  ; CHECK-LABEL: name: test_mixed_arg12
  ; CHECK: bb.1.entry:
  ; CHECK-NEXT:   liveins: $f1, $v2, $v3, $x7, $x8, $x9
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(<2 x s64>) = COPY $v2
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(<4 x s32>) = COPY $v3
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(s64) = COPY $x7
  ; CHECK-NEXT:   [[TRUNC:%[0-9]+]]:_(s32) = G_TRUNC [[COPY2]](s64)
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:_(s64) = COPY $x8
  ; CHECK-NEXT:   [[TRUNC1:%[0-9]+]]:_(s32) = G_TRUNC [[COPY3]](s64)
  ; CHECK-NEXT:   [[COPY4:%[0-9]+]]:_(s64) = COPY $x9
  ; CHECK-NEXT:   [[COPY5:%[0-9]+]]:_(s32) = COPY $f1
  ; CHECK-NEXT:   BLR8 implicit $lr8, implicit $rm
entry:
  ret void
}

define void @test_mixed_arg13(i8 %a, <2 x double> %b, i64 %c, <4 x i32> %d, double %e) {
  ; CHECK-LABEL: name: test_mixed_arg13
  ; CHECK: bb.1.entry:
  ; CHECK-NEXT:   liveins: $f1, $v2, $v3, $x3, $x7
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(s64) = COPY $x3
  ; CHECK-NEXT:   [[TRUNC:%[0-9]+]]:_(s8) = G_TRUNC [[COPY]](s64)
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(<2 x s64>) = COPY $v2
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(s64) = COPY $x7
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:_(<4 x s32>) = COPY $v3
  ; CHECK-NEXT:   [[COPY4:%[0-9]+]]:_(s64) = COPY $f1
  ; CHECK-NEXT:   BLR8 implicit $lr8, implicit $rm
entry:
  ret void
}
