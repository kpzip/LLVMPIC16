; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc -amdgpu-scalarize-global-loads=false -mtriple=r600 -mcpu=redwood < %s | FileCheck -enable-var-scope -check-prefixes=R600 %s

define amdgpu_kernel void @xor_v2i32(ptr addrspace(1) %out, ptr addrspace(1) %in0, ptr addrspace(1) %in1) {
; R600-LABEL: xor_v2i32:
; R600:       ; %bb.0:
; R600-NEXT:    ALU 1, @10, KC0[CB0:0-32], KC1[]
; R600-NEXT:    TEX 1 @6
; R600-NEXT:    ALU 3, @12, KC0[CB0:0-32], KC1[]
; R600-NEXT:    MEM_RAT_CACHELESS STORE_RAW T0.XY, T1.X, 1
; R600-NEXT:    CF_END
; R600-NEXT:    PAD
; R600-NEXT:    Fetch clause starting at 6:
; R600-NEXT:     VTX_READ_64 T1.XY, T1.X, 0, #1
; R600-NEXT:     VTX_READ_64 T0.XY, T0.X, 0, #1
; R600-NEXT:    ALU clause starting at 10:
; R600-NEXT:     MOV T0.X, KC0[2].Z,
; R600-NEXT:     MOV * T1.X, KC0[2].W,
; R600-NEXT:    ALU clause starting at 12:
; R600-NEXT:     XOR_INT * T0.Y, T0.Y, T1.Y,
; R600-NEXT:     XOR_INT T0.X, T0.X, T1.X,
; R600-NEXT:     LSHR * T1.X, KC0[2].Y, literal.x,
; R600-NEXT:    2(2.802597e-45), 0(0.000000e+00)
  %a = load <2 x i32>, ptr addrspace(1) %in0
  %b = load <2 x i32>, ptr addrspace(1) %in1
  %result = xor <2 x i32> %a, %b
  store <2 x i32> %result, ptr addrspace(1) %out
  ret void
}

define amdgpu_kernel void @xor_v4i32(ptr addrspace(1) %out, ptr addrspace(1) %in0, ptr addrspace(1) %in1) {
; R600-LABEL: xor_v4i32:
; R600:       ; %bb.0:
; R600-NEXT:    ALU 1, @10, KC0[CB0:0-32], KC1[]
; R600-NEXT:    TEX 1 @6
; R600-NEXT:    ALU 5, @12, KC0[CB0:0-32], KC1[]
; R600-NEXT:    MEM_RAT_CACHELESS STORE_RAW T0.XYZW, T1.X, 1
; R600-NEXT:    CF_END
; R600-NEXT:    PAD
; R600-NEXT:    Fetch clause starting at 6:
; R600-NEXT:     VTX_READ_128 T1.XYZW, T1.X, 0, #1
; R600-NEXT:     VTX_READ_128 T0.XYZW, T0.X, 0, #1
; R600-NEXT:    ALU clause starting at 10:
; R600-NEXT:     MOV T0.X, KC0[2].Z,
; R600-NEXT:     MOV * T1.X, KC0[2].W,
; R600-NEXT:    ALU clause starting at 12:
; R600-NEXT:     XOR_INT * T0.W, T0.W, T1.W,
; R600-NEXT:     XOR_INT * T0.Z, T0.Z, T1.Z,
; R600-NEXT:     XOR_INT * T0.Y, T0.Y, T1.Y,
; R600-NEXT:     XOR_INT T0.X, T0.X, T1.X,
; R600-NEXT:     LSHR * T1.X, KC0[2].Y, literal.x,
; R600-NEXT:    2(2.802597e-45), 0(0.000000e+00)
  %a = load <4 x i32>, ptr addrspace(1) %in0
  %b = load <4 x i32>, ptr addrspace(1) %in1
  %result = xor <4 x i32> %a, %b
  store <4 x i32> %result, ptr addrspace(1) %out
  ret void
}

