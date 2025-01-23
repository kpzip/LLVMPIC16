; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
;RUN: llc < %s -mtriple=amdgcn -mcpu=verde -verify-machineinstrs | FileCheck -check-prefixes=PREGFX10 %s
;RUN: llc < %s -mtriple=amdgcn -mcpu=tonga -verify-machineinstrs | FileCheck -check-prefixes=PREGFX10 %s
;RUN: llc < %s -mtriple=amdgcn -mcpu=gfx1010 -verify-machineinstrs | FileCheck -check-prefixes=GFX10 %s
;RUN: llc < %s -mtriple=amdgcn -mcpu=gfx1100 -verify-machineinstrs | FileCheck -check-prefixes=GFX11 %s

define amdgpu_vs {<4 x float>, <4 x float>, <4 x float>, <4 x float>} @tbuffer_load(ptr addrspace(8) inreg) {
; PREGFX10-LABEL: tbuffer_load:
; PREGFX10:       ; %bb.0: ; %main_body
; PREGFX10-NEXT:    v_mov_b32_e32 v12, 0
; PREGFX10-NEXT:    tbuffer_load_format_xyzw v[0:3], v12, s[0:3], 0 format:[BUF_DATA_FORMAT_32_32_32_32,BUF_NUM_FORMAT_UINT] idxen
; PREGFX10-NEXT:    tbuffer_load_format_xyzw v[4:7], v12, s[0:3], 0 format:[BUF_DATA_FORMAT_RESERVED_15,BUF_NUM_FORMAT_SSCALED] idxen glc
; PREGFX10-NEXT:    tbuffer_load_format_xyzw v[8:11], v12, s[0:3], 0 format:[BUF_DATA_FORMAT_10_11_11,BUF_NUM_FORMAT_SNORM] idxen slc
; PREGFX10-NEXT:    tbuffer_load_format_xyzw v[12:15], v12, s[0:3], 0 format:[BUF_DATA_FORMAT_10_11_11,BUF_NUM_FORMAT_SNORM] idxen glc
; PREGFX10-NEXT:    s_waitcnt vmcnt(0)
; PREGFX10-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: tbuffer_load:
; GFX10:       ; %bb.0: ; %main_body
; GFX10-NEXT:    v_mov_b32_e32 v16, 0
; GFX10-NEXT:    s_clause 0x3
; GFX10-NEXT:    tbuffer_load_format_xyzw v[0:3], v16, s[0:3], 0 format:78 idxen
; GFX10-NEXT:    tbuffer_load_format_xyzw v[4:7], v16, s[0:3], 0 format:[BUF_FMT_32_32_SINT] idxen glc
; GFX10-NEXT:    tbuffer_load_format_xyzw v[8:11], v16, s[0:3], 0 format:[BUF_FMT_32_FLOAT] idxen slc
; GFX10-NEXT:    tbuffer_load_format_xyzw v[12:15], v16, s[0:3], 0 format:[BUF_FMT_32_FLOAT] idxen glc dlc
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    ; return to shader part epilog
;
; GFX11-LABEL: tbuffer_load:
; GFX11:       ; %bb.0: ; %main_body
; GFX11-NEXT:    v_mov_b32_e32 v12, 0
; GFX11-NEXT:    s_clause 0x3
; GFX11-NEXT:    tbuffer_load_format_xyzw v[0:3], v12, s[0:3], 0 format:78 idxen
; GFX11-NEXT:    tbuffer_load_format_xyzw v[4:7], v12, s[0:3], 0 format:[BUF_FMT_32_32_32_32_FLOAT] idxen glc
; GFX11-NEXT:    tbuffer_load_format_xyzw v[8:11], v12, s[0:3], 0 format:[BUF_FMT_32_FLOAT] idxen slc
; GFX11-NEXT:    tbuffer_load_format_xyzw v[12:15], v12, s[0:3], 0 format:[BUF_FMT_32_FLOAT] idxen glc dlc
; GFX11-NEXT:    s_waitcnt vmcnt(0)
; GFX11-NEXT:    ; return to shader part epilog
main_body:
    %vdata     = call <4 x i32> @llvm.amdgcn.struct.ptr.tbuffer.load.v4i32(ptr addrspace(8) %0, i32 0, i32 0, i32 0, i32 78, i32 0)
    %vdata_glc = call <4 x i32> @llvm.amdgcn.struct.ptr.tbuffer.load.v4i32(ptr addrspace(8) %0, i32 0, i32 0, i32 0, i32 63, i32 1)
    %vdata_slc = call <4 x i32> @llvm.amdgcn.struct.ptr.tbuffer.load.v4i32(ptr addrspace(8) %0, i32 0, i32 0, i32 0, i32 22, i32 2)
    %vdata_f32 = call <4 x float> @llvm.amdgcn.struct.ptr.tbuffer.load.v4f32(ptr addrspace(8) %0, i32 0, i32 0, i32 0, i32 22, i32 5)
    %vdata.f     = bitcast <4 x i32> %vdata to <4 x float>
    %vdata_glc.f = bitcast <4 x i32> %vdata_glc to <4 x float>
    %vdata_slc.f = bitcast <4 x i32> %vdata_slc to <4 x float>
    %r0 = insertvalue {<4 x float>, <4 x float>, <4 x float>, <4 x float>} undef, <4 x float> %vdata.f, 0
    %r1 = insertvalue {<4 x float>, <4 x float>, <4 x float>, <4 x float>} %r0, <4 x float> %vdata_glc.f, 1
    %r2 = insertvalue {<4 x float>, <4 x float>, <4 x float>, <4 x float>} %r1, <4 x float> %vdata_slc.f, 2
    %r3 = insertvalue {<4 x float>, <4 x float>, <4 x float>, <4 x float>} %r2, <4 x float> %vdata_f32, 3
    ret {<4 x float>, <4 x float>, <4 x float>, <4 x float>} %r3
}

