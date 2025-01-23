; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-linux-gnu | FileCheck %s --check-prefix=X86
; RUN: llc < %s -mtriple=x86_64-linux-gnu -mattr=+avx2 | FileCheck %s --check-prefixes=X64
; RUN: llc < %s -mtriple=x86_64-linux-gnu -mattr=+avx512bf16,+avx512vl | FileCheck %s --check-prefixes=X64

@a = global bfloat 0xR0000, align 2
@b = global bfloat 0xR0000, align 2
@c = global bfloat 0xR0000, align 2

define float @bfloat_to_float() strictfp {
; X86-LABEL: bfloat_to_float:
; X86:       # %bb.0:
; X86-NEXT:    subl $12, %esp
; X86-NEXT:    .cfi_def_cfa_offset 16
; X86-NEXT:    movzwl a, %eax
; X86-NEXT:    movl %eax, (%esp)
; X86-NEXT:    calll __extendbfsf2
; X86-NEXT:    addl $12, %esp
; X86-NEXT:    .cfi_def_cfa_offset 4
; X86-NEXT:    retl
;
; X64-LABEL: bfloat_to_float:
; X64:       # %bb.0:
; X64-NEXT:    pushq %rax
; X64-NEXT:    .cfi_def_cfa_offset 16
; X64-NEXT:    movq a@GOTPCREL(%rip), %rax
; X64-NEXT:    movzwl (%rax), %edi
; X64-NEXT:    callq __extendbfsf2@PLT
; X64-NEXT:    popq %rax
; X64-NEXT:    .cfi_def_cfa_offset 8
; X64-NEXT:    retq
  %1 = load bfloat, ptr @a, align 2
  %2 = tail call float @llvm.experimental.constrained.fpext.f32.bfloat(bfloat %1, metadata !"fpexcept.strict") #0
  ret float %2
}

define double @bfloat_to_double() strictfp {
; X86-LABEL: bfloat_to_double:
; X86:       # %bb.0:
; X86-NEXT:    subl $12, %esp
; X86-NEXT:    .cfi_def_cfa_offset 16
; X86-NEXT:    movzwl a, %eax
; X86-NEXT:    movl %eax, (%esp)
; X86-NEXT:    calll __extendbfsf2
; X86-NEXT:    addl $12, %esp
; X86-NEXT:    .cfi_def_cfa_offset 4
; X86-NEXT:    retl
;
; X64-LABEL: bfloat_to_double:
; X64:       # %bb.0:
; X64-NEXT:    pushq %rax
; X64-NEXT:    .cfi_def_cfa_offset 16
; X64-NEXT:    movq a@GOTPCREL(%rip), %rax
; X64-NEXT:    movzwl (%rax), %edi
; X64-NEXT:    callq __extendbfsf2@PLT
; X64-NEXT:    vcvtss2sd %xmm0, %xmm0, %xmm0
; X64-NEXT:    popq %rax
; X64-NEXT:    .cfi_def_cfa_offset 8
; X64-NEXT:    retq
  %1 = load bfloat, ptr @a, align 2
  %2 = tail call double @llvm.experimental.constrained.fpext.f64.bfloat(bfloat %1, metadata !"fpexcept.strict") #0
  ret double %2
}

define void @float_to_bfloat(float %0) strictfp {
; X86-LABEL: float_to_bfloat:
; X86:       # %bb.0:
; X86-NEXT:    subl $12, %esp
; X86-NEXT:    .cfi_def_cfa_offset 16
; X86-NEXT:    flds {{[0-9]+}}(%esp)
; X86-NEXT:    fstps (%esp)
; X86-NEXT:    wait
; X86-NEXT:    calll __truncsfbf2
; X86-NEXT:    movw %ax, a
; X86-NEXT:    addl $12, %esp
; X86-NEXT:    .cfi_def_cfa_offset 4
; X86-NEXT:    retl
;
; X64-LABEL: float_to_bfloat:
; X64:       # %bb.0:
; X64-NEXT:    pushq %rax
; X64-NEXT:    .cfi_def_cfa_offset 16
; X64-NEXT:    callq __truncsfbf2@PLT
; X64-NEXT:    movq a@GOTPCREL(%rip), %rcx
; X64-NEXT:    movw %ax, (%rcx)
; X64-NEXT:    popq %rax
; X64-NEXT:    .cfi_def_cfa_offset 8
; X64-NEXT:    retq
  %2 = tail call bfloat @llvm.experimental.constrained.fptrunc.bfloat.f32(float %0, metadata !"round.tonearest", metadata !"fpexcept.strict") #0
  store bfloat %2, ptr @a, align 2
  ret void
}

