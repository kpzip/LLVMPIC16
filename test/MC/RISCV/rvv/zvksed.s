# RUN: llvm-mc -triple=riscv32 -show-encoding --mattr=+zve32x --mattr=+zvksed %s \
# RUN:        | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST
# RUN: not llvm-mc -triple=riscv32 -show-encoding %s 2>&1 \
# RUN:        | FileCheck %s --check-prefix=CHECK-ERROR
# RUN: llvm-mc -triple=riscv32 -filetype=obj --mattr=+zve32x --mattr=+zvksed %s \
# RUN:        | llvm-objdump -d --mattr=+zve32x --mattr=+zvksed --no-print-imm-hex - \
# RUN:        | FileCheck %s --check-prefix=CHECK-INST
# RUN: llvm-mc -triple=riscv32 -filetype=obj --mattr=+zve32x --mattr=+zvksed %s \
# RUN:        | llvm-objdump -d - | FileCheck %s --check-prefix=CHECK-UNKNOWN

vsm4k.vi v10, v9, 7
# CHECK-INST: vsm4k.vi v10, v9, 7
# CHECK-ENCODING: [0x77,0xa5,0x93,0x86]
# CHECK-ERROR: instruction requires the following: 'Zvksed' (SM4 Block Cipher Instructions){{$}}
# CHECK-UNKNOWN: 8693a577 <unknown>

vsm4k.vi v10, v9, 31
# CHECK-INST: vsm4k.vi v10, v9, 31
# CHECK-ENCODING: [0x77,0xa5,0x9f,0x86]
# CHECK-ERROR: instruction requires the following: 'Zvksed' (SM4 Block Cipher Instructions){{$}}
# CHECK-UNKNOWN: 869fa577 <unknown>

vsm4r.vv v10, v9
# CHECK-INST: vsm4r.vv v10, v9
# CHECK-ENCODING: [0x77,0x25,0x98,0xa2]
# CHECK-ERROR: instruction requires the following: 'Zvksed' (SM4 Block Cipher Instructions){{$}}
# CHECK-UNKNOWN: a2982577 <unknown>

vsm4r.vs v10, v9
# CHECK-INST: vsm4r.vs v10, v9
# CHECK-ENCODING: [0x77,0x25,0x98,0xa6]
# CHECK-ERROR: instruction requires the following: 'Zvksed' (SM4 Block Cipher Instructions){{$}}
# CHECK-UNKNOWN: a6982577 <unknown>
