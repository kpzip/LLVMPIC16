// RUN: not llvm-mc -triple=amdgcn -mcpu=gfx1010 -mattr=+wavefrontsize64 -show-encoding %s | FileCheck -check-prefix=GFX10 %s
// RUN: not llvm-mc -triple=amdgcn -mcpu=gfx900  -show-encoding %s | FileCheck -check-prefix=GFX9 %s
// RUN: not llvm-mc -triple=amdgcn -mcpu=gfx1010 -mattr=+wavefrontsize64 %s 2>&1 | FileCheck -check-prefix=GFX10-ERR --implicit-check-not=error: %s
// RUN: not llvm-mc -triple=amdgcn -mcpu=gfx900  %s 2>&1 | FileCheck -check-prefix=GFX9-ERR --implicit-check-not=error: %s

v_bfe_u32 v0, 0x3039, v1, s1
// GFX10:     v_bfe_u32 v0, 0x3039, v1, s1    ; encoding: [0x00,0x00,0x48,0xd5,0xff,0x02,0x06,0x00,0x39,0x30,0x00,0x00]
// GFX9-ERR:  error: literal operands are not supported

v_bfe_u32 v0, v1, 0x3039, s1
// GFX10:     v_bfe_u32 v0, v1, 0x3039, s1    ; encoding: [0x00,0x00,0x48,0xd5,0x01,0xff,0x05,0x00,0x39,0x30,0x00,0x00]
// GFX9-ERR:  error: literal operands are not supported

v_bfe_u32 v0, v1, s1, 0x3039
// GFX10:     v_bfe_u32 v0, v1, s1, 0x3039    ; encoding: [0x00,0x00,0x48,0xd5,0x01,0x03,0xfc,0x03,0x39,0x30,0x00,0x00]
// GFX9-ERR:  error: literal operands are not supported

v_bfe_u32 v0, 0x3039, 0x3039, s1
// GFX10:     v_bfe_u32 v0, 0x3039, 0x3039, s1 ; encoding: [0x00,0x00,0x48,0xd5,0xff,0xfe,0x05,0x00,0x39,0x30,0x00,0x00]
// GFX9-ERR:  error: literal operands are not supported

v_bfe_u32 v0, 0x3039, s1, 0x3039
// GFX10:     v_bfe_u32 v0, 0x3039, s1, 0x3039 ; encoding: [0x00,0x00,0x48,0xd5,0xff,0x02,0xfc,0x03,0x39,0x30,0x00,0x00]
// GFX9-ERR:  error: literal operands are not supported

v_bfe_u32 v0, v1, 0x3039, 0x3039
// GFX10:     v_bfe_u32 v0, v1, 0x3039, 0x3039 ; encoding: [0x00,0x00,0x48,0xd5,0x01,0xff,0xfd,0x03,0x39,0x30,0x00,0x00]
// GFX9-ERR:  error: literal operands are not supported

v_bfe_u32 v0, 0x3039, 0x3039, 0x3039
// GFX10:     v_bfe_u32 v0, 0x3039, 0x3039, 0x3039 ; encoding: [0x00,0x00,0x48,0xd5,0xff,0xfe,0xfd,0x03,0x39,0x30,0x00,0x00]
// GFX9-ERR:  error: literal operands are not supported

v_bfe_u32 v0, 0x3039, s1, 0x3038
// GFX10-ERR: :[[@LINE-1]]:{{[0-9]+}}: error: only one unique literal operand is allowed
// GFX9-ERR:  error: literal operands are not supported

v_bfe_u32 v0, 0x3039, v1, v2
// GFX10:    v_bfe_u32 v0, 0x3039, v1, v2    ; encoding: [0x00,0x00,0x48,0xd5,0xff,0x02,0x0a,0x04,0x39,0x30,0x00,0x00]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: literal operands are not supported

v_bfe_u32 v0, 0x3039, 0x12345, v2
// GFX10-ERR: :[[@LINE-1]]:{{[0-9]+}}: error: only one unique literal operand is allowed
// GFX9-ERR:  error: literal operands are not supported