define amdgpu_kernel void @xor_i1(ptr addrspace(1) %out, ptr addrspace(1) %in0, ptr addrspace(1) %in1) {
; R600-LABEL: xor_i1:
; R600:       ; %bb.0:
; R600-NEXT:    ALU 0, @12, KC0[CB0:0-32], KC1[]
; R600-NEXT:    TEX 0 @8
; R600-NEXT:    ALU 0, @13, KC0[CB0:0-32], KC1[]
; R600-NEXT:    TEX 0 @10
; R600-NEXT:    ALU 5, @14, KC0[CB0:0-32], KC1[]
; R600-NEXT:    MEM_RAT_CACHELESS STORE_RAW T0.X, T1.X, 1
; R600-NEXT:    CF_END
; R600-NEXT:    PAD
; R600-NEXT:    Fetch clause starting at 8:
; R600-NEXT:     VTX_READ_32 T0.X, T0.X, 0, #1
; R600-NEXT:    Fetch clause starting at 10:
; R600-NEXT:     VTX_READ_32 T1.X, T1.X, 0, #1
; R600-NEXT:    ALU clause starting at 12:
; R600-NEXT:     MOV * T0.X, KC0[2].W,
; R600-NEXT:    ALU clause starting at 13:
; R600-NEXT:     MOV * T1.X, KC0[2].Z,
; R600-NEXT:    ALU clause starting at 14:
; R600-NEXT:     SETGE_DX10 T0.W, T0.X, 1.0,
; R600-NEXT:     SETGE_DX10 * T1.W, T1.X, 0.0,
; R600-NEXT:     XOR_INT * T0.W, PS, PV.W,
; R600-NEXT:     CNDE_INT T0.X, PV.W, T0.X, T1.X,
; R600-NEXT:     LSHR * T1.X, KC0[2].Y, literal.x,
; R600-NEXT:    2(2.802597e-45), 0(0.000000e+00)
  %a = load float, ptr addrspace(1) %in0
  %b = load float, ptr addrspace(1) %in1
  %acmp = fcmp oge float %a, 0.000000e+00
  %bcmp = fcmp oge float %b, 1.000000e+00
  %xor = xor i1 %acmp, %bcmp
  %result = select i1 %xor, float %a, float %b
  store float %result, ptr addrspace(1) %out
  ret void
}

define amdgpu_kernel void @v_xor_i1(ptr addrspace(1) %out, ptr addrspace(1) %in0, ptr addrspace(1) %in1) {
; R600-LABEL: v_xor_i1:
; R600:       ; %bb.0:
; R600-NEXT:    ALU 0, @12, KC0[CB0:0-32], KC1[]
; R600-NEXT:    TEX 0 @8
; R600-NEXT:    ALU 0, @13, KC0[CB0:0-32], KC1[]
; R600-NEXT:    TEX 0 @10
; R600-NEXT:    ALU 12, @14, KC0[CB0:0-32], KC1[]
; R600-NEXT:    MEM_RAT MSKOR T0.XW, T1.X
; R600-NEXT:    CF_END
; R600-NEXT:    PAD
; R600-NEXT:    Fetch clause starting at 8:
; R600-NEXT:     VTX_READ_8 T0.X, T0.X, 0, #1
; R600-NEXT:    Fetch clause starting at 10:
; R600-NEXT:     VTX_READ_8 T1.X, T1.X, 0, #1
; R600-NEXT:    ALU clause starting at 12:
; R600-NEXT:     MOV * T0.X, KC0[2].Z,
; R600-NEXT:    ALU clause starting at 13:
; R600-NEXT:     MOV * T1.X, KC0[2].W,
; R600-NEXT:    ALU clause starting at 14:
; R600-NEXT:     AND_INT T0.W, KC0[2].Y, literal.x,
; R600-NEXT:     XOR_INT * T1.W, T0.X, T1.X,
; R600-NEXT:    3(4.203895e-45), 0(0.000000e+00)
; R600-NEXT:     AND_INT T1.W, PS, 1,
; R600-NEXT:     LSHL * T0.W, PV.W, literal.x,
; R600-NEXT:    3(4.203895e-45), 0(0.000000e+00)
; R600-NEXT:     LSHL T0.X, PV.W, PS,
; R600-NEXT:     LSHL * T0.W, literal.x, PS,
; R600-NEXT:    255(3.573311e-43), 0(0.000000e+00)
; R600-NEXT:     MOV T0.Y, 0.0,
; R600-NEXT:     MOV * T0.Z, 0.0,
; R600-NEXT:     LSHR * T1.X, KC0[2].Y, literal.x,
; R600-NEXT:    2(2.802597e-45), 0(0.000000e+00)
  %a = load volatile i1, ptr addrspace(1) %in0
  %b = load volatile i1, ptr addrspace(1) %in1
  %xor = xor i1 %a, %b
  store i1 %xor, ptr addrspace(1) %out
  ret void
}

