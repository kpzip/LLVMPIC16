# RUN: llvm-mc -triple x86_64 --show-encoding %s | FileCheck %s

# CHECK: cfcmovbw	%r17w, %r21w, %r25w
# CHECK: encoding: [0x62,0xec,0x35,0x14,0x42,0xe9]
         cfcmovbw	%r17w, %r21w, %r25w

# CHECK: cfcmovbw	%r17w, %r21w
# CHECK: encoding: [0x62,0xec,0x7d,0x0c,0x42,0xcd]
         cfcmovbw	%r17w, %r21w

# CHECK: cfcmovbw	%r17w, 291(%r28,%r29,4)
# CHECK: encoding: [0x62,0x8c,0x79,0x0c,0x42,0x8c,0xac,0x23,0x01,0x00,0x00]
         cfcmovbw	%r17w, 291(%r28,%r29,4)

# CHECK: cfcmovbl	%r18d, %r22d, %r26d
# CHECK: encoding: [0x62,0xec,0x2c,0x14,0x42,0xf2]
         cfcmovbl	%r18d, %r22d, %r26d

# CHECK: cfcmovbl	%r18d, %r22d
# CHECK: encoding: [0x62,0xec,0x7c,0x0c,0x42,0xd6]
         cfcmovbl	%r18d, %r22d

# CHECK: cfcmovbl	%r18d, 291(%r28,%r29,4)
# CHECK: encoding: [0x62,0x8c,0x78,0x0c,0x42,0x94,0xac,0x23,0x01,0x00,0x00]
         cfcmovbl	%r18d, 291(%r28,%r29,4)

# CHECK: cfcmovbq	%r19, %r23, %r27
# CHECK: encoding: [0x62,0xec,0xa4,0x14,0x42,0xfb]
         cfcmovbq	%r19, %r23, %r27

# CHECK: cfcmovbq	%r19, %r23
# CHECK: encoding: [0x62,0xec,0xfc,0x0c,0x42,0xdf]
         cfcmovbq	%r19, %r23

# CHECK: cfcmovbq	%r19, 291(%r28,%r29,4)
# CHECK: encoding: [0x62,0x8c,0xf8,0x0c,0x42,0x9c,0xac,0x23,0x01,0x00,0x00]
         cfcmovbq	%r19, 291(%r28,%r29,4)

# CHECK: cfcmovbw	291(%r28,%r29,4), %r17w, %r21w
# CHECK: encoding: [0x62,0x8c,0x51,0x14,0x42,0x8c,0xac,0x23,0x01,0x00,0x00]
         cfcmovbw	291(%r28,%r29,4), %r17w, %r21w

# CHECK: cfcmovbw	291(%r28,%r29,4), %r17w
# CHECK: encoding: [0x62,0x8c,0x79,0x08,0x42,0x8c,0xac,0x23,0x01,0x00,0x00]
         cfcmovbw	291(%r28,%r29,4), %r17w

# CHECK: cfcmovbl	291(%r28,%r29,4), %r18d, %r22d
# CHECK: encoding: [0x62,0x8c,0x48,0x14,0x42,0x94,0xac,0x23,0x01,0x00,0x00]
         cfcmovbl	291(%r28,%r29,4), %r18d, %r22d

# CHECK: cfcmovbl	291(%r28,%r29,4), %r18d
# CHECK: encoding: [0x62,0x8c,0x78,0x08,0x42,0x94,0xac,0x23,0x01,0x00,0x00]
         cfcmovbl	291(%r28,%r29,4), %r18d

# CHECK: cfcmovbq	291(%r28,%r29,4), %r19, %r23
# CHECK: encoding: [0x62,0x8c,0xc0,0x14,0x42,0x9c,0xac,0x23,0x01,0x00,0x00]
         cfcmovbq	291(%r28,%r29,4), %r19, %r23

# CHECK: cfcmovbq	291(%r28,%r29,4), %r19
# CHECK: encoding: [0x62,0x8c,0xf8,0x08,0x42,0x9c,0xac,0x23,0x01,0x00,0x00]
         cfcmovbq	291(%r28,%r29,4), %r19

# CHECK: cfcmovbew	%r17w, %r21w, %r25w
# CHECK: encoding: [0x62,0xec,0x35,0x14,0x46,0xe9]
         cfcmovbew	%r17w, %r21w, %r25w

# CHECK: cfcmovbew	%r17w, %r21w
# CHECK: encoding: [0x62,0xec,0x7d,0x0c,0x46,0xcd]
         cfcmovbew	%r17w, %r21w

# CHECK: cfcmovbew	%r17w, 291(%r28,%r29,4)
# CHECK: encoding: [0x62,0x8c,0x79,0x0c,0x46,0x8c,0xac,0x23,0x01,0x00,0x00]
         cfcmovbew	%r17w, 291(%r28,%r29,4)

# CHECK: cfcmovbel	%r18d, %r22d, %r26d
# CHECK: encoding: [0x62,0xec,0x2c,0x14,0x46,0xf2]
         cfcmovbel	%r18d, %r22d, %r26d

# CHECK: cfcmovbel	%r18d, %r22d
# CHECK: encoding: [0x62,0xec,0x7c,0x0c,0x46,0xd6]
         cfcmovbel	%r18d, %r22d

# CHECK: cfcmovbel	%r18d, 291(%r28,%r29,4)
# CHECK: encoding: [0x62,0x8c,0x78,0x0c,0x46,0x94,0xac,0x23,0x01,0x00,0x00]
         cfcmovbel	%r18d, 291(%r28,%r29,4)

# CHECK: cfcmovbeq	%r19, %r23, %r27
# CHECK: encoding: [0x62,0xec,0xa4,0x14,0x46,0xfb]
         cfcmovbeq	%r19, %r23, %r27

# CHECK: cfcmovbeq	%r19, %r23
# CHECK: encoding: [0x62,0xec,0xfc,0x0c,0x46,0xdf]
         cfcmovbeq	%r19, %r23

# CHECK: cfcmovbeq	%r19, 291(%r28,%r29,4)
# CHECK: encoding: [0x62,0x8c,0xf8,0x0c,0x46,0x9c,0xac,0x23,0x01,0x00,0x00]
         cfcmovbeq	%r19, 291(%r28,%r29,4)

# CHECK: cfcmovbew	291(%r28,%r29,4), %r17w, %r21w
# CHECK: encoding: [0x62,0x8c,0x51,0x14,0x46,0x8c,0xac,0x23,0x01,0x00,0x00]
         cfcmovbew	291(%r28,%r29,4), %r17w, %r21w

# CHECK: cfcmovbew	291(%r28,%r29,4), %r17w
# CHECK: encoding: [0x62,0x8c,0x79,0x08,0x46,0x8c,0xac,0x23,0x01,0x00,0x00]
         cfcmovbew	291(%r28,%r29,4), %r17w

