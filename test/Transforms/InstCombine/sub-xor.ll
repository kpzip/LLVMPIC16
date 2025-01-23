; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=instcombine -S < %s | FileCheck %s

declare void @use(i32)

define i32 @low_mask_nsw_nuw(i32 %x) {
; CHECK-LABEL: @low_mask_nsw_nuw(
; CHECK-NEXT:    [[AND:%.*]] = and i32 [[X:%.*]], 31
; CHECK-NEXT:    [[SUB:%.*]] = xor i32 [[AND]], 63
; CHECK-NEXT:    ret i32 [[SUB]]
;
  %and = and i32 %x, 31
  %sub = sub i32 63, %and
  ret i32 %sub
}

define <2 x i32> @low_mask_nsw_nuw_vec(<2 x i32> %x) {
; CHECK-LABEL: @low_mask_nsw_nuw_vec(
; CHECK-NEXT:    [[AND:%.*]] = and <2 x i32> [[X:%.*]], <i32 31, i32 31>
; CHECK-NEXT:    [[SUB:%.*]] = xor <2 x i32> [[AND]], <i32 63, i32 63>
; CHECK-NEXT:    ret <2 x i32> [[SUB]]
;
  %and = and <2 x i32> %x, <i32 31, i32 31>
  %sub = sub <2 x i32> <i32 63, i32 63>, %and
  ret <2 x i32> %sub
}

define i8 @arbitrary_mask_sub_i8(i8 %x) {
; CHECK-LABEL: @arbitrary_mask_sub_i8(
; CHECK-NEXT:    [[A:%.*]] = and i8 [[X:%.*]], 10
; CHECK-NEXT:    [[M:%.*]] = sub nuw nsw i8 11, [[A]]
; CHECK-NEXT:    ret i8 [[M]]
;
  %a = and i8 %x, 10 ; 0b00001010
  %m = sub i8 11, %a ; 0b00001011
  ret i8 %m
}

; TODO: Borrow from the MSB is ok.

define i8 @arbitrary_mask_sub_high_bit_dont_care_i8(i8 %x) {
; CHECK-LABEL: @arbitrary_mask_sub_high_bit_dont_care_i8(
; CHECK-NEXT:    [[MASKX:%.*]] = and i8 [[X:%.*]], -93
; CHECK-NEXT:    [[S:%.*]] = sub i8 39, [[MASKX]]
; CHECK-NEXT:    ret i8 [[S]]
;
  %maskx = and i8 %x, 163 ; 0b10100011
  %s = sub i8 39, %maskx  ; 0b00100111
  ret i8 %s
}

define i8 @arbitrary_mask_sub_nsw_high_bit_dont_care_i8(i8 %x) {
; CHECK-LABEL: @arbitrary_mask_sub_nsw_high_bit_dont_care_i8(
; CHECK-NEXT:    [[MASKX:%.*]] = and i8 [[X:%.*]], -93
; CHECK-NEXT:    [[S:%.*]] = sub nsw i8 39, [[MASKX]]
; CHECK-NEXT:    ret i8 [[S]]
;
  %maskx = and i8 %x, 163     ; 0b10100011
  %s = sub nsw i8 39, %maskx  ; 0b00100111
  ret i8 %s
}

define i8 @arbitrary_mask_sub_nuw_high_bit_dont_care_i8(i8 %x) {
; CHECK-LABEL: @arbitrary_mask_sub_nuw_high_bit_dont_care_i8(
; CHECK-NEXT:    [[MASKX:%.*]] = and i8 [[X:%.*]], -93
; CHECK-NEXT:    [[S:%.*]] = sub nuw i8 39, [[MASKX]]
; CHECK-NEXT:    ret i8 [[S]]
;
  %maskx = and i8 %x, 163     ; 0b10100011
  %s = sub nuw i8 39, %maskx  ; 0b00100111
  ret i8 %s
}

define <2 x i5> @arbitrary_mask_sub_v2i5(<2 x i5> %x) {
; CHECK-LABEL: @arbitrary_mask_sub_v2i5(
; CHECK-NEXT:    [[A:%.*]] = and <2 x i5> [[X:%.*]], <i5 -8, i5 -8>
; CHECK-NEXT:    [[M:%.*]] = sub nuw nsw <2 x i5> <i5 -6, i5 -6>, [[A]]
; CHECK-NEXT:    ret <2 x i5> [[M]]
;
  %a = and <2 x i5> %x, <i5 24, i5 24> ; 0b11000
  %m = sub <2 x i5> <i5 26, i5 26>, %a ; 0b11010
  ret <2 x i5> %m
}

define i8 @not_masked_sub_i8(i8 %x) {
; CHECK-LABEL: @not_masked_sub_i8(
; CHECK-NEXT:    [[A:%.*]] = and i8 [[X:%.*]], 7
; CHECK-NEXT:    [[M:%.*]] = sub nuw nsw i8 11, [[A]]
; CHECK-NEXT:    ret i8 [[M]]
;
  %a = and i8 %x, 7  ; 0b00000111
  %m = sub i8 11, %a ; 0b00001011
  ret i8 %m
}

declare i32 @llvm.ctlz.i32(i32, i1)

define i32 @range_masked_sub(i32 %x) {
; CHECK-LABEL: @range_masked_sub(
; CHECK-NEXT:    [[COUNT:%.*]] = tail call range(i32 0, 33) i32 @llvm.ctlz.i32(i32 [[X:%.*]], i1 true) #[[ATTR1:[0-9]+]]
; CHECK-NEXT:    [[SUB:%.*]] = xor i32 [[COUNT]], 31
; CHECK-NEXT:    ret i32 [[SUB]]
;
  %count = tail call i32 @llvm.ctlz.i32(i32 %x, i1 true) nounwind readnone
  %sub = sub i32 31, %count
  ret i32 %sub
}

define i32 @xor_add(i32 %x) {
; CHECK-LABEL: @xor_add(
; CHECK-NEXT:    [[AND:%.*]] = and i32 [[X:%.*]], 31
; CHECK-NEXT:    [[ADD:%.*]] = sub nuw nsw i32 73, [[AND]]
; CHECK-NEXT:    ret i32 [[ADD]]
;
  %and = and i32 %x, 31
  %xor = xor i32 %and, 31
  %add = add i32 %xor, 42
  ret i32 %add
}

define i32 @xor_add_extra_use(i32 %x) {
; CHECK-LABEL: @xor_add_extra_use(
; CHECK-NEXT:    [[AND:%.*]] = and i32 [[X:%.*]], 31
; CHECK-NEXT:    [[XOR:%.*]] = xor i32 [[AND]], 31
; CHECK-NEXT:    call void @use(i32 [[XOR]])
; CHECK-NEXT:    [[ADD:%.*]] = sub nuw nsw i32 73, [[AND]]
; CHECK-NEXT:    ret i32 [[ADD]]
;
  %and = and i32 %x, 31
  %xor = xor i32 %and, 31
  call void @use(i32 %xor)
  %add = add i32 %xor, 42
  ret i32 %add
}

define <2 x i8> @xor_add_splat(<2 x i8> %x) {
; CHECK-LABEL: @xor_add_splat(
; CHECK-NEXT:    [[AND:%.*]] = and <2 x i8> [[X:%.*]], <i8 24, i8 24>
; CHECK-NEXT:    [[ADD:%.*]] = sub nuw nsw <2 x i8> <i8 105, i8 105>, [[AND]]
; CHECK-NEXT:    ret <2 x i8> [[ADD]]
;
  %and = and <2 x i8> %x, <i8 24, i8 24>
  %xor = xor <2 x i8> %and, <i8 63, i8 63>
  %add = add <2 x i8> %xor, <i8 42, i8 42>
  ret <2 x i8> %add
}

define <2 x i8> @xor_add_splat_undef(<2 x i8> %x) {
; CHECK-LABEL: @xor_add_splat_undef(
; CHECK-NEXT:    [[AND:%.*]] = and <2 x i8> [[X:%.*]], <i8 24, i8 24>
; CHECK-NEXT:    [[XOR:%.*]] = xor <2 x i8> [[AND]], <i8 63, i8 undef>
; CHECK-NEXT:    [[ADD:%.*]] = add <2 x i8> [[XOR]], <i8 42, i8 42>
; CHECK-NEXT:    ret <2 x i8> [[ADD]]
;
  %and = and <2 x i8> %x, <i8 24, i8 24>
  %xor = xor <2 x i8> %and, <i8 63, i8 undef>
  %add = add <2 x i8> %xor, <i8 42, i8 42>
  ret <2 x i8> %add
}

; Make sure we don't convert sub to xor using dominating condition. That makes
; it hard for other passe to reverse.
define i32 @xor_dominating_cond(i32 %x) {
; CHECK-LABEL: @xor_dominating_cond(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[COND:%.*]] = icmp ult i32 [[X:%.*]], 256
; CHECK-NEXT:    br i1 [[COND]], label [[IF_THEN:%.*]], label [[IF_END:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    [[A:%.*]] = sub nuw nsw i32 255, [[X]]
; CHECK-NEXT:    ret i32 [[A]]
; CHECK:       if.end:
; CHECK-NEXT:    ret i32 [[X]]
;
entry:
  %cond = icmp ult i32 %x, 256
  br i1 %cond, label %if.then, label %if.end

if.then:
  %a = sub i32 255, %x
  ret i32 %a

if.end:
  ret i32 %x
}
