# NOTE: Assertions have been autogenerated by utils/update_mca_test_checks.py
# RUN: llvm-mca -mtriple=amdgcn -mcpu=gfx1010 --timeline --iterations=1 --timeline-max-cycles=0 < %s | FileCheck %s -check-prefixes=CHECK,GFX10
# RUN: llvm-mca -mtriple=amdgcn -mcpu=gfx1100 --timeline --iterations=1 --timeline-max-cycles=0 < %s | FileCheck %s -check-prefixes=CHECK,GFX11

v_log_f32 v0, v0
v_rcp_f32 v0, v0
v_rsq_f32 v1, v1
v_sqrt_f32 v2, v0
v_rcp_f64 v[0:1], v[0:1]
v_rsq_f64 v[1:2], v[1:2]
v_sqrt_f64 v[2:3], v[0:1]

# CHECK:      Iterations:        1
# CHECK-NEXT: Instructions:      7

# GFX10-NEXT: Total Cycles:      94
# GFX11-NEXT: Total Cycles:      142

# CHECK-NEXT: Total uOps:        7

# CHECK:      Dispatch Width:    1

# GFX10-NEXT: uOps Per Cycle:    0.07
# GFX10-NEXT: IPC:               0.07

# GFX11-NEXT: uOps Per Cycle:    0.05
# GFX11-NEXT: IPC:               0.05

# CHECK-NEXT: Block RThroughput: 7.0

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects (U)

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  1      10    1.00                  U     v_log_f32_e32 v0, v0
# CHECK-NEXT:  1      10    1.00                  U     v_rcp_f32_e32 v0, v0
# CHECK-NEXT:  1      10    1.00                  U     v_rsq_f32_e32 v1, v1
# CHECK-NEXT:  1      10    1.00                  U     v_sqrt_f32_e32 v2, v0

# GFX10-NEXT:  1      24    1.00                  U     v_rcp_f64_e32 v[0:1], v[0:1]
# GFX10-NEXT:  1      24    1.00                  U     v_rsq_f64_e32 v[1:2], v[1:2]
# GFX10-NEXT:  1      24    1.00                  U     v_sqrt_f64_e32 v[2:3], v[0:1]

# GFX11-NEXT:  1      40    1.00                  U     v_rcp_f64_e32 v[0:1], v[0:1]
# GFX11-NEXT:  1      40    1.00                  U     v_rsq_f64_e32 v[1:2], v[1:2]
# GFX11-NEXT:  1      40    1.00                  U     v_sqrt_f64_e32 v[2:3], v[0:1]

# CHECK:      Resources:
# CHECK-NEXT: [0]   - HWBranch
# CHECK-NEXT: [1]   - HWExport
# CHECK-NEXT: [2]   - HWLGKM
# CHECK-NEXT: [3]   - HWRC
# CHECK-NEXT: [4]   - HWSALU
# CHECK-NEXT: [5]   - HWTransVALU
# CHECK-NEXT: [6]   - HWVALU
# CHECK-NEXT: [7]   - HWVMEM

# CHECK:      Resource pressure per iteration:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]
# CHECK-NEXT:  -      -      -     7.00    -     7.00   3.00    -

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    Instructions:
# CHECK-NEXT:  -      -      -     1.00    -     1.00    -      -     v_log_f32_e32 v0, v0
# CHECK-NEXT:  -      -      -     1.00    -     1.00    -      -     v_rcp_f32_e32 v0, v0
# CHECK-NEXT:  -      -      -     1.00    -     1.00    -      -     v_rsq_f32_e32 v1, v1
# CHECK-NEXT:  -      -      -     1.00    -     1.00    -      -     v_sqrt_f32_e32 v2, v0
# CHECK-NEXT:  -      -      -     1.00    -     1.00   1.00    -     v_rcp_f64_e32 v[0:1], v[0:1]
# CHECK-NEXT:  -      -      -     1.00    -     1.00   1.00    -     v_rsq_f64_e32 v[1:2], v[1:2]
# CHECK-NEXT:  -      -      -     1.00    -     1.00   1.00    -     v_sqrt_f64_e32 v[2:3], v[0:1]

# CHECK:      Timeline view:

# GFX10-NEXT:                     0123456789          0123456789          0123456789          0123456789          0123
# GFX10-NEXT: Index     0123456789          0123456789          0123456789          0123456789          0123456789

# GFX11-NEXT:                     0123456789          0123456789          0123456789          0123456789          0123456789          0123456789          0123456789
# GFX11-NEXT: Index     0123456789          0123456789          0123456789          0123456789          0123456789          0123456789          0123456789          01

# GFX10:      [0,0]     DeeeeeeeeeE    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .  .   v_log_f32_e32 v0, v0
# GFX10-NEXT: [0,1]     .    .    DeeeeeeeeeE    .    .    .    .    .    .    .    .    .    .    .    .    .    .  .   v_rcp_f32_e32 v0, v0
# GFX10-NEXT: [0,2]     .    .    .DeeeeeeeeeE   .    .    .    .    .    .    .    .    .    .    .    .    .    .  .   v_rsq_f32_e32 v1, v1
# GFX10-NEXT: [0,3]     .    .    .    .    DeeeeeeeeeE    .    .    .    .    .    .    .    .    .    .    .    .  .   v_sqrt_f32_e32 v2, v0
# GFX10-NEXT: [0,4]     .    .    .    .    .DeeeeeeeeeeeeeeeeeeeeeeeE    .    .    .    .    .    .    .    .    .  .   v_rcp_f64_e32 v[0:1], v[0:1]
# GFX10-NEXT: [0,5]     .    .    .    .    .    .    .    .    .    DeeeeeeeeeeeeeeeeeeeeeeeE.    .    .    .    .  .   v_rsq_f64_e32 v[1:2], v[1:2]
# GFX10-NEXT: [0,6]     .    .    .    .    .    .    .    .    .    .    .    .    .    .   DeeeeeeeeeeeeeeeeeeeeeeeE   v_sqrt_f64_e32 v[2:3], v[0:1]

# GFX11:      [0,0]     DeeeeeeeeeE    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    ..   v_log_f32_e32 v0, v0
# GFX11-NEXT: [0,1]     .    .    DeeeeeeeeeE    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    ..   v_rcp_f32_e32 v0, v0
# GFX11-NEXT: [0,2]     .    .    .DeeeeeeeeeE   .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    ..   v_rsq_f32_e32 v1, v1
# GFX11-NEXT: [0,3]     .    .    .    .    DeeeeeeeeeE    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    ..   v_sqrt_f32_e32 v2, v0
# GFX11-NEXT: [0,4]     .    .    .    .    .DeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeE   .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    ..   v_rcp_f64_e32 v[0:1], v[0:1]
# GFX11-NEXT: [0,5]     .    .    .    .    .    .    .    .    .    .    .    .    .DeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeE   .    .    .    .    .    .    .    ..   v_rsq_f64_e32 v[1:2], v[1:2]
# GFX11-NEXT: [0,6]     .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .DeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeE   v_sqrt_f64_e32 v[2:3], v[0:1]

# CHECK:      Average Wait times (based on the timeline view):
# CHECK-NEXT: [0]: Executions
# CHECK-NEXT: [1]: Average time spent waiting in a scheduler's queue
# CHECK-NEXT: [2]: Average time spent waiting in a scheduler's queue while ready
# CHECK-NEXT: [3]: Average time elapsed from WB until retire stage

# CHECK:            [0]    [1]    [2]    [3]
# CHECK-NEXT: 0.     1     0.0    0.0    0.0       v_log_f32_e32 v0, v0
# CHECK-NEXT: 1.     1     0.0    0.0    0.0       v_rcp_f32_e32 v0, v0
# CHECK-NEXT: 2.     1     0.0    0.0    0.0       v_rsq_f32_e32 v1, v1
# CHECK-NEXT: 3.     1     0.0    0.0    0.0       v_sqrt_f32_e32 v2, v0
# CHECK-NEXT: 4.     1     0.0    0.0    0.0       v_rcp_f64_e32 v[0:1], v[0:1]
# CHECK-NEXT: 5.     1     0.0    0.0    0.0       v_rsq_f64_e32 v[1:2], v[1:2]
# CHECK-NEXT: 6.     1     0.0    0.0    0.0       v_sqrt_f64_e32 v[2:3], v[0:1]
# CHECK-NEXT:        1     0.0    0.0    0.0       <total>