# CHECK: cfcmovbel	291(%r28,%r29,4), %r18d, %r22d
# CHECK: encoding: [0x62,0x8c,0x48,0x14,0x46,0x94,0xac,0x23,0x01,0x00,0x00]
         cfcmovbel	291(%r28,%r29,4), %r18d, %r22d

# CHECK: cfcmovbel	291(%r28,%r29,4), %r18d
# CHECK: encoding: [0x62,0x8c,0x78,0x08,0x46,0x94,0xac,0x23,0x01,0x00,0x00]
         cfcmovbel	291(%r28,%r29,4), %r18d

# CHECK: cfcmovbeq	291(%r28,%r29,4), %r19, %r23
# CHECK: encoding: [0x62,0x8c,0xc0,0x14,0x46,0x9c,0xac,0x23,0x01,0x00,0x00]
         cfcmovbeq	291(%r28,%r29,4), %r19, %r23

# CHECK: cfcmovbeq	291(%r28,%r29,4), %r19
# CHECK: encoding: [0x62,0x8c,0xf8,0x08,0x46,0x9c,0xac,0x23,0x01,0x00,0x00]
         cfcmovbeq	291(%r28,%r29,4), %r19

# CHECK: cfcmovlw	%r17w, %r21w, %r25w
# CHECK: encoding: [0x62,0xec,0x35,0x14,0x4c,0xe9]
         cfcmovlw	%r17w, %r21w, %r25w

# CHECK: cfcmovlw	%r17w, %r21w
# CHECK: encoding: [0x62,0xec,0x7d,0x0c,0x4c,0xcd]
         cfcmovlw	%r17w, %r21w

# CHECK: cfcmovlw	%r17w, 291(%r28,%r29,4)
# CHECK: encoding: [0x62,0x8c,0x79,0x0c,0x4c,0x8c,0xac,0x23,0x01,0x00,0x00]
         cfcmovlw	%r17w, 291(%r28,%r29,4)

# CHECK: cfcmovll	%r18d, %r22d, %r26d
# CHECK: encoding: [0x62,0xec,0x2c,0x14,0x4c,0xf2]
         cfcmovll	%r18d, %r22d, %r26d

# CHECK: cfcmovll	%r18d, %r22d
# CHECK: encoding: [0x62,0xec,0x7c,0x0c,0x4c,0xd6]
         cfcmovll	%r18d, %r22d

# CHECK: cfcmovll	%r18d, 291(%r28,%r29,4)
# CHECK: encoding: [0x62,0x8c,0x78,0x0c,0x4c,0x94,0xac,0x23,0x01,0x00,0x00]
         cfcmovll	%r18d, 291(%r28,%r29,4)

# CHECK: cfcmovlq	%r19, %r23, %r27
# CHECK: encoding: [0x62,0xec,0xa4,0x14,0x4c,0xfb]
         cfcmovlq	%r19, %r23, %r27

# CHECK: cfcmovlq	%r19, %r23
# CHECK: encoding: [0x62,0xec,0xfc,0x0c,0x4c,0xdf]
         cfcmovlq	%r19, %r23

# CHECK: cfcmovlq	%r19, 291(%r28,%r29,4)
# CHECK: encoding: [0x62,0x8c,0xf8,0x0c,0x4c,0x9c,0xac,0x23,0x01,0x00,0x00]
         cfcmovlq	%r19, 291(%r28,%r29,4)

# CHECK: cfcmovlw	291(%r28,%r29,4), %r17w, %r21w
# CHECK: encoding: [0x62,0x8c,0x51,0x14,0x4c,0x8c,0xac,0x23,0x01,0x00,0x00]
         cfcmovlw	291(%r28,%r29,4), %r17w, %r21w

# CHECK: cfcmovlw	291(%r28,%r29,4), %r17w
# CHECK: encoding: [0x62,0x8c,0x79,0x08,0x4c,0x8c,0xac,0x23,0x01,0x00,0x00]
         cfcmovlw	291(%r28,%r29,4), %r17w

# CHECK: cfcmovll	291(%r28,%r29,4), %r18d, %r22d
# CHECK: encoding: [0x62,0x8c,0x48,0x14,0x4c,0x94,0xac,0x23,0x01,0x00,0x00]
         cfcmovll	291(%r28,%r29,4), %r18d, %r22d

# CHECK: cfcmovll	291(%r28,%r29,4), %r18d
# CHECK: encoding: [0x62,0x8c,0x78,0x08,0x4c,0x94,0xac,0x23,0x01,0x00,0x00]
         cfcmovll	291(%r28,%r29,4), %r18d

# CHECK: cfcmovlq	291(%r28,%r29,4), %r19, %r23
# CHECK: encoding: [0x62,0x8c,0xc0,0x14,0x4c,0x9c,0xac,0x23,0x01,0x00,0x00]
         cfcmovlq	291(%r28,%r29,4), %r19, %r23

# CHECK: cfcmovlq	291(%r28,%r29,4), %r19
# CHECK: encoding: [0x62,0x8c,0xf8,0x08,0x4c,0x9c,0xac,0x23,0x01,0x00,0x00]
         cfcmovlq	291(%r28,%r29,4), %r19

# CHECK: cfcmovlew	%r17w, %r21w, %r25w
# CHECK: encoding: [0x62,0xec,0x35,0x14,0x4e,0xe9]
         cfcmovlew	%r17w, %r21w, %r25w

# CHECK: cfcmovlew	%r17w, %r21w
# CHECK: encoding: [0x62,0xec,0x7d,0x0c,0x4e,0xcd]
         cfcmovlew	%r17w, %r21w

# CHECK: cfcmovlew	%r17w, 291(%r28,%r29,4)
# CHECK: encoding: [0x62,0x8c,0x79,0x0c,0x4e,0x8c,0xac,0x23,0x01,0x00,0x00]
         cfcmovlew	%r17w, 291(%r28,%r29,4)

# CHECK: cfcmovlel	%r18d, %r22d, %r26d
# CHECK: encoding: [0x62,0xec,0x2c,0x14,0x4e,0xf2]
         cfcmovlel	%r18d, %r22d, %r26d

# CHECK: cfcmovlel	%r18d, %r22d
# CHECK: encoding: [0x62,0xec,0x7c,0x0c,0x4e,0xd6]
         cfcmovlel	%r18d, %r22d

# CHECK: cfcmovlel	%r18d, 291(%r28,%r29,4)
# CHECK: encoding: [0x62,0x8c,0x78,0x0c,0x4e,0x94,0xac,0x23,0x01,0x00,0x00]
         cfcmovlel	%r18d, 291(%r28,%r29,4)

# CHECK: cfcmovleq	%r19, %r23, %r27
# CHECK: encoding: [0x62,0xec,0xa4,0x14,0x4e,0xfb]
         cfcmovleq	%r19, %r23, %r27

# CHECK: cfcmovleq	%r19, %r23
# CHECK: encoding: [0x62,0xec,0xfc,0x0c,0x4e,0xdf]
         cfcmovleq	%r19, %r23