define amdgpu_vs <4 x float> @tbuffer_load_immoffs(ptr addrspace(8) inreg) {
; PREGFX10-LABEL: tbuffer_load_immoffs:
; PREGFX10:       ; %bb.0: ; %main_body
; PREGFX10-NEXT:    v_mov_b32_e32 v0, 0
; PREGFX10-NEXT:    tbuffer_load_format_xyzw v[0:3], v0, s[0:3], 0 format:[BUF_DATA_FORMAT_32_32_32_32,BUF_NUM_FORMAT_UINT] idxen offset:42
; PREGFX10-NEXT:    s_waitcnt vmcnt(0)
; PREGFX10-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: tbuffer_load_immoffs:
; GFX10:       ; %bb.0: ; %main_body
; GFX10-NEXT:    v_mov_b32_e32 v0, 0
; GFX10-NEXT:    tbuffer_load_format_xyzw v[0:3], v0, s[0:3], 0 format:78 idxen offset:42
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    ; return to shader part epilog
;
; GFX11-LABEL: tbuffer_load_immoffs:
; GFX11:       ; %bb.0: ; %main_body
; GFX11-NEXT:    v_mov_b32_e32 v0, 0
; GFX11-NEXT:    tbuffer_load_format_xyzw v[0:3], v0, s[0:3], 0 format:78 idxen offset:42
; GFX11-NEXT:    s_waitcnt vmcnt(0)
; GFX11-NEXT:    ; return to shader part epilog
main_body:
    %vdata   = call <4 x i32> @llvm.amdgcn.struct.ptr.tbuffer.load.v4i32(ptr addrspace(8) %0, i32 0, i32 42, i32 0, i32 78, i32 0)
    %vdata.f = bitcast <4 x i32> %vdata to <4 x float>
    ret <4 x float> %vdata.f
}