define void @double_to_bfloat(double %0) strictfp {
; X86-LABEL: double_to_bfloat:
; X86:       # %bb.0:
; X86-NEXT:    subl $12, %esp
; X86-NEXT:    .cfi_def_cfa_offset 16
; X86-NEXT:    fldl {{[0-9]+}}(%esp)
; X86-NEXT:    fstpl (%esp)
; X86-NEXT:    wait
; X86-NEXT:    calll __truncdfbf2
; X86-NEXT:    movw %ax, a
; X86-NEXT:    addl $12, %esp
; X86-NEXT:    .cfi_def_cfa_offset 4
; X86-NEXT:    retl
;
; X64-LABEL: double_to_bfloat:
; X64:       # %bb.0:
; X64-NEXT:    pushq %rax
; X64-NEXT:    .cfi_def_cfa_offset 16
; X64-NEXT:    callq __truncdfbf2@PLT
; X64-NEXT:    movq a@GOTPCREL(%rip), %rcx
; X64-NEXT:    movw %ax, (%rcx)
; X64-NEXT:    popq %rax
; X64-NEXT:    .cfi_def_cfa_offset 8
; X64-NEXT:    retq
  %2 = tail call bfloat @llvm.experimental.constrained.fptrunc.bfloat.f64(double %0, metadata !"round.tonearest", metadata !"fpexcept.strict") #0
  store bfloat %2, ptr @a, align 2
  ret void
}

define void @add() strictfp {
; X86-LABEL: add:
; X86:       # %bb.0:
; X86-NEXT:    subl $12, %esp
; X86-NEXT:    .cfi_def_cfa_offset 16
; X86-NEXT:    movzwl a, %eax
; X86-NEXT:    movl %eax, (%esp)
; X86-NEXT:    calll __extendbfsf2
; X86-NEXT:    fstps {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Folded Spill
; X86-NEXT:    wait
; X86-NEXT:    movzwl b, %eax
; X86-NEXT:    movl %eax, (%esp)
; X86-NEXT:    calll __extendbfsf2
; X86-NEXT:    flds {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Folded Reload
; X86-NEXT:    faddp %st, %st(1)
; X86-NEXT:    fstps (%esp)
; X86-NEXT:    wait
; X86-NEXT:    calll __truncsfbf2
; X86-NEXT:    movw %ax, c
; X86-NEXT:    addl $12, %esp
; X86-NEXT:    .cfi_def_cfa_offset 4
; X86-NEXT:    retl
;
; X64-LABEL: add:
; X64:       # %bb.0:
; X64-NEXT:    pushq %rax
; X64-NEXT:    .cfi_def_cfa_offset 16
; X64-NEXT:    movq a@GOTPCREL(%rip), %rax
; X64-NEXT:    movzwl (%rax), %edi
; X64-NEXT:    callq __extendbfsf2@PLT
; X64-NEXT:    vmovss %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 4-byte Spill
; X64-NEXT:    movq b@GOTPCREL(%rip), %rax
; X64-NEXT:    movzwl (%rax), %edi
; X64-NEXT:    callq __extendbfsf2@PLT
; X64-NEXT:    vaddss {{[-0-9]+}}(%r{{[sb]}}p), %xmm0, %xmm0 # 4-byte Folded Reload
; X64-NEXT:    callq __truncsfbf2@PLT
; X64-NEXT:    movq c@GOTPCREL(%rip), %rcx
; X64-NEXT:    movw %ax, (%rcx)
; X64-NEXT:    popq %rax
; X64-NEXT:    .cfi_def_cfa_offset 8
; X64-NEXT:    retq
  %1 = load bfloat, ptr @a, align 2
  %2 = tail call float @llvm.experimental.constrained.fpext.f32.bfloat(bfloat %1, metadata !"fpexcept.strict") #0
  %3 = load bfloat, ptr @b, align 2
  %4 = tail call float @llvm.experimental.constrained.fpext.f32.bfloat(bfloat %3, metadata !"fpexcept.strict") #0
  %5 = tail call float @llvm.experimental.constrained.fadd.f32(float %2, float %4, metadata !"round.tonearest", metadata !"fpexcept.strict") #0
  %6 = tail call bfloat @llvm.experimental.constrained.fptrunc.bfloat.f32(float %5, metadata !"round.tonearest", metadata !"fpexcept.strict") #0
  store bfloat %6, ptr @c, align 2
  ret void
}

declare float @llvm.experimental.constrained.fpext.f32.bfloat(bfloat, metadata)
declare double @llvm.experimental.constrained.fpext.f64.bfloat(bfloat, metadata)
declare float @llvm.experimental.constrained.fadd.f32(float, float, metadata, metadata)
declare bfloat @llvm.experimental.constrained.fptrunc.bfloat.f32(float, metadata, metadata)
declare bfloat @llvm.experimental.constrained.fptrunc.bfloat.f64(double, metadata, metadata)

attributes #0 = { strictfp }