# CHECK: cfcmovleq	%r19, 291(%r28,%r29,4)
# CHECK: encoding: [0x62,0x8c,0xf8,0x0c,0x4e,0x9c,0xac,0x23,0x01,0x00,0x00]
         cfcmovleq	%r19, 291(%r28,%r29,4)

# CHECK: cfcmovlew	291(%r28,%r29,4), %r17w, %r21w
# CHECK: encoding: [0x62,0x8c,0x51,0x14,0x4e,0x8c,0xac,0x23,0x01,0x00,0x00]
         cfcmovlew	291(%r28,%r29,4), %r17w, %r21w

# CHECK: cfcmovlew	291(%r28,%r29,4), %r17w
# CHECK: encoding: [0x62,0x8c,0x79,0x08,0x4e,0x8c,0xac,0x23,0x01,0x00,0x00]
         cfcmovlew	291(%r28,%r29,4), %r17w

# CHECK: cfcmovlel	291(%r28,%r29,4), %r18d, %r22d
# CHECK: encoding: [0x62,0x8c,0x48,0x14,0x4e,0x94,0xac,0x23,0x01,0x00,0x00]
         cfcmovlel	291(%r28,%r29,4), %r18d, %r22d

# CHECK: cfcmovlel	291(%r28,%r29,4), %r18d
# CHECK: encoding: [0x62,0x8c,0x78,0x08,0x4e,0x94,0xac,0x23,0x01,0x00,0x00]
         cfcmovlel	291(%r28,%r29,4), %r18d

# CHECK: cfcmovleq	291(%r28,%r29,4), %r19, %r23
# CHECK: encoding: [0x62,0x8c,0xc0,0x14,0x4e,0x9c,0xac,0x23,0x01,0x00,0x00]
         cfcmovleq	291(%r28,%r29,4), %r19, %r23

# CHECK: cfcmovleq	291(%r28,%r29,4), %r19
# CHECK: encoding: [0x62,0x8c,0xf8,0x08,0x4e,0x9c,0xac,0x23,0x01,0x00,0x00]
         cfcmovleq	291(%r28,%r29,4), %r19

# CHECK: cfcmovaew	%r17w, %r21w, %r25w
# CHECK: encoding: [0x62,0xec,0x35,0x14,0x43,0xe9]
         cfcmovaew	%r17w, %r21w, %r25w

# CHECK: cfcmovaew	%r17w, %r21w
# CHECK: encoding: [0x62,0xec,0x7d,0x0c,0x43,0xcd]
         cfcmovaew	%r17w, %r21w

# CHECK: cfcmovaew	%r17w, 291(%r28,%r29,4)
# CHECK: encoding: [0x62,0x8c,0x79,0x0c,0x43,0x8c,0xac,0x23,0x01,0x00,0x00]
         cfcmovaew	%r17w, 291(%r28,%r29,4)

# CHECK: cfcmovael	%r18d, %r22d, %r26d
# CHECK: encoding: [0x62,0xec,0x2c,0x14,0x43,0xf2]
         cfcmovael	%r18d, %r22d, %r26d

# CHECK: cfcmovael	%r18d, %r22d
# CHECK: encoding: [0x62,0xec,0x7c,0x0c,0x43,0xd6]
         cfcmovael	%r18d, %r22d

# CHECK: cfcmovael	%r18d, 291(%r28,%r29,4)
# CHECK: encoding: [0x62,0x8c,0x78,0x0c,0x43,0x94,0xac,0x23,0x01,0x00,0x00]
         cfcmovael	%r18d, 291(%r28,%r29,4)

# CHECK: cfcmovaeq	%r19, %r23, %r27
# CHECK: encoding: [0x62,0xec,0xa4,0x14,0x43,0xfb]
         cfcmovaeq	%r19, %r23, %r27

# CHECK: cfcmovaeq	%r19, %r23
# CHECK: encoding: [0x62,0xec,0xfc,0x0c,0x43,0xdf]
         cfcmovaeq	%r19, %r23

# CHECK: cfcmovaeq	%r19, 291(%r28,%r29,4)
# CHECK: encoding: [0x62,0x8c,0xf8,0x0c,0x43,0x9c,0xac,0x23,0x01,0x00,0x00]
         cfcmovaeq	%r19, 291(%r28,%r29,4)

# CHECK: cfcmovaew	291(%r28,%r29,4), %r17w, %r21w
# CHECK: encoding: [0x62,0x8c,0x51,0x14,0x43,0x8c,0xac,0x23,0x01,0x00,0x00]
         cfcmovaew	291(%r28,%r29,4), %r17w, %r21w

# CHECK: cfcmovaew	291(%r28,%r29,4), %r17w
# CHECK: encoding: [0x62,0x8c,0x79,0x08,0x43,0x8c,0xac,0x23,0x01,0x00,0x00]
         cfcmovaew	291(%r28,%r29,4), %r17w

# CHECK: cfcmovael	291(%r28,%r29,4), %r18d, %r22d
# CHECK: encoding: [0x62,0x8c,0x48,0x14,0x43,0x94,0xac,0x23,0x01,0x00,0x00]
         cfcmovael	291(%r28,%r29,4), %r18d, %r22d

# CHECK: cfcmovael	291(%r28,%r29,4), %r18d
# CHECK: encoding: [0x62,0x8c,0x78,0x08,0x43,0x94,0xac,0x23,0x01,0x00,0x00]
         cfcmovael	291(%r28,%r29,4), %r18d

# CHECK: cfcmovaeq	291(%r28,%r29,4), %r19, %r23
# CHECK: encoding: [0x62,0x8c,0xc0,0x14,0x43,0x9c,0xac,0x23,0x01,0x00,0x00]
         cfcmovaeq	291(%r28,%r29,4), %r19, %r23

# CHECK: cfcmovaeq	291(%r28,%r29,4), %r19
# CHECK: encoding: [0x62,0x8c,0xf8,0x08,0x43,0x9c,0xac,0x23,0x01,0x00,0x00]
         cfcmovaeq	291(%r28,%r29,4), %r19

# CHECK: cfcmovaw	%r17w, %r21w, %r25w
# CHECK: encoding: [0x62,0xec,0x35,0x14,0x47,0xe9]
         cfcmovaw	%r17w, %r21w, %r25w

# CHECK: cfcmovaw	%r17w, %r21w
# CHECK: encoding: [0x62,0xec,0x7d,0x0c,0x47,0xcd]
         cfcmovaw	%r17w, %r21w

# CHECK: cfcmovaw	%r17w, 291(%r28,%r29,4)
# CHECK: encoding: [0x62,0x8c,0x79,0x0c,0x47,0x8c,0xac,0x23,0x01,0x00,0x00]
         cfcmovaw	%r17w, 291(%r28,%r29,4)

# CHECK: cfcmoval	%r18d, %r22d, %r26d
# CHECK: encoding: [0x62,0xec,0x2c,0x14,0x47,0xf2]
         cfcmoval	%r18d, %r22d, %r26d