v_bfe_u32 v0, s1, 0x3039, s1
// GFX9-ERR:  error: literal operands are not supported
// GFX10: v_bfe_u32 v0, s1, 0x3039, s1 ; encoding: [0x00,0x00,0x48,0xd5,0x01,0xfe,0x05,0x00,0x39,0x30,0x00,0x00]

v_bfe_u32 v0, s1, 0x3039, s2
// GFX9-ERR:  error: literal operands are not supported
// GFX10-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: invalid operand (violates constant bus restrictions)

v_bfm_b32_e64 v0, 0x3039, s1
// GFX10:     v_bfm_b32 v0, 0x3039, s1 ; encoding: [0x00,0x00,0x63,0xd7,0xff,0x02,0x00,0x00,0x39,0x30,0x00,0x00]
// GFX9-ERR:  error: literal operands are not supported

v_bfm_b32_e64 v0, 0x3039, v1
// GFX10:    v_bfm_b32 v0, 0x3039, v1 ; encoding: [0x00,0x00,0x63,0xd7,0xff,0x02,0x02,0x00,0x39,0x30,0x00,0x00]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: literal operands are not supported

v_bfm_b32_e64 v0, 0x3039, 0x3039
// GFX10:    v_bfm_b32 v0, 0x3039, 0x3039 ; encoding: [0x00,0x00,0x63,0xd7,0xff,0xfe,0x01,0x00,0x39,0x30,0x00,0x00]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: literal operands are not supported

v_bfm_b32_e64 v0, 0x3039, 0x3038
// GFX10-ERR: :[[@LINE-1]]:{{[0-9]+}}: error: only one unique literal operand is allowed
// GFX9-ERR:  error: literal operands are not supported

v_pk_add_f16 v1, 25.0, v2
// GFX10:    v_pk_add_f16 v1, 0x4e40, v2     ; encoding: [0x01,0x40,0x0f,0xcc,0xff,0x04,0x02,0x18,0x40,0x4e,0x00,0x00]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: literal operands are not supported

v_pk_add_f16 v1, 123456, v2
// GFX10:    v_pk_add_f16 v1, 0x1e240, v2    ; encoding: [0x01,0x40,0x0f,0xcc,0xff,0x04,0x02,0x18,0x40,0xe2,0x01,0x00]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: literal operands are not supported

v_pk_add_f16 v1, -200, v2
// GFX10:    v_pk_add_f16 v1, 0xffffff38, v2 ; encoding: [0x01,0x40,0x0f,0xcc,0xff,0x04,0x02,0x18,0x38,0xff,0xff,0xff]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: literal operands are not supported

v_pk_add_f16 v1, 25.0, 25.0
// GFX10:    v_pk_add_f16 v1, 0x4e40, 0x4e40 ; encoding: [0x01,0x40,0x0f,0xcc,0xff,0xfe,0x01,0x18,0x40,0x4e,0x00,0x00]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: literal operands are not supported

v_pk_add_f16 v1, 25.0, 25.1
// GFX10-ERR: :[[@LINE-1]]:{{[0-9]+}}: error: only one unique literal operand is allowed
// GFX9-ERR:  error: literal operands are not supported

v_pk_add_u16 v1, -200, v2
// GFX10:    v_pk_add_u16 v1, 0xffffff38, v2 ; encoding: [0x01,0x40,0x0a,0xcc,0xff,0x04,0x02,0x18,0x38,0xff,0xff,0xff]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: literal operands are not supported

v_pk_add_u16 v1, 64, v2
// GFX10: v_pk_add_u16 v1, 64, v2         ; encoding: [0x01,0x40,0x0a,0xcc,0xc0,0x04,0x02,0x18]
// GFX9:  v_pk_add_u16 v1, 64, v2         ; encoding: [0x01,0x40,0x8a,0xd3,0xc0,0x04,0x02,0x18]

v_pk_add_u16 v1, 65, v2
// GFX10: v_pk_add_u16 v1, 0x41, v2       ; encoding: [0x01,0x40,0x0a,0xcc,0xff,0x04,0x02,0x18,0x41,0x00,0x00,0x00]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: literal operands are not supported

