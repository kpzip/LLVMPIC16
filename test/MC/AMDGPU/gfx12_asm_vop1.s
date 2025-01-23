// RUN: llvm-mc -triple=amdgcn -mcpu=gfx1200 -mattr=+wavefrontsize32 -show-encoding %s | FileCheck --strict-whitespace --check-prefixes=GFX12,GFX12-ASM %s
// RUN: llvm-mc -triple=amdgcn -mcpu=gfx1200 -mattr=+wavefrontsize32 -show-encoding %s | %extract-encodings | llvm-mc -triple=amdgcn -mcpu=gfx1200 -mattr=+wavefrontsize32,-wavefrontsize64 -disassemble -show-encoding | FileCheck --strict-whitespace --check-prefixes=GFX12,GFX12-DIS %s
// RUN: llvm-mc -triple=amdgcn -mcpu=gfx1200 -mattr=+wavefrontsize64 -show-encoding %s | FileCheck --strict-whitespace --check-prefixes=GFX12,GFX12-ASM %s
// RUN: llvm-mc -triple=amdgcn -mcpu=gfx1200 -mattr=+wavefrontsize64 -show-encoding %s | %extract-encodings | llvm-mc -triple=amdgcn -mcpu=gfx1200 -mattr=-wavefrontsize32,+wavefrontsize64 -disassemble -show-encoding | FileCheck --strict-whitespace --check-prefixes=GFX12,GFX12-DIS %s

v_bfrev_b32_e32 v5, v1
// GFX12: v_bfrev_b32_e32 v5, v1                  ; encoding: [0x01,0x71,0x0a,0x7e]

v_bfrev_b32 v5, v255
// GFX12: v_bfrev_b32_e32 v5, v255                ; encoding: [0xff,0x71,0x0a,0x7e]

v_bfrev_b32 v5, s1
// GFX12: v_bfrev_b32_e32 v5, s1                  ; encoding: [0x01,0x70,0x0a,0x7e]

v_bfrev_b32 v5, s105
// GFX12: v_bfrev_b32_e32 v5, s105                ; encoding: [0x69,0x70,0x0a,0x7e]

v_bfrev_b32 v5, vcc_lo
// GFX12: v_bfrev_b32_e32 v5, vcc_lo              ; encoding: [0x6a,0x70,0x0a,0x7e]

v_bfrev_b32 v5, vcc_hi
// GFX12: v_bfrev_b32_e32 v5, vcc_hi              ; encoding: [0x6b,0x70,0x0a,0x7e]

v_bfrev_b32 v5, ttmp15
// GFX12: v_bfrev_b32_e32 v5, ttmp15              ; encoding: [0x7b,0x70,0x0a,0x7e]

v_bfrev_b32 v5, m0
// GFX12: v_bfrev_b32_e32 v5, m0                  ; encoding: [0x7d,0x70,0x0a,0x7e]

v_bfrev_b32 v5, exec_lo
// GFX12: v_bfrev_b32_e32 v5, exec_lo             ; encoding: [0x7e,0x70,0x0a,0x7e]

v_bfrev_b32 v5, exec_hi
// GFX12: v_bfrev_b32_e32 v5, exec_hi             ; encoding: [0x7f,0x70,0x0a,0x7e]

v_bfrev_b32 v5, null
// GFX12: v_bfrev_b32_e32 v5, null                ; encoding: [0x7c,0x70,0x0a,0x7e]

v_bfrev_b32 v5, -1
// GFX12: v_bfrev_b32_e32 v5, -1                  ; encoding: [0xc1,0x70,0x0a,0x7e]

v_bfrev_b32 v5, 0.5
// GFX12: v_bfrev_b32_e32 v5, 0.5                 ; encoding: [0xf0,0x70,0x0a,0x7e]

v_bfrev_b32 v5, src_scc
// GFX12: v_bfrev_b32_e32 v5, src_scc             ; encoding: [0xfd,0x70,0x0a,0x7e]

v_bfrev_b32 v255, 0xaf123456
// GFX12: v_bfrev_b32_e32 v255, 0xaf123456        ; encoding: [0xff,0x70,0xfe,0x7f,0x56,0x34,0x12,0xaf]

v_ceil_f16 v5, v1
// GFX12: v_ceil_f16_e32 v5, v1                   ; encoding: [0x01,0xb9,0x0a,0x7e]

v_ceil_f16 v5, v127
// GFX12: v_ceil_f16_e32 v5, v127                 ; encoding: [0x7f,0xb9,0x0a,0x7e]

v_ceil_f16 v5, s1
// GFX12: v_ceil_f16_e32 v5, s1                   ; encoding: [0x01,0xb8,0x0a,0x7e]

v_ceil_f16 v5, s105
// GFX12: v_ceil_f16_e32 v5, s105                 ; encoding: [0x69,0xb8,0x0a,0x7e]

v_ceil_f16 v5, vcc_lo
// GFX12: v_ceil_f16_e32 v5, vcc_lo               ; encoding: [0x6a,0xb8,0x0a,0x7e]

v_ceil_f16 v5, vcc_hi
// GFX12: v_ceil_f16_e32 v5, vcc_hi               ; encoding: [0x6b,0xb8,0x0a,0x7e]

v_ceil_f16 v5, ttmp15
// GFX12: v_ceil_f16_e32 v5, ttmp15               ; encoding: [0x7b,0xb8,0x0a,0x7e]

v_ceil_f16 v5, m0
// GFX12: v_ceil_f16_e32 v5, m0                   ; encoding: [0x7d,0xb8,0x0a,0x7e]

v_ceil_f16 v5, exec_lo
// GFX12: v_ceil_f16_e32 v5, exec_lo              ; encoding: [0x7e,0xb8,0x0a,0x7e]

v_ceil_f16 v5, exec_hi
// GFX12: v_ceil_f16_e32 v5, exec_hi              ; encoding: [0x7f,0xb8,0x0a,0x7e]

v_ceil_f16 v5, null
// GFX12: v_ceil_f16_e32 v5, null                 ; encoding: [0x7c,0xb8,0x0a,0x7e]

v_ceil_f16 v5, -1
// GFX12: v_ceil_f16_e32 v5, -1                   ; encoding: [0xc1,0xb8,0x0a,0x7e]

v_ceil_f16 v5, 0.5
// GFX12: v_ceil_f16_e32 v5, 0.5                  ; encoding: [0xf0,0xb8,0x0a,0x7e]

v_ceil_f16 v5, src_scc
// GFX12: v_ceil_f16_e32 v5, src_scc              ; encoding: [0xfd,0xb8,0x0a,0x7e]

v_ceil_f16 v127, 0xfe0b
// GFX12: v_ceil_f16_e32 v127, 0xfe0b             ; encoding: [0xff,0xb8,0xfe,0x7e,0x0b,0xfe,0x00,0x00]

v_ceil_f32 v5, v1
// GFX12: v_ceil_f32_e32 v5, v1                   ; encoding: [0x01,0x45,0x0a,0x7e]

v_ceil_f32 v5, v255
// GFX12: v_ceil_f32_e32 v5, v255                 ; encoding: [0xff,0x45,0x0a,0x7e]

v_ceil_f32 v5, s1
// GFX12: v_ceil_f32_e32 v5, s1                   ; encoding: [0x01,0x44,0x0a,0x7e]

v_ceil_f32 v5, s105
// GFX12: v_ceil_f32_e32 v5, s105                 ; encoding: [0x69,0x44,0x0a,0x7e]

v_ceil_f32 v5, vcc_lo
// GFX12: v_ceil_f32_e32 v5, vcc_lo               ; encoding: [0x6a,0x44,0x0a,0x7e]

v_ceil_f32 v5, vcc_hi
// GFX12: v_ceil_f32_e32 v5, vcc_hi               ; encoding: [0x6b,0x44,0x0a,0x7e]

v_ceil_f32 v5, ttmp15
// GFX12: v_ceil_f32_e32 v5, ttmp15               ; encoding: [0x7b,0x44,0x0a,0x7e]

v_ceil_f32 v5, m0
// GFX12: v_ceil_f32_e32 v5, m0                   ; encoding: [0x7d,0x44,0x0a,0x7e]

v_ceil_f32 v5, exec_lo
// GFX12: v_ceil_f32_e32 v5, exec_lo              ; encoding: [0x7e,0x44,0x0a,0x7e]

v_ceil_f32 v5, exec_hi
// GFX12: v_ceil_f32_e32 v5, exec_hi              ; encoding: [0x7f,0x44,0x0a,0x7e]

v_ceil_f32 v5, null
// GFX12: v_ceil_f32_e32 v5, null                 ; encoding: [0x7c,0x44,0x0a,0x7e]

v_ceil_f32 v5, -1
// GFX12: v_ceil_f32_e32 v5, -1                   ; encoding: [0xc1,0x44,0x0a,0x7e]

v_ceil_f32 v5, 0.5
// GFX12: v_ceil_f32_e32 v5, 0.5                  ; encoding: [0xf0,0x44,0x0a,0x7e]

v_ceil_f32 v5, src_scc
// GFX12: v_ceil_f32_e32 v5, src_scc              ; encoding: [0xfd,0x44,0x0a,0x7e]

v_ceil_f32 v255, 0xaf123456
// GFX12: v_ceil_f32_e32 v255, 0xaf123456         ; encoding: [0xff,0x44,0xfe,0x7f,0x56,0x34,0x12,0xaf]

v_ceil_f64 v[5:6], v[1:2]
// GFX12: v_ceil_f64_e32 v[5:6], v[1:2]           ; encoding: [0x01,0x31,0x0a,0x7e]

v_ceil_f64 v[5:6], v[254:255]
// GFX12: v_ceil_f64_e32 v[5:6], v[254:255]       ; encoding: [0xfe,0x31,0x0a,0x7e]

v_ceil_f64 v[5:6], s[2:3]
// GFX12: v_ceil_f64_e32 v[5:6], s[2:3]           ; encoding: [0x02,0x30,0x0a,0x7e]

v_ceil_f64 v[5:6], s[104:105]
// GFX12: v_ceil_f64_e32 v[5:6], s[104:105]       ; encoding: [0x68,0x30,0x0a,0x7e]

v_ceil_f64 v[5:6], vcc
// GFX12: v_ceil_f64_e32 v[5:6], vcc              ; encoding: [0x6a,0x30,0x0a,0x7e]

v_ceil_f64 v[5:6], ttmp[14:15]
// GFX12: v_ceil_f64_e32 v[5:6], ttmp[14:15]      ; encoding: [0x7a,0x30,0x0a,0x7e]

v_ceil_f64 v[5:6], exec
// GFX12: v_ceil_f64_e32 v[5:6], exec             ; encoding: [0x7e,0x30,0x0a,0x7e]

v_ceil_f64 v[5:6], null
// GFX12: v_ceil_f64_e32 v[5:6], null             ; encoding: [0x7c,0x30,0x0a,0x7e]

v_ceil_f64 v[5:6], -1
// GFX12: v_ceil_f64_e32 v[5:6], -1               ; encoding: [0xc1,0x30,0x0a,0x7e]

v_ceil_f64 v[5:6], 0.5
// GFX12: v_ceil_f64_e32 v[5:6], 0.5              ; encoding: [0xf0,0x30,0x0a,0x7e]

v_ceil_f64 v[5:6], src_scc
// GFX12: v_ceil_f64_e32 v[5:6], src_scc          ; encoding: [0xfd,0x30,0x0a,0x7e]

v_ceil_f64 v[254:255], 0xaf123456
// GFX12: v_ceil_f64_e32 v[254:255], 0xaf123456   ; encoding: [0xff,0x30,0xfc,0x7f,0x56,0x34,0x12,0xaf]

v_cls_i32 v5, v1
// GFX12: v_cls_i32_e32 v5, v1                    ; encoding: [0x01,0x77,0x0a,0x7e]

v_cls_i32 v5, v255
// GFX12: v_cls_i32_e32 v5, v255                  ; encoding: [0xff,0x77,0x0a,0x7e]

v_cls_i32 v5, s1
// GFX12: v_cls_i32_e32 v5, s1                    ; encoding: [0x01,0x76,0x0a,0x7e]

v_cls_i32 v5, s105
// GFX12: v_cls_i32_e32 v5, s105                  ; encoding: [0x69,0x76,0x0a,0x7e]

v_cls_i32 v5, vcc_lo
// GFX12: v_cls_i32_e32 v5, vcc_lo                ; encoding: [0x6a,0x76,0x0a,0x7e]

v_cls_i32 v5, vcc_hi
// GFX12: v_cls_i32_e32 v5, vcc_hi                ; encoding: [0x6b,0x76,0x0a,0x7e]

v_cls_i32 v5, ttmp15
// GFX12: v_cls_i32_e32 v5, ttmp15                ; encoding: [0x7b,0x76,0x0a,0x7e]

v_cls_i32 v5, m0
// GFX12: v_cls_i32_e32 v5, m0                    ; encoding: [0x7d,0x76,0x0a,0x7e]

v_cls_i32 v5, exec_lo
// GFX12: v_cls_i32_e32 v5, exec_lo               ; encoding: [0x7e,0x76,0x0a,0x7e]

v_cls_i32 v5, exec_hi
// GFX12: v_cls_i32_e32 v5, exec_hi               ; encoding: [0x7f,0x76,0x0a,0x7e]

v_cls_i32 v5, null
// GFX12: v_cls_i32_e32 v5, null                  ; encoding: [0x7c,0x76,0x0a,0x7e]

v_cls_i32 v5, -1
// GFX12: v_cls_i32_e32 v5, -1                    ; encoding: [0xc1,0x76,0x0a,0x7e]

v_cls_i32 v5, 0.5
// GFX12: v_cls_i32_e32 v5, 0.5                   ; encoding: [0xf0,0x76,0x0a,0x7e]

v_cls_i32 v5, src_scc
// GFX12: v_cls_i32_e32 v5, src_scc               ; encoding: [0xfd,0x76,0x0a,0x7e]

v_cls_i32 v255, 0xaf123456
// GFX12: v_cls_i32_e32 v255, 0xaf123456          ; encoding: [0xff,0x76,0xfe,0x7f,0x56,0x34,0x12,0xaf]

v_clz_i32_u32 v5, v1
// GFX12: v_clz_i32_u32_e32 v5, v1                ; encoding: [0x01,0x73,0x0a,0x7e]

v_clz_i32_u32 v5, v255
// GFX12: v_clz_i32_u32_e32 v5, v255              ; encoding: [0xff,0x73,0x0a,0x7e]

v_clz_i32_u32 v5, s1
// GFX12: v_clz_i32_u32_e32 v5, s1                ; encoding: [0x01,0x72,0x0a,0x7e]

v_clz_i32_u32 v5, s105
// GFX12: v_clz_i32_u32_e32 v5, s105              ; encoding: [0x69,0x72,0x0a,0x7e]

v_clz_i32_u32 v5, vcc_lo
// GFX12: v_clz_i32_u32_e32 v5, vcc_lo            ; encoding: [0x6a,0x72,0x0a,0x7e]

v_clz_i32_u32 v5, vcc_hi
// GFX12: v_clz_i32_u32_e32 v5, vcc_hi            ; encoding: [0x6b,0x72,0x0a,0x7e]

v_clz_i32_u32 v5, ttmp15
// GFX12: v_clz_i32_u32_e32 v5, ttmp15            ; encoding: [0x7b,0x72,0x0a,0x7e]

v_clz_i32_u32 v5, m0
// GFX12: v_clz_i32_u32_e32 v5, m0                ; encoding: [0x7d,0x72,0x0a,0x7e]

v_clz_i32_u32 v5, exec_lo
// GFX12: v_clz_i32_u32_e32 v5, exec_lo           ; encoding: [0x7e,0x72,0x0a,0x7e]

v_clz_i32_u32 v5, exec_hi
// GFX12: v_clz_i32_u32_e32 v5, exec_hi           ; encoding: [0x7f,0x72,0x0a,0x7e]

v_clz_i32_u32 v5, null
// GFX12: v_clz_i32_u32_e32 v5, null              ; encoding: [0x7c,0x72,0x0a,0x7e]

v_clz_i32_u32 v5, -1
// GFX12: v_clz_i32_u32_e32 v5, -1                ; encoding: [0xc1,0x72,0x0a,0x7e]

v_clz_i32_u32 v5, 0.5
// GFX12: v_clz_i32_u32_e32 v5, 0.5               ; encoding: [0xf0,0x72,0x0a,0x7e]

v_clz_i32_u32 v5, src_scc
// GFX12: v_clz_i32_u32_e32 v5, src_scc           ; encoding: [0xfd,0x72,0x0a,0x7e]

v_clz_i32_u32 v255, 0xaf123456
// GFX12: v_clz_i32_u32_e32 v255, 0xaf123456      ; encoding: [0xff,0x72,0xfe,0x7f,0x56,0x34,0x12,0xaf]

v_cos_f16 v5, v1
// GFX12: v_cos_f16_e32 v5, v1                    ; encoding: [0x01,0xc3,0x0a,0x7e]

v_cos_f16 v5, v127
// GFX12: v_cos_f16_e32 v5, v127                  ; encoding: [0x7f,0xc3,0x0a,0x7e]

v_cos_f16 v5, s1
// GFX12: v_cos_f16_e32 v5, s1                    ; encoding: [0x01,0xc2,0x0a,0x7e]

v_cos_f16 v5, s105
// GFX12: v_cos_f16_e32 v5, s105                  ; encoding: [0x69,0xc2,0x0a,0x7e]

v_cos_f16 v5, vcc_lo
// GFX12: v_cos_f16_e32 v5, vcc_lo                ; encoding: [0x6a,0xc2,0x0a,0x7e]

v_cos_f16 v5, vcc_hi
// GFX12: v_cos_f16_e32 v5, vcc_hi                ; encoding: [0x6b,0xc2,0x0a,0x7e]

v_cos_f16 v5, ttmp15
// GFX12: v_cos_f16_e32 v5, ttmp15                ; encoding: [0x7b,0xc2,0x0a,0x7e]

v_cos_f16 v5, m0
// GFX12: v_cos_f16_e32 v5, m0                    ; encoding: [0x7d,0xc2,0x0a,0x7e]

v_cos_f16 v5, exec_lo
// GFX12: v_cos_f16_e32 v5, exec_lo               ; encoding: [0x7e,0xc2,0x0a,0x7e]

v_cos_f16 v5, exec_hi
// GFX12: v_cos_f16_e32 v5, exec_hi               ; encoding: [0x7f,0xc2,0x0a,0x7e]

v_cos_f16 v5, null
// GFX12: v_cos_f16_e32 v5, null                  ; encoding: [0x7c,0xc2,0x0a,0x7e]

v_cos_f16 v5, -1
// GFX12: v_cos_f16_e32 v5, -1                    ; encoding: [0xc1,0xc2,0x0a,0x7e]

v_cos_f16 v5, 0.5
// GFX12: v_cos_f16_e32 v5, 0.5                   ; encoding: [0xf0,0xc2,0x0a,0x7e]

v_cos_f16 v5, src_scc
// GFX12: v_cos_f16_e32 v5, src_scc               ; encoding: [0xfd,0xc2,0x0a,0x7e]

v_cos_f16 v127, 0xfe0b
// GFX12: v_cos_f16_e32 v127, 0xfe0b              ; encoding: [0xff,0xc2,0xfe,0x7e,0x0b,0xfe,0x00,0x00]

v_cos_f32 v5, v1
// GFX12: v_cos_f32_e32 v5, v1                    ; encoding: [0x01,0x6d,0x0a,0x7e]

v_cos_f32 v5, v255
// GFX12: v_cos_f32_e32 v5, v255                  ; encoding: [0xff,0x6d,0x0a,0x7e]

v_cos_f32 v5, s1
// GFX12: v_cos_f32_e32 v5, s1                    ; encoding: [0x01,0x6c,0x0a,0x7e]

v_cos_f32 v5, s105
// GFX12: v_cos_f32_e32 v5, s105                  ; encoding: [0x69,0x6c,0x0a,0x7e]

v_cos_f32 v5, vcc_lo
// GFX12: v_cos_f32_e32 v5, vcc_lo                ; encoding: [0x6a,0x6c,0x0a,0x7e]

v_cos_f32 v5, vcc_hi
// GFX12: v_cos_f32_e32 v5, vcc_hi                ; encoding: [0x6b,0x6c,0x0a,0x7e]

v_cos_f32 v5, ttmp15
// GFX12: v_cos_f32_e32 v5, ttmp15                ; encoding: [0x7b,0x6c,0x0a,0x7e]

v_cos_f32 v5, m0
// GFX12: v_cos_f32_e32 v5, m0                    ; encoding: [0x7d,0x6c,0x0a,0x7e]

v_cos_f32 v5, exec_lo
// GFX12: v_cos_f32_e32 v5, exec_lo               ; encoding: [0x7e,0x6c,0x0a,0x7e]

v_cos_f32 v5, exec_hi
// GFX12: v_cos_f32_e32 v5, exec_hi               ; encoding: [0x7f,0x6c,0x0a,0x7e]

v_cos_f32 v5, null
// GFX12: v_cos_f32_e32 v5, null                  ; encoding: [0x7c,0x6c,0x0a,0x7e]

v_cos_f32 v5, -1
// GFX12: v_cos_f32_e32 v5, -1                    ; encoding: [0xc1,0x6c,0x0a,0x7e]

v_cos_f32 v5, 0.5
// GFX12: v_cos_f32_e32 v5, 0.5                   ; encoding: [0xf0,0x6c,0x0a,0x7e]

v_cos_f32 v5, src_scc
// GFX12: v_cos_f32_e32 v5, src_scc               ; encoding: [0xfd,0x6c,0x0a,0x7e]

v_cos_f32 v255, 0xaf123456
// GFX12: v_cos_f32_e32 v255, 0xaf123456          ; encoding: [0xff,0x6c,0xfe,0x7f,0x56,0x34,0x12,0xaf]

v_ctz_i32_b32 v5, v1
// GFX12: v_ctz_i32_b32_e32 v5, v1                ; encoding: [0x01,0x75,0x0a,0x7e]

v_ctz_i32_b32 v5, v255
// GFX12: v_ctz_i32_b32_e32 v5, v255              ; encoding: [0xff,0x75,0x0a,0x7e]

v_ctz_i32_b32 v5, s1
// GFX12: v_ctz_i32_b32_e32 v5, s1                ; encoding: [0x01,0x74,0x0a,0x7e]

v_ctz_i32_b32 v5, s105
// GFX12: v_ctz_i32_b32_e32 v5, s105              ; encoding: [0x69,0x74,0x0a,0x7e]

v_ctz_i32_b32 v5, vcc_lo
// GFX12: v_ctz_i32_b32_e32 v5, vcc_lo            ; encoding: [0x6a,0x74,0x0a,0x7e]

v_ctz_i32_b32 v5, vcc_hi
// GFX12: v_ctz_i32_b32_e32 v5, vcc_hi            ; encoding: [0x6b,0x74,0x0a,0x7e]

v_ctz_i32_b32 v5, ttmp15
// GFX12: v_ctz_i32_b32_e32 v5, ttmp15            ; encoding: [0x7b,0x74,0x0a,0x7e]

v_ctz_i32_b32 v5, m0
// GFX12: v_ctz_i32_b32_e32 v5, m0                ; encoding: [0x7d,0x74,0x0a,0x7e]

v_ctz_i32_b32 v5, exec_lo
// GFX12: v_ctz_i32_b32_e32 v5, exec_lo           ; encoding: [0x7e,0x74,0x0a,0x7e]

v_ctz_i32_b32 v5, exec_hi
// GFX12: v_ctz_i32_b32_e32 v5, exec_hi           ; encoding: [0x7f,0x74,0x0a,0x7e]

v_ctz_i32_b32 v5, null
// GFX12: v_ctz_i32_b32_e32 v5, null              ; encoding: [0x7c,0x74,0x0a,0x7e]

v_ctz_i32_b32 v5, -1
// GFX12: v_ctz_i32_b32_e32 v5, -1                ; encoding: [0xc1,0x74,0x0a,0x7e]

v_ctz_i32_b32 v5, 0.5
// GFX12: v_ctz_i32_b32_e32 v5, 0.5               ; encoding: [0xf0,0x74,0x0a,0x7e]

v_ctz_i32_b32 v5, src_scc
// GFX12: v_ctz_i32_b32_e32 v5, src_scc           ; encoding: [0xfd,0x74,0x0a,0x7e]

v_ctz_i32_b32 v255, 0xaf123456
// GFX12: v_ctz_i32_b32_e32 v255, 0xaf123456      ; encoding: [0xff,0x74,0xfe,0x7f,0x56,0x34,0x12,0xaf]

v_cvt_f32_bf8_e32 v1, s3
// GFX12: v_cvt_f32_bf8_e32 v1, s3                ; encoding: [0x03,0xda,0x02,0x7e]

v_cvt_f32_bf8_e32 v1, 3
// GFX12: v_cvt_f32_bf8_e32 v1, 3                 ; encoding: [0x83,0xda,0x02,0x7e]

v_cvt_f32_bf8_e32 v1, v3
// GFX12: v_cvt_f32_bf8_e32 v1, v3                ; encoding: [0x03,0xdb,0x02,0x7e]

v_cvt_f32_fp8_e32 v1, s3
// GFX12: v_cvt_f32_fp8_e32 v1, s3                ; encoding: [0x03,0xd8,0x02,0x7e]

v_cvt_f32_fp8_e32 v1, 3
// GFX12: v_cvt_f32_fp8_e32 v1, 3                 ; encoding: [0x83,0xd8,0x02,0x7e]

v_cvt_f32_fp8_e32 v1, v3
// GFX12: v_cvt_f32_fp8_e32 v1, v3                ; encoding: [0x03,0xd9,0x02,0x7e]

v_cvt_pk_f32_bf8_e32 v[2:3], s3
// GFX12: v_cvt_pk_f32_bf8_e32 v[2:3], s3         ; encoding: [0x03,0xde,0x04,0x7e]

v_cvt_pk_f32_bf8_e32 v[3:4], s5
// GFX12: v_cvt_pk_f32_bf8_e32 v[3:4], s5         ; encoding: [0x05,0xde,0x06,0x7e]

v_cvt_pk_f32_bf8_e32 v[2:3], 3
// GFX12: v_cvt_pk_f32_bf8_e32 v[2:3], 3          ; encoding: [0x83,0xde,0x04,0x7e]

v_cvt_pk_f32_bf8_e32 v[3:4], 3
// GFX12: v_cvt_pk_f32_bf8_e32 v[3:4], 3          ; encoding: [0x83,0xde,0x06,0x7e]

v_cvt_pk_f32_bf8_e32 v[2:3], v3
// GFX12: v_cvt_pk_f32_bf8_e32 v[2:3], v3         ; encoding: [0x03,0xdf,0x04,0x7e]

v_cvt_pk_f32_bf8_e32 v[3:4], v3
// GFX12: v_cvt_pk_f32_bf8_e32 v[3:4], v3         ; encoding: [0x03,0xdf,0x06,0x7e]

v_cvt_pk_f32_fp8_e32 v[2:3], s3
// GFX12: v_cvt_pk_f32_fp8_e32 v[2:3], s3         ; encoding: [0x03,0xdc,0x04,0x7e]

v_cvt_pk_f32_fp8_e32 v[2:3], 3
// GFX12: v_cvt_pk_f32_fp8_e32 v[2:3], 3          ; encoding: [0x83,0xdc,0x04,0x7e]

v_cvt_pk_f32_fp8_e32 v[2:3], v3
// GFX12: v_cvt_pk_f32_fp8_e32 v[2:3], v3         ; encoding: [0x03,0xdd,0x04,0x7e]

v_cvt_f16_f32 v5, v1
// GFX12: v_cvt_f16_f32_e32 v5, v1                ; encoding: [0x01,0x15,0x0a,0x7e]