define amdgpu_vs {<4 x float>, <4 x float>, <4 x float>} @tbuffer_load_immoffs_large(ptr addrspace(8) inreg, i32 inreg %soffs) {
; PREGFX10-LABEL: tbuffer_load_immoffs_large:
; PREGFX10:       ; %bb.0:
; PREGFX10-NEXT:    v_mov_b32_e32 v8, 0
; PREGFX10-NEXT:    tbuffer_load_format_xyzw v[0:3], v8, s[0:3], 61 format:[BUF_DATA_FORMAT_RESERVED_15,BUF_NUM_FORMAT_USCALED] idxen offset:4095
; PREGFX10-NEXT:    tbuffer_load_format_xyzw v[4:7], v8, s[0:3], s4 format:[BUF_DATA_FORMAT_32_32_32_32,BUF_NUM_FORMAT_SSCALED] idxen offset:73
; PREGFX10-NEXT:    tbuffer_load_format_xyzw v[8:11], v8, s[0:3], s4 format:[BUF_DATA_FORMAT_32_32_32,BUF_NUM_FORMAT_UINT] idxen offset:1
; PREGFX10-NEXT:    s_waitcnt vmcnt(0)
; PREGFX10-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: tbuffer_load_immoffs_large:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    v_mov_b32_e32 v12, 0
; GFX10-NEXT:    s_clause 0x2
; GFX10-NEXT:    tbuffer_load_format_xyzw v[0:3], v12, s[0:3], 61 format:[BUF_FMT_10_10_10_2_SSCALED] idxen offset:4095
; GFX10-NEXT:    tbuffer_load_format_xyzw v[4:7], v12, s[0:3], s4 format:[BUF_FMT_32_32_UINT] idxen offset:73
; GFX10-NEXT:    tbuffer_load_format_xyzw v[8:11], v12, s[0:3], s4 format:[BUF_FMT_32_32_32_32_FLOAT] idxen offset:1
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    ; return to shader part epilog
;
; GFX11-LABEL: tbuffer_load_immoffs_large:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    v_mov_b32_e32 v8, 0
; GFX11-NEXT:    s_clause 0x2
; GFX11-NEXT:    tbuffer_load_format_xyzw v[0:3], v8, s[0:3], 61 format:[BUF_FMT_8_8_8_8_SINT] idxen offset:4095
; GFX11-NEXT:    tbuffer_load_format_xyzw v[4:7], v8, s[0:3], s4 format:[BUF_FMT_32_32_32_32_SINT] idxen offset:73
; GFX11-NEXT:    tbuffer_load_format_xyzw v[8:11], v8, s[0:3], s4 format:77 idxen offset:1
; GFX11-NEXT:    s_waitcnt vmcnt(0)
; GFX11-NEXT:    ; return to shader part epilog
    %vdata     = call <4 x i32> @llvm.amdgcn.struct.ptr.tbuffer.load.v4i32(ptr addrspace(8) %0, i32 0, i32 4095, i32 61, i32 47, i32 0)
    %vdata_glc = call <4 x i32> @llvm.amdgcn.struct.ptr.tbuffer.load.v4i32(ptr addrspace(8) %0, i32 0, i32 73, i32 %soffs, i32 62, i32 0)
    %vdata_slc = call <4 x i32> @llvm.amdgcn.struct.ptr.tbuffer.load.v4i32(ptr addrspace(8) %0, i32 0, i32 1, i32 %soffs, i32 77, i32 0)
    %vdata.f     = bitcast <4 x i32> %vdata to <4 x float>
    %vdata_glc.f = bitcast <4 x i32> %vdata_glc to <4 x float>
    %vdata_slc.f = bitcast <4 x i32> %vdata_slc to <4 x float>
    %r0 = insertvalue {<4 x float>, <4 x float>, <4 x float>} undef, <4 x float> %vdata.f, 0
    %r1 = insertvalue {<4 x float>, <4 x float>, <4 x float>} %r0, <4 x float> %vdata_glc.f, 1
    %r2 = insertvalue {<4 x float>, <4 x float>, <4 x float>} %r1, <4 x float> %vdata_slc.f, 2
    ret {<4 x float>, <4 x float>, <4 x float>} %r2
}

define amdgpu_vs <4 x float> @tbuffer_load_idx(ptr addrspace(8) inreg, i32 %vindex) {
; PREGFX10-LABEL: tbuffer_load_idx:
; PREGFX10:       ; %bb.0: ; %main_body
; PREGFX10-NEXT:    tbuffer_load_format_xyzw v[0:3], v0, s[0:3], 0 format:[BUF_DATA_FORMAT_32_32_32_32,BUF_NUM_FORMAT_UINT] idxen
; PREGFX10-NEXT:    s_waitcnt vmcnt(0)
; PREGFX10-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: tbuffer_load_idx:
; GFX10:       ; %bb.0: ; %main_body
; GFX10-NEXT:    tbuffer_load_format_xyzw v[0:3], v0, s[0:3], 0 format:78 idxen
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    ; return to shader part epilog
;
; GFX11-LABEL: tbuffer_load_idx:
; GFX11:       ; %bb.0: ; %main_body
; GFX11-NEXT:    tbuffer_load_format_xyzw v[0:3], v0, s[0:3], 0 format:78 idxen
; GFX11-NEXT:    s_waitcnt vmcnt(0)
; GFX11-NEXT:    ; return to shader part epilog
main_body:
    %vdata   = call <4 x i32> @llvm.amdgcn.struct.ptr.tbuffer.load.v4i32(ptr addrspace(8) %0, i32 %vindex, i32 0, i32 0, i32 78, i32 0)
    %vdata.f = bitcast <4 x i32> %vdata to <4 x float>
    ret <4 x float> %vdata.f
}