v_pk_add_u16 v1, -1, v2
// GFX10: v_pk_add_u16 v1, -1, v2         ; encoding: [0x01,0x40,0x0a,0xcc,0xc1,0x04,0x02,0x18]
// GFX9:  v_pk_add_u16 v1, -1, v2         ; encoding: [0x01,0x40,0x8a,0xd3,0xc1,0x04,0x02,0x18]

v_pk_add_u16 v1, -5, v2
// GFX10: v_pk_add_u16 v1, -5, v2         ; encoding: [0x01,0x40,0x0a,0xcc,0xc5,0x04,0x02,0x18]
// GFX9:  v_pk_add_u16 v1, -5, v2         ; encoding: [0x01,0x40,0x8a,0xd3,0xc5,0x04,0x02,0x18]

v_pk_add_u16 v1, -100, v2
// GFX10: v_pk_add_u16 v1, 0xffffff9c, v2 ; encoding: [0x01,0x40,0x0a,0xcc,0xff,0x04,0x02,0x18,0x9c,0xff,0xff,0xff]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: literal operands are not supported

v_pk_add_u16 v1, -100, -100
// GFX10: v_pk_add_u16 v1, 0xffffff9c, 0xffffff9c ; encoding: [0x01,0x40,0x0a,0xcc,0xff,0xfe,0x01,0x18,0x9c,0xff,0xff,0xff]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: literal operands are not supported

v_add_f32_e64 v1, neg(abs(0x123)), v3
// GFX10: v_add_f32_e64 v1, -|0x123|, v3  ; encoding: [0x01,0x01,0x03,0xd5,0xff,0x06,0x02,0x20,0x23,0x01,0x00,0x00]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: literal operands are not supported

v_add_f32_e64 v1, v3, neg(0x123)
// GFX10: v_add_f32_e64 v1, v3, neg(0x123) ; encoding: [0x01,0x00,0x03,0xd5,0x03,0xff,0x01,0x40,0x23,0x01,0x00,0x00]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: literal operands are not supported

v_add_f32_e64 v1, neg(abs(0x12345678)), neg(0x12345678)
// GFX10: v_add_f32_e64 v1, -|0x12345678|, neg(0x12345678) ; encoding: [0x01,0x01,0x03,0xd5,0xff,0xfe,0x01,0x60,0x78,0x56,0x34,0x12]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: literal operands are not supported

v_add_f16_e64 v0, v0, 0xfe0b
// GFX10: v_add_f16_e64 v0, v0, 0xfe0b      ; encoding: [0x00,0x00,0x32,0xd5,0x00,0xff,0x01,0x00,0x0b,0xfe,0x00,0x00]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: literal operands are not supported

v_add_f16_e64 v0, v0, neg(0xfe0b)
// GFX10: v_add_f16_e64 v0, v0, neg(0xfe0b) ; encoding: [0x00,0x00,0x32,0xd5,0x00,0xff,0x01,0x40,0x0b,0xfe,0x00,0x00]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: literal operands are not supported

v_add_f16_e64 v0, 0x3456, v0
// GFX10: v_add_f16_e64 v0, 0x3456, v0      ; encoding: [0x00,0x00,0x32,0xd5,0xff,0x00,0x02,0x00,0x56,0x34,0x00,0x00]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: literal operands are not supported

v_add_f16_e64 v0, 0xfe0b, neg(0xfe0b)
// GFX10: v_add_f16_e64 v0, 0xfe0b, neg(0xfe0b) ; encoding: [0x00,0x00,0x32,0xd5,0xff,0xfe,0x01,0x40,0x0b,0xfe,0x00,0x00]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: literal operands are not supported

v_add_f64 v[0:1], 1.23456, v[0:1]
// GFX10: v_add_f64 v[0:1], 0x3ff3c0c1, v[0:1] ; encoding: [0x00,0x00,0x64,0xd5,0xff,0x00,0x02,0x00,0xc1,0xc0,0xf3,0x3f]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: literal operands are not supported