v_cvt_f16_f32 v5, v255
// GFX12: v_cvt_f16_f32_e32 v5, v255              ; encoding: [0xff,0x15,0x0a,0x7e]

v_cvt_f16_f32 v5, s1
// GFX12: v_cvt_f16_f32_e32 v5, s1                ; encoding: [0x01,0x14,0x0a,0x7e]

v_cvt_f16_f32 v5, s105
// GFX12: v_cvt_f16_f32_e32 v5, s105              ; encoding: [0x69,0x14,0x0a,0x7e]

v_cvt_f16_f32 v5, vcc_lo
// GFX12: v_cvt_f16_f32_e32 v5, vcc_lo            ; encoding: [0x6a,0x14,0x0a,0x7e]

v_cvt_f16_f32 v5, vcc_hi
// GFX12: v_cvt_f16_f32_e32 v5, vcc_hi            ; encoding: [0x6b,0x14,0x0a,0x7e]

v_cvt_f16_f32 v5, ttmp15
// GFX12: v_cvt_f16_f32_e32 v5, ttmp15            ; encoding: [0x7b,0x14,0x0a,0x7e]

v_cvt_f16_f32 v5, m0
// GFX12: v_cvt_f16_f32_e32 v5, m0                ; encoding: [0x7d,0x14,0x0a,0x7e]

v_cvt_f16_f32 v5, exec_lo
// GFX12: v_cvt_f16_f32_e32 v5, exec_lo           ; encoding: [0x7e,0x14,0x0a,0x7e]

v_cvt_f16_f32 v5, exec_hi
// GFX12: v_cvt_f16_f32_e32 v5, exec_hi           ; encoding: [0x7f,0x14,0x0a,0x7e]

v_cvt_f16_f32 v5, null
// GFX12: v_cvt_f16_f32_e32 v5, null              ; encoding: [0x7c,0x14,0x0a,0x7e]

v_cvt_f16_f32 v5, -1
// GFX12: v_cvt_f16_f32_e32 v5, -1                ; encoding: [0xc1,0x14,0x0a,0x7e]

v_cvt_f16_f32 v5, 0.5
// GFX12: v_cvt_f16_f32_e32 v5, 0.5               ; encoding: [0xf0,0x14,0x0a,0x7e]

v_cvt_f16_f32 v5, src_scc
// GFX12: v_cvt_f16_f32_e32 v5, src_scc           ; encoding: [0xfd,0x14,0x0a,0x7e]

v_cvt_f16_f32 v127, 0xaf123456
// GFX12: v_cvt_f16_f32_e32 v127, 0xaf123456      ; encoding: [0xff,0x14,0xfe,0x7e,0x56,0x34,0x12,0xaf]

v_cvt_f16_i16 v5, v1
// GFX12: v_cvt_f16_i16_e32 v5, v1                ; encoding: [0x01,0xa3,0x0a,0x7e]

v_cvt_f16_i16 v5, v127
// GFX12: v_cvt_f16_i16_e32 v5, v127              ; encoding: [0x7f,0xa3,0x0a,0x7e]

v_cvt_f16_i16 v5, s1
// GFX12: v_cvt_f16_i16_e32 v5, s1                ; encoding: [0x01,0xa2,0x0a,0x7e]

v_cvt_f16_i16 v5, s105
// GFX12: v_cvt_f16_i16_e32 v5, s105              ; encoding: [0x69,0xa2,0x0a,0x7e]

v_cvt_f16_i16 v5, vcc_lo
// GFX12: v_cvt_f16_i16_e32 v5, vcc_lo            ; encoding: [0x6a,0xa2,0x0a,0x7e]

v_cvt_f16_i16 v5, vcc_hi
// GFX12: v_cvt_f16_i16_e32 v5, vcc_hi            ; encoding: [0x6b,0xa2,0x0a,0x7e]

v_cvt_f16_i16 v5, ttmp15
// GFX12: v_cvt_f16_i16_e32 v5, ttmp15            ; encoding: [0x7b,0xa2,0x0a,0x7e]

v_cvt_f16_i16 v5, m0
// GFX12: v_cvt_f16_i16_e32 v5, m0                ; encoding: [0x7d,0xa2,0x0a,0x7e]

v_cvt_f16_i16 v5, exec_lo
// GFX12: v_cvt_f16_i16_e32 v5, exec_lo           ; encoding: [0x7e,0xa2,0x0a,0x7e]

v_cvt_f16_i16 v5, exec_hi
// GFX12: v_cvt_f16_i16_e32 v5, exec_hi           ; encoding: [0x7f,0xa2,0x0a,0x7e]

v_cvt_f16_i16 v5, null
// GFX12: v_cvt_f16_i16_e32 v5, null              ; encoding: [0x7c,0xa2,0x0a,0x7e]

v_cvt_f16_i16 v5, -1
// GFX12: v_cvt_f16_i16_e32 v5, -1                ; encoding: [0xc1,0xa2,0x0a,0x7e]

v_cvt_f16_i16 v5, 0.5
// GFX12-ASM: v_cvt_f16_i16_e32 v5, 0.5               ; encoding: [0xf0,0xa2,0x0a,0x7e]
// GFX12-DIS: v_cvt_f16_i16_e32 v5, 0x3800            ; encoding: [0xff,0xa2,0x0a,0x7e,0x00,0x38,0x00,0x00]

v_cvt_f16_i16 v5, src_scc
// GFX12: v_cvt_f16_i16_e32 v5, src_scc           ; encoding: [0xfd,0xa2,0x0a,0x7e]

v_cvt_f16_i16 v127, 0xfe0b
// GFX12: v_cvt_f16_i16_e32 v127, 0xfe0b          ; encoding: [0xff,0xa2,0xfe,0x7e,0x0b,0xfe,0x00,0x00]

v_cvt_f16_u16 v5, v1
// GFX12: v_cvt_f16_u16_e32 v5, v1                ; encoding: [0x01,0xa1,0x0a,0x7e]

v_cvt_f16_u16 v5, v127
// GFX12: v_cvt_f16_u16_e32 v5, v127              ; encoding: [0x7f,0xa1,0x0a,0x7e]

v_cvt_f16_u16 v5, s1
// GFX12: v_cvt_f16_u16_e32 v5, s1                ; encoding: [0x01,0xa0,0x0a,0x7e]

v_cvt_f16_u16 v5, s105
// GFX12: v_cvt_f16_u16_e32 v5, s105              ; encoding: [0x69,0xa0,0x0a,0x7e]

v_cvt_f16_u16 v5, vcc_lo
// GFX12: v_cvt_f16_u16_e32 v5, vcc_lo            ; encoding: [0x6a,0xa0,0x0a,0x7e]

v_cvt_f16_u16 v5, vcc_hi
// GFX12: v_cvt_f16_u16_e32 v5, vcc_hi            ; encoding: [0x6b,0xa0,0x0a,0x7e]

v_cvt_f16_u16 v5, ttmp15
// GFX12: v_cvt_f16_u16_e32 v5, ttmp15            ; encoding: [0x7b,0xa0,0x0a,0x7e]

v_cvt_f16_u16 v5, m0
// GFX12: v_cvt_f16_u16_e32 v5, m0                ; encoding: [0x7d,0xa0,0x0a,0x7e]

v_cvt_f16_u16 v5, exec_lo
// GFX12: v_cvt_f16_u16_e32 v5, exec_lo           ; encoding: [0x7e,0xa0,0x0a,0x7e]

v_cvt_f16_u16 v5, exec_hi
// GFX12: v_cvt_f16_u16_e32 v5, exec_hi           ; encoding: [0x7f,0xa0,0x0a,0x7e]

v_cvt_f16_u16 v5, null
// GFX12: v_cvt_f16_u16_e32 v5, null              ; encoding: [0x7c,0xa0,0x0a,0x7e]

v_cvt_f16_u16 v5, -1
// GFX12: v_cvt_f16_u16_e32 v5, -1                ; encoding: [0xc1,0xa0,0x0a,0x7e]

v_cvt_f16_u16 v5, 0.5
// GFX12-ASM: v_cvt_f16_u16_e32 v5, 0.5               ; encoding: [0xf0,0xa0,0x0a,0x7e]
// GFX12-DIS: v_cvt_f16_u16_e32 v5, 0x3800            ; encoding: [0xff,0xa0,0x0a,0x7e,0x00,0x38,0x00,0x00]

v_cvt_f16_u16 v5, src_scc
// GFX12: v_cvt_f16_u16_e32 v5, src_scc           ; encoding: [0xfd,0xa0,0x0a,0x7e]

v_cvt_f16_u16 v127, 0xfe0b
// GFX12: v_cvt_f16_u16_e32 v127, 0xfe0b          ; encoding: [0xff,0xa0,0xfe,0x7e,0x0b,0xfe,0x00,0x00]

v_cvt_f32_f16 v5, v1
// GFX12: v_cvt_f32_f16_e32 v5, v1                ; encoding: [0x01,0x17,0x0a,0x7e]

v_cvt_f32_f16 v5, v127
// GFX12: v_cvt_f32_f16_e32 v5, v127              ; encoding: [0x7f,0x17,0x0a,0x7e]

v_cvt_f32_f16 v5, s1
// GFX12: v_cvt_f32_f16_e32 v5, s1                ; encoding: [0x01,0x16,0x0a,0x7e]

v_cvt_f32_f16 v5, s105
// GFX12: v_cvt_f32_f16_e32 v5, s105              ; encoding: [0x69,0x16,0x0a,0x7e]

v_cvt_f32_f16 v5, vcc_lo
// GFX12: v_cvt_f32_f16_e32 v5, vcc_lo            ; encoding: [0x6a,0x16,0x0a,0x7e]

v_cvt_f32_f16 v5, vcc_hi
// GFX12: v_cvt_f32_f16_e32 v5, vcc_hi            ; encoding: [0x6b,0x16,0x0a,0x7e]

v_cvt_f32_f16 v5, ttmp15
// GFX12: v_cvt_f32_f16_e32 v5, ttmp15            ; encoding: [0x7b,0x16,0x0a,0x7e]

v_cvt_f32_f16 v5, m0
// GFX12: v_cvt_f32_f16_e32 v5, m0                ; encoding: [0x7d,0x16,0x0a,0x7e]

v_cvt_f32_f16 v5, exec_lo
// GFX12: v_cvt_f32_f16_e32 v5, exec_lo           ; encoding: [0x7e,0x16,0x0a,0x7e]

v_cvt_f32_f16 v5, exec_hi
// GFX12: v_cvt_f32_f16_e32 v5, exec_hi           ; encoding: [0x7f,0x16,0x0a,0x7e]

v_cvt_f32_f16 v5, null
// GFX12: v_cvt_f32_f16_e32 v5, null              ; encoding: [0x7c,0x16,0x0a,0x7e]

v_cvt_f32_f16 v5, -1
// GFX12: v_cvt_f32_f16_e32 v5, -1                ; encoding: [0xc1,0x16,0x0a,0x7e]

v_cvt_f32_f16 v5, 0.5
// GFX12: v_cvt_f32_f16_e32 v5, 0.5               ; encoding: [0xf0,0x16,0x0a,0x7e]

v_cvt_f32_f16 v5, src_scc
// GFX12: v_cvt_f32_f16_e32 v5, src_scc           ; encoding: [0xfd,0x16,0x0a,0x7e]

v_cvt_f32_f16 v255, 0xfe0b
// GFX12: v_cvt_f32_f16_e32 v255, 0xfe0b          ; encoding: [0xff,0x16,0xfe,0x7f,0x0b,0xfe,0x00,0x00]

v_cvt_f32_f64 v5, v[1:2]
// GFX12: v_cvt_f32_f64_e32 v5, v[1:2]            ; encoding: [0x01,0x1f,0x0a,0x7e]

v_cvt_f32_f64 v5, v[254:255]
// GFX12: v_cvt_f32_f64_e32 v5, v[254:255]        ; encoding: [0xfe,0x1f,0x0a,0x7e]

v_cvt_f32_f64 v5, s[2:3]
// GFX12: v_cvt_f32_f64_e32 v5, s[2:3]            ; encoding: [0x02,0x1e,0x0a,0x7e]

v_cvt_f32_f64 v5, s[104:105]
// GFX12: v_cvt_f32_f64_e32 v5, s[104:105]        ; encoding: [0x68,0x1e,0x0a,0x7e]

v_cvt_f32_f64 v5, vcc
// GFX12: v_cvt_f32_f64_e32 v5, vcc               ; encoding: [0x6a,0x1e,0x0a,0x7e]

v_cvt_f32_f64 v5, ttmp[14:15]
// GFX12: v_cvt_f32_f64_e32 v5, ttmp[14:15]       ; encoding: [0x7a,0x1e,0x0a,0x7e]

v_cvt_f32_f64 v5, exec
// GFX12: v_cvt_f32_f64_e32 v5, exec              ; encoding: [0x7e,0x1e,0x0a,0x7e]

v_cvt_f32_f64 v5, null
// GFX12: v_cvt_f32_f64_e32 v5, null              ; encoding: [0x7c,0x1e,0x0a,0x7e]

v_cvt_f32_f64 v5, -1
// GFX12: v_cvt_f32_f64_e32 v5, -1                ; encoding: [0xc1,0x1e,0x0a,0x7e]

v_cvt_f32_f64 v5, 0.5
// GFX12: v_cvt_f32_f64_e32 v5, 0.5               ; encoding: [0xf0,0x1e,0x0a,0x7e]

v_cvt_f32_f64 v5, src_scc
// GFX12: v_cvt_f32_f64_e32 v5, src_scc           ; encoding: [0xfd,0x1e,0x0a,0x7e]

v_cvt_f32_f64 v255, 0xaf123456
// GFX12: v_cvt_f32_f64_e32 v255, 0xaf123456      ; encoding: [0xff,0x1e,0xfe,0x7f,0x56,0x34,0x12,0xaf]

v_cvt_f32_i32 v5, v1
// GFX12: v_cvt_f32_i32_e32 v5, v1                ; encoding: [0x01,0x0b,0x0a,0x7e]

v_cvt_f32_i32 v5, v255
// GFX12: v_cvt_f32_i32_e32 v5, v255              ; encoding: [0xff,0x0b,0x0a,0x7e]

v_cvt_f32_i32 v5, s1
// GFX12: v_cvt_f32_i32_e32 v5, s1                ; encoding: [0x01,0x0a,0x0a,0x7e]

v_cvt_f32_i32 v5, s105
// GFX12: v_cvt_f32_i32_e32 v5, s105              ; encoding: [0x69,0x0a,0x0a,0x7e]

v_cvt_f32_i32 v5, vcc_lo
// GFX12: v_cvt_f32_i32_e32 v5, vcc_lo            ; encoding: [0x6a,0x0a,0x0a,0x7e]

v_cvt_f32_i32 v5, vcc_hi
// GFX12: v_cvt_f32_i32_e32 v5, vcc_hi            ; encoding: [0x6b,0x0a,0x0a,0x7e]

v_cvt_f32_i32 v5, ttmp15
// GFX12: v_cvt_f32_i32_e32 v5, ttmp15            ; encoding: [0x7b,0x0a,0x0a,0x7e]

v_cvt_f32_i32 v5, m0
// GFX12: v_cvt_f32_i32_e32 v5, m0                ; encoding: [0x7d,0x0a,0x0a,0x7e]

v_cvt_f32_i32 v5, exec_lo
// GFX12: v_cvt_f32_i32_e32 v5, exec_lo           ; encoding: [0x7e,0x0a,0x0a,0x7e]

v_cvt_f32_i32 v5, exec_hi
// GFX12: v_cvt_f32_i32_e32 v5, exec_hi           ; encoding: [0x7f,0x0a,0x0a,0x7e]

v_cvt_f32_i32 v5, null
// GFX12: v_cvt_f32_i32_e32 v5, null              ; encoding: [0x7c,0x0a,0x0a,0x7e]

v_cvt_f32_i32 v5, -1
// GFX12: v_cvt_f32_i32_e32 v5, -1                ; encoding: [0xc1,0x0a,0x0a,0x7e]

v_cvt_f32_i32 v5, 0.5
// GFX12: v_cvt_f32_i32_e32 v5, 0.5               ; encoding: [0xf0,0x0a,0x0a,0x7e]

v_cvt_f32_i32 v5, src_scc
// GFX12: v_cvt_f32_i32_e32 v5, src_scc           ; encoding: [0xfd,0x0a,0x0a,0x7e]

v_cvt_f32_i32 v255, 0xaf123456
// GFX12: v_cvt_f32_i32_e32 v255, 0xaf123456      ; encoding: [0xff,0x0a,0xfe,0x7f,0x56,0x34,0x12,0xaf]

v_cvt_f32_u32 v5, v1
// GFX12: v_cvt_f32_u32_e32 v5, v1                ; encoding: [0x01,0x0d,0x0a,0x7e]

v_cvt_f32_u32 v5, v255
// GFX12: v_cvt_f32_u32_e32 v5, v255              ; encoding: [0xff,0x0d,0x0a,0x7e]

v_cvt_f32_u32 v5, s1
// GFX12: v_cvt_f32_u32_e32 v5, s1                ; encoding: [0x01,0x0c,0x0a,0x7e]

v_cvt_f32_u32 v5, s105
// GFX12: v_cvt_f32_u32_e32 v5, s105              ; encoding: [0x69,0x0c,0x0a,0x7e]

v_cvt_f32_u32 v5, vcc_lo
// GFX12: v_cvt_f32_u32_e32 v5, vcc_lo            ; encoding: [0x6a,0x0c,0x0a,0x7e]

v_cvt_f32_u32 v5, vcc_hi
// GFX12: v_cvt_f32_u32_e32 v5, vcc_hi            ; encoding: [0x6b,0x0c,0x0a,0x7e]

v_cvt_f32_u32 v5, ttmp15
// GFX12: v_cvt_f32_u32_e32 v5, ttmp15            ; encoding: [0x7b,0x0c,0x0a,0x7e]

v_cvt_f32_u32 v5, m0
// GFX12: v_cvt_f32_u32_e32 v5, m0                ; encoding: [0x7d,0x0c,0x0a,0x7e]

v_cvt_f32_u32 v5, exec_lo
// GFX12: v_cvt_f32_u32_e32 v5, exec_lo           ; encoding: [0x7e,0x0c,0x0a,0x7e]

v_cvt_f32_u32 v5, exec_hi
// GFX12: v_cvt_f32_u32_e32 v5, exec_hi           ; encoding: [0x7f,0x0c,0x0a,0x7e]

v_cvt_f32_u32 v5, null
// GFX12: v_cvt_f32_u32_e32 v5, null              ; encoding: [0x7c,0x0c,0x0a,0x7e]

v_cvt_f32_u32 v5, -1
// GFX12: v_cvt_f32_u32_e32 v5, -1                ; encoding: [0xc1,0x0c,0x0a,0x7e]

v_cvt_f32_u32 v5, 0.5
// GFX12: v_cvt_f32_u32_e32 v5, 0.5               ; encoding: [0xf0,0x0c,0x0a,0x7e]

v_cvt_f32_u32 v5, src_scc
// GFX12: v_cvt_f32_u32_e32 v5, src_scc           ; encoding: [0xfd,0x0c,0x0a,0x7e]

v_cvt_f32_u32 v255, 0xaf123456
// GFX12: v_cvt_f32_u32_e32 v255, 0xaf123456      ; encoding: [0xff,0x0c,0xfe,0x7f,0x56,0x34,0x12,0xaf]

v_cvt_f32_ubyte0 v5, v1
// GFX12: v_cvt_f32_ubyte0_e32 v5, v1             ; encoding: [0x01,0x23,0x0a,0x7e]

v_cvt_f32_ubyte0 v5, v255
// GFX12: v_cvt_f32_ubyte0_e32 v5, v255           ; encoding: [0xff,0x23,0x0a,0x7e]

v_cvt_f32_ubyte0 v5, s1
// GFX12: v_cvt_f32_ubyte0_e32 v5, s1             ; encoding: [0x01,0x22,0x0a,0x7e]

v_cvt_f32_ubyte0 v5, s105
// GFX12: v_cvt_f32_ubyte0_e32 v5, s105           ; encoding: [0x69,0x22,0x0a,0x7e]

v_cvt_f32_ubyte0 v5, vcc_lo
// GFX12: v_cvt_f32_ubyte0_e32 v5, vcc_lo         ; encoding: [0x6a,0x22,0x0a,0x7e]

v_cvt_f32_ubyte0 v5, vcc_hi
// GFX12: v_cvt_f32_ubyte0_e32 v5, vcc_hi         ; encoding: [0x6b,0x22,0x0a,0x7e]

v_cvt_f32_ubyte0 v5, ttmp15
// GFX12: v_cvt_f32_ubyte0_e32 v5, ttmp15         ; encoding: [0x7b,0x22,0x0a,0x7e]

v_cvt_f32_ubyte0 v5, m0
// GFX12: v_cvt_f32_ubyte0_e32 v5, m0             ; encoding: [0x7d,0x22,0x0a,0x7e]

v_cvt_f32_ubyte0 v5, exec_lo
// GFX12: v_cvt_f32_ubyte0_e32 v5, exec_lo        ; encoding: [0x7e,0x22,0x0a,0x7e]

v_cvt_f32_ubyte0 v5, exec_hi
// GFX12: v_cvt_f32_ubyte0_e32 v5, exec_hi        ; encoding: [0x7f,0x22,0x0a,0x7e]

v_cvt_f32_ubyte0 v5, null
// GFX12: v_cvt_f32_ubyte0_e32 v5, null           ; encoding: [0x7c,0x22,0x0a,0x7e]

v_cvt_f32_ubyte0 v5, -1
// GFX12: v_cvt_f32_ubyte0_e32 v5, -1             ; encoding: [0xc1,0x22,0x0a,0x7e]

v_cvt_f32_ubyte0 v5, 0.5
// GFX12: v_cvt_f32_ubyte0_e32 v5, 0.5            ; encoding: [0xf0,0x22,0x0a,0x7e]

v_cvt_f32_ubyte0 v5, src_scc
// GFX12: v_cvt_f32_ubyte0_e32 v5, src_scc        ; encoding: [0xfd,0x22,0x0a,0x7e]

v_cvt_f32_ubyte0 v255, 0xaf123456
// GFX12: v_cvt_f32_ubyte0_e32 v255, 0xaf123456   ; encoding: [0xff,0x22,0xfe,0x7f,0x56,0x34,0x12,0xaf]

v_cvt_f32_ubyte1 v5, v1
// GFX12: v_cvt_f32_ubyte1_e32 v5, v1             ; encoding: [0x01,0x25,0x0a,0x7e]

v_cvt_f32_ubyte1 v5, v255
// GFX12: v_cvt_f32_ubyte1_e32 v5, v255           ; encoding: [0xff,0x25,0x0a,0x7e]

v_cvt_f32_ubyte1 v5, s1
// GFX12: v_cvt_f32_ubyte1_e32 v5, s1             ; encoding: [0x01,0x24,0x0a,0x7e]

v_cvt_f32_ubyte1 v5, s105
// GFX12: v_cvt_f32_ubyte1_e32 v5, s105           ; encoding: [0x69,0x24,0x0a,0x7e]

v_cvt_f32_ubyte1 v5, vcc_lo
// GFX12: v_cvt_f32_ubyte1_e32 v5, vcc_lo         ; encoding: [0x6a,0x24,0x0a,0x7e]

v_cvt_f32_ubyte1 v5, vcc_hi
// GFX12: v_cvt_f32_ubyte1_e32 v5, vcc_hi         ; encoding: [0x6b,0x24,0x0a,0x7e]

v_cvt_f32_ubyte1 v5, ttmp15
// GFX12: v_cvt_f32_ubyte1_e32 v5, ttmp15         ; encoding: [0x7b,0x24,0x0a,0x7e]

v_cvt_f32_ubyte1 v5, m0
// GFX12: v_cvt_f32_ubyte1_e32 v5, m0             ; encoding: [0x7d,0x24,0x0a,0x7e]

v_cvt_f32_ubyte1 v5, exec_lo
// GFX12: v_cvt_f32_ubyte1_e32 v5, exec_lo        ; encoding: [0x7e,0x24,0x0a,0x7e]

v_cvt_f32_ubyte1 v5, exec_hi
// GFX12: v_cvt_f32_ubyte1_e32 v5, exec_hi        ; encoding: [0x7f,0x24,0x0a,0x7e]

v_cvt_f32_ubyte1 v5, null
// GFX12: v_cvt_f32_ubyte1_e32 v5, null           ; encoding: [0x7c,0x24,0x0a,0x7e]

v_cvt_f32_ubyte1 v5, -1
// GFX12: v_cvt_f32_ubyte1_e32 v5, -1             ; encoding: [0xc1,0x24,0x0a,0x7e]

v_cvt_f32_ubyte1 v5, 0.5
// GFX12: v_cvt_f32_ubyte1_e32 v5, 0.5            ; encoding: [0xf0,0x24,0x0a,0x7e]

v_cvt_f32_ubyte1 v5, src_scc
// GFX12: v_cvt_f32_ubyte1_e32 v5, src_scc        ; encoding: [0xfd,0x24,0x0a,0x7e]

v_cvt_f32_ubyte1 v255, 0xaf123456
// GFX12: v_cvt_f32_ubyte1_e32 v255, 0xaf123456   ; encoding: [0xff,0x24,0xfe,0x7f,0x56,0x34,0x12,0xaf]

v_cvt_f32_ubyte2 v5, v1
// GFX12: v_cvt_f32_ubyte2_e32 v5, v1             ; encoding: [0x01,0x27,0x0a,0x7e]

v_cvt_f32_ubyte2 v5, v255
// GFX12: v_cvt_f32_ubyte2_e32 v5, v255           ; encoding: [0xff,0x27,0x0a,0x7e]

v_cvt_f32_ubyte2 v5, s1
// GFX12: v_cvt_f32_ubyte2_e32 v5, s1             ; encoding: [0x01,0x26,0x0a,0x7e]

v_cvt_f32_ubyte2 v5, s105
// GFX12: v_cvt_f32_ubyte2_e32 v5, s105           ; encoding: [0x69,0x26,0x0a,0x7e]

v_cvt_f32_ubyte2 v5, vcc_lo
// GFX12: v_cvt_f32_ubyte2_e32 v5, vcc_lo         ; encoding: [0x6a,0x26,0x0a,0x7e]

v_cvt_f32_ubyte2 v5, vcc_hi
// GFX12: v_cvt_f32_ubyte2_e32 v5, vcc_hi         ; encoding: [0x6b,0x26,0x0a,0x7e]

v_cvt_f32_ubyte2 v5, ttmp15
// GFX12: v_cvt_f32_ubyte2_e32 v5, ttmp15         ; encoding: [0x7b,0x26,0x0a,0x7e]

v_cvt_f32_ubyte2 v5, m0
// GFX12: v_cvt_f32_ubyte2_e32 v5, m0             ; encoding: [0x7d,0x26,0x0a,0x7e]

v_cvt_f32_ubyte2 v5, exec_lo
// GFX12: v_cvt_f32_ubyte2_e32 v5, exec_lo        ; encoding: [0x7e,0x26,0x0a,0x7e]

v_cvt_f32_ubyte2 v5, exec_hi
// GFX12: v_cvt_f32_ubyte2_e32 v5, exec_hi        ; encoding: [0x7f,0x26,0x0a,0x7e]

v_cvt_f32_ubyte2 v5, null
// GFX12: v_cvt_f32_ubyte2_e32 v5, null           ; encoding: [0x7c,0x26,0x0a,0x7e]

v_cvt_f32_ubyte2 v5, -1
// GFX12: v_cvt_f32_ubyte2_e32 v5, -1             ; encoding: [0xc1,0x26,0x0a,0x7e]