# CHECK: cfcmoval	%r18d, %r22d
# CHECK: encoding: [0x62,0xec,0x7c,0x0c,0x47,0xd6]
         cfcmoval	%r18d, %r22d

# CHECK: cfcmoval	%r18d, 291(%r28,%r29,4)
# CHECK: encoding: [0x62,0x8c,0x78,0x0c,0x47,0x94,0xac,0x23,0x01,0x00,0x00]
         cfcmoval	%r18d, 291(%r28,%r29,4)

# CHECK: cfcmovaq	%r19, %r23, %r27
# CHECK: encoding: [0x62,0xec,0xa4,0x14,0x47,0xfb]
         cfcmovaq	%r19, %r23, %r27

# CHECK: cfcmovaq	%r19, %r23
# CHECK: encoding: [0x62,0xec,0xfc,0x0c,0x47,0xdf]
         cfcmovaq	%r19, %r23

# CHECK: cfcmovaq	%r19, 291(%r28,%r29,4)
# CHECK: encoding: [0x62,0x8c,0xf8,0x0c,0x47,0x9c,0xac,0x23,0x01,0x00,0x00]
         cfcmovaq	%r19, 291(%r28,%r29,4)

# CHECK: cfcmovaw	291(%r28,%r29,4), %r17w, %r21w
# CHECK: encoding: [0x62,0x8c,0x51,0x14,0x47,0x8c,0xac,0x23,0x01,0x00,0x00]
         cfcmovaw	291(%r28,%r29,4), %r17w, %r21w

# CHECK: cfcmovaw	291(%r28,%r29,4), %r17w
# CHECK: encoding: [0x62,0x8c,0x79,0x08,0x47,0x8c,0xac,0x23,0x01,0x00,0x00]
         cfcmovaw	291(%r28,%r29,4), %r17w

# CHECK: cfcmoval	291(%r28,%r29,4), %r18d, %r22d
# CHECK: encoding: [0x62,0x8c,0x48,0x14,0x47,0x94,0xac,0x23,0x01,0x00,0x00]
         cfcmoval	291(%r28,%r29,4), %r18d, %r22d

# CHECK: cfcmoval	291(%r28,%r29,4), %r18d
# CHECK: encoding: [0x62,0x8c,0x78,0x08,0x47,0x94,0xac,0x23,0x01,0x00,0x00]
         cfcmoval	291(%r28,%r29,4), %r18d

# CHECK: cfcmovaq	291(%r28,%r29,4), %r19, %r23
# CHECK: encoding: [0x62,0x8c,0xc0,0x14,0x47,0x9c,0xac,0x23,0x01,0x00,0x00]
         cfcmovaq	291(%r28,%r29,4), %r19, %r23

# CHECK: cfcmovaq	291(%r28,%r29,4), %r19
# CHECK: encoding: [0x62,0x8c,0xf8,0x08,0x47,0x9c,0xac,0x23,0x01,0x00,0x00]
         cfcmovaq	291(%r28,%r29,4), %r19

# CHECK: cfcmovgew	%r17w, %r21w, %r25w
# CHECK: encoding: [0x62,0xec,0x35,0x14,0x4d,0xe9]
         cfcmovgew	%r17w, %r21w, %r25w

# CHECK: cfcmovgew	%r17w, %r21w
# CHECK: encoding: [0x62,0xec,0x7d,0x0c,0x4d,0xcd]
         cfcmovgew	%r17w, %r21w

# CHECK: cfcmovgew	%r17w, 291(%r28,%r29,4)
# CHECK: encoding: [0x62,0x8c,0x79,0x0c,0x4d,0x8c,0xac,0x23,0x01,0x00,0x00]
         cfcmovgew	%r17w, 291(%r28,%r29,4)

# CHECK: cfcmovgel	%r18d, %r22d, %r26d
# CHECK: encoding: [0x62,0xec,0x2c,0x14,0x4d,0xf2]
         cfcmovgel	%r18d, %r22d, %r26d

# CHECK: cfcmovgel	%r18d, %r22d
# CHECK: encoding: [0x62,0xec,0x7c,0x0c,0x4d,0xd6]
         cfcmovgel	%r18d, %r22d

# CHECK: cfcmovgel	%r18d, 291(%r28,%r29,4)
# CHECK: encoding: [0x62,0x8c,0x78,0x0c,0x4d,0x94,0xac,0x23,0x01,0x00,0x00]
         cfcmovgel	%r18d, 291(%r28,%r29,4)

# CHECK: cfcmovgeq	%r19, %r23, %r27
# CHECK: encoding: [0x62,0xec,0xa4,0x14,0x4d,0xfb]
         cfcmovgeq	%r19, %r23, %r27

# CHECK: cfcmovgeq	%r19, %r23
# CHECK: encoding: [0x62,0xec,0xfc,0x0c,0x4d,0xdf]
         cfcmovgeq	%r19, %r23

# CHECK: cfcmovgeq	%r19, 291(%r28,%r29,4)
# CHECK: encoding: [0x62,0x8c,0xf8,0x0c,0x4d,0x9c,0xac,0x23,0x01,0x00,0x00]
         cfcmovgeq	%r19, 291(%r28,%r29,4)

# CHECK: cfcmovgew	291(%r28,%r29,4), %r17w, %r21w
# CHECK: encoding: [0x62,0x8c,0x51,0x14,0x4d,0x8c,0xac,0x23,0x01,0x00,0x00]
         cfcmovgew	291(%r28,%r29,4), %r17w, %r21w

# CHECK: cfcmovgew	291(%r28,%r29,4), %r17w
# CHECK: encoding: [0x62,0x8c,0x79,0x08,0x4d,0x8c,0xac,0x23,0x01,0x00,0x00]
         cfcmovgew	291(%r28,%r29,4), %r17w

# CHECK: cfcmovgel	291(%r28,%r29,4), %r18d, %r22d
# CHECK: encoding: [0x62,0x8c,0x48,0x14,0x4d,0x94,0xac,0x23,0x01,0x00,0x00]
         cfcmovgel	291(%r28,%r29,4), %r18d, %r22d

# CHECK: cfcmovgel	291(%r28,%r29,4), %r18d
# CHECK: encoding: [0x62,0x8c,0x78,0x08,0x4d,0x94,0xac,0x23,0x01,0x00,0x00]
         cfcmovgel	291(%r28,%r29,4), %r18d

# CHECK: cfcmovgeq	291(%r28,%r29,4), %r19, %r23
# CHECK: encoding: [0x62,0x8c,0xc0,0x14,0x4d,0x9c,0xac,0x23,0x01,0x00,0x00]
         cfcmovgeq	291(%r28,%r29,4), %r19, %r23

# CHECK: cfcmovgeq	291(%r28,%r29,4), %r19
# CHECK: encoding: [0x62,0x8c,0xf8,0x08,0x4d,0x9c,0xac,0x23,0x01,0x00,0x00]
         cfcmovgeq	291(%r28,%r29,4), %r19