define amdgpu_vs <4 x float> @tbuffer_load_ofs(ptr addrspace(8) inreg, i32 %voffs) {
; PREGFX10-LABEL: tbuffer_load_ofs:
; PREGFX10:       ; %bb.0: ; %main_body
; PREGFX10-NEXT:    s_mov_b32 s4, 0
; PREGFX10-NEXT:    v_mov_b32_e32 v1, v0
; PREGFX10-NEXT:    v_mov_b32_e32 v0, s4
; PREGFX10-NEXT:    tbuffer_load_format_xyzw v[0:3], v[0:1], s[0:3], 0 format:[BUF_DATA_FORMAT_32_32_32_32,BUF_NUM_FORMAT_UINT] idxen offen
; PREGFX10-NEXT:    s_waitcnt vmcnt(0)
; PREGFX10-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: tbuffer_load_ofs:
; GFX10:       ; %bb.0: ; %main_body
; GFX10-NEXT:    s_mov_b32 s4, 0
; GFX10-NEXT:    v_mov_b32_e32 v1, v0
; GFX10-NEXT:    v_mov_b32_e32 v0, s4
; GFX10-NEXT:    tbuffer_load_format_xyzw v[0:3], v[0:1], s[0:3], 0 format:78 idxen offen
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    ; return to shader part epilog
;
; GFX11-LABEL: tbuffer_load_ofs:
; GFX11:       ; %bb.0: ; %main_body
; GFX11-NEXT:    s_mov_b32 s4, 0
; GFX11-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; GFX11-NEXT:    v_dual_mov_b32 v1, v0 :: v_dual_mov_b32 v0, s4
; GFX11-NEXT:    tbuffer_load_format_xyzw v[0:3], v[0:1], s[0:3], 0 format:78 idxen offen
; GFX11-NEXT:    s_waitcnt vmcnt(0)
; GFX11-NEXT:    ; return to shader part epilog
main_body:
    %vdata   = call <4 x i32> @llvm.amdgcn.struct.ptr.tbuffer.load.v4i32(ptr addrspace(8) %0, i32 0, i32 %voffs, i32 0, i32 78, i32 0)
    %vdata.f = bitcast <4 x i32> %vdata to <4 x float>
    ret <4 x float> %vdata.f
}

define amdgpu_vs <4 x float> @tbuffer_load_ofs_imm(ptr addrspace(8) inreg, i32 %voffs) {
; PREGFX10-LABEL: tbuffer_load_ofs_imm:
; PREGFX10:       ; %bb.0: ; %main_body
; PREGFX10-NEXT:    s_mov_b32 s4, 0
; PREGFX10-NEXT:    v_mov_b32_e32 v1, v0
; PREGFX10-NEXT:    v_mov_b32_e32 v0, s4
; PREGFX10-NEXT:    tbuffer_load_format_xyzw v[0:3], v[0:1], s[0:3], 0 format:[BUF_DATA_FORMAT_32_32_32_32,BUF_NUM_FORMAT_UINT] idxen offen offset:52
; PREGFX10-NEXT:    s_waitcnt vmcnt(0)
; PREGFX10-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: tbuffer_load_ofs_imm:
; GFX10:       ; %bb.0: ; %main_body
; GFX10-NEXT:    s_mov_b32 s4, 0
; GFX10-NEXT:    v_mov_b32_e32 v1, v0
; GFX10-NEXT:    v_mov_b32_e32 v0, s4
; GFX10-NEXT:    tbuffer_load_format_xyzw v[0:3], v[0:1], s[0:3], 0 format:78 idxen offen offset:52
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    ; return to shader part epilog
;
; GFX11-LABEL: tbuffer_load_ofs_imm:
; GFX11:       ; %bb.0: ; %main_body
; GFX11-NEXT:    s_mov_b32 s4, 0
; GFX11-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; GFX11-NEXT:    v_dual_mov_b32 v1, v0 :: v_dual_mov_b32 v0, s4
; GFX11-NEXT:    tbuffer_load_format_xyzw v[0:3], v[0:1], s[0:3], 0 format:78 idxen offen offset:52
; GFX11-NEXT:    s_waitcnt vmcnt(0)
; GFX11-NEXT:    ; return to shader part epilog
main_body:
    %ofs = add i32 %voffs, 52
    %vdata   = call <4 x i32> @llvm.amdgcn.struct.ptr.tbuffer.load.v4i32(ptr addrspace(8) %0, i32 0, i32 %ofs, i32 0, i32 78, i32 0)
    %vdata.f = bitcast <4 x i32> %vdata to <4 x float>
    ret <4 x float> %vdata.f
}

