; RUN: opt -S -passes=wholeprogramdevirt -whole-program-visibility %s | FileCheck %s

target datalayout = "e-p:64:64"
target triple = "x86_64-unknown-linux-gnu"

@vt1 = constant [1 x ptr] [ptr @vf1], !type !0
@vt2 = constant [1 x ptr] [ptr @vf2], !type !0

define i32 @vf1() readnone {
  ret i32 1
}

define i32 @vf2() readnone {
  ret i32 2
}

; CHECK: define i32 @call
define i32 @call(ptr %obj) {
  %vtable = load ptr, ptr %obj
  %p = call i1 @llvm.type.test(ptr %vtable, metadata !"typeid")
  call void @llvm.assume(i1 %p)
  %fptr = load ptr, ptr %vtable
  ; CHECK: call i32 %
  %result = call i32 %fptr()
  ret i32 %result
}

declare i1 @llvm.type.test(ptr, metadata)
declare void @llvm.assume(i1)

!0 = !{i32 0, !"typeid"}