v_cvt_f32_ubyte2 v5, 0.5
// GFX12: v_cvt_f32_ubyte2_e32 v5, 0.5            ; encoding: [0xf0,0x26,0x0a,0x7e]

v_cvt_f32_ubyte2 v5, src_scc
// GFX12: v_cvt_f32_ubyte2_e32 v5, src_scc        ; encoding: [0xfd,0x26,0x0a,0x7e]

v_cvt_f32_ubyte2 v255, 0xaf123456
// GFX12: v_cvt_f32_ubyte2_e32 v255, 0xaf123456   ; encoding: [0xff,0x26,0xfe,0x7f,0x56,0x34,0x12,0xaf]

v_cvt_f32_ubyte3 v5, v1
// GFX12: v_cvt_f32_ubyte3_e32 v5, v1             ; encoding: [0x01,0x29,0x0a,0x7e]

v_cvt_f32_ubyte3 v5, v255
// GFX12: v_cvt_f32_ubyte3_e32 v5, v255           ; encoding: [0xff,0x29,0x0a,0x7e]

v_cvt_f32_ubyte3 v5, s1
// GFX12: v_cvt_f32_ubyte3_e32 v5, s1             ; encoding: [0x01,0x28,0x0a,0x7e]

v_cvt_f32_ubyte3 v5, s105
// GFX12: v_cvt_f32_ubyte3_e32 v5, s105           ; encoding: [0x69,0x28,0x0a,0x7e]

v_cvt_f32_ubyte3 v5, vcc_lo
// GFX12: v_cvt_f32_ubyte3_e32 v5, vcc_lo         ; encoding: [0x6a,0x28,0x0a,0x7e]

v_cvt_f32_ubyte3 v5, vcc_hi
// GFX12: v_cvt_f32_ubyte3_e32 v5, vcc_hi         ; encoding: [0x6b,0x28,0x0a,0x7e]

v_cvt_f32_ubyte3 v5, ttmp15
// GFX12: v_cvt_f32_ubyte3_e32 v5, ttmp15         ; encoding: [0x7b,0x28,0x0a,0x7e]

v_cvt_f32_ubyte3 v5, m0
// GFX12: v_cvt_f32_ubyte3_e32 v5, m0             ; encoding: [0x7d,0x28,0x0a,0x7e]

v_cvt_f32_ubyte3 v5, exec_lo
// GFX12: v_cvt_f32_ubyte3_e32 v5, exec_lo        ; encoding: [0x7e,0x28,0x0a,0x7e]

v_cvt_f32_ubyte3 v5, exec_hi
// GFX12: v_cvt_f32_ubyte3_e32 v5, exec_hi        ; encoding: [0x7f,0x28,0x0a,0x7e]

v_cvt_f32_ubyte3 v5, null
// GFX12: v_cvt_f32_ubyte3_e32 v5, null           ; encoding: [0x7c,0x28,0x0a,0x7e]

v_cvt_f32_ubyte3 v5, -1
// GFX12: v_cvt_f32_ubyte3_e32 v5, -1             ; encoding: [0xc1,0x28,0x0a,0x7e]

v_cvt_f32_ubyte3 v5, 0.5
// GFX12: v_cvt_f32_ubyte3_e32 v5, 0.5            ; encoding: [0xf0,0x28,0x0a,0x7e]

v_cvt_f32_ubyte3 v5, src_scc
// GFX12: v_cvt_f32_ubyte3_e32 v5, src_scc        ; encoding: [0xfd,0x28,0x0a,0x7e]

v_cvt_f32_ubyte3 v255, 0xaf123456
// GFX12: v_cvt_f32_ubyte3_e32 v255, 0xaf123456   ; encoding: [0xff,0x28,0xfe,0x7f,0x56,0x34,0x12,0xaf]

v_cvt_f64_f32 v[5:6], v1
// GFX12: v_cvt_f64_f32_e32 v[5:6], v1            ; encoding: [0x01,0x21,0x0a,0x7e]

v_cvt_f64_f32 v[5:6], v255
// GFX12: v_cvt_f64_f32_e32 v[5:6], v255          ; encoding: [0xff,0x21,0x0a,0x7e]

v_cvt_f64_f32 v[5:6], s1
// GFX12: v_cvt_f64_f32_e32 v[5:6], s1            ; encoding: [0x01,0x20,0x0a,0x7e]

v_cvt_f64_f32 v[5:6], s105
// GFX12: v_cvt_f64_f32_e32 v[5:6], s105          ; encoding: [0x69,0x20,0x0a,0x7e]

v_cvt_f64_f32 v[5:6], vcc_lo
// GFX12: v_cvt_f64_f32_e32 v[5:6], vcc_lo        ; encoding: [0x6a,0x20,0x0a,0x7e]

v_cvt_f64_f32 v[5:6], vcc_hi
// GFX12: v_cvt_f64_f32_e32 v[5:6], vcc_hi        ; encoding: [0x6b,0x20,0x0a,0x7e]

v_cvt_f64_f32 v[5:6], ttmp15
// GFX12: v_cvt_f64_f32_e32 v[5:6], ttmp15        ; encoding: [0x7b,0x20,0x0a,0x7e]

v_cvt_f64_f32 v[5:6], m0
// GFX12: v_cvt_f64_f32_e32 v[5:6], m0            ; encoding: [0x7d,0x20,0x0a,0x7e]

v_cvt_f64_f32 v[5:6], exec_lo
// GFX12: v_cvt_f64_f32_e32 v[5:6], exec_lo       ; encoding: [0x7e,0x20,0x0a,0x7e]

v_cvt_f64_f32 v[5:6], exec_hi
// GFX12: v_cvt_f64_f32_e32 v[5:6], exec_hi       ; encoding: [0x7f,0x20,0x0a,0x7e]

v_cvt_f64_f32 v[5:6], null
// GFX12: v_cvt_f64_f32_e32 v[5:6], null          ; encoding: [0x7c,0x20,0x0a,0x7e]

v_cvt_f64_f32 v[5:6], -1
// GFX12: v_cvt_f64_f32_e32 v[5:6], -1            ; encoding: [0xc1,0x20,0x0a,0x7e]

v_cvt_f64_f32 v[5:6], 0.5
// GFX12: v_cvt_f64_f32_e32 v[5:6], 0.5           ; encoding: [0xf0,0x20,0x0a,0x7e]

v_cvt_f64_f32 v[5:6], src_scc
// GFX12: v_cvt_f64_f32_e32 v[5:6], src_scc       ; encoding: [0xfd,0x20,0x0a,0x7e]

v_cvt_f64_f32 v[254:255], 0xaf123456
// GFX12: v_cvt_f64_f32_e32 v[254:255], 0xaf123456 ; encoding: [0xff,0x20,0xfc,0x7f,0x56,0x34,0x12,0xaf]

v_cvt_f64_i32 v[5:6], v1
// GFX12: v_cvt_f64_i32_e32 v[5:6], v1            ; encoding: [0x01,0x09,0x0a,0x7e]

v_cvt_f64_i32 v[5:6], v255
// GFX12: v_cvt_f64_i32_e32 v[5:6], v255          ; encoding: [0xff,0x09,0x0a,0x7e]

v_cvt_f64_i32 v[5:6], s1
// GFX12: v_cvt_f64_i32_e32 v[5:6], s1            ; encoding: [0x01,0x08,0x0a,0x7e]

v_cvt_f64_i32 v[5:6], s105
// GFX12: v_cvt_f64_i32_e32 v[5:6], s105          ; encoding: [0x69,0x08,0x0a,0x7e]

v_cvt_f64_i32 v[5:6], vcc_lo
// GFX12: v_cvt_f64_i32_e32 v[5:6], vcc_lo        ; encoding: [0x6a,0x08,0x0a,0x7e]

v_cvt_f64_i32 v[5:6], vcc_hi
// GFX12: v_cvt_f64_i32_e32 v[5:6], vcc_hi        ; encoding: [0x6b,0x08,0x0a,0x7e]

v_cvt_f64_i32 v[5:6], ttmp15
// GFX12: v_cvt_f64_i32_e32 v[5:6], ttmp15        ; encoding: [0x7b,0x08,0x0a,0x7e]

v_cvt_f64_i32 v[5:6], m0
// GFX12: v_cvt_f64_i32_e32 v[5:6], m0            ; encoding: [0x7d,0x08,0x0a,0x7e]

v_cvt_f64_i32 v[5:6], exec_lo
// GFX12: v_cvt_f64_i32_e32 v[5:6], exec_lo       ; encoding: [0x7e,0x08,0x0a,0x7e]

v_cvt_f64_i32 v[5:6], exec_hi
// GFX12: v_cvt_f64_i32_e32 v[5:6], exec_hi       ; encoding: [0x7f,0x08,0x0a,0x7e]

v_cvt_f64_i32 v[5:6], null
// GFX12: v_cvt_f64_i32_e32 v[5:6], null          ; encoding: [0x7c,0x08,0x0a,0x7e]

v_cvt_f64_i32 v[5:6], -1
// GFX12: v_cvt_f64_i32_e32 v[5:6], -1            ; encoding: [0xc1,0x08,0x0a,0x7e]

v_cvt_f64_i32 v[5:6], 0.5
// GFX12: v_cvt_f64_i32_e32 v[5:6], 0.5           ; encoding: [0xf0,0x08,0x0a,0x7e]

v_cvt_f64_i32 v[5:6], src_scc
// GFX12: v_cvt_f64_i32_e32 v[5:6], src_scc       ; encoding: [0xfd,0x08,0x0a,0x7e]

v_cvt_f64_i32 v[254:255], 0xaf123456
// GFX12: v_cvt_f64_i32_e32 v[254:255], 0xaf123456 ; encoding: [0xff,0x08,0xfc,0x7f,0x56,0x34,0x12,0xaf]

v_cvt_f64_u32 v[5:6], v1
// GFX12: v_cvt_f64_u32_e32 v[5:6], v1            ; encoding: [0x01,0x2d,0x0a,0x7e]

v_cvt_f64_u32 v[5:6], v255
// GFX12: v_cvt_f64_u32_e32 v[5:6], v255          ; encoding: [0xff,0x2d,0x0a,0x7e]

v_cvt_f64_u32 v[5:6], s1
// GFX12: v_cvt_f64_u32_e32 v[5:6], s1            ; encoding: [0x01,0x2c,0x0a,0x7e]

v_cvt_f64_u32 v[5:6], s105
// GFX12: v_cvt_f64_u32_e32 v[5:6], s105          ; encoding: [0x69,0x2c,0x0a,0x7e]

v_cvt_f64_u32 v[5:6], vcc_lo
// GFX12: v_cvt_f64_u32_e32 v[5:6], vcc_lo        ; encoding: [0x6a,0x2c,0x0a,0x7e]

v_cvt_f64_u32 v[5:6], vcc_hi
// GFX12: v_cvt_f64_u32_e32 v[5:6], vcc_hi        ; encoding: [0x6b,0x2c,0x0a,0x7e]

v_cvt_f64_u32 v[5:6], ttmp15
// GFX12: v_cvt_f64_u32_e32 v[5:6], ttmp15        ; encoding: [0x7b,0x2c,0x0a,0x7e]

v_cvt_f64_u32 v[5:6], m0
// GFX12: v_cvt_f64_u32_e32 v[5:6], m0            ; encoding: [0x7d,0x2c,0x0a,0x7e]

v_cvt_f64_u32 v[5:6], exec_lo
// GFX12: v_cvt_f64_u32_e32 v[5:6], exec_lo       ; encoding: [0x7e,0x2c,0x0a,0x7e]

v_cvt_f64_u32 v[5:6], exec_hi
// GFX12: v_cvt_f64_u32_e32 v[5:6], exec_hi       ; encoding: [0x7f,0x2c,0x0a,0x7e]

v_cvt_f64_u32 v[5:6], null
// GFX12: v_cvt_f64_u32_e32 v[5:6], null          ; encoding: [0x7c,0x2c,0x0a,0x7e]

v_cvt_f64_u32 v[5:6], -1
// GFX12: v_cvt_f64_u32_e32 v[5:6], -1            ; encoding: [0xc1,0x2c,0x0a,0x7e]

v_cvt_f64_u32 v[5:6], 0.5
// GFX12: v_cvt_f64_u32_e32 v[5:6], 0.5           ; encoding: [0xf0,0x2c,0x0a,0x7e]

v_cvt_f64_u32 v[5:6], src_scc
// GFX12: v_cvt_f64_u32_e32 v[5:6], src_scc       ; encoding: [0xfd,0x2c,0x0a,0x7e]

v_cvt_f64_u32 v[254:255], 0xaf123456
// GFX12: v_cvt_f64_u32_e32 v[254:255], 0xaf123456 ; encoding: [0xff,0x2c,0xfc,0x7f,0x56,0x34,0x12,0xaf]

v_cvt_floor_i32_f32 v5, v1
// GFX12: v_cvt_floor_i32_f32_e32 v5, v1          ; encoding: [0x01,0x1b,0x0a,0x7e]

v_cvt_floor_i32_f32 v5, v255
// GFX12: v_cvt_floor_i32_f32_e32 v5, v255        ; encoding: [0xff,0x1b,0x0a,0x7e]

v_cvt_floor_i32_f32 v5, s1
// GFX12: v_cvt_floor_i32_f32_e32 v5, s1          ; encoding: [0x01,0x1a,0x0a,0x7e]

v_cvt_floor_i32_f32 v5, s105
// GFX12: v_cvt_floor_i32_f32_e32 v5, s105        ; encoding: [0x69,0x1a,0x0a,0x7e]

v_cvt_floor_i32_f32 v5, vcc_lo
// GFX12: v_cvt_floor_i32_f32_e32 v5, vcc_lo      ; encoding: [0x6a,0x1a,0x0a,0x7e]

v_cvt_floor_i32_f32 v5, vcc_hi
// GFX12: v_cvt_floor_i32_f32_e32 v5, vcc_hi      ; encoding: [0x6b,0x1a,0x0a,0x7e]

v_cvt_floor_i32_f32 v5, ttmp15
// GFX12: v_cvt_floor_i32_f32_e32 v5, ttmp15      ; encoding: [0x7b,0x1a,0x0a,0x7e]

v_cvt_floor_i32_f32 v5, m0
// GFX12: v_cvt_floor_i32_f32_e32 v5, m0          ; encoding: [0x7d,0x1a,0x0a,0x7e]

v_cvt_floor_i32_f32 v5, exec_lo
// GFX12: v_cvt_floor_i32_f32_e32 v5, exec_lo     ; encoding: [0x7e,0x1a,0x0a,0x7e]

v_cvt_floor_i32_f32 v5, exec_hi
// GFX12: v_cvt_floor_i32_f32_e32 v5, exec_hi     ; encoding: [0x7f,0x1a,0x0a,0x7e]

v_cvt_floor_i32_f32 v5, null
// GFX12: v_cvt_floor_i32_f32_e32 v5, null        ; encoding: [0x7c,0x1a,0x0a,0x7e]

v_cvt_floor_i32_f32 v5, -1
// GFX12: v_cvt_floor_i32_f32_e32 v5, -1          ; encoding: [0xc1,0x1a,0x0a,0x7e]

v_cvt_floor_i32_f32 v5, 0.5
// GFX12: v_cvt_floor_i32_f32_e32 v5, 0.5         ; encoding: [0xf0,0x1a,0x0a,0x7e]

v_cvt_floor_i32_f32 v5, src_scc
// GFX12: v_cvt_floor_i32_f32_e32 v5, src_scc     ; encoding: [0xfd,0x1a,0x0a,0x7e]

v_cvt_floor_i32_f32 v255, 0xaf123456
// GFX12: v_cvt_floor_i32_f32_e32 v255, 0xaf123456 ; encoding: [0xff,0x1a,0xfe,0x7f,0x56,0x34,0x12,0xaf]

v_cvt_flr_i32_f32 v5, v1
// GFX12: v_cvt_floor_i32_f32_e32 v5, v1          ; encoding: [0x01,0x1b,0x0a,0x7e]

v_cvt_flr_i32_f32 v5, v255
// GFX12: v_cvt_floor_i32_f32_e32 v5, v255        ; encoding: [0xff,0x1b,0x0a,0x7e]

v_cvt_flr_i32_f32 v5, s1
// GFX12: v_cvt_floor_i32_f32_e32 v5, s1          ; encoding: [0x01,0x1a,0x0a,0x7e]

v_cvt_flr_i32_f32 v5, s105
// GFX12: v_cvt_floor_i32_f32_e32 v5, s105        ; encoding: [0x69,0x1a,0x0a,0x7e]

v_cvt_flr_i32_f32 v5, vcc_lo
// GFX12: v_cvt_floor_i32_f32_e32 v5, vcc_lo      ; encoding: [0x6a,0x1a,0x0a,0x7e]

v_cvt_flr_i32_f32 v5, vcc_hi
// GFX12: v_cvt_floor_i32_f32_e32 v5, vcc_hi      ; encoding: [0x6b,0x1a,0x0a,0x7e]

v_cvt_flr_i32_f32 v5, ttmp15
// GFX12: v_cvt_floor_i32_f32_e32 v5, ttmp15      ; encoding: [0x7b,0x1a,0x0a,0x7e]

v_cvt_flr_i32_f32 v5, m0
// GFX12: v_cvt_floor_i32_f32_e32 v5, m0          ; encoding: [0x7d,0x1a,0x0a,0x7e]

v_cvt_flr_i32_f32 v5, exec_lo
// GFX12: v_cvt_floor_i32_f32_e32 v5, exec_lo     ; encoding: [0x7e,0x1a,0x0a,0x7e]

v_cvt_flr_i32_f32 v5, exec_hi
// GFX12: v_cvt_floor_i32_f32_e32 v5, exec_hi     ; encoding: [0x7f,0x1a,0x0a,0x7e]

v_cvt_flr_i32_f32 v5, null
// GFX12: v_cvt_floor_i32_f32_e32 v5, null        ; encoding: [0x7c,0x1a,0x0a,0x7e]

v_cvt_flr_i32_f32 v5, -1
// GFX12: v_cvt_floor_i32_f32_e32 v5, -1          ; encoding: [0xc1,0x1a,0x0a,0x7e]

v_cvt_flr_i32_f32 v5, 0.5
// GFX12: v_cvt_floor_i32_f32_e32 v5, 0.5         ; encoding: [0xf0,0x1a,0x0a,0x7e]

v_cvt_flr_i32_f32 v5, src_scc
// GFX12: v_cvt_floor_i32_f32_e32 v5, src_scc     ; encoding: [0xfd,0x1a,0x0a,0x7e]

v_cvt_flr_i32_f32 v255, 0xaf123456
// GFX12: v_cvt_floor_i32_f32_e32 v255, 0xaf123456 ; encoding: [0xff,0x1a,0xfe,0x7f,0x56,0x34,0x12,0xaf]

v_cvt_i16_f16 v5, v1
// GFX12: v_cvt_i16_f16_e32 v5, v1                ; encoding: [0x01,0xa7,0x0a,0x7e]

v_cvt_i16_f16 v5, v127
// GFX12: v_cvt_i16_f16_e32 v5, v127              ; encoding: [0x7f,0xa7,0x0a,0x7e]

v_cvt_i16_f16 v5, s1
// GFX12: v_cvt_i16_f16_e32 v5, s1                ; encoding: [0x01,0xa6,0x0a,0x7e]

v_cvt_i16_f16 v5, s105
// GFX12: v_cvt_i16_f16_e32 v5, s105              ; encoding: [0x69,0xa6,0x0a,0x7e]

v_cvt_i16_f16 v5, vcc_lo
// GFX12: v_cvt_i16_f16_e32 v5, vcc_lo            ; encoding: [0x6a,0xa6,0x0a,0x7e]

v_cvt_i16_f16 v5, vcc_hi
// GFX12: v_cvt_i16_f16_e32 v5, vcc_hi            ; encoding: [0x6b,0xa6,0x0a,0x7e]

v_cvt_i16_f16 v5, ttmp15
// GFX12: v_cvt_i16_f16_e32 v5, ttmp15            ; encoding: [0x7b,0xa6,0x0a,0x7e]

v_cvt_i16_f16 v5, m0
// GFX12: v_cvt_i16_f16_e32 v5, m0                ; encoding: [0x7d,0xa6,0x0a,0x7e]

v_cvt_i16_f16 v5, exec_lo
// GFX12: v_cvt_i16_f16_e32 v5, exec_lo           ; encoding: [0x7e,0xa6,0x0a,0x7e]

v_cvt_i16_f16 v5, exec_hi
// GFX12: v_cvt_i16_f16_e32 v5, exec_hi           ; encoding: [0x7f,0xa6,0x0a,0x7e]

v_cvt_i16_f16 v5, null
// GFX12: v_cvt_i16_f16_e32 v5, null              ; encoding: [0x7c,0xa6,0x0a,0x7e]

v_cvt_i16_f16 v5, -1
// GFX12: v_cvt_i16_f16_e32 v5, -1                ; encoding: [0xc1,0xa6,0x0a,0x7e]

v_cvt_i16_f16 v5, 0.5
// GFX12: v_cvt_i16_f16_e32 v5, 0.5               ; encoding: [0xf0,0xa6,0x0a,0x7e]

v_cvt_i16_f16 v5, src_scc
// GFX12: v_cvt_i16_f16_e32 v5, src_scc           ; encoding: [0xfd,0xa6,0x0a,0x7e]

v_cvt_i16_f16 v127, 0xfe0b
// GFX12: v_cvt_i16_f16_e32 v127, 0xfe0b          ; encoding: [0xff,0xa6,0xfe,0x7e,0x0b,0xfe,0x00,0x00]

v_cvt_i32_f32 v5, v1
// GFX12: v_cvt_i32_f32_e32 v5, v1                ; encoding: [0x01,0x11,0x0a,0x7e]

v_cvt_i32_f32 v5, v255
// GFX12: v_cvt_i32_f32_e32 v5, v255              ; encoding: [0xff,0x11,0x0a,0x7e]

v_cvt_i32_f32 v5, s1
// GFX12: v_cvt_i32_f32_e32 v5, s1                ; encoding: [0x01,0x10,0x0a,0x7e]

v_cvt_i32_f32 v5, s105
// GFX12: v_cvt_i32_f32_e32 v5, s105              ; encoding: [0x69,0x10,0x0a,0x7e]

v_cvt_i32_f32 v5, vcc_lo
// GFX12: v_cvt_i32_f32_e32 v5, vcc_lo            ; encoding: [0x6a,0x10,0x0a,0x7e]

v_cvt_i32_f32 v5, vcc_hi
// GFX12: v_cvt_i32_f32_e32 v5, vcc_hi            ; encoding: [0x6b,0x10,0x0a,0x7e]

v_cvt_i32_f32 v5, ttmp15
// GFX12: v_cvt_i32_f32_e32 v5, ttmp15            ; encoding: [0x7b,0x10,0x0a,0x7e]

v_cvt_i32_f32 v5, m0
// GFX12: v_cvt_i32_f32_e32 v5, m0                ; encoding: [0x7d,0x10,0x0a,0x7e]

v_cvt_i32_f32 v5, exec_lo
// GFX12: v_cvt_i32_f32_e32 v5, exec_lo           ; encoding: [0x7e,0x10,0x0a,0x7e]

v_cvt_i32_f32 v5, exec_hi
// GFX12: v_cvt_i32_f32_e32 v5, exec_hi           ; encoding: [0x7f,0x10,0x0a,0x7e]

v_cvt_i32_f32 v5, null
// GFX12: v_cvt_i32_f32_e32 v5, null              ; encoding: [0x7c,0x10,0x0a,0x7e]

v_cvt_i32_f32 v5, -1
// GFX12: v_cvt_i32_f32_e32 v5, -1                ; encoding: [0xc1,0x10,0x0a,0x7e]

v_cvt_i32_f32 v5, 0.5
// GFX12: v_cvt_i32_f32_e32 v5, 0.5               ; encoding: [0xf0,0x10,0x0a,0x7e]

v_cvt_i32_f32 v5, src_scc
// GFX12: v_cvt_i32_f32_e32 v5, src_scc           ; encoding: [0xfd,0x10,0x0a,0x7e]

v_cvt_i32_f32 v255, 0xaf123456
// GFX12: v_cvt_i32_f32_e32 v255, 0xaf123456      ; encoding: [0xff,0x10,0xfe,0x7f,0x56,0x34,0x12,0xaf]

v_cvt_i32_f64 v5, v[1:2]
// GFX12: v_cvt_i32_f64_e32 v5, v[1:2]            ; encoding: [0x01,0x07,0x0a,0x7e]

v_cvt_i32_f64 v5, v[254:255]
// GFX12: v_cvt_i32_f64_e32 v5, v[254:255]        ; encoding: [0xfe,0x07,0x0a,0x7e]

v_cvt_i32_f64 v5, s[2:3]
// GFX12: v_cvt_i32_f64_e32 v5, s[2:3]            ; encoding: [0x02,0x06,0x0a,0x7e]

v_cvt_i32_f64 v5, s[104:105]
// GFX12: v_cvt_i32_f64_e32 v5, s[104:105]        ; encoding: [0x68,0x06,0x0a,0x7e]

v_cvt_i32_f64 v5, vcc
// GFX12: v_cvt_i32_f64_e32 v5, vcc               ; encoding: [0x6a,0x06,0x0a,0x7e]

v_cvt_i32_f64 v5, ttmp[14:15]
// GFX12: v_cvt_i32_f64_e32 v5, ttmp[14:15]       ; encoding: [0x7a,0x06,0x0a,0x7e]

v_cvt_i32_f64 v5, exec
// GFX12: v_cvt_i32_f64_e32 v5, exec              ; encoding: [0x7e,0x06,0x0a,0x7e]

v_cvt_i32_f64 v5, null
// GFX12: v_cvt_i32_f64_e32 v5, null              ; encoding: [0x7c,0x06,0x0a,0x7e]

v_cvt_i32_f64 v5, -1
// GFX12: v_cvt_i32_f64_e32 v5, -1                ; encoding: [0xc1,0x06,0x0a,0x7e]

v_cvt_i32_f64 v5, 0.5
// GFX12: v_cvt_i32_f64_e32 v5, 0.5               ; encoding: [0xf0,0x06,0x0a,0x7e]

v_cvt_i32_f64 v5, src_scc
// GFX12: v_cvt_i32_f64_e32 v5, src_scc           ; encoding: [0xfd,0x06,0x0a,0x7e]

v_cvt_i32_f64 v255, 0xaf123456
// GFX12: v_cvt_i32_f64_e32 v255, 0xaf123456      ; encoding: [0xff,0x06,0xfe,0x7f,0x56,0x34,0x12,0xaf]

v_cvt_i32_i16 v5, v1
// GFX12: v_cvt_i32_i16_e32 v5, v1                ; encoding: [0x01,0xd5,0x0a,0x7e]

v_cvt_i32_i16 v5, v127
// GFX12: v_cvt_i32_i16_e32 v5, v127              ; encoding: [0x7f,0xd5,0x0a,0x7e]

v_cvt_i32_i16 v5, s1
// GFX12: v_cvt_i32_i16_e32 v5, s1                ; encoding: [0x01,0xd4,0x0a,0x7e]

v_cvt_i32_i16 v5, s105
// GFX12: v_cvt_i32_i16_e32 v5, s105              ; encoding: [0x69,0xd4,0x0a,0x7e]

v_cvt_i32_i16 v5, vcc_lo
// GFX12: v_cvt_i32_i16_e32 v5, vcc_lo            ; encoding: [0x6a,0xd4,0x0a,0x7e]

v_cvt_i32_i16 v5, vcc_hi
// GFX12: v_cvt_i32_i16_e32 v5, vcc_hi            ; encoding: [0x6b,0xd4,0x0a,0x7e]

v_cvt_i32_i16 v5, ttmp15
// GFX12: v_cvt_i32_i16_e32 v5, ttmp15            ; encoding: [0x7b,0xd4,0x0a,0x7e]

