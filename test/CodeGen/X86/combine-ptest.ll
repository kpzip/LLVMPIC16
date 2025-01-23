; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+sse4.1 | FileCheck %s --check-prefixes=SSE,SSE41
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+sse4.2 | FileCheck %s --check-prefixes=SSE,SSE42
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx    | FileCheck %s --check-prefixes=AVX
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx2   | FileCheck %s --check-prefixes=AVX

;
; testz(~X,Y) -> testc(X,Y)
;

define i32 @ptestz_128_invert0(<2 x i64> %c, <2 x i64> %d, i32 %a, i32 %b) {
; SSE-LABEL: ptestz_128_invert0:
; SSE:       # %bb.0:
; SSE-NEXT:    movl %edi, %eax
; SSE-NEXT:    ptest %xmm1, %xmm0
; SSE-NEXT:    cmovael %esi, %eax
; SSE-NEXT:    retq
;
; AVX-LABEL: ptestz_128_invert0:
; AVX:       # %bb.0:
; AVX-NEXT:    movl %edi, %eax
; AVX-NEXT:    vptest %xmm1, %xmm0
; AVX-NEXT:    cmovael %esi, %eax
; AVX-NEXT:    retq
  %t1 = xor <2 x i64> %c, <i64 -1, i64 -1>
  %t2 = call i32 @llvm.x86.sse41.ptestz(<2 x i64> %t1, <2 x i64> %d)
  %t3 = icmp ne i32 %t2, 0
  %t4 = select i1 %t3, i32 %a, i32 %b
  ret i32 %t4
}

;
; testz(X,~Y) -> testc(Y,X)
;

define i32 @ptestz_128_invert1(<2 x i64> %c, <2 x i64> %d, i32 %a, i32 %b) {
; SSE-LABEL: ptestz_128_invert1:
; SSE:       # %bb.0:
; SSE-NEXT:    movl %edi, %eax
; SSE-NEXT:    ptest %xmm0, %xmm1
; SSE-NEXT:    cmovael %esi, %eax
; SSE-NEXT:    retq
;
; AVX-LABEL: ptestz_128_invert1:
; AVX:       # %bb.0:
; AVX-NEXT:    movl %edi, %eax
; AVX-NEXT:    vptest %xmm0, %xmm1
; AVX-NEXT:    cmovael %esi, %eax
; AVX-NEXT:    retq
  %t1 = xor <2 x i64> %d, <i64 -1, i64 -1>
  %t2 = call i32 @llvm.x86.sse41.ptestz(<2 x i64> %c, <2 x i64> %t1)
  %t3 = icmp ne i32 %t2, 0
  %t4 = select i1 %t3, i32 %a, i32 %b
  ret i32 %t4
}

;
; testc(~X,Y) -> testz(X,Y)
;

define i32 @ptestc_128_invert0(<2 x i64> %c, <2 x i64> %d, i32 %a, i32 %b) {
; SSE-LABEL: ptestc_128_invert0:
; SSE:       # %bb.0:
; SSE-NEXT:    movl %edi, %eax
; SSE-NEXT:    ptest %xmm1, %xmm0
; SSE-NEXT:    cmovnel %esi, %eax
; SSE-NEXT:    retq
;
; AVX-LABEL: ptestc_128_invert0:
; AVX:       # %bb.0:
; AVX-NEXT:    movl %edi, %eax
; AVX-NEXT:    vptest %xmm1, %xmm0
; AVX-NEXT:    cmovnel %esi, %eax
; AVX-NEXT:    retq
  %t1 = xor <2 x i64> %c, <i64 -1, i64 -1>
  %t2 = call i32 @llvm.x86.sse41.ptestc(<2 x i64> %t1, <2 x i64> %d)
  %t3 = icmp ne i32 %t2, 0
  %t4 = select i1 %t3, i32 %a, i32 %b
  ret i32 %t4
}

;
; testnzc(~X,Y) -> testnzc(X,Y)
;