define amdgpu_kernel void @vector_xor_i32(ptr addrspace(1) %out, ptr addrspace(1) %in0, ptr addrspace(1) %in1) {
; R600-LABEL: vector_xor_i32:
; R600:       ; %bb.0:
; R600-NEXT:    ALU 1, @10, KC0[CB0:0-32], KC1[]
; R600-NEXT:    TEX 1 @6
; R600-NEXT:    ALU 2, @12, KC0[CB0:0-32], KC1[]
; R600-NEXT:    MEM_RAT_CACHELESS STORE_RAW T0.X, T1.X, 1
; R600-NEXT:    CF_END
; R600-NEXT:    PAD
; R600-NEXT:    Fetch clause starting at 6:
; R600-NEXT:     VTX_READ_32 T1.X, T1.X, 0, #1
; R600-NEXT:     VTX_READ_32 T0.X, T0.X, 0, #1
; R600-NEXT:    ALU clause starting at 10:
; R600-NEXT:     MOV T0.X, KC0[2].Z,
; R600-NEXT:     MOV * T1.X, KC0[2].W,
; R600-NEXT:    ALU clause starting at 12:
; R600-NEXT:     XOR_INT T0.X, T0.X, T1.X,
; R600-NEXT:     LSHR * T1.X, KC0[2].Y, literal.x,
; R600-NEXT:    2(2.802597e-45), 0(0.000000e+00)
  %a = load i32, ptr addrspace(1) %in0
  %b = load i32, ptr addrspace(1) %in1
  %result = xor i32 %a, %b
  store i32 %result, ptr addrspace(1) %out
  ret void
}

define amdgpu_kernel void @scalar_xor_i32(ptr addrspace(1) %out, i32 %a, i32 %b) {
; R600-LABEL: scalar_xor_i32:
; R600:       ; %bb.0:
; R600-NEXT:    ALU 2, @4, KC0[CB0:0-32], KC1[]
; R600-NEXT:    MEM_RAT_CACHELESS STORE_RAW T1.X, T0.X, 1
; R600-NEXT:    CF_END
; R600-NEXT:    PAD
; R600-NEXT:    ALU clause starting at 4:
; R600-NEXT:     LSHR T0.X, KC0[2].Y, literal.x,
; R600-NEXT:     NOT_INT * T1.X, KC0[2].Z,
; R600-NEXT:    2(2.802597e-45), 0(0.000000e+00)
  %result = xor i32 %a, -1
  store i32 %result, ptr addrspace(1) %out
  ret void
}

define amdgpu_kernel void @vector_not_i32(ptr addrspace(1) %out, ptr addrspace(1) %in0, ptr addrspace(1) %in1) {
; R600-LABEL: vector_not_i32:
; R600:       ; %bb.0:
; R600-NEXT:    ALU 0, @8, KC0[CB0:0-32], KC1[]
; R600-NEXT:    TEX 0 @6
; R600-NEXT:    ALU 2, @9, KC0[CB0:0-32], KC1[]
; R600-NEXT:    MEM_RAT_CACHELESS STORE_RAW T0.X, T1.X, 1
; R600-NEXT:    CF_END
; R600-NEXT:    PAD
; R600-NEXT:    Fetch clause starting at 6:
; R600-NEXT:     VTX_READ_32 T0.X, T0.X, 0, #1
; R600-NEXT:    ALU clause starting at 8:
; R600-NEXT:     MOV * T0.X, KC0[2].Z,
; R600-NEXT:    ALU clause starting at 9:
; R600-NEXT:     NOT_INT T0.X, T0.X,
; R600-NEXT:     LSHR * T1.X, KC0[2].Y, literal.x,
; R600-NEXT:    2(2.802597e-45), 0(0.000000e+00)
  %a = load i32, ptr addrspace(1) %in0
  %b = load i32, ptr addrspace(1) %in1
  %result = xor i32 %a, -1
  store i32 %result, ptr addrspace(1) %out
  ret void
}