v_cvt_i32_i16 v5, m0
// GFX12: v_cvt_i32_i16_e32 v5, m0                ; encoding: [0x7d,0xd4,0x0a,0x7e]

v_cvt_i32_i16 v5, exec_lo
// GFX12: v_cvt_i32_i16_e32 v5, exec_lo           ; encoding: [0x7e,0xd4,0x0a,0x7e]

v_cvt_i32_i16 v5, exec_hi
// GFX12: v_cvt_i32_i16_e32 v5, exec_hi           ; encoding: [0x7f,0xd4,0x0a,0x7e]

v_cvt_i32_i16 v5, null
// GFX12: v_cvt_i32_i16_e32 v5, null              ; encoding: [0x7c,0xd4,0x0a,0x7e]

v_cvt_i32_i16 v5, -1
// GFX12: v_cvt_i32_i16_e32 v5, -1                ; encoding: [0xc1,0xd4,0x0a,0x7e]

v_cvt_i32_i16 v5, 0.5
// GFX12-ASM: v_cvt_i32_i16_e32 v5, 0.5               ; encoding: [0xf0,0xd4,0x0a,0x7e]
// GFX12-DIS: v_cvt_i32_i16_e32 v5, 0x3800            ; encoding: [0xff,0xd4,0x0a,0x7e,0x00,0x38,0x00,0x00]

v_cvt_i32_i16 v5, src_scc
// GFX12: v_cvt_i32_i16_e32 v5, src_scc           ; encoding: [0xfd,0xd4,0x0a,0x7e]

v_cvt_i32_i16 v255, 0xfe0b
// GFX12: v_cvt_i32_i16_e32 v255, 0xfe0b          ; encoding: [0xff,0xd4,0xfe,0x7f,0x0b,0xfe,0x00,0x00]

v_cvt_nearest_i32_f32 v5, v1
// GFX12: v_cvt_nearest_i32_f32_e32 v5, v1        ; encoding: [0x01,0x19,0x0a,0x7e]

v_cvt_nearest_i32_f32 v5, v255
// GFX12: v_cvt_nearest_i32_f32_e32 v5, v255      ; encoding: [0xff,0x19,0x0a,0x7e]

v_cvt_nearest_i32_f32 v5, s1
// GFX12: v_cvt_nearest_i32_f32_e32 v5, s1        ; encoding: [0x01,0x18,0x0a,0x7e]

v_cvt_nearest_i32_f32 v5, s105
// GFX12: v_cvt_nearest_i32_f32_e32 v5, s105      ; encoding: [0x69,0x18,0x0a,0x7e]

v_cvt_nearest_i32_f32 v5, vcc_lo
// GFX12: v_cvt_nearest_i32_f32_e32 v5, vcc_lo    ; encoding: [0x6a,0x18,0x0a,0x7e]

v_cvt_nearest_i32_f32 v5, vcc_hi
// GFX12: v_cvt_nearest_i32_f32_e32 v5, vcc_hi    ; encoding: [0x6b,0x18,0x0a,0x7e]

v_cvt_nearest_i32_f32 v5, ttmp15
// GFX12: v_cvt_nearest_i32_f32_e32 v5, ttmp15    ; encoding: [0x7b,0x18,0x0a,0x7e]

v_cvt_nearest_i32_f32 v5, m0
// GFX12: v_cvt_nearest_i32_f32_e32 v5, m0        ; encoding: [0x7d,0x18,0x0a,0x7e]

v_cvt_nearest_i32_f32 v5, exec_lo
// GFX12: v_cvt_nearest_i32_f32_e32 v5, exec_lo   ; encoding: [0x7e,0x18,0x0a,0x7e]

v_cvt_nearest_i32_f32 v5, exec_hi
// GFX12: v_cvt_nearest_i32_f32_e32 v5, exec_hi   ; encoding: [0x7f,0x18,0x0a,0x7e]

v_cvt_nearest_i32_f32 v5, null
// GFX12: v_cvt_nearest_i32_f32_e32 v5, null      ; encoding: [0x7c,0x18,0x0a,0x7e]

v_cvt_nearest_i32_f32 v5, -1
// GFX12: v_cvt_nearest_i32_f32_e32 v5, -1        ; encoding: [0xc1,0x18,0x0a,0x7e]

v_cvt_nearest_i32_f32 v5, 0.5
// GFX12: v_cvt_nearest_i32_f32_e32 v5, 0.5       ; encoding: [0xf0,0x18,0x0a,0x7e]

v_cvt_nearest_i32_f32 v5, src_scc
// GFX12: v_cvt_nearest_i32_f32_e32 v5, src_scc   ; encoding: [0xfd,0x18,0x0a,0x7e]

v_cvt_nearest_i32_f32 v255, 0xaf123456
// GFX12: v_cvt_nearest_i32_f32_e32 v255, 0xaf123456 ; encoding: [0xff,0x18,0xfe,0x7f,0x56,0x34,0x12,0xaf]

v_cvt_norm_i16_f16 v5, v1
// GFX12: v_cvt_norm_i16_f16_e32 v5, v1           ; encoding: [0x01,0xc7,0x0a,0x7e]

v_cvt_norm_i16_f16 v5, v127
// GFX12: v_cvt_norm_i16_f16_e32 v5, v127         ; encoding: [0x7f,0xc7,0x0a,0x7e]

v_cvt_norm_i16_f16 v5, s1
// GFX12: v_cvt_norm_i16_f16_e32 v5, s1           ; encoding: [0x01,0xc6,0x0a,0x7e]

v_cvt_norm_i16_f16 v5, s105
// GFX12: v_cvt_norm_i16_f16_e32 v5, s105         ; encoding: [0x69,0xc6,0x0a,0x7e]

v_cvt_norm_i16_f16 v5, vcc_lo
// GFX12: v_cvt_norm_i16_f16_e32 v5, vcc_lo       ; encoding: [0x6a,0xc6,0x0a,0x7e]

v_cvt_norm_i16_f16 v5, vcc_hi
// GFX12: v_cvt_norm_i16_f16_e32 v5, vcc_hi       ; encoding: [0x6b,0xc6,0x0a,0x7e]

v_cvt_norm_i16_f16 v5, ttmp15
// GFX12: v_cvt_norm_i16_f16_e32 v5, ttmp15       ; encoding: [0x7b,0xc6,0x0a,0x7e]

v_cvt_norm_i16_f16 v5, m0
// GFX12: v_cvt_norm_i16_f16_e32 v5, m0           ; encoding: [0x7d,0xc6,0x0a,0x7e]

v_cvt_norm_i16_f16 v5, exec_lo
// GFX12: v_cvt_norm_i16_f16_e32 v5, exec_lo      ; encoding: [0x7e,0xc6,0x0a,0x7e]

v_cvt_norm_i16_f16 v5, exec_hi
// GFX12: v_cvt_norm_i16_f16_e32 v5, exec_hi      ; encoding: [0x7f,0xc6,0x0a,0x7e]

v_cvt_norm_i16_f16 v5, null
// GFX12: v_cvt_norm_i16_f16_e32 v5, null         ; encoding: [0x7c,0xc6,0x0a,0x7e]

v_cvt_norm_i16_f16 v5, -1
// GFX12: v_cvt_norm_i16_f16_e32 v5, -1           ; encoding: [0xc1,0xc6,0x0a,0x7e]

v_cvt_norm_i16_f16 v5, 0.5
// GFX12: v_cvt_norm_i16_f16_e32 v5, 0.5          ; encoding: [0xf0,0xc6,0x0a,0x7e]

v_cvt_norm_i16_f16 v5, src_scc
// GFX12: v_cvt_norm_i16_f16_e32 v5, src_scc      ; encoding: [0xfd,0xc6,0x0a,0x7e]

v_cvt_norm_i16_f16 v127, 0xfe0b
// GFX12: v_cvt_norm_i16_f16_e32 v127, 0xfe0b     ; encoding: [0xff,0xc6,0xfe,0x7e,0x0b,0xfe,0x00,0x00]

v_cvt_norm_u16_f16 v5, v1
// GFX12: v_cvt_norm_u16_f16_e32 v5, v1           ; encoding: [0x01,0xc9,0x0a,0x7e]

v_cvt_norm_u16_f16 v5, v127
// GFX12: v_cvt_norm_u16_f16_e32 v5, v127         ; encoding: [0x7f,0xc9,0x0a,0x7e]

v_cvt_norm_u16_f16 v5, s1
// GFX12: v_cvt_norm_u16_f16_e32 v5, s1           ; encoding: [0x01,0xc8,0x0a,0x7e]

v_cvt_norm_u16_f16 v5, s105
// GFX12: v_cvt_norm_u16_f16_e32 v5, s105         ; encoding: [0x69,0xc8,0x0a,0x7e]

v_cvt_norm_u16_f16 v5, vcc_lo
// GFX12: v_cvt_norm_u16_f16_e32 v5, vcc_lo       ; encoding: [0x6a,0xc8,0x0a,0x7e]

v_cvt_norm_u16_f16 v5, vcc_hi
// GFX12: v_cvt_norm_u16_f16_e32 v5, vcc_hi       ; encoding: [0x6b,0xc8,0x0a,0x7e]

v_cvt_norm_u16_f16 v5, ttmp15
// GFX12: v_cvt_norm_u16_f16_e32 v5, ttmp15       ; encoding: [0x7b,0xc8,0x0a,0x7e]

v_cvt_norm_u16_f16 v5, m0
// GFX12: v_cvt_norm_u16_f16_e32 v5, m0           ; encoding: [0x7d,0xc8,0x0a,0x7e]

v_cvt_norm_u16_f16 v5, exec_lo
// GFX12: v_cvt_norm_u16_f16_e32 v5, exec_lo      ; encoding: [0x7e,0xc8,0x0a,0x7e]

v_cvt_norm_u16_f16 v5, exec_hi
// GFX12: v_cvt_norm_u16_f16_e32 v5, exec_hi      ; encoding: [0x7f,0xc8,0x0a,0x7e]

v_cvt_norm_u16_f16 v5, null
// GFX12: v_cvt_norm_u16_f16_e32 v5, null         ; encoding: [0x7c,0xc8,0x0a,0x7e]

v_cvt_norm_u16_f16 v5, -1
// GFX12: v_cvt_norm_u16_f16_e32 v5, -1           ; encoding: [0xc1,0xc8,0x0a,0x7e]

v_cvt_norm_u16_f16 v5, 0.5
// GFX12: v_cvt_norm_u16_f16_e32 v5, 0.5          ; encoding: [0xf0,0xc8,0x0a,0x7e]

v_cvt_norm_u16_f16 v5, src_scc
// GFX12: v_cvt_norm_u16_f16_e32 v5, src_scc      ; encoding: [0xfd,0xc8,0x0a,0x7e]

v_cvt_norm_u16_f16 v127, 0xfe0b
// GFX12: v_cvt_norm_u16_f16_e32 v127, 0xfe0b     ; encoding: [0xff,0xc8,0xfe,0x7e,0x0b,0xfe,0x00,0x00]

v_cvt_off_f32_i4 v5, v1
// GFX12: v_cvt_off_f32_i4_e32 v5, v1             ; encoding: [0x01,0x1d,0x0a,0x7e]

v_cvt_off_f32_i4 v5, v255
// GFX12: v_cvt_off_f32_i4_e32 v5, v255           ; encoding: [0xff,0x1d,0x0a,0x7e]

v_cvt_off_f32_i4 v5, s1
// GFX12: v_cvt_off_f32_i4_e32 v5, s1             ; encoding: [0x01,0x1c,0x0a,0x7e]

v_cvt_off_f32_i4 v5, s105
// GFX12: v_cvt_off_f32_i4_e32 v5, s105           ; encoding: [0x69,0x1c,0x0a,0x7e]

v_cvt_off_f32_i4 v5, vcc_lo
// GFX12: v_cvt_off_f32_i4_e32 v5, vcc_lo         ; encoding: [0x6a,0x1c,0x0a,0x7e]

v_cvt_off_f32_i4 v5, vcc_hi
// GFX12: v_cvt_off_f32_i4_e32 v5, vcc_hi         ; encoding: [0x6b,0x1c,0x0a,0x7e]

v_cvt_off_f32_i4 v5, ttmp15
// GFX12: v_cvt_off_f32_i4_e32 v5, ttmp15         ; encoding: [0x7b,0x1c,0x0a,0x7e]

v_cvt_off_f32_i4 v5, m0
// GFX12: v_cvt_off_f32_i4_e32 v5, m0             ; encoding: [0x7d,0x1c,0x0a,0x7e]

v_cvt_off_f32_i4 v5, exec_lo
// GFX12: v_cvt_off_f32_i4_e32 v5, exec_lo        ; encoding: [0x7e,0x1c,0x0a,0x7e]

v_cvt_off_f32_i4 v5, exec_hi
// GFX12: v_cvt_off_f32_i4_e32 v5, exec_hi        ; encoding: [0x7f,0x1c,0x0a,0x7e]

v_cvt_off_f32_i4 v5, null
// GFX12: v_cvt_off_f32_i4_e32 v5, null           ; encoding: [0x7c,0x1c,0x0a,0x7e]

v_cvt_off_f32_i4 v5, -1
// GFX12: v_cvt_off_f32_i4_e32 v5, -1             ; encoding: [0xc1,0x1c,0x0a,0x7e]

v_cvt_off_f32_i4 v5, 0.5
// GFX12: v_cvt_off_f32_i4_e32 v5, 0.5            ; encoding: [0xf0,0x1c,0x0a,0x7e]

v_cvt_off_f32_i4 v5, src_scc
// GFX12: v_cvt_off_f32_i4_e32 v5, src_scc        ; encoding: [0xfd,0x1c,0x0a,0x7e]

v_cvt_off_f32_i4 v255, 0x4f
// GFX12: v_cvt_off_f32_i4_e32 v255, 0x4f         ; encoding: [0xff,0x1c,0xfe,0x7f,0x4f,0x00,0x00,0x00]

v_cvt_rpi_i32_f32 v5, v1
// GFX12: v_cvt_nearest_i32_f32_e32 v5, v1        ; encoding: [0x01,0x19,0x0a,0x7e]

v_cvt_rpi_i32_f32 v5, v255
// GFX12: v_cvt_nearest_i32_f32_e32 v5, v255      ; encoding: [0xff,0x19,0x0a,0x7e]

v_cvt_rpi_i32_f32 v5, s1
// GFX12: v_cvt_nearest_i32_f32_e32 v5, s1        ; encoding: [0x01,0x18,0x0a,0x7e]

v_cvt_rpi_i32_f32 v5, s105
// GFX12: v_cvt_nearest_i32_f32_e32 v5, s105      ; encoding: [0x69,0x18,0x0a,0x7e]

v_cvt_rpi_i32_f32 v5, vcc_lo
// GFX12: v_cvt_nearest_i32_f32_e32 v5, vcc_lo    ; encoding: [0x6a,0x18,0x0a,0x7e]

v_cvt_rpi_i32_f32 v5, vcc_hi
// GFX12: v_cvt_nearest_i32_f32_e32 v5, vcc_hi    ; encoding: [0x6b,0x18,0x0a,0x7e]

v_cvt_rpi_i32_f32 v5, ttmp15
// GFX12: v_cvt_nearest_i32_f32_e32 v5, ttmp15    ; encoding: [0x7b,0x18,0x0a,0x7e]

v_cvt_rpi_i32_f32 v5, m0
// GFX12: v_cvt_nearest_i32_f32_e32 v5, m0        ; encoding: [0x7d,0x18,0x0a,0x7e]

v_cvt_rpi_i32_f32 v5, exec_lo
// GFX12: v_cvt_nearest_i32_f32_e32 v5, exec_lo   ; encoding: [0x7e,0x18,0x0a,0x7e]

v_cvt_rpi_i32_f32 v5, exec_hi
// GFX12: v_cvt_nearest_i32_f32_e32 v5, exec_hi   ; encoding: [0x7f,0x18,0x0a,0x7e]

v_cvt_rpi_i32_f32 v5, null
// GFX12: v_cvt_nearest_i32_f32_e32 v5, null      ; encoding: [0x7c,0x18,0x0a,0x7e]

v_cvt_rpi_i32_f32 v5, -1
// GFX12: v_cvt_nearest_i32_f32_e32 v5, -1        ; encoding: [0xc1,0x18,0x0a,0x7e]

v_cvt_rpi_i32_f32 v5, 0.5
// GFX12: v_cvt_nearest_i32_f32_e32 v5, 0.5       ; encoding: [0xf0,0x18,0x0a,0x7e]

v_cvt_rpi_i32_f32 v5, src_scc
// GFX12: v_cvt_nearest_i32_f32_e32 v5, src_scc   ; encoding: [0xfd,0x18,0x0a,0x7e]

v_cvt_rpi_i32_f32 v255, 0xaf123456
// GFX12: v_cvt_nearest_i32_f32_e32 v255, 0xaf123456 ; encoding: [0xff,0x18,0xfe,0x7f,0x56,0x34,0x12,0xaf]

v_cvt_u16_f16 v5, v1
// GFX12: v_cvt_u16_f16_e32 v5, v1                ; encoding: [0x01,0xa5,0x0a,0x7e]

v_cvt_u16_f16 v5, v127
// GFX12: v_cvt_u16_f16_e32 v5, v127              ; encoding: [0x7f,0xa5,0x0a,0x7e]

v_cvt_u16_f16 v5, s1
// GFX12: v_cvt_u16_f16_e32 v5, s1                ; encoding: [0x01,0xa4,0x0a,0x7e]

v_cvt_u16_f16 v5, s105
// GFX12: v_cvt_u16_f16_e32 v5, s105              ; encoding: [0x69,0xa4,0x0a,0x7e]

v_cvt_u16_f16 v5, vcc_lo
// GFX12: v_cvt_u16_f16_e32 v5, vcc_lo            ; encoding: [0x6a,0xa4,0x0a,0x7e]

v_cvt_u16_f16 v5, vcc_hi
// GFX12: v_cvt_u16_f16_e32 v5, vcc_hi            ; encoding: [0x6b,0xa4,0x0a,0x7e]

v_cvt_u16_f16 v5, ttmp15
// GFX12: v_cvt_u16_f16_e32 v5, ttmp15            ; encoding: [0x7b,0xa4,0x0a,0x7e]

v_cvt_u16_f16 v5, m0
// GFX12: v_cvt_u16_f16_e32 v5, m0                ; encoding: [0x7d,0xa4,0x0a,0x7e]

v_cvt_u16_f16 v5, exec_lo
// GFX12: v_cvt_u16_f16_e32 v5, exec_lo           ; encoding: [0x7e,0xa4,0x0a,0x7e]

v_cvt_u16_f16 v5, exec_hi
// GFX12: v_cvt_u16_f16_e32 v5, exec_hi           ; encoding: [0x7f,0xa4,0x0a,0x7e]

v_cvt_u16_f16 v5, null
// GFX12: v_cvt_u16_f16_e32 v5, null              ; encoding: [0x7c,0xa4,0x0a,0x7e]

v_cvt_u16_f16 v5, -1
// GFX12: v_cvt_u16_f16_e32 v5, -1                ; encoding: [0xc1,0xa4,0x0a,0x7e]

v_cvt_u16_f16 v5, 0.5
// GFX12: v_cvt_u16_f16_e32 v5, 0.5               ; encoding: [0xf0,0xa4,0x0a,0x7e]

v_cvt_u16_f16 v5, src_scc
// GFX12: v_cvt_u16_f16_e32 v5, src_scc           ; encoding: [0xfd,0xa4,0x0a,0x7e]

v_cvt_u16_f16 v127, 0xfe0b
// GFX12: v_cvt_u16_f16_e32 v127, 0xfe0b          ; encoding: [0xff,0xa4,0xfe,0x7e,0x0b,0xfe,0x00,0x00]

v_cvt_u32_f32 v5, v1
// GFX12: v_cvt_u32_f32_e32 v5, v1                ; encoding: [0x01,0x0f,0x0a,0x7e]

v_cvt_u32_f32 v5, v255
// GFX12: v_cvt_u32_f32_e32 v5, v255              ; encoding: [0xff,0x0f,0x0a,0x7e]

v_cvt_u32_f32 v5, s1
// GFX12: v_cvt_u32_f32_e32 v5, s1                ; encoding: [0x01,0x0e,0x0a,0x7e]

v_cvt_u32_f32 v5, s105
// GFX12: v_cvt_u32_f32_e32 v5, s105              ; encoding: [0x69,0x0e,0x0a,0x7e]

v_cvt_u32_f32 v5, vcc_lo
// GFX12: v_cvt_u32_f32_e32 v5, vcc_lo            ; encoding: [0x6a,0x0e,0x0a,0x7e]

v_cvt_u32_f32 v5, vcc_hi
// GFX12: v_cvt_u32_f32_e32 v5, vcc_hi            ; encoding: [0x6b,0x0e,0x0a,0x7e]

v_cvt_u32_f32 v5, ttmp15
// GFX12: v_cvt_u32_f32_e32 v5, ttmp15            ; encoding: [0x7b,0x0e,0x0a,0x7e]

v_cvt_u32_f32 v5, m0
// GFX12: v_cvt_u32_f32_e32 v5, m0                ; encoding: [0x7d,0x0e,0x0a,0x7e]

v_cvt_u32_f32 v5, exec_lo
// GFX12: v_cvt_u32_f32_e32 v5, exec_lo           ; encoding: [0x7e,0x0e,0x0a,0x7e]

v_cvt_u32_f32 v5, exec_hi
// GFX12: v_cvt_u32_f32_e32 v5, exec_hi           ; encoding: [0x7f,0x0e,0x0a,0x7e]

v_cvt_u32_f32 v5, null
// GFX12: v_cvt_u32_f32_e32 v5, null              ; encoding: [0x7c,0x0e,0x0a,0x7e]

v_cvt_u32_f32 v5, -1
// GFX12: v_cvt_u32_f32_e32 v5, -1                ; encoding: [0xc1,0x0e,0x0a,0x7e]

v_cvt_u32_f32 v5, 0.5
// GFX12: v_cvt_u32_f32_e32 v5, 0.5               ; encoding: [0xf0,0x0e,0x0a,0x7e]

v_cvt_u32_f32 v5, src_scc
// GFX12: v_cvt_u32_f32_e32 v5, src_scc           ; encoding: [0xfd,0x0e,0x0a,0x7e]

v_cvt_u32_f32 v255, 0xaf123456
// GFX12: v_cvt_u32_f32_e32 v255, 0xaf123456      ; encoding: [0xff,0x0e,0xfe,0x7f,0x56,0x34,0x12,0xaf]

v_cvt_u32_f64 v5, v[1:2]
// GFX12: v_cvt_u32_f64_e32 v5, v[1:2]            ; encoding: [0x01,0x2b,0x0a,0x7e]

v_cvt_u32_f64 v5, v[254:255]
// GFX12: v_cvt_u32_f64_e32 v5, v[254:255]        ; encoding: [0xfe,0x2b,0x0a,0x7e]

v_cvt_u32_f64 v5, s[2:3]
// GFX12: v_cvt_u32_f64_e32 v5, s[2:3]            ; encoding: [0x02,0x2a,0x0a,0x7e]

v_cvt_u32_f64 v5, s[104:105]
// GFX12: v_cvt_u32_f64_e32 v5, s[104:105]        ; encoding: [0x68,0x2a,0x0a,0x7e]

v_cvt_u32_f64 v5, vcc
// GFX12: v_cvt_u32_f64_e32 v5, vcc               ; encoding: [0x6a,0x2a,0x0a,0x7e]

v_cvt_u32_f64 v5, ttmp[14:15]
// GFX12: v_cvt_u32_f64_e32 v5, ttmp[14:15]       ; encoding: [0x7a,0x2a,0x0a,0x7e]

v_cvt_u32_f64 v5, exec
// GFX12: v_cvt_u32_f64_e32 v5, exec              ; encoding: [0x7e,0x2a,0x0a,0x7e]

v_cvt_u32_f64 v5, null
// GFX12: v_cvt_u32_f64_e32 v5, null              ; encoding: [0x7c,0x2a,0x0a,0x7e]

v_cvt_u32_f64 v5, -1
// GFX12: v_cvt_u32_f64_e32 v5, -1                ; encoding: [0xc1,0x2a,0x0a,0x7e]

v_cvt_u32_f64 v5, 0.5
// GFX12: v_cvt_u32_f64_e32 v5, 0.5               ; encoding: [0xf0,0x2a,0x0a,0x7e]

v_cvt_u32_f64 v5, src_scc
// GFX12: v_cvt_u32_f64_e32 v5, src_scc           ; encoding: [0xfd,0x2a,0x0a,0x7e]

v_cvt_u32_f64 v255, 0xaf123456
// GFX12: v_cvt_u32_f64_e32 v255, 0xaf123456      ; encoding: [0xff,0x2a,0xfe,0x7f,0x56,0x34,0x12,0xaf]

v_cvt_u32_u16 v5, v1
// GFX12: v_cvt_u32_u16_e32 v5, v1                ; encoding: [0x01,0xd7,0x0a,0x7e]

v_cvt_u32_u16 v5, v127
// GFX12: v_cvt_u32_u16_e32 v5, v127              ; encoding: [0x7f,0xd7,0x0a,0x7e]

v_cvt_u32_u16 v5, s1
// GFX12: v_cvt_u32_u16_e32 v5, s1                ; encoding: [0x01,0xd6,0x0a,0x7e]

v_cvt_u32_u16 v5, s105
// GFX12: v_cvt_u32_u16_e32 v5, s105              ; encoding: [0x69,0xd6,0x0a,0x7e]

v_cvt_u32_u16 v5, vcc_lo
// GFX12: v_cvt_u32_u16_e32 v5, vcc_lo            ; encoding: [0x6a,0xd6,0x0a,0x7e]

v_cvt_u32_u16 v5, vcc_hi
// GFX12: v_cvt_u32_u16_e32 v5, vcc_hi            ; encoding: [0x6b,0xd6,0x0a,0x7e]

v_cvt_u32_u16 v5, ttmp15
// GFX12: v_cvt_u32_u16_e32 v5, ttmp15            ; encoding: [0x7b,0xd6,0x0a,0x7e]

v_cvt_u32_u16 v5, m0
// GFX12: v_cvt_u32_u16_e32 v5, m0                ; encoding: [0x7d,0xd6,0x0a,0x7e]

v_cvt_u32_u16 v5, exec_lo
// GFX12: v_cvt_u32_u16_e32 v5, exec_lo           ; encoding: [0x7e,0xd6,0x0a,0x7e]

v_cvt_u32_u16 v5, exec_hi
// GFX12: v_cvt_u32_u16_e32 v5, exec_hi           ; encoding: [0x7f,0xd6,0x0a,0x7e]

v_cvt_u32_u16 v5, null
// GFX12: v_cvt_u32_u16_e32 v5, null              ; encoding: [0x7c,0xd6,0x0a,0x7e]

v_cvt_u32_u16 v5, -1
// GFX12: v_cvt_u32_u16_e32 v5, -1                ; encoding: [0xc1,0xd6,0x0a,0x7e]

v_cvt_u32_u16 v5, 0.5
// GFX12-ASM: v_cvt_u32_u16_e32 v5, 0.5               ; encoding: [0xf0,0xd6,0x0a,0x7e]
// GFX12-DIS: v_cvt_u32_u16_e32 v5, 0x3800            ; encoding: [0xff,0xd6,0x0a,0x7e,0x00,0x38,0x00,0x00]

v_cvt_u32_u16 v5, src_scc
// GFX12: v_cvt_u32_u16_e32 v5, src_scc           ; encoding: [0xfd,0xd6,0x0a,0x7e]

v_cvt_u32_u16 v255, 0xfe0b
// GFX12: v_cvt_u32_u16_e32 v255, 0xfe0b          ; encoding: [0xff,0xd6,0xfe,0x7f,0x0b,0xfe,0x00,0x00]

