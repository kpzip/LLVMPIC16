# NOTE: Assertions have been autogenerated by utils/update_mca_test_checks.py
# RUN: llvm-mca -mtriple=amdgcn -mcpu=gfx940 --timeline --iterations=1 --timeline-max-cycles=0 < %s | FileCheck %s

v_pk_mov_b32 v[0:1], v[2:3], v[4:5]
v_pk_add_f32 v[0:1], v[0:1], v[0:1]
v_pk_mul_f32 v[0:1], v[0:1], v[0:1]
v_add_co_u32 v5, s[0:1], v1, v2
v_sub_co_u32 v5, s[0:1], v1, v2
v_add_u32 v5, v1, v2
v_sub_u32 v5, v1, v2

# CHECK:      Iterations:        1
# CHECK-NEXT: Instructions:      7
# CHECK-NEXT: Total Cycles:      10
# CHECK-NEXT: Total uOps:        9

# CHECK:      Dispatch Width:    1
# CHECK-NEXT: uOps Per Cycle:    0.90
# CHECK-NEXT: IPC:               0.70
# CHECK-NEXT: Block RThroughput: 9.0

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects (U)

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  1      1     1.00                  U     v_pk_mov_b32 v[0:1], v[2:3], v[4:5]
# CHECK-NEXT:  1      1     1.00                  U     v_pk_add_f32 v[0:1], v[0:1], v[0:1]
# CHECK-NEXT:  1      1     1.00                  U     v_pk_mul_f32 v[0:1], v[0:1], v[0:1]
# CHECK-NEXT:  2      1     1.00                  U     v_add_co_u32_e64 v5, s[0:1], v1, v2
# CHECK-NEXT:  2      1     1.00                  U     v_sub_co_u32_e64 v5, s[0:1], v1, v2
# CHECK-NEXT:  1      1     1.00                  U     v_add_u32_e32 v5, v1, v2
# CHECK-NEXT:  1      1     1.00                  U     v_sub_u32_e32 v5, v1, v2

# CHECK:      Resources:
# CHECK-NEXT: [0]   - HWBranch
# CHECK-NEXT: [1]   - HWExport
# CHECK-NEXT: [2]   - HWLGKM
# CHECK-NEXT: [3]   - HWSALU
# CHECK-NEXT: [4]   - HWVALU
# CHECK-NEXT: [5]   - HWVMEM
# CHECK-NEXT: [6]   - HWXDL

# CHECK:      Resource pressure per iteration:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]
# CHECK-NEXT:  -      -      -     2.00   7.00    -      -

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  -      -      -      -     1.00    -      -     v_pk_mov_b32 v[0:1], v[2:3], v[4:5]
# CHECK-NEXT:  -      -      -      -     1.00    -      -     v_pk_add_f32 v[0:1], v[0:1], v[0:1]
# CHECK-NEXT:  -      -      -      -     1.00    -      -     v_pk_mul_f32 v[0:1], v[0:1], v[0:1]
# CHECK-NEXT:  -      -      -     1.00   1.00    -      -     v_add_co_u32_e64 v5, s[0:1], v1, v2
# CHECK-NEXT:  -      -      -     1.00   1.00    -      -     v_sub_co_u32_e64 v5, s[0:1], v1, v2
# CHECK-NEXT:  -      -      -      -     1.00    -      -     v_add_u32_e32 v5, v1, v2
# CHECK-NEXT:  -      -      -      -     1.00    -      -     v_sub_u32_e32 v5, v1, v2

# CHECK:      Timeline view:
# CHECK-NEXT: Index     0123456789

# CHECK:      [0,0]     DE   .   .   v_pk_mov_b32 v[0:1], v[2:3], v[4:5]
# CHECK-NEXT: [0,1]     .DE  .   .   v_pk_add_f32 v[0:1], v[0:1], v[0:1]
# CHECK-NEXT: [0,2]     . DE .   .   v_pk_mul_f32 v[0:1], v[0:1], v[0:1]
# CHECK-NEXT: [0,3]     .  DE.   .   v_add_co_u32_e64 v5, s[0:1], v1, v2
# CHECK-NEXT: [0,4]     .   DeE  .   v_sub_co_u32_e64 v5, s[0:1], v1, v2
# CHECK-NEXT: [0,5]     .    . DE.   v_add_u32_e32 v5, v1, v2
# CHECK-NEXT: [0,6]     .    .  DE   v_sub_u32_e32 v5, v1, v2

# CHECK:      Average Wait times (based on the timeline view):
# CHECK-NEXT: [0]: Executions
# CHECK-NEXT: [1]: Average time spent waiting in a scheduler's queue
# CHECK-NEXT: [2]: Average time spent waiting in a scheduler's queue while ready
# CHECK-NEXT: [3]: Average time elapsed from WB until retire stage

# CHECK:            [0]    [1]    [2]    [3]
# CHECK-NEXT: 0.     1     0.0    0.0    0.0       v_pk_mov_b32 v[0:1], v[2:3], v[4:5]
# CHECK-NEXT: 1.     1     0.0    0.0    0.0       v_pk_add_f32 v[0:1], v[0:1], v[0:1]
# CHECK-NEXT: 2.     1     0.0    0.0    0.0       v_pk_mul_f32 v[0:1], v[0:1], v[0:1]
# CHECK-NEXT: 3.     1     0.0    0.0    0.0       v_add_co_u32_e64 v5, s[0:1], v1, v2
# CHECK-NEXT: 4.     1     0.0    0.0    0.0       v_sub_co_u32_e64 v5, s[0:1], v1, v2
# CHECK-NEXT: 5.     1     0.0    0.0    0.0       v_add_u32_e32 v5, v1, v2
# CHECK-NEXT: 6.     1     0.0    0.0    0.0       v_sub_u32_e32 v5, v1, v2
# CHECK-NEXT:        1     0.0    0.0    0.0       <total>
