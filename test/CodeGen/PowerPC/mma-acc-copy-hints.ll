; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -mtriple=powerpc64le-unknown-linux-gnu \
; RUN:   -mcpu=pwr10 -ppc-asm-full-reg-names \
; RUN:   -ppc-vsr-nums-as-vr < %s | FileCheck %s
; RUN: llc -verify-machineinstrs -mtriple=powerpc64-unknown-linux-gnu \
; RUN:   -mcpu=pwr10 -ppc-asm-full-reg-names \
; RUN:   -ppc-vsr-nums-as-vr < %s | FileCheck %s --check-prefix=CHECK-BE

define void @testMultiply(ptr nocapture noundef readonly %a, ptr nocapture noundef readonly %b, ptr nocapture noundef writeonly %c) local_unnamed_addr #0 {
; CHECK-LABEL: testMultiply:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    mflr r0
; CHECK-NEXT:    std r30, -16(r1)
; CHECK-NEXT:    mr r30, r1
; CHECK-NEXT:    std r0, 16(r1)
; CHECK-NEXT:    clrldi r0, r1, 59
; CHECK-NEXT:    subfic r0, r0, -128
; CHECK-NEXT:    stdux r1, r1, r0
; CHECK-NEXT:    stxv v30, -64(r30) # 16-byte Folded Spill
; CHECK-NEXT:    stxv v31, -48(r30) # 16-byte Folded Spill
; CHECK-NEXT:    lxv v31, 0(r3)
; CHECK-NEXT:    lxv v30, 0(r4)
; CHECK-NEXT:    addi r3, r1, 32
; CHECK-NEXT:    vmr v2, v31
; CHECK-NEXT:    vmr v3, v30
; CHECK-NEXT:    std r29, -24(r30) # 8-byte Folded Spill
; CHECK-NEXT:    mr r29, r5
; CHECK-NEXT:    bl _Z15buildVectorPairPu13__vector_pairDv16_hS0_@notoc
; CHECK-NEXT:    xxsetaccz acc0
; CHECK-NEXT:    xvf32gerpp acc0, v31, v30
; CHECK-NEXT:    lxv v3, 32(r1)
; CHECK-NEXT:    lxv v2, 48(r1)
; CHECK-NEXT:    xvf32gerpp acc0, v3, v2
; CHECK-NEXT:    lxv v31, -48(r30) # 16-byte Folded Reload
; CHECK-NEXT:    lxv v30, -64(r30) # 16-byte Folded Reload
; CHECK-NEXT:    xxmfacc acc0
; CHECK-NEXT:    stxv vs3, 0(r29)
; CHECK-NEXT:    pstxv vs2, 8(r29), 0
; CHECK-NEXT:    stxv vs1, 16(r29)
; CHECK-NEXT:    pstxv vs0, 24(r29), 0
; CHECK-NEXT:    ld r29, -24(r30) # 8-byte Folded Reload
; CHECK-NEXT:    mr r1, r30
; CHECK-NEXT:    ld r0, 16(r1)
; CHECK-NEXT:    ld r30, -16(r1)
; CHECK-NEXT:    mtlr r0
; CHECK-NEXT:    blr
;
; CHECK-BE-LABEL: testMultiply:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    mflr r0
; CHECK-BE-NEXT:    std r30, -16(r1)
; CHECK-BE-NEXT:    mr r30, r1
; CHECK-BE-NEXT:    std r0, 16(r1)
; CHECK-BE-NEXT:    clrldi r0, r1, 59
; CHECK-BE-NEXT:    subfic r0, r0, -224
; CHECK-BE-NEXT:    stdux r1, r1, r0
; CHECK-BE-NEXT:    stxv v30, -64(r30) # 16-byte Folded Spill
; CHECK-BE-NEXT:    stxv v31, -48(r30) # 16-byte Folded Spill
; CHECK-BE-NEXT:    lxv v31, 0(r3)
; CHECK-BE-NEXT:    lxv v30, 0(r4)
; CHECK-BE-NEXT:    addi r3, r1, 128
; CHECK-BE-NEXT:    vmr v2, v31
; CHECK-BE-NEXT:    vmr v3, v30
; CHECK-BE-NEXT:    std r29, -24(r30) # 8-byte Folded Spill
; CHECK-BE-NEXT:    mr r29, r5
; CHECK-BE-NEXT:    bl _Z15buildVectorPairPu13__vector_pairDv16_hS0_
; CHECK-BE-NEXT:    nop
; CHECK-BE-NEXT:    xxsetaccz acc1
; CHECK-BE-NEXT:    xvf32gerpp acc1, v31, v30
; CHECK-BE-NEXT:    lxv v3, 144(r1)
; CHECK-BE-NEXT:    lxv v2, 128(r1)
; CHECK-BE-NEXT:    xvf32gerpp acc1, v2, v3
; CHECK-BE-NEXT:    lxv v31, -48(r30) # 16-byte Folded Reload
; CHECK-BE-NEXT:    lxv v30, -64(r30) # 16-byte Folded Reload
; CHECK-BE-NEXT:    xxmfacc acc1
; CHECK-BE-NEXT:    xxlor vs1, vs6, vs6
; CHECK-BE-NEXT:    xxlor vs0, vs7, vs7
; CHECK-BE-NEXT:    xxlor vs3, vs4, vs4
; CHECK-BE-NEXT:    xxlor vs2, vs5, vs5
; CHECK-BE-NEXT:    stxv vs0, 0(r29)
; CHECK-BE-NEXT:    pstxv vs1, 8(r29), 0
; CHECK-BE-NEXT:    stxv vs2, 16(r29)
; CHECK-BE-NEXT:    pstxv vs3, 24(r29), 0
; CHECK-BE-NEXT:    ld r29, -24(r30) # 8-byte Folded Reload
; CHECK-BE-NEXT:    mr r1, r30
; CHECK-BE-NEXT:    ld r0, 16(r1)
; CHECK-BE-NEXT:    ld r30, -16(r1)
; CHECK-BE-NEXT:    mtlr r0
; CHECK-BE-NEXT:    blr
entry:
  %vP = alloca <256 x i1>, align 32
  call void @llvm.lifetime.start.p0(i64 32, ptr nonnull %vP)
  %0 = tail call <512 x i1> @llvm.ppc.mma.xxsetaccz()
  %1 = load <16 x i8>, ptr %a, align 16
  %2 = load <16 x i8>, ptr %b, align 16
  call void @_Z15buildVectorPairPu13__vector_pairDv16_hS0_(ptr noundef nonnull %vP, <16 x i8> noundef %1, <16 x i8> noundef %2)
  %3 = call <512 x i1> @llvm.ppc.mma.xvf32gerpp(<512 x i1> %0, <16 x i8> %1, <16 x i8> %2)
  %4 = load <256 x i1>, ptr %vP, align 32
  %5 = call { <16 x i8>, <16 x i8> } @llvm.ppc.vsx.disassemble.pair(<256 x i1> %4)
  %6 = extractvalue { <16 x i8>, <16 x i8> } %5, 0
  %7 = extractvalue { <16 x i8>, <16 x i8> } %5, 1
  %8 = call <512 x i1> @llvm.ppc.mma.xvf32gerpp(<512 x i1> %3, <16 x i8> %6, <16 x i8> %7)
  %9 = call { <16 x i8>, <16 x i8>, <16 x i8>, <16 x i8> } @llvm.ppc.mma.disassemble.acc(<512 x i1> %8)
  %10 = extractvalue { <16 x i8>, <16 x i8>, <16 x i8>, <16 x i8> } %9, 0
  %11 = extractvalue { <16 x i8>, <16 x i8>, <16 x i8>, <16 x i8> } %9, 1
  %12 = extractvalue { <16 x i8>, <16 x i8>, <16 x i8>, <16 x i8> } %9, 2
  %13 = extractvalue { <16 x i8>, <16 x i8>, <16 x i8>, <16 x i8> } %9, 3
  %14 = call <512 x i1> @llvm.ppc.mma.assemble.acc(<16 x i8> %13, <16 x i8> %12, <16 x i8> %11, <16 x i8> %10)
  %15 = call { <16 x i8>, <16 x i8>, <16 x i8>, <16 x i8> } @llvm.ppc.mma.disassemble.acc(<512 x i1> %14)
  %16 = extractvalue { <16 x i8>, <16 x i8>, <16 x i8>, <16 x i8> } %15, 0
  %17 = extractvalue { <16 x i8>, <16 x i8>, <16 x i8>, <16 x i8> } %15, 1
  %18 = extractvalue { <16 x i8>, <16 x i8>, <16 x i8>, <16 x i8> } %15, 2
  %19 = extractvalue { <16 x i8>, <16 x i8>, <16 x i8>, <16 x i8> } %15, 3
  store <16 x i8> %16, ptr %c, align 16
  %add.ptr = getelementptr inbounds float, ptr %c, i64 2
  store <16 x i8> %17, ptr %add.ptr, align 16
  %add.ptr11 = getelementptr inbounds float, ptr %c, i64 4
  store <16 x i8> %18, ptr %add.ptr11, align 16
  %add.ptr13 = getelementptr inbounds float, ptr %c, i64 6
  store <16 x i8> %19, ptr %add.ptr13, align 16
  call void @llvm.lifetime.end.p0(i64 32, ptr nonnull %vP)
  ret void
}

declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture)
declare <512 x i1> @llvm.ppc.mma.xxsetaccz()
declare void @_Z15buildVectorPairPu13__vector_pairDv16_hS0_(ptr noundef, <16 x i8> noundef, <16 x i8> noundef) local_unnamed_addr
declare <512 x i1> @llvm.ppc.mma.xvf32gerpp(<512 x i1>, <16 x i8>, <16 x i8>)
declare { <16 x i8>, <16 x i8> } @llvm.ppc.vsx.disassemble.pair(<256 x i1>)
declare { <16 x i8>, <16 x i8>, <16 x i8>, <16 x i8> } @llvm.ppc.mma.disassemble.acc(<512 x i1>)
declare <512 x i1> @llvm.ppc.mma.assemble.acc(<16 x i8>, <16 x i8>, <16 x i8>, <16 x i8>)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture)

attributes #0 = { nounwind }
