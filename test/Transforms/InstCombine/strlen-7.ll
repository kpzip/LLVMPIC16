; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; Verify that strlen calls with members of constant structs are folded.
;
; RUN: opt < %s -passes=instcombine -S | FileCheck %s

declare i64 @strlen(ptr)

%struct.A = type { [4 x i8], [5 x i8] }

@a = constant [2 x %struct.A] [%struct.A { [4 x i8] c"1\00\00\00", [5 x i8] c"12\00\00\00" }, %struct.A { [4 x i8] c"123\00", [5 x i8] c"1234\00" }], align 16


; Fold strlen(a[I].a + J) and strlen(a[I].b + J) with constant I and J
; to constants.

define void @fold_strlen_A(ptr %plen) {
; CHECK-LABEL: @fold_strlen_A(
; CHECK-NEXT:    store i64 1, ptr [[PLEN:%.*]], align 4
; CHECK-NEXT:    [[PLEN1:%.*]] = getelementptr i8, ptr [[PLEN]], i64 8
; CHECK-NEXT:    store i64 0, ptr [[PLEN1]], align 4
; CHECK-NEXT:    [[PLEN2:%.*]] = getelementptr i8, ptr [[PLEN]], i64 16
; CHECK-NEXT:    store i64 0, ptr [[PLEN2]], align 4
; CHECK-NEXT:    [[PLEN3:%.*]] = getelementptr i8, ptr [[PLEN]], i64 24
; CHECK-NEXT:    store i64 0, ptr [[PLEN3]], align 4
; CHECK-NEXT:    [[PLEN4:%.*]] = getelementptr i8, ptr [[PLEN]], i64 32
; CHECK-NEXT:    store i64 2, ptr [[PLEN4]], align 4
; CHECK-NEXT:    [[PLEN5:%.*]] = getelementptr i8, ptr [[PLEN]], i64 40
; CHECK-NEXT:    store i64 1, ptr [[PLEN5]], align 4
; CHECK-NEXT:    [[PLEN6:%.*]] = getelementptr i8, ptr [[PLEN]], i64 48
; CHECK-NEXT:    store i64 0, ptr [[PLEN6]], align 4
; CHECK-NEXT:    [[PLEN7:%.*]] = getelementptr i8, ptr [[PLEN]], i64 56
; CHECK-NEXT:    store i64 0, ptr [[PLEN7]], align 4
; CHECK-NEXT:    [[PLEN8:%.*]] = getelementptr i8, ptr [[PLEN]], i64 64
; CHECK-NEXT:    store i64 0, ptr [[PLEN8]], align 4
; CHECK-NEXT:    [[PLEN9:%.*]] = getelementptr i8, ptr [[PLEN]], i64 72
; CHECK-NEXT:    store i64 3, ptr [[PLEN9]], align 4
; CHECK-NEXT:    [[PLEN10:%.*]] = getelementptr i8, ptr [[PLEN]], i64 80
; CHECK-NEXT:    store i64 2, ptr [[PLEN10]], align 4
; CHECK-NEXT:    [[PLEN11:%.*]] = getelementptr i8, ptr [[PLEN]], i64 88
; CHECK-NEXT:    store i64 1, ptr [[PLEN11]], align 4
; CHECK-NEXT:    [[PLEN12:%.*]] = getelementptr i8, ptr [[PLEN]], i64 96
; CHECK-NEXT:    store i64 0, ptr [[PLEN12]], align 4
; CHECK-NEXT:    [[PLEN14:%.*]] = getelementptr i8, ptr [[PLEN]], i64 112
; CHECK-NEXT:    store i64 4, ptr [[PLEN14]], align 4
; CHECK-NEXT:    [[PLEN15:%.*]] = getelementptr i8, ptr [[PLEN]], i64 120
; CHECK-NEXT:    store i64 3, ptr [[PLEN15]], align 4
; CHECK-NEXT:    [[PLEN16:%.*]] = getelementptr i8, ptr [[PLEN]], i64 128
; CHECK-NEXT:    store i64 2, ptr [[PLEN16]], align 4
; CHECK-NEXT:    [[PLEN17:%.*]] = getelementptr i8, ptr [[PLEN]], i64 136
; CHECK-NEXT:    store i64 1, ptr [[PLEN17]], align 4
; CHECK-NEXT:    [[PLEN18:%.*]] = getelementptr i8, ptr [[PLEN]], i64 144
; CHECK-NEXT:    store i64 0, ptr [[PLEN18]], align 4
; CHECK-NEXT:    ret void
;
; Fold strlen(a[0].a) to 1.
  %lena0a = call i64 @strlen(ptr @a)
  store i64 %lena0a, ptr %plen

; Fold strlen(a[0].a + 1) to 0.
  %pa0ap1 = getelementptr [2 x %struct.A], ptr @a, i64 0, i64 0, i32 0, i64 1
  %lena0ap1 = call i64 @strlen(ptr %pa0ap1)
  %plen1 = getelementptr i64, ptr %plen, i32 1
  store i64 %lena0ap1, ptr %plen1

; Fold strlen(a[0].a + 2) to 0.
  %pa0ap2 = getelementptr [2 x %struct.A], ptr @a, i64 0, i64 0, i32 0, i64 2
  %lena0ap2 = call i64 @strlen(ptr %pa0ap2)
  %plen2 = getelementptr i64, ptr %plen, i32 2
  store i64 %lena0ap2, ptr %plen2

; Fold strlen(a[0].a + 3) to 0.
  %pa0ap3 = getelementptr [2 x %struct.A], ptr @a, i64 0, i64 0, i32 0, i64 3
  %lena0ap3 = call i64 @strlen(ptr %pa0ap3)
  %plen3 = getelementptr i64, ptr %plen, i32 3
  store i64 %lena0ap3, ptr %plen3

; Fold strlen(a[0].b) to 2.
  %pa0b = getelementptr [2 x %struct.A], ptr @a, i64 0, i64 0, i32 1, i64 0
  %lena0b = call i64 @strlen(ptr %pa0b)
  %plen4 = getelementptr i64, ptr %plen, i32 4
  store i64 %lena0b, ptr %plen4

; Fold strlen(a[0].b + 1) to 1.
  %pa0bp1 = getelementptr [2 x %struct.A], ptr @a, i64 0, i64 0, i32 1, i64 1
  %lena0bp1 = call i64 @strlen(ptr %pa0bp1)
  %plen5 = getelementptr i64, ptr %plen, i32 5
  store i64 %lena0bp1, ptr %plen5

; Fold strlen(a[0].b + 2) to 0.
  %pa0bp2 = getelementptr [2 x %struct.A], ptr @a, i64 0, i64 0, i32 1, i64 2
  %lena0bp2 = call i64 @strlen(ptr %pa0bp2)
  %plen6 = getelementptr i64, ptr %plen, i32 6
  store i64 %lena0bp2, ptr %plen6

; Fold strlen(a[0].b + 3) to 0.
  %pa0bp3 = getelementptr [2 x %struct.A], ptr @a, i64 0, i64 0, i32 1, i64 3
  %lena0bp3 = call i64 @strlen(ptr %pa0bp3)
  %plen7 = getelementptr i64, ptr %plen, i32 7
  store i64 %lena0bp3, ptr %plen7

; Fold strlen(a[0].b + 4) to 0.
  %pa0bp4 = getelementptr [2 x %struct.A], ptr @a, i64 0, i64 0, i32 1, i64 4
  %lena0bp4 = call i64 @strlen(ptr %pa0bp4)
  %plen8 = getelementptr i64, ptr %plen, i32 8
  store i64 %lena0bp4, ptr %plen8

; Fold strlen(a[1].a) to 3.
  %pa1a = getelementptr [2 x %struct.A], ptr @a, i64 0, i64 1, i32 0, i64 0
  %lena1a = call i64 @strlen(ptr %pa1a)
  %plen9 = getelementptr i64, ptr %plen, i32 9
  store i64 %lena1a, ptr %plen9

; Fold strlen(a[1].a + 1) to 2.
  %pa1ap1 = getelementptr [2 x %struct.A], ptr @a, i64 0, i64 1, i32 0, i64 1
  %lena1ap1 = call i64 @strlen(ptr %pa1ap1)
  %plen10 = getelementptr i64, ptr %plen, i32 10
  store i64 %lena1ap1, ptr %plen10

; Fold strlen(a[1].a + 2) to 1.
  %pa1ap2 = getelementptr [2 x %struct.A], ptr @a, i64 0, i64 1, i32 0, i64 2
  %lena1ap2 = call i64 @strlen(ptr %pa1ap2)
  %plen11 = getelementptr i64, ptr %plen, i32 11
  store i64 %lena1ap2, ptr %plen11

; Fold strlen(a[1].a + 3) to 0.
  %pa1ap3 = getelementptr [2 x %struct.A], ptr @a, i64 0, i64 1, i32 0, i64 3
  %lena1ap3 = call i64 @strlen(ptr %pa1ap3)
  %plen12 = getelementptr i64, ptr %plen, i32 12
  store i64 %lena1ap3, ptr %plen12

; Fold strlen(a[1].b) to 4.
  %pa1b = getelementptr [2 x %struct.A], ptr @a, i64 0, i64 1, i32 1, i64 0
  %lena1b = call i64 @strlen(ptr %pa1b)
  %plen14 = getelementptr i64, ptr %plen, i32 14
  store i64 %lena1b, ptr %plen14

; Fold strlen(a[1].b + 1) to 3.
  %pa1bp1 = getelementptr [2 x %struct.A], ptr @a, i64 0, i64 1, i32 1, i64 1
  %lena1bp1 = call i64 @strlen(ptr %pa1bp1)
  %plen15 = getelementptr i64, ptr %plen, i32 15
  store i64 %lena1bp1, ptr %plen15

; Fold strlen(a[1].b + 2) to 2.
  %pa1bp2 = getelementptr [2 x %struct.A], ptr @a, i64 0, i64 1, i32 1, i64 2
  %lena1bp2 = call i64 @strlen(ptr %pa1bp2)
  %plen16 = getelementptr i64, ptr %plen, i32 16
  store i64 %lena1bp2, ptr %plen16

; Fold strlen(a[1].b + 3) to 1.
  %pa1bp3 = getelementptr [2 x %struct.A], ptr @a, i64 0, i64 1, i32 1, i64 3
  %lena1bp3 = call i64 @strlen(ptr %pa1bp3)
  %plen17 = getelementptr i64, ptr %plen, i32 17
  store i64 %lena1bp3, ptr %plen17

; Fold strlen(a[1].b + 4) to 0.
  %pa1bp4 = getelementptr [2 x %struct.A], ptr @a, i64 0, i64 1, i32 1, i64 4
  %lena1bp4 = call i64 @strlen(ptr %pa1bp4)
  %plen18 = getelementptr i64, ptr %plen, i32 18
  store i64 %lena1bp4, ptr %plen18

  ret void
}


; TODO: Fold strlen(a[I].a + X) and strlen(a[I].b + X) with constant I and
; variable X to (X - strlen(a[I].a)) and (X - strlen(a[I].b)) respectively.

define void @fold_strlen_A_pI(ptr %plen, i64 %I) {
; CHECK-LABEL: @fold_strlen_A_pI(
; CHECK-NEXT:    [[PA0A:%.*]] = getelementptr [2 x %struct.A], ptr @a, i64 0, i64 0, i32 0, i64 [[I:%.*]]
; CHECK-NEXT:    [[LENA0A:%.*]] = call i64 @strlen(ptr noundef nonnull dereferenceable(1) [[PA0A]])
; CHECK-NEXT:    store i64 [[LENA0A]], ptr [[PLEN:%.*]], align 4
; CHECK-NEXT:    [[PA0B:%.*]] = getelementptr [2 x %struct.A], ptr @a, i64 0, i64 0, i32 1, i64 [[I]]
; CHECK-NEXT:    [[LENA0B:%.*]] = call i64 @strlen(ptr noundef nonnull dereferenceable(1) [[PA0B]])
; CHECK-NEXT:    [[PLEN1:%.*]] = getelementptr i8, ptr [[PLEN]], i64 8
; CHECK-NEXT:    store i64 [[LENA0B]], ptr [[PLEN1]], align 4
; CHECK-NEXT:    [[PA1A:%.*]] = getelementptr [2 x %struct.A], ptr @a, i64 0, i64 1, i32 0, i64 [[I]]
; CHECK-NEXT:    [[LENA1A:%.*]] = call i64 @strlen(ptr noundef nonnull dereferenceable(1) [[PA1A]])
; CHECK-NEXT:    [[PLEN2:%.*]] = getelementptr i8, ptr [[PLEN]], i64 16
; CHECK-NEXT:    store i64 [[LENA1A]], ptr [[PLEN2]], align 4
; CHECK-NEXT:    [[PA1B:%.*]] = getelementptr [2 x %struct.A], ptr @a, i64 0, i64 1, i32 1, i64 [[I]]
; CHECK-NEXT:    [[LENA1B:%.*]] = call i64 @strlen(ptr noundef nonnull dereferenceable(1) [[PA1B]])
; CHECK-NEXT:    [[PLEN3:%.*]] = getelementptr i8, ptr [[PLEN]], i64 24
; CHECK-NEXT:    store i64 [[LENA1B]], ptr [[PLEN3]], align 4
; CHECK-NEXT:    ret void
;
  %pa0a = getelementptr [2 x %struct.A], ptr @a, i64 0, i64 0, i32 0, i64 %I
  %lena0a = call i64 @strlen(ptr %pa0a)
  store i64 %lena0a, ptr %plen

  %pa0b = getelementptr [2 x %struct.A], ptr @a, i64 0, i64 0, i32 1, i64 %I
  %lena0b = call i64 @strlen(ptr %pa0b)
  %plen1 = getelementptr i64, ptr %plen, i32 1
  store i64 %lena0b, ptr %plen1

  %pa1a = getelementptr [2 x %struct.A], ptr @a, i64 0, i64 1, i32 0, i64 %I
  %lena1a = call i64 @strlen(ptr %pa1a)
  %plen2 = getelementptr i64, ptr %plen, i32 2
  store i64 %lena1a, ptr %plen2

  %pa1b = getelementptr [2 x %struct.A], ptr @a, i64 0, i64 1, i32 1, i64 %I
  %lena1b = call i64 @strlen(ptr %pa1b)
  %plen3 = getelementptr i64, ptr %plen, i32 3
  store i64 %lena1b, ptr %plen3

  ret void
}