v_exp_f16 v5, v1
// GFX12: v_exp_f16_e32 v5, v1                    ; encoding: [0x01,0xb1,0x0a,0x7e]

v_exp_f16 v5, v127
// GFX12: v_exp_f16_e32 v5, v127                  ; encoding: [0x7f,0xb1,0x0a,0x7e]

v_exp_f16 v5, s1
// GFX12: v_exp_f16_e32 v5, s1                    ; encoding: [0x01,0xb0,0x0a,0x7e]

v_exp_f16 v5, s105
// GFX12: v_exp_f16_e32 v5, s105                  ; encoding: [0x69,0xb0,0x0a,0x7e]

v_exp_f16 v5, vcc_lo
// GFX12: v_exp_f16_e32 v5, vcc_lo                ; encoding: [0x6a,0xb0,0x0a,0x7e]

v_exp_f16 v5, vcc_hi
// GFX12: v_exp_f16_e32 v5, vcc_hi                ; encoding: [0x6b,0xb0,0x0a,0x7e]

v_exp_f16 v5, ttmp15
// GFX12: v_exp_f16_e32 v5, ttmp15                ; encoding: [0x7b,0xb0,0x0a,0x7e]

v_exp_f16 v5, m0
// GFX12: v_exp_f16_e32 v5, m0                    ; encoding: [0x7d,0xb0,0x0a,0x7e]

v_exp_f16 v5, exec_lo
// GFX12: v_exp_f16_e32 v5, exec_lo               ; encoding: [0x7e,0xb0,0x0a,0x7e]

v_exp_f16 v5, exec_hi
// GFX12: v_exp_f16_e32 v5, exec_hi               ; encoding: [0x7f,0xb0,0x0a,0x7e]

v_exp_f16 v5, null
// GFX12: v_exp_f16_e32 v5, null                  ; encoding: [0x7c,0xb0,0x0a,0x7e]

v_exp_f16 v5, -1
// GFX12: v_exp_f16_e32 v5, -1                    ; encoding: [0xc1,0xb0,0x0a,0x7e]

v_exp_f16 v5, 0.5
// GFX12: v_exp_f16_e32 v5, 0.5                   ; encoding: [0xf0,0xb0,0x0a,0x7e]

v_exp_f16 v5, src_scc
// GFX12: v_exp_f16_e32 v5, src_scc               ; encoding: [0xfd,0xb0,0x0a,0x7e]

v_exp_f16 v127, 0xfe0b
// GFX12: v_exp_f16_e32 v127, 0xfe0b              ; encoding: [0xff,0xb0,0xfe,0x7e,0x0b,0xfe,0x00,0x00]

v_exp_f32 v5, v1
// GFX12: v_exp_f32_e32 v5, v1                    ; encoding: [0x01,0x4b,0x0a,0x7e]

v_exp_f32 v5, v255
// GFX12: v_exp_f32_e32 v5, v255                  ; encoding: [0xff,0x4b,0x0a,0x7e]

v_exp_f32 v5, s1
// GFX12: v_exp_f32_e32 v5, s1                    ; encoding: [0x01,0x4a,0x0a,0x7e]

v_exp_f32 v5, s105
// GFX12: v_exp_f32_e32 v5, s105                  ; encoding: [0x69,0x4a,0x0a,0x7e]

v_exp_f32 v5, vcc_lo
// GFX12: v_exp_f32_e32 v5, vcc_lo                ; encoding: [0x6a,0x4a,0x0a,0x7e]

v_exp_f32 v5, vcc_hi
// GFX12: v_exp_f32_e32 v5, vcc_hi                ; encoding: [0x6b,0x4a,0x0a,0x7e]

v_exp_f32 v5, ttmp15
// GFX12: v_exp_f32_e32 v5, ttmp15                ; encoding: [0x7b,0x4a,0x0a,0x7e]

v_exp_f32 v5, m0
// GFX12: v_exp_f32_e32 v5, m0                    ; encoding: [0x7d,0x4a,0x0a,0x7e]

v_exp_f32 v5, exec_lo
// GFX12: v_exp_f32_e32 v5, exec_lo               ; encoding: [0x7e,0x4a,0x0a,0x7e]

v_exp_f32 v5, exec_hi
// GFX12: v_exp_f32_e32 v5, exec_hi               ; encoding: [0x7f,0x4a,0x0a,0x7e]

v_exp_f32 v5, null
// GFX12: v_exp_f32_e32 v5, null                  ; encoding: [0x7c,0x4a,0x0a,0x7e]

v_exp_f32 v5, -1
// GFX12: v_exp_f32_e32 v5, -1                    ; encoding: [0xc1,0x4a,0x0a,0x7e]

v_exp_f32 v5, 0.5
// GFX12: v_exp_f32_e32 v5, 0.5                   ; encoding: [0xf0,0x4a,0x0a,0x7e]

v_exp_f32 v5, src_scc
// GFX12: v_exp_f32_e32 v5, src_scc               ; encoding: [0xfd,0x4a,0x0a,0x7e]

v_exp_f32 v255, 0xaf123456
// GFX12: v_exp_f32_e32 v255, 0xaf123456          ; encoding: [0xff,0x4a,0xfe,0x7f,0x56,0x34,0x12,0xaf]

v_ffbh_i32 v5, v1
// GFX12: v_cls_i32_e32 v5, v1                    ; encoding: [0x01,0x77,0x0a,0x7e]

v_ffbh_i32 v5, v255
// GFX12: v_cls_i32_e32 v5, v255                  ; encoding: [0xff,0x77,0x0a,0x7e]

v_ffbh_i32 v5, s1
// GFX12: v_cls_i32_e32 v5, s1                    ; encoding: [0x01,0x76,0x0a,0x7e]

v_ffbh_i32 v5, s105
// GFX12: v_cls_i32_e32 v5, s105                  ; encoding: [0x69,0x76,0x0a,0x7e]

v_ffbh_i32 v5, vcc_lo
// GFX12: v_cls_i32_e32 v5, vcc_lo                ; encoding: [0x6a,0x76,0x0a,0x7e]

v_ffbh_i32 v5, vcc_hi
// GFX12: v_cls_i32_e32 v5, vcc_hi                ; encoding: [0x6b,0x76,0x0a,0x7e]

v_ffbh_i32 v5, ttmp15
// GFX12: v_cls_i32_e32 v5, ttmp15                ; encoding: [0x7b,0x76,0x0a,0x7e]

v_ffbh_i32 v5, m0
// GFX12: v_cls_i32_e32 v5, m0                    ; encoding: [0x7d,0x76,0x0a,0x7e]

v_ffbh_i32 v5, exec_lo
// GFX12: v_cls_i32_e32 v5, exec_lo               ; encoding: [0x7e,0x76,0x0a,0x7e]

v_ffbh_i32 v5, exec_hi
// GFX12: v_cls_i32_e32 v5, exec_hi               ; encoding: [0x7f,0x76,0x0a,0x7e]

v_ffbh_i32 v5, null
// GFX12: v_cls_i32_e32 v5, null                  ; encoding: [0x7c,0x76,0x0a,0x7e]

v_ffbh_i32 v5, -1
// GFX12: v_cls_i32_e32 v5, -1                    ; encoding: [0xc1,0x76,0x0a,0x7e]

v_ffbh_i32 v5, 0.5
// GFX12: v_cls_i32_e32 v5, 0.5                   ; encoding: [0xf0,0x76,0x0a,0x7e]

v_ffbh_i32 v5, src_scc
// GFX12: v_cls_i32_e32 v5, src_scc               ; encoding: [0xfd,0x76,0x0a,0x7e]

v_ffbh_i32 v255, 0xaf123456
// GFX12: v_cls_i32_e32 v255, 0xaf123456          ; encoding: [0xff,0x76,0xfe,0x7f,0x56,0x34,0x12,0xaf]

v_ffbh_u32 v5, v1
// GFX12: v_clz_i32_u32_e32 v5, v1                ; encoding: [0x01,0x73,0x0a,0x7e]

v_ffbh_u32 v5, v255
// GFX12: v_clz_i32_u32_e32 v5, v255              ; encoding: [0xff,0x73,0x0a,0x7e]

v_ffbh_u32 v5, s1
// GFX12: v_clz_i32_u32_e32 v5, s1                ; encoding: [0x01,0x72,0x0a,0x7e]

v_ffbh_u32 v5, s105
// GFX12: v_clz_i32_u32_e32 v5, s105              ; encoding: [0x69,0x72,0x0a,0x7e]

v_ffbh_u32 v5, vcc_lo
// GFX12: v_clz_i32_u32_e32 v5, vcc_lo            ; encoding: [0x6a,0x72,0x0a,0x7e]

v_ffbh_u32 v5, vcc_hi
// GFX12: v_clz_i32_u32_e32 v5, vcc_hi            ; encoding: [0x6b,0x72,0x0a,0x7e]

v_ffbh_u32 v5, ttmp15
// GFX12: v_clz_i32_u32_e32 v5, ttmp15            ; encoding: [0x7b,0x72,0x0a,0x7e]

v_ffbh_u32 v5, m0
// GFX12: v_clz_i32_u32_e32 v5, m0                ; encoding: [0x7d,0x72,0x0a,0x7e]

v_ffbh_u32 v5, exec_lo
// GFX12: v_clz_i32_u32_e32 v5, exec_lo           ; encoding: [0x7e,0x72,0x0a,0x7e]

v_ffbh_u32 v5, exec_hi
// GFX12: v_clz_i32_u32_e32 v5, exec_hi           ; encoding: [0x7f,0x72,0x0a,0x7e]

v_ffbh_u32 v5, null
// GFX12: v_clz_i32_u32_e32 v5, null              ; encoding: [0x7c,0x72,0x0a,0x7e]

v_ffbh_u32 v5, -1
// GFX12: v_clz_i32_u32_e32 v5, -1                ; encoding: [0xc1,0x72,0x0a,0x7e]

v_ffbh_u32 v5, 0.5
// GFX12: v_clz_i32_u32_e32 v5, 0.5               ; encoding: [0xf0,0x72,0x0a,0x7e]

v_ffbh_u32 v5, src_scc
// GFX12: v_clz_i32_u32_e32 v5, src_scc           ; encoding: [0xfd,0x72,0x0a,0x7e]

v_ffbh_u32 v255, 0xaf123456
// GFX12: v_clz_i32_u32_e32 v255, 0xaf123456      ; encoding: [0xff,0x72,0xfe,0x7f,0x56,0x34,0x12,0xaf]

v_ffbl_b32 v5, v1
// GFX12: v_ctz_i32_b32_e32 v5, v1                ; encoding: [0x01,0x75,0x0a,0x7e]

v_ffbl_b32 v5, v255
// GFX12: v_ctz_i32_b32_e32 v5, v255              ; encoding: [0xff,0x75,0x0a,0x7e]

v_ffbl_b32 v5, s1
// GFX12: v_ctz_i32_b32_e32 v5, s1                ; encoding: [0x01,0x74,0x0a,0x7e]

v_ffbl_b32 v5, s105
// GFX12: v_ctz_i32_b32_e32 v5, s105              ; encoding: [0x69,0x74,0x0a,0x7e]

v_ffbl_b32 v5, vcc_lo
// GFX12: v_ctz_i32_b32_e32 v5, vcc_lo            ; encoding: [0x6a,0x74,0x0a,0x7e]

v_ffbl_b32 v5, vcc_hi
// GFX12: v_ctz_i32_b32_e32 v5, vcc_hi            ; encoding: [0x6b,0x74,0x0a,0x7e]

v_ffbl_b32 v5, ttmp15
// GFX12: v_ctz_i32_b32_e32 v5, ttmp15            ; encoding: [0x7b,0x74,0x0a,0x7e]

v_ffbl_b32 v5, m0
// GFX12: v_ctz_i32_b32_e32 v5, m0                ; encoding: [0x7d,0x74,0x0a,0x7e]

v_ffbl_b32 v5, exec_lo
// GFX12: v_ctz_i32_b32_e32 v5, exec_lo           ; encoding: [0x7e,0x74,0x0a,0x7e]

v_ffbl_b32 v5, exec_hi
// GFX12: v_ctz_i32_b32_e32 v5, exec_hi           ; encoding: [0x7f,0x74,0x0a,0x7e]

v_ffbl_b32 v5, null
// GFX12: v_ctz_i32_b32_e32 v5, null              ; encoding: [0x7c,0x74,0x0a,0x7e]

v_ffbl_b32 v5, -1
// GFX12: v_ctz_i32_b32_e32 v5, -1                ; encoding: [0xc1,0x74,0x0a,0x7e]

v_ffbl_b32 v5, 0.5
// GFX12: v_ctz_i32_b32_e32 v5, 0.5               ; encoding: [0xf0,0x74,0x0a,0x7e]

v_ffbl_b32 v5, src_scc
// GFX12: v_ctz_i32_b32_e32 v5, src_scc           ; encoding: [0xfd,0x74,0x0a,0x7e]

v_ffbl_b32 v255, 0xaf123456
// GFX12: v_ctz_i32_b32_e32 v255, 0xaf123456      ; encoding: [0xff,0x74,0xfe,0x7f,0x56,0x34,0x12,0xaf]

v_floor_f16 v5, v1
// GFX12: v_floor_f16_e32 v5, v1                  ; encoding: [0x01,0xb7,0x0a,0x7e]

v_floor_f16 v5, v127
// GFX12: v_floor_f16_e32 v5, v127                ; encoding: [0x7f,0xb7,0x0a,0x7e]

v_floor_f16 v5, s1
// GFX12: v_floor_f16_e32 v5, s1                  ; encoding: [0x01,0xb6,0x0a,0x7e]

v_floor_f16 v5, s105
// GFX12: v_floor_f16_e32 v5, s105                ; encoding: [0x69,0xb6,0x0a,0x7e]

v_floor_f16 v5, vcc_lo
// GFX12: v_floor_f16_e32 v5, vcc_lo              ; encoding: [0x6a,0xb6,0x0a,0x7e]

v_floor_f16 v5, vcc_hi
// GFX12: v_floor_f16_e32 v5, vcc_hi              ; encoding: [0x6b,0xb6,0x0a,0x7e]

v_floor_f16 v5, ttmp15
// GFX12: v_floor_f16_e32 v5, ttmp15              ; encoding: [0x7b,0xb6,0x0a,0x7e]

v_floor_f16 v5, m0
// GFX12: v_floor_f16_e32 v5, m0                  ; encoding: [0x7d,0xb6,0x0a,0x7e]

v_floor_f16 v5, exec_lo
// GFX12: v_floor_f16_e32 v5, exec_lo             ; encoding: [0x7e,0xb6,0x0a,0x7e]

v_floor_f16 v5, exec_hi
// GFX12: v_floor_f16_e32 v5, exec_hi             ; encoding: [0x7f,0xb6,0x0a,0x7e]

v_floor_f16 v5, null
// GFX12: v_floor_f16_e32 v5, null                ; encoding: [0x7c,0xb6,0x0a,0x7e]

v_floor_f16 v5, -1
// GFX12: v_floor_f16_e32 v5, -1                  ; encoding: [0xc1,0xb6,0x0a,0x7e]

v_floor_f16 v5, 0.5
// GFX12: v_floor_f16_e32 v5, 0.5                 ; encoding: [0xf0,0xb6,0x0a,0x7e]

v_floor_f16 v5, src_scc
// GFX12: v_floor_f16_e32 v5, src_scc             ; encoding: [0xfd,0xb6,0x0a,0x7e]

v_floor_f16 v127, 0xfe0b
// GFX12: v_floor_f16_e32 v127, 0xfe0b            ; encoding: [0xff,0xb6,0xfe,0x7e,0x0b,0xfe,0x00,0x00]

v_floor_f32 v5, v1
// GFX12: v_floor_f32_e32 v5, v1                  ; encoding: [0x01,0x49,0x0a,0x7e]

v_floor_f32 v5, v255
// GFX12: v_floor_f32_e32 v5, v255                ; encoding: [0xff,0x49,0x0a,0x7e]

v_floor_f32 v5, s1
// GFX12: v_floor_f32_e32 v5, s1                  ; encoding: [0x01,0x48,0x0a,0x7e]

v_floor_f32 v5, s105
// GFX12: v_floor_f32_e32 v5, s105                ; encoding: [0x69,0x48,0x0a,0x7e]

v_floor_f32 v5, vcc_lo
// GFX12: v_floor_f32_e32 v5, vcc_lo              ; encoding: [0x6a,0x48,0x0a,0x7e]

v_floor_f32 v5, vcc_hi
// GFX12: v_floor_f32_e32 v5, vcc_hi              ; encoding: [0x6b,0x48,0x0a,0x7e]

v_floor_f32 v5, ttmp15
// GFX12: v_floor_f32_e32 v5, ttmp15              ; encoding: [0x7b,0x48,0x0a,0x7e]

v_floor_f32 v5, m0
// GFX12: v_floor_f32_e32 v5, m0                  ; encoding: [0x7d,0x48,0x0a,0x7e]

v_floor_f32 v5, exec_lo
// GFX12: v_floor_f32_e32 v5, exec_lo             ; encoding: [0x7e,0x48,0x0a,0x7e]

v_floor_f32 v5, exec_hi
// GFX12: v_floor_f32_e32 v5, exec_hi             ; encoding: [0x7f,0x48,0x0a,0x7e]

v_floor_f32 v5, null
// GFX12: v_floor_f32_e32 v5, null                ; encoding: [0x7c,0x48,0x0a,0x7e]

v_floor_f32 v5, -1
// GFX12: v_floor_f32_e32 v5, -1                  ; encoding: [0xc1,0x48,0x0a,0x7e]

v_floor_f32 v5, 0.5
// GFX12: v_floor_f32_e32 v5, 0.5                 ; encoding: [0xf0,0x48,0x0a,0x7e]

v_floor_f32 v5, src_scc
// GFX12: v_floor_f32_e32 v5, src_scc             ; encoding: [0xfd,0x48,0x0a,0x7e]

v_floor_f32 v255, 0xaf123456
// GFX12: v_floor_f32_e32 v255, 0xaf123456        ; encoding: [0xff,0x48,0xfe,0x7f,0x56,0x34,0x12,0xaf]

v_floor_f64 v[5:6], v[1:2]
// GFX12: v_floor_f64_e32 v[5:6], v[1:2]          ; encoding: [0x01,0x35,0x0a,0x7e]

v_floor_f64 v[5:6], v[254:255]
// GFX12: v_floor_f64_e32 v[5:6], v[254:255]      ; encoding: [0xfe,0x35,0x0a,0x7e]

v_floor_f64 v[5:6], s[2:3]
// GFX12: v_floor_f64_e32 v[5:6], s[2:3]          ; encoding: [0x02,0x34,0x0a,0x7e]

v_floor_f64 v[5:6], s[104:105]
// GFX12: v_floor_f64_e32 v[5:6], s[104:105]      ; encoding: [0x68,0x34,0x0a,0x7e]

v_floor_f64 v[5:6], vcc
// GFX12: v_floor_f64_e32 v[5:6], vcc             ; encoding: [0x6a,0x34,0x0a,0x7e]

v_floor_f64 v[5:6], ttmp[14:15]
// GFX12: v_floor_f64_e32 v[5:6], ttmp[14:15]     ; encoding: [0x7a,0x34,0x0a,0x7e]

v_floor_f64 v[5:6], exec
// GFX12: v_floor_f64_e32 v[5:6], exec            ; encoding: [0x7e,0x34,0x0a,0x7e]

v_floor_f64 v[5:6], null
// GFX12: v_floor_f64_e32 v[5:6], null            ; encoding: [0x7c,0x34,0x0a,0x7e]

v_floor_f64 v[5:6], -1
// GFX12: v_floor_f64_e32 v[5:6], -1              ; encoding: [0xc1,0x34,0x0a,0x7e]

v_floor_f64 v[5:6], 0.5
// GFX12: v_floor_f64_e32 v[5:6], 0.5             ; encoding: [0xf0,0x34,0x0a,0x7e]

v_floor_f64 v[5:6], src_scc
// GFX12: v_floor_f64_e32 v[5:6], src_scc         ; encoding: [0xfd,0x34,0x0a,0x7e]

v_floor_f64 v[254:255], 0xaf123456
// GFX12: v_floor_f64_e32 v[254:255], 0xaf123456  ; encoding: [0xff,0x34,0xfc,0x7f,0x56,0x34,0x12,0xaf]

v_fract_f16 v5, v1
// GFX12: v_fract_f16_e32 v5, v1                  ; encoding: [0x01,0xbf,0x0a,0x7e]

v_fract_f16 v5, v127
// GFX12: v_fract_f16_e32 v5, v127                ; encoding: [0x7f,0xbf,0x0a,0x7e]

v_fract_f16 v5, s1
// GFX12: v_fract_f16_e32 v5, s1                  ; encoding: [0x01,0xbe,0x0a,0x7e]

v_fract_f16 v5, s105
// GFX12: v_fract_f16_e32 v5, s105                ; encoding: [0x69,0xbe,0x0a,0x7e]

v_fract_f16 v5, vcc_lo
// GFX12: v_fract_f16_e32 v5, vcc_lo              ; encoding: [0x6a,0xbe,0x0a,0x7e]

v_fract_f16 v5, vcc_hi
// GFX12: v_fract_f16_e32 v5, vcc_hi              ; encoding: [0x6b,0xbe,0x0a,0x7e]

v_fract_f16 v5, ttmp15
// GFX12: v_fract_f16_e32 v5, ttmp15              ; encoding: [0x7b,0xbe,0x0a,0x7e]

v_fract_f16 v5, m0
// GFX12: v_fract_f16_e32 v5, m0                  ; encoding: [0x7d,0xbe,0x0a,0x7e]

v_fract_f16 v5, exec_lo
// GFX12: v_fract_f16_e32 v5, exec_lo             ; encoding: [0x7e,0xbe,0x0a,0x7e]

v_fract_f16 v5, exec_hi
// GFX12: v_fract_f16_e32 v5, exec_hi             ; encoding: [0x7f,0xbe,0x0a,0x7e]

v_fract_f16 v5, null
// GFX12: v_fract_f16_e32 v5, null                ; encoding: [0x7c,0xbe,0x0a,0x7e]

v_fract_f16 v5, -1
// GFX12: v_fract_f16_e32 v5, -1                  ; encoding: [0xc1,0xbe,0x0a,0x7e]

v_fract_f16 v5, 0.5
// GFX12: v_fract_f16_e32 v5, 0.5                 ; encoding: [0xf0,0xbe,0x0a,0x7e]

v_fract_f16 v5, src_scc
// GFX12: v_fract_f16_e32 v5, src_scc             ; encoding: [0xfd,0xbe,0x0a,0x7e]

v_fract_f16 v127, 0xfe0b
// GFX12: v_fract_f16_e32 v127, 0xfe0b            ; encoding: [0xff,0xbe,0xfe,0x7e,0x0b,0xfe,0x00,0x00]

v_fract_f32 v5, v1
// GFX12: v_fract_f32_e32 v5, v1                  ; encoding: [0x01,0x41,0x0a,0x7e]

v_fract_f32 v5, v255
// GFX12: v_fract_f32_e32 v5, v255                ; encoding: [0xff,0x41,0x0a,0x7e]

v_fract_f32 v5, s1
// GFX12: v_fract_f32_e32 v5, s1                  ; encoding: [0x01,0x40,0x0a,0x7e]

v_fract_f32 v5, s105
// GFX12: v_fract_f32_e32 v5, s105                ; encoding: [0x69,0x40,0x0a,0x7e]

v_fract_f32 v5, vcc_lo
// GFX12: v_fract_f32_e32 v5, vcc_lo              ; encoding: [0x6a,0x40,0x0a,0x7e]

v_fract_f32 v5, vcc_hi
// GFX12: v_fract_f32_e32 v5, vcc_hi              ; encoding: [0x6b,0x40,0x0a,0x7e]

v_fract_f32 v5, ttmp15
// GFX12: v_fract_f32_e32 v5, ttmp15              ; encoding: [0x7b,0x40,0x0a,0x7e]

v_fract_f32 v5, m0
// GFX12: v_fract_f32_e32 v5, m0                  ; encoding: [0x7d,0x40,0x0a,0x7e]

v_fract_f32 v5, exec_lo
// GFX12: v_fract_f32_e32 v5, exec_lo             ; encoding: [0x7e,0x40,0x0a,0x7e]

v_fract_f32 v5, exec_hi
// GFX12: v_fract_f32_e32 v5, exec_hi             ; encoding: [0x7f,0x40,0x0a,0x7e]

v_fract_f32 v5, null
// GFX12: v_fract_f32_e32 v5, null                ; encoding: [0x7c,0x40,0x0a,0x7e]

v_fract_f32 v5, -1
// GFX12: v_fract_f32_e32 v5, -1                  ; encoding: [0xc1,0x40,0x0a,0x7e]

v_fract_f32 v5, 0.5
// GFX12: v_fract_f32_e32 v5, 0.5                 ; encoding: [0xf0,0x40,0x0a,0x7e]

v_fract_f32 v5, src_scc
// GFX12: v_fract_f32_e32 v5, src_scc             ; encoding: [0xfd,0x40,0x0a,0x7e]

v_fract_f32 v255, 0xaf123456
// GFX12: v_fract_f32_e32 v255, 0xaf123456        ; encoding: [0xff,0x40,0xfe,0x7f,0x56,0x34,0x12,0xaf]

v_fract_f64 v[5:6], v[1:2]
// GFX12: v_fract_f64_e32 v[5:6], v[1:2]          ; encoding: [0x01,0x7d,0x0a,0x7e]

v_fract_f64 v[5:6], v[254:255]
// GFX12: v_fract_f64_e32 v[5:6], v[254:255]      ; encoding: [0xfe,0x7d,0x0a,0x7e]

v_fract_f64 v[5:6], s[2:3]
// GFX12: v_fract_f64_e32 v[5:6], s[2:3]          ; encoding: [0x02,0x7c,0x0a,0x7e]

v_fract_f64 v[5:6], s[104:105]
// GFX12: v_fract_f64_e32 v[5:6], s[104:105]      ; encoding: [0x68,0x7c,0x0a,0x7e]

v_fract_f64 v[5:6], vcc
// GFX12: v_fract_f64_e32 v[5:6], vcc             ; encoding: [0x6a,0x7c,0x0a,0x7e]

v_fract_f64 v[5:6], ttmp[14:15]
// GFX12: v_fract_f64_e32 v[5:6], ttmp[14:15]     ; encoding: [0x7a,0x7c,0x0a,0x7e]

v_fract_f64 v[5:6], exec
// GFX12: v_fract_f64_e32 v[5:6], exec            ; encoding: [0x7e,0x7c,0x0a,0x7e]

v_fract_f64 v[5:6], null
// GFX12: v_fract_f64_e32 v[5:6], null            ; encoding: [0x7c,0x7c,0x0a,0x7e]

v_fract_f64 v[5:6], -1
// GFX12: v_fract_f64_e32 v[5:6], -1              ; encoding: [0xc1,0x7c,0x0a,0x7e]

v_fract_f64 v[5:6], 0.5
// GFX12: v_fract_f64_e32 v[5:6], 0.5             ; encoding: [0xf0,0x7c,0x0a,0x7e]

v_fract_f64 v[5:6], src_scc
// GFX12: v_fract_f64_e32 v[5:6], src_scc         ; encoding: [0xfd,0x7c,0x0a,0x7e]

v_fract_f64 v[254:255], 0xaf123456
// GFX12: v_fract_f64_e32 v[254:255], 0xaf123456  ; encoding: [0xff,0x7c,0xfc,0x7f,0x56,0x34,0x12,0xaf]