define i32 @ptestnzc_128_invert0(<2 x i64> %c, <2 x i64> %d, i32 %a, i32 %b) {
; SSE-LABEL: ptestnzc_128_invert0:
; SSE:       # %bb.0:
; SSE-NEXT:    movl %edi, %eax
; SSE-NEXT:    ptest %xmm1, %xmm0
; SSE-NEXT:    cmovnel %esi, %eax
; SSE-NEXT:    retq
;
; AVX-LABEL: ptestnzc_128_invert0:
; AVX:       # %bb.0:
; AVX-NEXT:    movl %edi, %eax
; AVX-NEXT:    vptest %xmm1, %xmm0
; AVX-NEXT:    cmovnel %esi, %eax
; AVX-NEXT:    retq
  %t1 = xor <2 x i64> %c, <i64 -1, i64 -1>
  %t2 = call i32 @llvm.x86.sse41.ptestc(<2 x i64> %t1, <2 x i64> %d)
  %t3 = icmp ne i32 %t2, 0
  %t4 = select i1 %t3, i32 %a, i32 %b
  ret i32 %t4
}

;
; testc(X,~X) -> testc(X,-1)
;

define i32 @ptestc_128_not(<2 x i64> %c, <2 x i64> %d, i32 %a, i32 %b) {
; SSE-LABEL: ptestc_128_not:
; SSE:       # %bb.0:
; SSE-NEXT:    movl %edi, %eax
; SSE-NEXT:    pcmpeqd %xmm1, %xmm1
; SSE-NEXT:    ptest %xmm1, %xmm0
; SSE-NEXT:    cmovael %esi, %eax
; SSE-NEXT:    retq
;
; AVX-LABEL: ptestc_128_not:
; AVX:       # %bb.0:
; AVX-NEXT:    movl %edi, %eax
; AVX-NEXT:    vpcmpeqd %xmm1, %xmm1, %xmm1
; AVX-NEXT:    vptest %xmm1, %xmm0
; AVX-NEXT:    cmovael %esi, %eax
; AVX-NEXT:    retq
  %t1 = xor <2 x i64> %c, <i64 -1, i64 -1>
  %t2 = call i32 @llvm.x86.sse41.ptestc(<2 x i64> %c, <2 x i64> %t1)
  %t3 = icmp ne i32 %t2, 0
  %t4 = select i1 %t3, i32 %a, i32 %b
  ret i32 %t4
}

;
; testz(AND(X,Y),AND(X,Y)) -> testz(X,Y)
;

define i32 @ptestz_128_and(<2 x i64> %c, <2 x i64> %d, i32 %a, i32 %b) {
; SSE-LABEL: ptestz_128_and:
; SSE:       # %bb.0:
; SSE-NEXT:    movl %edi, %eax
; SSE-NEXT:    ptest %xmm1, %xmm0
; SSE-NEXT:    cmovnel %esi, %eax
; SSE-NEXT:    retq
;
; AVX-LABEL: ptestz_128_and:
; AVX:       # %bb.0:
; AVX-NEXT:    movl %edi, %eax
; AVX-NEXT:    vptest %xmm1, %xmm0
; AVX-NEXT:    cmovnel %esi, %eax
; AVX-NEXT:    retq
  %t1 = and <2 x i64> %c, %d
  %t2 = call i32 @llvm.x86.sse41.ptestz(<2 x i64> %t1, <2 x i64> %t1)
  %t3 = icmp ne i32 %t2, 0
  %t4 = select i1 %t3, i32 %a, i32 %b
  ret i32 %t4
}

;
; testz(AND(~X,Y),AND(~X,Y)) -> testc(X,Y)
;

define i32 @ptestz_128_andc(<2 x i64> %c, <2 x i64> %d, i32 %a, i32 %b) {
; SSE-LABEL: ptestz_128_andc:
; SSE:       # %bb.0:
; SSE-NEXT:    movl %edi, %eax
; SSE-NEXT:    ptest %xmm1, %xmm0
; SSE-NEXT:    cmovael %esi, %eax
; SSE-NEXT:    retq
;
; AVX-LABEL: ptestz_128_andc:
; AVX:       # %bb.0:
; AVX-NEXT:    movl %edi, %eax
; AVX-NEXT:    vptest %xmm1, %xmm0
; AVX-NEXT:    cmovael %esi, %eax
; AVX-NEXT:    retq
  %t1 = xor <2 x i64> %c, <i64 -1, i64 -1>
  %t2 = and <2 x i64> %t1, %d
  %t3 = call i32 @llvm.x86.sse41.ptestz(<2 x i64> %t2, <2 x i64> %t2)
  %t4 = icmp ne i32 %t3, 0
  %t5 = select i1 %t4, i32 %a, i32 %b
  ret i32 %t5
}

;
; testz(-1,X) -> testz(X,X)
;

