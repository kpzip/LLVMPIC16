; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -O2 -S %s | FileCheck %s --check-prefix=WITHGLOBALSAA
; RUN: opt -O2 -enable-global-analyses=0 -S %s | FileCheck %s --check-prefix=NOGLOBALSAA

@glb = internal global i8 0

define i8 @f(ptr %ptr) {
; WITHGLOBALSAA-LABEL: @f(
; WITHGLOBALSAA-NEXT:    store i8 1, ptr [[PTR:%.*]], align 1
; WITHGLOBALSAA-NEXT:    store i1 true, ptr @glb, align 1
; WITHGLOBALSAA-NEXT:    ret i8 1
;
; NOGLOBALSAA-LABEL: @f(
; NOGLOBALSAA-NEXT:    store i8 1, ptr [[PTR:%.*]], align 1
; NOGLOBALSAA-NEXT:    store i1 true, ptr @glb, align 1
; NOGLOBALSAA-NEXT:    [[R:%.*]] = load i8, ptr [[PTR]], align 1
; NOGLOBALSAA-NEXT:    ret i8 [[R]]
;
  store i8 1, ptr %ptr
  store i8 2, ptr @glb
  %r = load i8, ptr %ptr
  ret i8 %r
}

define i8 @dummy() {
; WITHGLOBALSAA-LABEL: @dummy(
; WITHGLOBALSAA-NEXT:    [[VAL_B:%.*]] = load i1, ptr @glb, align 1
; WITHGLOBALSAA-NEXT:    [[VAL:%.*]] = select i1 [[VAL_B]], i8 2, i8 0
; WITHGLOBALSAA-NEXT:    ret i8 [[VAL]]
;
; NOGLOBALSAA-LABEL: @dummy(
; NOGLOBALSAA-NEXT:    [[VAL_B:%.*]] = load i1, ptr @glb, align 1
; NOGLOBALSAA-NEXT:    [[VAL:%.*]] = select i1 [[VAL_B]], i8 2, i8 0
; NOGLOBALSAA-NEXT:    ret i8 [[VAL]]
;
  %val = load i8, ptr @glb
  ret i8 %val
}