define amdgpu_kernel void @vector_xor_i64(ptr addrspace(1) %out, ptr addrspace(1) %in0, ptr addrspace(1) %in1) {
; R600-LABEL: vector_xor_i64:
; R600:       ; %bb.0:
; R600-NEXT:    ALU 1, @10, KC0[CB0:0-32], KC1[]
; R600-NEXT:    TEX 1 @6
; R600-NEXT:    ALU 3, @12, KC0[CB0:0-32], KC1[]
; R600-NEXT:    MEM_RAT_CACHELESS STORE_RAW T0.XY, T1.X, 1
; R600-NEXT:    CF_END
; R600-NEXT:    PAD
; R600-NEXT:    Fetch clause starting at 6:
; R600-NEXT:     VTX_READ_64 T1.XY, T1.X, 0, #1
; R600-NEXT:     VTX_READ_64 T0.XY, T0.X, 0, #1
; R600-NEXT:    ALU clause starting at 10:
; R600-NEXT:     MOV T0.X, KC0[2].Z,
; R600-NEXT:     MOV * T1.X, KC0[2].W,
; R600-NEXT:    ALU clause starting at 12:
; R600-NEXT:     XOR_INT * T0.Y, T0.Y, T1.Y,
; R600-NEXT:     XOR_INT T0.X, T0.X, T1.X,
; R600-NEXT:     LSHR * T1.X, KC0[2].Y, literal.x,
; R600-NEXT:    2(2.802597e-45), 0(0.000000e+00)
  %a = load i64, ptr addrspace(1) %in0
  %b = load i64, ptr addrspace(1) %in1
  %result = xor i64 %a, %b
  store i64 %result, ptr addrspace(1) %out
  ret void
}

define amdgpu_kernel void @scalar_xor_i64(ptr addrspace(1) %out, i64 %a, i64 %b) {
; R600-LABEL: scalar_xor_i64:
; R600:       ; %bb.0:
; R600-NEXT:    ALU 3, @4, KC0[CB0:0-32], KC1[]
; R600-NEXT:    MEM_RAT_CACHELESS STORE_RAW T0.XY, T1.X, 1
; R600-NEXT:    CF_END
; R600-NEXT:    PAD
; R600-NEXT:    ALU clause starting at 4:
; R600-NEXT:     XOR_INT * T0.Y, KC0[3].X, KC0[3].Z,
; R600-NEXT:     XOR_INT * T0.X, KC0[2].W, KC0[3].Y,
; R600-NEXT:     LSHR * T1.X, KC0[2].Y, literal.x,
; R600-NEXT:    2(2.802597e-45), 0(0.000000e+00)
  %result = xor i64 %a, %b
  store i64 %result, ptr addrspace(1) %out
  ret void
}

define amdgpu_kernel void @scalar_not_i64(ptr addrspace(1) %out, i64 %a) {
; R600-LABEL: scalar_not_i64:
; R600:       ; %bb.0:
; R600-NEXT:    ALU 3, @4, KC0[CB0:0-32], KC1[]
; R600-NEXT:    MEM_RAT_CACHELESS STORE_RAW T0.XY, T1.X, 1
; R600-NEXT:    CF_END
; R600-NEXT:    PAD
; R600-NEXT:    ALU clause starting at 4:
; R600-NEXT:     NOT_INT * T0.Y, KC0[3].X,
; R600-NEXT:     NOT_INT T0.X, KC0[2].W,
; R600-NEXT:     LSHR * T1.X, KC0[2].Y, literal.x,
; R600-NEXT:    2(2.802597e-45), 0(0.000000e+00)
  %result = xor i64 %a, -1
  store i64 %result, ptr addrspace(1) %out
  ret void
}