define i32 @ptestz_128_allones0(<2 x i64> %c, i32 %a, i32 %b) {
; SSE-LABEL: ptestz_128_allones0:
; SSE:       # %bb.0:
; SSE-NEXT:    movl %edi, %eax
; SSE-NEXT:    ptest %xmm0, %xmm0
; SSE-NEXT:    cmovnel %esi, %eax
; SSE-NEXT:    retq
;
; AVX-LABEL: ptestz_128_allones0:
; AVX:       # %bb.0:
; AVX-NEXT:    movl %edi, %eax
; AVX-NEXT:    vptest %xmm0, %xmm0
; AVX-NEXT:    cmovnel %esi, %eax
; AVX-NEXT:    retq
  %t1 = call i32 @llvm.x86.sse41.ptestz(<2 x i64> <i64 -1, i64 -1>, <2 x i64> %c)
  %t2 = icmp ne i32 %t1, 0
  %t3 = select i1 %t2, i32 %a, i32 %b
  ret i32 %t3
}

;
; testz(X,-1) -> testz(X,X)
;

define i32 @ptestz_128_allones1(<2 x i64> %c, i32 %a, i32 %b) {
; SSE-LABEL: ptestz_128_allones1:
; SSE:       # %bb.0:
; SSE-NEXT:    movl %edi, %eax
; SSE-NEXT:    ptest %xmm0, %xmm0
; SSE-NEXT:    cmovnel %esi, %eax
; SSE-NEXT:    retq
;
; AVX-LABEL: ptestz_128_allones1:
; AVX:       # %bb.0:
; AVX-NEXT:    movl %edi, %eax
; AVX-NEXT:    vptest %xmm0, %xmm0
; AVX-NEXT:    cmovnel %esi, %eax
; AVX-NEXT:    retq
  %t1 = call i32 @llvm.x86.sse41.ptestz(<2 x i64> %c, <2 x i64> <i64 -1, i64 -1>)
  %t2 = icmp ne i32 %t1, 0
  %t3 = select i1 %t2, i32 %a, i32 %b
  ret i32 %t3
}

define zeroext i1 @PR38522(ptr %x, ptr %y) {
; SSE-LABEL: PR38522:
; SSE:       # %bb.0: # %start
; SSE-NEXT:    movdqa (%rdi), %xmm0
; SSE-NEXT:    pcmpgtb (%rsi), %xmm0
; SSE-NEXT:    ptest %xmm0, %xmm0
; SSE-NEXT:    sete %al
; SSE-NEXT:    retq
;
; AVX-LABEL: PR38522:
; AVX:       # %bb.0: # %start
; AVX-NEXT:    vmovdqa (%rdi), %xmm0
; AVX-NEXT:    vpcmpgtb (%rsi), %xmm0, %xmm0
; AVX-NEXT:    vptest %xmm0, %xmm0
; AVX-NEXT:    sete %al
; AVX-NEXT:    retq
start:
  %0 = load <16 x i8>, ptr %x, align 16
  %1 = load <16 x i8>, ptr %y, align 16
  %2 = icmp sle <16 x i8> %0, %1
  %3 = sext <16 x i1> %2 to <16 x i8>
  %4 = bitcast <16 x i8> %3 to <2 x i64>
  %5 = tail call i32 @llvm.x86.sse41.ptestc(<2 x i64> %4, <2 x i64> <i64 -1, i64 -1>)
  %6 = icmp eq i32 %5, 1
  ret i1 %6
}

;
; testz(ashr(X,bw-1),-1) -> testpd/testps/movmskpd/movmskps/pmovmskb(X)
;

define i32 @ptestz_v2i64_signbits(<2 x i64> %c, i32 %a, i32 %b) {
; SSE41-LABEL: ptestz_v2i64_signbits:
; SSE41:       # %bb.0:
; SSE41-NEXT:    movl %edi, %eax
; SSE41-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[1,1,3,3]
; SSE41-NEXT:    movmskps %xmm0, %ecx
; SSE41-NEXT:    testl %ecx, %ecx
; SSE41-NEXT:    cmovnel %esi, %eax
; SSE41-NEXT:    retq
;
; SSE42-LABEL: ptestz_v2i64_signbits:
; SSE42:       # %bb.0:
; SSE42-NEXT:    movl %edi, %eax
; SSE42-NEXT:    movmskpd %xmm0, %ecx
; SSE42-NEXT:    testl %ecx, %ecx
; SSE42-NEXT:    cmovnel %esi, %eax
; SSE42-NEXT:    retq
;
; AVX-LABEL: ptestz_v2i64_signbits:
; AVX:       # %bb.0:
; AVX-NEXT:    movl %edi, %eax
; AVX-NEXT:    vtestpd %xmm0, %xmm0
; AVX-NEXT:    cmovnel %esi, %eax
; AVX-NEXT:    retq
  %t1 = ashr <2 x i64> %c, <i64 63, i64 63>
  %t2 = call i32 @llvm.x86.sse41.ptestz(<2 x i64> %t1, <2 x i64> <i64 -1, i64 -1>)
  %t3 = icmp ne i32 %t2, 0
  %t4 = select i1 %t3, i32 %a, i32 %b
  ret i32 %t4
}