v_add_f64 v[0:1], v[0:1], -abs(1.23456)
// GFX10: v_add_f64 v[0:1], v[0:1], -|0x3ff3c0c1| ; encoding: [0x00,0x02,0x64,0xd5,0x00,0xff,0x01,0x40,0xc1,0xc0,0xf3,0x3f]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: literal operands are not supported

v_add_f64 v[0:1], 1.23456, -abs(1.23456)
// GFX10: v_add_f64 v[0:1], 0x3ff3c0c1, -|0x3ff3c0c1| ; encoding: [0x00,0x02,0x64,0xd5,0xff,0xfe,0x01,0x40,0xc1,0xc0,0xf3,0x3f]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: literal operands are not supported

v_add_f64 v[0:1], 1.23456, -abs(1.2345)
// GFX10-ERR: :[[@LINE-1]]:{{[0-9]+}}: error: only one unique literal operand is allowed
// GFX9-ERR:  error: literal operands are not supported

v_max_i16_e64 v5, 0xfe0b, v2
// GFX10: v_max_i16 v5, 0xfe0b, v2 ; encoding: [0x05,0x00,0x0a,0xd7,0xff,0x04,0x02,0x00,0x0b,0xfe,0x00,0x00]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: literal operands are not supported

v_max_i16_e64 v5, v1, 0x123
// GFX10: v_max_i16 v5, v1, 0x123 ; encoding: [0x05,0x00,0x0a,0xd7,0x01,0xff,0x01,0x00,0x23,0x01,0x00,0x00]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: literal operands are not supported

v_max_i16_e64 v5, 0x1234, 0x1234
// GFX10: v_max_i16 v5, 0x1234, 0x1234 ; encoding: [0x05,0x00,0x0a,0xd7,0xff,0xfe,0x01,0x00,0x34,0x12,0x00,0x00]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: literal operands are not supported

v_min3_i16 v5, 0xfe0b, v2, v3
// GFX10: v_min3_i16 v5, 0xfe0b, v2, v3   ; encoding: [0x05,0x00,0x52,0xd7,0xff,0x04,0x0e,0x04,0x0b,0xfe,0x00,0x00]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: literal operands are not supported

v_min3_i16 v5, v1, 0x1234, v3
// GFX10: v_min3_i16 v5, v1, 0x1234, v3   ; encoding: [0x05,0x00,0x52,0xd7,0x01,0xff,0x0d,0x04,0x34,0x12,0x00,0x00]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: literal operands are not supported

v_min3_i16 v5, v1, v2, 0x5678
// GFX10: v_min3_i16 v5, v1, v2, 0x5678   ; encoding: [0x05,0x00,0x52,0xd7,0x01,0x05,0xfe,0x03,0x78,0x56,0x00,0x00]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: literal operands are not supported

v_min3_i16 v5, 0x5678, 0x5678, 0x5678
// GFX10: v_min3_i16 v5, 0x5678, 0x5678, 0x5678 ; encoding: [0x05,0x00,0x52,0xd7,0xff,0xfe,0xfd,0x03,0x78,0x56,0x00,0x00]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: literal operands are not supported

v_min3_i16 v5, 0x5678, 0x5679, 0x5678
// GFX10-ERR: :[[@LINE-1]]:{{[0-9]+}}: error: only one unique literal operand is allowed
// GFX9-ERR:  error: literal operands are not supported

v_min3_i16 v5, 0x5678, 0x5678, 0x5679
// GFX10-ERR: :[[@LINE-1]]:{{[0-9]+}}: error: only one unique literal operand is allowed
// GFX9-ERR:  error: literal operands are not supported

v_add_nc_u16 v5, 0xfe0b, v2
// GFX10: v_add_nc_u16 v5, 0xfe0b, v2 ; encoding: [0x05,0x00,0x03,0xd7,0xff,0x04,0x02,0x00,0x0b,0xfe,0x00,0x00]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction not supported on this GPU

v_add_nc_u16 v5, v1, 0x1234
// GFX10: v_add_nc_u16 v5, v1, 0x1234 ; encoding: [0x05,0x00,0x03,0xd7,0x01,0xff,0x01,0x00,0x34,0x12,0x00,0x00]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction not supported on this GPU