define amdgpu_vs <4 x float> @tbuffer_load_both(ptr addrspace(8) inreg, i32 %vindex, i32 %voffs) {
; PREGFX10-LABEL: tbuffer_load_both:
; PREGFX10:       ; %bb.0: ; %main_body
; PREGFX10-NEXT:    tbuffer_load_format_xyzw v[0:3], v[0:1], s[0:3], 0 format:[BUF_DATA_FORMAT_32_32_32_32,BUF_NUM_FORMAT_UINT] idxen offen
; PREGFX10-NEXT:    s_waitcnt vmcnt(0)
; PREGFX10-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: tbuffer_load_both:
; GFX10:       ; %bb.0: ; %main_body
; GFX10-NEXT:    tbuffer_load_format_xyzw v[0:3], v[0:1], s[0:3], 0 format:78 idxen offen
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    ; return to shader part epilog
;
; GFX11-LABEL: tbuffer_load_both:
; GFX11:       ; %bb.0: ; %main_body
; GFX11-NEXT:    tbuffer_load_format_xyzw v[0:3], v[0:1], s[0:3], 0 format:78 idxen offen
; GFX11-NEXT:    s_waitcnt vmcnt(0)
; GFX11-NEXT:    ; return to shader part epilog
main_body:
    %vdata   = call <4 x i32> @llvm.amdgcn.struct.ptr.tbuffer.load.v4i32(ptr addrspace(8) %0, i32 %vindex, i32 %voffs, i32 0, i32 78, i32 0)
    %vdata.f = bitcast <4 x i32> %vdata to <4 x float>
    ret <4 x float> %vdata.f
}

define amdgpu_vs <2 x float> @buffer_load_xy(ptr addrspace(8) inreg %rsrc) {
; PREGFX10-LABEL: buffer_load_xy:
; PREGFX10:       ; %bb.0:
; PREGFX10-NEXT:    v_mov_b32_e32 v0, 0
; PREGFX10-NEXT:    tbuffer_load_format_xy v[0:1], v0, s[0:3], 0 format:[BUF_DATA_FORMAT_32_32_32,BUF_NUM_FORMAT_UINT] idxen
; PREGFX10-NEXT:    s_waitcnt vmcnt(0)
; PREGFX10-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: buffer_load_xy:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    v_mov_b32_e32 v0, 0
; GFX10-NEXT:    tbuffer_load_format_xy v[0:1], v0, s[0:3], 0 format:[BUF_FMT_32_32_32_32_FLOAT] idxen
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    ; return to shader part epilog
;
; GFX11-LABEL: buffer_load_xy:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    v_mov_b32_e32 v0, 0
; GFX11-NEXT:    tbuffer_load_format_xy v[0:1], v0, s[0:3], 0 format:77 idxen
; GFX11-NEXT:    s_waitcnt vmcnt(0)
; GFX11-NEXT:    ; return to shader part epilog
    %vdata = call <2 x i32> @llvm.amdgcn.struct.ptr.tbuffer.load.v2i32(ptr addrspace(8) %rsrc, i32 0, i32 0, i32 0, i32 77, i32 0)
    %vdata.f = bitcast <2 x i32> %vdata to <2 x float>
    ret <2 x float> %vdata.f
}

