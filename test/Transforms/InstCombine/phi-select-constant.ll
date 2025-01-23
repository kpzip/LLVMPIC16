; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -S -passes=instcombine | FileCheck %s
@A = extern_weak global i32, align 4
@B = extern_weak global i32, align 4

define i32 @foo(i1 %which) {
; CHECK-LABEL: @foo(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[WHICH:%.*]], label [[FINAL:%.*]], label [[DELAY:%.*]]
; CHECK:       delay:
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq ptr @A, @B
; CHECK-NEXT:    [[TMP0:%.*]] = select i1 [[CMP]], i32 2, i32 1
; CHECK-NEXT:    br label [[FINAL]]
; CHECK:       final:
; CHECK-NEXT:    [[USE2:%.*]] = phi i32 [ 1, [[ENTRY:%.*]] ], [ [[TMP0]], [[DELAY]] ]
; CHECK-NEXT:    ret i32 [[USE2]]
;
entry:
  br i1 %which, label %final, label %delay

delay:
  %cmp = icmp eq ptr @A, @B
  br label %final

final:
  %use2 = phi i1 [ false, %entry ], [ %cmp, %delay ]
  %value = select i1 %use2, i32 2, i32 1
  ret i32 %value
}


; test folding of select into phi for vectors.
define <4 x i64> @vec1(i1 %which) {
; CHECK-LABEL: @vec1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[WHICH:%.*]], label [[FINAL:%.*]], label [[DELAY:%.*]]
; CHECK:       delay:
; CHECK-NEXT:    br label [[FINAL]]
; CHECK:       final:
; CHECK-NEXT:    [[PHINODE:%.*]] = phi <4 x i64> [ zeroinitializer, [[ENTRY:%.*]] ], [ <i64 0, i64 0, i64 126, i64 127>, [[DELAY]] ]
; CHECK-NEXT:    ret <4 x i64> [[PHINODE]]
;
entry:
  br i1 %which, label %final, label %delay

delay:
  br label %final

final:
  %phinode =  phi <4 x i1> [ <i1 true, i1 true, i1 true, i1 true>, %entry ], [ <i1 true, i1 true, i1 false, i1 false>, %delay ]
  %sel = select <4 x i1> %phinode, <4 x i64> zeroinitializer, <4 x i64> <i64 124, i64 125, i64 126, i64 127>
  ret <4 x i64> %sel
}

define <4 x i64> @vec2(i1 %which) {
; CHECK-LABEL: @vec2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[WHICH:%.*]], label [[FINAL:%.*]], label [[DELAY:%.*]]
; CHECK:       delay:
; CHECK-NEXT:    br label [[FINAL]]
; CHECK:       final:
; CHECK-NEXT:    [[PHINODE:%.*]] = phi <4 x i64> [ <i64 124, i64 125, i64 126, i64 127>, [[ENTRY:%.*]] ], [ <i64 0, i64 125, i64 0, i64 127>, [[DELAY]] ]
; CHECK-NEXT:    ret <4 x i64> [[PHINODE]]
;
entry:
  br i1 %which, label %final, label %delay

delay:
  br label %final

final:
  %phinode =  phi <4 x i1> [ <i1 false, i1 false, i1 false, i1 false>, %entry ], [ <i1 true, i1 false, i1 true, i1 false>, %delay ]
  %sel = select <4 x i1> %phinode, <4 x i64> zeroinitializer, <4 x i64> <i64 124, i64 125, i64 126, i64 127>
  ret <4 x i64> %sel
}