v_frexp_exp_i16_f16 v5, v1
// GFX12: v_frexp_exp_i16_f16_e32 v5, v1          ; encoding: [0x01,0xb5,0x0a,0x7e]

v_frexp_exp_i16_f16 v5, v127
// GFX12: v_frexp_exp_i16_f16_e32 v5, v127        ; encoding: [0x7f,0xb5,0x0a,0x7e]

v_frexp_exp_i16_f16 v5, s1
// GFX12: v_frexp_exp_i16_f16_e32 v5, s1          ; encoding: [0x01,0xb4,0x0a,0x7e]

v_frexp_exp_i16_f16 v5, s105
// GFX12: v_frexp_exp_i16_f16_e32 v5, s105        ; encoding: [0x69,0xb4,0x0a,0x7e]

v_frexp_exp_i16_f16 v5, vcc_lo
// GFX12: v_frexp_exp_i16_f16_e32 v5, vcc_lo      ; encoding: [0x6a,0xb4,0x0a,0x7e]

v_frexp_exp_i16_f16 v5, vcc_hi
// GFX12: v_frexp_exp_i16_f16_e32 v5, vcc_hi      ; encoding: [0x6b,0xb4,0x0a,0x7e]

v_frexp_exp_i16_f16 v5, ttmp15
// GFX12: v_frexp_exp_i16_f16_e32 v5, ttmp15      ; encoding: [0x7b,0xb4,0x0a,0x7e]

v_frexp_exp_i16_f16 v5, m0
// GFX12: v_frexp_exp_i16_f16_e32 v5, m0          ; encoding: [0x7d,0xb4,0x0a,0x7e]

v_frexp_exp_i16_f16 v5, exec_lo
// GFX12: v_frexp_exp_i16_f16_e32 v5, exec_lo     ; encoding: [0x7e,0xb4,0x0a,0x7e]

v_frexp_exp_i16_f16 v5, exec_hi
// GFX12: v_frexp_exp_i16_f16_e32 v5, exec_hi     ; encoding: [0x7f,0xb4,0x0a,0x7e]

v_frexp_exp_i16_f16 v5, null
// GFX12: v_frexp_exp_i16_f16_e32 v5, null        ; encoding: [0x7c,0xb4,0x0a,0x7e]

v_frexp_exp_i16_f16 v5, -1
// GFX12: v_frexp_exp_i16_f16_e32 v5, -1          ; encoding: [0xc1,0xb4,0x0a,0x7e]

v_frexp_exp_i16_f16 v5, 0.5
// GFX12: v_frexp_exp_i16_f16_e32 v5, 0.5         ; encoding: [0xf0,0xb4,0x0a,0x7e]

v_frexp_exp_i16_f16 v5, src_scc
// GFX12: v_frexp_exp_i16_f16_e32 v5, src_scc     ; encoding: [0xfd,0xb4,0x0a,0x7e]

v_frexp_exp_i16_f16 v127, 0xfe0b
// GFX12: v_frexp_exp_i16_f16_e32 v127, 0xfe0b    ; encoding: [0xff,0xb4,0xfe,0x7e,0x0b,0xfe,0x00,0x00]

v_frexp_exp_i32_f32 v5, v1
// GFX12: v_frexp_exp_i32_f32_e32 v5, v1          ; encoding: [0x01,0x7f,0x0a,0x7e]

v_frexp_exp_i32_f32 v5, v255
// GFX12: v_frexp_exp_i32_f32_e32 v5, v255        ; encoding: [0xff,0x7f,0x0a,0x7e]

v_frexp_exp_i32_f32 v5, s1
// GFX12: v_frexp_exp_i32_f32_e32 v5, s1          ; encoding: [0x01,0x7e,0x0a,0x7e]

v_frexp_exp_i32_f32 v5, s105
// GFX12: v_frexp_exp_i32_f32_e32 v5, s105        ; encoding: [0x69,0x7e,0x0a,0x7e]

v_frexp_exp_i32_f32 v5, vcc_lo
// GFX12: v_frexp_exp_i32_f32_e32 v5, vcc_lo      ; encoding: [0x6a,0x7e,0x0a,0x7e]

v_frexp_exp_i32_f32 v5, vcc_hi
// GFX12: v_frexp_exp_i32_f32_e32 v5, vcc_hi      ; encoding: [0x6b,0x7e,0x0a,0x7e]

v_frexp_exp_i32_f32 v5, ttmp15
// GFX12: v_frexp_exp_i32_f32_e32 v5, ttmp15      ; encoding: [0x7b,0x7e,0x0a,0x7e]

v_frexp_exp_i32_f32 v5, m0
// GFX12: v_frexp_exp_i32_f32_e32 v5, m0          ; encoding: [0x7d,0x7e,0x0a,0x7e]

v_frexp_exp_i32_f32 v5, exec_lo
// GFX12: v_frexp_exp_i32_f32_e32 v5, exec_lo     ; encoding: [0x7e,0x7e,0x0a,0x7e]

v_frexp_exp_i32_f32 v5, exec_hi
// GFX12: v_frexp_exp_i32_f32_e32 v5, exec_hi     ; encoding: [0x7f,0x7e,0x0a,0x7e]

v_frexp_exp_i32_f32 v5, null
// GFX12: v_frexp_exp_i32_f32_e32 v5, null        ; encoding: [0x7c,0x7e,0x0a,0x7e]

v_frexp_exp_i32_f32 v5, -1
// GFX12: v_frexp_exp_i32_f32_e32 v5, -1          ; encoding: [0xc1,0x7e,0x0a,0x7e]

v_frexp_exp_i32_f32 v5, 0.5
// GFX12: v_frexp_exp_i32_f32_e32 v5, 0.5         ; encoding: [0xf0,0x7e,0x0a,0x7e]

v_frexp_exp_i32_f32 v5, src_scc
// GFX12: v_frexp_exp_i32_f32_e32 v5, src_scc     ; encoding: [0xfd,0x7e,0x0a,0x7e]

v_frexp_exp_i32_f32 v255, 0xaf123456
// GFX12: v_frexp_exp_i32_f32_e32 v255, 0xaf123456 ; encoding: [0xff,0x7e,0xfe,0x7f,0x56,0x34,0x12,0xaf]

v_frexp_exp_i32_f64 v5, v[1:2]
// GFX12: v_frexp_exp_i32_f64_e32 v5, v[1:2]      ; encoding: [0x01,0x79,0x0a,0x7e]

v_frexp_exp_i32_f64 v5, v[254:255]
// GFX12: v_frexp_exp_i32_f64_e32 v5, v[254:255]  ; encoding: [0xfe,0x79,0x0a,0x7e]

v_frexp_exp_i32_f64 v5, s[2:3]
// GFX12: v_frexp_exp_i32_f64_e32 v5, s[2:3]      ; encoding: [0x02,0x78,0x0a,0x7e]

v_frexp_exp_i32_f64 v5, s[104:105]
// GFX12: v_frexp_exp_i32_f64_e32 v5, s[104:105]  ; encoding: [0x68,0x78,0x0a,0x7e]

v_frexp_exp_i32_f64 v5, vcc
// GFX12: v_frexp_exp_i32_f64_e32 v5, vcc         ; encoding: [0x6a,0x78,0x0a,0x7e]

v_frexp_exp_i32_f64 v5, ttmp[14:15]
// GFX12: v_frexp_exp_i32_f64_e32 v5, ttmp[14:15] ; encoding: [0x7a,0x78,0x0a,0x7e]

v_frexp_exp_i32_f64 v5, exec
// GFX12: v_frexp_exp_i32_f64_e32 v5, exec        ; encoding: [0x7e,0x78,0x0a,0x7e]

v_frexp_exp_i32_f64 v5, null
// GFX12: v_frexp_exp_i32_f64_e32 v5, null        ; encoding: [0x7c,0x78,0x0a,0x7e]

v_frexp_exp_i32_f64 v5, -1
// GFX12: v_frexp_exp_i32_f64_e32 v5, -1          ; encoding: [0xc1,0x78,0x0a,0x7e]

v_frexp_exp_i32_f64 v5, 0.5
// GFX12: v_frexp_exp_i32_f64_e32 v5, 0.5         ; encoding: [0xf0,0x78,0x0a,0x7e]

v_frexp_exp_i32_f64 v5, src_scc
// GFX12: v_frexp_exp_i32_f64_e32 v5, src_scc     ; encoding: [0xfd,0x78,0x0a,0x7e]

v_frexp_exp_i32_f64 v255, 0xaf123456
// GFX12: v_frexp_exp_i32_f64_e32 v255, 0xaf123456 ; encoding: [0xff,0x78,0xfe,0x7f,0x56,0x34,0x12,0xaf]

v_frexp_mant_f16 v5, v1
// GFX12: v_frexp_mant_f16_e32 v5, v1             ; encoding: [0x01,0xb3,0x0a,0x7e]

v_frexp_mant_f16 v5, v127
// GFX12: v_frexp_mant_f16_e32 v5, v127           ; encoding: [0x7f,0xb3,0x0a,0x7e]

v_frexp_mant_f16 v5, s1
// GFX12: v_frexp_mant_f16_e32 v5, s1             ; encoding: [0x01,0xb2,0x0a,0x7e]

v_frexp_mant_f16 v5, s105
// GFX12: v_frexp_mant_f16_e32 v5, s105           ; encoding: [0x69,0xb2,0x0a,0x7e]

v_frexp_mant_f16 v5, vcc_lo
// GFX12: v_frexp_mant_f16_e32 v5, vcc_lo         ; encoding: [0x6a,0xb2,0x0a,0x7e]

v_frexp_mant_f16 v5, vcc_hi
// GFX12: v_frexp_mant_f16_e32 v5, vcc_hi         ; encoding: [0x6b,0xb2,0x0a,0x7e]

v_frexp_mant_f16 v5, ttmp15
// GFX12: v_frexp_mant_f16_e32 v5, ttmp15         ; encoding: [0x7b,0xb2,0x0a,0x7e]

v_frexp_mant_f16 v5, m0
// GFX12: v_frexp_mant_f16_e32 v5, m0             ; encoding: [0x7d,0xb2,0x0a,0x7e]

v_frexp_mant_f16 v5, exec_lo
// GFX12: v_frexp_mant_f16_e32 v5, exec_lo        ; encoding: [0x7e,0xb2,0x0a,0x7e]

v_frexp_mant_f16 v5, exec_hi
// GFX12: v_frexp_mant_f16_e32 v5, exec_hi        ; encoding: [0x7f,0xb2,0x0a,0x7e]

v_frexp_mant_f16 v5, null
// GFX12: v_frexp_mant_f16_e32 v5, null           ; encoding: [0x7c,0xb2,0x0a,0x7e]

v_frexp_mant_f16 v5, -1
// GFX12: v_frexp_mant_f16_e32 v5, -1             ; encoding: [0xc1,0xb2,0x0a,0x7e]

v_frexp_mant_f16 v5, 0.5
// GFX12: v_frexp_mant_f16_e32 v5, 0.5            ; encoding: [0xf0,0xb2,0x0a,0x7e]

v_frexp_mant_f16 v5, src_scc
// GFX12: v_frexp_mant_f16_e32 v5, src_scc        ; encoding: [0xfd,0xb2,0x0a,0x7e]

v_frexp_mant_f16 v127, 0xfe0b
// GFX12: v_frexp_mant_f16_e32 v127, 0xfe0b       ; encoding: [0xff,0xb2,0xfe,0x7e,0x0b,0xfe,0x00,0x00]

v_frexp_mant_f32 v5, v1
// GFX12: v_frexp_mant_f32_e32 v5, v1             ; encoding: [0x01,0x81,0x0a,0x7e]

v_frexp_mant_f32 v5, v255
// GFX12: v_frexp_mant_f32_e32 v5, v255           ; encoding: [0xff,0x81,0x0a,0x7e]

v_frexp_mant_f32 v5, s1
// GFX12: v_frexp_mant_f32_e32 v5, s1             ; encoding: [0x01,0x80,0x0a,0x7e]

v_frexp_mant_f32 v5, s105
// GFX12: v_frexp_mant_f32_e32 v5, s105           ; encoding: [0x69,0x80,0x0a,0x7e]

v_frexp_mant_f32 v5, vcc_lo
// GFX12: v_frexp_mant_f32_e32 v5, vcc_lo         ; encoding: [0x6a,0x80,0x0a,0x7e]

v_frexp_mant_f32 v5, vcc_hi
// GFX12: v_frexp_mant_f32_e32 v5, vcc_hi         ; encoding: [0x6b,0x80,0x0a,0x7e]

v_frexp_mant_f32 v5, ttmp15
// GFX12: v_frexp_mant_f32_e32 v5, ttmp15         ; encoding: [0x7b,0x80,0x0a,0x7e]

v_frexp_mant_f32 v5, m0
// GFX12: v_frexp_mant_f32_e32 v5, m0             ; encoding: [0x7d,0x80,0x0a,0x7e]

v_frexp_mant_f32 v5, exec_lo
// GFX12: v_frexp_mant_f32_e32 v5, exec_lo        ; encoding: [0x7e,0x80,0x0a,0x7e]

v_frexp_mant_f32 v5, exec_hi
// GFX12: v_frexp_mant_f32_e32 v5, exec_hi        ; encoding: [0x7f,0x80,0x0a,0x7e]

v_frexp_mant_f32 v5, null
// GFX12: v_frexp_mant_f32_e32 v5, null           ; encoding: [0x7c,0x80,0x0a,0x7e]

v_frexp_mant_f32 v5, -1
// GFX12: v_frexp_mant_f32_e32 v5, -1             ; encoding: [0xc1,0x80,0x0a,0x7e]

v_frexp_mant_f32 v5, 0.5
// GFX12: v_frexp_mant_f32_e32 v5, 0.5            ; encoding: [0xf0,0x80,0x0a,0x7e]

v_frexp_mant_f32 v5, src_scc
// GFX12: v_frexp_mant_f32_e32 v5, src_scc        ; encoding: [0xfd,0x80,0x0a,0x7e]

v_frexp_mant_f32 v255, 0xaf123456
// GFX12: v_frexp_mant_f32_e32 v255, 0xaf123456   ; encoding: [0xff,0x80,0xfe,0x7f,0x56,0x34,0x12,0xaf]

v_frexp_mant_f64 v[5:6], v[1:2]
// GFX12: v_frexp_mant_f64_e32 v[5:6], v[1:2]     ; encoding: [0x01,0x7b,0x0a,0x7e]

v_frexp_mant_f64 v[5:6], v[254:255]
// GFX12: v_frexp_mant_f64_e32 v[5:6], v[254:255] ; encoding: [0xfe,0x7b,0x0a,0x7e]

v_frexp_mant_f64 v[5:6], s[2:3]
// GFX12: v_frexp_mant_f64_e32 v[5:6], s[2:3]     ; encoding: [0x02,0x7a,0x0a,0x7e]

v_frexp_mant_f64 v[5:6], s[104:105]
// GFX12: v_frexp_mant_f64_e32 v[5:6], s[104:105] ; encoding: [0x68,0x7a,0x0a,0x7e]

v_frexp_mant_f64 v[5:6], vcc
// GFX12: v_frexp_mant_f64_e32 v[5:6], vcc        ; encoding: [0x6a,0x7a,0x0a,0x7e]

v_frexp_mant_f64 v[5:6], ttmp[14:15]
// GFX12: v_frexp_mant_f64_e32 v[5:6], ttmp[14:15] ; encoding: [0x7a,0x7a,0x0a,0x7e]

v_frexp_mant_f64 v[5:6], exec
// GFX12: v_frexp_mant_f64_e32 v[5:6], exec       ; encoding: [0x7e,0x7a,0x0a,0x7e]

v_frexp_mant_f64 v[5:6], null
// GFX12: v_frexp_mant_f64_e32 v[5:6], null       ; encoding: [0x7c,0x7a,0x0a,0x7e]

v_frexp_mant_f64 v[5:6], -1
// GFX12: v_frexp_mant_f64_e32 v[5:6], -1         ; encoding: [0xc1,0x7a,0x0a,0x7e]

v_frexp_mant_f64 v[5:6], 0.5
// GFX12: v_frexp_mant_f64_e32 v[5:6], 0.5        ; encoding: [0xf0,0x7a,0x0a,0x7e]

v_frexp_mant_f64 v[5:6], src_scc
// GFX12: v_frexp_mant_f64_e32 v[5:6], src_scc    ; encoding: [0xfd,0x7a,0x0a,0x7e]

v_frexp_mant_f64 v[254:255], 0xaf123456
// GFX12: v_frexp_mant_f64_e32 v[254:255], 0xaf123456 ; encoding: [0xff,0x7a,0xfc,0x7f,0x56,0x34,0x12,0xaf]

v_log_f16 v5, v1
// GFX12: v_log_f16_e32 v5, v1                    ; encoding: [0x01,0xaf,0x0a,0x7e]

v_log_f16 v5, v127
// GFX12: v_log_f16_e32 v5, v127                  ; encoding: [0x7f,0xaf,0x0a,0x7e]

v_log_f16 v5, s1
// GFX12: v_log_f16_e32 v5, s1                    ; encoding: [0x01,0xae,0x0a,0x7e]

v_log_f16 v5, s105
// GFX12: v_log_f16_e32 v5, s105                  ; encoding: [0x69,0xae,0x0a,0x7e]

v_log_f16 v5, vcc_lo
// GFX12: v_log_f16_e32 v5, vcc_lo                ; encoding: [0x6a,0xae,0x0a,0x7e]

v_log_f16 v5, vcc_hi
// GFX12: v_log_f16_e32 v5, vcc_hi                ; encoding: [0x6b,0xae,0x0a,0x7e]

v_log_f16 v5, ttmp15
// GFX12: v_log_f16_e32 v5, ttmp15                ; encoding: [0x7b,0xae,0x0a,0x7e]

v_log_f16 v5, m0
// GFX12: v_log_f16_e32 v5, m0                    ; encoding: [0x7d,0xae,0x0a,0x7e]

v_log_f16 v5, exec_lo
// GFX12: v_log_f16_e32 v5, exec_lo               ; encoding: [0x7e,0xae,0x0a,0x7e]

v_log_f16 v5, exec_hi
// GFX12: v_log_f16_e32 v5, exec_hi               ; encoding: [0x7f,0xae,0x0a,0x7e]

v_log_f16 v5, null
// GFX12: v_log_f16_e32 v5, null                  ; encoding: [0x7c,0xae,0x0a,0x7e]

v_log_f16 v5, -1
// GFX12: v_log_f16_e32 v5, -1                    ; encoding: [0xc1,0xae,0x0a,0x7e]

v_log_f16 v5, 0.5
// GFX12: v_log_f16_e32 v5, 0.5                   ; encoding: [0xf0,0xae,0x0a,0x7e]

v_log_f16 v5, src_scc
// GFX12: v_log_f16_e32 v5, src_scc               ; encoding: [0xfd,0xae,0x0a,0x7e]

v_log_f16 v127, 0xfe0b
// GFX12: v_log_f16_e32 v127, 0xfe0b              ; encoding: [0xff,0xae,0xfe,0x7e,0x0b,0xfe,0x00,0x00]

v_log_f32 v5, v1
// GFX12: v_log_f32_e32 v5, v1                    ; encoding: [0x01,0x4f,0x0a,0x7e]

v_log_f32 v5, v255
// GFX12: v_log_f32_e32 v5, v255                  ; encoding: [0xff,0x4f,0x0a,0x7e]

v_log_f32 v5, s1
// GFX12: v_log_f32_e32 v5, s1                    ; encoding: [0x01,0x4e,0x0a,0x7e]

v_log_f32 v5, s105
// GFX12: v_log_f32_e32 v5, s105                  ; encoding: [0x69,0x4e,0x0a,0x7e]

v_log_f32 v5, vcc_lo
// GFX12: v_log_f32_e32 v5, vcc_lo                ; encoding: [0x6a,0x4e,0x0a,0x7e]

v_log_f32 v5, vcc_hi
// GFX12: v_log_f32_e32 v5, vcc_hi                ; encoding: [0x6b,0x4e,0x0a,0x7e]

v_log_f32 v5, ttmp15
// GFX12: v_log_f32_e32 v5, ttmp15                ; encoding: [0x7b,0x4e,0x0a,0x7e]

v_log_f32 v5, m0
// GFX12: v_log_f32_e32 v5, m0                    ; encoding: [0x7d,0x4e,0x0a,0x7e]

v_log_f32 v5, exec_lo
// GFX12: v_log_f32_e32 v5, exec_lo               ; encoding: [0x7e,0x4e,0x0a,0x7e]

v_log_f32 v5, exec_hi
// GFX12: v_log_f32_e32 v5, exec_hi               ; encoding: [0x7f,0x4e,0x0a,0x7e]

v_log_f32 v5, null
// GFX12: v_log_f32_e32 v5, null                  ; encoding: [0x7c,0x4e,0x0a,0x7e]

v_log_f32 v5, -1
// GFX12: v_log_f32_e32 v5, -1                    ; encoding: [0xc1,0x4e,0x0a,0x7e]

v_log_f32 v5, 0.5
// GFX12: v_log_f32_e32 v5, 0.5                   ; encoding: [0xf0,0x4e,0x0a,0x7e]

v_log_f32 v5, src_scc
// GFX12: v_log_f32_e32 v5, src_scc               ; encoding: [0xfd,0x4e,0x0a,0x7e]

v_log_f32 v255, 0xaf123456
// GFX12: v_log_f32_e32 v255, 0xaf123456          ; encoding: [0xff,0x4e,0xfe,0x7f,0x56,0x34,0x12,0xaf]

v_mov_b32 v5, v1
// GFX12: v_mov_b32_e32 v5, v1                    ; encoding: [0x01,0x03,0x0a,0x7e]

v_mov_b32 v5, v255
// GFX12: v_mov_b32_e32 v5, v255                  ; encoding: [0xff,0x03,0x0a,0x7e]

v_mov_b32 v5, s1
// GFX12: v_mov_b32_e32 v5, s1                    ; encoding: [0x01,0x02,0x0a,0x7e]

v_mov_b32 v5, s105
// GFX12: v_mov_b32_e32 v5, s105                  ; encoding: [0x69,0x02,0x0a,0x7e]

v_mov_b32 v5, vcc_lo
// GFX12: v_mov_b32_e32 v5, vcc_lo                ; encoding: [0x6a,0x02,0x0a,0x7e]

v_mov_b32 v5, vcc_hi
// GFX12: v_mov_b32_e32 v5, vcc_hi                ; encoding: [0x6b,0x02,0x0a,0x7e]

v_mov_b32 v5, ttmp15
// GFX12: v_mov_b32_e32 v5, ttmp15                ; encoding: [0x7b,0x02,0x0a,0x7e]

v_mov_b32 v5, m0
// GFX12: v_mov_b32_e32 v5, m0                    ; encoding: [0x7d,0x02,0x0a,0x7e]

v_mov_b32 v5, exec_lo
// GFX12: v_mov_b32_e32 v5, exec_lo               ; encoding: [0x7e,0x02,0x0a,0x7e]

v_mov_b32 v5, exec_hi
// GFX12: v_mov_b32_e32 v5, exec_hi               ; encoding: [0x7f,0x02,0x0a,0x7e]

v_mov_b32 v5, null
// GFX12: v_mov_b32_e32 v5, null                  ; encoding: [0x7c,0x02,0x0a,0x7e]

v_mov_b32 v5, -1
// GFX12: v_mov_b32_e32 v5, -1                    ; encoding: [0xc1,0x02,0x0a,0x7e]

v_mov_b32 v5, 0.5
// GFX12: v_mov_b32_e32 v5, 0.5                   ; encoding: [0xf0,0x02,0x0a,0x7e]

v_mov_b32 v5, src_scc
// GFX12: v_mov_b32_e32 v5, src_scc               ; encoding: [0xfd,0x02,0x0a,0x7e]

v_mov_b32 v255, 0xaf123456
// GFX12: v_mov_b32_e32 v255, 0xaf123456          ; encoding: [0xff,0x02,0xfe,0x7f,0x56,0x34,0x12,0xaf]

v_movreld_b32 v5, v1
// GFX12: v_movreld_b32_e32 v5, v1                ; encoding: [0x01,0x85,0x0a,0x7e]

v_movreld_b32 v5, v255
// GFX12: v_movreld_b32_e32 v5, v255              ; encoding: [0xff,0x85,0x0a,0x7e]

v_movreld_b32 v5, s1
// GFX12: v_movreld_b32_e32 v5, s1                ; encoding: [0x01,0x84,0x0a,0x7e]

v_movreld_b32 v5, s105
// GFX12: v_movreld_b32_e32 v5, s105              ; encoding: [0x69,0x84,0x0a,0x7e]

v_movreld_b32 v5, vcc_lo
// GFX12: v_movreld_b32_e32 v5, vcc_lo            ; encoding: [0x6a,0x84,0x0a,0x7e]

v_movreld_b32 v5, vcc_hi
// GFX12: v_movreld_b32_e32 v5, vcc_hi            ; encoding: [0x6b,0x84,0x0a,0x7e]

v_movreld_b32 v5, ttmp15
// GFX12: v_movreld_b32_e32 v5, ttmp15            ; encoding: [0x7b,0x84,0x0a,0x7e]

v_movreld_b32 v5, m0
// GFX12: v_movreld_b32_e32 v5, m0                ; encoding: [0x7d,0x84,0x0a,0x7e]

v_movreld_b32 v5, exec_lo
// GFX12: v_movreld_b32_e32 v5, exec_lo           ; encoding: [0x7e,0x84,0x0a,0x7e]

v_movreld_b32 v5, exec_hi
// GFX12: v_movreld_b32_e32 v5, exec_hi           ; encoding: [0x7f,0x84,0x0a,0x7e]

v_movreld_b32 v5, null
// GFX12: v_movreld_b32_e32 v5, null              ; encoding: [0x7c,0x84,0x0a,0x7e]

v_movreld_b32 v5, -1
// GFX12: v_movreld_b32_e32 v5, -1                ; encoding: [0xc1,0x84,0x0a,0x7e]

v_movreld_b32 v5, 0.5
// GFX12: v_movreld_b32_e32 v5, 0.5               ; encoding: [0xf0,0x84,0x0a,0x7e]

v_movreld_b32 v5, src_scc
// GFX12: v_movreld_b32_e32 v5, src_scc           ; encoding: [0xfd,0x84,0x0a,0x7e]

v_movreld_b32 v255, 0xaf123456
// GFX12: v_movreld_b32_e32 v255, 0xaf123456      ; encoding: [0xff,0x84,0xfe,0x7f,0x56,0x34,0x12,0xaf]

v_movrels_b32 v5, v1
// GFX12: v_movrels_b32_e32 v5, v1                ; encoding: [0x01,0x87,0x0a,0x7e]

v_movrels_b32 v255, v255
// GFX12: v_movrels_b32_e32 v255, v255            ; encoding: [0xff,0x87,0xfe,0x7f]

v_movrelsd_2_b32 v5, v1
// GFX12: v_movrelsd_2_b32_e32 v5, v1             ; encoding: [0x01,0x91,0x0a,0x7e]

v_movrelsd_2_b32 v255, v255
// GFX12: v_movrelsd_2_b32_e32 v255, v255         ; encoding: [0xff,0x91,0xfe,0x7f]

v_movrelsd_b32 v5, v1
// GFX12: v_movrelsd_b32_e32 v5, v1               ; encoding: [0x01,0x89,0x0a,0x7e]

v_movrelsd_b32 v255, v255
// GFX12: v_movrelsd_b32_e32 v255, v255           ; encoding: [0xff,0x89,0xfe,0x7f]

v_nop
// GFX12: v_nop                                   ; encoding: [0x00,0x00,0x00,0x7e]

v_not_b16 v5, v1
// GFX12: v_not_b16_e32 v5, v1                    ; encoding: [0x01,0xd3,0x0a,0x7e]