v_add_nc_u16 v5, 0x1234, 0x1234
// GFX10: v_add_nc_u16 v5, 0x1234, 0x1234 ; encoding: [0x05,0x00,0x03,0xd7,0xff,0xfe,0x01,0x00,0x34,0x12,0x00,0x00]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction not supported on this GPU

v_ashrrev_i16_e64 v5, 0x3456, v2
// GFX10: v_ashrrev_i16 v5, 0x3456, v2 ; encoding: [0x05,0x00,0x08,0xd7,0xff,0x04,0x02,0x00,0x56,0x34,0x00,0x00]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: literal operands are not supported

v_mad_u16 v5, 0xfe0b, v2, v3
// GFX10: v_mad_u16 v5, 0xfe0b, v2, v3    ; encoding: [0x05,0x00,0x40,0xd7,0xff,0x04,0x0e,0x04,0x0b,0xfe,0x00,0x00]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: literal operands are not supported

v_mad_u16 v5, v1, 0x1234, v3
// GFX10: v_mad_u16 v5, v1, 0x1234, v3    ; encoding: [0x05,0x00,0x40,0xd7,0x01,0xff,0x0d,0x04,0x34,0x12,0x00,0x00]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: literal operands are not supported

v_mad_u16 v5, v1, v2, 0x5678
// GFX10: v_mad_u16 v5, v1, v2, 0x5678    ; encoding: [0x05,0x00,0x40,0xd7,0x01,0x05,0xfe,0x03,0x78,0x56,0x00,0x00]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: literal operands are not supported

v_mad_u16 v5, 0x5678, 0x5678, 0x5678
// GFX10: v_mad_u16 v5, 0x5678, 0x5678, 0x5678 ; encoding: [0x05,0x00,0x40,0xd7,0xff,0xfe,0xfd,0x03,0x78,0x56,0x00,0x00]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: literal operands are not supported

v_mad_legacy_f32 v5, 0xaf123456, v2, v3
// GFX10: v_mad_legacy_f32 v5, 0xaf123456, v2, v3 ; encoding: [0x05,0x00,0x40,0xd5,0xff,0x04,0x0e,0x04,0x56,0x34,0x12,0xaf]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: literal operands are not supported

v_mad_legacy_f32 v5, v1, 0xaf123456, v3
// GFX10: v_mad_legacy_f32 v5, v1, 0xaf123456, v3 ; encoding: [0x05,0x00,0x40,0xd5,0x01,0xff,0x0d,0x04,0x56,0x34,0x12,0xaf]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: literal operands are not supported

v_mad_legacy_f32 v5, v1, v2, 0xaf123456
// GFX10: v_mad_legacy_f32 v5, v1, v2, 0xaf123456 ; encoding: [0x05,0x00,0x40,0xd5,0x01,0x05,0xfe,0x03,0x56,0x34,0x12,0xaf]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: literal operands are not supported

v_mad_legacy_f32 v5, 0xaf123456, 0xaf123456, 0xaf123456
// GFX10: v_mad_legacy_f32 v5, 0xaf123456, 0xaf123456, 0xaf123456 ; encoding: [0x05,0x00,0x40,0xd5,0xff,0xfe,0xfd,0x03,0x56,0x34,0x12,0xaf]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: literal operands are not supported

v_cmp_f_i32_e64 s[10:11], 0xaf123456, v2
// GFX10: v_cmp_f_i32_e64 s[10:11], 0xaf123456, v2 ; encoding: [0x0a,0x00,0x80,0xd4,0xff,0x04,0x02,0x00,0x56,0x34,0x12,0xaf]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: literal operands are not supported

v_cmp_f_i32_e64 s[10:11], v1, 0xaf123456
// GFX10: v_cmp_f_i32_e64 s[10:11], v1, 0xaf123456 ; encoding: [0x0a,0x00,0x80,0xd4,0x01,0xff,0x01,0x00,0x56,0x34,0x12,0xaf]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: literal operands are not supported

