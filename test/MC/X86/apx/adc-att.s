# RUN: llvm-mc -triple x86_64 -show-encoding %s | FileCheck %s
# RUN: not llvm-mc -triple i386 -show-encoding %s 2>&1 | FileCheck %s --check-prefix=ERROR

# ERROR-COUNT-52: error:
# ERROR-NOT: error:
# CHECK: {evex}	adcb	$123, %bl
# CHECK: encoding: [0x62,0xf4,0x7c,0x08,0x80,0xd3,0x7b]
         {evex}	adcb	$123, %bl
# CHECK: adcb	$123, %bl, %cl
# CHECK: encoding: [0x62,0xf4,0x74,0x18,0x80,0xd3,0x7b]
         adcb	$123, %bl, %cl
# CHECK: {evex}	adcw	$123, %dx
# CHECK: encoding: [0x62,0xf4,0x7d,0x08,0x83,0xd2,0x7b]
         {evex}	adcw	$123, %dx
# CHECK: adcw	$123, %dx, %ax
# CHECK: encoding: [0x62,0xf4,0x7d,0x18,0x83,0xd2,0x7b]
         adcw	$123, %dx, %ax
# CHECK: {evex}	adcl	$123, %ecx
# CHECK: encoding: [0x62,0xf4,0x7c,0x08,0x83,0xd1,0x7b]
         {evex}	adcl	$123, %ecx
# CHECK: adcl	$123, %ecx, %edx
# CHECK: encoding: [0x62,0xf4,0x6c,0x18,0x83,0xd1,0x7b]
         adcl	$123, %ecx, %edx
# CHECK: {evex}	adcq	$123, %r9
# CHECK: encoding: [0x62,0xd4,0xfc,0x08,0x83,0xd1,0x7b]
         {evex}	adcq	$123, %r9
# CHECK: adcq	$123, %r9, %r15
# CHECK: encoding: [0x62,0xd4,0x84,0x18,0x83,0xd1,0x7b]
         adcq	$123, %r9, %r15
# CHECK: {evex}	adcb	$123, 291(%r8,%rax,4)
# CHECK: encoding: [0x62,0xd4,0x7c,0x08,0x80,0x94,0x80,0x23,0x01,0x00,0x00,0x7b]
         {evex}	adcb	$123, 291(%r8,%rax,4)
# CHECK: adcb	$123, 291(%r8,%rax,4), %bl
# CHECK: encoding: [0x62,0xd4,0x64,0x18,0x80,0x94,0x80,0x23,0x01,0x00,0x00,0x7b]
         adcb	$123, 291(%r8,%rax,4), %bl
# CHECK: {evex}	adcw	$123, 291(%r8,%rax,4)
# CHECK: encoding: [0x62,0xd4,0x7d,0x08,0x83,0x94,0x80,0x23,0x01,0x00,0x00,0x7b]
         {evex}	adcw	$123, 291(%r8,%rax,4)
# CHECK: adcw	$123, 291(%r8,%rax,4), %dx
# CHECK: encoding: [0x62,0xd4,0x6d,0x18,0x83,0x94,0x80,0x23,0x01,0x00,0x00,0x7b]
         adcw	$123, 291(%r8,%rax,4), %dx
# CHECK: {evex}	adcl	$123, 291(%r8,%rax,4)
# CHECK: encoding: [0x62,0xd4,0x7c,0x08,0x83,0x94,0x80,0x23,0x01,0x00,0x00,0x7b]
         {evex}	adcl	$123, 291(%r8,%rax,4)
# CHECK: adcl	$123, 291(%r8,%rax,4), %ecx
# CHECK: encoding: [0x62,0xd4,0x74,0x18,0x83,0x94,0x80,0x23,0x01,0x00,0x00,0x7b]
         adcl	$123, 291(%r8,%rax,4), %ecx
# CHECK: {evex}	adcq	$123, 291(%r8,%rax,4)
# CHECK: encoding: [0x62,0xd4,0xfc,0x08,0x83,0x94,0x80,0x23,0x01,0x00,0x00,0x7b]
         {evex}	adcq	$123, 291(%r8,%rax,4)
# CHECK: adcq	$123, 291(%r8,%rax,4), %r9
# CHECK: encoding: [0x62,0xd4,0xb4,0x18,0x83,0x94,0x80,0x23,0x01,0x00,0x00,0x7b]
         adcq	$123, 291(%r8,%rax,4), %r9
# CHECK: {evex}	adcw	$1234, %dx
# CHECK: encoding: [0x62,0xf4,0x7d,0x08,0x81,0xd2,0xd2,0x04]
         {evex}	adcw	$1234, %dx
