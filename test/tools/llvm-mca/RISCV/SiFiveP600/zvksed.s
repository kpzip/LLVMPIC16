# NOTE: Assertions have been autogenerated by utils/update_mca_test_checks.py
# RUN: llvm-mca -mtriple=riscv64 -mcpu=sifive-p670 -iterations=1 < %s | FileCheck %s

# These instructions only support e32

vsetvli zero, zero, e32, mf2, tu, mu
vsm4k.vi v4, v8, 8
vsm4r.vv v4, v8
vsm4r.vs v4, v8

vsetvli zero, zero, e32, m1, tu, mu
vsm4k.vi v4, v8, 8
vsm4r.vv v4, v8
vsm4r.vs v4, v8

vsetvli zero, zero, e32, m2, tu, mu
vsm4k.vi v4, v8, 8
vsm4r.vv v4, v8
vsm4r.vs v4, v8

vsetvli zero, zero, e32, m4, tu, mu
vsm4k.vi v4, v8, 8
vsm4r.vv v4, v8
vsm4r.vs v4, v8

vsetvli zero, zero, e32, m8, tu, mu
vsm4k.vi v8, v16, 8
vsm4r.vv v8, v16
vsm4r.vs v8, v16

# CHECK:      Iterations:        1
# CHECK-NEXT: Instructions:      20
# CHECK-NEXT: Total Cycles:      47
# CHECK-NEXT: Total uOps:        20

# CHECK:      Dispatch Width:    4
# CHECK-NEXT: uOps Per Cycle:    0.43
# CHECK-NEXT: IPC:               0.43
# CHECK-NEXT: Block RThroughput: 48.0

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects (U)

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  1      1     1.00                  U     vsetvli	zero, zero, e32, mf2, tu, mu
# CHECK-NEXT:  1      3     1.00                        vsm4k.vi	v4, v8, 8
# CHECK-NEXT:  1      3     1.00                        vsm4r.vv	v4, v8
# CHECK-NEXT:  1      3     1.00                        vsm4r.vs	v4, v8
# CHECK-NEXT:  1      1     1.00                  U     vsetvli	zero, zero, e32, m1, tu, mu
# CHECK-NEXT:  1      3     1.00                        vsm4k.vi	v4, v8, 8
# CHECK-NEXT:  1      3     1.00                        vsm4r.vv	v4, v8
# CHECK-NEXT:  1      3     1.00                        vsm4r.vs	v4, v8
# CHECK-NEXT:  1      1     1.00                  U     vsetvli	zero, zero, e32, m2, tu, mu
# CHECK-NEXT:  1      3     2.00                        vsm4k.vi	v4, v8, 8
# CHECK-NEXT:  1      3     2.00                        vsm4r.vv	v4, v8
# CHECK-NEXT:  1      3     2.00                        vsm4r.vs	v4, v8
# CHECK-NEXT:  1      1     1.00                  U     vsetvli	zero, zero, e32, m4, tu, mu
# CHECK-NEXT:  1      3     4.00                        vsm4k.vi	v4, v8, 8
# CHECK-NEXT:  1      3     4.00                        vsm4r.vv	v4, v8
# CHECK-NEXT:  1      3     4.00                        vsm4r.vs	v4, v8
# CHECK-NEXT:  1      1     1.00                  U     vsetvli	zero, zero, e32, m8, tu, mu
# CHECK-NEXT:  1      3     8.00                        vsm4k.vi	v8, v16, 8
# CHECK-NEXT:  1      3     8.00                        vsm4r.vv	v8, v16
# CHECK-NEXT:  1      3     8.00                        vsm4r.vs	v8, v16

# CHECK:      Resources:
# CHECK-NEXT: [0]   - SiFiveP600Div
# CHECK-NEXT: [1]   - SiFiveP600FEXQ0
# CHECK-NEXT: [2]   - SiFiveP600FEXQ1
# CHECK-NEXT: [3]   - SiFiveP600FloatDiv
# CHECK-NEXT: [4]   - SiFiveP600IEXQ0
# CHECK-NEXT: [5]   - SiFiveP600IEXQ1
# CHECK-NEXT: [6]   - SiFiveP600IEXQ2
# CHECK-NEXT: [7]   - SiFiveP600IEXQ3
# CHECK-NEXT: [8.0] - SiFiveP600LDST
# CHECK-NEXT: [8.1] - SiFiveP600LDST
# CHECK-NEXT: [9]   - SiFiveP600VDiv
# CHECK-NEXT: [10]  - SiFiveP600VEXQ0
# CHECK-NEXT: [11]  - SiFiveP600VEXQ1
# CHECK-NEXT: [12]  - SiFiveP600VFloatDiv
# CHECK-NEXT: [13]  - SiFiveP600VLD
# CHECK-NEXT: [14]  - SiFiveP600VST

# CHECK:      Resource pressure per iteration:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8.0]  [8.1]  [9]    [10]   [11]   [12]   [13]   [14]
# CHECK-NEXT:  -      -      -      -     5.00    -      -      -      -      -      -     48.00   -      -      -      -

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8.0]  [8.1]  [9]    [10]   [11]   [12]   [13]   [14]   Instructions:
# CHECK-NEXT:  -      -      -      -     1.00    -      -      -      -      -      -      -      -      -      -      -     vsetvli	zero, zero, e32, mf2, tu, mu
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -      -     1.00    -      -      -      -     vsm4k.vi	v4, v8, 8
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -      -     1.00    -      -      -      -     vsm4r.vv	v4, v8
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -      -     1.00    -      -      -      -     vsm4r.vs	v4, v8
# CHECK-NEXT:  -      -      -      -     1.00    -      -      -      -      -      -      -      -      -      -      -     vsetvli	zero, zero, e32, m1, tu, mu
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -      -     1.00    -      -      -      -     vsm4k.vi	v4, v8, 8
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -      -     1.00    -      -      -      -     vsm4r.vv	v4, v8
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -      -     1.00    -      -      -      -     vsm4r.vs	v4, v8
# CHECK-NEXT:  -      -      -      -     1.00    -      -      -      -      -      -      -      -      -      -      -     vsetvli	zero, zero, e32, m2, tu, mu
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -      -     2.00    -      -      -      -     vsm4k.vi	v4, v8, 8
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -      -     2.00    -      -      -      -     vsm4r.vv	v4, v8
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -      -     2.00    -      -      -      -     vsm4r.vs	v4, v8
# CHECK-NEXT:  -      -      -      -     1.00    -      -      -      -      -      -      -      -      -      -      -     vsetvli	zero, zero, e32, m4, tu, mu
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -      -     4.00    -      -      -      -     vsm4k.vi	v4, v8, 8
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -      -     4.00    -      -      -      -     vsm4r.vv	v4, v8
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -      -     4.00    -      -      -      -     vsm4r.vs	v4, v8
# CHECK-NEXT:  -      -      -      -     1.00    -      -      -      -      -      -      -      -      -      -      -     vsetvli	zero, zero, e32, m8, tu, mu
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -      -     8.00    -      -      -      -     vsm4k.vi	v8, v16, 8
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -      -     8.00    -      -      -      -     vsm4r.vv	v8, v16
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -      -     8.00    -      -      -      -     vsm4r.vs	v8, v16