define amdgpu_vs float @buffer_load_x(ptr addrspace(8) inreg %rsrc) {
; PREGFX10-LABEL: buffer_load_x:
; PREGFX10:       ; %bb.0:
; PREGFX10-NEXT:    v_mov_b32_e32 v0, 0
; PREGFX10-NEXT:    tbuffer_load_format_x v0, v0, s[0:3], 0 format:[BUF_DATA_FORMAT_32_32_32,BUF_NUM_FORMAT_UINT] idxen
; PREGFX10-NEXT:    s_waitcnt vmcnt(0)
; PREGFX10-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: buffer_load_x:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    v_mov_b32_e32 v0, 0
; GFX10-NEXT:    tbuffer_load_format_x v0, v0, s[0:3], 0 format:[BUF_FMT_32_32_32_32_FLOAT] idxen
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    ; return to shader part epilog
;
; GFX11-LABEL: buffer_load_x:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    v_mov_b32_e32 v0, 0
; GFX11-NEXT:    tbuffer_load_format_x v0, v0, s[0:3], 0 format:77 idxen
; GFX11-NEXT:    s_waitcnt vmcnt(0)
; GFX11-NEXT:    ; return to shader part epilog
    %vdata = call i32 @llvm.amdgcn.struct.ptr.tbuffer.load.i32(ptr addrspace(8) %rsrc, i32 0, i32 0, i32 0, i32 77, i32 0)
    %vdata.f = bitcast i32 %vdata to float
    ret float %vdata.f
}

define amdgpu_ps <4 x float> @buffer_load_voffset_large_12bit(ptr addrspace(8) inreg) {
; PREGFX10-LABEL: buffer_load_voffset_large_12bit:
; PREGFX10:       ; %bb.0: ; %main_body
; PREGFX10-NEXT:    v_mov_b32_e32 v0, 0
; PREGFX10-NEXT:    tbuffer_load_format_xyzw v[0:3], v0, s[0:3], 0 format:[BUF_DATA_FORMAT_RESERVED_15,BUF_NUM_FORMAT_SSCALED] idxen offset:4092
; PREGFX10-NEXT:    s_waitcnt vmcnt(0)
; PREGFX10-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: buffer_load_voffset_large_12bit:
; GFX10:       ; %bb.0: ; %main_body
; GFX10-NEXT:    v_mov_b32_e32 v0, 0
; GFX10-NEXT:    tbuffer_load_format_xyzw v[0:3], v0, s[0:3], 0 format:[BUF_FMT_32_32_SINT] idxen offset:4092
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    ; return to shader part epilog
;
; GFX11-LABEL: buffer_load_voffset_large_12bit:
; GFX11:       ; %bb.0: ; %main_body
; GFX11-NEXT:    v_mov_b32_e32 v0, 0
; GFX11-NEXT:    tbuffer_load_format_xyzw v[0:3], v0, s[0:3], 0 format:[BUF_FMT_32_32_32_32_FLOAT] idxen offset:4092
; GFX11-NEXT:    s_waitcnt vmcnt(0)
; GFX11-NEXT:    ; return to shader part epilog
main_body:
  %data = call <4 x float> @llvm.amdgcn.struct.ptr.tbuffer.load.v4f32(ptr addrspace(8) %0, i32 0, i32 4092, i32 0, i32 63, i32 0)
  ret <4 x float> %data
}

define amdgpu_ps <4 x float> @tbuffer_load_voffset_large_13bit(ptr addrspace(8) inreg) {
; PREGFX10-LABEL: tbuffer_load_voffset_large_13bit:
; PREGFX10:       ; %bb.0: ; %main_body
; PREGFX10-NEXT:    s_mov_b32 s4, 0
; PREGFX10-NEXT:    v_mov_b32_e32 v1, 0x1000
; PREGFX10-NEXT:    v_mov_b32_e32 v0, s4
; PREGFX10-NEXT:    tbuffer_load_format_xyzw v[0:3], v[0:1], s[0:3], 0 format:[BUF_DATA_FORMAT_RESERVED_15,BUF_NUM_FORMAT_SSCALED] idxen offen offset:4092
; PREGFX10-NEXT:    s_waitcnt vmcnt(0)
; PREGFX10-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: tbuffer_load_voffset_large_13bit:
; GFX10:       ; %bb.0: ; %main_body
; GFX10-NEXT:    s_mov_b32 s4, 0
; GFX10-NEXT:    v_mov_b32_e32 v1, 0x1000
; GFX10-NEXT:    v_mov_b32_e32 v0, s4
; GFX10-NEXT:    tbuffer_load_format_xyzw v[0:3], v[0:1], s[0:3], 0 format:[BUF_FMT_32_32_SINT] idxen offen offset:4092
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    ; return to shader part epilog
;
; GFX11-LABEL: tbuffer_load_voffset_large_13bit:
; GFX11:       ; %bb.0: ; %main_body
; GFX11-NEXT:    s_mov_b32 s4, 0
; GFX11-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; GFX11-NEXT:    v_dual_mov_b32 v1, 0x1000 :: v_dual_mov_b32 v0, s4
; GFX11-NEXT:    tbuffer_load_format_xyzw v[0:3], v[0:1], s[0:3], 0 format:[BUF_FMT_32_32_32_32_FLOAT] idxen offen offset:4092
; GFX11-NEXT:    s_waitcnt vmcnt(0)
; GFX11-NEXT:    ; return to shader part epilog
main_body:
  %data = call <4 x float> @llvm.amdgcn.struct.ptr.tbuffer.load.v4f32(ptr addrspace(8) %0, i32 0, i32 8188, i32 0, i32 63, i32 0)
  ret <4 x float> %data
}

