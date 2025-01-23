; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --check-globals
; RUN: opt -S -passes=openmp-opt-postlink < %s | FileCheck %s --check-prefix=POSTLINK
; RUN: opt -S -passes=openmp-opt < %s | FileCheck %s --check-prefix=PRELINK

@client = internal addrspace(1) global i64 zeroinitializer, align 8
@__llvm_libc_rpc_client = protected local_unnamed_addr addrspace(1) global ptr addrspacecast (ptr addrspace(1) @client to ptr), align 8

;.
; POSTLINK: @client = internal addrspace(1) global i64 0, align 8
; POSTLINK: @__llvm_libc_rpc_client = protected local_unnamed_addr addrspace(1) global ptr addrspacecast (ptr addrspace(1) @client to ptr), align 8
;.
; PRELINK: @client = internal addrspace(1) global i64 0, align 8
; PRELINK: @__llvm_libc_rpc_client = protected local_unnamed_addr addrspace(1) global ptr addrspacecast (ptr addrspace(1) @client to ptr), align 8
;.
define i64 @a() {
; POSTLINK-LABEL: define {{[^@]+}}@a
; POSTLINK-SAME: () #[[ATTR0:[0-9]+]] {
; POSTLINK-NEXT:    [[RETVAL:%.*]] = load i64, ptr addrspace(1) @client, align 8
; POSTLINK-NEXT:    ret i64 [[RETVAL]]
;
; PRELINK-LABEL: define {{[^@]+}}@a
; PRELINK-SAME: () #[[ATTR0:[0-9]+]] {
; PRELINK-NEXT:    [[RETVAL:%.*]] = load i64, ptr addrspace(1) @client, align 8
; PRELINK-NEXT:    ret i64 [[RETVAL]]
;
  %retval = load i64, ptr addrspace(1) @client, align 8
  ret i64 %retval
}

!llvm.module.flags = !{!0, !1, !2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"openmp", i32 50}
!2 = !{i32 7, !"openmp-device", i32 50}
;.
; POSTLINK: attributes #[[ATTR0]] = { norecurse nosync }
;.
; PRELINK: attributes #[[ATTR0]] = { norecurse nosync }
;.
; POSTLINK: [[META0:![0-9]+]] = !{i32 1, !"wchar_size", i32 4}
; POSTLINK: [[META1:![0-9]+]] = !{i32 7, !"openmp", i32 50}
; POSTLINK: [[META2:![0-9]+]] = !{i32 7, !"openmp-device", i32 50}
;.
; PRELINK: [[META0:![0-9]+]] = !{i32 1, !"wchar_size", i32 4}
; PRELINK: [[META1:![0-9]+]] = !{i32 7, !"openmp", i32 50}
; PRELINK: [[META2:![0-9]+]] = !{i32 7, !"openmp-device", i32 50}
;.