v_cmp_f_i32_e64 s[10:11], 0xaf123456, 0xaf123456
// GFX10: v_cmp_f_i32_e64 s[10:11], 0xaf123456, 0xaf123456 ; encoding: [0x0a,0x00,0x80,0xd4,0xff,0xfe,0x01,0x00,0x56,0x34,0x12,0xaf]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: literal operands are not supported

v_cmp_f_i32_e64 s[10:11], 0xaf123456, 0xaf123455
// GFX10-ERR: :[[@LINE-1]]:{{[0-9]+}}: error: only one unique literal operand is allowed
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: literal operands are not supported

v_cmp_f_u64_e64 s[10:11], 0xaf123456, v[2:3]
// GFX10: v_cmp_f_u64_e64 s[10:11], 0xaf123456, v[2:3] ; encoding: [0x0a,0x00,0xe0,0xd4,0xff,0x04,0x02,0x00,0x56,0x34,0x12,0xaf]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: literal operands are not supported

v_cmp_f_u64_e64 s[10:11], v[1:2], 0x3f717273
// GFX10: v_cmp_f_u64_e64 s[10:11], v[1:2], 0x3f717273 ; encoding: [0x0a,0x00,0xe0,0xd4,0x01,0xff,0x01,0x00,0x73,0x72,0x71,0x3f]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: literal operands are not supported

v_cmp_f_u64_e64 s[10:11], 0x3f717273, 0x3f717273
// GFX10: v_cmp_f_u64_e64 s[10:11], 0x3f717273, 0x3f717273 ; encoding: [0x0a,0x00,0xe0,0xd4,0xff,0xfe,0x01,0x00,0x73,0x72,0x71,0x3f]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: literal operands are not supported

v_cmpx_class_f32_e64 0xaf123456, v2
// GFX10: v_cmpx_class_f32_e64 0xaf123456, v2 ; encoding: [0x7e,0x00,0x98,0xd4,0xff,0x04,0x02,0x00,0x56,0x34,0x12,0xaf]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmpx_class_f32_e64 v1, 0xaf123456
// GFX10: v_cmpx_class_f32_e64 v1, 0xaf123456 ; encoding: [0x7e,0x00,0x98,0xd4,0x01,0xff,0x01,0x00,0x56,0x34,0x12,0xaf]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmpx_class_f32_e64 0xaf123456, 0xaf123456
// GFX10: v_cmpx_class_f32_e64 0xaf123456, 0xaf123456 ; encoding: [0x7e,0x00,0x98,0xd4,0xff,0xfe,0x01,0x00,0x56,0x34,0x12,0xaf]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmpx_class_f32_e64 0xaf123456, 0xaf123455
// GFX10-ERR: :[[@LINE-1]]:{{[0-9]+}}: error: only one unique literal operand is allowed
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmpx_lt_i16_e64 v1, 0x3456
// GFX10: v_cmpx_lt_i16_e64 v1, 0x3456    ; encoding: [0x7e,0x00,0x99,0xd4,0x01,0xff,0x01,0x00,0x56,0x34,0x00,0x00]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmpx_lt_i16_e64 0x3456, v2
// GFX10: v_cmpx_lt_i16_e64 0x3456, v2    ; encoding: [0x7e,0x00,0x99,0xd4,0xff,0x04,0x02,0x00,0x56,0x34,0x00,0x00]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmpx_lt_i16_e64 0x3456, 0x3456
// GFX10: v_cmpx_lt_i16_e64 0x3456, 0x3456 ; encoding: [0x7e,0x00,0x99,0xd4,0xff,0xfe,0x01,0x00,0x56,0x34,0x00,0x00]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmpx_f_i64_e64 0xaf123456, v[2:3]
// GFX10: v_cmpx_f_i64_e64 0xaf123456, v[2:3] ; encoding: [0x7e,0x00,0xb0,0xd4,0xff,0x04,0x02,0x00,0x56,0x34,0x12,0xaf]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmpx_f_i64_e64 v[1:2], 0x3f717273
// GFX10: v_cmpx_f_i64_e64 v[1:2], 0x3f717273 ; encoding: [0x7e,0x00,0xb0,0xd4,0x01,0xff,0x01,0x00,0x73,0x72,0x71,0x3f]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmpx_f_i64_e64 0x3f717273, 0x3f717273
// GFX10: v_cmpx_f_i64_e64 0x3f717273, 0x3f717273 ; encoding: [0x7e,0x00,0xb0,0xd4,0xff,0xfe,0x01,0x00,0x73,0x72,0x71,0x3f]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_lshlrev_b64 v[5:6], 0xaf123456, v[2:3]
// GFX10: v_lshlrev_b64 v[5:6], 0xaf123456, v[2:3] ; encoding: [0x05,0x00,0xff,0xd6,0xff,0x04,0x02,0x00,0x56,0x34,0x12,0xaf]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: literal operands are not supported