define amdgpu_ps <4 x float> @tbuffer_load_voffset_large_16bit(ptr addrspace(8) inreg) {
; PREGFX10-LABEL: tbuffer_load_voffset_large_16bit:
; PREGFX10:       ; %bb.0: ; %main_body
; PREGFX10-NEXT:    s_mov_b32 s4, 0
; PREGFX10-NEXT:    v_mov_b32_e32 v1, 0xf000
; PREGFX10-NEXT:    v_mov_b32_e32 v0, s4
; PREGFX10-NEXT:    tbuffer_load_format_xyzw v[0:3], v[0:1], s[0:3], 0 format:[BUF_DATA_FORMAT_RESERVED_15,BUF_NUM_FORMAT_SSCALED] idxen offen offset:4092
; PREGFX10-NEXT:    s_waitcnt vmcnt(0)
; PREGFX10-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: tbuffer_load_voffset_large_16bit:
; GFX10:       ; %bb.0: ; %main_body
; GFX10-NEXT:    s_mov_b32 s4, 0
; GFX10-NEXT:    v_mov_b32_e32 v1, 0xf000
; GFX10-NEXT:    v_mov_b32_e32 v0, s4
; GFX10-NEXT:    tbuffer_load_format_xyzw v[0:3], v[0:1], s[0:3], 0 format:[BUF_FMT_32_32_SINT] idxen offen offset:4092
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    ; return to shader part epilog
;
; GFX11-LABEL: tbuffer_load_voffset_large_16bit:
; GFX11:       ; %bb.0: ; %main_body
; GFX11-NEXT:    s_mov_b32 s4, 0
; GFX11-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; GFX11-NEXT:    v_dual_mov_b32 v1, 0xf000 :: v_dual_mov_b32 v0, s4
; GFX11-NEXT:    tbuffer_load_format_xyzw v[0:3], v[0:1], s[0:3], 0 format:[BUF_FMT_32_32_32_32_FLOAT] idxen offen offset:4092
; GFX11-NEXT:    s_waitcnt vmcnt(0)
; GFX11-NEXT:    ; return to shader part epilog
main_body:
  %data = call <4 x float> @llvm.amdgcn.struct.ptr.tbuffer.load.v4f32(ptr addrspace(8) %0, i32 0, i32 65532, i32 0, i32 63, i32 0)
  ret <4 x float> %data
}