# CHECK: adcw	$1234, %dx, %ax
# CHECK: encoding: [0x62,0xf4,0x7d,0x18,0x81,0xd2,0xd2,0x04]
         adcw	$1234, %dx, %ax
# CHECK: {evex}	adcw	$1234, 291(%r8,%rax,4)
# CHECK: encoding: [0x62,0xd4,0x7d,0x08,0x81,0x94,0x80,0x23,0x01,0x00,0x00,0xd2,0x04]
         {evex}	adcw	$1234, 291(%r8,%rax,4)
# CHECK: adcw	$1234, 291(%r8,%rax,4), %dx
# CHECK: encoding: [0x62,0xd4,0x6d,0x18,0x81,0x94,0x80,0x23,0x01,0x00,0x00,0xd2,0x04]
         adcw	$1234, 291(%r8,%rax,4), %dx
# CHECK: {evex}	adcl	$123456, %ecx
# CHECK: encoding: [0x62,0xf4,0x7c,0x08,0x81,0xd1,0x40,0xe2,0x01,0x00]
         {evex}	adcl	$123456, %ecx
# CHECK: adcl	$123456, %ecx, %edx
# CHECK: encoding: [0x62,0xf4,0x6c,0x18,0x81,0xd1,0x40,0xe2,0x01,0x00]
         adcl	$123456, %ecx, %edx
# CHECK: {evex}	adcq	$123456, %r9
# CHECK: encoding: [0x62,0xd4,0xfc,0x08,0x81,0xd1,0x40,0xe2,0x01,0x00]
         {evex}	adcq	$123456, %r9
# CHECK: adcq	$123456, %r9, %r15
# CHECK: encoding: [0x62,0xd4,0x84,0x18,0x81,0xd1,0x40,0xe2,0x01,0x00]
         adcq	$123456, %r9, %r15
# CHECK: {evex}	adcl	$123456, 291(%r8,%rax,4)
# CHECK: encoding: [0x62,0xd4,0x7c,0x08,0x81,0x94,0x80,0x23,0x01,0x00,0x00,0x40,0xe2,0x01,0x00]
         {evex}	adcl	$123456, 291(%r8,%rax,4)
# CHECK: adcl	$123456, 291(%r8,%rax,4), %ecx
# CHECK: encoding: [0x62,0xd4,0x74,0x18,0x81,0x94,0x80,0x23,0x01,0x00,0x00,0x40,0xe2,0x01,0x00]
         adcl	$123456, 291(%r8,%rax,4), %ecx
# CHECK: {evex}	adcq	$123456, 291(%r8,%rax,4)
# CHECK: encoding: [0x62,0xd4,0xfc,0x08,0x81,0x94,0x80,0x23,0x01,0x00,0x00,0x40,0xe2,0x01,0x00]
         {evex}	adcq	$123456, 291(%r8,%rax,4)
# CHECK: adcq	$123456, 291(%r8,%rax,4), %r9
# CHECK: encoding: [0x62,0xd4,0xb4,0x18,0x81,0x94,0x80,0x23,0x01,0x00,0x00,0x40,0xe2,0x01,0x00]
         adcq	$123456, 291(%r8,%rax,4), %r9
# CHECK: {evex}	adcb	%bl, %cl
# CHECK: encoding: [0x62,0xf4,0x7c,0x08,0x10,0xd9]
         {evex}	adcb	%bl, %cl
# CHECK: adcb	%bl, %cl, %r8b
# CHECK: encoding: [0x62,0xf4,0x3c,0x18,0x10,0xd9]
         adcb	%bl, %cl, %r8b
# CHECK: {evex}	adcb	%bl, 291(%r8,%rax,4)
# CHECK: encoding: [0x62,0xd4,0x7c,0x08,0x10,0x9c,0x80,0x23,0x01,0x00,0x00]
         {evex}	adcb	%bl, 291(%r8,%rax,4)
# CHECK: adcb	%bl, 291(%r8,%rax,4), %cl
# CHECK: encoding: [0x62,0xd4,0x74,0x18,0x10,0x9c,0x80,0x23,0x01,0x00,0x00]
         adcb	%bl, 291(%r8,%rax,4), %cl
# CHECK: {evex}	adcw	%dx, %ax
# CHECK: encoding: [0x62,0xf4,0x7d,0x08,0x11,0xd0]
         {evex}	adcw	%dx, %ax
# CHECK: adcw	%dx, %ax, %r9w
# CHECK: encoding: [0x62,0xf4,0x35,0x18,0x11,0xd0]
         adcw	%dx, %ax, %r9w
# CHECK: {evex}	adcw	%dx, 291(%r8,%rax,4)
# CHECK: encoding: [0x62,0xd4,0x7d,0x08,0x11,0x94,0x80,0x23,0x01,0x00,0x00]
         {evex}	adcw	%dx, 291(%r8,%rax,4)