# CHECK: cfcmovnow	%r17w, %r21w, %r25w
# CHECK: encoding: [0x62,0xec,0x35,0x14,0x41,0xe9]
         cfcmovnow	%r17w, %r21w, %r25w

# CHECK: cfcmovnow	%r17w, %r21w
# CHECK: encoding: [0x62,0xec,0x7d,0x0c,0x41,0xcd]
         cfcmovnow	%r17w, %r21w

# CHECK: cfcmovnow	%r17w, 291(%r28,%r29,4)
# CHECK: encoding: [0x62,0x8c,0x79,0x0c,0x41,0x8c,0xac,0x23,0x01,0x00,0x00]
         cfcmovnow	%r17w, 291(%r28,%r29,4)

# CHECK: cfcmovnol	%r18d, %r22d, %r26d
# CHECK: encoding: [0x62,0xec,0x2c,0x14,0x41,0xf2]
         cfcmovnol	%r18d, %r22d, %r26d

# CHECK: cfcmovnol	%r18d, %r22d
# CHECK: encoding: [0x62,0xec,0x7c,0x0c,0x41,0xd6]
         cfcmovnol	%r18d, %r22d

# CHECK: cfcmovnol	%r18d, 291(%r28,%r29,4)
# CHECK: encoding: [0x62,0x8c,0x78,0x0c,0x41,0x94,0xac,0x23,0x01,0x00,0x00]
         cfcmovnol	%r18d, 291(%r28,%r29,4)

# CHECK: cfcmovnoq	%r19, %r23, %r27
# CHECK: encoding: [0x62,0xec,0xa4,0x14,0x41,0xfb]
         cfcmovnoq	%r19, %r23, %r27

# CHECK: cfcmovnoq	%r19, %r23
# CHECK: encoding: [0x62,0xec,0xfc,0x0c,0x41,0xdf]
         cfcmovnoq	%r19, %r23

# CHECK: cfcmovnoq	%r19, 291(%r28,%r29,4)
# CHECK: encoding: [0x62,0x8c,0xf8,0x0c,0x41,0x9c,0xac,0x23,0x01,0x00,0x00]
         cfcmovnoq	%r19, 291(%r28,%r29,4)

# CHECK: cfcmovnow	291(%r28,%r29,4), %r17w, %r21w
# CHECK: encoding: [0x62,0x8c,0x51,0x14,0x41,0x8c,0xac,0x23,0x01,0x00,0x00]
         cfcmovnow	291(%r28,%r29,4), %r17w, %r21w

# CHECK: cfcmovnow	291(%r28,%r29,4), %r17w
# CHECK: encoding: [0x62,0x8c,0x79,0x08,0x41,0x8c,0xac,0x23,0x01,0x00,0x00]
         cfcmovnow	291(%r28,%r29,4), %r17w

# CHECK: cfcmovnol	291(%r28,%r29,4), %r18d, %r22d
# CHECK: encoding: [0x62,0x8c,0x48,0x14,0x41,0x94,0xac,0x23,0x01,0x00,0x00]
         cfcmovnol	291(%r28,%r29,4), %r18d, %r22d

# CHECK: cfcmovnol	291(%r28,%r29,4), %r18d
# CHECK: encoding: [0x62,0x8c,0x78,0x08,0x41,0x94,0xac,0x23,0x01,0x00,0x00]
         cfcmovnol	291(%r28,%r29,4), %r18d

# CHECK: cfcmovnoq	291(%r28,%r29,4), %r19, %r23
# CHECK: encoding: [0x62,0x8c,0xc0,0x14,0x41,0x9c,0xac,0x23,0x01,0x00,0x00]
         cfcmovnoq	291(%r28,%r29,4), %r19, %r23

# CHECK: cfcmovnoq	291(%r28,%r29,4), %r19
# CHECK: encoding: [0x62,0x8c,0xf8,0x08,0x41,0x9c,0xac,0x23,0x01,0x00,0x00]
         cfcmovnoq	291(%r28,%r29,4), %r19

# CHECK: cfcmovnpw	%r17w, %r21w, %r25w
# CHECK: encoding: [0x62,0xec,0x35,0x14,0x4b,0xe9]
         cfcmovnpw	%r17w, %r21w, %r25w

# CHECK: cfcmovnpw	%r17w, %r21w
# CHECK: encoding: [0x62,0xec,0x7d,0x0c,0x4b,0xcd]
         cfcmovnpw	%r17w, %r21w

# CHECK: cfcmovnpw	%r17w, 291(%r28,%r29,4)
# CHECK: encoding: [0x62,0x8c,0x79,0x0c,0x4b,0x8c,0xac,0x23,0x01,0x00,0x00]
         cfcmovnpw	%r17w, 291(%r28,%r29,4)

# CHECK: cfcmovnpl	%r18d, %r22d, %r26d
# CHECK: encoding: [0x62,0xec,0x2c,0x14,0x4b,0xf2]
         cfcmovnpl	%r18d, %r22d, %r26d

# CHECK: cfcmovnpl	%r18d, %r22d
# CHECK: encoding: [0x62,0xec,0x7c,0x0c,0x4b,0xd6]
         cfcmovnpl	%r18d, %r22d

# CHECK: cfcmovnpl	%r18d, 291(%r28,%r29,4)
# CHECK: encoding: [0x62,0x8c,0x78,0x0c,0x4b,0x94,0xac,0x23,0x01,0x00,0x00]
         cfcmovnpl	%r18d, 291(%r28,%r29,4)

# CHECK: cfcmovnpq	%r19, %r23, %r27
# CHECK: encoding: [0x62,0xec,0xa4,0x14,0x4b,0xfb]
         cfcmovnpq	%r19, %r23, %r27

# CHECK: cfcmovnpq	%r19, %r23
# CHECK: encoding: [0x62,0xec,0xfc,0x0c,0x4b,0xdf]
         cfcmovnpq	%r19, %r23

# CHECK: cfcmovnpq	%r19, 291(%r28,%r29,4)
# CHECK: encoding: [0x62,0x8c,0xf8,0x0c,0x4b,0x9c,0xac,0x23,0x01,0x00,0x00]
         cfcmovnpq	%r19, 291(%r28,%r29,4)

# CHECK: cfcmovnpw	291(%r28,%r29,4), %r17w, %r21w
# CHECK: encoding: [0x62,0x8c,0x51,0x14,0x4b,0x8c,0xac,0x23,0x01,0x00,0x00]
         cfcmovnpw	291(%r28,%r29,4), %r17w, %r21w

# CHECK: cfcmovnpw	291(%r28,%r29,4), %r17w
# CHECK: encoding: [0x62,0x8c,0x79,0x08,0x4b,0x8c,0xac,0x23,0x01,0x00,0x00]
         cfcmovnpw	291(%r28,%r29,4), %r17w