define amdgpu_kernel void @vector_not_i64(ptr addrspace(1) %out, ptr addrspace(1) %in0, ptr addrspace(1) %in1) {
; R600-LABEL: vector_not_i64:
; R600:       ; %bb.0:
; R600-NEXT:    ALU 0, @8, KC0[CB0:0-32], KC1[]
; R600-NEXT:    TEX 0 @6
; R600-NEXT:    ALU 3, @9, KC0[CB0:0-32], KC1[]
; R600-NEXT:    MEM_RAT_CACHELESS STORE_RAW T0.XY, T1.X, 1
; R600-NEXT:    CF_END
; R600-NEXT:    PAD
; R600-NEXT:    Fetch clause starting at 6:
; R600-NEXT:     VTX_READ_64 T0.XY, T0.X, 0, #1
; R600-NEXT:    ALU clause starting at 8:
; R600-NEXT:     MOV * T0.X, KC0[2].Z,
; R600-NEXT:    ALU clause starting at 9:
; R600-NEXT:     NOT_INT * T0.Y, T0.Y,
; R600-NEXT:     NOT_INT T0.X, T0.X,
; R600-NEXT:     LSHR * T1.X, KC0[2].Y, literal.x,
; R600-NEXT:    2(2.802597e-45), 0(0.000000e+00)
  %a = load i64, ptr addrspace(1) %in0
  %b = load i64, ptr addrspace(1) %in1
  %result = xor i64 %a, -1
  store i64 %result, ptr addrspace(1) %out
  ret void
}

define amdgpu_kernel void @xor_cf(ptr addrspace(1) %out, ptr addrspace(1) %in, i64 %a, i64 %b) {
; R600-LABEL: xor_cf:
; R600:       ; %bb.0: ; %entry
; R600-NEXT:    ALU_PUSH_BEFORE 4, @14, KC0[CB0:0-32], KC1[]
; R600-NEXT:    JUMP @5 POP:1
; R600-NEXT:    ALU 0, @19, KC0[CB0:0-32], KC1[]
; R600-NEXT:    TEX 0 @12
; R600-NEXT:    ALU_POP_AFTER 1, @20, KC0[], KC1[]
; R600-NEXT:    ALU_PUSH_BEFORE 2, @22, KC0[CB0:0-32], KC1[]
; R600-NEXT:    JUMP @8 POP:1
; R600-NEXT:    ALU_POP_AFTER 5, @25, KC0[CB0:0-32], KC1[]
; R600-NEXT:    ALU 1, @31, KC0[], KC1[]
; R600-NEXT:    MEM_RAT_CACHELESS STORE_RAW T0.XY, T1.X, 1
; R600-NEXT:    CF_END
; R600-NEXT:    PAD
; R600-NEXT:    Fetch clause starting at 12:
; R600-NEXT:     VTX_READ_64 T0.XY, T0.X, 0, #1
; R600-NEXT:    ALU clause starting at 14:
; R600-NEXT:     OR_INT T0.W, KC0[2].W, KC0[3].X,
; R600-NEXT:     MOV * T1.W, literal.x,
; R600-NEXT:    1(1.401298e-45), 0(0.000000e+00)
; R600-NEXT:     SETNE_INT * T0.W, PV.W, 0.0,
; R600-NEXT:     PRED_SETNE_INT * ExecMask,PredicateBit (MASKED), PV.W, 0.0,
; R600-NEXT:    ALU clause starting at 19:
; R600-NEXT:     MOV * T0.X, KC0[2].Z,
; R600-NEXT:    ALU clause starting at 20:
; R600-NEXT:     MOV * T1.W, literal.x,
; R600-NEXT:    0(0.000000e+00), 0(0.000000e+00)
; R600-NEXT:    ALU clause starting at 22:
; R600-NEXT:     MOV T0.W, KC0[2].Y,
; R600-NEXT:     SETE_INT * T1.W, T1.W, 0.0,
; R600-NEXT:     PRED_SETE_INT * ExecMask,PredicateBit (MASKED), PS, 0.0,
; R600-NEXT:    ALU clause starting at 25:
; R600-NEXT:     MOV T1.W, KC0[2].W,
; R600-NEXT:     MOV * T2.W, KC0[3].Y,
; R600-NEXT:     XOR_INT T0.X, PV.W, PS,
; R600-NEXT:     MOV T1.W, KC0[3].X,
; R600-NEXT:     MOV * T2.W, KC0[3].Z,
; R600-NEXT:     XOR_INT * T0.Y, PV.W, PS,
; R600-NEXT:    ALU clause starting at 31:
; R600-NEXT:     LSHR * T1.X, T0.W, literal.x,
; R600-NEXT:    2(2.802597e-45), 0(0.000000e+00)
entry:
  %0 = icmp eq i64 %a, 0
  br i1 %0, label %if, label %else

if:
  %1 = xor i64 %a, %b
  br label %endif

else:
  %2 = load i64, ptr addrspace(1) %in
  br label %endif

endif:
  %3 = phi i64 [%1, %if], [%2, %else]
  store i64 %3, ptr addrspace(1) %out
  ret void
}

