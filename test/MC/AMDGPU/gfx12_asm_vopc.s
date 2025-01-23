// RUN: not llvm-mc -triple=amdgcn -mcpu=gfx1200 -mattr=+wavefrontsize32 -show-encoding %s | FileCheck --check-prefix=W32 %s
// RUN: not llvm-mc -triple=amdgcn -mcpu=gfx1200 -mattr=+wavefrontsize64 -show-encoding %s | FileCheck --check-prefix=W64 %s
// RUN: not llvm-mc -triple=amdgcn -mcpu=gfx1200 -mattr=+wavefrontsize32 %s 2>&1 | FileCheck --check-prefix=W32-ERR --implicit-check-not=error: %s
// RUN: not llvm-mc -triple=amdgcn -mcpu=gfx1200 -mattr=+wavefrontsize64 %s 2>&1 | FileCheck --check-prefix=W64-ERR --implicit-check-not=error: %s

v_cmp_class_f16_e32 vcc_lo, v1, v2
// W32: encoding: [0x01,0x05,0xfa,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f16 vcc_lo, v127, v2
// W32: encoding: [0x7f,0x05,0xfa,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f16 vcc_lo, s1, v2
// W32: encoding: [0x01,0x04,0xfa,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f16 vcc_lo, s105, v2
// W32: encoding: [0x69,0x04,0xfa,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f16 vcc_lo, vcc_lo, v2
// W32: encoding: [0x6a,0x04,0xfa,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f16 vcc_lo, vcc_hi, v2
// W32: encoding: [0x6b,0x04,0xfa,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f16 vcc_lo, ttmp15, v2
// W32: encoding: [0x7b,0x04,0xfa,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f16 vcc_lo, m0, v2
// W32: encoding: [0x7d,0x04,0xfa,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f16 vcc_lo, exec_lo, v2
// W32: encoding: [0x7e,0x04,0xfa,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f16 vcc_lo, exec_hi, v2
// W32: encoding: [0x7f,0x04,0xfa,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f16 vcc_lo, null, v2
// W32: encoding: [0x7c,0x04,0xfa,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f16 vcc_lo, -1, v2
// W32: encoding: [0xc1,0x04,0xfa,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f16 vcc_lo, 0.5, v2
// W32: encoding: [0xf0,0x04,0xfa,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f16 vcc_lo, src_scc, v2
// W32: encoding: [0xfd,0x04,0xfa,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f16 vcc_lo, 0xfe0b, v127
// W32: encoding: [0xff,0xfe,0xfa,0x7c,0x0b,0xfe,0x00,0x00]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f16 vcc, v1, v2
// W64: encoding: [0x01,0x05,0xfa,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f16 vcc, v127, v2
// W64: encoding: [0x7f,0x05,0xfa,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f16 vcc, s1, v2
// W64: encoding: [0x01,0x04,0xfa,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f16 vcc, s105, v2
// W64: encoding: [0x69,0x04,0xfa,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f16 vcc, vcc_lo, v2
// W64: encoding: [0x6a,0x04,0xfa,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f16 vcc, vcc_hi, v2
// W64: encoding: [0x6b,0x04,0xfa,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f16 vcc, ttmp15, v2
// W64: encoding: [0x7b,0x04,0xfa,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f16 vcc, m0, v2
// W64: encoding: [0x7d,0x04,0xfa,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f16 vcc, exec_lo, v2
// W64: encoding: [0x7e,0x04,0xfa,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f16 vcc, exec_hi, v2
// W64: encoding: [0x7f,0x04,0xfa,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f16 vcc, null, v2
// W64: encoding: [0x7c,0x04,0xfa,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f16 vcc, -1, v2
// W64: encoding: [0xc1,0x04,0xfa,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f16 vcc, 0.5, v2
// W64: encoding: [0xf0,0x04,0xfa,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f16 vcc, src_scc, v2
// W64: encoding: [0xfd,0x04,0xfa,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f16 vcc, 0xfe0b, v127
// W64: encoding: [0xff,0xfe,0xfa,0x7c,0x0b,0xfe,0x00,0x00]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc_lo, v1, v2
// W32: encoding: [0x01,0x05,0xfc,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc_lo, v255, v2
// W32: encoding: [0xff,0x05,0xfc,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc_lo, s1, v2
// W32: encoding: [0x01,0x04,0xfc,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc_lo, s105, v2
// W32: encoding: [0x69,0x04,0xfc,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc_lo, vcc_lo, v2
// W32: encoding: [0x6a,0x04,0xfc,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc_lo, vcc_hi, v2
// W32: encoding: [0x6b,0x04,0xfc,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc_lo, ttmp15, v2
// W32: encoding: [0x7b,0x04,0xfc,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc_lo, m0, v2
// W32: encoding: [0x7d,0x04,0xfc,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc_lo, exec_lo, v2
// W32: encoding: [0x7e,0x04,0xfc,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc_lo, exec_hi, v2
// W32: encoding: [0x7f,0x04,0xfc,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc_lo, null, v2
// W32: encoding: [0x7c,0x04,0xfc,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc_lo, -1, v2
// W32: encoding: [0xc1,0x04,0xfc,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc_lo, 0.5, v2
// W32: encoding: [0xf0,0x04,0xfc,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc_lo, src_scc, v2
// W32: encoding: [0xfd,0x04,0xfc,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc_lo, 0xaf123456, v255
// W32: encoding: [0xff,0xfe,0xfd,0x7c,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc, v1, v2
// W64: encoding: [0x01,0x05,0xfc,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc, v255, v2
// W64: encoding: [0xff,0x05,0xfc,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc, s1, v2
// W64: encoding: [0x01,0x04,0xfc,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc, s105, v2
// W64: encoding: [0x69,0x04,0xfc,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc, vcc_lo, v2
// W64: encoding: [0x6a,0x04,0xfc,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc, vcc_hi, v2
// W64: encoding: [0x6b,0x04,0xfc,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc, ttmp15, v2
// W64: encoding: [0x7b,0x04,0xfc,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc, m0, v2
// W64: encoding: [0x7d,0x04,0xfc,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc, exec_lo, v2
// W64: encoding: [0x7e,0x04,0xfc,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc, exec_hi, v2
// W64: encoding: [0x7f,0x04,0xfc,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc, null, v2
// W64: encoding: [0x7c,0x04,0xfc,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc, -1, v2
// W64: encoding: [0xc1,0x04,0xfc,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc, 0.5, v2
// W64: encoding: [0xf0,0x04,0xfc,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc, src_scc, v2
// W64: encoding: [0xfd,0x04,0xfc,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f32 vcc, 0xaf123456, v255
// W64: encoding: [0xff,0xfe,0xfd,0x7c,0x56,0x34,0x12,0xaf]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f64 vcc_lo, v[1:2], v2
// W32: encoding: [0x01,0x05,0xfe,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f64 vcc_lo, v[254:255], v2
// W32: encoding: [0xfe,0x05,0xfe,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f64 vcc_lo, s[2:3], v2
// W32: encoding: [0x02,0x04,0xfe,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f64 vcc_lo, s[104:105], v2
// W32: encoding: [0x68,0x04,0xfe,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f64 vcc_lo, vcc, v2
// W32: encoding: [0x6a,0x04,0xfe,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f64 vcc_lo, ttmp[14:15], v2
// W32: encoding: [0x7a,0x04,0xfe,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f64 vcc_lo, exec, v2
// W32: encoding: [0x7e,0x04,0xfe,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f64 vcc_lo, null, v2
// W32: encoding: [0x7c,0x04,0xfe,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f64 vcc_lo, -1, v2
// W32: encoding: [0xc1,0x04,0xfe,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f64 vcc_lo, 0.5, v2
// W32: encoding: [0xf0,0x04,0xfe,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f64 vcc_lo, src_scc, v2
// W32: encoding: [0xfd,0x04,0xfe,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f64 vcc_lo, 0xaf123456, v255
// W32: encoding: [0xff,0xfe,0xff,0x7c,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f64 vcc, v[1:2], v2
// W64: encoding: [0x01,0x05,0xfe,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f64 vcc, v[254:255], v2
// W64: encoding: [0xfe,0x05,0xfe,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f64 vcc, s[2:3], v2
// W64: encoding: [0x02,0x04,0xfe,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f64 vcc, s[104:105], v2
// W64: encoding: [0x68,0x04,0xfe,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f64 vcc, vcc, v2
// W64: encoding: [0x6a,0x04,0xfe,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f64 vcc, ttmp[14:15], v2
// W64: encoding: [0x7a,0x04,0xfe,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f64 vcc, exec, v2
// W64: encoding: [0x7e,0x04,0xfe,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f64 vcc, null, v2
// W64: encoding: [0x7c,0x04,0xfe,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f64 vcc, -1, v2
// W64: encoding: [0xc1,0x04,0xfe,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f64 vcc, 0.5, v2
// W64: encoding: [0xf0,0x04,0xfe,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f64 vcc, src_scc, v2
// W64: encoding: [0xfd,0x04,0xfe,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_class_f64 vcc, 0xaf123456, v255
// W64: encoding: [0xff,0xfe,0xff,0x7c,0x56,0x34,0x12,0xaf]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc_lo, v1, v2
// W32: encoding: [0x01,0x05,0x04,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc_lo, v127, v2
// W32: encoding: [0x7f,0x05,0x04,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc_lo, s1, v2
// W32: encoding: [0x01,0x04,0x04,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc_lo, s105, v2
// W32: encoding: [0x69,0x04,0x04,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc_lo, vcc_lo, v2
// W32: encoding: [0x6a,0x04,0x04,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc_lo, vcc_hi, v2
// W32: encoding: [0x6b,0x04,0x04,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc_lo, ttmp15, v2
// W32: encoding: [0x7b,0x04,0x04,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc_lo, m0, v2
// W32: encoding: [0x7d,0x04,0x04,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc_lo, exec_lo, v2
// W32: encoding: [0x7e,0x04,0x04,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc_lo, exec_hi, v2
// W32: encoding: [0x7f,0x04,0x04,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc_lo, null, v2
// W32: encoding: [0x7c,0x04,0x04,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc_lo, -1, v2
// W32: encoding: [0xc1,0x04,0x04,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc_lo, 0.5, v2
// W32: encoding: [0xf0,0x04,0x04,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc_lo, src_scc, v2
// W32: encoding: [0xfd,0x04,0x04,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc_lo, 0xfe0b, v127
// W32: encoding: [0xff,0xfe,0x04,0x7c,0x0b,0xfe,0x00,0x00]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc, v1, v2
// W64: encoding: [0x01,0x05,0x04,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc, v127, v2
// W64: encoding: [0x7f,0x05,0x04,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc, s1, v2
// W64: encoding: [0x01,0x04,0x04,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc, s105, v2
// W64: encoding: [0x69,0x04,0x04,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc, vcc_lo, v2
// W64: encoding: [0x6a,0x04,0x04,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc, vcc_hi, v2
// W64: encoding: [0x6b,0x04,0x04,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc, ttmp15, v2
// W64: encoding: [0x7b,0x04,0x04,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc, m0, v2
// W64: encoding: [0x7d,0x04,0x04,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc, exec_lo, v2
// W64: encoding: [0x7e,0x04,0x04,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc, exec_hi, v2
// W64: encoding: [0x7f,0x04,0x04,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc, null, v2
// W64: encoding: [0x7c,0x04,0x04,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc, -1, v2
// W64: encoding: [0xc1,0x04,0x04,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc, 0.5, v2
// W64: encoding: [0xf0,0x04,0x04,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc, src_scc, v2
// W64: encoding: [0xfd,0x04,0x04,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f16 vcc, 0xfe0b, v127
// W64: encoding: [0xff,0xfe,0x04,0x7c,0x0b,0xfe,0x00,0x00]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc_lo, v1, v2
// W32: encoding: [0x01,0x05,0x24,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc_lo, v255, v2
// W32: encoding: [0xff,0x05,0x24,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc_lo, s1, v2
// W32: encoding: [0x01,0x04,0x24,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc_lo, s105, v2
// W32: encoding: [0x69,0x04,0x24,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc_lo, vcc_lo, v2
// W32: encoding: [0x6a,0x04,0x24,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc_lo, vcc_hi, v2
// W32: encoding: [0x6b,0x04,0x24,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc_lo, ttmp15, v2
// W32: encoding: [0x7b,0x04,0x24,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc_lo, m0, v2
// W32: encoding: [0x7d,0x04,0x24,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc_lo, exec_lo, v2
// W32: encoding: [0x7e,0x04,0x24,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc_lo, exec_hi, v2
// W32: encoding: [0x7f,0x04,0x24,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc_lo, null, v2
// W32: encoding: [0x7c,0x04,0x24,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc_lo, -1, v2
// W32: encoding: [0xc1,0x04,0x24,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc_lo, 0.5, v2
// W32: encoding: [0xf0,0x04,0x24,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc_lo, src_scc, v2
// W32: encoding: [0xfd,0x04,0x24,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc_lo, 0xaf123456, v255
// W32: encoding: [0xff,0xfe,0x25,0x7c,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc, v1, v2
// W64: encoding: [0x01,0x05,0x24,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc, v255, v2
// W64: encoding: [0xff,0x05,0x24,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc, s1, v2
// W64: encoding: [0x01,0x04,0x24,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc, s105, v2
// W64: encoding: [0x69,0x04,0x24,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc, vcc_lo, v2
// W64: encoding: [0x6a,0x04,0x24,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc, vcc_hi, v2
// W64: encoding: [0x6b,0x04,0x24,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc, ttmp15, v2
// W64: encoding: [0x7b,0x04,0x24,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc, m0, v2
// W64: encoding: [0x7d,0x04,0x24,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc, exec_lo, v2
// W64: encoding: [0x7e,0x04,0x24,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc, exec_hi, v2
// W64: encoding: [0x7f,0x04,0x24,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc, null, v2
// W64: encoding: [0x7c,0x04,0x24,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc, -1, v2
// W64: encoding: [0xc1,0x04,0x24,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc, 0.5, v2
// W64: encoding: [0xf0,0x04,0x24,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc, src_scc, v2
// W64: encoding: [0xfd,0x04,0x24,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f32 vcc, 0xaf123456, v255
// W64: encoding: [0xff,0xfe,0x25,0x7c,0x56,0x34,0x12,0xaf]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f64 vcc_lo, v[1:2], v[2:3]
// W32: encoding: [0x01,0x05,0x44,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f64 vcc_lo, v[254:255], v[2:3]
// W32: encoding: [0xfe,0x05,0x44,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f64 vcc_lo, s[2:3], v[2:3]
// W32: encoding: [0x02,0x04,0x44,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f64 vcc_lo, s[104:105], v[2:3]
// W32: encoding: [0x68,0x04,0x44,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f64 vcc_lo, vcc, v[2:3]
// W32: encoding: [0x6a,0x04,0x44,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f64 vcc_lo, ttmp[14:15], v[2:3]
// W32: encoding: [0x7a,0x04,0x44,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f64 vcc_lo, exec, v[2:3]
// W32: encoding: [0x7e,0x04,0x44,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f64 vcc_lo, null, v[2:3]
// W32: encoding: [0x7c,0x04,0x44,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f64 vcc_lo, -1, v[2:3]
// W32: encoding: [0xc1,0x04,0x44,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f64 vcc_lo, 0.5, v[2:3]
// W32: encoding: [0xf0,0x04,0x44,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f64 vcc_lo, src_scc, v[2:3]
// W32: encoding: [0xfd,0x04,0x44,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f64 vcc_lo, 0xaf123456, v[254:255]
// W32: encoding: [0xff,0xfc,0x45,0x7c,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f64 vcc, v[1:2], v[2:3]
// W64: encoding: [0x01,0x05,0x44,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f64 vcc, v[254:255], v[2:3]
// W64: encoding: [0xfe,0x05,0x44,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f64 vcc, s[2:3], v[2:3]
// W64: encoding: [0x02,0x04,0x44,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f64 vcc, s[104:105], v[2:3]
// W64: encoding: [0x68,0x04,0x44,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f64 vcc, vcc, v[2:3]
// W64: encoding: [0x6a,0x04,0x44,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f64 vcc, ttmp[14:15], v[2:3]
// W64: encoding: [0x7a,0x04,0x44,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f64 vcc, exec, v[2:3]
// W64: encoding: [0x7e,0x04,0x44,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f64 vcc, null, v[2:3]
// W64: encoding: [0x7c,0x04,0x44,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f64 vcc, -1, v[2:3]
// W64: encoding: [0xc1,0x04,0x44,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f64 vcc, 0.5, v[2:3]
// W64: encoding: [0xf0,0x04,0x44,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f64 vcc, src_scc, v[2:3]
// W64: encoding: [0xfd,0x04,0x44,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_f64 vcc, 0xaf123456, v[254:255]
// W64: encoding: [0xff,0xfc,0x45,0x7c,0x56,0x34,0x12,0xaf]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc_lo, v1, v2
// W32: encoding: [0x01,0x05,0x64,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc_lo, v127, v2
// W32: encoding: [0x7f,0x05,0x64,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc_lo, s1, v2
// W32: encoding: [0x01,0x04,0x64,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc_lo, s105, v2
// W32: encoding: [0x69,0x04,0x64,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc_lo, vcc_lo, v2
// W32: encoding: [0x6a,0x04,0x64,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc_lo, vcc_hi, v2
// W32: encoding: [0x6b,0x04,0x64,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc_lo, ttmp15, v2
// W32: encoding: [0x7b,0x04,0x64,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc_lo, m0, v2
// W32: encoding: [0x7d,0x04,0x64,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc_lo, exec_lo, v2
// W32: encoding: [0x7e,0x04,0x64,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc_lo, exec_hi, v2
// W32: encoding: [0x7f,0x04,0x64,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc_lo, null, v2
// W32: encoding: [0x7c,0x04,0x64,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc_lo, -1, v2
// W32: encoding: [0xc1,0x04,0x64,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc_lo, 0.5, v2
// W32: encoding: [0xf0,0x04,0x64,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc_lo, src_scc, v2
// W32: encoding: [0xfd,0x04,0x64,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc_lo, 0xfe0b, v127
// W32: encoding: [0xff,0xfe,0x64,0x7c,0x0b,0xfe,0x00,0x00]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc, v1, v2
// W64: encoding: [0x01,0x05,0x64,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc, v127, v2
// W64: encoding: [0x7f,0x05,0x64,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc, s1, v2
// W64: encoding: [0x01,0x04,0x64,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc, s105, v2
// W64: encoding: [0x69,0x04,0x64,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc, vcc_lo, v2
// W64: encoding: [0x6a,0x04,0x64,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc, vcc_hi, v2
// W64: encoding: [0x6b,0x04,0x64,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc, ttmp15, v2
// W64: encoding: [0x7b,0x04,0x64,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc, m0, v2
// W64: encoding: [0x7d,0x04,0x64,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc, exec_lo, v2
// W64: encoding: [0x7e,0x04,0x64,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc, exec_hi, v2
// W64: encoding: [0x7f,0x04,0x64,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc, null, v2
// W64: encoding: [0x7c,0x04,0x64,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc, -1, v2
// W64: encoding: [0xc1,0x04,0x64,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc, 0.5, v2
// W64: encoding: [0xf0,0x04,0x64,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc, src_scc, v2
// W64: encoding: [0xfd,0x04,0x64,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i16 vcc, 0xfe0b, v127
// W64: encoding: [0xff,0xfe,0x64,0x7c,0x0b,0xfe,0x00,0x00]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc_lo, v1, v2
// W32: encoding: [0x01,0x05,0x84,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc_lo, v255, v2
// W32: encoding: [0xff,0x05,0x84,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc_lo, s1, v2
// W32: encoding: [0x01,0x04,0x84,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc_lo, s105, v2
// W32: encoding: [0x69,0x04,0x84,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc_lo, vcc_lo, v2
// W32: encoding: [0x6a,0x04,0x84,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc_lo, vcc_hi, v2
// W32: encoding: [0x6b,0x04,0x84,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc_lo, ttmp15, v2
// W32: encoding: [0x7b,0x04,0x84,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc_lo, m0, v2
// W32: encoding: [0x7d,0x04,0x84,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc_lo, exec_lo, v2
// W32: encoding: [0x7e,0x04,0x84,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc_lo, exec_hi, v2
// W32: encoding: [0x7f,0x04,0x84,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc_lo, null, v2
// W32: encoding: [0x7c,0x04,0x84,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc_lo, -1, v2
// W32: encoding: [0xc1,0x04,0x84,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc_lo, 0.5, v2
// W32: encoding: [0xf0,0x04,0x84,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc_lo, src_scc, v2
// W32: encoding: [0xfd,0x04,0x84,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc_lo, 0xaf123456, v255
// W32: encoding: [0xff,0xfe,0x85,0x7c,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc, v1, v2
// W64: encoding: [0x01,0x05,0x84,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc, v255, v2
// W64: encoding: [0xff,0x05,0x84,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc, s1, v2
// W64: encoding: [0x01,0x04,0x84,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc, s105, v2
// W64: encoding: [0x69,0x04,0x84,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc, vcc_lo, v2
// W64: encoding: [0x6a,0x04,0x84,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc, vcc_hi, v2
// W64: encoding: [0x6b,0x04,0x84,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc, ttmp15, v2
// W64: encoding: [0x7b,0x04,0x84,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc, m0, v2
// W64: encoding: [0x7d,0x04,0x84,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc, exec_lo, v2
// W64: encoding: [0x7e,0x04,0x84,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc, exec_hi, v2
// W64: encoding: [0x7f,0x04,0x84,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc, null, v2
// W64: encoding: [0x7c,0x04,0x84,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc, -1, v2
// W64: encoding: [0xc1,0x04,0x84,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc, 0.5, v2
// W64: encoding: [0xf0,0x04,0x84,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc, src_scc, v2
// W64: encoding: [0xfd,0x04,0x84,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i32 vcc, 0xaf123456, v255
// W64: encoding: [0xff,0xfe,0x85,0x7c,0x56,0x34,0x12,0xaf]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i64 vcc_lo, v[1:2], v[2:3]
// W32: encoding: [0x01,0x05,0xa4,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i64 vcc_lo, v[254:255], v[2:3]
// W32: encoding: [0xfe,0x05,0xa4,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i64 vcc_lo, s[2:3], v[2:3]
// W32: encoding: [0x02,0x04,0xa4,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i64 vcc_lo, s[104:105], v[2:3]
// W32: encoding: [0x68,0x04,0xa4,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i64 vcc_lo, vcc, v[2:3]
// W32: encoding: [0x6a,0x04,0xa4,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i64 vcc_lo, ttmp[14:15], v[2:3]
// W32: encoding: [0x7a,0x04,0xa4,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i64 vcc_lo, exec, v[2:3]
// W32: encoding: [0x7e,0x04,0xa4,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i64 vcc_lo, null, v[2:3]
// W32: encoding: [0x7c,0x04,0xa4,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i64 vcc_lo, -1, v[2:3]
// W32: encoding: [0xc1,0x04,0xa4,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i64 vcc_lo, 0.5, v[2:3]
// W32: encoding: [0xf0,0x04,0xa4,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i64 vcc_lo, src_scc, v[2:3]
// W32: encoding: [0xfd,0x04,0xa4,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i64 vcc_lo, 0xaf123456, v[254:255]
// W32: encoding: [0xff,0xfc,0xa5,0x7c,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i64 vcc, v[1:2], v[2:3]
// W64: encoding: [0x01,0x05,0xa4,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i64 vcc, v[254:255], v[2:3]
// W64: encoding: [0xfe,0x05,0xa4,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i64 vcc, s[2:3], v[2:3]
// W64: encoding: [0x02,0x04,0xa4,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i64 vcc, s[104:105], v[2:3]
// W64: encoding: [0x68,0x04,0xa4,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i64 vcc, vcc, v[2:3]
// W64: encoding: [0x6a,0x04,0xa4,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i64 vcc, ttmp[14:15], v[2:3]
// W64: encoding: [0x7a,0x04,0xa4,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i64 vcc, exec, v[2:3]
// W64: encoding: [0x7e,0x04,0xa4,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i64 vcc, null, v[2:3]
// W64: encoding: [0x7c,0x04,0xa4,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i64 vcc, -1, v[2:3]
// W64: encoding: [0xc1,0x04,0xa4,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i64 vcc, 0.5, v[2:3]
// W64: encoding: [0xf0,0x04,0xa4,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i64 vcc, src_scc, v[2:3]
// W64: encoding: [0xfd,0x04,0xa4,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_i64 vcc, 0xaf123456, v[254:255]
// W64: encoding: [0xff,0xfc,0xa5,0x7c,0x56,0x34,0x12,0xaf]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc_lo, v1, v2
// W32: encoding: [0x01,0x05,0x74,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc_lo, v127, v2
// W32: encoding: [0x7f,0x05,0x74,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc_lo, s1, v2
// W32: encoding: [0x01,0x04,0x74,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc_lo, s105, v2
// W32: encoding: [0x69,0x04,0x74,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc_lo, vcc_lo, v2
// W32: encoding: [0x6a,0x04,0x74,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc_lo, vcc_hi, v2
// W32: encoding: [0x6b,0x04,0x74,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc_lo, ttmp15, v2
// W32: encoding: [0x7b,0x04,0x74,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc_lo, m0, v2
// W32: encoding: [0x7d,0x04,0x74,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc_lo, exec_lo, v2
// W32: encoding: [0x7e,0x04,0x74,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc_lo, exec_hi, v2
// W32: encoding: [0x7f,0x04,0x74,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc_lo, null, v2
// W32: encoding: [0x7c,0x04,0x74,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc_lo, -1, v2
// W32: encoding: [0xc1,0x04,0x74,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc_lo, 0.5, v2
// W32: encoding: [0xf0,0x04,0x74,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc_lo, src_scc, v2
// W32: encoding: [0xfd,0x04,0x74,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc_lo, 0xfe0b, v127
// W32: encoding: [0xff,0xfe,0x74,0x7c,0x0b,0xfe,0x00,0x00]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc, v1, v2
// W64: encoding: [0x01,0x05,0x74,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc, v127, v2
// W64: encoding: [0x7f,0x05,0x74,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc, s1, v2
// W64: encoding: [0x01,0x04,0x74,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc, s105, v2
// W64: encoding: [0x69,0x04,0x74,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc, vcc_lo, v2
// W64: encoding: [0x6a,0x04,0x74,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc, vcc_hi, v2
// W64: encoding: [0x6b,0x04,0x74,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc, ttmp15, v2
// W64: encoding: [0x7b,0x04,0x74,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc, m0, v2
// W64: encoding: [0x7d,0x04,0x74,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc, exec_lo, v2
// W64: encoding: [0x7e,0x04,0x74,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc, exec_hi, v2
// W64: encoding: [0x7f,0x04,0x74,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc, null, v2
// W64: encoding: [0x7c,0x04,0x74,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc, -1, v2
// W64: encoding: [0xc1,0x04,0x74,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc, 0.5, v2
// W64: encoding: [0xf0,0x04,0x74,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc, src_scc, v2
// W64: encoding: [0xfd,0x04,0x74,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u16 vcc, 0xfe0b, v127
// W64: encoding: [0xff,0xfe,0x74,0x7c,0x0b,0xfe,0x00,0x00]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc_lo, v1, v2
// W32: encoding: [0x01,0x05,0x94,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc_lo, v255, v2
// W32: encoding: [0xff,0x05,0x94,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc_lo, s1, v2
// W32: encoding: [0x01,0x04,0x94,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc_lo, s105, v2
// W32: encoding: [0x69,0x04,0x94,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc_lo, vcc_lo, v2
// W32: encoding: [0x6a,0x04,0x94,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc_lo, vcc_hi, v2
// W32: encoding: [0x6b,0x04,0x94,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc_lo, ttmp15, v2
// W32: encoding: [0x7b,0x04,0x94,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc_lo, m0, v2
// W32: encoding: [0x7d,0x04,0x94,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc_lo, exec_lo, v2
// W32: encoding: [0x7e,0x04,0x94,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc_lo, exec_hi, v2
// W32: encoding: [0x7f,0x04,0x94,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc_lo, null, v2
// W32: encoding: [0x7c,0x04,0x94,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc_lo, -1, v2
// W32: encoding: [0xc1,0x04,0x94,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc_lo, 0.5, v2
// W32: encoding: [0xf0,0x04,0x94,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc_lo, src_scc, v2
// W32: encoding: [0xfd,0x04,0x94,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc_lo, 0xaf123456, v255
// W32: encoding: [0xff,0xfe,0x95,0x7c,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc, v1, v2
// W64: encoding: [0x01,0x05,0x94,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc, v255, v2
// W64: encoding: [0xff,0x05,0x94,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc, s1, v2
// W64: encoding: [0x01,0x04,0x94,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc, s105, v2
// W64: encoding: [0x69,0x04,0x94,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc, vcc_lo, v2
// W64: encoding: [0x6a,0x04,0x94,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc, vcc_hi, v2
// W64: encoding: [0x6b,0x04,0x94,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc, ttmp15, v2
// W64: encoding: [0x7b,0x04,0x94,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc, m0, v2
// W64: encoding: [0x7d,0x04,0x94,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc, exec_lo, v2
// W64: encoding: [0x7e,0x04,0x94,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc, exec_hi, v2
// W64: encoding: [0x7f,0x04,0x94,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc, null, v2
// W64: encoding: [0x7c,0x04,0x94,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc, -1, v2
// W64: encoding: [0xc1,0x04,0x94,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc, 0.5, v2
// W64: encoding: [0xf0,0x04,0x94,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc, src_scc, v2
// W64: encoding: [0xfd,0x04,0x94,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u32 vcc, 0xaf123456, v255
// W64: encoding: [0xff,0xfe,0x95,0x7c,0x56,0x34,0x12,0xaf]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u64 vcc_lo, v[1:2], v[2:3]
// W32: encoding: [0x01,0x05,0xb4,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u64 vcc_lo, v[254:255], v[2:3]
// W32: encoding: [0xfe,0x05,0xb4,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u64 vcc_lo, s[2:3], v[2:3]
// W32: encoding: [0x02,0x04,0xb4,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u64 vcc_lo, s[104:105], v[2:3]
// W32: encoding: [0x68,0x04,0xb4,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u64 vcc_lo, vcc, v[2:3]
// W32: encoding: [0x6a,0x04,0xb4,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u64 vcc_lo, ttmp[14:15], v[2:3]
// W32: encoding: [0x7a,0x04,0xb4,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u64 vcc_lo, exec, v[2:3]
// W32: encoding: [0x7e,0x04,0xb4,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u64 vcc_lo, null, v[2:3]
// W32: encoding: [0x7c,0x04,0xb4,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u64 vcc_lo, -1, v[2:3]
// W32: encoding: [0xc1,0x04,0xb4,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u64 vcc_lo, 0.5, v[2:3]
// W32: encoding: [0xf0,0x04,0xb4,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u64 vcc_lo, src_scc, v[2:3]
// W32: encoding: [0xfd,0x04,0xb4,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u64 vcc_lo, 0xaf123456, v[254:255]
// W32: encoding: [0xff,0xfc,0xb5,0x7c,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u64 vcc, v[1:2], v[2:3]
// W64: encoding: [0x01,0x05,0xb4,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u64 vcc, v[254:255], v[2:3]
// W64: encoding: [0xfe,0x05,0xb4,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u64 vcc, s[2:3], v[2:3]
// W64: encoding: [0x02,0x04,0xb4,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u64 vcc, s[104:105], v[2:3]
// W64: encoding: [0x68,0x04,0xb4,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u64 vcc, vcc, v[2:3]
// W64: encoding: [0x6a,0x04,0xb4,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u64 vcc, ttmp[14:15], v[2:3]
// W64: encoding: [0x7a,0x04,0xb4,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u64 vcc, exec, v[2:3]
// W64: encoding: [0x7e,0x04,0xb4,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u64 vcc, null, v[2:3]
// W64: encoding: [0x7c,0x04,0xb4,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u64 vcc, -1, v[2:3]
// W64: encoding: [0xc1,0x04,0xb4,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u64 vcc, 0.5, v[2:3]
// W64: encoding: [0xf0,0x04,0xb4,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u64 vcc, src_scc, v[2:3]
// W64: encoding: [0xfd,0x04,0xb4,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_eq_u64 vcc, 0xaf123456, v[254:255]
// W64: encoding: [0xff,0xfc,0xb5,0x7c,0x56,0x34,0x12,0xaf]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc_lo, v1, v2
// W32: encoding: [0x01,0x05,0x0c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc_lo, v127, v2
// W32: encoding: [0x7f,0x05,0x0c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc_lo, s1, v2
// W32: encoding: [0x01,0x04,0x0c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc_lo, s105, v2
// W32: encoding: [0x69,0x04,0x0c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc_lo, vcc_lo, v2
// W32: encoding: [0x6a,0x04,0x0c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc_lo, vcc_hi, v2
// W32: encoding: [0x6b,0x04,0x0c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc_lo, ttmp15, v2
// W32: encoding: [0x7b,0x04,0x0c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc_lo, m0, v2
// W32: encoding: [0x7d,0x04,0x0c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc_lo, exec_lo, v2
// W32: encoding: [0x7e,0x04,0x0c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc_lo, exec_hi, v2
// W32: encoding: [0x7f,0x04,0x0c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc_lo, null, v2
// W32: encoding: [0x7c,0x04,0x0c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc_lo, -1, v2
// W32: encoding: [0xc1,0x04,0x0c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc_lo, 0.5, v2
// W32: encoding: [0xf0,0x04,0x0c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc_lo, src_scc, v2
// W32: encoding: [0xfd,0x04,0x0c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc_lo, 0xfe0b, v127
// W32: encoding: [0xff,0xfe,0x0c,0x7c,0x0b,0xfe,0x00,0x00]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc, v1, v2
// W64: encoding: [0x01,0x05,0x0c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc, v127, v2
// W64: encoding: [0x7f,0x05,0x0c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc, s1, v2
// W64: encoding: [0x01,0x04,0x0c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc, s105, v2
// W64: encoding: [0x69,0x04,0x0c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc, vcc_lo, v2
// W64: encoding: [0x6a,0x04,0x0c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc, vcc_hi, v2
// W64: encoding: [0x6b,0x04,0x0c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc, ttmp15, v2
// W64: encoding: [0x7b,0x04,0x0c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc, m0, v2
// W64: encoding: [0x7d,0x04,0x0c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc, exec_lo, v2
// W64: encoding: [0x7e,0x04,0x0c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc, exec_hi, v2
// W64: encoding: [0x7f,0x04,0x0c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc, null, v2
// W64: encoding: [0x7c,0x04,0x0c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc, -1, v2
// W64: encoding: [0xc1,0x04,0x0c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc, 0.5, v2
// W64: encoding: [0xf0,0x04,0x0c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc, src_scc, v2
// W64: encoding: [0xfd,0x04,0x0c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f16 vcc, 0xfe0b, v127
// W64: encoding: [0xff,0xfe,0x0c,0x7c,0x0b,0xfe,0x00,0x00]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc_lo, v1, v2
// W32: encoding: [0x01,0x05,0x2c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc_lo, v255, v2
// W32: encoding: [0xff,0x05,0x2c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc_lo, s1, v2
// W32: encoding: [0x01,0x04,0x2c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc_lo, s105, v2
// W32: encoding: [0x69,0x04,0x2c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc_lo, vcc_lo, v2
// W32: encoding: [0x6a,0x04,0x2c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc_lo, vcc_hi, v2
// W32: encoding: [0x6b,0x04,0x2c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc_lo, ttmp15, v2
// W32: encoding: [0x7b,0x04,0x2c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc_lo, m0, v2
// W32: encoding: [0x7d,0x04,0x2c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc_lo, exec_lo, v2
// W32: encoding: [0x7e,0x04,0x2c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc_lo, exec_hi, v2
// W32: encoding: [0x7f,0x04,0x2c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc_lo, null, v2
// W32: encoding: [0x7c,0x04,0x2c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc_lo, -1, v2
// W32: encoding: [0xc1,0x04,0x2c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc_lo, 0.5, v2
// W32: encoding: [0xf0,0x04,0x2c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc_lo, src_scc, v2
// W32: encoding: [0xfd,0x04,0x2c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc_lo, 0xaf123456, v255
// W32: encoding: [0xff,0xfe,0x2d,0x7c,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc, v1, v2
// W64: encoding: [0x01,0x05,0x2c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc, v255, v2
// W64: encoding: [0xff,0x05,0x2c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc, s1, v2
// W64: encoding: [0x01,0x04,0x2c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc, s105, v2
// W64: encoding: [0x69,0x04,0x2c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc, vcc_lo, v2
// W64: encoding: [0x6a,0x04,0x2c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc, vcc_hi, v2
// W64: encoding: [0x6b,0x04,0x2c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc, ttmp15, v2
// W64: encoding: [0x7b,0x04,0x2c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc, m0, v2
// W64: encoding: [0x7d,0x04,0x2c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc, exec_lo, v2
// W64: encoding: [0x7e,0x04,0x2c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc, exec_hi, v2
// W64: encoding: [0x7f,0x04,0x2c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc, null, v2
// W64: encoding: [0x7c,0x04,0x2c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc, -1, v2
// W64: encoding: [0xc1,0x04,0x2c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc, 0.5, v2
// W64: encoding: [0xf0,0x04,0x2c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc, src_scc, v2
// W64: encoding: [0xfd,0x04,0x2c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f32 vcc, 0xaf123456, v255
// W64: encoding: [0xff,0xfe,0x2d,0x7c,0x56,0x34,0x12,0xaf]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f64 vcc_lo, v[1:2], v[2:3]
// W32: encoding: [0x01,0x05,0x4c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f64 vcc_lo, v[254:255], v[2:3]
// W32: encoding: [0xfe,0x05,0x4c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f64 vcc_lo, s[2:3], v[2:3]
// W32: encoding: [0x02,0x04,0x4c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f64 vcc_lo, s[104:105], v[2:3]
// W32: encoding: [0x68,0x04,0x4c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f64 vcc_lo, vcc, v[2:3]
// W32: encoding: [0x6a,0x04,0x4c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f64 vcc_lo, ttmp[14:15], v[2:3]
// W32: encoding: [0x7a,0x04,0x4c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f64 vcc_lo, exec, v[2:3]
// W32: encoding: [0x7e,0x04,0x4c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f64 vcc_lo, null, v[2:3]
// W32: encoding: [0x7c,0x04,0x4c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f64 vcc_lo, -1, v[2:3]
// W32: encoding: [0xc1,0x04,0x4c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f64 vcc_lo, 0.5, v[2:3]
// W32: encoding: [0xf0,0x04,0x4c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f64 vcc_lo, src_scc, v[2:3]
// W32: encoding: [0xfd,0x04,0x4c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f64 vcc_lo, 0xaf123456, v[254:255]
// W32: encoding: [0xff,0xfc,0x4d,0x7c,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f64 vcc, v[1:2], v[2:3]
// W64: encoding: [0x01,0x05,0x4c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f64 vcc, v[254:255], v[2:3]
// W64: encoding: [0xfe,0x05,0x4c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f64 vcc, s[2:3], v[2:3]
// W64: encoding: [0x02,0x04,0x4c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f64 vcc, s[104:105], v[2:3]
// W64: encoding: [0x68,0x04,0x4c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f64 vcc, vcc, v[2:3]
// W64: encoding: [0x6a,0x04,0x4c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f64 vcc, ttmp[14:15], v[2:3]
// W64: encoding: [0x7a,0x04,0x4c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f64 vcc, exec, v[2:3]
// W64: encoding: [0x7e,0x04,0x4c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f64 vcc, null, v[2:3]
// W64: encoding: [0x7c,0x04,0x4c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f64 vcc, -1, v[2:3]
// W64: encoding: [0xc1,0x04,0x4c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f64 vcc, 0.5, v[2:3]
// W64: encoding: [0xf0,0x04,0x4c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f64 vcc, src_scc, v[2:3]
// W64: encoding: [0xfd,0x04,0x4c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_f64 vcc, 0xaf123456, v[254:255]
// W64: encoding: [0xff,0xfc,0x4d,0x7c,0x56,0x34,0x12,0xaf]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc_lo, v1, v2
// W32: encoding: [0x01,0x05,0x6c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc_lo, v127, v2
// W32: encoding: [0x7f,0x05,0x6c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc_lo, s1, v2
// W32: encoding: [0x01,0x04,0x6c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc_lo, s105, v2
// W32: encoding: [0x69,0x04,0x6c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc_lo, vcc_lo, v2
// W32: encoding: [0x6a,0x04,0x6c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc_lo, vcc_hi, v2
// W32: encoding: [0x6b,0x04,0x6c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc_lo, ttmp15, v2
// W32: encoding: [0x7b,0x04,0x6c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc_lo, m0, v2
// W32: encoding: [0x7d,0x04,0x6c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc_lo, exec_lo, v2
// W32: encoding: [0x7e,0x04,0x6c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc_lo, exec_hi, v2
// W32: encoding: [0x7f,0x04,0x6c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc_lo, null, v2
// W32: encoding: [0x7c,0x04,0x6c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc_lo, -1, v2
// W32: encoding: [0xc1,0x04,0x6c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc_lo, 0.5, v2
// W32: encoding: [0xf0,0x04,0x6c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc_lo, src_scc, v2
// W32: encoding: [0xfd,0x04,0x6c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc_lo, 0xfe0b, v127
// W32: encoding: [0xff,0xfe,0x6c,0x7c,0x0b,0xfe,0x00,0x00]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc, v1, v2
// W64: encoding: [0x01,0x05,0x6c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc, v127, v2
// W64: encoding: [0x7f,0x05,0x6c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc, s1, v2
// W64: encoding: [0x01,0x04,0x6c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc, s105, v2
// W64: encoding: [0x69,0x04,0x6c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc, vcc_lo, v2
// W64: encoding: [0x6a,0x04,0x6c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc, vcc_hi, v2
// W64: encoding: [0x6b,0x04,0x6c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc, ttmp15, v2
// W64: encoding: [0x7b,0x04,0x6c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc, m0, v2
// W64: encoding: [0x7d,0x04,0x6c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc, exec_lo, v2
// W64: encoding: [0x7e,0x04,0x6c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc, exec_hi, v2
// W64: encoding: [0x7f,0x04,0x6c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc, null, v2
// W64: encoding: [0x7c,0x04,0x6c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc, -1, v2
// W64: encoding: [0xc1,0x04,0x6c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc, 0.5, v2
// W64: encoding: [0xf0,0x04,0x6c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc, src_scc, v2
// W64: encoding: [0xfd,0x04,0x6c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i16 vcc, 0xfe0b, v127
// W64: encoding: [0xff,0xfe,0x6c,0x7c,0x0b,0xfe,0x00,0x00]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc_lo, v1, v2
// W32: encoding: [0x01,0x05,0x8c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc_lo, v255, v2
// W32: encoding: [0xff,0x05,0x8c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc_lo, s1, v2
// W32: encoding: [0x01,0x04,0x8c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc_lo, s105, v2
// W32: encoding: [0x69,0x04,0x8c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc_lo, vcc_lo, v2
// W32: encoding: [0x6a,0x04,0x8c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc_lo, vcc_hi, v2
// W32: encoding: [0x6b,0x04,0x8c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc_lo, ttmp15, v2
// W32: encoding: [0x7b,0x04,0x8c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc_lo, m0, v2
// W32: encoding: [0x7d,0x04,0x8c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc_lo, exec_lo, v2
// W32: encoding: [0x7e,0x04,0x8c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc_lo, exec_hi, v2
// W32: encoding: [0x7f,0x04,0x8c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc_lo, null, v2
// W32: encoding: [0x7c,0x04,0x8c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc_lo, -1, v2
// W32: encoding: [0xc1,0x04,0x8c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc_lo, 0.5, v2
// W32: encoding: [0xf0,0x04,0x8c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc_lo, src_scc, v2
// W32: encoding: [0xfd,0x04,0x8c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc_lo, 0xaf123456, v255
// W32: encoding: [0xff,0xfe,0x8d,0x7c,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc, v1, v2
// W64: encoding: [0x01,0x05,0x8c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc, v255, v2
// W64: encoding: [0xff,0x05,0x8c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc, s1, v2
// W64: encoding: [0x01,0x04,0x8c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc, s105, v2
// W64: encoding: [0x69,0x04,0x8c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc, vcc_lo, v2
// W64: encoding: [0x6a,0x04,0x8c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc, vcc_hi, v2
// W64: encoding: [0x6b,0x04,0x8c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc, ttmp15, v2
// W64: encoding: [0x7b,0x04,0x8c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc, m0, v2
// W64: encoding: [0x7d,0x04,0x8c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc, exec_lo, v2
// W64: encoding: [0x7e,0x04,0x8c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc, exec_hi, v2
// W64: encoding: [0x7f,0x04,0x8c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc, null, v2
// W64: encoding: [0x7c,0x04,0x8c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc, -1, v2
// W64: encoding: [0xc1,0x04,0x8c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc, 0.5, v2
// W64: encoding: [0xf0,0x04,0x8c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc, src_scc, v2
// W64: encoding: [0xfd,0x04,0x8c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i32 vcc, 0xaf123456, v255
// W64: encoding: [0xff,0xfe,0x8d,0x7c,0x56,0x34,0x12,0xaf]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i64 vcc_lo, v[1:2], v[2:3]
// W32: encoding: [0x01,0x05,0xac,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i64 vcc_lo, v[254:255], v[2:3]
// W32: encoding: [0xfe,0x05,0xac,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i64 vcc_lo, s[2:3], v[2:3]
// W32: encoding: [0x02,0x04,0xac,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i64 vcc_lo, s[104:105], v[2:3]
// W32: encoding: [0x68,0x04,0xac,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i64 vcc_lo, vcc, v[2:3]
// W32: encoding: [0x6a,0x04,0xac,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i64 vcc_lo, ttmp[14:15], v[2:3]
// W32: encoding: [0x7a,0x04,0xac,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i64 vcc_lo, exec, v[2:3]
// W32: encoding: [0x7e,0x04,0xac,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i64 vcc_lo, null, v[2:3]
// W32: encoding: [0x7c,0x04,0xac,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i64 vcc_lo, -1, v[2:3]
// W32: encoding: [0xc1,0x04,0xac,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i64 vcc_lo, 0.5, v[2:3]
// W32: encoding: [0xf0,0x04,0xac,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i64 vcc_lo, src_scc, v[2:3]
// W32: encoding: [0xfd,0x04,0xac,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i64 vcc_lo, 0xaf123456, v[254:255]
// W32: encoding: [0xff,0xfc,0xad,0x7c,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i64 vcc, v[1:2], v[2:3]
// W64: encoding: [0x01,0x05,0xac,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i64 vcc, v[254:255], v[2:3]
// W64: encoding: [0xfe,0x05,0xac,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i64 vcc, s[2:3], v[2:3]
// W64: encoding: [0x02,0x04,0xac,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i64 vcc, s[104:105], v[2:3]
// W64: encoding: [0x68,0x04,0xac,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i64 vcc, vcc, v[2:3]
// W64: encoding: [0x6a,0x04,0xac,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i64 vcc, ttmp[14:15], v[2:3]
// W64: encoding: [0x7a,0x04,0xac,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i64 vcc, exec, v[2:3]
// W64: encoding: [0x7e,0x04,0xac,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i64 vcc, null, v[2:3]
// W64: encoding: [0x7c,0x04,0xac,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i64 vcc, -1, v[2:3]
// W64: encoding: [0xc1,0x04,0xac,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i64 vcc, 0.5, v[2:3]
// W64: encoding: [0xf0,0x04,0xac,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i64 vcc, src_scc, v[2:3]
// W64: encoding: [0xfd,0x04,0xac,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_i64 vcc, 0xaf123456, v[254:255]
// W64: encoding: [0xff,0xfc,0xad,0x7c,0x56,0x34,0x12,0xaf]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc_lo, v1, v2
// W32: encoding: [0x01,0x05,0x7c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc_lo, v127, v2
// W32: encoding: [0x7f,0x05,0x7c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc_lo, s1, v2
// W32: encoding: [0x01,0x04,0x7c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc_lo, s105, v2
// W32: encoding: [0x69,0x04,0x7c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc_lo, vcc_lo, v2
// W32: encoding: [0x6a,0x04,0x7c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc_lo, vcc_hi, v2
// W32: encoding: [0x6b,0x04,0x7c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc_lo, ttmp15, v2
// W32: encoding: [0x7b,0x04,0x7c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc_lo, m0, v2
// W32: encoding: [0x7d,0x04,0x7c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc_lo, exec_lo, v2
// W32: encoding: [0x7e,0x04,0x7c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc_lo, exec_hi, v2
// W32: encoding: [0x7f,0x04,0x7c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc_lo, null, v2
// W32: encoding: [0x7c,0x04,0x7c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc_lo, -1, v2
// W32: encoding: [0xc1,0x04,0x7c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc_lo, 0.5, v2
// W32: encoding: [0xf0,0x04,0x7c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc_lo, src_scc, v2
// W32: encoding: [0xfd,0x04,0x7c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc_lo, 0xfe0b, v127
// W32: encoding: [0xff,0xfe,0x7c,0x7c,0x0b,0xfe,0x00,0x00]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc, v1, v2
// W64: encoding: [0x01,0x05,0x7c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc, v127, v2
// W64: encoding: [0x7f,0x05,0x7c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc, s1, v2
// W64: encoding: [0x01,0x04,0x7c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc, s105, v2
// W64: encoding: [0x69,0x04,0x7c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc, vcc_lo, v2
// W64: encoding: [0x6a,0x04,0x7c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc, vcc_hi, v2
// W64: encoding: [0x6b,0x04,0x7c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc, ttmp15, v2
// W64: encoding: [0x7b,0x04,0x7c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc, m0, v2
// W64: encoding: [0x7d,0x04,0x7c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc, exec_lo, v2
// W64: encoding: [0x7e,0x04,0x7c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc, exec_hi, v2
// W64: encoding: [0x7f,0x04,0x7c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc, null, v2
// W64: encoding: [0x7c,0x04,0x7c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc, -1, v2
// W64: encoding: [0xc1,0x04,0x7c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc, 0.5, v2
// W64: encoding: [0xf0,0x04,0x7c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc, src_scc, v2
// W64: encoding: [0xfd,0x04,0x7c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u16 vcc, 0xfe0b, v127
// W64: encoding: [0xff,0xfe,0x7c,0x7c,0x0b,0xfe,0x00,0x00]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc_lo, v1, v2
// W32: encoding: [0x01,0x05,0x9c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc_lo, v255, v2
// W32: encoding: [0xff,0x05,0x9c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc_lo, s1, v2
// W32: encoding: [0x01,0x04,0x9c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc_lo, s105, v2
// W32: encoding: [0x69,0x04,0x9c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc_lo, vcc_lo, v2
// W32: encoding: [0x6a,0x04,0x9c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc_lo, vcc_hi, v2
// W32: encoding: [0x6b,0x04,0x9c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc_lo, ttmp15, v2
// W32: encoding: [0x7b,0x04,0x9c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc_lo, m0, v2
// W32: encoding: [0x7d,0x04,0x9c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc_lo, exec_lo, v2
// W32: encoding: [0x7e,0x04,0x9c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc_lo, exec_hi, v2
// W32: encoding: [0x7f,0x04,0x9c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc_lo, null, v2
// W32: encoding: [0x7c,0x04,0x9c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc_lo, -1, v2
// W32: encoding: [0xc1,0x04,0x9c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc_lo, 0.5, v2
// W32: encoding: [0xf0,0x04,0x9c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc_lo, src_scc, v2
// W32: encoding: [0xfd,0x04,0x9c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc_lo, 0xaf123456, v255
// W32: encoding: [0xff,0xfe,0x9d,0x7c,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc, v1, v2
// W64: encoding: [0x01,0x05,0x9c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc, v255, v2
// W64: encoding: [0xff,0x05,0x9c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc, s1, v2
// W64: encoding: [0x01,0x04,0x9c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc, s105, v2
// W64: encoding: [0x69,0x04,0x9c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc, vcc_lo, v2
// W64: encoding: [0x6a,0x04,0x9c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc, vcc_hi, v2
// W64: encoding: [0x6b,0x04,0x9c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc, ttmp15, v2
// W64: encoding: [0x7b,0x04,0x9c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc, m0, v2
// W64: encoding: [0x7d,0x04,0x9c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc, exec_lo, v2
// W64: encoding: [0x7e,0x04,0x9c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc, exec_hi, v2
// W64: encoding: [0x7f,0x04,0x9c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc, null, v2
// W64: encoding: [0x7c,0x04,0x9c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc, -1, v2
// W64: encoding: [0xc1,0x04,0x9c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc, 0.5, v2
// W64: encoding: [0xf0,0x04,0x9c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc, src_scc, v2
// W64: encoding: [0xfd,0x04,0x9c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u32 vcc, 0xaf123456, v255
// W64: encoding: [0xff,0xfe,0x9d,0x7c,0x56,0x34,0x12,0xaf]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u64 vcc_lo, v[1:2], v[2:3]
// W32: encoding: [0x01,0x05,0xbc,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u64 vcc_lo, v[254:255], v[2:3]
// W32: encoding: [0xfe,0x05,0xbc,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u64 vcc_lo, s[2:3], v[2:3]
// W32: encoding: [0x02,0x04,0xbc,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u64 vcc_lo, s[104:105], v[2:3]
// W32: encoding: [0x68,0x04,0xbc,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u64 vcc_lo, vcc, v[2:3]
// W32: encoding: [0x6a,0x04,0xbc,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u64 vcc_lo, ttmp[14:15], v[2:3]
// W32: encoding: [0x7a,0x04,0xbc,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u64 vcc_lo, exec, v[2:3]
// W32: encoding: [0x7e,0x04,0xbc,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u64 vcc_lo, null, v[2:3]
// W32: encoding: [0x7c,0x04,0xbc,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u64 vcc_lo, -1, v[2:3]
// W32: encoding: [0xc1,0x04,0xbc,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u64 vcc_lo, 0.5, v[2:3]
// W32: encoding: [0xf0,0x04,0xbc,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u64 vcc_lo, src_scc, v[2:3]
// W32: encoding: [0xfd,0x04,0xbc,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u64 vcc_lo, 0xaf123456, v[254:255]
// W32: encoding: [0xff,0xfc,0xbd,0x7c,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u64 vcc, v[1:2], v[2:3]
// W64: encoding: [0x01,0x05,0xbc,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u64 vcc, v[254:255], v[2:3]
// W64: encoding: [0xfe,0x05,0xbc,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u64 vcc, s[2:3], v[2:3]
// W64: encoding: [0x02,0x04,0xbc,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u64 vcc, s[104:105], v[2:3]
// W64: encoding: [0x68,0x04,0xbc,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u64 vcc, vcc, v[2:3]
// W64: encoding: [0x6a,0x04,0xbc,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u64 vcc, ttmp[14:15], v[2:3]
// W64: encoding: [0x7a,0x04,0xbc,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u64 vcc, exec, v[2:3]
// W64: encoding: [0x7e,0x04,0xbc,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u64 vcc, null, v[2:3]
// W64: encoding: [0x7c,0x04,0xbc,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u64 vcc, -1, v[2:3]
// W64: encoding: [0xc1,0x04,0xbc,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u64 vcc, 0.5, v[2:3]
// W64: encoding: [0xf0,0x04,0xbc,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u64 vcc, src_scc, v[2:3]
// W64: encoding: [0xfd,0x04,0xbc,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ge_u64 vcc, 0xaf123456, v[254:255]
// W64: encoding: [0xff,0xfc,0xbd,0x7c,0x56,0x34,0x12,0xaf]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc_lo, v1, v2
// W32: encoding: [0x01,0x05,0x08,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc_lo, v127, v2
// W32: encoding: [0x7f,0x05,0x08,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc_lo, s1, v2
// W32: encoding: [0x01,0x04,0x08,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc_lo, s105, v2
// W32: encoding: [0x69,0x04,0x08,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc_lo, vcc_lo, v2
// W32: encoding: [0x6a,0x04,0x08,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc_lo, vcc_hi, v2
// W32: encoding: [0x6b,0x04,0x08,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc_lo, ttmp15, v2
// W32: encoding: [0x7b,0x04,0x08,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc_lo, m0, v2
// W32: encoding: [0x7d,0x04,0x08,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc_lo, exec_lo, v2
// W32: encoding: [0x7e,0x04,0x08,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc_lo, exec_hi, v2
// W32: encoding: [0x7f,0x04,0x08,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc_lo, null, v2
// W32: encoding: [0x7c,0x04,0x08,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc_lo, -1, v2
// W32: encoding: [0xc1,0x04,0x08,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc_lo, 0.5, v2
// W32: encoding: [0xf0,0x04,0x08,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc_lo, src_scc, v2
// W32: encoding: [0xfd,0x04,0x08,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc_lo, 0xfe0b, v127
// W32: encoding: [0xff,0xfe,0x08,0x7c,0x0b,0xfe,0x00,0x00]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc, v1, v2
// W64: encoding: [0x01,0x05,0x08,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc, v127, v2
// W64: encoding: [0x7f,0x05,0x08,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc, s1, v2
// W64: encoding: [0x01,0x04,0x08,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc, s105, v2
// W64: encoding: [0x69,0x04,0x08,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc, vcc_lo, v2
// W64: encoding: [0x6a,0x04,0x08,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc, vcc_hi, v2
// W64: encoding: [0x6b,0x04,0x08,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc, ttmp15, v2
// W64: encoding: [0x7b,0x04,0x08,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc, m0, v2
// W64: encoding: [0x7d,0x04,0x08,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc, exec_lo, v2
// W64: encoding: [0x7e,0x04,0x08,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc, exec_hi, v2
// W64: encoding: [0x7f,0x04,0x08,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc, null, v2
// W64: encoding: [0x7c,0x04,0x08,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc, -1, v2
// W64: encoding: [0xc1,0x04,0x08,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc, 0.5, v2
// W64: encoding: [0xf0,0x04,0x08,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc, src_scc, v2
// W64: encoding: [0xfd,0x04,0x08,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f16 vcc, 0xfe0b, v127
// W64: encoding: [0xff,0xfe,0x08,0x7c,0x0b,0xfe,0x00,0x00]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc_lo, v1, v2
// W32: encoding: [0x01,0x05,0x28,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc_lo, v255, v2
// W32: encoding: [0xff,0x05,0x28,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc_lo, s1, v2
// W32: encoding: [0x01,0x04,0x28,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc_lo, s105, v2
// W32: encoding: [0x69,0x04,0x28,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc_lo, vcc_lo, v2
// W32: encoding: [0x6a,0x04,0x28,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc_lo, vcc_hi, v2
// W32: encoding: [0x6b,0x04,0x28,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc_lo, ttmp15, v2
// W32: encoding: [0x7b,0x04,0x28,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc_lo, m0, v2
// W32: encoding: [0x7d,0x04,0x28,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc_lo, exec_lo, v2
// W32: encoding: [0x7e,0x04,0x28,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc_lo, exec_hi, v2
// W32: encoding: [0x7f,0x04,0x28,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc_lo, null, v2
// W32: encoding: [0x7c,0x04,0x28,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc_lo, -1, v2
// W32: encoding: [0xc1,0x04,0x28,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc_lo, 0.5, v2
// W32: encoding: [0xf0,0x04,0x28,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc_lo, src_scc, v2
// W32: encoding: [0xfd,0x04,0x28,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc_lo, 0xaf123456, v255
// W32: encoding: [0xff,0xfe,0x29,0x7c,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc, v1, v2
// W64: encoding: [0x01,0x05,0x28,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc, v255, v2
// W64: encoding: [0xff,0x05,0x28,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc, s1, v2
// W64: encoding: [0x01,0x04,0x28,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc, s105, v2
// W64: encoding: [0x69,0x04,0x28,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc, vcc_lo, v2
// W64: encoding: [0x6a,0x04,0x28,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc, vcc_hi, v2
// W64: encoding: [0x6b,0x04,0x28,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc, ttmp15, v2
// W64: encoding: [0x7b,0x04,0x28,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc, m0, v2
// W64: encoding: [0x7d,0x04,0x28,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc, exec_lo, v2
// W64: encoding: [0x7e,0x04,0x28,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc, exec_hi, v2
// W64: encoding: [0x7f,0x04,0x28,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc, null, v2
// W64: encoding: [0x7c,0x04,0x28,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc, -1, v2
// W64: encoding: [0xc1,0x04,0x28,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc, 0.5, v2
// W64: encoding: [0xf0,0x04,0x28,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc, src_scc, v2
// W64: encoding: [0xfd,0x04,0x28,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f32 vcc, 0xaf123456, v255
// W64: encoding: [0xff,0xfe,0x29,0x7c,0x56,0x34,0x12,0xaf]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f64 vcc_lo, v[1:2], v[2:3]
// W32: encoding: [0x01,0x05,0x48,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f64 vcc_lo, v[254:255], v[2:3]
// W32: encoding: [0xfe,0x05,0x48,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f64 vcc_lo, s[2:3], v[2:3]
// W32: encoding: [0x02,0x04,0x48,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f64 vcc_lo, s[104:105], v[2:3]
// W32: encoding: [0x68,0x04,0x48,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f64 vcc_lo, vcc, v[2:3]
// W32: encoding: [0x6a,0x04,0x48,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f64 vcc_lo, ttmp[14:15], v[2:3]
// W32: encoding: [0x7a,0x04,0x48,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f64 vcc_lo, exec, v[2:3]
// W32: encoding: [0x7e,0x04,0x48,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f64 vcc_lo, null, v[2:3]
// W32: encoding: [0x7c,0x04,0x48,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f64 vcc_lo, -1, v[2:3]
// W32: encoding: [0xc1,0x04,0x48,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f64 vcc_lo, 0.5, v[2:3]
// W32: encoding: [0xf0,0x04,0x48,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f64 vcc_lo, src_scc, v[2:3]
// W32: encoding: [0xfd,0x04,0x48,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f64 vcc_lo, 0xaf123456, v[254:255]
// W32: encoding: [0xff,0xfc,0x49,0x7c,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f64 vcc, v[1:2], v[2:3]
// W64: encoding: [0x01,0x05,0x48,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f64 vcc, v[254:255], v[2:3]
// W64: encoding: [0xfe,0x05,0x48,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f64 vcc, s[2:3], v[2:3]
// W64: encoding: [0x02,0x04,0x48,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f64 vcc, s[104:105], v[2:3]
// W64: encoding: [0x68,0x04,0x48,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f64 vcc, vcc, v[2:3]
// W64: encoding: [0x6a,0x04,0x48,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f64 vcc, ttmp[14:15], v[2:3]
// W64: encoding: [0x7a,0x04,0x48,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f64 vcc, exec, v[2:3]
// W64: encoding: [0x7e,0x04,0x48,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f64 vcc, null, v[2:3]
// W64: encoding: [0x7c,0x04,0x48,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f64 vcc, -1, v[2:3]
// W64: encoding: [0xc1,0x04,0x48,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f64 vcc, 0.5, v[2:3]
// W64: encoding: [0xf0,0x04,0x48,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f64 vcc, src_scc, v[2:3]
// W64: encoding: [0xfd,0x04,0x48,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_f64 vcc, 0xaf123456, v[254:255]
// W64: encoding: [0xff,0xfc,0x49,0x7c,0x56,0x34,0x12,0xaf]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc_lo, v1, v2
// W32: encoding: [0x01,0x05,0x68,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc_lo, v127, v2
// W32: encoding: [0x7f,0x05,0x68,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc_lo, s1, v2
// W32: encoding: [0x01,0x04,0x68,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc_lo, s105, v2
// W32: encoding: [0x69,0x04,0x68,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc_lo, vcc_lo, v2
// W32: encoding: [0x6a,0x04,0x68,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc_lo, vcc_hi, v2
// W32: encoding: [0x6b,0x04,0x68,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc_lo, ttmp15, v2
// W32: encoding: [0x7b,0x04,0x68,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc_lo, m0, v2
// W32: encoding: [0x7d,0x04,0x68,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc_lo, exec_lo, v2
// W32: encoding: [0x7e,0x04,0x68,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc_lo, exec_hi, v2
// W32: encoding: [0x7f,0x04,0x68,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc_lo, null, v2
// W32: encoding: [0x7c,0x04,0x68,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc_lo, -1, v2
// W32: encoding: [0xc1,0x04,0x68,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc_lo, 0.5, v2
// W32: encoding: [0xf0,0x04,0x68,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc_lo, src_scc, v2
// W32: encoding: [0xfd,0x04,0x68,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc_lo, 0xfe0b, v127
// W32: encoding: [0xff,0xfe,0x68,0x7c,0x0b,0xfe,0x00,0x00]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc, v1, v2
// W64: encoding: [0x01,0x05,0x68,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc, v127, v2
// W64: encoding: [0x7f,0x05,0x68,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc, s1, v2
// W64: encoding: [0x01,0x04,0x68,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc, s105, v2
// W64: encoding: [0x69,0x04,0x68,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc, vcc_lo, v2
// W64: encoding: [0x6a,0x04,0x68,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc, vcc_hi, v2
// W64: encoding: [0x6b,0x04,0x68,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc, ttmp15, v2
// W64: encoding: [0x7b,0x04,0x68,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc, m0, v2
// W64: encoding: [0x7d,0x04,0x68,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc, exec_lo, v2
// W64: encoding: [0x7e,0x04,0x68,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc, exec_hi, v2
// W64: encoding: [0x7f,0x04,0x68,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc, null, v2
// W64: encoding: [0x7c,0x04,0x68,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc, -1, v2
// W64: encoding: [0xc1,0x04,0x68,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc, 0.5, v2
// W64: encoding: [0xf0,0x04,0x68,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc, src_scc, v2
// W64: encoding: [0xfd,0x04,0x68,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i16 vcc, 0xfe0b, v127
// W64: encoding: [0xff,0xfe,0x68,0x7c,0x0b,0xfe,0x00,0x00]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc_lo, v1, v2
// W32: encoding: [0x01,0x05,0x88,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc_lo, v255, v2
// W32: encoding: [0xff,0x05,0x88,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc_lo, s1, v2
// W32: encoding: [0x01,0x04,0x88,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc_lo, s105, v2
// W32: encoding: [0x69,0x04,0x88,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc_lo, vcc_lo, v2
// W32: encoding: [0x6a,0x04,0x88,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc_lo, vcc_hi, v2
// W32: encoding: [0x6b,0x04,0x88,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc_lo, ttmp15, v2
// W32: encoding: [0x7b,0x04,0x88,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc_lo, m0, v2
// W32: encoding: [0x7d,0x04,0x88,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc_lo, exec_lo, v2
// W32: encoding: [0x7e,0x04,0x88,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc_lo, exec_hi, v2
// W32: encoding: [0x7f,0x04,0x88,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc_lo, null, v2
// W32: encoding: [0x7c,0x04,0x88,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc_lo, -1, v2
// W32: encoding: [0xc1,0x04,0x88,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc_lo, 0.5, v2
// W32: encoding: [0xf0,0x04,0x88,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc_lo, src_scc, v2
// W32: encoding: [0xfd,0x04,0x88,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc_lo, 0xaf123456, v255
// W32: encoding: [0xff,0xfe,0x89,0x7c,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc, v1, v2
// W64: encoding: [0x01,0x05,0x88,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc, v255, v2
// W64: encoding: [0xff,0x05,0x88,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc, s1, v2
// W64: encoding: [0x01,0x04,0x88,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc, s105, v2
// W64: encoding: [0x69,0x04,0x88,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc, vcc_lo, v2
// W64: encoding: [0x6a,0x04,0x88,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc, vcc_hi, v2
// W64: encoding: [0x6b,0x04,0x88,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc, ttmp15, v2
// W64: encoding: [0x7b,0x04,0x88,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc, m0, v2
// W64: encoding: [0x7d,0x04,0x88,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc, exec_lo, v2
// W64: encoding: [0x7e,0x04,0x88,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc, exec_hi, v2
// W64: encoding: [0x7f,0x04,0x88,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc, null, v2
// W64: encoding: [0x7c,0x04,0x88,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc, -1, v2
// W64: encoding: [0xc1,0x04,0x88,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc, 0.5, v2
// W64: encoding: [0xf0,0x04,0x88,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc, src_scc, v2
// W64: encoding: [0xfd,0x04,0x88,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i32 vcc, 0xaf123456, v255
// W64: encoding: [0xff,0xfe,0x89,0x7c,0x56,0x34,0x12,0xaf]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i64 vcc_lo, v[1:2], v[2:3]
// W32: encoding: [0x01,0x05,0xa8,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i64 vcc_lo, v[254:255], v[2:3]
// W32: encoding: [0xfe,0x05,0xa8,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i64 vcc_lo, s[2:3], v[2:3]
// W32: encoding: [0x02,0x04,0xa8,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i64 vcc_lo, s[104:105], v[2:3]
// W32: encoding: [0x68,0x04,0xa8,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i64 vcc_lo, vcc, v[2:3]
// W32: encoding: [0x6a,0x04,0xa8,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i64 vcc_lo, ttmp[14:15], v[2:3]
// W32: encoding: [0x7a,0x04,0xa8,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i64 vcc_lo, exec, v[2:3]
// W32: encoding: [0x7e,0x04,0xa8,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i64 vcc_lo, null, v[2:3]
// W32: encoding: [0x7c,0x04,0xa8,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i64 vcc_lo, -1, v[2:3]
// W32: encoding: [0xc1,0x04,0xa8,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i64 vcc_lo, 0.5, v[2:3]
// W32: encoding: [0xf0,0x04,0xa8,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i64 vcc_lo, src_scc, v[2:3]
// W32: encoding: [0xfd,0x04,0xa8,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i64 vcc_lo, 0xaf123456, v[254:255]
// W32: encoding: [0xff,0xfc,0xa9,0x7c,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i64 vcc, v[1:2], v[2:3]
// W64: encoding: [0x01,0x05,0xa8,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i64 vcc, v[254:255], v[2:3]
// W64: encoding: [0xfe,0x05,0xa8,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i64 vcc, s[2:3], v[2:3]
// W64: encoding: [0x02,0x04,0xa8,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i64 vcc, s[104:105], v[2:3]
// W64: encoding: [0x68,0x04,0xa8,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i64 vcc, vcc, v[2:3]
// W64: encoding: [0x6a,0x04,0xa8,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i64 vcc, ttmp[14:15], v[2:3]
// W64: encoding: [0x7a,0x04,0xa8,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i64 vcc, exec, v[2:3]
// W64: encoding: [0x7e,0x04,0xa8,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i64 vcc, null, v[2:3]
// W64: encoding: [0x7c,0x04,0xa8,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i64 vcc, -1, v[2:3]
// W64: encoding: [0xc1,0x04,0xa8,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i64 vcc, 0.5, v[2:3]
// W64: encoding: [0xf0,0x04,0xa8,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i64 vcc, src_scc, v[2:3]
// W64: encoding: [0xfd,0x04,0xa8,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_i64 vcc, 0xaf123456, v[254:255]
// W64: encoding: [0xff,0xfc,0xa9,0x7c,0x56,0x34,0x12,0xaf]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc_lo, v1, v2
// W32: encoding: [0x01,0x05,0x78,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc_lo, v127, v2
// W32: encoding: [0x7f,0x05,0x78,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc_lo, s1, v2
// W32: encoding: [0x01,0x04,0x78,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc_lo, s105, v2
// W32: encoding: [0x69,0x04,0x78,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc_lo, vcc_lo, v2
// W32: encoding: [0x6a,0x04,0x78,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc_lo, vcc_hi, v2
// W32: encoding: [0x6b,0x04,0x78,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc_lo, ttmp15, v2
// W32: encoding: [0x7b,0x04,0x78,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc_lo, m0, v2
// W32: encoding: [0x7d,0x04,0x78,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc_lo, exec_lo, v2
// W32: encoding: [0x7e,0x04,0x78,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc_lo, exec_hi, v2
// W32: encoding: [0x7f,0x04,0x78,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc_lo, null, v2
// W32: encoding: [0x7c,0x04,0x78,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc_lo, -1, v2
// W32: encoding: [0xc1,0x04,0x78,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc_lo, 0.5, v2
// W32: encoding: [0xf0,0x04,0x78,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc_lo, src_scc, v2
// W32: encoding: [0xfd,0x04,0x78,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc_lo, 0xfe0b, v127
// W32: encoding: [0xff,0xfe,0x78,0x7c,0x0b,0xfe,0x00,0x00]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc, v1, v2
// W64: encoding: [0x01,0x05,0x78,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc, v127, v2
// W64: encoding: [0x7f,0x05,0x78,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc, s1, v2
// W64: encoding: [0x01,0x04,0x78,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc, s105, v2
// W64: encoding: [0x69,0x04,0x78,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc, vcc_lo, v2
// W64: encoding: [0x6a,0x04,0x78,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc, vcc_hi, v2
// W64: encoding: [0x6b,0x04,0x78,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc, ttmp15, v2
// W64: encoding: [0x7b,0x04,0x78,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc, m0, v2
// W64: encoding: [0x7d,0x04,0x78,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc, exec_lo, v2
// W64: encoding: [0x7e,0x04,0x78,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc, exec_hi, v2
// W64: encoding: [0x7f,0x04,0x78,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc, null, v2
// W64: encoding: [0x7c,0x04,0x78,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc, -1, v2
// W64: encoding: [0xc1,0x04,0x78,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc, 0.5, v2
// W64: encoding: [0xf0,0x04,0x78,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc, src_scc, v2
// W64: encoding: [0xfd,0x04,0x78,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u16 vcc, 0xfe0b, v127
// W64: encoding: [0xff,0xfe,0x78,0x7c,0x0b,0xfe,0x00,0x00]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc_lo, v1, v2
// W32: encoding: [0x01,0x05,0x98,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc_lo, v255, v2
// W32: encoding: [0xff,0x05,0x98,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc_lo, s1, v2
// W32: encoding: [0x01,0x04,0x98,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc_lo, s105, v2
// W32: encoding: [0x69,0x04,0x98,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc_lo, vcc_lo, v2
// W32: encoding: [0x6a,0x04,0x98,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc_lo, vcc_hi, v2
// W32: encoding: [0x6b,0x04,0x98,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc_lo, ttmp15, v2
// W32: encoding: [0x7b,0x04,0x98,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc_lo, m0, v2
// W32: encoding: [0x7d,0x04,0x98,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc_lo, exec_lo, v2
// W32: encoding: [0x7e,0x04,0x98,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc_lo, exec_hi, v2
// W32: encoding: [0x7f,0x04,0x98,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc_lo, null, v2
// W32: encoding: [0x7c,0x04,0x98,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc_lo, -1, v2
// W32: encoding: [0xc1,0x04,0x98,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc_lo, 0.5, v2
// W32: encoding: [0xf0,0x04,0x98,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc_lo, src_scc, v2
// W32: encoding: [0xfd,0x04,0x98,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc_lo, 0xaf123456, v255
// W32: encoding: [0xff,0xfe,0x99,0x7c,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc, v1, v2
// W64: encoding: [0x01,0x05,0x98,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc, v255, v2
// W64: encoding: [0xff,0x05,0x98,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc, s1, v2
// W64: encoding: [0x01,0x04,0x98,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc, s105, v2
// W64: encoding: [0x69,0x04,0x98,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc, vcc_lo, v2
// W64: encoding: [0x6a,0x04,0x98,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc, vcc_hi, v2
// W64: encoding: [0x6b,0x04,0x98,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc, ttmp15, v2
// W64: encoding: [0x7b,0x04,0x98,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc, m0, v2
// W64: encoding: [0x7d,0x04,0x98,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc, exec_lo, v2
// W64: encoding: [0x7e,0x04,0x98,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc, exec_hi, v2
// W64: encoding: [0x7f,0x04,0x98,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc, null, v2
// W64: encoding: [0x7c,0x04,0x98,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc, -1, v2
// W64: encoding: [0xc1,0x04,0x98,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc, 0.5, v2
// W64: encoding: [0xf0,0x04,0x98,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc, src_scc, v2
// W64: encoding: [0xfd,0x04,0x98,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u32 vcc, 0xaf123456, v255
// W64: encoding: [0xff,0xfe,0x99,0x7c,0x56,0x34,0x12,0xaf]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u64 vcc_lo, v[1:2], v[2:3]
// W32: encoding: [0x01,0x05,0xb8,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u64 vcc_lo, v[254:255], v[2:3]
// W32: encoding: [0xfe,0x05,0xb8,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u64 vcc_lo, s[2:3], v[2:3]
// W32: encoding: [0x02,0x04,0xb8,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u64 vcc_lo, s[104:105], v[2:3]
// W32: encoding: [0x68,0x04,0xb8,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u64 vcc_lo, vcc, v[2:3]
// W32: encoding: [0x6a,0x04,0xb8,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u64 vcc_lo, ttmp[14:15], v[2:3]
// W32: encoding: [0x7a,0x04,0xb8,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u64 vcc_lo, exec, v[2:3]
// W32: encoding: [0x7e,0x04,0xb8,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u64 vcc_lo, null, v[2:3]
// W32: encoding: [0x7c,0x04,0xb8,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u64 vcc_lo, -1, v[2:3]
// W32: encoding: [0xc1,0x04,0xb8,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u64 vcc_lo, 0.5, v[2:3]
// W32: encoding: [0xf0,0x04,0xb8,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u64 vcc_lo, src_scc, v[2:3]
// W32: encoding: [0xfd,0x04,0xb8,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u64 vcc_lo, 0xaf123456, v[254:255]
// W32: encoding: [0xff,0xfc,0xb9,0x7c,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u64 vcc, v[1:2], v[2:3]
// W64: encoding: [0x01,0x05,0xb8,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u64 vcc, v[254:255], v[2:3]
// W64: encoding: [0xfe,0x05,0xb8,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u64 vcc, s[2:3], v[2:3]
// W64: encoding: [0x02,0x04,0xb8,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u64 vcc, s[104:105], v[2:3]
// W64: encoding: [0x68,0x04,0xb8,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u64 vcc, vcc, v[2:3]
// W64: encoding: [0x6a,0x04,0xb8,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u64 vcc, ttmp[14:15], v[2:3]
// W64: encoding: [0x7a,0x04,0xb8,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u64 vcc, exec, v[2:3]
// W64: encoding: [0x7e,0x04,0xb8,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u64 vcc, null, v[2:3]
// W64: encoding: [0x7c,0x04,0xb8,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u64 vcc, -1, v[2:3]
// W64: encoding: [0xc1,0x04,0xb8,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u64 vcc, 0.5, v[2:3]
// W64: encoding: [0xf0,0x04,0xb8,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u64 vcc, src_scc, v[2:3]
// W64: encoding: [0xfd,0x04,0xb8,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_gt_u64 vcc, 0xaf123456, v[254:255]
// W64: encoding: [0xff,0xfc,0xb9,0x7c,0x56,0x34,0x12,0xaf]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc_lo, v1, v2
// W32: encoding: [0x01,0x05,0x06,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc_lo, v127, v2
// W32: encoding: [0x7f,0x05,0x06,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc_lo, s1, v2
// W32: encoding: [0x01,0x04,0x06,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc_lo, s105, v2
// W32: encoding: [0x69,0x04,0x06,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc_lo, vcc_lo, v2
// W32: encoding: [0x6a,0x04,0x06,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc_lo, vcc_hi, v2
// W32: encoding: [0x6b,0x04,0x06,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc_lo, ttmp15, v2
// W32: encoding: [0x7b,0x04,0x06,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc_lo, m0, v2
// W32: encoding: [0x7d,0x04,0x06,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc_lo, exec_lo, v2
// W32: encoding: [0x7e,0x04,0x06,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc_lo, exec_hi, v2
// W32: encoding: [0x7f,0x04,0x06,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc_lo, null, v2
// W32: encoding: [0x7c,0x04,0x06,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc_lo, -1, v2
// W32: encoding: [0xc1,0x04,0x06,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc_lo, 0.5, v2
// W32: encoding: [0xf0,0x04,0x06,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc_lo, src_scc, v2
// W32: encoding: [0xfd,0x04,0x06,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc_lo, 0xfe0b, v127
// W32: encoding: [0xff,0xfe,0x06,0x7c,0x0b,0xfe,0x00,0x00]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc, v1, v2
// W64: encoding: [0x01,0x05,0x06,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc, v127, v2
// W64: encoding: [0x7f,0x05,0x06,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc, s1, v2
// W64: encoding: [0x01,0x04,0x06,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc, s105, v2
// W64: encoding: [0x69,0x04,0x06,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc, vcc_lo, v2
// W64: encoding: [0x6a,0x04,0x06,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc, vcc_hi, v2
// W64: encoding: [0x6b,0x04,0x06,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc, ttmp15, v2
// W64: encoding: [0x7b,0x04,0x06,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc, m0, v2
// W64: encoding: [0x7d,0x04,0x06,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc, exec_lo, v2
// W64: encoding: [0x7e,0x04,0x06,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc, exec_hi, v2
// W64: encoding: [0x7f,0x04,0x06,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc, null, v2
// W64: encoding: [0x7c,0x04,0x06,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc, -1, v2
// W64: encoding: [0xc1,0x04,0x06,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc, 0.5, v2
// W64: encoding: [0xf0,0x04,0x06,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc, src_scc, v2
// W64: encoding: [0xfd,0x04,0x06,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f16 vcc, 0xfe0b, v127
// W64: encoding: [0xff,0xfe,0x06,0x7c,0x0b,0xfe,0x00,0x00]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc_lo, v1, v2
// W32: encoding: [0x01,0x05,0x26,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc_lo, v255, v2
// W32: encoding: [0xff,0x05,0x26,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc_lo, s1, v2
// W32: encoding: [0x01,0x04,0x26,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc_lo, s105, v2
// W32: encoding: [0x69,0x04,0x26,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc_lo, vcc_lo, v2
// W32: encoding: [0x6a,0x04,0x26,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc_lo, vcc_hi, v2
// W32: encoding: [0x6b,0x04,0x26,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc_lo, ttmp15, v2
// W32: encoding: [0x7b,0x04,0x26,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc_lo, m0, v2
// W32: encoding: [0x7d,0x04,0x26,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc_lo, exec_lo, v2
// W32: encoding: [0x7e,0x04,0x26,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc_lo, exec_hi, v2
// W32: encoding: [0x7f,0x04,0x26,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc_lo, null, v2
// W32: encoding: [0x7c,0x04,0x26,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc_lo, -1, v2
// W32: encoding: [0xc1,0x04,0x26,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc_lo, 0.5, v2
// W32: encoding: [0xf0,0x04,0x26,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc_lo, src_scc, v2
// W32: encoding: [0xfd,0x04,0x26,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc_lo, 0xaf123456, v255
// W32: encoding: [0xff,0xfe,0x27,0x7c,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc, v1, v2
// W64: encoding: [0x01,0x05,0x26,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc, v255, v2
// W64: encoding: [0xff,0x05,0x26,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc, s1, v2
// W64: encoding: [0x01,0x04,0x26,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc, s105, v2
// W64: encoding: [0x69,0x04,0x26,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc, vcc_lo, v2
// W64: encoding: [0x6a,0x04,0x26,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc, vcc_hi, v2
// W64: encoding: [0x6b,0x04,0x26,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc, ttmp15, v2
// W64: encoding: [0x7b,0x04,0x26,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc, m0, v2
// W64: encoding: [0x7d,0x04,0x26,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc, exec_lo, v2
// W64: encoding: [0x7e,0x04,0x26,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc, exec_hi, v2
// W64: encoding: [0x7f,0x04,0x26,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc, null, v2
// W64: encoding: [0x7c,0x04,0x26,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc, -1, v2
// W64: encoding: [0xc1,0x04,0x26,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc, 0.5, v2
// W64: encoding: [0xf0,0x04,0x26,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc, src_scc, v2
// W64: encoding: [0xfd,0x04,0x26,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f32 vcc, 0xaf123456, v255
// W64: encoding: [0xff,0xfe,0x27,0x7c,0x56,0x34,0x12,0xaf]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f64 vcc_lo, v[1:2], v[2:3]
// W32: encoding: [0x01,0x05,0x46,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f64 vcc_lo, v[254:255], v[2:3]
// W32: encoding: [0xfe,0x05,0x46,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f64 vcc_lo, s[2:3], v[2:3]
// W32: encoding: [0x02,0x04,0x46,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f64 vcc_lo, s[104:105], v[2:3]
// W32: encoding: [0x68,0x04,0x46,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f64 vcc_lo, vcc, v[2:3]
// W32: encoding: [0x6a,0x04,0x46,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f64 vcc_lo, ttmp[14:15], v[2:3]
// W32: encoding: [0x7a,0x04,0x46,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f64 vcc_lo, exec, v[2:3]
// W32: encoding: [0x7e,0x04,0x46,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f64 vcc_lo, null, v[2:3]
// W32: encoding: [0x7c,0x04,0x46,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f64 vcc_lo, -1, v[2:3]
// W32: encoding: [0xc1,0x04,0x46,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f64 vcc_lo, 0.5, v[2:3]
// W32: encoding: [0xf0,0x04,0x46,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f64 vcc_lo, src_scc, v[2:3]
// W32: encoding: [0xfd,0x04,0x46,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f64 vcc_lo, 0xaf123456, v[254:255]
// W32: encoding: [0xff,0xfc,0x47,0x7c,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f64 vcc, v[1:2], v[2:3]
// W64: encoding: [0x01,0x05,0x46,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f64 vcc, v[254:255], v[2:3]
// W64: encoding: [0xfe,0x05,0x46,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f64 vcc, s[2:3], v[2:3]
// W64: encoding: [0x02,0x04,0x46,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f64 vcc, s[104:105], v[2:3]
// W64: encoding: [0x68,0x04,0x46,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f64 vcc, vcc, v[2:3]
// W64: encoding: [0x6a,0x04,0x46,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f64 vcc, ttmp[14:15], v[2:3]
// W64: encoding: [0x7a,0x04,0x46,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f64 vcc, exec, v[2:3]
// W64: encoding: [0x7e,0x04,0x46,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f64 vcc, null, v[2:3]
// W64: encoding: [0x7c,0x04,0x46,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f64 vcc, -1, v[2:3]
// W64: encoding: [0xc1,0x04,0x46,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f64 vcc, 0.5, v[2:3]
// W64: encoding: [0xf0,0x04,0x46,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f64 vcc, src_scc, v[2:3]
// W64: encoding: [0xfd,0x04,0x46,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_f64 vcc, 0xaf123456, v[254:255]
// W64: encoding: [0xff,0xfc,0x47,0x7c,0x56,0x34,0x12,0xaf]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc_lo, v1, v2
// W32: encoding: [0x01,0x05,0x66,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc_lo, v127, v2
// W32: encoding: [0x7f,0x05,0x66,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc_lo, s1, v2
// W32: encoding: [0x01,0x04,0x66,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc_lo, s105, v2
// W32: encoding: [0x69,0x04,0x66,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc_lo, vcc_lo, v2
// W32: encoding: [0x6a,0x04,0x66,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc_lo, vcc_hi, v2
// W32: encoding: [0x6b,0x04,0x66,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc_lo, ttmp15, v2
// W32: encoding: [0x7b,0x04,0x66,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc_lo, m0, v2
// W32: encoding: [0x7d,0x04,0x66,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc_lo, exec_lo, v2
// W32: encoding: [0x7e,0x04,0x66,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc_lo, exec_hi, v2
// W32: encoding: [0x7f,0x04,0x66,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc_lo, null, v2
// W32: encoding: [0x7c,0x04,0x66,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc_lo, -1, v2
// W32: encoding: [0xc1,0x04,0x66,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc_lo, 0.5, v2
// W32: encoding: [0xf0,0x04,0x66,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc_lo, src_scc, v2
// W32: encoding: [0xfd,0x04,0x66,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc_lo, 0xfe0b, v127
// W32: encoding: [0xff,0xfe,0x66,0x7c,0x0b,0xfe,0x00,0x00]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc, v1, v2
// W64: encoding: [0x01,0x05,0x66,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc, v127, v2
// W64: encoding: [0x7f,0x05,0x66,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc, s1, v2
// W64: encoding: [0x01,0x04,0x66,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc, s105, v2
// W64: encoding: [0x69,0x04,0x66,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc, vcc_lo, v2
// W64: encoding: [0x6a,0x04,0x66,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc, vcc_hi, v2
// W64: encoding: [0x6b,0x04,0x66,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc, ttmp15, v2
// W64: encoding: [0x7b,0x04,0x66,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc, m0, v2
// W64: encoding: [0x7d,0x04,0x66,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc, exec_lo, v2
// W64: encoding: [0x7e,0x04,0x66,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc, exec_hi, v2
// W64: encoding: [0x7f,0x04,0x66,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc, null, v2
// W64: encoding: [0x7c,0x04,0x66,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc, -1, v2
// W64: encoding: [0xc1,0x04,0x66,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc, 0.5, v2
// W64: encoding: [0xf0,0x04,0x66,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc, src_scc, v2
// W64: encoding: [0xfd,0x04,0x66,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i16 vcc, 0xfe0b, v127
// W64: encoding: [0xff,0xfe,0x66,0x7c,0x0b,0xfe,0x00,0x00]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc_lo, v1, v2
// W32: encoding: [0x01,0x05,0x86,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc_lo, v255, v2
// W32: encoding: [0xff,0x05,0x86,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc_lo, s1, v2
// W32: encoding: [0x01,0x04,0x86,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc_lo, s105, v2
// W32: encoding: [0x69,0x04,0x86,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc_lo, vcc_lo, v2
// W32: encoding: [0x6a,0x04,0x86,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc_lo, vcc_hi, v2
// W32: encoding: [0x6b,0x04,0x86,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc_lo, ttmp15, v2
// W32: encoding: [0x7b,0x04,0x86,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc_lo, m0, v2
// W32: encoding: [0x7d,0x04,0x86,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc_lo, exec_lo, v2
// W32: encoding: [0x7e,0x04,0x86,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc_lo, exec_hi, v2
// W32: encoding: [0x7f,0x04,0x86,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc_lo, null, v2
// W32: encoding: [0x7c,0x04,0x86,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc_lo, -1, v2
// W32: encoding: [0xc1,0x04,0x86,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc_lo, 0.5, v2
// W32: encoding: [0xf0,0x04,0x86,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc_lo, src_scc, v2
// W32: encoding: [0xfd,0x04,0x86,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc_lo, 0xaf123456, v255
// W32: encoding: [0xff,0xfe,0x87,0x7c,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc, v1, v2
// W64: encoding: [0x01,0x05,0x86,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc, v255, v2
// W64: encoding: [0xff,0x05,0x86,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc, s1, v2
// W64: encoding: [0x01,0x04,0x86,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc, s105, v2
// W64: encoding: [0x69,0x04,0x86,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc, vcc_lo, v2
// W64: encoding: [0x6a,0x04,0x86,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc, vcc_hi, v2
// W64: encoding: [0x6b,0x04,0x86,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc, ttmp15, v2
// W64: encoding: [0x7b,0x04,0x86,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc, m0, v2
// W64: encoding: [0x7d,0x04,0x86,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc, exec_lo, v2
// W64: encoding: [0x7e,0x04,0x86,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc, exec_hi, v2
// W64: encoding: [0x7f,0x04,0x86,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc, null, v2
// W64: encoding: [0x7c,0x04,0x86,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc, -1, v2
// W64: encoding: [0xc1,0x04,0x86,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc, 0.5, v2
// W64: encoding: [0xf0,0x04,0x86,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc, src_scc, v2
// W64: encoding: [0xfd,0x04,0x86,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i32 vcc, 0xaf123456, v255
// W64: encoding: [0xff,0xfe,0x87,0x7c,0x56,0x34,0x12,0xaf]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i64 vcc_lo, v[1:2], v[2:3]
// W32: encoding: [0x01,0x05,0xa6,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i64 vcc_lo, v[254:255], v[2:3]
// W32: encoding: [0xfe,0x05,0xa6,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i64 vcc_lo, s[2:3], v[2:3]
// W32: encoding: [0x02,0x04,0xa6,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i64 vcc_lo, s[104:105], v[2:3]
// W32: encoding: [0x68,0x04,0xa6,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i64 vcc_lo, vcc, v[2:3]
// W32: encoding: [0x6a,0x04,0xa6,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i64 vcc_lo, ttmp[14:15], v[2:3]
// W32: encoding: [0x7a,0x04,0xa6,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i64 vcc_lo, exec, v[2:3]
// W32: encoding: [0x7e,0x04,0xa6,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i64 vcc_lo, null, v[2:3]
// W32: encoding: [0x7c,0x04,0xa6,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i64 vcc_lo, -1, v[2:3]
// W32: encoding: [0xc1,0x04,0xa6,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i64 vcc_lo, 0.5, v[2:3]
// W32: encoding: [0xf0,0x04,0xa6,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i64 vcc_lo, src_scc, v[2:3]
// W32: encoding: [0xfd,0x04,0xa6,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i64 vcc_lo, 0xaf123456, v[254:255]
// W32: encoding: [0xff,0xfc,0xa7,0x7c,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i64 vcc, v[1:2], v[2:3]
// W64: encoding: [0x01,0x05,0xa6,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i64 vcc, v[254:255], v[2:3]
// W64: encoding: [0xfe,0x05,0xa6,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i64 vcc, s[2:3], v[2:3]
// W64: encoding: [0x02,0x04,0xa6,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i64 vcc, s[104:105], v[2:3]
// W64: encoding: [0x68,0x04,0xa6,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i64 vcc, vcc, v[2:3]
// W64: encoding: [0x6a,0x04,0xa6,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i64 vcc, ttmp[14:15], v[2:3]
// W64: encoding: [0x7a,0x04,0xa6,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i64 vcc, exec, v[2:3]
// W64: encoding: [0x7e,0x04,0xa6,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i64 vcc, null, v[2:3]
// W64: encoding: [0x7c,0x04,0xa6,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i64 vcc, -1, v[2:3]
// W64: encoding: [0xc1,0x04,0xa6,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i64 vcc, 0.5, v[2:3]
// W64: encoding: [0xf0,0x04,0xa6,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i64 vcc, src_scc, v[2:3]
// W64: encoding: [0xfd,0x04,0xa6,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_i64 vcc, 0xaf123456, v[254:255]
// W64: encoding: [0xff,0xfc,0xa7,0x7c,0x56,0x34,0x12,0xaf]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc_lo, v1, v2
// W32: encoding: [0x01,0x05,0x76,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc_lo, v127, v2
// W32: encoding: [0x7f,0x05,0x76,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc_lo, s1, v2
// W32: encoding: [0x01,0x04,0x76,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc_lo, s105, v2
// W32: encoding: [0x69,0x04,0x76,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc_lo, vcc_lo, v2
// W32: encoding: [0x6a,0x04,0x76,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc_lo, vcc_hi, v2
// W32: encoding: [0x6b,0x04,0x76,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc_lo, ttmp15, v2
// W32: encoding: [0x7b,0x04,0x76,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc_lo, m0, v2
// W32: encoding: [0x7d,0x04,0x76,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc_lo, exec_lo, v2
// W32: encoding: [0x7e,0x04,0x76,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc_lo, exec_hi, v2
// W32: encoding: [0x7f,0x04,0x76,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc_lo, null, v2
// W32: encoding: [0x7c,0x04,0x76,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc_lo, -1, v2
// W32: encoding: [0xc1,0x04,0x76,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc_lo, 0.5, v2
// W32: encoding: [0xf0,0x04,0x76,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc_lo, src_scc, v2
// W32: encoding: [0xfd,0x04,0x76,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc_lo, 0xfe0b, v127
// W32: encoding: [0xff,0xfe,0x76,0x7c,0x0b,0xfe,0x00,0x00]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc, v1, v2
// W64: encoding: [0x01,0x05,0x76,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc, v127, v2
// W64: encoding: [0x7f,0x05,0x76,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc, s1, v2
// W64: encoding: [0x01,0x04,0x76,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc, s105, v2
// W64: encoding: [0x69,0x04,0x76,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc, vcc_lo, v2
// W64: encoding: [0x6a,0x04,0x76,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc, vcc_hi, v2
// W64: encoding: [0x6b,0x04,0x76,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc, ttmp15, v2
// W64: encoding: [0x7b,0x04,0x76,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc, m0, v2
// W64: encoding: [0x7d,0x04,0x76,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc, exec_lo, v2
// W64: encoding: [0x7e,0x04,0x76,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc, exec_hi, v2
// W64: encoding: [0x7f,0x04,0x76,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc, null, v2
// W64: encoding: [0x7c,0x04,0x76,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc, -1, v2
// W64: encoding: [0xc1,0x04,0x76,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc, 0.5, v2
// W64: encoding: [0xf0,0x04,0x76,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc, src_scc, v2
// W64: encoding: [0xfd,0x04,0x76,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u16 vcc, 0xfe0b, v127
// W64: encoding: [0xff,0xfe,0x76,0x7c,0x0b,0xfe,0x00,0x00]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc_lo, v1, v2
// W32: encoding: [0x01,0x05,0x96,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc_lo, v255, v2
// W32: encoding: [0xff,0x05,0x96,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc_lo, s1, v2
// W32: encoding: [0x01,0x04,0x96,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc_lo, s105, v2
// W32: encoding: [0x69,0x04,0x96,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc_lo, vcc_lo, v2
// W32: encoding: [0x6a,0x04,0x96,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc_lo, vcc_hi, v2
// W32: encoding: [0x6b,0x04,0x96,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc_lo, ttmp15, v2
// W32: encoding: [0x7b,0x04,0x96,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc_lo, m0, v2
// W32: encoding: [0x7d,0x04,0x96,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc_lo, exec_lo, v2
// W32: encoding: [0x7e,0x04,0x96,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc_lo, exec_hi, v2
// W32: encoding: [0x7f,0x04,0x96,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc_lo, null, v2
// W32: encoding: [0x7c,0x04,0x96,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc_lo, -1, v2
// W32: encoding: [0xc1,0x04,0x96,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc_lo, 0.5, v2
// W32: encoding: [0xf0,0x04,0x96,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc_lo, src_scc, v2
// W32: encoding: [0xfd,0x04,0x96,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc_lo, 0xaf123456, v255
// W32: encoding: [0xff,0xfe,0x97,0x7c,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc, v1, v2
// W64: encoding: [0x01,0x05,0x96,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc, v255, v2
// W64: encoding: [0xff,0x05,0x96,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc, s1, v2
// W64: encoding: [0x01,0x04,0x96,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc, s105, v2
// W64: encoding: [0x69,0x04,0x96,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc, vcc_lo, v2
// W64: encoding: [0x6a,0x04,0x96,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc, vcc_hi, v2
// W64: encoding: [0x6b,0x04,0x96,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc, ttmp15, v2
// W64: encoding: [0x7b,0x04,0x96,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc, m0, v2
// W64: encoding: [0x7d,0x04,0x96,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc, exec_lo, v2
// W64: encoding: [0x7e,0x04,0x96,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc, exec_hi, v2
// W64: encoding: [0x7f,0x04,0x96,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc, null, v2
// W64: encoding: [0x7c,0x04,0x96,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc, -1, v2
// W64: encoding: [0xc1,0x04,0x96,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc, 0.5, v2
// W64: encoding: [0xf0,0x04,0x96,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc, src_scc, v2
// W64: encoding: [0xfd,0x04,0x96,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u32 vcc, 0xaf123456, v255
// W64: encoding: [0xff,0xfe,0x97,0x7c,0x56,0x34,0x12,0xaf]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u64 vcc_lo, v[1:2], v[2:3]
// W32: encoding: [0x01,0x05,0xb6,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u64 vcc_lo, v[254:255], v[2:3]
// W32: encoding: [0xfe,0x05,0xb6,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u64 vcc_lo, s[2:3], v[2:3]
// W32: encoding: [0x02,0x04,0xb6,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u64 vcc_lo, s[104:105], v[2:3]
// W32: encoding: [0x68,0x04,0xb6,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u64 vcc_lo, vcc, v[2:3]
// W32: encoding: [0x6a,0x04,0xb6,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u64 vcc_lo, ttmp[14:15], v[2:3]
// W32: encoding: [0x7a,0x04,0xb6,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u64 vcc_lo, exec, v[2:3]
// W32: encoding: [0x7e,0x04,0xb6,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u64 vcc_lo, null, v[2:3]
// W32: encoding: [0x7c,0x04,0xb6,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u64 vcc_lo, -1, v[2:3]
// W32: encoding: [0xc1,0x04,0xb6,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u64 vcc_lo, 0.5, v[2:3]
// W32: encoding: [0xf0,0x04,0xb6,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u64 vcc_lo, src_scc, v[2:3]
// W32: encoding: [0xfd,0x04,0xb6,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u64 vcc_lo, 0xaf123456, v[254:255]
// W32: encoding: [0xff,0xfc,0xb7,0x7c,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u64 vcc, v[1:2], v[2:3]
// W64: encoding: [0x01,0x05,0xb6,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u64 vcc, v[254:255], v[2:3]
// W64: encoding: [0xfe,0x05,0xb6,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u64 vcc, s[2:3], v[2:3]
// W64: encoding: [0x02,0x04,0xb6,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u64 vcc, s[104:105], v[2:3]
// W64: encoding: [0x68,0x04,0xb6,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u64 vcc, vcc, v[2:3]
// W64: encoding: [0x6a,0x04,0xb6,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u64 vcc, ttmp[14:15], v[2:3]
// W64: encoding: [0x7a,0x04,0xb6,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u64 vcc, exec, v[2:3]
// W64: encoding: [0x7e,0x04,0xb6,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u64 vcc, null, v[2:3]
// W64: encoding: [0x7c,0x04,0xb6,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u64 vcc, -1, v[2:3]
// W64: encoding: [0xc1,0x04,0xb6,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u64 vcc, 0.5, v[2:3]
// W64: encoding: [0xf0,0x04,0xb6,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u64 vcc, src_scc, v[2:3]
// W64: encoding: [0xfd,0x04,0xb6,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_le_u64 vcc, 0xaf123456, v[254:255]
// W64: encoding: [0xff,0xfc,0xb7,0x7c,0x56,0x34,0x12,0xaf]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc_lo, v1, v2
// W32: encoding: [0x01,0x05,0x0a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc_lo, v127, v2
// W32: encoding: [0x7f,0x05,0x0a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc_lo, s1, v2
// W32: encoding: [0x01,0x04,0x0a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc_lo, s105, v2
// W32: encoding: [0x69,0x04,0x0a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc_lo, vcc_lo, v2
// W32: encoding: [0x6a,0x04,0x0a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc_lo, vcc_hi, v2
// W32: encoding: [0x6b,0x04,0x0a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc_lo, ttmp15, v2
// W32: encoding: [0x7b,0x04,0x0a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc_lo, m0, v2
// W32: encoding: [0x7d,0x04,0x0a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc_lo, exec_lo, v2
// W32: encoding: [0x7e,0x04,0x0a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc_lo, exec_hi, v2
// W32: encoding: [0x7f,0x04,0x0a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc_lo, null, v2
// W32: encoding: [0x7c,0x04,0x0a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc_lo, -1, v2
// W32: encoding: [0xc1,0x04,0x0a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc_lo, 0.5, v2
// W32: encoding: [0xf0,0x04,0x0a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc_lo, src_scc, v2
// W32: encoding: [0xfd,0x04,0x0a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc_lo, 0xfe0b, v127
// W32: encoding: [0xff,0xfe,0x0a,0x7c,0x0b,0xfe,0x00,0x00]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc, v1, v2
// W64: encoding: [0x01,0x05,0x0a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc, v127, v2
// W64: encoding: [0x7f,0x05,0x0a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc, s1, v2
// W64: encoding: [0x01,0x04,0x0a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc, s105, v2
// W64: encoding: [0x69,0x04,0x0a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc, vcc_lo, v2
// W64: encoding: [0x6a,0x04,0x0a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc, vcc_hi, v2
// W64: encoding: [0x6b,0x04,0x0a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc, ttmp15, v2
// W64: encoding: [0x7b,0x04,0x0a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc, m0, v2
// W64: encoding: [0x7d,0x04,0x0a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc, exec_lo, v2
// W64: encoding: [0x7e,0x04,0x0a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc, exec_hi, v2
// W64: encoding: [0x7f,0x04,0x0a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc, null, v2
// W64: encoding: [0x7c,0x04,0x0a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc, -1, v2
// W64: encoding: [0xc1,0x04,0x0a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc, 0.5, v2
// W64: encoding: [0xf0,0x04,0x0a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc, src_scc, v2
// W64: encoding: [0xfd,0x04,0x0a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f16 vcc, 0xfe0b, v127
// W64: encoding: [0xff,0xfe,0x0a,0x7c,0x0b,0xfe,0x00,0x00]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc_lo, v1, v2
// W32: encoding: [0x01,0x05,0x2a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc_lo, v255, v2
// W32: encoding: [0xff,0x05,0x2a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc_lo, s1, v2
// W32: encoding: [0x01,0x04,0x2a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc_lo, s105, v2
// W32: encoding: [0x69,0x04,0x2a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc_lo, vcc_lo, v2
// W32: encoding: [0x6a,0x04,0x2a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc_lo, vcc_hi, v2
// W32: encoding: [0x6b,0x04,0x2a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc_lo, ttmp15, v2
// W32: encoding: [0x7b,0x04,0x2a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc_lo, m0, v2
// W32: encoding: [0x7d,0x04,0x2a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc_lo, exec_lo, v2
// W32: encoding: [0x7e,0x04,0x2a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc_lo, exec_hi, v2
// W32: encoding: [0x7f,0x04,0x2a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc_lo, null, v2
// W32: encoding: [0x7c,0x04,0x2a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc_lo, -1, v2
// W32: encoding: [0xc1,0x04,0x2a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc_lo, 0.5, v2
// W32: encoding: [0xf0,0x04,0x2a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc_lo, src_scc, v2
// W32: encoding: [0xfd,0x04,0x2a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc_lo, 0xaf123456, v255
// W32: encoding: [0xff,0xfe,0x2b,0x7c,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc, v1, v2
// W64: encoding: [0x01,0x05,0x2a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc, v255, v2
// W64: encoding: [0xff,0x05,0x2a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc, s1, v2
// W64: encoding: [0x01,0x04,0x2a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc, s105, v2
// W64: encoding: [0x69,0x04,0x2a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc, vcc_lo, v2
// W64: encoding: [0x6a,0x04,0x2a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc, vcc_hi, v2
// W64: encoding: [0x6b,0x04,0x2a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc, ttmp15, v2
// W64: encoding: [0x7b,0x04,0x2a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc, m0, v2
// W64: encoding: [0x7d,0x04,0x2a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc, exec_lo, v2
// W64: encoding: [0x7e,0x04,0x2a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc, exec_hi, v2
// W64: encoding: [0x7f,0x04,0x2a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc, null, v2
// W64: encoding: [0x7c,0x04,0x2a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc, -1, v2
// W64: encoding: [0xc1,0x04,0x2a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc, 0.5, v2
// W64: encoding: [0xf0,0x04,0x2a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc, src_scc, v2
// W64: encoding: [0xfd,0x04,0x2a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f32 vcc, 0xaf123456, v255
// W64: encoding: [0xff,0xfe,0x2b,0x7c,0x56,0x34,0x12,0xaf]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f64 vcc_lo, v[1:2], v[2:3]
// W32: encoding: [0x01,0x05,0x4a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f64 vcc_lo, v[254:255], v[2:3]
// W32: encoding: [0xfe,0x05,0x4a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f64 vcc_lo, s[2:3], v[2:3]
// W32: encoding: [0x02,0x04,0x4a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f64 vcc_lo, s[104:105], v[2:3]
// W32: encoding: [0x68,0x04,0x4a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f64 vcc_lo, vcc, v[2:3]
// W32: encoding: [0x6a,0x04,0x4a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f64 vcc_lo, ttmp[14:15], v[2:3]
// W32: encoding: [0x7a,0x04,0x4a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f64 vcc_lo, exec, v[2:3]
// W32: encoding: [0x7e,0x04,0x4a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f64 vcc_lo, null, v[2:3]
// W32: encoding: [0x7c,0x04,0x4a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f64 vcc_lo, -1, v[2:3]
// W32: encoding: [0xc1,0x04,0x4a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f64 vcc_lo, 0.5, v[2:3]
// W32: encoding: [0xf0,0x04,0x4a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f64 vcc_lo, src_scc, v[2:3]
// W32: encoding: [0xfd,0x04,0x4a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f64 vcc_lo, 0xaf123456, v[254:255]
// W32: encoding: [0xff,0xfc,0x4b,0x7c,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f64 vcc, v[1:2], v[2:3]
// W64: encoding: [0x01,0x05,0x4a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f64 vcc, v[254:255], v[2:3]
// W64: encoding: [0xfe,0x05,0x4a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f64 vcc, s[2:3], v[2:3]
// W64: encoding: [0x02,0x04,0x4a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f64 vcc, s[104:105], v[2:3]
// W64: encoding: [0x68,0x04,0x4a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f64 vcc, vcc, v[2:3]
// W64: encoding: [0x6a,0x04,0x4a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f64 vcc, ttmp[14:15], v[2:3]
// W64: encoding: [0x7a,0x04,0x4a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f64 vcc, exec, v[2:3]
// W64: encoding: [0x7e,0x04,0x4a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f64 vcc, null, v[2:3]
// W64: encoding: [0x7c,0x04,0x4a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f64 vcc, -1, v[2:3]
// W64: encoding: [0xc1,0x04,0x4a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f64 vcc, 0.5, v[2:3]
// W64: encoding: [0xf0,0x04,0x4a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f64 vcc, src_scc, v[2:3]
// W64: encoding: [0xfd,0x04,0x4a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lg_f64 vcc, 0xaf123456, v[254:255]
// W64: encoding: [0xff,0xfc,0x4b,0x7c,0x56,0x34,0x12,0xaf]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc_lo, v1, v2
// W32: encoding: [0x01,0x05,0x02,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc_lo, v127, v2
// W32: encoding: [0x7f,0x05,0x02,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc_lo, s1, v2
// W32: encoding: [0x01,0x04,0x02,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc_lo, s105, v2
// W32: encoding: [0x69,0x04,0x02,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc_lo, vcc_lo, v2
// W32: encoding: [0x6a,0x04,0x02,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc_lo, vcc_hi, v2
// W32: encoding: [0x6b,0x04,0x02,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc_lo, ttmp15, v2
// W32: encoding: [0x7b,0x04,0x02,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc_lo, m0, v2
// W32: encoding: [0x7d,0x04,0x02,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc_lo, exec_lo, v2
// W32: encoding: [0x7e,0x04,0x02,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc_lo, exec_hi, v2
// W32: encoding: [0x7f,0x04,0x02,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc_lo, null, v2
// W32: encoding: [0x7c,0x04,0x02,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc_lo, -1, v2
// W32: encoding: [0xc1,0x04,0x02,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc_lo, 0.5, v2
// W32: encoding: [0xf0,0x04,0x02,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc_lo, src_scc, v2
// W32: encoding: [0xfd,0x04,0x02,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc_lo, 0xfe0b, v127
// W32: encoding: [0xff,0xfe,0x02,0x7c,0x0b,0xfe,0x00,0x00]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc, v1, v2
// W64: encoding: [0x01,0x05,0x02,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc, v127, v2
// W64: encoding: [0x7f,0x05,0x02,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc, s1, v2
// W64: encoding: [0x01,0x04,0x02,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc, s105, v2
// W64: encoding: [0x69,0x04,0x02,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc, vcc_lo, v2
// W64: encoding: [0x6a,0x04,0x02,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc, vcc_hi, v2
// W64: encoding: [0x6b,0x04,0x02,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc, ttmp15, v2
// W64: encoding: [0x7b,0x04,0x02,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc, m0, v2
// W64: encoding: [0x7d,0x04,0x02,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc, exec_lo, v2
// W64: encoding: [0x7e,0x04,0x02,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc, exec_hi, v2
// W64: encoding: [0x7f,0x04,0x02,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc, null, v2
// W64: encoding: [0x7c,0x04,0x02,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc, -1, v2
// W64: encoding: [0xc1,0x04,0x02,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc, 0.5, v2
// W64: encoding: [0xf0,0x04,0x02,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc, src_scc, v2
// W64: encoding: [0xfd,0x04,0x02,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f16 vcc, 0xfe0b, v127
// W64: encoding: [0xff,0xfe,0x02,0x7c,0x0b,0xfe,0x00,0x00]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc_lo, v1, v2
// W32: encoding: [0x01,0x05,0x22,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc_lo, v255, v2
// W32: encoding: [0xff,0x05,0x22,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc_lo, s1, v2
// W32: encoding: [0x01,0x04,0x22,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc_lo, s105, v2
// W32: encoding: [0x69,0x04,0x22,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc_lo, vcc_lo, v2
// W32: encoding: [0x6a,0x04,0x22,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc_lo, vcc_hi, v2
// W32: encoding: [0x6b,0x04,0x22,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc_lo, ttmp15, v2
// W32: encoding: [0x7b,0x04,0x22,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc_lo, m0, v2
// W32: encoding: [0x7d,0x04,0x22,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc_lo, exec_lo, v2
// W32: encoding: [0x7e,0x04,0x22,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc_lo, exec_hi, v2
// W32: encoding: [0x7f,0x04,0x22,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc_lo, null, v2
// W32: encoding: [0x7c,0x04,0x22,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc_lo, -1, v2
// W32: encoding: [0xc1,0x04,0x22,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc_lo, 0.5, v2
// W32: encoding: [0xf0,0x04,0x22,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc_lo, src_scc, v2
// W32: encoding: [0xfd,0x04,0x22,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc_lo, 0xaf123456, v255
// W32: encoding: [0xff,0xfe,0x23,0x7c,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc, v1, v2
// W64: encoding: [0x01,0x05,0x22,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc, v255, v2
// W64: encoding: [0xff,0x05,0x22,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc, s1, v2
// W64: encoding: [0x01,0x04,0x22,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc, s105, v2
// W64: encoding: [0x69,0x04,0x22,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc, vcc_lo, v2
// W64: encoding: [0x6a,0x04,0x22,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc, vcc_hi, v2
// W64: encoding: [0x6b,0x04,0x22,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc, ttmp15, v2
// W64: encoding: [0x7b,0x04,0x22,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc, m0, v2
// W64: encoding: [0x7d,0x04,0x22,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc, exec_lo, v2
// W64: encoding: [0x7e,0x04,0x22,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc, exec_hi, v2
// W64: encoding: [0x7f,0x04,0x22,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc, null, v2
// W64: encoding: [0x7c,0x04,0x22,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc, -1, v2
// W64: encoding: [0xc1,0x04,0x22,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc, 0.5, v2
// W64: encoding: [0xf0,0x04,0x22,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc, src_scc, v2
// W64: encoding: [0xfd,0x04,0x22,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f32 vcc, 0xaf123456, v255
// W64: encoding: [0xff,0xfe,0x23,0x7c,0x56,0x34,0x12,0xaf]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f64 vcc_lo, v[1:2], v[2:3]
// W32: encoding: [0x01,0x05,0x42,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f64 vcc_lo, v[254:255], v[2:3]
// W32: encoding: [0xfe,0x05,0x42,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f64 vcc_lo, s[2:3], v[2:3]
// W32: encoding: [0x02,0x04,0x42,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f64 vcc_lo, s[104:105], v[2:3]
// W32: encoding: [0x68,0x04,0x42,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f64 vcc_lo, vcc, v[2:3]
// W32: encoding: [0x6a,0x04,0x42,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f64 vcc_lo, ttmp[14:15], v[2:3]
// W32: encoding: [0x7a,0x04,0x42,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f64 vcc_lo, exec, v[2:3]
// W32: encoding: [0x7e,0x04,0x42,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f64 vcc_lo, null, v[2:3]
// W32: encoding: [0x7c,0x04,0x42,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f64 vcc_lo, -1, v[2:3]
// W32: encoding: [0xc1,0x04,0x42,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f64 vcc_lo, 0.5, v[2:3]
// W32: encoding: [0xf0,0x04,0x42,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f64 vcc_lo, src_scc, v[2:3]
// W32: encoding: [0xfd,0x04,0x42,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f64 vcc_lo, 0xaf123456, v[254:255]
// W32: encoding: [0xff,0xfc,0x43,0x7c,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f64 vcc, v[1:2], v[2:3]
// W64: encoding: [0x01,0x05,0x42,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f64 vcc, v[254:255], v[2:3]
// W64: encoding: [0xfe,0x05,0x42,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f64 vcc, s[2:3], v[2:3]
// W64: encoding: [0x02,0x04,0x42,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f64 vcc, s[104:105], v[2:3]
// W64: encoding: [0x68,0x04,0x42,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f64 vcc, vcc, v[2:3]
// W64: encoding: [0x6a,0x04,0x42,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f64 vcc, ttmp[14:15], v[2:3]
// W64: encoding: [0x7a,0x04,0x42,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f64 vcc, exec, v[2:3]
// W64: encoding: [0x7e,0x04,0x42,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f64 vcc, null, v[2:3]
// W64: encoding: [0x7c,0x04,0x42,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f64 vcc, -1, v[2:3]
// W64: encoding: [0xc1,0x04,0x42,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f64 vcc, 0.5, v[2:3]
// W64: encoding: [0xf0,0x04,0x42,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f64 vcc, src_scc, v[2:3]
// W64: encoding: [0xfd,0x04,0x42,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_f64 vcc, 0xaf123456, v[254:255]
// W64: encoding: [0xff,0xfc,0x43,0x7c,0x56,0x34,0x12,0xaf]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc_lo, v1, v2
// W32: encoding: [0x01,0x05,0x62,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc_lo, v127, v2
// W32: encoding: [0x7f,0x05,0x62,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc_lo, s1, v2
// W32: encoding: [0x01,0x04,0x62,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc_lo, s105, v2
// W32: encoding: [0x69,0x04,0x62,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc_lo, vcc_lo, v2
// W32: encoding: [0x6a,0x04,0x62,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc_lo, vcc_hi, v2
// W32: encoding: [0x6b,0x04,0x62,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc_lo, ttmp15, v2
// W32: encoding: [0x7b,0x04,0x62,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc_lo, m0, v2
// W32: encoding: [0x7d,0x04,0x62,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc_lo, exec_lo, v2
// W32: encoding: [0x7e,0x04,0x62,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc_lo, exec_hi, v2
// W32: encoding: [0x7f,0x04,0x62,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc_lo, null, v2
// W32: encoding: [0x7c,0x04,0x62,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc_lo, -1, v2
// W32: encoding: [0xc1,0x04,0x62,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc_lo, 0.5, v2
// W32: encoding: [0xf0,0x04,0x62,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc_lo, src_scc, v2
// W32: encoding: [0xfd,0x04,0x62,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc_lo, 0xfe0b, v127
// W32: encoding: [0xff,0xfe,0x62,0x7c,0x0b,0xfe,0x00,0x00]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc, v1, v2
// W64: encoding: [0x01,0x05,0x62,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc, v127, v2
// W64: encoding: [0x7f,0x05,0x62,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc, s1, v2
// W64: encoding: [0x01,0x04,0x62,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc, s105, v2
// W64: encoding: [0x69,0x04,0x62,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc, vcc_lo, v2
// W64: encoding: [0x6a,0x04,0x62,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc, vcc_hi, v2
// W64: encoding: [0x6b,0x04,0x62,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc, ttmp15, v2
// W64: encoding: [0x7b,0x04,0x62,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc, m0, v2
// W64: encoding: [0x7d,0x04,0x62,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc, exec_lo, v2
// W64: encoding: [0x7e,0x04,0x62,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc, exec_hi, v2
// W64: encoding: [0x7f,0x04,0x62,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc, null, v2
// W64: encoding: [0x7c,0x04,0x62,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc, -1, v2
// W64: encoding: [0xc1,0x04,0x62,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc, 0.5, v2
// W64: encoding: [0xf0,0x04,0x62,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc, src_scc, v2
// W64: encoding: [0xfd,0x04,0x62,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i16 vcc, 0xfe0b, v127
// W64: encoding: [0xff,0xfe,0x62,0x7c,0x0b,0xfe,0x00,0x00]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc_lo, v1, v2
// W32: encoding: [0x01,0x05,0x82,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc_lo, v255, v2
// W32: encoding: [0xff,0x05,0x82,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc_lo, s1, v2
// W32: encoding: [0x01,0x04,0x82,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc_lo, s105, v2
// W32: encoding: [0x69,0x04,0x82,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc_lo, vcc_lo, v2
// W32: encoding: [0x6a,0x04,0x82,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc_lo, vcc_hi, v2
// W32: encoding: [0x6b,0x04,0x82,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc_lo, ttmp15, v2
// W32: encoding: [0x7b,0x04,0x82,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc_lo, m0, v2
// W32: encoding: [0x7d,0x04,0x82,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc_lo, exec_lo, v2
// W32: encoding: [0x7e,0x04,0x82,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc_lo, exec_hi, v2
// W32: encoding: [0x7f,0x04,0x82,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc_lo, null, v2
// W32: encoding: [0x7c,0x04,0x82,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc_lo, -1, v2
// W32: encoding: [0xc1,0x04,0x82,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc_lo, 0.5, v2
// W32: encoding: [0xf0,0x04,0x82,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc_lo, src_scc, v2
// W32: encoding: [0xfd,0x04,0x82,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc_lo, 0xaf123456, v255
// W32: encoding: [0xff,0xfe,0x83,0x7c,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc, v1, v2
// W64: encoding: [0x01,0x05,0x82,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc, v255, v2
// W64: encoding: [0xff,0x05,0x82,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc, s1, v2
// W64: encoding: [0x01,0x04,0x82,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc, s105, v2
// W64: encoding: [0x69,0x04,0x82,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc, vcc_lo, v2
// W64: encoding: [0x6a,0x04,0x82,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc, vcc_hi, v2
// W64: encoding: [0x6b,0x04,0x82,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc, ttmp15, v2
// W64: encoding: [0x7b,0x04,0x82,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc, m0, v2
// W64: encoding: [0x7d,0x04,0x82,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc, exec_lo, v2
// W64: encoding: [0x7e,0x04,0x82,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc, exec_hi, v2
// W64: encoding: [0x7f,0x04,0x82,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc, null, v2
// W64: encoding: [0x7c,0x04,0x82,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc, -1, v2
// W64: encoding: [0xc1,0x04,0x82,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc, 0.5, v2
// W64: encoding: [0xf0,0x04,0x82,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc, src_scc, v2
// W64: encoding: [0xfd,0x04,0x82,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i32 vcc, 0xaf123456, v255
// W64: encoding: [0xff,0xfe,0x83,0x7c,0x56,0x34,0x12,0xaf]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i64 vcc_lo, v[1:2], v[2:3]
// W32: encoding: [0x01,0x05,0xa2,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i64 vcc_lo, v[254:255], v[2:3]
// W32: encoding: [0xfe,0x05,0xa2,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i64 vcc_lo, s[2:3], v[2:3]
// W32: encoding: [0x02,0x04,0xa2,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i64 vcc_lo, s[104:105], v[2:3]
// W32: encoding: [0x68,0x04,0xa2,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i64 vcc_lo, vcc, v[2:3]
// W32: encoding: [0x6a,0x04,0xa2,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i64 vcc_lo, ttmp[14:15], v[2:3]
// W32: encoding: [0x7a,0x04,0xa2,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i64 vcc_lo, exec, v[2:3]
// W32: encoding: [0x7e,0x04,0xa2,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i64 vcc_lo, null, v[2:3]
// W32: encoding: [0x7c,0x04,0xa2,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i64 vcc_lo, -1, v[2:3]
// W32: encoding: [0xc1,0x04,0xa2,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i64 vcc_lo, 0.5, v[2:3]
// W32: encoding: [0xf0,0x04,0xa2,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i64 vcc_lo, src_scc, v[2:3]
// W32: encoding: [0xfd,0x04,0xa2,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i64 vcc_lo, 0xaf123456, v[254:255]
// W32: encoding: [0xff,0xfc,0xa3,0x7c,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i64 vcc, v[1:2], v[2:3]
// W64: encoding: [0x01,0x05,0xa2,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i64 vcc, v[254:255], v[2:3]
// W64: encoding: [0xfe,0x05,0xa2,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i64 vcc, s[2:3], v[2:3]
// W64: encoding: [0x02,0x04,0xa2,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i64 vcc, s[104:105], v[2:3]
// W64: encoding: [0x68,0x04,0xa2,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i64 vcc, vcc, v[2:3]
// W64: encoding: [0x6a,0x04,0xa2,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i64 vcc, ttmp[14:15], v[2:3]
// W64: encoding: [0x7a,0x04,0xa2,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i64 vcc, exec, v[2:3]
// W64: encoding: [0x7e,0x04,0xa2,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i64 vcc, null, v[2:3]
// W64: encoding: [0x7c,0x04,0xa2,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i64 vcc, -1, v[2:3]
// W64: encoding: [0xc1,0x04,0xa2,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i64 vcc, 0.5, v[2:3]
// W64: encoding: [0xf0,0x04,0xa2,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i64 vcc, src_scc, v[2:3]
// W64: encoding: [0xfd,0x04,0xa2,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_i64 vcc, 0xaf123456, v[254:255]
// W64: encoding: [0xff,0xfc,0xa3,0x7c,0x56,0x34,0x12,0xaf]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc_lo, v1, v2
// W32: encoding: [0x01,0x05,0x72,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc_lo, v127, v2
// W32: encoding: [0x7f,0x05,0x72,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc_lo, s1, v2
// W32: encoding: [0x01,0x04,0x72,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc_lo, s105, v2
// W32: encoding: [0x69,0x04,0x72,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc_lo, vcc_lo, v2
// W32: encoding: [0x6a,0x04,0x72,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc_lo, vcc_hi, v2
// W32: encoding: [0x6b,0x04,0x72,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc_lo, ttmp15, v2
// W32: encoding: [0x7b,0x04,0x72,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc_lo, m0, v2
// W32: encoding: [0x7d,0x04,0x72,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc_lo, exec_lo, v2
// W32: encoding: [0x7e,0x04,0x72,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc_lo, exec_hi, v2
// W32: encoding: [0x7f,0x04,0x72,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc_lo, null, v2
// W32: encoding: [0x7c,0x04,0x72,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc_lo, -1, v2
// W32: encoding: [0xc1,0x04,0x72,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc_lo, 0.5, v2
// W32: encoding: [0xf0,0x04,0x72,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc_lo, src_scc, v2
// W32: encoding: [0xfd,0x04,0x72,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc_lo, 0xfe0b, v127
// W32: encoding: [0xff,0xfe,0x72,0x7c,0x0b,0xfe,0x00,0x00]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc, v1, v2
// W64: encoding: [0x01,0x05,0x72,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc, v127, v2
// W64: encoding: [0x7f,0x05,0x72,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc, s1, v2
// W64: encoding: [0x01,0x04,0x72,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc, s105, v2
// W64: encoding: [0x69,0x04,0x72,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc, vcc_lo, v2
// W64: encoding: [0x6a,0x04,0x72,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc, vcc_hi, v2
// W64: encoding: [0x6b,0x04,0x72,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc, ttmp15, v2
// W64: encoding: [0x7b,0x04,0x72,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc, m0, v2
// W64: encoding: [0x7d,0x04,0x72,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc, exec_lo, v2
// W64: encoding: [0x7e,0x04,0x72,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc, exec_hi, v2
// W64: encoding: [0x7f,0x04,0x72,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc, null, v2
// W64: encoding: [0x7c,0x04,0x72,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc, -1, v2
// W64: encoding: [0xc1,0x04,0x72,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc, 0.5, v2
// W64: encoding: [0xf0,0x04,0x72,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc, src_scc, v2
// W64: encoding: [0xfd,0x04,0x72,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u16 vcc, 0xfe0b, v127
// W64: encoding: [0xff,0xfe,0x72,0x7c,0x0b,0xfe,0x00,0x00]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc_lo, v1, v2
// W32: encoding: [0x01,0x05,0x92,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc_lo, v255, v2
// W32: encoding: [0xff,0x05,0x92,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc_lo, s1, v2
// W32: encoding: [0x01,0x04,0x92,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc_lo, s105, v2
// W32: encoding: [0x69,0x04,0x92,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc_lo, vcc_lo, v2
// W32: encoding: [0x6a,0x04,0x92,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc_lo, vcc_hi, v2
// W32: encoding: [0x6b,0x04,0x92,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc_lo, ttmp15, v2
// W32: encoding: [0x7b,0x04,0x92,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc_lo, m0, v2
// W32: encoding: [0x7d,0x04,0x92,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc_lo, exec_lo, v2
// W32: encoding: [0x7e,0x04,0x92,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc_lo, exec_hi, v2
// W32: encoding: [0x7f,0x04,0x92,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc_lo, null, v2
// W32: encoding: [0x7c,0x04,0x92,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc_lo, -1, v2
// W32: encoding: [0xc1,0x04,0x92,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc_lo, 0.5, v2
// W32: encoding: [0xf0,0x04,0x92,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc_lo, src_scc, v2
// W32: encoding: [0xfd,0x04,0x92,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc_lo, 0xaf123456, v255
// W32: encoding: [0xff,0xfe,0x93,0x7c,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc, v1, v2
// W64: encoding: [0x01,0x05,0x92,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc, v255, v2
// W64: encoding: [0xff,0x05,0x92,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc, s1, v2
// W64: encoding: [0x01,0x04,0x92,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc, s105, v2
// W64: encoding: [0x69,0x04,0x92,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc, vcc_lo, v2
// W64: encoding: [0x6a,0x04,0x92,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc, vcc_hi, v2
// W64: encoding: [0x6b,0x04,0x92,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc, ttmp15, v2
// W64: encoding: [0x7b,0x04,0x92,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc, m0, v2
// W64: encoding: [0x7d,0x04,0x92,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc, exec_lo, v2
// W64: encoding: [0x7e,0x04,0x92,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc, exec_hi, v2
// W64: encoding: [0x7f,0x04,0x92,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc, null, v2
// W64: encoding: [0x7c,0x04,0x92,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc, -1, v2
// W64: encoding: [0xc1,0x04,0x92,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc, 0.5, v2
// W64: encoding: [0xf0,0x04,0x92,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc, src_scc, v2
// W64: encoding: [0xfd,0x04,0x92,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u32 vcc, 0xaf123456, v255
// W64: encoding: [0xff,0xfe,0x93,0x7c,0x56,0x34,0x12,0xaf]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u64 vcc_lo, v[1:2], v[2:3]
// W32: encoding: [0x01,0x05,0xb2,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u64 vcc_lo, v[254:255], v[2:3]
// W32: encoding: [0xfe,0x05,0xb2,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u64 vcc_lo, s[2:3], v[2:3]
// W32: encoding: [0x02,0x04,0xb2,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u64 vcc_lo, s[104:105], v[2:3]
// W32: encoding: [0x68,0x04,0xb2,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u64 vcc_lo, vcc, v[2:3]
// W32: encoding: [0x6a,0x04,0xb2,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u64 vcc_lo, ttmp[14:15], v[2:3]
// W32: encoding: [0x7a,0x04,0xb2,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u64 vcc_lo, exec, v[2:3]
// W32: encoding: [0x7e,0x04,0xb2,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u64 vcc_lo, null, v[2:3]
// W32: encoding: [0x7c,0x04,0xb2,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u64 vcc_lo, -1, v[2:3]
// W32: encoding: [0xc1,0x04,0xb2,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u64 vcc_lo, 0.5, v[2:3]
// W32: encoding: [0xf0,0x04,0xb2,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u64 vcc_lo, src_scc, v[2:3]
// W32: encoding: [0xfd,0x04,0xb2,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u64 vcc_lo, 0xaf123456, v[254:255]
// W32: encoding: [0xff,0xfc,0xb3,0x7c,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u64 vcc, v[1:2], v[2:3]
// W64: encoding: [0x01,0x05,0xb2,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u64 vcc, v[254:255], v[2:3]
// W64: encoding: [0xfe,0x05,0xb2,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u64 vcc, s[2:3], v[2:3]
// W64: encoding: [0x02,0x04,0xb2,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u64 vcc, s[104:105], v[2:3]
// W64: encoding: [0x68,0x04,0xb2,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u64 vcc, vcc, v[2:3]
// W64: encoding: [0x6a,0x04,0xb2,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u64 vcc, ttmp[14:15], v[2:3]
// W64: encoding: [0x7a,0x04,0xb2,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u64 vcc, exec, v[2:3]
// W64: encoding: [0x7e,0x04,0xb2,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u64 vcc, null, v[2:3]
// W64: encoding: [0x7c,0x04,0xb2,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u64 vcc, -1, v[2:3]
// W64: encoding: [0xc1,0x04,0xb2,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u64 vcc, 0.5, v[2:3]
// W64: encoding: [0xf0,0x04,0xb2,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u64 vcc, src_scc, v[2:3]
// W64: encoding: [0xfd,0x04,0xb2,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_lt_u64 vcc, 0xaf123456, v[254:255]
// W64: encoding: [0xff,0xfc,0xb3,0x7c,0x56,0x34,0x12,0xaf]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc_lo, v1, v2
// W32: encoding: [0x01,0x05,0x6a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc_lo, v127, v2
// W32: encoding: [0x7f,0x05,0x6a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc_lo, s1, v2
// W32: encoding: [0x01,0x04,0x6a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc_lo, s105, v2
// W32: encoding: [0x69,0x04,0x6a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc_lo, vcc_lo, v2
// W32: encoding: [0x6a,0x04,0x6a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc_lo, vcc_hi, v2
// W32: encoding: [0x6b,0x04,0x6a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc_lo, ttmp15, v2
// W32: encoding: [0x7b,0x04,0x6a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc_lo, m0, v2
// W32: encoding: [0x7d,0x04,0x6a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc_lo, exec_lo, v2
// W32: encoding: [0x7e,0x04,0x6a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc_lo, exec_hi, v2
// W32: encoding: [0x7f,0x04,0x6a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc_lo, null, v2
// W32: encoding: [0x7c,0x04,0x6a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc_lo, -1, v2
// W32: encoding: [0xc1,0x04,0x6a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc_lo, 0.5, v2
// W32: encoding: [0xf0,0x04,0x6a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc_lo, src_scc, v2
// W32: encoding: [0xfd,0x04,0x6a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc_lo, 0xfe0b, v127
// W32: encoding: [0xff,0xfe,0x6a,0x7c,0x0b,0xfe,0x00,0x00]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc, v1, v2
// W64: encoding: [0x01,0x05,0x6a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc, v127, v2
// W64: encoding: [0x7f,0x05,0x6a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc, s1, v2
// W64: encoding: [0x01,0x04,0x6a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc, s105, v2
// W64: encoding: [0x69,0x04,0x6a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc, vcc_lo, v2
// W64: encoding: [0x6a,0x04,0x6a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc, vcc_hi, v2
// W64: encoding: [0x6b,0x04,0x6a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc, ttmp15, v2
// W64: encoding: [0x7b,0x04,0x6a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc, m0, v2
// W64: encoding: [0x7d,0x04,0x6a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc, exec_lo, v2
// W64: encoding: [0x7e,0x04,0x6a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc, exec_hi, v2
// W64: encoding: [0x7f,0x04,0x6a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc, null, v2
// W64: encoding: [0x7c,0x04,0x6a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc, -1, v2
// W64: encoding: [0xc1,0x04,0x6a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc, 0.5, v2
// W64: encoding: [0xf0,0x04,0x6a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc, src_scc, v2
// W64: encoding: [0xfd,0x04,0x6a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i16 vcc, 0xfe0b, v127
// W64: encoding: [0xff,0xfe,0x6a,0x7c,0x0b,0xfe,0x00,0x00]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc_lo, v1, v2
// W32: encoding: [0x01,0x05,0x8a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc_lo, v255, v2
// W32: encoding: [0xff,0x05,0x8a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc_lo, s1, v2
// W32: encoding: [0x01,0x04,0x8a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc_lo, s105, v2
// W32: encoding: [0x69,0x04,0x8a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc_lo, vcc_lo, v2
// W32: encoding: [0x6a,0x04,0x8a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc_lo, vcc_hi, v2
// W32: encoding: [0x6b,0x04,0x8a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc_lo, ttmp15, v2
// W32: encoding: [0x7b,0x04,0x8a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc_lo, m0, v2
// W32: encoding: [0x7d,0x04,0x8a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc_lo, exec_lo, v2
// W32: encoding: [0x7e,0x04,0x8a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc_lo, exec_hi, v2
// W32: encoding: [0x7f,0x04,0x8a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc_lo, null, v2
// W32: encoding: [0x7c,0x04,0x8a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc_lo, -1, v2
// W32: encoding: [0xc1,0x04,0x8a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc_lo, 0.5, v2
// W32: encoding: [0xf0,0x04,0x8a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc_lo, src_scc, v2
// W32: encoding: [0xfd,0x04,0x8a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc_lo, 0xaf123456, v255
// W32: encoding: [0xff,0xfe,0x8b,0x7c,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc, v1, v2
// W64: encoding: [0x01,0x05,0x8a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc, v255, v2
// W64: encoding: [0xff,0x05,0x8a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc, s1, v2
// W64: encoding: [0x01,0x04,0x8a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc, s105, v2
// W64: encoding: [0x69,0x04,0x8a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc, vcc_lo, v2
// W64: encoding: [0x6a,0x04,0x8a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc, vcc_hi, v2
// W64: encoding: [0x6b,0x04,0x8a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc, ttmp15, v2
// W64: encoding: [0x7b,0x04,0x8a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc, m0, v2
// W64: encoding: [0x7d,0x04,0x8a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc, exec_lo, v2
// W64: encoding: [0x7e,0x04,0x8a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc, exec_hi, v2
// W64: encoding: [0x7f,0x04,0x8a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc, null, v2
// W64: encoding: [0x7c,0x04,0x8a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc, -1, v2
// W64: encoding: [0xc1,0x04,0x8a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc, 0.5, v2
// W64: encoding: [0xf0,0x04,0x8a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc, src_scc, v2
// W64: encoding: [0xfd,0x04,0x8a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i32 vcc, 0xaf123456, v255
// W64: encoding: [0xff,0xfe,0x8b,0x7c,0x56,0x34,0x12,0xaf]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i64 vcc_lo, v[1:2], v[2:3]
// W32: encoding: [0x01,0x05,0xaa,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i64 vcc_lo, v[254:255], v[2:3]
// W32: encoding: [0xfe,0x05,0xaa,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i64 vcc_lo, s[2:3], v[2:3]
// W32: encoding: [0x02,0x04,0xaa,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i64 vcc_lo, s[104:105], v[2:3]
// W32: encoding: [0x68,0x04,0xaa,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i64 vcc_lo, vcc, v[2:3]
// W32: encoding: [0x6a,0x04,0xaa,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i64 vcc_lo, ttmp[14:15], v[2:3]
// W32: encoding: [0x7a,0x04,0xaa,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i64 vcc_lo, exec, v[2:3]
// W32: encoding: [0x7e,0x04,0xaa,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i64 vcc_lo, null, v[2:3]
// W32: encoding: [0x7c,0x04,0xaa,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i64 vcc_lo, -1, v[2:3]
// W32: encoding: [0xc1,0x04,0xaa,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i64 vcc_lo, 0.5, v[2:3]
// W32: encoding: [0xf0,0x04,0xaa,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i64 vcc_lo, src_scc, v[2:3]
// W32: encoding: [0xfd,0x04,0xaa,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i64 vcc_lo, 0xaf123456, v[254:255]
// W32: encoding: [0xff,0xfc,0xab,0x7c,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i64 vcc, v[1:2], v[2:3]
// W64: encoding: [0x01,0x05,0xaa,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i64 vcc, v[254:255], v[2:3]
// W64: encoding: [0xfe,0x05,0xaa,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i64 vcc, s[2:3], v[2:3]
// W64: encoding: [0x02,0x04,0xaa,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i64 vcc, s[104:105], v[2:3]
// W64: encoding: [0x68,0x04,0xaa,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i64 vcc, vcc, v[2:3]
// W64: encoding: [0x6a,0x04,0xaa,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i64 vcc, ttmp[14:15], v[2:3]
// W64: encoding: [0x7a,0x04,0xaa,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i64 vcc, exec, v[2:3]
// W64: encoding: [0x7e,0x04,0xaa,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i64 vcc, null, v[2:3]
// W64: encoding: [0x7c,0x04,0xaa,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i64 vcc, -1, v[2:3]
// W64: encoding: [0xc1,0x04,0xaa,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i64 vcc, 0.5, v[2:3]
// W64: encoding: [0xf0,0x04,0xaa,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i64 vcc, src_scc, v[2:3]
// W64: encoding: [0xfd,0x04,0xaa,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_i64 vcc, 0xaf123456, v[254:255]
// W64: encoding: [0xff,0xfc,0xab,0x7c,0x56,0x34,0x12,0xaf]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc_lo, v1, v2
// W32: encoding: [0x01,0x05,0x7a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc_lo, v127, v2
// W32: encoding: [0x7f,0x05,0x7a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc_lo, s1, v2
// W32: encoding: [0x01,0x04,0x7a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc_lo, s105, v2
// W32: encoding: [0x69,0x04,0x7a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc_lo, vcc_lo, v2
// W32: encoding: [0x6a,0x04,0x7a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc_lo, vcc_hi, v2
// W32: encoding: [0x6b,0x04,0x7a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc_lo, ttmp15, v2
// W32: encoding: [0x7b,0x04,0x7a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc_lo, m0, v2
// W32: encoding: [0x7d,0x04,0x7a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc_lo, exec_lo, v2
// W32: encoding: [0x7e,0x04,0x7a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc_lo, exec_hi, v2
// W32: encoding: [0x7f,0x04,0x7a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc_lo, null, v2
// W32: encoding: [0x7c,0x04,0x7a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc_lo, -1, v2
// W32: encoding: [0xc1,0x04,0x7a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc_lo, 0.5, v2
// W32: encoding: [0xf0,0x04,0x7a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc_lo, src_scc, v2
// W32: encoding: [0xfd,0x04,0x7a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc_lo, 0xfe0b, v127
// W32: encoding: [0xff,0xfe,0x7a,0x7c,0x0b,0xfe,0x00,0x00]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc, v1, v2
// W64: encoding: [0x01,0x05,0x7a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc, v127, v2
// W64: encoding: [0x7f,0x05,0x7a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc, s1, v2
// W64: encoding: [0x01,0x04,0x7a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc, s105, v2
// W64: encoding: [0x69,0x04,0x7a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc, vcc_lo, v2
// W64: encoding: [0x6a,0x04,0x7a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc, vcc_hi, v2
// W64: encoding: [0x6b,0x04,0x7a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc, ttmp15, v2
// W64: encoding: [0x7b,0x04,0x7a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc, m0, v2
// W64: encoding: [0x7d,0x04,0x7a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc, exec_lo, v2
// W64: encoding: [0x7e,0x04,0x7a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc, exec_hi, v2
// W64: encoding: [0x7f,0x04,0x7a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc, null, v2
// W64: encoding: [0x7c,0x04,0x7a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc, -1, v2
// W64: encoding: [0xc1,0x04,0x7a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc, 0.5, v2
// W64: encoding: [0xf0,0x04,0x7a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc, src_scc, v2
// W64: encoding: [0xfd,0x04,0x7a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u16 vcc, 0xfe0b, v127
// W64: encoding: [0xff,0xfe,0x7a,0x7c,0x0b,0xfe,0x00,0x00]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc_lo, v1, v2
// W32: encoding: [0x01,0x05,0x9a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc_lo, v255, v2
// W32: encoding: [0xff,0x05,0x9a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc_lo, s1, v2
// W32: encoding: [0x01,0x04,0x9a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc_lo, s105, v2
// W32: encoding: [0x69,0x04,0x9a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc_lo, vcc_lo, v2
// W32: encoding: [0x6a,0x04,0x9a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc_lo, vcc_hi, v2
// W32: encoding: [0x6b,0x04,0x9a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc_lo, ttmp15, v2
// W32: encoding: [0x7b,0x04,0x9a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc_lo, m0, v2
// W32: encoding: [0x7d,0x04,0x9a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc_lo, exec_lo, v2
// W32: encoding: [0x7e,0x04,0x9a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc_lo, exec_hi, v2
// W32: encoding: [0x7f,0x04,0x9a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc_lo, null, v2
// W32: encoding: [0x7c,0x04,0x9a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc_lo, -1, v2
// W32: encoding: [0xc1,0x04,0x9a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc_lo, 0.5, v2
// W32: encoding: [0xf0,0x04,0x9a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc_lo, src_scc, v2
// W32: encoding: [0xfd,0x04,0x9a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc_lo, 0xaf123456, v255
// W32: encoding: [0xff,0xfe,0x9b,0x7c,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc, v1, v2
// W64: encoding: [0x01,0x05,0x9a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc, v255, v2
// W64: encoding: [0xff,0x05,0x9a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc, s1, v2
// W64: encoding: [0x01,0x04,0x9a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc, s105, v2
// W64: encoding: [0x69,0x04,0x9a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc, vcc_lo, v2
// W64: encoding: [0x6a,0x04,0x9a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc, vcc_hi, v2
// W64: encoding: [0x6b,0x04,0x9a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc, ttmp15, v2
// W64: encoding: [0x7b,0x04,0x9a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc, m0, v2
// W64: encoding: [0x7d,0x04,0x9a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc, exec_lo, v2
// W64: encoding: [0x7e,0x04,0x9a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc, exec_hi, v2
// W64: encoding: [0x7f,0x04,0x9a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc, null, v2
// W64: encoding: [0x7c,0x04,0x9a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc, -1, v2
// W64: encoding: [0xc1,0x04,0x9a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc, 0.5, v2
// W64: encoding: [0xf0,0x04,0x9a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc, src_scc, v2
// W64: encoding: [0xfd,0x04,0x9a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u32 vcc, 0xaf123456, v255
// W64: encoding: [0xff,0xfe,0x9b,0x7c,0x56,0x34,0x12,0xaf]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u64 vcc_lo, v[1:2], v[2:3]
// W32: encoding: [0x01,0x05,0xba,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u64 vcc_lo, v[254:255], v[2:3]
// W32: encoding: [0xfe,0x05,0xba,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u64 vcc_lo, s[2:3], v[2:3]
// W32: encoding: [0x02,0x04,0xba,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u64 vcc_lo, s[104:105], v[2:3]
// W32: encoding: [0x68,0x04,0xba,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u64 vcc_lo, vcc, v[2:3]
// W32: encoding: [0x6a,0x04,0xba,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u64 vcc_lo, ttmp[14:15], v[2:3]
// W32: encoding: [0x7a,0x04,0xba,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u64 vcc_lo, exec, v[2:3]
// W32: encoding: [0x7e,0x04,0xba,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u64 vcc_lo, null, v[2:3]
// W32: encoding: [0x7c,0x04,0xba,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u64 vcc_lo, -1, v[2:3]
// W32: encoding: [0xc1,0x04,0xba,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u64 vcc_lo, 0.5, v[2:3]
// W32: encoding: [0xf0,0x04,0xba,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u64 vcc_lo, src_scc, v[2:3]
// W32: encoding: [0xfd,0x04,0xba,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u64 vcc_lo, 0xaf123456, v[254:255]
// W32: encoding: [0xff,0xfc,0xbb,0x7c,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u64 vcc, v[1:2], v[2:3]
// W64: encoding: [0x01,0x05,0xba,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u64 vcc, v[254:255], v[2:3]
// W64: encoding: [0xfe,0x05,0xba,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u64 vcc, s[2:3], v[2:3]
// W64: encoding: [0x02,0x04,0xba,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u64 vcc, s[104:105], v[2:3]
// W64: encoding: [0x68,0x04,0xba,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u64 vcc, vcc, v[2:3]
// W64: encoding: [0x6a,0x04,0xba,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u64 vcc, ttmp[14:15], v[2:3]
// W64: encoding: [0x7a,0x04,0xba,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u64 vcc, exec, v[2:3]
// W64: encoding: [0x7e,0x04,0xba,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u64 vcc, null, v[2:3]
// W64: encoding: [0x7c,0x04,0xba,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u64 vcc, -1, v[2:3]
// W64: encoding: [0xc1,0x04,0xba,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u64 vcc, 0.5, v[2:3]
// W64: encoding: [0xf0,0x04,0xba,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u64 vcc, src_scc, v[2:3]
// W64: encoding: [0xfd,0x04,0xba,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ne_u64 vcc, 0xaf123456, v[254:255]
// W64: encoding: [0xff,0xfc,0xbb,0x7c,0x56,0x34,0x12,0xaf]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc_lo, v1, v2
// W32: encoding: [0x01,0x05,0x1a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc_lo, v127, v2
// W32: encoding: [0x7f,0x05,0x1a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc_lo, s1, v2
// W32: encoding: [0x01,0x04,0x1a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc_lo, s105, v2
// W32: encoding: [0x69,0x04,0x1a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc_lo, vcc_lo, v2
// W32: encoding: [0x6a,0x04,0x1a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc_lo, vcc_hi, v2
// W32: encoding: [0x6b,0x04,0x1a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc_lo, ttmp15, v2
// W32: encoding: [0x7b,0x04,0x1a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc_lo, m0, v2
// W32: encoding: [0x7d,0x04,0x1a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc_lo, exec_lo, v2
// W32: encoding: [0x7e,0x04,0x1a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc_lo, exec_hi, v2
// W32: encoding: [0x7f,0x04,0x1a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc_lo, null, v2
// W32: encoding: [0x7c,0x04,0x1a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc_lo, -1, v2
// W32: encoding: [0xc1,0x04,0x1a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc_lo, 0.5, v2
// W32: encoding: [0xf0,0x04,0x1a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc_lo, src_scc, v2
// W32: encoding: [0xfd,0x04,0x1a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc_lo, 0xfe0b, v127
// W32: encoding: [0xff,0xfe,0x1a,0x7c,0x0b,0xfe,0x00,0x00]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc, v1, v2
// W64: encoding: [0x01,0x05,0x1a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc, v127, v2
// W64: encoding: [0x7f,0x05,0x1a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc, s1, v2
// W64: encoding: [0x01,0x04,0x1a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc, s105, v2
// W64: encoding: [0x69,0x04,0x1a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc, vcc_lo, v2
// W64: encoding: [0x6a,0x04,0x1a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc, vcc_hi, v2
// W64: encoding: [0x6b,0x04,0x1a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc, ttmp15, v2
// W64: encoding: [0x7b,0x04,0x1a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc, m0, v2
// W64: encoding: [0x7d,0x04,0x1a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc, exec_lo, v2
// W64: encoding: [0x7e,0x04,0x1a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc, exec_hi, v2
// W64: encoding: [0x7f,0x04,0x1a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc, null, v2
// W64: encoding: [0x7c,0x04,0x1a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc, -1, v2
// W64: encoding: [0xc1,0x04,0x1a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc, 0.5, v2
// W64: encoding: [0xf0,0x04,0x1a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc, src_scc, v2
// W64: encoding: [0xfd,0x04,0x1a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f16 vcc, 0xfe0b, v127
// W64: encoding: [0xff,0xfe,0x1a,0x7c,0x0b,0xfe,0x00,0x00]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc_lo, v1, v2
// W32: encoding: [0x01,0x05,0x3a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc_lo, v255, v2
// W32: encoding: [0xff,0x05,0x3a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc_lo, s1, v2
// W32: encoding: [0x01,0x04,0x3a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc_lo, s105, v2
// W32: encoding: [0x69,0x04,0x3a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc_lo, vcc_lo, v2
// W32: encoding: [0x6a,0x04,0x3a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc_lo, vcc_hi, v2
// W32: encoding: [0x6b,0x04,0x3a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc_lo, ttmp15, v2
// W32: encoding: [0x7b,0x04,0x3a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc_lo, m0, v2
// W32: encoding: [0x7d,0x04,0x3a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc_lo, exec_lo, v2
// W32: encoding: [0x7e,0x04,0x3a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc_lo, exec_hi, v2
// W32: encoding: [0x7f,0x04,0x3a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc_lo, null, v2
// W32: encoding: [0x7c,0x04,0x3a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc_lo, -1, v2
// W32: encoding: [0xc1,0x04,0x3a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc_lo, 0.5, v2
// W32: encoding: [0xf0,0x04,0x3a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc_lo, src_scc, v2
// W32: encoding: [0xfd,0x04,0x3a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc_lo, 0xaf123456, v255
// W32: encoding: [0xff,0xfe,0x3b,0x7c,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc, v1, v2
// W64: encoding: [0x01,0x05,0x3a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc, v255, v2
// W64: encoding: [0xff,0x05,0x3a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc, s1, v2
// W64: encoding: [0x01,0x04,0x3a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc, s105, v2
// W64: encoding: [0x69,0x04,0x3a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc, vcc_lo, v2
// W64: encoding: [0x6a,0x04,0x3a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc, vcc_hi, v2
// W64: encoding: [0x6b,0x04,0x3a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc, ttmp15, v2
// W64: encoding: [0x7b,0x04,0x3a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc, m0, v2
// W64: encoding: [0x7d,0x04,0x3a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc, exec_lo, v2
// W64: encoding: [0x7e,0x04,0x3a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc, exec_hi, v2
// W64: encoding: [0x7f,0x04,0x3a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc, null, v2
// W64: encoding: [0x7c,0x04,0x3a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc, -1, v2
// W64: encoding: [0xc1,0x04,0x3a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc, 0.5, v2
// W64: encoding: [0xf0,0x04,0x3a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc, src_scc, v2
// W64: encoding: [0xfd,0x04,0x3a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f32 vcc, 0xaf123456, v255
// W64: encoding: [0xff,0xfe,0x3b,0x7c,0x56,0x34,0x12,0xaf]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f64 vcc_lo, v[1:2], v[2:3]
// W32: encoding: [0x01,0x05,0x5a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f64 vcc_lo, v[254:255], v[2:3]
// W32: encoding: [0xfe,0x05,0x5a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f64 vcc_lo, s[2:3], v[2:3]
// W32: encoding: [0x02,0x04,0x5a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f64 vcc_lo, s[104:105], v[2:3]
// W32: encoding: [0x68,0x04,0x5a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f64 vcc_lo, vcc, v[2:3]
// W32: encoding: [0x6a,0x04,0x5a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f64 vcc_lo, ttmp[14:15], v[2:3]
// W32: encoding: [0x7a,0x04,0x5a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f64 vcc_lo, exec, v[2:3]
// W32: encoding: [0x7e,0x04,0x5a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f64 vcc_lo, null, v[2:3]
// W32: encoding: [0x7c,0x04,0x5a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f64 vcc_lo, -1, v[2:3]
// W32: encoding: [0xc1,0x04,0x5a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f64 vcc_lo, 0.5, v[2:3]
// W32: encoding: [0xf0,0x04,0x5a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f64 vcc_lo, src_scc, v[2:3]
// W32: encoding: [0xfd,0x04,0x5a,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f64 vcc_lo, 0xaf123456, v[254:255]
// W32: encoding: [0xff,0xfc,0x5b,0x7c,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f64 vcc, v[1:2], v[2:3]
// W64: encoding: [0x01,0x05,0x5a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f64 vcc, v[254:255], v[2:3]
// W64: encoding: [0xfe,0x05,0x5a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f64 vcc, s[2:3], v[2:3]
// W64: encoding: [0x02,0x04,0x5a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f64 vcc, s[104:105], v[2:3]
// W64: encoding: [0x68,0x04,0x5a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f64 vcc, vcc, v[2:3]
// W64: encoding: [0x6a,0x04,0x5a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f64 vcc, ttmp[14:15], v[2:3]
// W64: encoding: [0x7a,0x04,0x5a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f64 vcc, exec, v[2:3]
// W64: encoding: [0x7e,0x04,0x5a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f64 vcc, null, v[2:3]
// W64: encoding: [0x7c,0x04,0x5a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f64 vcc, -1, v[2:3]
// W64: encoding: [0xc1,0x04,0x5a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f64 vcc, 0.5, v[2:3]
// W64: encoding: [0xf0,0x04,0x5a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f64 vcc, src_scc, v[2:3]
// W64: encoding: [0xfd,0x04,0x5a,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_neq_f64 vcc, 0xaf123456, v[254:255]
// W64: encoding: [0xff,0xfc,0x5b,0x7c,0x56,0x34,0x12,0xaf]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc_lo, v1, v2
// W32: encoding: [0x01,0x05,0x12,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc_lo, v127, v2
// W32: encoding: [0x7f,0x05,0x12,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc_lo, s1, v2
// W32: encoding: [0x01,0x04,0x12,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc_lo, s105, v2
// W32: encoding: [0x69,0x04,0x12,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc_lo, vcc_lo, v2
// W32: encoding: [0x6a,0x04,0x12,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc_lo, vcc_hi, v2
// W32: encoding: [0x6b,0x04,0x12,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc_lo, ttmp15, v2
// W32: encoding: [0x7b,0x04,0x12,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc_lo, m0, v2
// W32: encoding: [0x7d,0x04,0x12,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc_lo, exec_lo, v2
// W32: encoding: [0x7e,0x04,0x12,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc_lo, exec_hi, v2
// W32: encoding: [0x7f,0x04,0x12,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc_lo, null, v2
// W32: encoding: [0x7c,0x04,0x12,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc_lo, -1, v2
// W32: encoding: [0xc1,0x04,0x12,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc_lo, 0.5, v2
// W32: encoding: [0xf0,0x04,0x12,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc_lo, src_scc, v2
// W32: encoding: [0xfd,0x04,0x12,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc_lo, 0xfe0b, v127
// W32: encoding: [0xff,0xfe,0x12,0x7c,0x0b,0xfe,0x00,0x00]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc, v1, v2
// W64: encoding: [0x01,0x05,0x12,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc, v127, v2
// W64: encoding: [0x7f,0x05,0x12,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc, s1, v2
// W64: encoding: [0x01,0x04,0x12,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc, s105, v2
// W64: encoding: [0x69,0x04,0x12,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc, vcc_lo, v2
// W64: encoding: [0x6a,0x04,0x12,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc, vcc_hi, v2
// W64: encoding: [0x6b,0x04,0x12,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc, ttmp15, v2
// W64: encoding: [0x7b,0x04,0x12,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc, m0, v2
// W64: encoding: [0x7d,0x04,0x12,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc, exec_lo, v2
// W64: encoding: [0x7e,0x04,0x12,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc, exec_hi, v2
// W64: encoding: [0x7f,0x04,0x12,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc, null, v2
// W64: encoding: [0x7c,0x04,0x12,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc, -1, v2
// W64: encoding: [0xc1,0x04,0x12,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc, 0.5, v2
// W64: encoding: [0xf0,0x04,0x12,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc, src_scc, v2
// W64: encoding: [0xfd,0x04,0x12,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f16 vcc, 0xfe0b, v127
// W64: encoding: [0xff,0xfe,0x12,0x7c,0x0b,0xfe,0x00,0x00]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc_lo, v1, v2
// W32: encoding: [0x01,0x05,0x32,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc_lo, v255, v2
// W32: encoding: [0xff,0x05,0x32,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc_lo, s1, v2
// W32: encoding: [0x01,0x04,0x32,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc_lo, s105, v2
// W32: encoding: [0x69,0x04,0x32,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc_lo, vcc_lo, v2
// W32: encoding: [0x6a,0x04,0x32,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc_lo, vcc_hi, v2
// W32: encoding: [0x6b,0x04,0x32,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc_lo, ttmp15, v2
// W32: encoding: [0x7b,0x04,0x32,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc_lo, m0, v2
// W32: encoding: [0x7d,0x04,0x32,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc_lo, exec_lo, v2
// W32: encoding: [0x7e,0x04,0x32,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc_lo, exec_hi, v2
// W32: encoding: [0x7f,0x04,0x32,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc_lo, null, v2
// W32: encoding: [0x7c,0x04,0x32,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc_lo, -1, v2
// W32: encoding: [0xc1,0x04,0x32,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc_lo, 0.5, v2
// W32: encoding: [0xf0,0x04,0x32,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc_lo, src_scc, v2
// W32: encoding: [0xfd,0x04,0x32,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc_lo, 0xaf123456, v255
// W32: encoding: [0xff,0xfe,0x33,0x7c,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc, v1, v2
// W64: encoding: [0x01,0x05,0x32,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc, v255, v2
// W64: encoding: [0xff,0x05,0x32,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc, s1, v2
// W64: encoding: [0x01,0x04,0x32,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc, s105, v2
// W64: encoding: [0x69,0x04,0x32,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc, vcc_lo, v2
// W64: encoding: [0x6a,0x04,0x32,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc, vcc_hi, v2
// W64: encoding: [0x6b,0x04,0x32,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc, ttmp15, v2
// W64: encoding: [0x7b,0x04,0x32,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc, m0, v2
// W64: encoding: [0x7d,0x04,0x32,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc, exec_lo, v2
// W64: encoding: [0x7e,0x04,0x32,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc, exec_hi, v2
// W64: encoding: [0x7f,0x04,0x32,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc, null, v2
// W64: encoding: [0x7c,0x04,0x32,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc, -1, v2
// W64: encoding: [0xc1,0x04,0x32,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc, 0.5, v2
// W64: encoding: [0xf0,0x04,0x32,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc, src_scc, v2
// W64: encoding: [0xfd,0x04,0x32,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f32 vcc, 0xaf123456, v255
// W64: encoding: [0xff,0xfe,0x33,0x7c,0x56,0x34,0x12,0xaf]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f64 vcc_lo, v[1:2], v[2:3]
// W32: encoding: [0x01,0x05,0x52,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f64 vcc_lo, v[254:255], v[2:3]
// W32: encoding: [0xfe,0x05,0x52,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f64 vcc_lo, s[2:3], v[2:3]
// W32: encoding: [0x02,0x04,0x52,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f64 vcc_lo, s[104:105], v[2:3]
// W32: encoding: [0x68,0x04,0x52,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f64 vcc_lo, vcc, v[2:3]
// W32: encoding: [0x6a,0x04,0x52,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f64 vcc_lo, ttmp[14:15], v[2:3]
// W32: encoding: [0x7a,0x04,0x52,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f64 vcc_lo, exec, v[2:3]
// W32: encoding: [0x7e,0x04,0x52,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f64 vcc_lo, null, v[2:3]
// W32: encoding: [0x7c,0x04,0x52,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f64 vcc_lo, -1, v[2:3]
// W32: encoding: [0xc1,0x04,0x52,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f64 vcc_lo, 0.5, v[2:3]
// W32: encoding: [0xf0,0x04,0x52,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f64 vcc_lo, src_scc, v[2:3]
// W32: encoding: [0xfd,0x04,0x52,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f64 vcc_lo, 0xaf123456, v[254:255]
// W32: encoding: [0xff,0xfc,0x53,0x7c,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f64 vcc, v[1:2], v[2:3]
// W64: encoding: [0x01,0x05,0x52,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f64 vcc, v[254:255], v[2:3]
// W64: encoding: [0xfe,0x05,0x52,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f64 vcc, s[2:3], v[2:3]
// W64: encoding: [0x02,0x04,0x52,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f64 vcc, s[104:105], v[2:3]
// W64: encoding: [0x68,0x04,0x52,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f64 vcc, vcc, v[2:3]
// W64: encoding: [0x6a,0x04,0x52,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f64 vcc, ttmp[14:15], v[2:3]
// W64: encoding: [0x7a,0x04,0x52,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f64 vcc, exec, v[2:3]
// W64: encoding: [0x7e,0x04,0x52,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f64 vcc, null, v[2:3]
// W64: encoding: [0x7c,0x04,0x52,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f64 vcc, -1, v[2:3]
// W64: encoding: [0xc1,0x04,0x52,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f64 vcc, 0.5, v[2:3]
// W64: encoding: [0xf0,0x04,0x52,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f64 vcc, src_scc, v[2:3]
// W64: encoding: [0xfd,0x04,0x52,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nge_f64 vcc, 0xaf123456, v[254:255]
// W64: encoding: [0xff,0xfc,0x53,0x7c,0x56,0x34,0x12,0xaf]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc_lo, v1, v2
// W32: encoding: [0x01,0x05,0x16,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc_lo, v127, v2
// W32: encoding: [0x7f,0x05,0x16,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc_lo, s1, v2
// W32: encoding: [0x01,0x04,0x16,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc_lo, s105, v2
// W32: encoding: [0x69,0x04,0x16,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc_lo, vcc_lo, v2
// W32: encoding: [0x6a,0x04,0x16,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc_lo, vcc_hi, v2
// W32: encoding: [0x6b,0x04,0x16,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc_lo, ttmp15, v2
// W32: encoding: [0x7b,0x04,0x16,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc_lo, m0, v2
// W32: encoding: [0x7d,0x04,0x16,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc_lo, exec_lo, v2
// W32: encoding: [0x7e,0x04,0x16,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc_lo, exec_hi, v2
// W32: encoding: [0x7f,0x04,0x16,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc_lo, null, v2
// W32: encoding: [0x7c,0x04,0x16,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc_lo, -1, v2
// W32: encoding: [0xc1,0x04,0x16,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc_lo, 0.5, v2
// W32: encoding: [0xf0,0x04,0x16,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc_lo, src_scc, v2
// W32: encoding: [0xfd,0x04,0x16,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc_lo, 0xfe0b, v127
// W32: encoding: [0xff,0xfe,0x16,0x7c,0x0b,0xfe,0x00,0x00]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc, v1, v2
// W64: encoding: [0x01,0x05,0x16,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc, v127, v2
// W64: encoding: [0x7f,0x05,0x16,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc, s1, v2
// W64: encoding: [0x01,0x04,0x16,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc, s105, v2
// W64: encoding: [0x69,0x04,0x16,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc, vcc_lo, v2
// W64: encoding: [0x6a,0x04,0x16,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc, vcc_hi, v2
// W64: encoding: [0x6b,0x04,0x16,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc, ttmp15, v2
// W64: encoding: [0x7b,0x04,0x16,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc, m0, v2
// W64: encoding: [0x7d,0x04,0x16,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc, exec_lo, v2
// W64: encoding: [0x7e,0x04,0x16,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc, exec_hi, v2
// W64: encoding: [0x7f,0x04,0x16,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc, null, v2
// W64: encoding: [0x7c,0x04,0x16,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc, -1, v2
// W64: encoding: [0xc1,0x04,0x16,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc, 0.5, v2
// W64: encoding: [0xf0,0x04,0x16,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc, src_scc, v2
// W64: encoding: [0xfd,0x04,0x16,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f16 vcc, 0xfe0b, v127
// W64: encoding: [0xff,0xfe,0x16,0x7c,0x0b,0xfe,0x00,0x00]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc_lo, v1, v2
// W32: encoding: [0x01,0x05,0x36,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc_lo, v255, v2
// W32: encoding: [0xff,0x05,0x36,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc_lo, s1, v2
// W32: encoding: [0x01,0x04,0x36,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc_lo, s105, v2
// W32: encoding: [0x69,0x04,0x36,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc_lo, vcc_lo, v2
// W32: encoding: [0x6a,0x04,0x36,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc_lo, vcc_hi, v2
// W32: encoding: [0x6b,0x04,0x36,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc_lo, ttmp15, v2
// W32: encoding: [0x7b,0x04,0x36,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc_lo, m0, v2
// W32: encoding: [0x7d,0x04,0x36,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc_lo, exec_lo, v2
// W32: encoding: [0x7e,0x04,0x36,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc_lo, exec_hi, v2
// W32: encoding: [0x7f,0x04,0x36,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc_lo, null, v2
// W32: encoding: [0x7c,0x04,0x36,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc_lo, -1, v2
// W32: encoding: [0xc1,0x04,0x36,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc_lo, 0.5, v2
// W32: encoding: [0xf0,0x04,0x36,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc_lo, src_scc, v2
// W32: encoding: [0xfd,0x04,0x36,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc_lo, 0xaf123456, v255
// W32: encoding: [0xff,0xfe,0x37,0x7c,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc, v1, v2
// W64: encoding: [0x01,0x05,0x36,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc, v255, v2
// W64: encoding: [0xff,0x05,0x36,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc, s1, v2
// W64: encoding: [0x01,0x04,0x36,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc, s105, v2
// W64: encoding: [0x69,0x04,0x36,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc, vcc_lo, v2
// W64: encoding: [0x6a,0x04,0x36,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc, vcc_hi, v2
// W64: encoding: [0x6b,0x04,0x36,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc, ttmp15, v2
// W64: encoding: [0x7b,0x04,0x36,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc, m0, v2
// W64: encoding: [0x7d,0x04,0x36,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc, exec_lo, v2
// W64: encoding: [0x7e,0x04,0x36,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc, exec_hi, v2
// W64: encoding: [0x7f,0x04,0x36,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc, null, v2
// W64: encoding: [0x7c,0x04,0x36,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc, -1, v2
// W64: encoding: [0xc1,0x04,0x36,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc, 0.5, v2
// W64: encoding: [0xf0,0x04,0x36,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc, src_scc, v2
// W64: encoding: [0xfd,0x04,0x36,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f32 vcc, 0xaf123456, v255
// W64: encoding: [0xff,0xfe,0x37,0x7c,0x56,0x34,0x12,0xaf]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f64 vcc_lo, v[1:2], v[2:3]
// W32: encoding: [0x01,0x05,0x56,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f64 vcc_lo, v[254:255], v[2:3]
// W32: encoding: [0xfe,0x05,0x56,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f64 vcc_lo, s[2:3], v[2:3]
// W32: encoding: [0x02,0x04,0x56,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f64 vcc_lo, s[104:105], v[2:3]
// W32: encoding: [0x68,0x04,0x56,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f64 vcc_lo, vcc, v[2:3]
// W32: encoding: [0x6a,0x04,0x56,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f64 vcc_lo, ttmp[14:15], v[2:3]
// W32: encoding: [0x7a,0x04,0x56,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f64 vcc_lo, exec, v[2:3]
// W32: encoding: [0x7e,0x04,0x56,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f64 vcc_lo, null, v[2:3]
// W32: encoding: [0x7c,0x04,0x56,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f64 vcc_lo, -1, v[2:3]
// W32: encoding: [0xc1,0x04,0x56,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f64 vcc_lo, 0.5, v[2:3]
// W32: encoding: [0xf0,0x04,0x56,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f64 vcc_lo, src_scc, v[2:3]
// W32: encoding: [0xfd,0x04,0x56,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f64 vcc_lo, 0xaf123456, v[254:255]
// W32: encoding: [0xff,0xfc,0x57,0x7c,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f64 vcc, v[1:2], v[2:3]
// W64: encoding: [0x01,0x05,0x56,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f64 vcc, v[254:255], v[2:3]
// W64: encoding: [0xfe,0x05,0x56,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f64 vcc, s[2:3], v[2:3]
// W64: encoding: [0x02,0x04,0x56,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f64 vcc, s[104:105], v[2:3]
// W64: encoding: [0x68,0x04,0x56,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f64 vcc, vcc, v[2:3]
// W64: encoding: [0x6a,0x04,0x56,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f64 vcc, ttmp[14:15], v[2:3]
// W64: encoding: [0x7a,0x04,0x56,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f64 vcc, exec, v[2:3]
// W64: encoding: [0x7e,0x04,0x56,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f64 vcc, null, v[2:3]
// W64: encoding: [0x7c,0x04,0x56,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f64 vcc, -1, v[2:3]
// W64: encoding: [0xc1,0x04,0x56,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f64 vcc, 0.5, v[2:3]
// W64: encoding: [0xf0,0x04,0x56,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f64 vcc, src_scc, v[2:3]
// W64: encoding: [0xfd,0x04,0x56,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_ngt_f64 vcc, 0xaf123456, v[254:255]
// W64: encoding: [0xff,0xfc,0x57,0x7c,0x56,0x34,0x12,0xaf]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc_lo, v1, v2
// W32: encoding: [0x01,0x05,0x18,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc_lo, v127, v2
// W32: encoding: [0x7f,0x05,0x18,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc_lo, s1, v2
// W32: encoding: [0x01,0x04,0x18,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc_lo, s105, v2
// W32: encoding: [0x69,0x04,0x18,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc_lo, vcc_lo, v2
// W32: encoding: [0x6a,0x04,0x18,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc_lo, vcc_hi, v2
// W32: encoding: [0x6b,0x04,0x18,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc_lo, ttmp15, v2
// W32: encoding: [0x7b,0x04,0x18,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc_lo, m0, v2
// W32: encoding: [0x7d,0x04,0x18,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc_lo, exec_lo, v2
// W32: encoding: [0x7e,0x04,0x18,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc_lo, exec_hi, v2
// W32: encoding: [0x7f,0x04,0x18,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc_lo, null, v2
// W32: encoding: [0x7c,0x04,0x18,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc_lo, -1, v2
// W32: encoding: [0xc1,0x04,0x18,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc_lo, 0.5, v2
// W32: encoding: [0xf0,0x04,0x18,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc_lo, src_scc, v2
// W32: encoding: [0xfd,0x04,0x18,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc_lo, 0xfe0b, v127
// W32: encoding: [0xff,0xfe,0x18,0x7c,0x0b,0xfe,0x00,0x00]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc, v1, v2
// W64: encoding: [0x01,0x05,0x18,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc, v127, v2
// W64: encoding: [0x7f,0x05,0x18,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc, s1, v2
// W64: encoding: [0x01,0x04,0x18,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc, s105, v2
// W64: encoding: [0x69,0x04,0x18,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc, vcc_lo, v2
// W64: encoding: [0x6a,0x04,0x18,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc, vcc_hi, v2
// W64: encoding: [0x6b,0x04,0x18,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc, ttmp15, v2
// W64: encoding: [0x7b,0x04,0x18,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc, m0, v2
// W64: encoding: [0x7d,0x04,0x18,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc, exec_lo, v2
// W64: encoding: [0x7e,0x04,0x18,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc, exec_hi, v2
// W64: encoding: [0x7f,0x04,0x18,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc, null, v2
// W64: encoding: [0x7c,0x04,0x18,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc, -1, v2
// W64: encoding: [0xc1,0x04,0x18,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc, 0.5, v2
// W64: encoding: [0xf0,0x04,0x18,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc, src_scc, v2
// W64: encoding: [0xfd,0x04,0x18,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f16 vcc, 0xfe0b, v127
// W64: encoding: [0xff,0xfe,0x18,0x7c,0x0b,0xfe,0x00,0x00]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc_lo, v1, v2
// W32: encoding: [0x01,0x05,0x38,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc_lo, v255, v2
// W32: encoding: [0xff,0x05,0x38,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc_lo, s1, v2
// W32: encoding: [0x01,0x04,0x38,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc_lo, s105, v2
// W32: encoding: [0x69,0x04,0x38,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc_lo, vcc_lo, v2
// W32: encoding: [0x6a,0x04,0x38,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc_lo, vcc_hi, v2
// W32: encoding: [0x6b,0x04,0x38,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc_lo, ttmp15, v2
// W32: encoding: [0x7b,0x04,0x38,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc_lo, m0, v2
// W32: encoding: [0x7d,0x04,0x38,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc_lo, exec_lo, v2
// W32: encoding: [0x7e,0x04,0x38,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc_lo, exec_hi, v2
// W32: encoding: [0x7f,0x04,0x38,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc_lo, null, v2
// W32: encoding: [0x7c,0x04,0x38,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc_lo, -1, v2
// W32: encoding: [0xc1,0x04,0x38,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc_lo, 0.5, v2
// W32: encoding: [0xf0,0x04,0x38,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc_lo, src_scc, v2
// W32: encoding: [0xfd,0x04,0x38,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc_lo, 0xaf123456, v255
// W32: encoding: [0xff,0xfe,0x39,0x7c,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc, v1, v2
// W64: encoding: [0x01,0x05,0x38,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc, v255, v2
// W64: encoding: [0xff,0x05,0x38,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc, s1, v2
// W64: encoding: [0x01,0x04,0x38,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc, s105, v2
// W64: encoding: [0x69,0x04,0x38,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc, vcc_lo, v2
// W64: encoding: [0x6a,0x04,0x38,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc, vcc_hi, v2
// W64: encoding: [0x6b,0x04,0x38,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc, ttmp15, v2
// W64: encoding: [0x7b,0x04,0x38,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc, m0, v2
// W64: encoding: [0x7d,0x04,0x38,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc, exec_lo, v2
// W64: encoding: [0x7e,0x04,0x38,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc, exec_hi, v2
// W64: encoding: [0x7f,0x04,0x38,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc, null, v2
// W64: encoding: [0x7c,0x04,0x38,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc, -1, v2
// W64: encoding: [0xc1,0x04,0x38,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc, 0.5, v2
// W64: encoding: [0xf0,0x04,0x38,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc, src_scc, v2
// W64: encoding: [0xfd,0x04,0x38,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f32 vcc, 0xaf123456, v255
// W64: encoding: [0xff,0xfe,0x39,0x7c,0x56,0x34,0x12,0xaf]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f64 vcc_lo, v[1:2], v[2:3]
// W32: encoding: [0x01,0x05,0x58,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f64 vcc_lo, v[254:255], v[2:3]
// W32: encoding: [0xfe,0x05,0x58,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f64 vcc_lo, s[2:3], v[2:3]
// W32: encoding: [0x02,0x04,0x58,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f64 vcc_lo, s[104:105], v[2:3]
// W32: encoding: [0x68,0x04,0x58,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f64 vcc_lo, vcc, v[2:3]
// W32: encoding: [0x6a,0x04,0x58,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f64 vcc_lo, ttmp[14:15], v[2:3]
// W32: encoding: [0x7a,0x04,0x58,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f64 vcc_lo, exec, v[2:3]
// W32: encoding: [0x7e,0x04,0x58,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f64 vcc_lo, null, v[2:3]
// W32: encoding: [0x7c,0x04,0x58,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f64 vcc_lo, -1, v[2:3]
// W32: encoding: [0xc1,0x04,0x58,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f64 vcc_lo, 0.5, v[2:3]
// W32: encoding: [0xf0,0x04,0x58,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f64 vcc_lo, src_scc, v[2:3]
// W32: encoding: [0xfd,0x04,0x58,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f64 vcc_lo, 0xaf123456, v[254:255]
// W32: encoding: [0xff,0xfc,0x59,0x7c,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f64 vcc, v[1:2], v[2:3]
// W64: encoding: [0x01,0x05,0x58,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f64 vcc, v[254:255], v[2:3]
// W64: encoding: [0xfe,0x05,0x58,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f64 vcc, s[2:3], v[2:3]
// W64: encoding: [0x02,0x04,0x58,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f64 vcc, s[104:105], v[2:3]
// W64: encoding: [0x68,0x04,0x58,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f64 vcc, vcc, v[2:3]
// W64: encoding: [0x6a,0x04,0x58,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f64 vcc, ttmp[14:15], v[2:3]
// W64: encoding: [0x7a,0x04,0x58,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f64 vcc, exec, v[2:3]
// W64: encoding: [0x7e,0x04,0x58,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f64 vcc, null, v[2:3]
// W64: encoding: [0x7c,0x04,0x58,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f64 vcc, -1, v[2:3]
// W64: encoding: [0xc1,0x04,0x58,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f64 vcc, 0.5, v[2:3]
// W64: encoding: [0xf0,0x04,0x58,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f64 vcc, src_scc, v[2:3]
// W64: encoding: [0xfd,0x04,0x58,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nle_f64 vcc, 0xaf123456, v[254:255]
// W64: encoding: [0xff,0xfc,0x59,0x7c,0x56,0x34,0x12,0xaf]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc_lo, v1, v2
// W32: encoding: [0x01,0x05,0x14,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc_lo, v127, v2
// W32: encoding: [0x7f,0x05,0x14,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc_lo, s1, v2
// W32: encoding: [0x01,0x04,0x14,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc_lo, s105, v2
// W32: encoding: [0x69,0x04,0x14,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc_lo, vcc_lo, v2
// W32: encoding: [0x6a,0x04,0x14,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc_lo, vcc_hi, v2
// W32: encoding: [0x6b,0x04,0x14,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc_lo, ttmp15, v2
// W32: encoding: [0x7b,0x04,0x14,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc_lo, m0, v2
// W32: encoding: [0x7d,0x04,0x14,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc_lo, exec_lo, v2
// W32: encoding: [0x7e,0x04,0x14,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc_lo, exec_hi, v2
// W32: encoding: [0x7f,0x04,0x14,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc_lo, null, v2
// W32: encoding: [0x7c,0x04,0x14,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc_lo, -1, v2
// W32: encoding: [0xc1,0x04,0x14,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc_lo, 0.5, v2
// W32: encoding: [0xf0,0x04,0x14,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc_lo, src_scc, v2
// W32: encoding: [0xfd,0x04,0x14,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc_lo, 0xfe0b, v127
// W32: encoding: [0xff,0xfe,0x14,0x7c,0x0b,0xfe,0x00,0x00]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc, v1, v2
// W64: encoding: [0x01,0x05,0x14,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc, v127, v2
// W64: encoding: [0x7f,0x05,0x14,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc, s1, v2
// W64: encoding: [0x01,0x04,0x14,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc, s105, v2
// W64: encoding: [0x69,0x04,0x14,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc, vcc_lo, v2
// W64: encoding: [0x6a,0x04,0x14,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc, vcc_hi, v2
// W64: encoding: [0x6b,0x04,0x14,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc, ttmp15, v2
// W64: encoding: [0x7b,0x04,0x14,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc, m0, v2
// W64: encoding: [0x7d,0x04,0x14,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc, exec_lo, v2
// W64: encoding: [0x7e,0x04,0x14,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc, exec_hi, v2
// W64: encoding: [0x7f,0x04,0x14,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc, null, v2
// W64: encoding: [0x7c,0x04,0x14,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc, -1, v2
// W64: encoding: [0xc1,0x04,0x14,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc, 0.5, v2
// W64: encoding: [0xf0,0x04,0x14,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc, src_scc, v2
// W64: encoding: [0xfd,0x04,0x14,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f16 vcc, 0xfe0b, v127
// W64: encoding: [0xff,0xfe,0x14,0x7c,0x0b,0xfe,0x00,0x00]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc_lo, v1, v2
// W32: encoding: [0x01,0x05,0x34,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc_lo, v255, v2
// W32: encoding: [0xff,0x05,0x34,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc_lo, s1, v2
// W32: encoding: [0x01,0x04,0x34,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc_lo, s105, v2
// W32: encoding: [0x69,0x04,0x34,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc_lo, vcc_lo, v2
// W32: encoding: [0x6a,0x04,0x34,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc_lo, vcc_hi, v2
// W32: encoding: [0x6b,0x04,0x34,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc_lo, ttmp15, v2
// W32: encoding: [0x7b,0x04,0x34,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc_lo, m0, v2
// W32: encoding: [0x7d,0x04,0x34,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc_lo, exec_lo, v2
// W32: encoding: [0x7e,0x04,0x34,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc_lo, exec_hi, v2
// W32: encoding: [0x7f,0x04,0x34,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc_lo, null, v2
// W32: encoding: [0x7c,0x04,0x34,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc_lo, -1, v2
// W32: encoding: [0xc1,0x04,0x34,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc_lo, 0.5, v2
// W32: encoding: [0xf0,0x04,0x34,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc_lo, src_scc, v2
// W32: encoding: [0xfd,0x04,0x34,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc_lo, 0xaf123456, v255
// W32: encoding: [0xff,0xfe,0x35,0x7c,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc, v1, v2
// W64: encoding: [0x01,0x05,0x34,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc, v255, v2
// W64: encoding: [0xff,0x05,0x34,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc, s1, v2
// W64: encoding: [0x01,0x04,0x34,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc, s105, v2
// W64: encoding: [0x69,0x04,0x34,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc, vcc_lo, v2
// W64: encoding: [0x6a,0x04,0x34,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc, vcc_hi, v2
// W64: encoding: [0x6b,0x04,0x34,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc, ttmp15, v2
// W64: encoding: [0x7b,0x04,0x34,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc, m0, v2
// W64: encoding: [0x7d,0x04,0x34,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc, exec_lo, v2
// W64: encoding: [0x7e,0x04,0x34,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc, exec_hi, v2
// W64: encoding: [0x7f,0x04,0x34,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc, null, v2
// W64: encoding: [0x7c,0x04,0x34,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc, -1, v2
// W64: encoding: [0xc1,0x04,0x34,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc, 0.5, v2
// W64: encoding: [0xf0,0x04,0x34,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc, src_scc, v2
// W64: encoding: [0xfd,0x04,0x34,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f32 vcc, 0xaf123456, v255
// W64: encoding: [0xff,0xfe,0x35,0x7c,0x56,0x34,0x12,0xaf]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f64 vcc_lo, v[1:2], v[2:3]
// W32: encoding: [0x01,0x05,0x54,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f64 vcc_lo, v[254:255], v[2:3]
// W32: encoding: [0xfe,0x05,0x54,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f64 vcc_lo, s[2:3], v[2:3]
// W32: encoding: [0x02,0x04,0x54,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f64 vcc_lo, s[104:105], v[2:3]
// W32: encoding: [0x68,0x04,0x54,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f64 vcc_lo, vcc, v[2:3]
// W32: encoding: [0x6a,0x04,0x54,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f64 vcc_lo, ttmp[14:15], v[2:3]
// W32: encoding: [0x7a,0x04,0x54,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f64 vcc_lo, exec, v[2:3]
// W32: encoding: [0x7e,0x04,0x54,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f64 vcc_lo, null, v[2:3]
// W32: encoding: [0x7c,0x04,0x54,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f64 vcc_lo, -1, v[2:3]
// W32: encoding: [0xc1,0x04,0x54,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f64 vcc_lo, 0.5, v[2:3]
// W32: encoding: [0xf0,0x04,0x54,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f64 vcc_lo, src_scc, v[2:3]
// W32: encoding: [0xfd,0x04,0x54,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f64 vcc_lo, 0xaf123456, v[254:255]
// W32: encoding: [0xff,0xfc,0x55,0x7c,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f64 vcc, v[1:2], v[2:3]
// W64: encoding: [0x01,0x05,0x54,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f64 vcc, v[254:255], v[2:3]
// W64: encoding: [0xfe,0x05,0x54,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f64 vcc, s[2:3], v[2:3]
// W64: encoding: [0x02,0x04,0x54,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f64 vcc, s[104:105], v[2:3]
// W64: encoding: [0x68,0x04,0x54,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f64 vcc, vcc, v[2:3]
// W64: encoding: [0x6a,0x04,0x54,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f64 vcc, ttmp[14:15], v[2:3]
// W64: encoding: [0x7a,0x04,0x54,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f64 vcc, exec, v[2:3]
// W64: encoding: [0x7e,0x04,0x54,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f64 vcc, null, v[2:3]
// W64: encoding: [0x7c,0x04,0x54,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f64 vcc, -1, v[2:3]
// W64: encoding: [0xc1,0x04,0x54,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f64 vcc, 0.5, v[2:3]
// W64: encoding: [0xf0,0x04,0x54,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f64 vcc, src_scc, v[2:3]
// W64: encoding: [0xfd,0x04,0x54,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlg_f64 vcc, 0xaf123456, v[254:255]
// W64: encoding: [0xff,0xfc,0x55,0x7c,0x56,0x34,0x12,0xaf]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc_lo, v1, v2
// W32: encoding: [0x01,0x05,0x1c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc_lo, v127, v2
// W32: encoding: [0x7f,0x05,0x1c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc_lo, s1, v2
// W32: encoding: [0x01,0x04,0x1c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc_lo, s105, v2
// W32: encoding: [0x69,0x04,0x1c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc_lo, vcc_lo, v2
// W32: encoding: [0x6a,0x04,0x1c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc_lo, vcc_hi, v2
// W32: encoding: [0x6b,0x04,0x1c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc_lo, ttmp15, v2
// W32: encoding: [0x7b,0x04,0x1c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc_lo, m0, v2
// W32: encoding: [0x7d,0x04,0x1c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc_lo, exec_lo, v2
// W32: encoding: [0x7e,0x04,0x1c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc_lo, exec_hi, v2
// W32: encoding: [0x7f,0x04,0x1c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc_lo, null, v2
// W32: encoding: [0x7c,0x04,0x1c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc_lo, -1, v2
// W32: encoding: [0xc1,0x04,0x1c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc_lo, 0.5, v2
// W32: encoding: [0xf0,0x04,0x1c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc_lo, src_scc, v2
// W32: encoding: [0xfd,0x04,0x1c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc_lo, 0xfe0b, v127
// W32: encoding: [0xff,0xfe,0x1c,0x7c,0x0b,0xfe,0x00,0x00]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc, v1, v2
// W64: encoding: [0x01,0x05,0x1c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc, v127, v2
// W64: encoding: [0x7f,0x05,0x1c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc, s1, v2
// W64: encoding: [0x01,0x04,0x1c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc, s105, v2
// W64: encoding: [0x69,0x04,0x1c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc, vcc_lo, v2
// W64: encoding: [0x6a,0x04,0x1c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc, vcc_hi, v2
// W64: encoding: [0x6b,0x04,0x1c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc, ttmp15, v2
// W64: encoding: [0x7b,0x04,0x1c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc, m0, v2
// W64: encoding: [0x7d,0x04,0x1c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc, exec_lo, v2
// W64: encoding: [0x7e,0x04,0x1c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc, exec_hi, v2
// W64: encoding: [0x7f,0x04,0x1c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc, null, v2
// W64: encoding: [0x7c,0x04,0x1c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc, -1, v2
// W64: encoding: [0xc1,0x04,0x1c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc, 0.5, v2
// W64: encoding: [0xf0,0x04,0x1c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc, src_scc, v2
// W64: encoding: [0xfd,0x04,0x1c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f16 vcc, 0xfe0b, v127
// W64: encoding: [0xff,0xfe,0x1c,0x7c,0x0b,0xfe,0x00,0x00]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc_lo, v1, v2
// W32: encoding: [0x01,0x05,0x3c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc_lo, v255, v2
// W32: encoding: [0xff,0x05,0x3c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc_lo, s1, v2
// W32: encoding: [0x01,0x04,0x3c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc_lo, s105, v2
// W32: encoding: [0x69,0x04,0x3c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc_lo, vcc_lo, v2
// W32: encoding: [0x6a,0x04,0x3c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc_lo, vcc_hi, v2
// W32: encoding: [0x6b,0x04,0x3c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc_lo, ttmp15, v2
// W32: encoding: [0x7b,0x04,0x3c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc_lo, m0, v2
// W32: encoding: [0x7d,0x04,0x3c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc_lo, exec_lo, v2
// W32: encoding: [0x7e,0x04,0x3c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc_lo, exec_hi, v2
// W32: encoding: [0x7f,0x04,0x3c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc_lo, null, v2
// W32: encoding: [0x7c,0x04,0x3c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc_lo, -1, v2
// W32: encoding: [0xc1,0x04,0x3c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc_lo, 0.5, v2
// W32: encoding: [0xf0,0x04,0x3c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc_lo, src_scc, v2
// W32: encoding: [0xfd,0x04,0x3c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc_lo, 0xaf123456, v255
// W32: encoding: [0xff,0xfe,0x3d,0x7c,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc, v1, v2
// W64: encoding: [0x01,0x05,0x3c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc, v255, v2
// W64: encoding: [0xff,0x05,0x3c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc, s1, v2
// W64: encoding: [0x01,0x04,0x3c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc, s105, v2
// W64: encoding: [0x69,0x04,0x3c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc, vcc_lo, v2
// W64: encoding: [0x6a,0x04,0x3c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc, vcc_hi, v2
// W64: encoding: [0x6b,0x04,0x3c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc, ttmp15, v2
// W64: encoding: [0x7b,0x04,0x3c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc, m0, v2
// W64: encoding: [0x7d,0x04,0x3c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc, exec_lo, v2
// W64: encoding: [0x7e,0x04,0x3c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc, exec_hi, v2
// W64: encoding: [0x7f,0x04,0x3c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc, null, v2
// W64: encoding: [0x7c,0x04,0x3c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc, -1, v2
// W64: encoding: [0xc1,0x04,0x3c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc, 0.5, v2
// W64: encoding: [0xf0,0x04,0x3c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc, src_scc, v2
// W64: encoding: [0xfd,0x04,0x3c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f32 vcc, 0xaf123456, v255
// W64: encoding: [0xff,0xfe,0x3d,0x7c,0x56,0x34,0x12,0xaf]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f64 vcc_lo, v[1:2], v[2:3]
// W32: encoding: [0x01,0x05,0x5c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f64 vcc_lo, v[254:255], v[2:3]
// W32: encoding: [0xfe,0x05,0x5c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f64 vcc_lo, s[2:3], v[2:3]
// W32: encoding: [0x02,0x04,0x5c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f64 vcc_lo, s[104:105], v[2:3]
// W32: encoding: [0x68,0x04,0x5c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f64 vcc_lo, vcc, v[2:3]
// W32: encoding: [0x6a,0x04,0x5c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f64 vcc_lo, ttmp[14:15], v[2:3]
// W32: encoding: [0x7a,0x04,0x5c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f64 vcc_lo, exec, v[2:3]
// W32: encoding: [0x7e,0x04,0x5c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f64 vcc_lo, null, v[2:3]
// W32: encoding: [0x7c,0x04,0x5c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f64 vcc_lo, -1, v[2:3]
// W32: encoding: [0xc1,0x04,0x5c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f64 vcc_lo, 0.5, v[2:3]
// W32: encoding: [0xf0,0x04,0x5c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f64 vcc_lo, src_scc, v[2:3]
// W32: encoding: [0xfd,0x04,0x5c,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f64 vcc_lo, 0xaf123456, v[254:255]
// W32: encoding: [0xff,0xfc,0x5d,0x7c,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f64 vcc, v[1:2], v[2:3]
// W64: encoding: [0x01,0x05,0x5c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f64 vcc, v[254:255], v[2:3]
// W64: encoding: [0xfe,0x05,0x5c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f64 vcc, s[2:3], v[2:3]
// W64: encoding: [0x02,0x04,0x5c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f64 vcc, s[104:105], v[2:3]
// W64: encoding: [0x68,0x04,0x5c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f64 vcc, vcc, v[2:3]
// W64: encoding: [0x6a,0x04,0x5c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f64 vcc, ttmp[14:15], v[2:3]
// W64: encoding: [0x7a,0x04,0x5c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f64 vcc, exec, v[2:3]
// W64: encoding: [0x7e,0x04,0x5c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f64 vcc, null, v[2:3]
// W64: encoding: [0x7c,0x04,0x5c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f64 vcc, -1, v[2:3]
// W64: encoding: [0xc1,0x04,0x5c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f64 vcc, 0.5, v[2:3]
// W64: encoding: [0xf0,0x04,0x5c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f64 vcc, src_scc, v[2:3]
// W64: encoding: [0xfd,0x04,0x5c,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_nlt_f64 vcc, 0xaf123456, v[254:255]
// W64: encoding: [0xff,0xfc,0x5d,0x7c,0x56,0x34,0x12,0xaf]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc_lo, v1, v2
// W32: encoding: [0x01,0x05,0x0e,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc_lo, v127, v2
// W32: encoding: [0x7f,0x05,0x0e,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc_lo, s1, v2
// W32: encoding: [0x01,0x04,0x0e,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc_lo, s105, v2
// W32: encoding: [0x69,0x04,0x0e,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc_lo, vcc_lo, v2
// W32: encoding: [0x6a,0x04,0x0e,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc_lo, vcc_hi, v2
// W32: encoding: [0x6b,0x04,0x0e,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc_lo, ttmp15, v2
// W32: encoding: [0x7b,0x04,0x0e,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc_lo, m0, v2
// W32: encoding: [0x7d,0x04,0x0e,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc_lo, exec_lo, v2
// W32: encoding: [0x7e,0x04,0x0e,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc_lo, exec_hi, v2
// W32: encoding: [0x7f,0x04,0x0e,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc_lo, null, v2
// W32: encoding: [0x7c,0x04,0x0e,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc_lo, -1, v2
// W32: encoding: [0xc1,0x04,0x0e,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc_lo, 0.5, v2
// W32: encoding: [0xf0,0x04,0x0e,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc_lo, src_scc, v2
// W32: encoding: [0xfd,0x04,0x0e,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc_lo, 0xfe0b, v127
// W32: encoding: [0xff,0xfe,0x0e,0x7c,0x0b,0xfe,0x00,0x00]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc, v1, v2
// W64: encoding: [0x01,0x05,0x0e,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc, v127, v2
// W64: encoding: [0x7f,0x05,0x0e,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc, s1, v2
// W64: encoding: [0x01,0x04,0x0e,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc, s105, v2
// W64: encoding: [0x69,0x04,0x0e,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc, vcc_lo, v2
// W64: encoding: [0x6a,0x04,0x0e,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc, vcc_hi, v2
// W64: encoding: [0x6b,0x04,0x0e,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc, ttmp15, v2
// W64: encoding: [0x7b,0x04,0x0e,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc, m0, v2
// W64: encoding: [0x7d,0x04,0x0e,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc, exec_lo, v2
// W64: encoding: [0x7e,0x04,0x0e,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc, exec_hi, v2
// W64: encoding: [0x7f,0x04,0x0e,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc, null, v2
// W64: encoding: [0x7c,0x04,0x0e,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc, -1, v2
// W64: encoding: [0xc1,0x04,0x0e,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc, 0.5, v2
// W64: encoding: [0xf0,0x04,0x0e,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc, src_scc, v2
// W64: encoding: [0xfd,0x04,0x0e,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f16 vcc, 0xfe0b, v127
// W64: encoding: [0xff,0xfe,0x0e,0x7c,0x0b,0xfe,0x00,0x00]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc_lo, v1, v2
// W32: encoding: [0x01,0x05,0x2e,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc_lo, v255, v2
// W32: encoding: [0xff,0x05,0x2e,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc_lo, s1, v2
// W32: encoding: [0x01,0x04,0x2e,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc_lo, s105, v2
// W32: encoding: [0x69,0x04,0x2e,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc_lo, vcc_lo, v2
// W32: encoding: [0x6a,0x04,0x2e,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc_lo, vcc_hi, v2
// W32: encoding: [0x6b,0x04,0x2e,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc_lo, ttmp15, v2
// W32: encoding: [0x7b,0x04,0x2e,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc_lo, m0, v2
// W32: encoding: [0x7d,0x04,0x2e,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc_lo, exec_lo, v2
// W32: encoding: [0x7e,0x04,0x2e,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc_lo, exec_hi, v2
// W32: encoding: [0x7f,0x04,0x2e,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc_lo, null, v2
// W32: encoding: [0x7c,0x04,0x2e,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc_lo, -1, v2
// W32: encoding: [0xc1,0x04,0x2e,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc_lo, 0.5, v2
// W32: encoding: [0xf0,0x04,0x2e,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc_lo, src_scc, v2
// W32: encoding: [0xfd,0x04,0x2e,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc_lo, 0xaf123456, v255
// W32: encoding: [0xff,0xfe,0x2f,0x7c,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc, v1, v2
// W64: encoding: [0x01,0x05,0x2e,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc, v255, v2
// W64: encoding: [0xff,0x05,0x2e,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc, s1, v2
// W64: encoding: [0x01,0x04,0x2e,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc, s105, v2
// W64: encoding: [0x69,0x04,0x2e,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc, vcc_lo, v2
// W64: encoding: [0x6a,0x04,0x2e,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc, vcc_hi, v2
// W64: encoding: [0x6b,0x04,0x2e,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc, ttmp15, v2
// W64: encoding: [0x7b,0x04,0x2e,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc, m0, v2
// W64: encoding: [0x7d,0x04,0x2e,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc, exec_lo, v2
// W64: encoding: [0x7e,0x04,0x2e,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc, exec_hi, v2
// W64: encoding: [0x7f,0x04,0x2e,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc, null, v2
// W64: encoding: [0x7c,0x04,0x2e,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc, -1, v2
// W64: encoding: [0xc1,0x04,0x2e,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc, 0.5, v2
// W64: encoding: [0xf0,0x04,0x2e,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc, src_scc, v2
// W64: encoding: [0xfd,0x04,0x2e,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f32 vcc, 0xaf123456, v255
// W64: encoding: [0xff,0xfe,0x2f,0x7c,0x56,0x34,0x12,0xaf]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f64 vcc_lo, v[1:2], v[2:3]
// W32: encoding: [0x01,0x05,0x4e,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f64 vcc_lo, v[254:255], v[2:3]
// W32: encoding: [0xfe,0x05,0x4e,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f64 vcc_lo, s[2:3], v[2:3]
// W32: encoding: [0x02,0x04,0x4e,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f64 vcc_lo, s[104:105], v[2:3]
// W32: encoding: [0x68,0x04,0x4e,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f64 vcc_lo, vcc, v[2:3]
// W32: encoding: [0x6a,0x04,0x4e,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f64 vcc_lo, ttmp[14:15], v[2:3]
// W32: encoding: [0x7a,0x04,0x4e,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f64 vcc_lo, exec, v[2:3]
// W32: encoding: [0x7e,0x04,0x4e,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f64 vcc_lo, null, v[2:3]
// W32: encoding: [0x7c,0x04,0x4e,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f64 vcc_lo, -1, v[2:3]
// W32: encoding: [0xc1,0x04,0x4e,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f64 vcc_lo, 0.5, v[2:3]
// W32: encoding: [0xf0,0x04,0x4e,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f64 vcc_lo, src_scc, v[2:3]
// W32: encoding: [0xfd,0x04,0x4e,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f64 vcc_lo, 0xaf123456, v[254:255]
// W32: encoding: [0xff,0xfc,0x4f,0x7c,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f64 vcc, v[1:2], v[2:3]
// W64: encoding: [0x01,0x05,0x4e,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f64 vcc, v[254:255], v[2:3]
// W64: encoding: [0xfe,0x05,0x4e,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f64 vcc, s[2:3], v[2:3]
// W64: encoding: [0x02,0x04,0x4e,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f64 vcc, s[104:105], v[2:3]
// W64: encoding: [0x68,0x04,0x4e,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f64 vcc, vcc, v[2:3]
// W64: encoding: [0x6a,0x04,0x4e,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f64 vcc, ttmp[14:15], v[2:3]
// W64: encoding: [0x7a,0x04,0x4e,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f64 vcc, exec, v[2:3]
// W64: encoding: [0x7e,0x04,0x4e,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f64 vcc, null, v[2:3]
// W64: encoding: [0x7c,0x04,0x4e,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f64 vcc, -1, v[2:3]
// W64: encoding: [0xc1,0x04,0x4e,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f64 vcc, 0.5, v[2:3]
// W64: encoding: [0xf0,0x04,0x4e,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f64 vcc, src_scc, v[2:3]
// W64: encoding: [0xfd,0x04,0x4e,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_o_f64 vcc, 0xaf123456, v[254:255]
// W64: encoding: [0xff,0xfc,0x4f,0x7c,0x56,0x34,0x12,0xaf]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc_lo, v1, v2
// W32: encoding: [0x01,0x05,0x10,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc_lo, v127, v2
// W32: encoding: [0x7f,0x05,0x10,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc_lo, s1, v2
// W32: encoding: [0x01,0x04,0x10,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc_lo, s105, v2
// W32: encoding: [0x69,0x04,0x10,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc_lo, vcc_lo, v2
// W32: encoding: [0x6a,0x04,0x10,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc_lo, vcc_hi, v2
// W32: encoding: [0x6b,0x04,0x10,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc_lo, ttmp15, v2
// W32: encoding: [0x7b,0x04,0x10,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc_lo, m0, v2
// W32: encoding: [0x7d,0x04,0x10,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc_lo, exec_lo, v2
// W32: encoding: [0x7e,0x04,0x10,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc_lo, exec_hi, v2
// W32: encoding: [0x7f,0x04,0x10,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc_lo, null, v2
// W32: encoding: [0x7c,0x04,0x10,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc_lo, -1, v2
// W32: encoding: [0xc1,0x04,0x10,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc_lo, 0.5, v2
// W32: encoding: [0xf0,0x04,0x10,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc_lo, src_scc, v2
// W32: encoding: [0xfd,0x04,0x10,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc_lo, 0xfe0b, v127
// W32: encoding: [0xff,0xfe,0x10,0x7c,0x0b,0xfe,0x00,0x00]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc, v1, v2
// W64: encoding: [0x01,0x05,0x10,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc, v127, v2
// W64: encoding: [0x7f,0x05,0x10,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc, s1, v2
// W64: encoding: [0x01,0x04,0x10,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc, s105, v2
// W64: encoding: [0x69,0x04,0x10,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc, vcc_lo, v2
// W64: encoding: [0x6a,0x04,0x10,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc, vcc_hi, v2
// W64: encoding: [0x6b,0x04,0x10,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc, ttmp15, v2
// W64: encoding: [0x7b,0x04,0x10,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc, m0, v2
// W64: encoding: [0x7d,0x04,0x10,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc, exec_lo, v2
// W64: encoding: [0x7e,0x04,0x10,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc, exec_hi, v2
// W64: encoding: [0x7f,0x04,0x10,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc, null, v2
// W64: encoding: [0x7c,0x04,0x10,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc, -1, v2
// W64: encoding: [0xc1,0x04,0x10,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc, 0.5, v2
// W64: encoding: [0xf0,0x04,0x10,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc, src_scc, v2
// W64: encoding: [0xfd,0x04,0x10,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f16 vcc, 0xfe0b, v127
// W64: encoding: [0xff,0xfe,0x10,0x7c,0x0b,0xfe,0x00,0x00]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc_lo, v1, v2
// W32: encoding: [0x01,0x05,0x30,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc_lo, v255, v2
// W32: encoding: [0xff,0x05,0x30,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc_lo, s1, v2
// W32: encoding: [0x01,0x04,0x30,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc_lo, s105, v2
// W32: encoding: [0x69,0x04,0x30,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc_lo, vcc_lo, v2
// W32: encoding: [0x6a,0x04,0x30,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc_lo, vcc_hi, v2
// W32: encoding: [0x6b,0x04,0x30,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc_lo, ttmp15, v2
// W32: encoding: [0x7b,0x04,0x30,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc_lo, m0, v2
// W32: encoding: [0x7d,0x04,0x30,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc_lo, exec_lo, v2
// W32: encoding: [0x7e,0x04,0x30,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc_lo, exec_hi, v2
// W32: encoding: [0x7f,0x04,0x30,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc_lo, null, v2
// W32: encoding: [0x7c,0x04,0x30,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc_lo, -1, v2
// W32: encoding: [0xc1,0x04,0x30,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc_lo, 0.5, v2
// W32: encoding: [0xf0,0x04,0x30,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc_lo, src_scc, v2
// W32: encoding: [0xfd,0x04,0x30,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc_lo, 0xaf123456, v255
// W32: encoding: [0xff,0xfe,0x31,0x7c,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc, v1, v2
// W64: encoding: [0x01,0x05,0x30,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc, v255, v2
// W64: encoding: [0xff,0x05,0x30,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc, s1, v2
// W64: encoding: [0x01,0x04,0x30,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc, s105, v2
// W64: encoding: [0x69,0x04,0x30,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc, vcc_lo, v2
// W64: encoding: [0x6a,0x04,0x30,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc, vcc_hi, v2
// W64: encoding: [0x6b,0x04,0x30,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc, ttmp15, v2
// W64: encoding: [0x7b,0x04,0x30,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc, m0, v2
// W64: encoding: [0x7d,0x04,0x30,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc, exec_lo, v2
// W64: encoding: [0x7e,0x04,0x30,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc, exec_hi, v2
// W64: encoding: [0x7f,0x04,0x30,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc, null, v2
// W64: encoding: [0x7c,0x04,0x30,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc, -1, v2
// W64: encoding: [0xc1,0x04,0x30,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc, 0.5, v2
// W64: encoding: [0xf0,0x04,0x30,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc, src_scc, v2
// W64: encoding: [0xfd,0x04,0x30,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f32 vcc, 0xaf123456, v255
// W64: encoding: [0xff,0xfe,0x31,0x7c,0x56,0x34,0x12,0xaf]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f64 vcc_lo, v[1:2], v[2:3]
// W32: encoding: [0x01,0x05,0x50,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f64 vcc_lo, v[254:255], v[2:3]
// W32: encoding: [0xfe,0x05,0x50,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f64 vcc_lo, s[2:3], v[2:3]
// W32: encoding: [0x02,0x04,0x50,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f64 vcc_lo, s[104:105], v[2:3]
// W32: encoding: [0x68,0x04,0x50,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f64 vcc_lo, vcc, v[2:3]
// W32: encoding: [0x6a,0x04,0x50,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f64 vcc_lo, ttmp[14:15], v[2:3]
// W32: encoding: [0x7a,0x04,0x50,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f64 vcc_lo, exec, v[2:3]
// W32: encoding: [0x7e,0x04,0x50,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f64 vcc_lo, null, v[2:3]
// W32: encoding: [0x7c,0x04,0x50,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f64 vcc_lo, -1, v[2:3]
// W32: encoding: [0xc1,0x04,0x50,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f64 vcc_lo, 0.5, v[2:3]
// W32: encoding: [0xf0,0x04,0x50,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f64 vcc_lo, src_scc, v[2:3]
// W32: encoding: [0xfd,0x04,0x50,0x7c]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f64 vcc_lo, 0xaf123456, v[254:255]
// W32: encoding: [0xff,0xfc,0x51,0x7c,0x56,0x34,0x12,0xaf]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f64 vcc, v[1:2], v[2:3]
// W64: encoding: [0x01,0x05,0x50,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f64 vcc, v[254:255], v[2:3]
// W64: encoding: [0xfe,0x05,0x50,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f64 vcc, s[2:3], v[2:3]
// W64: encoding: [0x02,0x04,0x50,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f64 vcc, s[104:105], v[2:3]
// W64: encoding: [0x68,0x04,0x50,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f64 vcc, vcc, v[2:3]
// W64: encoding: [0x6a,0x04,0x50,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f64 vcc, ttmp[14:15], v[2:3]
// W64: encoding: [0x7a,0x04,0x50,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f64 vcc, exec, v[2:3]
// W64: encoding: [0x7e,0x04,0x50,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f64 vcc, null, v[2:3]
// W64: encoding: [0x7c,0x04,0x50,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f64 vcc, -1, v[2:3]
// W64: encoding: [0xc1,0x04,0x50,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f64 vcc, 0.5, v[2:3]
// W64: encoding: [0xf0,0x04,0x50,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f64 vcc, src_scc, v[2:3]
// W64: encoding: [0xfd,0x04,0x50,0x7c]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode

v_cmp_u_f64 vcc, 0xaf123456, v[254:255]
// W64: encoding: [0xff,0xfc,0x51,0x7c,0x56,0x34,0x12,0xaf]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: operands are not valid for this GPU or mode