# CHECK: cfcmovnpl	291(%r28,%r29,4), %r18d, %r22d
# CHECK: encoding: [0x62,0x8c,0x48,0x14,0x4b,0x94,0xac,0x23,0x01,0x00,0x00]
         cfcmovnpl	291(%r28,%r29,4), %r18d, %r22d

# CHECK: cfcmovnpl	291(%r28,%r29,4), %r18d
# CHECK: encoding: [0x62,0x8c,0x78,0x08,0x4b,0x94,0xac,0x23,0x01,0x00,0x00]
         cfcmovnpl	291(%r28,%r29,4), %r18d

# CHECK: cfcmovnpq	291(%r28,%r29,4), %r19, %r23
# CHECK: encoding: [0x62,0x8c,0xc0,0x14,0x4b,0x9c,0xac,0x23,0x01,0x00,0x00]
         cfcmovnpq	291(%r28,%r29,4), %r19, %r23

# CHECK: cfcmovnpq	291(%r28,%r29,4), %r19
# CHECK: encoding: [0x62,0x8c,0xf8,0x08,0x4b,0x9c,0xac,0x23,0x01,0x00,0x00]
         cfcmovnpq	291(%r28,%r29,4), %r19

# CHECK: cfcmovnsw	%r17w, %r21w, %r25w
# CHECK: encoding: [0x62,0xec,0x35,0x14,0x49,0xe9]
         cfcmovnsw	%r17w, %r21w, %r25w

# CHECK: cfcmovnsw	%r17w, %r21w
# CHECK: encoding: [0x62,0xec,0x7d,0x0c,0x49,0xcd]
         cfcmovnsw	%r17w, %r21w

# CHECK: cfcmovnsw	%r17w, 291(%r28,%r29,4)
# CHECK: encoding: [0x62,0x8c,0x79,0x0c,0x49,0x8c,0xac,0x23,0x01,0x00,0x00]
         cfcmovnsw	%r17w, 291(%r28,%r29,4)

# CHECK: cfcmovnsl	%r18d, %r22d, %r26d
# CHECK: encoding: [0x62,0xec,0x2c,0x14,0x49,0xf2]
         cfcmovnsl	%r18d, %r22d, %r26d

# CHECK: cfcmovnsl	%r18d, %r22d
# CHECK: encoding: [0x62,0xec,0x7c,0x0c,0x49,0xd6]
         cfcmovnsl	%r18d, %r22d

# CHECK: cfcmovnsl	%r18d, 291(%r28,%r29,4)
# CHECK: encoding: [0x62,0x8c,0x78,0x0c,0x49,0x94,0xac,0x23,0x01,0x00,0x00]
         cfcmovnsl	%r18d, 291(%r28,%r29,4)

# CHECK: cfcmovnsq	%r19, %r23, %r27
# CHECK: encoding: [0x62,0xec,0xa4,0x14,0x49,0xfb]
         cfcmovnsq	%r19, %r23, %r27

# CHECK: cfcmovnsq	%r19, %r23
# CHECK: encoding: [0x62,0xec,0xfc,0x0c,0x49,0xdf]
         cfcmovnsq	%r19, %r23

# CHECK: cfcmovnsq	%r19, 291(%r28,%r29,4)
# CHECK: encoding: [0x62,0x8c,0xf8,0x0c,0x49,0x9c,0xac,0x23,0x01,0x00,0x00]
         cfcmovnsq	%r19, 291(%r28,%r29,4)

# CHECK: cfcmovnsw	291(%r28,%r29,4), %r17w, %r21w
# CHECK: encoding: [0x62,0x8c,0x51,0x14,0x49,0x8c,0xac,0x23,0x01,0x00,0x00]
         cfcmovnsw	291(%r28,%r29,4), %r17w, %r21w

# CHECK: cfcmovnsw	291(%r28,%r29,4), %r17w
# CHECK: encoding: [0x62,0x8c,0x79,0x08,0x49,0x8c,0xac,0x23,0x01,0x00,0x00]
         cfcmovnsw	291(%r28,%r29,4), %r17w

# CHECK: cfcmovnsl	291(%r28,%r29,4), %r18d, %r22d
# CHECK: encoding: [0x62,0x8c,0x48,0x14,0x49,0x94,0xac,0x23,0x01,0x00,0x00]
         cfcmovnsl	291(%r28,%r29,4), %r18d, %r22d

# CHECK: cfcmovnsl	291(%r28,%r29,4), %r18d
# CHECK: encoding: [0x62,0x8c,0x78,0x08,0x49,0x94,0xac,0x23,0x01,0x00,0x00]
         cfcmovnsl	291(%r28,%r29,4), %r18d

# CHECK: cfcmovnsq	291(%r28,%r29,4), %r19, %r23
# CHECK: encoding: [0x62,0x8c,0xc0,0x14,0x49,0x9c,0xac,0x23,0x01,0x00,0x00]
         cfcmovnsq	291(%r28,%r29,4), %r19, %r23

# CHECK: cfcmovnsq	291(%r28,%r29,4), %r19
# CHECK: encoding: [0x62,0x8c,0xf8,0x08,0x49,0x9c,0xac,0x23,0x01,0x00,0x00]
         cfcmovnsq	291(%r28,%r29,4), %r19

# CHECK: cfcmovnew	%r17w, %r21w, %r25w
# CHECK: encoding: [0x62,0xec,0x35,0x14,0x45,0xe9]
         cfcmovnew	%r17w, %r21w, %r25w

# CHECK: cfcmovnew	%r17w, %r21w
# CHECK: encoding: [0x62,0xec,0x7d,0x0c,0x45,0xcd]
         cfcmovnew	%r17w, %r21w

# CHECK: cfcmovnew	%r17w, 291(%r28,%r29,4)
# CHECK: encoding: [0x62,0x8c,0x79,0x0c,0x45,0x8c,0xac,0x23,0x01,0x00,0x00]
         cfcmovnew	%r17w, 291(%r28,%r29,4)

# CHECK: cfcmovnel	%r18d, %r22d, %r26d
# CHECK: encoding: [0x62,0xec,0x2c,0x14,0x45,0xf2]
         cfcmovnel	%r18d, %r22d, %r26d

# CHECK: cfcmovnel	%r18d, %r22d
# CHECK: encoding: [0x62,0xec,0x7c,0x0c,0x45,0xd6]
         cfcmovnel	%r18d, %r22d

# CHECK: cfcmovnel	%r18d, 291(%r28,%r29,4)
# CHECK: encoding: [0x62,0x8c,0x78,0x0c,0x45,0x94,0xac,0x23,0x01,0x00,0x00]
         cfcmovnel	%r18d, 291(%r28,%r29,4)

# CHECK: cfcmovneq	%r19, %r23, %r27
# CHECK: encoding: [0x62,0xec,0xa4,0x14,0x45,0xfb]
         cfcmovneq	%r19, %r23, %r27

# CHECK: cfcmovneq	%r19, %r23
# CHECK: encoding: [0x62,0xec,0xfc,0x0c,0x45,0xdf]
         cfcmovneq	%r19, %r23