v_not_b16 v5, v127
// GFX12: v_not_b16_e32 v5, v127                  ; encoding: [0x7f,0xd3,0x0a,0x7e]

v_not_b16 v5, s1
// GFX12: v_not_b16_e32 v5, s1                    ; encoding: [0x01,0xd2,0x0a,0x7e]

v_not_b16 v5, s105
// GFX12: v_not_b16_e32 v5, s105                  ; encoding: [0x69,0xd2,0x0a,0x7e]

v_not_b16 v5, vcc_lo
// GFX12: v_not_b16_e32 v5, vcc_lo                ; encoding: [0x6a,0xd2,0x0a,0x7e]

v_not_b16 v5, vcc_hi
// GFX12: v_not_b16_e32 v5, vcc_hi                ; encoding: [0x6b,0xd2,0x0a,0x7e]

v_not_b16 v5, ttmp15
// GFX12: v_not_b16_e32 v5, ttmp15                ; encoding: [0x7b,0xd2,0x0a,0x7e]

v_not_b16 v5, m0
// GFX12: v_not_b16_e32 v5, m0                    ; encoding: [0x7d,0xd2,0x0a,0x7e]

v_not_b16 v5, exec_lo
// GFX12: v_not_b16_e32 v5, exec_lo               ; encoding: [0x7e,0xd2,0x0a,0x7e]

v_not_b16 v5, exec_hi
// GFX12: v_not_b16_e32 v5, exec_hi               ; encoding: [0x7f,0xd2,0x0a,0x7e]

v_not_b16 v5, null
// GFX12: v_not_b16_e32 v5, null                  ; encoding: [0x7c,0xd2,0x0a,0x7e]

v_not_b16 v5, -1
// GFX12: v_not_b16_e32 v5, -1                    ; encoding: [0xc1,0xd2,0x0a,0x7e]

v_not_b16 v5, 0.5
// GFX12-ASM: v_not_b16_e32 v5, 0.5                   ; encoding: [0xf0,0xd2,0x0a,0x7e]
// GFX12-DIS: v_not_b16_e32 v5, 0x3800                ; encoding: [0xff,0xd2,0x0a,0x7e,0x00,0x38,0x00,0x00]

v_not_b16 v5, src_scc
// GFX12: v_not_b16_e32 v5, src_scc               ; encoding: [0xfd,0xd2,0x0a,0x7e]

v_not_b16 v127, 0xfe0b
// GFX12: v_not_b16_e32 v127, 0xfe0b              ; encoding: [0xff,0xd2,0xfe,0x7e,0x0b,0xfe,0x00,0x00]

v_not_b32 v5, v1
// GFX12: v_not_b32_e32 v5, v1                    ; encoding: [0x01,0x6f,0x0a,0x7e]

v_not_b32 v5, v255
// GFX12: v_not_b32_e32 v5, v255                  ; encoding: [0xff,0x6f,0x0a,0x7e]

v_not_b32 v5, s1
// GFX12: v_not_b32_e32 v5, s1                    ; encoding: [0x01,0x6e,0x0a,0x7e]

v_not_b32 v5, s105
// GFX12: v_not_b32_e32 v5, s105                  ; encoding: [0x69,0x6e,0x0a,0x7e]

v_not_b32 v5, vcc_lo
// GFX12: v_not_b32_e32 v5, vcc_lo                ; encoding: [0x6a,0x6e,0x0a,0x7e]

v_not_b32 v5, vcc_hi
// GFX12: v_not_b32_e32 v5, vcc_hi                ; encoding: [0x6b,0x6e,0x0a,0x7e]

v_not_b32 v5, ttmp15
// GFX12: v_not_b32_e32 v5, ttmp15                ; encoding: [0x7b,0x6e,0x0a,0x7e]

v_not_b32 v5, m0
// GFX12: v_not_b32_e32 v5, m0                    ; encoding: [0x7d,0x6e,0x0a,0x7e]

v_not_b32 v5, exec_lo
// GFX12: v_not_b32_e32 v5, exec_lo               ; encoding: [0x7e,0x6e,0x0a,0x7e]

v_not_b32 v5, exec_hi
// GFX12: v_not_b32_e32 v5, exec_hi               ; encoding: [0x7f,0x6e,0x0a,0x7e]

v_not_b32 v5, null
// GFX12: v_not_b32_e32 v5, null                  ; encoding: [0x7c,0x6e,0x0a,0x7e]

v_not_b32 v5, -1
// GFX12: v_not_b32_e32 v5, -1                    ; encoding: [0xc1,0x6e,0x0a,0x7e]

v_not_b32 v5, 0.5
// GFX12: v_not_b32_e32 v5, 0.5                   ; encoding: [0xf0,0x6e,0x0a,0x7e]

v_not_b32 v5, src_scc
// GFX12: v_not_b32_e32 v5, src_scc               ; encoding: [0xfd,0x6e,0x0a,0x7e]

v_not_b32 v255, 0xaf123456
// GFX12: v_not_b32_e32 v255, 0xaf123456          ; encoding: [0xff,0x6e,0xfe,0x7f,0x56,0x34,0x12,0xaf]

v_permlane64_b32 v5, v1
// GFX12: v_permlane64_b32 v5, v1                 ; encoding: [0x01,0xcf,0x0a,0x7e]

v_permlane64_b32 v255, v255
// GFX12: v_permlane64_b32 v255, v255             ; encoding: [0xff,0xcf,0xfe,0x7f]

v_pipeflush
// GFX12: v_pipeflush                             ; encoding: [0x00,0x36,0x00,0x7e]

v_rcp_f16 v5, v1
// GFX12: v_rcp_f16_e32 v5, v1                    ; encoding: [0x01,0xa9,0x0a,0x7e]

v_rcp_f16 v5, v127
// GFX12: v_rcp_f16_e32 v5, v127                  ; encoding: [0x7f,0xa9,0x0a,0x7e]

v_rcp_f16 v5, s1
// GFX12: v_rcp_f16_e32 v5, s1                    ; encoding: [0x01,0xa8,0x0a,0x7e]

v_rcp_f16 v5, s105
// GFX12: v_rcp_f16_e32 v5, s105                  ; encoding: [0x69,0xa8,0x0a,0x7e]

v_rcp_f16 v5, vcc_lo
// GFX12: v_rcp_f16_e32 v5, vcc_lo                ; encoding: [0x6a,0xa8,0x0a,0x7e]

v_rcp_f16 v5, vcc_hi
// GFX12: v_rcp_f16_e32 v5, vcc_hi                ; encoding: [0x6b,0xa8,0x0a,0x7e]

v_rcp_f16 v5, ttmp15
// GFX12: v_rcp_f16_e32 v5, ttmp15                ; encoding: [0x7b,0xa8,0x0a,0x7e]

v_rcp_f16 v5, m0
// GFX12: v_rcp_f16_e32 v5, m0                    ; encoding: [0x7d,0xa8,0x0a,0x7e]

v_rcp_f16 v5, exec_lo
// GFX12: v_rcp_f16_e32 v5, exec_lo               ; encoding: [0x7e,0xa8,0x0a,0x7e]

v_rcp_f16 v5, exec_hi
// GFX12: v_rcp_f16_e32 v5, exec_hi               ; encoding: [0x7f,0xa8,0x0a,0x7e]

v_rcp_f16 v5, null
// GFX12: v_rcp_f16_e32 v5, null                  ; encoding: [0x7c,0xa8,0x0a,0x7e]

v_rcp_f16 v5, -1
// GFX12: v_rcp_f16_e32 v5, -1                    ; encoding: [0xc1,0xa8,0x0a,0x7e]

v_rcp_f16 v5, 0.5
// GFX12: v_rcp_f16_e32 v5, 0.5                   ; encoding: [0xf0,0xa8,0x0a,0x7e]

v_rcp_f16 v5, src_scc
// GFX12: v_rcp_f16_e32 v5, src_scc               ; encoding: [0xfd,0xa8,0x0a,0x7e]

v_rcp_f16 v127, 0xfe0b
// GFX12: v_rcp_f16_e32 v127, 0xfe0b              ; encoding: [0xff,0xa8,0xfe,0x7e,0x0b,0xfe,0x00,0x00]

v_rcp_f32 v5, v1
// GFX12: v_rcp_f32_e32 v5, v1                    ; encoding: [0x01,0x55,0x0a,0x7e]

v_rcp_f32 v5, v255
// GFX12: v_rcp_f32_e32 v5, v255                  ; encoding: [0xff,0x55,0x0a,0x7e]

v_rcp_f32 v5, s1
// GFX12: v_rcp_f32_e32 v5, s1                    ; encoding: [0x01,0x54,0x0a,0x7e]

v_rcp_f32 v5, s105
// GFX12: v_rcp_f32_e32 v5, s105                  ; encoding: [0x69,0x54,0x0a,0x7e]

v_rcp_f32 v5, vcc_lo
// GFX12: v_rcp_f32_e32 v5, vcc_lo                ; encoding: [0x6a,0x54,0x0a,0x7e]

v_rcp_f32 v5, vcc_hi
// GFX12: v_rcp_f32_e32 v5, vcc_hi                ; encoding: [0x6b,0x54,0x0a,0x7e]

v_rcp_f32 v5, ttmp15
// GFX12: v_rcp_f32_e32 v5, ttmp15                ; encoding: [0x7b,0x54,0x0a,0x7e]

v_rcp_f32 v5, m0
// GFX12: v_rcp_f32_e32 v5, m0                    ; encoding: [0x7d,0x54,0x0a,0x7e]

v_rcp_f32 v5, exec_lo
// GFX12: v_rcp_f32_e32 v5, exec_lo               ; encoding: [0x7e,0x54,0x0a,0x7e]

v_rcp_f32 v5, exec_hi
// GFX12: v_rcp_f32_e32 v5, exec_hi               ; encoding: [0x7f,0x54,0x0a,0x7e]

v_rcp_f32 v5, null
// GFX12: v_rcp_f32_e32 v5, null                  ; encoding: [0x7c,0x54,0x0a,0x7e]

v_rcp_f32 v5, -1
// GFX12: v_rcp_f32_e32 v5, -1                    ; encoding: [0xc1,0x54,0x0a,0x7e]

v_rcp_f32 v5, 0.5
// GFX12: v_rcp_f32_e32 v5, 0.5                   ; encoding: [0xf0,0x54,0x0a,0x7e]

v_rcp_f32 v5, src_scc
// GFX12: v_rcp_f32_e32 v5, src_scc               ; encoding: [0xfd,0x54,0x0a,0x7e]

v_rcp_f32 v255, 0xaf123456
// GFX12: v_rcp_f32_e32 v255, 0xaf123456          ; encoding: [0xff,0x54,0xfe,0x7f,0x56,0x34,0x12,0xaf]

v_rcp_f64 v[5:6], v[1:2]
// GFX12: v_rcp_f64_e32 v[5:6], v[1:2]            ; encoding: [0x01,0x5f,0x0a,0x7e]

v_rcp_f64 v[5:6], v[254:255]
// GFX12: v_rcp_f64_e32 v[5:6], v[254:255]        ; encoding: [0xfe,0x5f,0x0a,0x7e]

v_rcp_f64 v[5:6], s[2:3]
// GFX12: v_rcp_f64_e32 v[5:6], s[2:3]            ; encoding: [0x02,0x5e,0x0a,0x7e]

v_rcp_f64 v[5:6], s[104:105]
// GFX12: v_rcp_f64_e32 v[5:6], s[104:105]        ; encoding: [0x68,0x5e,0x0a,0x7e]

v_rcp_f64 v[5:6], vcc
// GFX12: v_rcp_f64_e32 v[5:6], vcc               ; encoding: [0x6a,0x5e,0x0a,0x7e]

v_rcp_f64 v[5:6], ttmp[14:15]
// GFX12: v_rcp_f64_e32 v[5:6], ttmp[14:15]       ; encoding: [0x7a,0x5e,0x0a,0x7e]

v_rcp_f64 v[5:6], exec
// GFX12: v_rcp_f64_e32 v[5:6], exec              ; encoding: [0x7e,0x5e,0x0a,0x7e]

v_rcp_f64 v[5:6], null
// GFX12: v_rcp_f64_e32 v[5:6], null              ; encoding: [0x7c,0x5e,0x0a,0x7e]

v_rcp_f64 v[5:6], -1
// GFX12: v_rcp_f64_e32 v[5:6], -1                ; encoding: [0xc1,0x5e,0x0a,0x7e]

v_rcp_f64 v[5:6], 0.5
// GFX12: v_rcp_f64_e32 v[5:6], 0.5               ; encoding: [0xf0,0x5e,0x0a,0x7e]

v_rcp_f64 v[5:6], src_scc
// GFX12: v_rcp_f64_e32 v[5:6], src_scc           ; encoding: [0xfd,0x5e,0x0a,0x7e]

v_rcp_f64 v[254:255], 0xaf123456
// GFX12: v_rcp_f64_e32 v[254:255], 0xaf123456    ; encoding: [0xff,0x5e,0xfc,0x7f,0x56,0x34,0x12,0xaf]

v_rcp_iflag_f32 v5, v1
// GFX12: v_rcp_iflag_f32_e32 v5, v1              ; encoding: [0x01,0x57,0x0a,0x7e]

v_rcp_iflag_f32 v5, v255
// GFX12: v_rcp_iflag_f32_e32 v5, v255            ; encoding: [0xff,0x57,0x0a,0x7e]

v_rcp_iflag_f32 v5, s1
// GFX12: v_rcp_iflag_f32_e32 v5, s1              ; encoding: [0x01,0x56,0x0a,0x7e]

v_rcp_iflag_f32 v5, s105
// GFX12: v_rcp_iflag_f32_e32 v5, s105            ; encoding: [0x69,0x56,0x0a,0x7e]

v_rcp_iflag_f32 v5, vcc_lo
// GFX12: v_rcp_iflag_f32_e32 v5, vcc_lo          ; encoding: [0x6a,0x56,0x0a,0x7e]

v_rcp_iflag_f32 v5, vcc_hi
// GFX12: v_rcp_iflag_f32_e32 v5, vcc_hi          ; encoding: [0x6b,0x56,0x0a,0x7e]

v_rcp_iflag_f32 v5, ttmp15
// GFX12: v_rcp_iflag_f32_e32 v5, ttmp15          ; encoding: [0x7b,0x56,0x0a,0x7e]

v_rcp_iflag_f32 v5, m0
// GFX12: v_rcp_iflag_f32_e32 v5, m0              ; encoding: [0x7d,0x56,0x0a,0x7e]

v_rcp_iflag_f32 v5, exec_lo
// GFX12: v_rcp_iflag_f32_e32 v5, exec_lo         ; encoding: [0x7e,0x56,0x0a,0x7e]

v_rcp_iflag_f32 v5, exec_hi
// GFX12: v_rcp_iflag_f32_e32 v5, exec_hi         ; encoding: [0x7f,0x56,0x0a,0x7e]

v_rcp_iflag_f32 v5, null
// GFX12: v_rcp_iflag_f32_e32 v5, null            ; encoding: [0x7c,0x56,0x0a,0x7e]

v_rcp_iflag_f32 v5, -1
// GFX12: v_rcp_iflag_f32_e32 v5, -1              ; encoding: [0xc1,0x56,0x0a,0x7e]

v_rcp_iflag_f32 v5, 0.5
// GFX12: v_rcp_iflag_f32_e32 v5, 0.5             ; encoding: [0xf0,0x56,0x0a,0x7e]

v_rcp_iflag_f32 v5, src_scc
// GFX12: v_rcp_iflag_f32_e32 v5, src_scc         ; encoding: [0xfd,0x56,0x0a,0x7e]

v_rcp_iflag_f32 v255, 0xaf123456
// GFX12: v_rcp_iflag_f32_e32 v255, 0xaf123456    ; encoding: [0xff,0x56,0xfe,0x7f,0x56,0x34,0x12,0xaf]

v_readfirstlane_b32 s5, v1
// GFX12: v_readfirstlane_b32 s5, v1              ; encoding: [0x01,0x05,0x0a,0x7e]

v_readfirstlane_b32 s105, v1
// GFX12: v_readfirstlane_b32 s105, v1            ; encoding: [0x01,0x05,0xd2,0x7e]

v_readfirstlane_b32 vcc_lo, v1
// GFX12: v_readfirstlane_b32 vcc_lo, v1          ; encoding: [0x01,0x05,0xd4,0x7e]

v_readfirstlane_b32 vcc_hi, v1
// GFX12: v_readfirstlane_b32 vcc_hi, v1          ; encoding: [0x01,0x05,0xd6,0x7e]

v_readfirstlane_b32 ttmp15, v1
// GFX12: v_readfirstlane_b32 ttmp15, v1          ; encoding: [0x01,0x05,0xf6,0x7e]

v_readfirstlane_b32 null, v255
// GFX12: v_readfirstlane_b32 null, v255          ; encoding: [0xff,0x05,0xf8,0x7e]

v_rndne_f16 v5, v1
// GFX12: v_rndne_f16_e32 v5, v1                  ; encoding: [0x01,0xbd,0x0a,0x7e]

v_rndne_f16 v5, v127
// GFX12: v_rndne_f16_e32 v5, v127                ; encoding: [0x7f,0xbd,0x0a,0x7e]

v_rndne_f16 v5, s1
// GFX12: v_rndne_f16_e32 v5, s1                  ; encoding: [0x01,0xbc,0x0a,0x7e]

v_rndne_f16 v5, s105
// GFX12: v_rndne_f16_e32 v5, s105                ; encoding: [0x69,0xbc,0x0a,0x7e]

v_rndne_f16 v5, vcc_lo
// GFX12: v_rndne_f16_e32 v5, vcc_lo              ; encoding: [0x6a,0xbc,0x0a,0x7e]

v_rndne_f16 v5, vcc_hi
// GFX12: v_rndne_f16_e32 v5, vcc_hi              ; encoding: [0x6b,0xbc,0x0a,0x7e]

v_rndne_f16 v5, ttmp15
// GFX12: v_rndne_f16_e32 v5, ttmp15              ; encoding: [0x7b,0xbc,0x0a,0x7e]

v_rndne_f16 v5, m0
// GFX12: v_rndne_f16_e32 v5, m0                  ; encoding: [0x7d,0xbc,0x0a,0x7e]

v_rndne_f16 v5, exec_lo
// GFX12: v_rndne_f16_e32 v5, exec_lo             ; encoding: [0x7e,0xbc,0x0a,0x7e]

v_rndne_f16 v5, exec_hi
// GFX12: v_rndne_f16_e32 v5, exec_hi             ; encoding: [0x7f,0xbc,0x0a,0x7e]

v_rndne_f16 v5, null
// GFX12: v_rndne_f16_e32 v5, null                ; encoding: [0x7c,0xbc,0x0a,0x7e]

v_rndne_f16 v5, -1
// GFX12: v_rndne_f16_e32 v5, -1                  ; encoding: [0xc1,0xbc,0x0a,0x7e]

v_rndne_f16 v5, 0.5
// GFX12: v_rndne_f16_e32 v5, 0.5                 ; encoding: [0xf0,0xbc,0x0a,0x7e]

v_rndne_f16 v5, src_scc
// GFX12: v_rndne_f16_e32 v5, src_scc             ; encoding: [0xfd,0xbc,0x0a,0x7e]

v_rndne_f16 v127, 0xfe0b
// GFX12: v_rndne_f16_e32 v127, 0xfe0b            ; encoding: [0xff,0xbc,0xfe,0x7e,0x0b,0xfe,0x00,0x00]

v_rndne_f32 v5, v1
// GFX12: v_rndne_f32_e32 v5, v1                  ; encoding: [0x01,0x47,0x0a,0x7e]

v_rndne_f32 v5, v255
// GFX12: v_rndne_f32_e32 v5, v255                ; encoding: [0xff,0x47,0x0a,0x7e]

v_rndne_f32 v5, s1
// GFX12: v_rndne_f32_e32 v5, s1                  ; encoding: [0x01,0x46,0x0a,0x7e]

v_rndne_f32 v5, s105
// GFX12: v_rndne_f32_e32 v5, s105                ; encoding: [0x69,0x46,0x0a,0x7e]

v_rndne_f32 v5, vcc_lo
// GFX12: v_rndne_f32_e32 v5, vcc_lo              ; encoding: [0x6a,0x46,0x0a,0x7e]

v_rndne_f32 v5, vcc_hi
// GFX12: v_rndne_f32_e32 v5, vcc_hi              ; encoding: [0x6b,0x46,0x0a,0x7e]

v_rndne_f32 v5, ttmp15
// GFX12: v_rndne_f32_e32 v5, ttmp15              ; encoding: [0x7b,0x46,0x0a,0x7e]

v_rndne_f32 v5, m0
// GFX12: v_rndne_f32_e32 v5, m0                  ; encoding: [0x7d,0x46,0x0a,0x7e]

v_rndne_f32 v5, exec_lo
// GFX12: v_rndne_f32_e32 v5, exec_lo             ; encoding: [0x7e,0x46,0x0a,0x7e]

v_rndne_f32 v5, exec_hi
// GFX12: v_rndne_f32_e32 v5, exec_hi             ; encoding: [0x7f,0x46,0x0a,0x7e]

v_rndne_f32 v5, null
// GFX12: v_rndne_f32_e32 v5, null                ; encoding: [0x7c,0x46,0x0a,0x7e]

v_rndne_f32 v5, -1
// GFX12: v_rndne_f32_e32 v5, -1                  ; encoding: [0xc1,0x46,0x0a,0x7e]

v_rndne_f32 v5, 0.5
// GFX12: v_rndne_f32_e32 v5, 0.5                 ; encoding: [0xf0,0x46,0x0a,0x7e]

v_rndne_f32 v5, src_scc
// GFX12: v_rndne_f32_e32 v5, src_scc             ; encoding: [0xfd,0x46,0x0a,0x7e]

v_rndne_f32 v255, 0xaf123456
// GFX12: v_rndne_f32_e32 v255, 0xaf123456        ; encoding: [0xff,0x46,0xfe,0x7f,0x56,0x34,0x12,0xaf]

v_rndne_f64 v[5:6], v[1:2]
// GFX12: v_rndne_f64_e32 v[5:6], v[1:2]          ; encoding: [0x01,0x33,0x0a,0x7e]

v_rndne_f64 v[5:6], v[254:255]
// GFX12: v_rndne_f64_e32 v[5:6], v[254:255]      ; encoding: [0xfe,0x33,0x0a,0x7e]

v_rndne_f64 v[5:6], s[2:3]
// GFX12: v_rndne_f64_e32 v[5:6], s[2:3]          ; encoding: [0x02,0x32,0x0a,0x7e]

v_rndne_f64 v[5:6], s[104:105]
// GFX12: v_rndne_f64_e32 v[5:6], s[104:105]      ; encoding: [0x68,0x32,0x0a,0x7e]

v_rndne_f64 v[5:6], vcc
// GFX12: v_rndne_f64_e32 v[5:6], vcc             ; encoding: [0x6a,0x32,0x0a,0x7e]

v_rndne_f64 v[5:6], ttmp[14:15]
// GFX12: v_rndne_f64_e32 v[5:6], ttmp[14:15]     ; encoding: [0x7a,0x32,0x0a,0x7e]

v_rndne_f64 v[5:6], exec
// GFX12: v_rndne_f64_e32 v[5:6], exec            ; encoding: [0x7e,0x32,0x0a,0x7e]

v_rndne_f64 v[5:6], null
// GFX12: v_rndne_f64_e32 v[5:6], null            ; encoding: [0x7c,0x32,0x0a,0x7e]

v_rndne_f64 v[5:6], -1
// GFX12: v_rndne_f64_e32 v[5:6], -1              ; encoding: [0xc1,0x32,0x0a,0x7e]

v_rndne_f64 v[5:6], 0.5
// GFX12: v_rndne_f64_e32 v[5:6], 0.5             ; encoding: [0xf0,0x32,0x0a,0x7e]

v_rndne_f64 v[5:6], src_scc
// GFX12: v_rndne_f64_e32 v[5:6], src_scc         ; encoding: [0xfd,0x32,0x0a,0x7e]

v_rndne_f64 v[254:255], 0xaf123456
// GFX12: v_rndne_f64_e32 v[254:255], 0xaf123456  ; encoding: [0xff,0x32,0xfc,0x7f,0x56,0x34,0x12,0xaf]

v_rsq_f16 v5, v1
// GFX12: v_rsq_f16_e32 v5, v1                    ; encoding: [0x01,0xad,0x0a,0x7e]

v_rsq_f16 v5, v127
// GFX12: v_rsq_f16_e32 v5, v127                  ; encoding: [0x7f,0xad,0x0a,0x7e]

v_rsq_f16 v5, s1
// GFX12: v_rsq_f16_e32 v5, s1                    ; encoding: [0x01,0xac,0x0a,0x7e]

v_rsq_f16 v5, s105
// GFX12: v_rsq_f16_e32 v5, s105                  ; encoding: [0x69,0xac,0x0a,0x7e]

v_rsq_f16 v5, vcc_lo
// GFX12: v_rsq_f16_e32 v5, vcc_lo                ; encoding: [0x6a,0xac,0x0a,0x7e]

v_rsq_f16 v5, vcc_hi
// GFX12: v_rsq_f16_e32 v5, vcc_hi                ; encoding: [0x6b,0xac,0x0a,0x7e]

v_rsq_f16 v5, ttmp15
// GFX12: v_rsq_f16_e32 v5, ttmp15                ; encoding: [0x7b,0xac,0x0a,0x7e]

v_rsq_f16 v5, m0
// GFX12: v_rsq_f16_e32 v5, m0                    ; encoding: [0x7d,0xac,0x0a,0x7e]

v_rsq_f16 v5, exec_lo
// GFX12: v_rsq_f16_e32 v5, exec_lo               ; encoding: [0x7e,0xac,0x0a,0x7e]

v_rsq_f16 v5, exec_hi
// GFX12: v_rsq_f16_e32 v5, exec_hi               ; encoding: [0x7f,0xac,0x0a,0x7e]

v_rsq_f16 v5, null
// GFX12: v_rsq_f16_e32 v5, null                  ; encoding: [0x7c,0xac,0x0a,0x7e]

v_rsq_f16 v5, -1
// GFX12: v_rsq_f16_e32 v5, -1                    ; encoding: [0xc1,0xac,0x0a,0x7e]

v_rsq_f16 v5, 0.5
// GFX12: v_rsq_f16_e32 v5, 0.5                   ; encoding: [0xf0,0xac,0x0a,0x7e]

v_rsq_f16 v5, src_scc
// GFX12: v_rsq_f16_e32 v5, src_scc               ; encoding: [0xfd,0xac,0x0a,0x7e]

v_rsq_f16 v127, 0xfe0b
// GFX12: v_rsq_f16_e32 v127, 0xfe0b              ; encoding: [0xff,0xac,0xfe,0x7e,0x0b,0xfe,0x00,0x00]

v_rsq_f32 v5, v1
// GFX12: v_rsq_f32_e32 v5, v1                    ; encoding: [0x01,0x5d,0x0a,0x7e]

v_rsq_f32 v5, v255
// GFX12: v_rsq_f32_e32 v5, v255                  ; encoding: [0xff,0x5d,0x0a,0x7e]

v_rsq_f32 v5, s1
// GFX12: v_rsq_f32_e32 v5, s1                    ; encoding: [0x01,0x5c,0x0a,0x7e]

v_rsq_f32 v5, s105
// GFX12: v_rsq_f32_e32 v5, s105                  ; encoding: [0x69,0x5c,0x0a,0x7e]

v_rsq_f32 v5, vcc_lo
// GFX12: v_rsq_f32_e32 v5, vcc_lo                ; encoding: [0x6a,0x5c,0x0a,0x7e]

v_rsq_f32 v5, vcc_hi
// GFX12: v_rsq_f32_e32 v5, vcc_hi                ; encoding: [0x6b,0x5c,0x0a,0x7e]