v_lshlrev_b64 v[5:6], v1, 0x3f717273
// GFX10: v_lshlrev_b64 v[5:6], v1, 0x3f717273 ; encoding: [0x05,0x00,0xff,0xd6,0x01,0xff,0x01,0x00,0x73,0x72,0x71,0x3f]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: literal operands are not supported

v_fma_mix_f32 v5, 0x123, v2, v3
// GFX10: v_fma_mix_f32 v5, 0x123, v2, v3 ; encoding: [0x05,0x00,0x20,0xcc,0xff,0x04,0x0e,0x04,0x23,0x01,0x00,0x00]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction not supported on this GPU

v_fma_mix_f32 v5, v1, 0x7b, v3
// GFX10: v_fma_mix_f32 v5, v1, 0x7b, v3  ; encoding: [0x05,0x00,0x20,0xcc,0x01,0xff,0x0d,0x04,0x7b,0x00,0x00,0x00]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction not supported on this GPU

v_fma_mix_f32 v5, v1, v2, 0x1c8
// GFX10: v_fma_mix_f32 v5, v1, v2, 0x1c8 ; encoding: [0x05,0x00,0x20,0xcc,0x01,0x05,0xfe,0x03,0xc8,0x01,0x00,0x00]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction not supported on this GPU

v_fma_mix_f32 v5, 0x1c8a, v2, 0x1c8a
// GFX10: v_fma_mix_f32 v5, 0x1c8a, v2, 0x1c8a ; encoding: [0x05,0x00,0x20,0xcc,0xff,0x04,0xfe,0x03,0x8a,0x1c,0x00,0x00]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction not supported on this GPU

v_fma_mix_f32 v5, 0x1c8a, 0x1c8a, 0x1c8a
// GFX10: v_fma_mix_f32 v5, 0x1c8a, 0x1c8a, 0x1c8a ; encoding: [0x05,0x00,0x20,0xcc,0xff,0xfe,0xfd,0x03,0x8a,0x1c,0x00,0x00]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: instruction not supported on this GPU

v_pk_add_f16 v5, 0xaf123456, v2
// GFX10: v_pk_add_f16 v5, 0xaf123456, v2 ; encoding: [0x05,0x40,0x0f,0xcc,0xff,0x04,0x02,0x18,0x56,0x34,0x12,0xaf]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: literal operands are not supported

v_pk_add_f16 v5, v1, 0x3f717273
// GFX10: v_pk_add_f16 v5, v1, 0x3f717273 ; encoding: [0x05,0x40,0x0f,0xcc,0x01,0xff,0x01,0x18,0x73,0x72,0x71,0x3f]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: literal operands are not supported

v_pk_add_f16 v5, 0x3f717273, 0x3f717273
// GFX10: v_pk_add_f16 v5, 0x3f717273, 0x3f717273 ; encoding: [0x05,0x40,0x0f,0xcc,0xff,0xfe,0x01,0x18,0x73,0x72,0x71,0x3f]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: literal operands are not supported

v_pk_add_i16 v5, 0x7b, v2
// GFX10: v_pk_add_i16 v5, 0x7b, v2       ; encoding: [0x05,0x40,0x02,0xcc,0xff,0x04,0x02,0x18,0x7b,0x00,0x00,0x00]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: literal operands are not supported