define amdgpu_kernel void @scalar_xor_literal_i64(ptr addrspace(1) %out, [8 x i32], i64 %a) {
; R600-LABEL: scalar_xor_literal_i64:
; R600:       ; %bb.0:
; R600-NEXT:    ALU 4, @4, KC0[CB0:0-32], KC1[]
; R600-NEXT:    MEM_RAT_CACHELESS STORE_RAW T0.XY, T1.X, 1
; R600-NEXT:    CF_END
; R600-NEXT:    PAD
; R600-NEXT:    ALU clause starting at 4:
; R600-NEXT:     XOR_INT * T0.Y, KC0[5].X, literal.x,
; R600-NEXT:    992123(1.390260e-39), 0(0.000000e+00)
; R600-NEXT:     XOR_INT T0.X, KC0[4].W, literal.x,
; R600-NEXT:     LSHR * T1.X, KC0[2].Y, literal.y,
; R600-NEXT:    12345(1.729903e-41), 2(2.802597e-45)
  %or = xor i64 %a, 4261135838621753
  store i64 %or, ptr addrspace(1) %out
  ret void
}

define amdgpu_kernel void @scalar_xor_literal_multi_use_i64(ptr addrspace(1) %out, [8 x i32], i64 %a, i64 %b) {
; R600-LABEL: scalar_xor_literal_multi_use_i64:
; R600:       ; %bb.0:
; R600-NEXT:    ALU 12, @6, KC0[CB0:0-32], KC1[]
; R600-NEXT:    MEM_RAT_CACHELESS STORE_RAW T3.XY, T4.X, 0
; R600-NEXT:    MEM_RAT_CACHELESS STORE_RAW T1.X, T2.X, 0
; R600-NEXT:    MEM_RAT_CACHELESS STORE_RAW T0.X, T2.X, 1
; R600-NEXT:    CF_END
; R600-NEXT:    PAD
; R600-NEXT:    ALU clause starting at 6:
; R600-NEXT:     ADDC_UINT * T0.W, KC0[5].Y, literal.x,
; R600-NEXT:    12345(1.729903e-41), 0(0.000000e+00)
; R600-NEXT:     ADD_INT T0.X, KC0[5].Y, literal.x,
; R600-NEXT:     ADD_INT * T0.W, KC0[5].Z, PV.W,
; R600-NEXT:    12345(1.729903e-41), 0(0.000000e+00)
; R600-NEXT:     ADD_INT T1.X, PV.W, literal.x,
; R600-NEXT:     MOV * T2.X, literal.y,
; R600-NEXT:    992123(1.390260e-39), 0(0.000000e+00)
; R600-NEXT:     XOR_INT * T3.Y, KC0[5].X, literal.x,
; R600-NEXT:    992123(1.390260e-39), 0(0.000000e+00)
; R600-NEXT:     XOR_INT T3.X, KC0[4].W, literal.x,
; R600-NEXT:     LSHR * T4.X, KC0[2].Y, literal.y,
; R600-NEXT:    12345(1.729903e-41), 2(2.802597e-45)
  %or = xor i64 %a, 4261135838621753
  store i64 %or, ptr addrspace(1) %out

  %foo = add i64 %b, 4261135838621753
  store volatile i64 %foo, ptr addrspace(1) undef
  ret void
}

define amdgpu_kernel void @scalar_xor_inline_imm_i64(ptr addrspace(1) %out, [8 x i32], i64 %a) {
; R600-LABEL: scalar_xor_inline_imm_i64:
; R600:       ; %bb.0:
; R600-NEXT:    ALU 3, @4, KC0[CB0:0-32], KC1[]
; R600-NEXT:    MEM_RAT_CACHELESS STORE_RAW T0.XY, T1.X, 1
; R600-NEXT:    CF_END
; R600-NEXT:    PAD
; R600-NEXT:    ALU clause starting at 4:
; R600-NEXT:     MOV * T0.Y, KC0[5].X,
; R600-NEXT:     XOR_INT T0.X, KC0[4].W, literal.x,
; R600-NEXT:     LSHR * T1.X, KC0[2].Y, literal.y,
; R600-NEXT:    63(8.828180e-44), 2(2.802597e-45)
  %or = xor i64 %a, 63
  store i64 %or, ptr addrspace(1) %out
  ret void
}

