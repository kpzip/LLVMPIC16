; RUN: not llvm-as < %s 2>&1 | FileCheck %s

; Large vector for intrinsics is valid
; CHECK-NOT: llvm.fshr
define dso_local <2147483648 x i32> @test_intrin(<2147483648 x i32> %l, <2147483648 x i32> %r, <2147483648 x i32> %amt) {
entry:
  %b = call <2147483648 x i32> @llvm.fshr.v8192i32(<2147483648 x i32> %l, <2147483648 x i32> %r, <2147483648 x i32> %amt)
  ret <2147483648 x i32> %b
}
declare <2147483648 x i32> @llvm.fshr.v2147483648i32 (<2147483648 x i32> %l, <2147483648 x i32> %r, <2147483648 x i32> %amt)

; CHECK: Incorrect alignment of return type to called function!
; CHECK: bar
define dso_local void @foo() {
entry:
  call <2147483648 x float> @bar()
  ret void
}

declare dso_local <2147483648 x float> @bar()