define amdgpu_ps <4 x float> @tbuffer_load_voffset_large_23bit(ptr addrspace(8) inreg) {
; PREGFX10-LABEL: tbuffer_load_voffset_large_23bit:
; PREGFX10:       ; %bb.0: ; %main_body
; PREGFX10-NEXT:    s_mov_b32 s4, 0
; PREGFX10-NEXT:    v_mov_b32_e32 v1, 0x7ff000
; PREGFX10-NEXT:    v_mov_b32_e32 v0, s4
; PREGFX10-NEXT:    tbuffer_load_format_xyzw v[0:3], v[0:1], s[0:3], 0 format:[BUF_DATA_FORMAT_RESERVED_15,BUF_NUM_FORMAT_SSCALED] idxen offen offset:4092
; PREGFX10-NEXT:    s_waitcnt vmcnt(0)
; PREGFX10-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: tbuffer_load_voffset_large_23bit:
; GFX10:       ; %bb.0: ; %main_body
; GFX10-NEXT:    s_mov_b32 s4, 0
; GFX10-NEXT:    v_mov_b32_e32 v1, 0x7ff000
; GFX10-NEXT:    v_mov_b32_e32 v0, s4
; GFX10-NEXT:    tbuffer_load_format_xyzw v[0:3], v[0:1], s[0:3], 0 format:[BUF_FMT_32_32_SINT] idxen offen offset:4092
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    ; return to shader part epilog
;
; GFX11-LABEL: tbuffer_load_voffset_large_23bit:
; GFX11:       ; %bb.0: ; %main_body
; GFX11-NEXT:    s_mov_b32 s4, 0
; GFX11-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; GFX11-NEXT:    v_dual_mov_b32 v1, 0x7ff000 :: v_dual_mov_b32 v0, s4
; GFX11-NEXT:    tbuffer_load_format_xyzw v[0:3], v[0:1], s[0:3], 0 format:[BUF_FMT_32_32_32_32_FLOAT] idxen offen offset:4092
; GFX11-NEXT:    s_waitcnt vmcnt(0)
; GFX11-NEXT:    ; return to shader part epilog
main_body:
  %data = call <4 x float> @llvm.amdgcn.struct.ptr.tbuffer.load.v4f32(ptr addrspace(8) %0, i32 0, i32 8388604, i32 0, i32 63, i32 0)
  ret <4 x float> %data
}

define amdgpu_ps <4 x float> @tbuffer_load_voffset_large_24bit(ptr addrspace(8) inreg) {
; PREGFX10-LABEL: tbuffer_load_voffset_large_24bit:
; PREGFX10:       ; %bb.0: ; %main_body
; PREGFX10-NEXT:    s_mov_b32 s4, 0
; PREGFX10-NEXT:    v_mov_b32_e32 v1, 0xfff000
; PREGFX10-NEXT:    v_mov_b32_e32 v0, s4
; PREGFX10-NEXT:    tbuffer_load_format_xyzw v[0:3], v[0:1], s[0:3], 0 format:[BUF_DATA_FORMAT_RESERVED_15,BUF_NUM_FORMAT_SSCALED] idxen offen offset:4092
; PREGFX10-NEXT:    s_waitcnt vmcnt(0)
; PREGFX10-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: tbuffer_load_voffset_large_24bit:
; GFX10:       ; %bb.0: ; %main_body
; GFX10-NEXT:    s_mov_b32 s4, 0
; GFX10-NEXT:    v_mov_b32_e32 v1, 0xfff000
; GFX10-NEXT:    v_mov_b32_e32 v0, s4
; GFX10-NEXT:    tbuffer_load_format_xyzw v[0:3], v[0:1], s[0:3], 0 format:[BUF_FMT_32_32_SINT] idxen offen offset:4092
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    ; return to shader part epilog
;
; GFX11-LABEL: tbuffer_load_voffset_large_24bit:
; GFX11:       ; %bb.0: ; %main_body
; GFX11-NEXT:    s_mov_b32 s4, 0
; GFX11-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; GFX11-NEXT:    v_dual_mov_b32 v1, 0xfff000 :: v_dual_mov_b32 v0, s4
; GFX11-NEXT:    tbuffer_load_format_xyzw v[0:3], v[0:1], s[0:3], 0 format:[BUF_FMT_32_32_32_32_FLOAT] idxen offen offset:4092
; GFX11-NEXT:    s_waitcnt vmcnt(0)
; GFX11-NEXT:    ; return to shader part epilog
main_body:
  %data = call <4 x float> @llvm.amdgcn.struct.ptr.tbuffer.load.v4f32(ptr addrspace(8) %0, i32 0, i32 16777212, i32 0, i32 63, i32 0)
  ret <4 x float> %data
}

declare i32 @llvm.amdgcn.struct.ptr.tbuffer.load.i32(ptr addrspace(8), i32, i32, i32, i32, i32)
declare <2 x i32> @llvm.amdgcn.struct.ptr.tbuffer.load.v2i32(ptr addrspace(8), i32, i32, i32, i32, i32)
declare <4 x i32> @llvm.amdgcn.struct.ptr.tbuffer.load.v4i32(ptr addrspace(8), i32, i32, i32, i32, i32)
declare <4 x float> @llvm.amdgcn.struct.ptr.tbuffer.load.v4f32(ptr addrspace(8), i32, i32, i32, i32, i32)
