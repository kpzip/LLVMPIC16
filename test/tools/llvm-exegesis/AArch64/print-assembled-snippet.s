# Check that "assembled_snippet" is fetched correctly from object file.
# Feel free to update the snippet in this test if the code generated by the
# snippet repetitor was changed intentionally and it is still fetched correctly.

# RUN: llvm-exegesis --mtriple=aarch64-linux-gnu --mcpu=generic --benchmark-phase=prepare-and-assemble-snippet \
# RUN:               --snippets-file=%s --mode=latency --repetition-mode=duplicate \
# RUN: | FileCheck %s --check-prefix=CHECK-LINUX

# RUN: llvm-exegesis --mtriple=aarch64-windows-gnu --mcpu=generic --benchmark-phase=prepare-and-assemble-snippet \
# RUN:               --snippets-file=%s --mode=latency --repetition-mode=duplicate \
# RUN: | FileCheck %s --check-prefix=CHECK-WINDOWS-GNU

# RUN: llvm-exegesis --mtriple=aarch64-windows-msvc --mcpu=generic --benchmark-phase=prepare-and-assemble-snippet \
# RUN:               --snippets-file=%s --mode=latency --repetition-mode=duplicate \
# RUN: | FileCheck %s --check-prefix=CHECK-WINDOWS-MSVC

# LLVM-EXEGESIS-DEFREG X0 0
# LLVM-EXEGESIS-DEFREG X1 0
add x0, x0, x1

# CHECK-LINUX: cpu_name:          generic
# CHECK-LINUX: llvm_triple:       aarch64-unknown-linux-gnu
# CHECK-LINUX: assembled_snippet: 000080D2010080D20000018B0000018B0000018B0000018BC0035FD6{{$}}

# CHECK-WINDOWS-GNU: cpu_name:          generic
# CHECK-WINDOWS-GNU: llvm_triple:       aarch64-unknown-windows-gnu
# CHECK-WINDOWS-GNU: assembled_snippet: 000080D2010080D20000018B0000018B0000018B0000018BC0035FD6{{$}}

# CHECK-WINDOWS-MSVC: cpu_name:          generic
# CHECK-WINDOWS-MSVC: llvm_triple:       aarch64-unknown-windows-msvc
# CHECK-WINDOWS-MSVC: assembled_snippet: 000080D2010080D20000018B0000018B0000018B0000018BC0035FD6{{$}}
