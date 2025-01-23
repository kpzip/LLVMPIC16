; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --check-attributes --check-globals
; RUN: opt < %s -passes=debugify,simplifycfg -simplifycfg-require-and-preserve-domtree=1 -sink-common-insts -S | FileCheck %s
; RUN: opt < %s -passes='debugify,simplifycfg<sink-common-insts>' -S | FileCheck %s
; RUN: opt < %s -passes='debugify,simplifycfg<sink-common-insts>' -S --try-experimental-debuginfo-iterators | FileCheck %s

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; More interesting test, here we can merge the invokes.
define void @t1_mergeable_invoke() personality ptr @__gxx_personality_v0 {
; CHECK-LABEL: @t1_mergeable_invoke(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[C0:%.*]] = call i1 @cond(), !dbg [[DBG12:![0-9]+]]
; CHECK-NEXT:      #dbg_value(i1 [[C0]], [[META9:![0-9]+]], !DIExpression(), [[DBG12]])
; CHECK-NEXT:    br i1 [[C0]], label [[IF_THEN1_INVOKE:%.*]], label [[IF_ELSE:%.*]], !dbg [[DBG13:![0-9]+]]
; CHECK:       lpad:
; CHECK-NEXT:    [[EH:%.*]] = landingpad { ptr, i32 }
; CHECK-NEXT:            cleanup, !dbg [[DBG14:![0-9]+]]
; CHECK-NEXT:    call void @destructor(), !dbg [[DBG15:![0-9]+]]
; CHECK-NEXT:    resume { ptr, i32 } [[EH]], !dbg [[DBG16:![0-9]+]]
; CHECK:       if.else:
; CHECK-NEXT:    [[C1:%.*]] = call i1 @cond(), !dbg [[DBG17:![0-9]+]]
; CHECK-NEXT:      #dbg_value(i1 [[C1]], [[META11:![0-9]+]], !DIExpression(), [[DBG17]])
; CHECK-NEXT:    br i1 [[C1]], label [[IF_THEN1_INVOKE]], label [[IF_END:%.*]], !dbg [[DBG18:![0-9]+]]
; CHECK:       if.then1.invoke:
; CHECK-NEXT:    invoke void @simple_throw()
; CHECK-NEXT:            to label [[IF_THEN1_CONT:%.*]] unwind label [[LPAD:%.*]], !dbg [[DBG19:![0-9]+]]
; CHECK:       if.then1.cont:
; CHECK-NEXT:    unreachable
; CHECK:       if.end:
; CHECK-NEXT:    call void @sideeffect(), !dbg [[DBG20:![0-9]+]]
; CHECK-NEXT:    ret void, !dbg [[DBG21:![0-9]+]]
;
entry:
  %c0 = call i1 @cond()
  br i1 %c0, label %if.then0, label %if.else

if.then0:
  invoke void @simple_throw() to label %invoke.cont0 unwind label %lpad

invoke.cont0:
  unreachable

lpad:
  %eh = landingpad { ptr, i32 } cleanup
  call void @destructor()
  resume { ptr, i32 } %eh

if.else:
  %c1 = call i1 @cond()
  br i1 %c1, label %if.then1, label %if.end

if.then1:
  invoke void @simple_throw() to label %invoke.cont2 unwind label %lpad

invoke.cont2:
  unreachable

if.end:
  call void @sideeffect()
  ret void
}

declare i1 @cond()
declare void @sideeffect()
declare void @simple_throw() noreturn
declare void @destructor()

declare dso_local i32 @__gxx_personality_v0(...)
;.
; CHECK: attributes #[[ATTR0:[0-9]+]] = { noreturn }
;.
; CHECK: [[META0:![0-9]+]] = distinct !DICompileUnit(language: DW_LANG_C, file: [[META1:![0-9]+]], producer: "debugify", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug)
; CHECK: [[META1]] = !DIFile(filename: "<stdin>", directory: {{.*}})
; CHECK: [[META2:![0-9]+]] = !{i32 13}
; CHECK: [[META3:![0-9]+]] = !{i32 2}
; CHECK: [[META4:![0-9]+]] = !{i32 2, !"Debug Info Version", i32 3}
; CHECK: [[META5:![0-9]+]] = distinct !DISubprogram(name: "t1_mergeable_invoke", linkageName: "t1_mergeable_invoke", scope: null, file: [[META1]], line: 1, type: [[META6:![0-9]+]], scopeLine: 1, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: [[META0]], retainedNodes: [[META8:![0-9]+]])
; CHECK: [[META6]] = !DISubroutineType(types: [[META7:![0-9]+]])
; CHECK: [[META7]] = !{}
; CHECK: [[META8]] = !{[[META9]], [[META11]]}
; CHECK: [[META9]] = !DILocalVariable(name: "1", scope: [[META5]], file: [[META1]], line: 1, type: [[META10:![0-9]+]])
; CHECK: [[META10]] = !DIBasicType(name: "ty8", size: 8, encoding: DW_ATE_unsigned)
; CHECK: [[META11]] = !DILocalVariable(name: "2", scope: [[META5]], file: [[META1]], line: 8, type: [[META10]])
; CHECK: [[DBG12]] = !DILocation(line: 1, column: 1, scope: [[META5]])
; CHECK: [[DBG13]] = !DILocation(line: 2, column: 1, scope: [[META5]])
; CHECK: [[DBG14]] = !DILocation(line: 5, column: 1, scope: [[META5]])
; CHECK: [[DBG15]] = !DILocation(line: 6, column: 1, scope: [[META5]])
; CHECK: [[DBG16]] = !DILocation(line: 7, column: 1, scope: [[META5]])
; CHECK: [[DBG17]] = !DILocation(line: 8, column: 1, scope: [[META5]])
; CHECK: [[DBG18]] = !DILocation(line: 9, column: 1, scope: [[META5]])
; CHECK: [[DBG19]] = !DILocation(line: 0, scope: [[META5]])
; CHECK: [[DBG20]] = !DILocation(line: 12, column: 1, scope: [[META5]])
; CHECK: [[DBG21]] = !DILocation(line: 13, column: 1, scope: [[META5]])
;.