define i32 @ptestz_v4i32_signbits(<4 x i32> %c, i32 %a, i32 %b) {
; SSE-LABEL: ptestz_v4i32_signbits:
; SSE:       # %bb.0:
; SSE-NEXT:    movl %edi, %eax
; SSE-NEXT:    movmskps %xmm0, %ecx
; SSE-NEXT:    testl %ecx, %ecx
; SSE-NEXT:    cmovnel %esi, %eax
; SSE-NEXT:    retq
;
; AVX-LABEL: ptestz_v4i32_signbits:
; AVX:       # %bb.0:
; AVX-NEXT:    movl %edi, %eax
; AVX-NEXT:    vtestps %xmm0, %xmm0
; AVX-NEXT:    cmovnel %esi, %eax
; AVX-NEXT:    retq
  %t1 = ashr <4 x i32> %c, <i32 31, i32 31, i32 31, i32 31>
  %t2 = bitcast <4 x i32> %t1 to <2 x i64>
  %t3 = call i32 @llvm.x86.sse41.ptestz(<2 x i64> %t2, <2 x i64> <i64 -1, i64 -1>)
  %t4 = icmp ne i32 %t3, 0
  %t5 = select i1 %t4, i32 %a, i32 %b
  ret i32 %t5
}

define i32 @ptestz_v8i16_signbits(<8 x i16> %c, i32 %a, i32 %b) {
; SSE-LABEL: ptestz_v8i16_signbits:
; SSE:       # %bb.0:
; SSE-NEXT:    movl %edi, %eax
; SSE-NEXT:    pmovmskb %xmm0, %ecx
; SSE-NEXT:    testl $43690, %ecx # imm = 0xAAAA
; SSE-NEXT:    cmovnel %esi, %eax
; SSE-NEXT:    retq
;
; AVX-LABEL: ptestz_v8i16_signbits:
; AVX:       # %bb.0:
; AVX-NEXT:    movl %edi, %eax
; AVX-NEXT:    vpmovmskb %xmm0, %ecx
; AVX-NEXT:    testl $43690, %ecx # imm = 0xAAAA
; AVX-NEXT:    cmovnel %esi, %eax
; AVX-NEXT:    retq
  %t1 = ashr <8 x i16> %c, <i16 15, i16 15, i16 15, i16 15, i16 15, i16 15, i16 15, i16 15>
  %t2 = bitcast <8 x i16> %t1 to <2 x i64>
  %t3 = call i32 @llvm.x86.sse41.ptestz(<2 x i64> %t2, <2 x i64> <i64 -1, i64 -1>)
  %t4 = icmp ne i32 %t3, 0
  %t5 = select i1 %t4, i32 %a, i32 %b
  ret i32 %t5
}