# CHECK: cfcmovneq	%r19, 291(%r28,%r29,4)
# CHECK: encoding: [0x62,0x8c,0xf8,0x0c,0x45,0x9c,0xac,0x23,0x01,0x00,0x00]
         cfcmovneq	%r19, 291(%r28,%r29,4)

# CHECK: cfcmovnew	291(%r28,%r29,4), %r17w, %r21w
# CHECK: encoding: [0x62,0x8c,0x51,0x14,0x45,0x8c,0xac,0x23,0x01,0x00,0x00]
         cfcmovnew	291(%r28,%r29,4), %r17w, %r21w

# CHECK: cfcmovnew	291(%r28,%r29,4), %r17w
# CHECK: encoding: [0x62,0x8c,0x79,0x08,0x45,0x8c,0xac,0x23,0x01,0x00,0x00]
         cfcmovnew	291(%r28,%r29,4), %r17w

# CHECK: cfcmovnel	291(%r28,%r29,4), %r18d, %r22d
# CHECK: encoding: [0x62,0x8c,0x48,0x14,0x45,0x94,0xac,0x23,0x01,0x00,0x00]
         cfcmovnel	291(%r28,%r29,4), %r18d, %r22d

# CHECK: cfcmovnel	291(%r28,%r29,4), %r18d
# CHECK: encoding: [0x62,0x8c,0x78,0x08,0x45,0x94,0xac,0x23,0x01,0x00,0x00]
         cfcmovnel	291(%r28,%r29,4), %r18d

# CHECK: cfcmovneq	291(%r28,%r29,4), %r19, %r23
# CHECK: encoding: [0x62,0x8c,0xc0,0x14,0x45,0x9c,0xac,0x23,0x01,0x00,0x00]
         cfcmovneq	291(%r28,%r29,4), %r19, %r23

# CHECK: cfcmovneq	291(%r28,%r29,4), %r19
# CHECK: encoding: [0x62,0x8c,0xf8,0x08,0x45,0x9c,0xac,0x23,0x01,0x00,0x00]
         cfcmovneq	291(%r28,%r29,4), %r19

# CHECK: cfcmovpw	%r17w, %r21w, %r25w
# CHECK: encoding: [0x62,0xec,0x35,0x14,0x4a,0xe9]
         cfcmovpw	%r17w, %r21w, %r25w

# CHECK: cfcmovpw	%r17w, %r21w
# CHECK: encoding: [0x62,0xec,0x7d,0x0c,0x4a,0xcd]
         cfcmovpw	%r17w, %r21w

# CHECK: cfcmovpw	%r17w, 291(%r28,%r29,4)
# CHECK: encoding: [0x62,0x8c,0x79,0x0c,0x4a,0x8c,0xac,0x23,0x01,0x00,0x00]
         cfcmovpw	%r17w, 291(%r28,%r29,4)

# CHECK: cfcmovpl	%r18d, %r22d, %r26d
# CHECK: encoding: [0x62,0xec,0x2c,0x14,0x4a,0xf2]
         cfcmovpl	%r18d, %r22d, %r26d

# CHECK: cfcmovpl	%r18d, %r22d
# CHECK: encoding: [0x62,0xec,0x7c,0x0c,0x4a,0xd6]
         cfcmovpl	%r18d, %r22d

# CHECK: cfcmovpl	%r18d, 291(%r28,%r29,4)
# CHECK: encoding: [0x62,0x8c,0x78,0x0c,0x4a,0x94,0xac,0x23,0x01,0x00,0x00]
         cfcmovpl	%r18d, 291(%r28,%r29,4)

# CHECK: cfcmovpq	%r19, %r23, %r27
# CHECK: encoding: [0x62,0xec,0xa4,0x14,0x4a,0xfb]
         cfcmovpq	%r19, %r23, %r27

# CHECK: cfcmovpq	%r19, %r23
# CHECK: encoding: [0x62,0xec,0xfc,0x0c,0x4a,0xdf]
         cfcmovpq	%r19, %r23

# CHECK: cfcmovpq	%r19, 291(%r28,%r29,4)
# CHECK: encoding: [0x62,0x8c,0xf8,0x0c,0x4a,0x9c,0xac,0x23,0x01,0x00,0x00]
         cfcmovpq	%r19, 291(%r28,%r29,4)

# CHECK: cfcmovpw	291(%r28,%r29,4), %r17w, %r21w
# CHECK: encoding: [0x62,0x8c,0x51,0x14,0x4a,0x8c,0xac,0x23,0x01,0x00,0x00]
         cfcmovpw	291(%r28,%r29,4), %r17w, %r21w

# CHECK: cfcmovpw	291(%r28,%r29,4), %r17w
# CHECK: encoding: [0x62,0x8c,0x79,0x08,0x4a,0x8c,0xac,0x23,0x01,0x00,0x00]
         cfcmovpw	291(%r28,%r29,4), %r17w

# CHECK: cfcmovpl	291(%r28,%r29,4), %r18d, %r22d
# CHECK: encoding: [0x62,0x8c,0x48,0x14,0x4a,0x94,0xac,0x23,0x01,0x00,0x00]
         cfcmovpl	291(%r28,%r29,4), %r18d, %r22d

# CHECK: cfcmovpl	291(%r28,%r29,4), %r18d
# CHECK: encoding: [0x62,0x8c,0x78,0x08,0x4a,0x94,0xac,0x23,0x01,0x00,0x00]
         cfcmovpl	291(%r28,%r29,4), %r18d

# CHECK: cfcmovpq	291(%r28,%r29,4), %r19, %r23
# CHECK: encoding: [0x62,0x8c,0xc0,0x14,0x4a,0x9c,0xac,0x23,0x01,0x00,0x00]
         cfcmovpq	291(%r28,%r29,4), %r19, %r23

# CHECK: cfcmovpq	291(%r28,%r29,4), %r19
# CHECK: encoding: [0x62,0x8c,0xf8,0x08,0x4a,0x9c,0xac,0x23,0x01,0x00,0x00]
         cfcmovpq	291(%r28,%r29,4), %r19

# CHECK: cfcmovsw	%r17w, %r21w, %r25w
# CHECK: encoding: [0x62,0xec,0x35,0x14,0x48,0xe9]
         cfcmovsw	%r17w, %r21w, %r25w

# CHECK: cfcmovsw	%r17w, %r21w
# CHECK: encoding: [0x62,0xec,0x7d,0x0c,0x48,0xcd]
         cfcmovsw	%r17w, %r21w

# CHECK: cfcmovsw	%r17w, 291(%r28,%r29,4)
# CHECK: encoding: [0x62,0x8c,0x79,0x0c,0x48,0x8c,0xac,0x23,0x01,0x00,0x00]
         cfcmovsw	%r17w, 291(%r28,%r29,4)

# CHECK: cfcmovsl	%r18d, %r22d, %r26d
# CHECK: encoding: [0x62,0xec,0x2c,0x14,0x48,0xf2]
         cfcmovsl	%r18d, %r22d, %r26d