v_pk_add_i16 v5, v1, 0x7b
// GFX10: v_pk_add_i16 v5, v1, 0x7b       ; encoding: [0x05,0x40,0x02,0xcc,0x01,0xff,0x01,0x18,0x7b,0x00,0x00,0x00]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: literal operands are not supported

v_pk_add_i16 v5, 0xab7b, 0xab7b
// GFX10: v_pk_add_i16 v5, 0xab7b, 0xab7b ; encoding: [0x05,0x40,0x02,0xcc,0xff,0xfe,0x01,0x18,0x7b,0xab,0x00,0x00]
// GFX9-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: literal operands are not supported

v_pk_add_i16 v5, 0xab7b, 0xab7a
// GFX10-ERR: :[[@LINE-1]]:{{[0-9]+}}: error: only one unique literal operand is allowed
// GFX9-ERR:  error: literal operands are not supported

v_div_fmas_f32 v5, v1, 0x123, v3
// GFX10: v_div_fmas_f32 v5, v1, 0x123, v3 ; encoding: [0x05,0x00,0x6f,0xd5,0x01,0xff,0x0d,0x04,0x23,0x01,0x00,0x00]
// GFX9-ERR:  error: literal operands are not supported

v_div_fmas_f32 v5, v1, 0x123, 0x123
// GFX10: v_div_fmas_f32 v5, v1, 0x123, 0x123 ; encoding: [0x05,0x00,0x6f,0xd5,0x01,0xff,0xfd,0x03,0x23,0x01,0x00,0x00]
// GFX9-ERR:  error: literal operands are not supported

v_div_fmas_f32 v5, 0x123, 0x123, 0x123
// GFX10: v_div_fmas_f32 v5, 0x123, 0x123, 0x123 ; encoding: [0x05,0x00,0x6f,0xd5,0xff,0xfe,0xfd,0x03,0x23,0x01,0x00,0x00]
// GFX9-ERR:  error: literal operands are not supported

v_div_fmas_f64 v[5:6], 0x12345678, v[2:3], v[3:4]
// GFX10: v_div_fmas_f64 v[5:6], 0x12345678, v[2:3], v[3:4] ; encoding: [0x05,0x00,0x70,0xd5,0xff,0x04,0x0e,0x04,0x78,0x56,0x34,0x12]
// GFX9-ERR:  error: literal operands are not supported

v_div_fmas_f64 v[5:6], 0x12345678, 0x12345678, 0x12345678
// GFX10: v_div_fmas_f64 v[5:6], 0x12345678, 0x12345678, 0x12345678 ; encoding: [0x05,0x00,0x70,0xd5,0xff,0xfe,0xfd,0x03,0x78,0x56,0x34,0x12]
// GFX9-ERR:  error: literal operands are not supported

v_div_fmas_f64 v[5:6], v[1:2], 0x123457, 0x123456
// GFX10-ERR: :[[@LINE-1]]:{{[0-9]+}}: error: only one unique literal operand is allowed
// GFX9-ERR:  error: literal operands are not supported

v_ldexp_f64 v[5:6], 0.12345, v2
// GFX10: v_ldexp_f64 v[5:6], 0x3fbf9a6b, v2 ; encoding: [0x05,0x00,0x68,0xd5,0xff,0x04,0x02,0x00,0x6b,0x9a,0xbf,0x3f]
// GFX9-ERR:  error: literal operands are not supported

v_ldexp_f64 v[5:6], 0.12345, 0x3fbf9a6b
// GFX10: v_ldexp_f64 v[5:6], 0x3fbf9a6b, 0x3fbf9a6b ; encoding: [0x05,0x00,0x68,0xd5,0xff,0xfe,0x01,0x00,0x6b,0x9a,0xbf,0x3f]
// GFX9-ERR:  error: literal operands are not supported

v_ldexp_f64 v[5:6], 0.12345, 0x3fbf9a6c
// GFX10-ERR: :[[@LINE-1]]:{{[0-9]+}}: error: only one unique literal operand is allowed
// GFX9-ERR:  error: literal operands are not supported