v_rsq_f32 v5, ttmp15
// GFX12: v_rsq_f32_e32 v5, ttmp15                ; encoding: [0x7b,0x5c,0x0a,0x7e]

v_rsq_f32 v5, m0
// GFX12: v_rsq_f32_e32 v5, m0                    ; encoding: [0x7d,0x5c,0x0a,0x7e]

v_rsq_f32 v5, exec_lo
// GFX12: v_rsq_f32_e32 v5, exec_lo               ; encoding: [0x7e,0x5c,0x0a,0x7e]

v_rsq_f32 v5, exec_hi
// GFX12: v_rsq_f32_e32 v5, exec_hi               ; encoding: [0x7f,0x5c,0x0a,0x7e]

v_rsq_f32 v5, null
// GFX12: v_rsq_f32_e32 v5, null                  ; encoding: [0x7c,0x5c,0x0a,0x7e]

v_rsq_f32 v5, -1
// GFX12: v_rsq_f32_e32 v5, -1                    ; encoding: [0xc1,0x5c,0x0a,0x7e]

v_rsq_f32 v5, 0.5
// GFX12: v_rsq_f32_e32 v5, 0.5                   ; encoding: [0xf0,0x5c,0x0a,0x7e]

v_rsq_f32 v5, src_scc
// GFX12: v_rsq_f32_e32 v5, src_scc               ; encoding: [0xfd,0x5c,0x0a,0x7e]

v_rsq_f32 v255, 0xaf123456
// GFX12: v_rsq_f32_e32 v255, 0xaf123456          ; encoding: [0xff,0x5c,0xfe,0x7f,0x56,0x34,0x12,0xaf]

v_rsq_f64 v[5:6], v[1:2]
// GFX12: v_rsq_f64_e32 v[5:6], v[1:2]            ; encoding: [0x01,0x63,0x0a,0x7e]

v_rsq_f64 v[5:6], v[254:255]
// GFX12: v_rsq_f64_e32 v[5:6], v[254:255]        ; encoding: [0xfe,0x63,0x0a,0x7e]

v_rsq_f64 v[5:6], s[2:3]
// GFX12: v_rsq_f64_e32 v[5:6], s[2:3]            ; encoding: [0x02,0x62,0x0a,0x7e]

v_rsq_f64 v[5:6], s[104:105]
// GFX12: v_rsq_f64_e32 v[5:6], s[104:105]        ; encoding: [0x68,0x62,0x0a,0x7e]

v_rsq_f64 v[5:6], vcc
// GFX12: v_rsq_f64_e32 v[5:6], vcc               ; encoding: [0x6a,0x62,0x0a,0x7e]

v_rsq_f64 v[5:6], ttmp[14:15]
// GFX12: v_rsq_f64_e32 v[5:6], ttmp[14:15]       ; encoding: [0x7a,0x62,0x0a,0x7e]

v_rsq_f64 v[5:6], exec
// GFX12: v_rsq_f64_e32 v[5:6], exec              ; encoding: [0x7e,0x62,0x0a,0x7e]

v_rsq_f64 v[5:6], null
// GFX12: v_rsq_f64_e32 v[5:6], null              ; encoding: [0x7c,0x62,0x0a,0x7e]

v_rsq_f64 v[5:6], -1
// GFX12: v_rsq_f64_e32 v[5:6], -1                ; encoding: [0xc1,0x62,0x0a,0x7e]

v_rsq_f64 v[5:6], 0.5
// GFX12: v_rsq_f64_e32 v[5:6], 0.5               ; encoding: [0xf0,0x62,0x0a,0x7e]

v_rsq_f64 v[5:6], src_scc
// GFX12: v_rsq_f64_e32 v[5:6], src_scc           ; encoding: [0xfd,0x62,0x0a,0x7e]

v_rsq_f64 v[254:255], 0xaf123456
// GFX12: v_rsq_f64_e32 v[254:255], 0xaf123456    ; encoding: [0xff,0x62,0xfc,0x7f,0x56,0x34,0x12,0xaf]

v_sat_pk_u8_i16 v5, v1
// GFX12: v_sat_pk_u8_i16_e32 v5, v1              ; encoding: [0x01,0xc5,0x0a,0x7e]

v_sat_pk_u8_i16 v5, v255
// GFX12: v_sat_pk_u8_i16_e32 v5, v255            ; encoding: [0xff,0xc5,0x0a,0x7e]

v_sat_pk_u8_i16 v5, s1
// GFX12: v_sat_pk_u8_i16_e32 v5, s1              ; encoding: [0x01,0xc4,0x0a,0x7e]

v_sat_pk_u8_i16 v5, s105
// GFX12: v_sat_pk_u8_i16_e32 v5, s105            ; encoding: [0x69,0xc4,0x0a,0x7e]

v_sat_pk_u8_i16 v5, vcc_lo
// GFX12: v_sat_pk_u8_i16_e32 v5, vcc_lo          ; encoding: [0x6a,0xc4,0x0a,0x7e]

v_sat_pk_u8_i16 v5, vcc_hi
// GFX12: v_sat_pk_u8_i16_e32 v5, vcc_hi          ; encoding: [0x6b,0xc4,0x0a,0x7e]

v_sat_pk_u8_i16 v5, ttmp15
// GFX12: v_sat_pk_u8_i16_e32 v5, ttmp15          ; encoding: [0x7b,0xc4,0x0a,0x7e]

v_sat_pk_u8_i16 v5, m0
// GFX12: v_sat_pk_u8_i16_e32 v5, m0              ; encoding: [0x7d,0xc4,0x0a,0x7e]

v_sat_pk_u8_i16 v5, exec_lo
// GFX12: v_sat_pk_u8_i16_e32 v5, exec_lo         ; encoding: [0x7e,0xc4,0x0a,0x7e]

v_sat_pk_u8_i16 v5, exec_hi
// GFX12: v_sat_pk_u8_i16_e32 v5, exec_hi         ; encoding: [0x7f,0xc4,0x0a,0x7e]

v_sat_pk_u8_i16 v5, null
// GFX12: v_sat_pk_u8_i16_e32 v5, null            ; encoding: [0x7c,0xc4,0x0a,0x7e]

v_sat_pk_u8_i16 v5, -1
// GFX12: v_sat_pk_u8_i16_e32 v5, -1              ; encoding: [0xc1,0xc4,0x0a,0x7e]

v_sat_pk_u8_i16 v5, 0.5
// GFX12: v_sat_pk_u8_i16_e32 v5, 0.5             ; encoding: [0xf0,0xc4,0x0a,0x7e]

v_sat_pk_u8_i16 v5, src_scc
// GFX12: v_sat_pk_u8_i16_e32 v5, src_scc         ; encoding: [0xfd,0xc4,0x0a,0x7e]

v_sat_pk_u8_i16 v127, 0xfe0b
// GFX12: v_sat_pk_u8_i16_e32 v127, 0xfe0b        ; encoding: [0xff,0xc4,0xfe,0x7e,0x0b,0xfe,0x00,0x00]

v_sin_f16 v5, v1
// GFX12: v_sin_f16_e32 v5, v1                    ; encoding: [0x01,0xc1,0x0a,0x7e]

v_sin_f16 v5, v127
// GFX12: v_sin_f16_e32 v5, v127                  ; encoding: [0x7f,0xc1,0x0a,0x7e]

v_sin_f16 v5, s1
// GFX12: v_sin_f16_e32 v5, s1                    ; encoding: [0x01,0xc0,0x0a,0x7e]

v_sin_f16 v5, s105
// GFX12: v_sin_f16_e32 v5, s105                  ; encoding: [0x69,0xc0,0x0a,0x7e]

v_sin_f16 v5, vcc_lo
// GFX12: v_sin_f16_e32 v5, vcc_lo                ; encoding: [0x6a,0xc0,0x0a,0x7e]

v_sin_f16 v5, vcc_hi
// GFX12: v_sin_f16_e32 v5, vcc_hi                ; encoding: [0x6b,0xc0,0x0a,0x7e]

v_sin_f16 v5, ttmp15
// GFX12: v_sin_f16_e32 v5, ttmp15                ; encoding: [0x7b,0xc0,0x0a,0x7e]

v_sin_f16 v5, m0
// GFX12: v_sin_f16_e32 v5, m0                    ; encoding: [0x7d,0xc0,0x0a,0x7e]

v_sin_f16 v5, exec_lo
// GFX12: v_sin_f16_e32 v5, exec_lo               ; encoding: [0x7e,0xc0,0x0a,0x7e]

v_sin_f16 v5, exec_hi
// GFX12: v_sin_f16_e32 v5, exec_hi               ; encoding: [0x7f,0xc0,0x0a,0x7e]

v_sin_f16 v5, null
// GFX12: v_sin_f16_e32 v5, null                  ; encoding: [0x7c,0xc0,0x0a,0x7e]

v_sin_f16 v5, -1
// GFX12: v_sin_f16_e32 v5, -1                    ; encoding: [0xc1,0xc0,0x0a,0x7e]

v_sin_f16 v5, 0.5
// GFX12: v_sin_f16_e32 v5, 0.5                   ; encoding: [0xf0,0xc0,0x0a,0x7e]

v_sin_f16 v5, src_scc
// GFX12: v_sin_f16_e32 v5, src_scc               ; encoding: [0xfd,0xc0,0x0a,0x7e]

v_sin_f16 v127, 0xfe0b
// GFX12: v_sin_f16_e32 v127, 0xfe0b              ; encoding: [0xff,0xc0,0xfe,0x7e,0x0b,0xfe,0x00,0x00]

v_sin_f32 v5, v1
// GFX12: v_sin_f32_e32 v5, v1                    ; encoding: [0x01,0x6b,0x0a,0x7e]

v_sin_f32 v5, v255
// GFX12: v_sin_f32_e32 v5, v255                  ; encoding: [0xff,0x6b,0x0a,0x7e]

v_sin_f32 v5, s1
// GFX12: v_sin_f32_e32 v5, s1                    ; encoding: [0x01,0x6a,0x0a,0x7e]

v_sin_f32 v5, s105
// GFX12: v_sin_f32_e32 v5, s105                  ; encoding: [0x69,0x6a,0x0a,0x7e]

v_sin_f32 v5, vcc_lo
// GFX12: v_sin_f32_e32 v5, vcc_lo                ; encoding: [0x6a,0x6a,0x0a,0x7e]

v_sin_f32 v5, vcc_hi
// GFX12: v_sin_f32_e32 v5, vcc_hi                ; encoding: [0x6b,0x6a,0x0a,0x7e]

v_sin_f32 v5, ttmp15
// GFX12: v_sin_f32_e32 v5, ttmp15                ; encoding: [0x7b,0x6a,0x0a,0x7e]

v_sin_f32 v5, m0
// GFX12: v_sin_f32_e32 v5, m0                    ; encoding: [0x7d,0x6a,0x0a,0x7e]

v_sin_f32 v5, exec_lo
// GFX12: v_sin_f32_e32 v5, exec_lo               ; encoding: [0x7e,0x6a,0x0a,0x7e]

v_sin_f32 v5, exec_hi
// GFX12: v_sin_f32_e32 v5, exec_hi               ; encoding: [0x7f,0x6a,0x0a,0x7e]

v_sin_f32 v5, null
// GFX12: v_sin_f32_e32 v5, null                  ; encoding: [0x7c,0x6a,0x0a,0x7e]

v_sin_f32 v5, -1
// GFX12: v_sin_f32_e32 v5, -1                    ; encoding: [0xc1,0x6a,0x0a,0x7e]

v_sin_f32 v5, 0.5
// GFX12: v_sin_f32_e32 v5, 0.5                   ; encoding: [0xf0,0x6a,0x0a,0x7e]

v_sin_f32 v5, src_scc
// GFX12: v_sin_f32_e32 v5, src_scc               ; encoding: [0xfd,0x6a,0x0a,0x7e]

v_sin_f32 v255, 0xaf123456
// GFX12: v_sin_f32_e32 v255, 0xaf123456          ; encoding: [0xff,0x6a,0xfe,0x7f,0x56,0x34,0x12,0xaf]

v_sqrt_f16 v5, v1
// GFX12: v_sqrt_f16_e32 v5, v1                   ; encoding: [0x01,0xab,0x0a,0x7e]

v_sqrt_f16 v5, v127
// GFX12: v_sqrt_f16_e32 v5, v127                 ; encoding: [0x7f,0xab,0x0a,0x7e]

v_sqrt_f16 v5, s1
// GFX12: v_sqrt_f16_e32 v5, s1                   ; encoding: [0x01,0xaa,0x0a,0x7e]

v_sqrt_f16 v5, s105
// GFX12: v_sqrt_f16_e32 v5, s105                 ; encoding: [0x69,0xaa,0x0a,0x7e]

v_sqrt_f16 v5, vcc_lo
// GFX12: v_sqrt_f16_e32 v5, vcc_lo               ; encoding: [0x6a,0xaa,0x0a,0x7e]

v_sqrt_f16 v5, vcc_hi
// GFX12: v_sqrt_f16_e32 v5, vcc_hi               ; encoding: [0x6b,0xaa,0x0a,0x7e]

v_sqrt_f16 v5, ttmp15
// GFX12: v_sqrt_f16_e32 v5, ttmp15               ; encoding: [0x7b,0xaa,0x0a,0x7e]

v_sqrt_f16 v5, m0
// GFX12: v_sqrt_f16_e32 v5, m0                   ; encoding: [0x7d,0xaa,0x0a,0x7e]

v_sqrt_f16 v5, exec_lo
// GFX12: v_sqrt_f16_e32 v5, exec_lo              ; encoding: [0x7e,0xaa,0x0a,0x7e]

v_sqrt_f16 v5, exec_hi
// GFX12: v_sqrt_f16_e32 v5, exec_hi              ; encoding: [0x7f,0xaa,0x0a,0x7e]

v_sqrt_f16 v5, null
// GFX12: v_sqrt_f16_e32 v5, null                 ; encoding: [0x7c,0xaa,0x0a,0x7e]

v_sqrt_f16 v5, -1
// GFX12: v_sqrt_f16_e32 v5, -1                   ; encoding: [0xc1,0xaa,0x0a,0x7e]

v_sqrt_f16 v5, 0.5
// GFX12: v_sqrt_f16_e32 v5, 0.5                  ; encoding: [0xf0,0xaa,0x0a,0x7e]

v_sqrt_f16 v5, src_scc
// GFX12: v_sqrt_f16_e32 v5, src_scc              ; encoding: [0xfd,0xaa,0x0a,0x7e]

v_sqrt_f16 v127, 0xfe0b
// GFX12: v_sqrt_f16_e32 v127, 0xfe0b             ; encoding: [0xff,0xaa,0xfe,0x7e,0x0b,0xfe,0x00,0x00]

v_sqrt_f32 v5, v1
// GFX12: v_sqrt_f32_e32 v5, v1                   ; encoding: [0x01,0x67,0x0a,0x7e]

v_sqrt_f32 v5, v255
// GFX12: v_sqrt_f32_e32 v5, v255                 ; encoding: [0xff,0x67,0x0a,0x7e]

v_sqrt_f32 v5, s1
// GFX12: v_sqrt_f32_e32 v5, s1                   ; encoding: [0x01,0x66,0x0a,0x7e]

v_sqrt_f32 v5, s105
// GFX12: v_sqrt_f32_e32 v5, s105                 ; encoding: [0x69,0x66,0x0a,0x7e]

v_sqrt_f32 v5, vcc_lo
// GFX12: v_sqrt_f32_e32 v5, vcc_lo               ; encoding: [0x6a,0x66,0x0a,0x7e]

v_sqrt_f32 v5, vcc_hi
// GFX12: v_sqrt_f32_e32 v5, vcc_hi               ; encoding: [0x6b,0x66,0x0a,0x7e]

v_sqrt_f32 v5, ttmp15
// GFX12: v_sqrt_f32_e32 v5, ttmp15               ; encoding: [0x7b,0x66,0x0a,0x7e]

v_sqrt_f32 v5, m0
// GFX12: v_sqrt_f32_e32 v5, m0                   ; encoding: [0x7d,0x66,0x0a,0x7e]

v_sqrt_f32 v5, exec_lo
// GFX12: v_sqrt_f32_e32 v5, exec_lo              ; encoding: [0x7e,0x66,0x0a,0x7e]

v_sqrt_f32 v5, exec_hi
// GFX12: v_sqrt_f32_e32 v5, exec_hi              ; encoding: [0x7f,0x66,0x0a,0x7e]

v_sqrt_f32 v5, null
// GFX12: v_sqrt_f32_e32 v5, null                 ; encoding: [0x7c,0x66,0x0a,0x7e]

v_sqrt_f32 v5, -1
// GFX12: v_sqrt_f32_e32 v5, -1                   ; encoding: [0xc1,0x66,0x0a,0x7e]

v_sqrt_f32 v5, 0.5
// GFX12: v_sqrt_f32_e32 v5, 0.5                  ; encoding: [0xf0,0x66,0x0a,0x7e]

v_sqrt_f32 v5, src_scc
// GFX12: v_sqrt_f32_e32 v5, src_scc              ; encoding: [0xfd,0x66,0x0a,0x7e]

v_sqrt_f32 v255, 0xaf123456
// GFX12: v_sqrt_f32_e32 v255, 0xaf123456         ; encoding: [0xff,0x66,0xfe,0x7f,0x56,0x34,0x12,0xaf]

v_sqrt_f64 v[5:6], v[1:2]
// GFX12: v_sqrt_f64_e32 v[5:6], v[1:2]           ; encoding: [0x01,0x69,0x0a,0x7e]

v_sqrt_f64 v[5:6], v[254:255]
// GFX12: v_sqrt_f64_e32 v[5:6], v[254:255]       ; encoding: [0xfe,0x69,0x0a,0x7e]

v_sqrt_f64 v[5:6], s[2:3]
// GFX12: v_sqrt_f64_e32 v[5:6], s[2:3]           ; encoding: [0x02,0x68,0x0a,0x7e]

v_sqrt_f64 v[5:6], s[104:105]
// GFX12: v_sqrt_f64_e32 v[5:6], s[104:105]       ; encoding: [0x68,0x68,0x0a,0x7e]

v_sqrt_f64 v[5:6], vcc
// GFX12: v_sqrt_f64_e32 v[5:6], vcc              ; encoding: [0x6a,0x68,0x0a,0x7e]

v_sqrt_f64 v[5:6], ttmp[14:15]
// GFX12: v_sqrt_f64_e32 v[5:6], ttmp[14:15]      ; encoding: [0x7a,0x68,0x0a,0x7e]

v_sqrt_f64 v[5:6], exec
// GFX12: v_sqrt_f64_e32 v[5:6], exec             ; encoding: [0x7e,0x68,0x0a,0x7e]

v_sqrt_f64 v[5:6], null
// GFX12: v_sqrt_f64_e32 v[5:6], null             ; encoding: [0x7c,0x68,0x0a,0x7e]

v_sqrt_f64 v[5:6], -1
// GFX12: v_sqrt_f64_e32 v[5:6], -1               ; encoding: [0xc1,0x68,0x0a,0x7e]

v_sqrt_f64 v[5:6], 0.5
// GFX12: v_sqrt_f64_e32 v[5:6], 0.5              ; encoding: [0xf0,0x68,0x0a,0x7e]

v_sqrt_f64 v[5:6], src_scc
// GFX12: v_sqrt_f64_e32 v[5:6], src_scc          ; encoding: [0xfd,0x68,0x0a,0x7e]

v_sqrt_f64 v[254:255], 0xaf123456
// GFX12: v_sqrt_f64_e32 v[254:255], 0xaf123456   ; encoding: [0xff,0x68,0xfc,0x7f,0x56,0x34,0x12,0xaf]

v_swap_b32 v5, v1
// GFX12: v_swap_b32 v5, v1                       ; encoding: [0x01,0xcb,0x0a,0x7e]

v_swap_b32 v255, v255
// GFX12: v_swap_b32 v255, v255                   ; encoding: [0xff,0xcb,0xfe,0x7f]

v_swaprel_b32 v5, v1
// GFX12: v_swaprel_b32 v5, v1                    ; encoding: [0x01,0xd1,0x0a,0x7e]

v_swaprel_b32 v255, v255
// GFX12: v_swaprel_b32 v255, v255                ; encoding: [0xff,0xd1,0xfe,0x7f]

v_trunc_f16 v5, v1
// GFX12: v_trunc_f16_e32 v5, v1                  ; encoding: [0x01,0xbb,0x0a,0x7e]

v_trunc_f16 v5, v127
// GFX12: v_trunc_f16_e32 v5, v127                ; encoding: [0x7f,0xbb,0x0a,0x7e]

v_trunc_f16 v5, s1
// GFX12: v_trunc_f16_e32 v5, s1                  ; encoding: [0x01,0xba,0x0a,0x7e]

v_trunc_f16 v5, s105
// GFX12: v_trunc_f16_e32 v5, s105                ; encoding: [0x69,0xba,0x0a,0x7e]

v_trunc_f16 v5, vcc_lo
// GFX12: v_trunc_f16_e32 v5, vcc_lo              ; encoding: [0x6a,0xba,0x0a,0x7e]

v_trunc_f16 v5, vcc_hi
// GFX12: v_trunc_f16_e32 v5, vcc_hi              ; encoding: [0x6b,0xba,0x0a,0x7e]

v_trunc_f16 v5, ttmp15
// GFX12: v_trunc_f16_e32 v5, ttmp15              ; encoding: [0x7b,0xba,0x0a,0x7e]

v_trunc_f16 v5, m0
// GFX12: v_trunc_f16_e32 v5, m0                  ; encoding: [0x7d,0xba,0x0a,0x7e]

v_trunc_f16 v5, exec_lo
// GFX12: v_trunc_f16_e32 v5, exec_lo             ; encoding: [0x7e,0xba,0x0a,0x7e]

v_trunc_f16 v5, exec_hi
// GFX12: v_trunc_f16_e32 v5, exec_hi             ; encoding: [0x7f,0xba,0x0a,0x7e]

v_trunc_f16 v5, null
// GFX12: v_trunc_f16_e32 v5, null                ; encoding: [0x7c,0xba,0x0a,0x7e]

v_trunc_f16 v5, -1
// GFX12: v_trunc_f16_e32 v5, -1                  ; encoding: [0xc1,0xba,0x0a,0x7e]

v_trunc_f16 v5, 0.5
// GFX12: v_trunc_f16_e32 v5, 0.5                 ; encoding: [0xf0,0xba,0x0a,0x7e]

v_trunc_f16 v5, src_scc
// GFX12: v_trunc_f16_e32 v5, src_scc             ; encoding: [0xfd,0xba,0x0a,0x7e]

v_trunc_f16 v127, 0xfe0b
// GFX12: v_trunc_f16_e32 v127, 0xfe0b            ; encoding: [0xff,0xba,0xfe,0x7e,0x0b,0xfe,0x00,0x00]

v_trunc_f32 v5, v1
// GFX12: v_trunc_f32_e32 v5, v1                  ; encoding: [0x01,0x43,0x0a,0x7e]

v_trunc_f32 v5, v255
// GFX12: v_trunc_f32_e32 v5, v255                ; encoding: [0xff,0x43,0x0a,0x7e]

v_trunc_f32 v5, s1
// GFX12: v_trunc_f32_e32 v5, s1                  ; encoding: [0x01,0x42,0x0a,0x7e]

v_trunc_f32 v5, s105
// GFX12: v_trunc_f32_e32 v5, s105                ; encoding: [0x69,0x42,0x0a,0x7e]

v_trunc_f32 v5, vcc_lo
// GFX12: v_trunc_f32_e32 v5, vcc_lo              ; encoding: [0x6a,0x42,0x0a,0x7e]

v_trunc_f32 v5, vcc_hi
// GFX12: v_trunc_f32_e32 v5, vcc_hi              ; encoding: [0x6b,0x42,0x0a,0x7e]

v_trunc_f32 v5, ttmp15
// GFX12: v_trunc_f32_e32 v5, ttmp15              ; encoding: [0x7b,0x42,0x0a,0x7e]

v_trunc_f32 v5, m0
// GFX12: v_trunc_f32_e32 v5, m0                  ; encoding: [0x7d,0x42,0x0a,0x7e]

v_trunc_f32 v5, exec_lo
// GFX12: v_trunc_f32_e32 v5, exec_lo             ; encoding: [0x7e,0x42,0x0a,0x7e]

v_trunc_f32 v5, exec_hi
// GFX12: v_trunc_f32_e32 v5, exec_hi             ; encoding: [0x7f,0x42,0x0a,0x7e]

v_trunc_f32 v5, null
// GFX12: v_trunc_f32_e32 v5, null                ; encoding: [0x7c,0x42,0x0a,0x7e]

v_trunc_f32 v5, -1
// GFX12: v_trunc_f32_e32 v5, -1                  ; encoding: [0xc1,0x42,0x0a,0x7e]

v_trunc_f32 v5, 0.5
// GFX12: v_trunc_f32_e32 v5, 0.5                 ; encoding: [0xf0,0x42,0x0a,0x7e]

v_trunc_f32 v5, src_scc
// GFX12: v_trunc_f32_e32 v5, src_scc             ; encoding: [0xfd,0x42,0x0a,0x7e]

v_trunc_f32 v255, 0xaf123456
// GFX12: v_trunc_f32_e32 v255, 0xaf123456        ; encoding: [0xff,0x42,0xfe,0x7f,0x56,0x34,0x12,0xaf]

v_trunc_f64 v[5:6], v[1:2]
// GFX12: v_trunc_f64_e32 v[5:6], v[1:2]          ; encoding: [0x01,0x2f,0x0a,0x7e]

v_trunc_f64 v[5:6], v[254:255]
// GFX12: v_trunc_f64_e32 v[5:6], v[254:255]      ; encoding: [0xfe,0x2f,0x0a,0x7e]

v_trunc_f64 v[5:6], s[2:3]
// GFX12: v_trunc_f64_e32 v[5:6], s[2:3]          ; encoding: [0x02,0x2e,0x0a,0x7e]

v_trunc_f64 v[5:6], s[104:105]
// GFX12: v_trunc_f64_e32 v[5:6], s[104:105]      ; encoding: [0x68,0x2e,0x0a,0x7e]

v_trunc_f64 v[5:6], vcc
// GFX12: v_trunc_f64_e32 v[5:6], vcc             ; encoding: [0x6a,0x2e,0x0a,0x7e]

v_trunc_f64 v[5:6], ttmp[14:15]
// GFX12: v_trunc_f64_e32 v[5:6], ttmp[14:15]     ; encoding: [0x7a,0x2e,0x0a,0x7e]

v_trunc_f64 v[5:6], exec
// GFX12: v_trunc_f64_e32 v[5:6], exec            ; encoding: [0x7e,0x2e,0x0a,0x7e]

v_trunc_f64 v[5:6], null
// GFX12: v_trunc_f64_e32 v[5:6], null            ; encoding: [0x7c,0x2e,0x0a,0x7e]

v_trunc_f64 v[5:6], -1
// GFX12: v_trunc_f64_e32 v[5:6], -1              ; encoding: [0xc1,0x2e,0x0a,0x7e]

v_trunc_f64 v[5:6], 0.5
// GFX12: v_trunc_f64_e32 v[5:6], 0.5             ; encoding: [0xf0,0x2e,0x0a,0x7e]

v_trunc_f64 v[5:6], src_scc
// GFX12: v_trunc_f64_e32 v[5:6], src_scc         ; encoding: [0xfd,0x2e,0x0a,0x7e]

v_trunc_f64 v[254:255], 0xaf123456
// GFX12: v_trunc_f64_e32 v[254:255], 0xaf123456  ; encoding: [0xff,0x2e,0xfc,0x7f,0x56,0x34,0x12,0xaf]