;
; testz(or(extract_lo(X),extract_hi(X),or(extract_lo(Y),extract_hi(Y)) -> testz(X,Y)
;

define i32 @ptestz_v2i64_concat(<4 x i64> %c, <4 x i64> %d, i32 %a, i32 %b) {
; SSE-LABEL: ptestz_v2i64_concat:
; SSE:       # %bb.0:
; SSE-NEXT:    movl %edi, %eax
; SSE-NEXT:    por %xmm1, %xmm0
; SSE-NEXT:    por %xmm3, %xmm2
; SSE-NEXT:    ptest %xmm2, %xmm0
; SSE-NEXT:    cmovnel %esi, %eax
; SSE-NEXT:    retq
;
; AVX-LABEL: ptestz_v2i64_concat:
; AVX:       # %bb.0:
; AVX-NEXT:    movl %edi, %eax
; AVX-NEXT:    vptest %ymm1, %ymm0
; AVX-NEXT:    cmovnel %esi, %eax
; AVX-NEXT:    vzeroupper
; AVX-NEXT:    retq
  %t1 = shufflevector <4 x i64> %c, <4 x i64> undef, <2 x i32> <i32 0, i32 1>
  %t2 = shufflevector <4 x i64> %c, <4 x i64> undef, <2 x i32> <i32 2, i32 3>
  %t3 = shufflevector <4 x i64> %d, <4 x i64> undef, <2 x i32> <i32 0, i32 1>
  %t4 = shufflevector <4 x i64> %d, <4 x i64> undef, <2 x i32> <i32 2, i32 3>
  %t5 = or <2 x i64> %t1, %t2
  %t6 = or <2 x i64> %t4, %t3
  %t7 = call i32 @llvm.x86.sse41.ptestz(<2 x i64> %t5, <2 x i64> %t6)
  %t8 = icmp ne i32 %t7, 0
  %t9 = select i1 %t8, i32 %a, i32 %b
  ret i32 %t9
}

; FIXME: Foldable to ptest(xor(%0,%1),xor(%0,%1))
define i1 @PR38788(<4 x i32> %0, <4 x i32> %1) {
; SSE-LABEL: PR38788:
; SSE:       # %bb.0:
; SSE-NEXT:    pcmpeqd %xmm1, %xmm0
; SSE-NEXT:    pcmpeqd %xmm1, %xmm1
; SSE-NEXT:    ptest %xmm1, %xmm0
; SSE-NEXT:    setb %al
; SSE-NEXT:    retq
;
; AVX-LABEL: PR38788:
; AVX:       # %bb.0:
; AVX-NEXT:    vpcmpeqd %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpcmpeqd %xmm1, %xmm1, %xmm1
; AVX-NEXT:    vptest %xmm1, %xmm0
; AVX-NEXT:    setb %al
; AVX-NEXT:    retq
  %3 = icmp eq <4 x i32> %0, %1
  %4 = sext <4 x i1> %3 to <4 x i32>
  %5 = bitcast <4 x i32> %4 to <2 x i64>
  %6 = tail call i32 @llvm.x86.sse41.ptestc(<2 x i64> %5, <2 x i64> <i64 -1, i64 -1>)
  %7 = icmp eq i32 %6, 1
  ret i1 %7
}

define i32 @PR88958_1(ptr %0, <2 x i64> %1) {
; SSE-LABEL: PR88958_1:
; SSE:       # %bb.0:
; SSE-NEXT:    xorl %eax, %eax
; SSE-NEXT:    ptest (%rdi), %xmm0
; SSE-NEXT:    sete %al
; SSE-NEXT:    retq
;
; AVX-LABEL: PR88958_1:
; AVX:       # %bb.0:
; AVX-NEXT:    xorl %eax, %eax
; AVX-NEXT:    vptest (%rdi), %xmm0
; AVX-NEXT:    sete %al
; AVX-NEXT:    retq
  %3 = load <2 x i64>, ptr %0
  %4 = tail call i32 @llvm.x86.sse41.ptestz(<2 x i64> %3, <2 x i64> %1)
  ret i32 %4
}

define i32 @PR88958_2(ptr %0, <2 x i64> %1) {
; SSE-LABEL: PR88958_2:
; SSE:       # %bb.0:
; SSE-NEXT:    movdqa (%rdi), %xmm1
; SSE-NEXT:    xorl %eax, %eax
; SSE-NEXT:    ptest %xmm0, %xmm1
; SSE-NEXT:    setb %al
; SSE-NEXT:    retq
;
; AVX-LABEL: PR88958_2:
; AVX:       # %bb.0:
; AVX-NEXT:    vmovdqa (%rdi), %xmm1
; AVX-NEXT:    xorl %eax, %eax
; AVX-NEXT:    vptest %xmm0, %xmm1
; AVX-NEXT:    setb %al
; AVX-NEXT:    retq
  %3 = load <2 x i64>, ptr %0
  %4 = tail call i32 @llvm.x86.sse41.ptestc(<2 x i64> %3, <2 x i64> %1)
  ret i32 %4
}

declare i32 @llvm.x86.sse41.ptestz(<2 x i64>, <2 x i64>) nounwind readnone
declare i32 @llvm.x86.sse41.ptestc(<2 x i64>, <2 x i64>) nounwind readnone
declare i32 @llvm.x86.sse41.ptestnzc(<2 x i64>, <2 x i64>) nounwind readnone