# CHECK: cfcmovsl	%r18d, %r22d
# CHECK: encoding: [0x62,0xec,0x7c,0x0c,0x48,0xd6]
         cfcmovsl	%r18d, %r22d

# CHECK: cfcmovsl	%r18d, 291(%r28,%r29,4)
# CHECK: encoding: [0x62,0x8c,0x78,0x0c,0x48,0x94,0xac,0x23,0x01,0x00,0x00]
         cfcmovsl	%r18d, 291(%r28,%r29,4)

# CHECK: cfcmovsq	%r19, %r23, %r27
# CHECK: encoding: [0x62,0xec,0xa4,0x14,0x48,0xfb]
         cfcmovsq	%r19, %r23, %r27

# CHECK: cfcmovsq	%r19, %r23
# CHECK: encoding: [0x62,0xec,0xfc,0x0c,0x48,0xdf]
         cfcmovsq	%r19, %r23

# CHECK: cfcmovsq	%r19, 291(%r28,%r29,4)
# CHECK: encoding: [0x62,0x8c,0xf8,0x0c,0x48,0x9c,0xac,0x23,0x01,0x00,0x00]
         cfcmovsq	%r19, 291(%r28,%r29,4)

# CHECK: cfcmovsw	291(%r28,%r29,4), %r17w, %r21w
# CHECK: encoding: [0x62,0x8c,0x51,0x14,0x48,0x8c,0xac,0x23,0x01,0x00,0x00]
         cfcmovsw	291(%r28,%r29,4), %r17w, %r21w

# CHECK: cfcmovsw	291(%r28,%r29,4), %r17w
# CHECK: encoding: [0x62,0x8c,0x79,0x08,0x48,0x8c,0xac,0x23,0x01,0x00,0x00]
         cfcmovsw	291(%r28,%r29,4), %r17w

# CHECK: cfcmovsl	291(%r28,%r29,4), %r18d, %r22d
# CHECK: encoding: [0x62,0x8c,0x48,0x14,0x48,0x94,0xac,0x23,0x01,0x00,0x00]
         cfcmovsl	291(%r28,%r29,4), %r18d, %r22d

# CHECK: cfcmovsl	291(%r28,%r29,4), %r18d
# CHECK: encoding: [0x62,0x8c,0x78,0x08,0x48,0x94,0xac,0x23,0x01,0x00,0x00]
         cfcmovsl	291(%r28,%r29,4), %r18d

# CHECK: cfcmovsq	291(%r28,%r29,4), %r19, %r23
# CHECK: encoding: [0x62,0x8c,0xc0,0x14,0x48,0x9c,0xac,0x23,0x01,0x00,0x00]
         cfcmovsq	291(%r28,%r29,4), %r19, %r23

# CHECK: cfcmovsq	291(%r28,%r29,4), %r19
# CHECK: encoding: [0x62,0x8c,0xf8,0x08,0x48,0x9c,0xac,0x23,0x01,0x00,0x00]
         cfcmovsq	291(%r28,%r29,4), %r19

# CHECK: cfcmovew	%r17w, %r21w, %r25w
# CHECK: encoding: [0x62,0xec,0x35,0x14,0x44,0xe9]
         cfcmovew	%r17w, %r21w, %r25w

# CHECK: cfcmovew	%r17w, %r21w
# CHECK: encoding: [0x62,0xec,0x7d,0x0c,0x44,0xcd]
         cfcmovew	%r17w, %r21w

# CHECK: cfcmovew	%r17w, 291(%r28,%r29,4)
# CHECK: encoding: [0x62,0x8c,0x79,0x0c,0x44,0x8c,0xac,0x23,0x01,0x00,0x00]
         cfcmovew	%r17w, 291(%r28,%r29,4)

# CHECK: cfcmovel	%r18d, %r22d, %r26d
# CHECK: encoding: [0x62,0xec,0x2c,0x14,0x44,0xf2]
         cfcmovel	%r18d, %r22d, %r26d

# CHECK: cfcmovel	%r18d, %r22d
# CHECK: encoding: [0x62,0xec,0x7c,0x0c,0x44,0xd6]
         cfcmovel	%r18d, %r22d

# CHECK: cfcmovel	%r18d, 291(%r28,%r29,4)
# CHECK: encoding: [0x62,0x8c,0x78,0x0c,0x44,0x94,0xac,0x23,0x01,0x00,0x00]
         cfcmovel	%r18d, 291(%r28,%r29,4)

# CHECK: cfcmoveq	%r19, %r23, %r27
# CHECK: encoding: [0x62,0xec,0xa4,0x14,0x44,0xfb]
         cfcmoveq	%r19, %r23, %r27

# CHECK: cfcmoveq	%r19, %r23
# CHECK: encoding: [0x62,0xec,0xfc,0x0c,0x44,0xdf]
         cfcmoveq	%r19, %r23

# CHECK: cfcmoveq	%r19, 291(%r28,%r29,4)
# CHECK: encoding: [0x62,0x8c,0xf8,0x0c,0x44,0x9c,0xac,0x23,0x01,0x00,0x00]
         cfcmoveq	%r19, 291(%r28,%r29,4)

# CHECK: cfcmovew	291(%r28,%r29,4), %r17w, %r21w
# CHECK: encoding: [0x62,0x8c,0x51,0x14,0x44,0x8c,0xac,0x23,0x01,0x00,0x00]
         cfcmovew	291(%r28,%r29,4), %r17w, %r21w

# CHECK: cfcmovew	291(%r28,%r29,4), %r17w
# CHECK: encoding: [0x62,0x8c,0x79,0x08,0x44,0x8c,0xac,0x23,0x01,0x00,0x00]
         cfcmovew	291(%r28,%r29,4), %r17w

# CHECK: cfcmovel	291(%r28,%r29,4), %r18d, %r22d
# CHECK: encoding: [0x62,0x8c,0x48,0x14,0x44,0x94,0xac,0x23,0x01,0x00,0x00]
         cfcmovel	291(%r28,%r29,4), %r18d, %r22d

# CHECK: cfcmovel	291(%r28,%r29,4), %r18d
# CHECK: encoding: [0x62,0x8c,0x78,0x08,0x44,0x94,0xac,0x23,0x01,0x00,0x00]
         cfcmovel	291(%r28,%r29,4), %r18d

# CHECK: cfcmoveq	291(%r28,%r29,4), %r19, %r23
# CHECK: encoding: [0x62,0x8c,0xc0,0x14,0x44,0x9c,0xac,0x23,0x01,0x00,0x00]
         cfcmoveq	291(%r28,%r29,4), %r19, %r23

# CHECK: cfcmoveq	291(%r28,%r29,4), %r19
# CHECK: encoding: [0x62,0x8c,0xf8,0x08,0x44,0x9c,0xac,0x23,0x01,0x00,0x00]
         cfcmoveq	291(%r28,%r29,4), %r19
