; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mcpu=sapphirerapids -verify-machineinstrs | FileCheck %s

define <8 x i64> @foo_reg_512(<8 x i64> %0, <8 x i64> %1, <8 x i64> %2, <8 x i64> %3, <8 x i64> %4, <8 x i64> %5) {
; CHECK-LABEL: foo_reg_512:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vpdpwssd %zmm2, %zmm1, %zmm0
; CHECK-NEXT:    vpmaddwd %zmm3, %zmm1, %zmm2
; CHECK-NEXT:    vpaddd %zmm2, %zmm0, %zmm0
; CHECK-NEXT:    vpmaddwd %zmm4, %zmm1, %zmm2
; CHECK-NEXT:    vpaddd %zmm2, %zmm0, %zmm0
; CHECK-NEXT:    vpmaddwd %zmm5, %zmm1, %zmm1
; CHECK-NEXT:    vpaddd %zmm1, %zmm0, %zmm0
; CHECK-NEXT:    retq
  %7 = bitcast <8 x i64> %0 to <16 x i32>
  %8 = bitcast <8 x i64> %1 to <16 x i32>
  %9 = bitcast <8 x i64> %2 to <16 x i32>
  %10 = tail call <16 x i32> @llvm.x86.avx512.vpdpwssd.512(<16 x i32> %7, <16 x i32> %8, <16 x i32> %9)
  %11 = bitcast <8 x i64> %3 to <16 x i32>
  %12 = tail call <16 x i32> @llvm.x86.avx512.vpdpwssd.512(<16 x i32> %10, <16 x i32> %8, <16 x i32> %11)
  %13 = bitcast <8 x i64> %4 to <16 x i32>
  %14 = tail call <16 x i32> @llvm.x86.avx512.vpdpwssd.512(<16 x i32> %12, <16 x i32> %8, <16 x i32> %13)
  %15 = bitcast <8 x i64> %5 to <16 x i32>
  %16 = tail call <16 x i32> @llvm.x86.avx512.vpdpwssd.512(<16 x i32> %14, <16 x i32> %8, <16 x i32> %15)
  %17 = bitcast <16 x i32> %16 to <8 x i64>
  ret <8 x i64> %17
}