# CHECK: adcw	%dx, 291(%r8,%rax,4), %ax
# CHECK: encoding: [0x62,0xd4,0x7d,0x18,0x11,0x94,0x80,0x23,0x01,0x00,0x00]
         adcw	%dx, 291(%r8,%rax,4), %ax
# CHECK: {evex}	adcl	%ecx, %edx
# CHECK: encoding: [0x62,0xf4,0x7c,0x08,0x11,0xca]
         {evex}	adcl	%ecx, %edx
# CHECK: adcl	%ecx, %edx, %r10d
# CHECK: encoding: [0x62,0xf4,0x2c,0x18,0x11,0xca]
         adcl	%ecx, %edx, %r10d
# CHECK: {evex}	adcl	%ecx, 291(%r8,%rax,4)
# CHECK: encoding: [0x62,0xd4,0x7c,0x08,0x11,0x8c,0x80,0x23,0x01,0x00,0x00]
         {evex}	adcl	%ecx, 291(%r8,%rax,4)
# CHECK: adcl	%ecx, 291(%r8,%rax,4), %edx
# CHECK: encoding: [0x62,0xd4,0x6c,0x18,0x11,0x8c,0x80,0x23,0x01,0x00,0x00]
         adcl	%ecx, 291(%r8,%rax,4), %edx
# CHECK: {evex}	adcq	%r9, %r15
# CHECK: encoding: [0x62,0x54,0xfc,0x08,0x11,0xcf]
         {evex}	adcq	%r9, %r15
# CHECK: adcq	%r9, %r15, %r11
# CHECK: encoding: [0x62,0x54,0xa4,0x18,0x11,0xcf]
         adcq	%r9, %r15, %r11
# CHECK: {evex}	adcq	%r9, 291(%r8,%rax,4)
# CHECK: encoding: [0x62,0x54,0xfc,0x08,0x11,0x8c,0x80,0x23,0x01,0x00,0x00]
         {evex}	adcq	%r9, 291(%r8,%rax,4)
# CHECK: adcq	%r9, 291(%r8,%rax,4), %r15
# CHECK: encoding: [0x62,0x54,0x84,0x18,0x11,0x8c,0x80,0x23,0x01,0x00,0x00]
         adcq	%r9, 291(%r8,%rax,4), %r15
# CHECK: {evex}	adcb	291(%r8,%rax,4), %bl
# CHECK: encoding: [0x62,0xd4,0x7c,0x08,0x12,0x9c,0x80,0x23,0x01,0x00,0x00]
         {evex}	adcb	291(%r8,%rax,4), %bl
# CHECK: adcb	291(%r8,%rax,4), %bl, %cl
# CHECK: encoding: [0x62,0xd4,0x74,0x18,0x12,0x9c,0x80,0x23,0x01,0x00,0x00]
         adcb	291(%r8,%rax,4), %bl, %cl
# CHECK: {evex}	adcw	291(%r8,%rax,4), %dx
# CHECK: encoding: [0x62,0xd4,0x7d,0x08,0x13,0x94,0x80,0x23,0x01,0x00,0x00]
         {evex}	adcw	291(%r8,%rax,4), %dx
# CHECK: adcw	291(%r8,%rax,4), %dx, %ax
# CHECK: encoding: [0x62,0xd4,0x7d,0x18,0x13,0x94,0x80,0x23,0x01,0x00,0x00]
         adcw	291(%r8,%rax,4), %dx, %ax
# CHECK: {evex}	adcl	291(%r8,%rax,4), %ecx
# CHECK: encoding: [0x62,0xd4,0x7c,0x08,0x13,0x8c,0x80,0x23,0x01,0x00,0x00]
         {evex}	adcl	291(%r8,%rax,4), %ecx
# CHECK: adcl	291(%r8,%rax,4), %ecx, %edx
# CHECK: encoding: [0x62,0xd4,0x6c,0x18,0x13,0x8c,0x80,0x23,0x01,0x00,0x00]
         adcl	291(%r8,%rax,4), %ecx, %edx
# CHECK: {evex}	adcq	291(%r8,%rax,4), %r9
# CHECK: encoding: [0x62,0x54,0xfc,0x08,0x13,0x8c,0x80,0x23,0x01,0x00,0x00]
         {evex}	adcq	291(%r8,%rax,4), %r9
# CHECK: adcq	291(%r8,%rax,4), %r9, %r15
# CHECK: encoding: [0x62,0x54,0x84,0x18,0x13,0x8c,0x80,0x23,0x01,0x00,0x00]
         adcq	291(%r8,%rax,4), %r9, %r15
