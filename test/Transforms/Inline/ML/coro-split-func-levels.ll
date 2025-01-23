; REQUIRES: llvm_inliner_model_autogenerated
; RUN: opt -S -passes='coro-early,scc-oz-module-inliner,print<inline-advisor>' \
; RUN:  -enable-ml-inliner=release -keep-inline-advisor-for-printing < %s

define void @_Z5get_sv() presplitcoroutine {
  %1 = call token @llvm.coro.id(i32 0, ptr null, ptr null, ptr null)
  %2 = call ptr @llvm.coro.begin(token %1, ptr null)
  %3 = call token @llvm.coro.save(ptr null)
  %4 = call i8 @llvm.coro.suspend(token none, i1 false)
  call void @_ZN1S12promise_typeD2Ev()
  ret void
}

declare token @llvm.coro.id(i32, ptr readnone, ptr nocapture readonly, ptr)
declare ptr @llvm.coro.begin(token, ptr writeonly)
declare token @llvm.coro.save(ptr)
declare i8 @llvm.coro.suspend(token, i1)

declare void @__clang_call_terminate()

define void @_ZN1S12promise_typeD2Ev() personality ptr null {
  invoke void @_Z4funcv()
          to label %1 unwind label %2

1:                                                ; preds = %0
  ret void

2:                                                ; preds = %0
  %3 = landingpad { ptr, i32 }
          catch ptr null
  call void @__clang_call_terminate()
  unreachable
}
declare void @_Z4funcv()

; CHECK:      [MLInlineAdvisor] FuncLevels:
; CHECK-NEXT: _Z5get_sv : 1
; CHECK-NEXT: _ZN1S12promise_typeD2Ev : 0
; CHECK-NEXT: _Z5get_sv.resume : 1
; CHECK-NEXT: _Z5get_sv.destroy : 1
; CHECK-NEXT: _Z5get_sv.cleanup : 1