; __m512i foo(int cnt, __m512i c, __m512i b, __m512i *p) {
;
;     for (int i = 0; i < cnt; ++i) {
;         __m512i a = p[i];
;         __m512i m = _mm512_madd_epi16(b, a);
;         c = _mm512_add_epi32(m, c);
;     }
;
;     return c;
; }
define <8 x i64> @foo_512(i32 %0, <8 x i64> %1, <8 x i64> %2, ptr %3) {
; CHECK-LABEL: foo_512:
; CHECK:       # %bb.0:
; CHECK-NEXT:    testl %edi, %edi
; CHECK-NEXT:    jle .LBB1_6
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    movl %edi, %edx
; CHECK-NEXT:    movl %edx, %eax
; CHECK-NEXT:    andl $3, %eax
; CHECK-NEXT:    cmpl $4, %edi
; CHECK-NEXT:    jae .LBB1_7
; CHECK-NEXT:  # %bb.2:
; CHECK-NEXT:    xorl %ecx, %ecx
; CHECK-NEXT:    jmp .LBB1_3
; CHECK-NEXT:  .LBB1_7:
; CHECK-NEXT:    andl $-4, %edx
; CHECK-NEXT:    leaq 192(%rsi), %rdi
; CHECK-NEXT:    xorl %ecx, %ecx
; CHECK-NEXT:    .p2align 4, 0x90
; CHECK-NEXT:  .LBB1_8: # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    vpdpwssd -192(%rdi), %zmm1, %zmm0
; CHECK-NEXT:    vpmaddwd -128(%rdi), %zmm1, %zmm2
; CHECK-NEXT:    vpaddd %zmm2, %zmm0, %zmm0
; CHECK-NEXT:    vpmaddwd -64(%rdi), %zmm1, %zmm2
; CHECK-NEXT:    vpaddd %zmm2, %zmm0, %zmm0
; CHECK-NEXT:    vpmaddwd (%rdi), %zmm1, %zmm2
; CHECK-NEXT:    vpaddd %zmm2, %zmm0, %zmm0
; CHECK-NEXT:    addq $4, %rcx
; CHECK-NEXT:    addq $256, %rdi # imm = 0x100
; CHECK-NEXT:    cmpq %rcx, %rdx
; CHECK-NEXT:    jne .LBB1_8
; CHECK-NEXT:  .LBB1_3:
; CHECK-NEXT:    testq %rax, %rax
; CHECK-NEXT:    je .LBB1_6
; CHECK-NEXT:  # %bb.4: # %.preheader
; CHECK-NEXT:    shlq $6, %rcx
; CHECK-NEXT:    addq %rcx, %rsi
; CHECK-NEXT:    shll $6, %eax
; CHECK-NEXT:    xorl %ecx, %ecx
; CHECK-NEXT:    .p2align 4, 0x90
; CHECK-NEXT:  .LBB1_5: # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    vpdpwssd (%rsi,%rcx), %zmm1, %zmm0
; CHECK-NEXT:    addq $64, %rcx
; CHECK-NEXT:    cmpq %rcx, %rax
; CHECK-NEXT:    jne .LBB1_5
; CHECK-NEXT:  .LBB1_6:
; CHECK-NEXT:    retq
  %5 = icmp sgt i32 %0, 0
  br i1 %5, label %6, label %33

6:                                                ; preds = %4
  %7 = bitcast <8 x i64> %2 to <32 x i16>
  %8 = bitcast <8 x i64> %1 to <16 x i32>
  %9 = zext i32 %0 to i64
  %10 = and i64 %9, 3
  %11 = icmp ult i32 %0, 4
  br i1 %11, label %14, label %12

12:                                               ; preds = %6
  %13 = and i64 %9, 4294967292
  br label %35

14:                                               ; preds = %35, %6
  %15 = phi <16 x i32> [ undef, %6 ], [ %57, %35 ]
  %16 = phi i64 [ 0, %6 ], [ %58, %35 ]
  %17 = phi <16 x i32> [ %8, %6 ], [ %57, %35 ]
  %18 = icmp eq i64 %10, 0
  br i1 %18, label %30, label %19

19:                                               ; preds = %14, %19
  %20 = phi i64 [ %27, %19 ], [ %16, %14 ]
  %21 = phi <16 x i32> [ %26, %19 ], [ %17, %14 ]
  %22 = phi i64 [ %28, %19 ], [ 0, %14 ]
  %23 = getelementptr inbounds <8 x i64>, ptr %3, i64 %20
  %24 = load <32 x i16>, ptr %23, align 64
  %25 = tail call <16 x i32> @llvm.x86.avx512.pmaddw.d.512(<32 x i16> %7, <32 x i16> %24)
  %26 = add <16 x i32> %25, %21
  %27 = add nuw nsw i64 %20, 1
  %28 = add i64 %22, 1
  %29 = icmp eq i64 %28, %10
  br i1 %29, label %30, label %19

30:                                               ; preds = %19, %14
  %31 = phi <16 x i32> [ %15, %14 ], [ %26, %19 ]
  %32 = bitcast <16 x i32> %31 to <8 x i64>
  br label %33

33:                                               ; preds = %30, %4
  %34 = phi <8 x i64> [ %32, %30 ], [ %1, %4 ]
  ret <8 x i64> %34

35:                                               ; preds = %35, %12
  %36 = phi i64 [ 0, %12 ], [ %58, %35 ]
  %37 = phi <16 x i32> [ %8, %12 ], [ %57, %35 ]
  %38 = phi i64 [ 0, %12 ], [ %59, %35 ]
  %39 = getelementptr inbounds <8 x i64>, ptr %3, i64 %36
  %40 = load <32 x i16>, ptr %39, align 64
  %41 = tail call <16 x i32> @llvm.x86.avx512.pmaddw.d.512(<32 x i16> %7, <32 x i16> %40)
  %42 = add <16 x i32> %41, %37
  %43 = or disjoint i64 %36, 1
  %44 = getelementptr inbounds <8 x i64>, ptr %3, i64 %43
  %45 = load <32 x i16>, ptr %44, align 64
  %46 = tail call <16 x i32> @llvm.x86.avx512.pmaddw.d.512(<32 x i16> %7, <32 x i16> %45)
  %47 = add <16 x i32> %46, %42
  %48 = or disjoint i64 %36, 2
  %49 = getelementptr inbounds <8 x i64>, ptr %3, i64 %48
  %50 = load <32 x i16>, ptr %49, align 64
  %51 = tail call <16 x i32> @llvm.x86.avx512.pmaddw.d.512(<32 x i16> %7, <32 x i16> %50)
  %52 = add <16 x i32> %51, %47
  %53 = or disjoint i64 %36, 3
  %54 = getelementptr inbounds <8 x i64>, ptr %3, i64 %53
  %55 = load <32 x i16>, ptr %54, align 64
  %56 = tail call <16 x i32> @llvm.x86.avx512.pmaddw.d.512(<32 x i16> %7, <32 x i16> %55)
  %57 = add <16 x i32> %56, %52
  %58 = add nuw nsw i64 %36, 4
  %59 = add i64 %38, 4
  %60 = icmp eq i64 %59, %13
  br i1 %60, label %14, label %35
}