; Test PR33364
; Insert the generated select into the same block as the incoming phi value.
; phi has constant vectors along with a single non-constant vector as operands.
define <2 x i8> @vec3(i1 %cond1, i1 %cond2, <2 x i1> %x, <2 x i8> %y, <2 x i8> %z) {
; CHECK-LABEL: @vec3(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[COND1:%.*]], label [[IF1:%.*]], label [[ELSE:%.*]]
; CHECK:       if1:
; CHECK-NEXT:    br i1 [[COND2:%.*]], label [[IF2:%.*]], label [[ELSE]]
; CHECK:       if2:
; CHECK-NEXT:    br label [[ELSE]]
; CHECK:       else:
; CHECK-NEXT:    [[PHI:%.*]] = phi <2 x i1> [ [[X:%.*]], [[IF2]] ], [ <i1 false, i1 true>, [[ENTRY:%.*]] ], [ <i1 true, i1 false>, [[IF1]] ]
; CHECK-NEXT:    [[SEL:%.*]] = select <2 x i1> [[PHI]], <2 x i8> [[Y:%.*]], <2 x i8> [[Z:%.*]]
; CHECK-NEXT:    ret <2 x i8> [[SEL]]
;
entry:
  br i1 %cond1, label %if1, label %else

if1:
  br i1 %cond2, label %if2, label %else

if2:
  br label %else

else:
  %phi = phi <2 x i1> [ %x, %if2 ], [ <i1 0, i1 1>, %entry ], [ <i1 1, i1 0>, %if1 ]
  %sel = select <2 x i1> %phi, <2 x i8> %y, <2 x i8> %z
  ret <2 x i8> %sel
}

; Don't crash on unreachable IR.

define void @PR48369(i32 %a, ptr %p) {
; CHECK-LABEL: @PR48369(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[PHI_CMP:%.*]] = icmp sgt i32 [[A:%.*]], 0
; CHECK-NEXT:    br label [[BB1:%.*]]
; CHECK:       bb1:
; CHECK-NEXT:    [[CMP:%.*]] = phi i1 [ [[PHI_CMP]], [[DEADBB:%.*]] ], [ true, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[SHL:%.*]] = select i1 [[CMP]], i32 256, i32 0
; CHECK-NEXT:    store i32 [[SHL]], ptr [[P:%.*]], align 4
; CHECK-NEXT:    br label [[END:%.*]]
; CHECK:       deadbb:
; CHECK-NEXT:    br label [[BB1]]
; CHECK:       end:
; CHECK-NEXT:    ret void
;
entry:
  %phi.cmp = icmp sgt i32 %a, 0
  br label %bb1

bb1:
  %cmp = phi i1 [ %phi.cmp, %deadbb ], [ true, %entry ]
  %shl = select i1 %cmp, i32 256, i32 0
  store i32 %shl, ptr %p
  br label %end

deadbb:
  br label %bb1

end:
  ret void
}

define i16 @sink_to_unreachable_crash(i1 %a)  {
; CHECK-LABEL: @sink_to_unreachable_crash(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[INF_LOOP:%.*]]
; CHECK:       inf_loop:
; CHECK-NEXT:    br label [[INF_LOOP]]
; CHECK:       unreachable:
; CHECK-NEXT:    ret i16 poison
;
entry:
  %s = select i1 %a, i16 0, i16 5
  br label %inf_loop

inf_loop:
  br label %inf_loop

unreachable:   ; No predecessors!
  ret i16 %s
}

define i32 @phi_trans(i1 %c, i1 %c2, i32 %v) {
; CHECK-LABEL: @phi_trans(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[IF:%.*]], label [[ELSE:%.*]]
; CHECK:       if:
; CHECK-NEXT:    [[V2:%.*]] = add i32 [[V:%.*]], 1
; CHECK-NEXT:    br label [[JOIN:%.*]]
; CHECK:       else:
; CHECK-NEXT:    [[V3:%.*]] = mul i32 [[V]], 3
; CHECK-NEXT:    [[V5:%.*]] = lshr i32 [[V]], 1
; CHECK-NEXT:    [[TMP0:%.*]] = select i1 [[C2:%.*]], i32 [[V3]], i32 [[V5]]
; CHECK-NEXT:    br label [[JOIN]]
; CHECK:       join:
; CHECK-NEXT:    [[PHI1:%.*]] = phi i32 [ [[V2]], [[IF]] ], [ [[TMP0]], [[ELSE]] ]
; CHECK-NEXT:    ret i32 [[PHI1]]
;
entry:
  br i1 %c, label %if, label %else

if:
  %v2 = add i32 %v, 1
  %v4 = shl i32 %v, 1
  br label %join

else:
  %v3 = mul i32 %v, 3
  %v5 = lshr i32 %v, 1
  br label %join

join:
  %phi1 = phi i1 [ true, %if ], [ %c2, %else ]
  %phi2 = phi i32 [ %v2, %if ], [ %v3, %else ]
  %phi3 = phi i32 [ %v4, %if ], [ %v5, %else ]
  %sel = select i1 %phi1, i32 %phi2, i32 %phi3
  ret i32 %sel
}