define amdgpu_kernel void @scalar_xor_neg_inline_imm_i64(ptr addrspace(1) %out, [8 x i32], i64 %a) {
; R600-LABEL: scalar_xor_neg_inline_imm_i64:
; R600:       ; %bb.0:
; R600-NEXT:    ALU 3, @4, KC0[CB0:0-32], KC1[]
; R600-NEXT:    MEM_RAT_CACHELESS STORE_RAW T0.XY, T1.X, 1
; R600-NEXT:    CF_END
; R600-NEXT:    PAD
; R600-NEXT:    ALU clause starting at 4:
; R600-NEXT:     NOT_INT * T0.Y, KC0[5].X,
; R600-NEXT:     XOR_INT T0.X, KC0[4].W, literal.x,
; R600-NEXT:     LSHR * T1.X, KC0[2].Y, literal.y,
; R600-NEXT:    -8(nan), 2(2.802597e-45)
  %or = xor i64 %a, -8
  store i64 %or, ptr addrspace(1) %out
  ret void
}

define amdgpu_kernel void @vector_xor_i64_neg_inline_imm(ptr addrspace(1) %out, ptr addrspace(1) %a, ptr addrspace(1) %b) {
; R600-LABEL: vector_xor_i64_neg_inline_imm:
; R600:       ; %bb.0:
; R600-NEXT:    ALU 0, @8, KC0[CB0:0-32], KC1[]
; R600-NEXT:    TEX 0 @6
; R600-NEXT:    ALU 3, @9, KC0[CB0:0-32], KC1[]
; R600-NEXT:    MEM_RAT_CACHELESS STORE_RAW T0.XY, T1.X, 1
; R600-NEXT:    CF_END
; R600-NEXT:    PAD
; R600-NEXT:    Fetch clause starting at 6:
; R600-NEXT:     VTX_READ_64 T0.XY, T0.X, 0, #1
; R600-NEXT:    ALU clause starting at 8:
; R600-NEXT:     MOV * T0.X, KC0[2].Z,
; R600-NEXT:    ALU clause starting at 9:
; R600-NEXT:     NOT_INT * T0.Y, T0.Y,
; R600-NEXT:     XOR_INT T0.X, T0.X, literal.x,
; R600-NEXT:     LSHR * T1.X, KC0[2].Y, literal.y,
; R600-NEXT:    -8(nan), 2(2.802597e-45)
  %loada = load i64, ptr addrspace(1) %a, align 8
  %or = xor i64 %loada, -8
  store i64 %or, ptr addrspace(1) %out
  ret void
}

define amdgpu_kernel void @vector_xor_literal_i64(ptr addrspace(1) %out, ptr addrspace(1) %a, ptr addrspace(1) %b) {
; R600-LABEL: vector_xor_literal_i64:
; R600:       ; %bb.0:
; R600-NEXT:    ALU 0, @8, KC0[CB0:0-32], KC1[]
; R600-NEXT:    TEX 0 @6
; R600-NEXT:    ALU 4, @9, KC0[CB0:0-32], KC1[]
; R600-NEXT:    MEM_RAT_CACHELESS STORE_RAW T0.XY, T1.X, 1
; R600-NEXT:    CF_END
; R600-NEXT:    PAD
; R600-NEXT:    Fetch clause starting at 6:
; R600-NEXT:     VTX_READ_64 T0.XY, T0.X, 0, #1
; R600-NEXT:    ALU clause starting at 8:
; R600-NEXT:     MOV * T0.X, KC0[2].Z,
; R600-NEXT:    ALU clause starting at 9:
; R600-NEXT:     XOR_INT * T0.Y, T0.Y, literal.x,
; R600-NEXT:    5231(7.330192e-42), 0(0.000000e+00)
; R600-NEXT:     XOR_INT T0.X, T0.X, literal.x,
; R600-NEXT:     LSHR * T1.X, KC0[2].Y, literal.y,
; R600-NEXT:    -545810305(-1.784115e+19), 2(2.802597e-45)
  %loada = load i64, ptr addrspace(1) %a, align 8
  %or = xor i64 %loada, 22470723082367
  store i64 %or, ptr addrspace(1) %out
  ret void
}