; void bar(int cnt, __m512i *c, __m512i b, __m512i *p) {
;     for (int i = 0; i < cnt; ++i) {
;         __m512i a = p[i];
;         c[i] = _mm512_dpwssd_epi32(c[i], b, a);
;     }
; }
define void @bar_512(i32 %0, ptr %1, <8 x i64> %2, ptr %3) {
; CHECK-LABEL: bar_512:
; CHECK:       # %bb.0:
; CHECK-NEXT:    testl %edi, %edi
; CHECK-NEXT:    jle .LBB2_5
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    movl %edi, %eax
; CHECK-NEXT:    cmpl $1, %edi
; CHECK-NEXT:    jne .LBB2_6
; CHECK-NEXT:  # %bb.2:
; CHECK-NEXT:    xorl %ecx, %ecx
; CHECK-NEXT:    jmp .LBB2_3
; CHECK-NEXT:  .LBB2_6:
; CHECK-NEXT:    movl %eax, %edi
; CHECK-NEXT:    andl $-2, %edi
; CHECK-NEXT:    movl $64, %r8d
; CHECK-NEXT:    xorl %ecx, %ecx
; CHECK-NEXT:    .p2align 4, 0x90
; CHECK-NEXT:  .LBB2_7: # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    vmovdqa64 (%rsi,%r8), %zmm1
; CHECK-NEXT:    vpmaddwd -64(%rdx,%r8), %zmm0, %zmm2
; CHECK-NEXT:    vpaddd -64(%rsi,%r8), %zmm2, %zmm2
; CHECK-NEXT:    vmovdqa64 %zmm2, -64(%rsi,%r8)
; CHECK-NEXT:    vpmaddwd (%rdx,%r8), %zmm0, %zmm2
; CHECK-NEXT:    vpaddd %zmm2, %zmm1, %zmm1
; CHECK-NEXT:    vmovdqa64 %zmm1, (%rsi,%r8)
; CHECK-NEXT:    addq $2, %rcx
; CHECK-NEXT:    subq $-128, %r8
; CHECK-NEXT:    cmpq %rcx, %rdi
; CHECK-NEXT:    jne .LBB2_7
; CHECK-NEXT:  .LBB2_3:
; CHECK-NEXT:    testb $1, %al
; CHECK-NEXT:    je .LBB2_5
; CHECK-NEXT:  # %bb.4:
; CHECK-NEXT:    shlq $6, %rcx
; CHECK-NEXT:    vpmaddwd (%rdx,%rcx), %zmm0, %zmm0
; CHECK-NEXT:    vpaddd (%rsi,%rcx), %zmm0, %zmm0
; CHECK-NEXT:    vmovdqa64 %zmm0, (%rsi,%rcx)
; CHECK-NEXT:  .LBB2_5:
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    retq
  %5 = icmp sgt i32 %0, 0
  br i1 %5, label %6, label %22

6:                                                ; preds = %4
  %7 = bitcast <8 x i64> %2 to <16 x i32>
  %8 = zext i32 %0 to i64
  %9 = and i64 %8, 1
  %10 = icmp eq i32 %0, 1
  br i1 %10, label %13, label %11

11:                                               ; preds = %6
  %12 = and i64 %8, 4294967294
  br label %23

13:                                               ; preds = %23, %6
  %14 = phi i64 [ 0, %6 ], [ %37, %23 ]
  %15 = icmp eq i64 %9, 0
  br i1 %15, label %22, label %16

16:                                               ; preds = %13
  %17 = getelementptr inbounds <8 x i64>, ptr %3, i64 %14
  %18 = load <16 x i32>, ptr %17, align 64
  %19 = getelementptr inbounds <8 x i64>, ptr %1, i64 %14
  %20 = load <16 x i32>, ptr %19, align 64
  %21 = tail call <16 x i32> @llvm.x86.avx512.vpdpwssd.512(<16 x i32> %20, <16 x i32> %7, <16 x i32> %18)
  store <16 x i32> %21, ptr %19, align 64
  br label %22

22:                                               ; preds = %16, %13, %4
  ret void

23:                                               ; preds = %23, %11
  %24 = phi i64 [ 0, %11 ], [ %37, %23 ]
  %25 = phi i64 [ 0, %11 ], [ %38, %23 ]
  %26 = getelementptr inbounds <8 x i64>, ptr %3, i64 %24
  %27 = load <16 x i32>, ptr %26, align 64
  %28 = getelementptr inbounds <8 x i64>, ptr %1, i64 %24
  %29 = load <16 x i32>, ptr %28, align 64
  %30 = tail call <16 x i32> @llvm.x86.avx512.vpdpwssd.512(<16 x i32> %29, <16 x i32> %7, <16 x i32> %27)
  store <16 x i32> %30, ptr %28, align 64
  %31 = or disjoint i64 %24, 1
  %32 = getelementptr inbounds <8 x i64>, ptr %3, i64 %31
  %33 = load <16 x i32>, ptr %32, align 64
  %34 = getelementptr inbounds <8 x i64>, ptr %1, i64 %31
  %35 = load <16 x i32>, ptr %34, align 64
  %36 = tail call <16 x i32> @llvm.x86.avx512.vpdpwssd.512(<16 x i32> %35, <16 x i32> %7, <16 x i32> %33)
  store <16 x i32> %36, ptr %34, align 64
  %37 = add nuw nsw i64 %24, 2
  %38 = add i64 %25, 2
  %39 = icmp eq i64 %38, %12
  br i1 %39, label %13, label %23
}

declare <16 x i32> @llvm.x86.avx512.vpdpwssd.512(<16 x i32>, <16 x i32>, <16 x i32>) #3
declare <16 x i32> @llvm.x86.avx512.pmaddw.d.512(<32 x i16>, <32 x i16>) #3
