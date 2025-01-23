; RUN: opt < %s -passes=gvn | llvm-dis

	%struct.ggBRDF = type { ptr }
	%struct.ggBox3 = type { %struct.ggPoint3, %struct.ggPoint3 }
	%struct.ggMaterialRecord = type { %struct.ggPoint2, %struct.ggBox3, %struct.ggBox3, %struct.ggSpectrum, %struct.ggSpectrum, %struct.ggSpectrum, ptr, i32, i32, i32, i32 }
	%struct.ggONB3 = type { %struct.ggPoint3, %struct.ggPoint3, %struct.ggPoint3 }
	%struct.ggPoint2 = type { [2 x double] }
	%struct.ggPoint3 = type { [3 x double] }
	%struct.ggSpectrum = type { [8 x float] }
	%struct.mrViewingHitRecord = type { double, %struct.ggPoint3, %struct.ggONB3, %struct.ggPoint2, double, %struct.ggSpectrum, %struct.ggSpectrum, i32, i32, i32, i32 }
	%struct.mrXEllipticalCylinder = type { %struct.ggBRDF, float, float, float, float, float, float }

define i32 @_ZNK21mrZEllipticalCylinder10viewingHitERK6ggRay3dddR18mrViewingHitRecordR16ggMaterialRecord(ptr %this, ptr %ray, double %unnamed_arg, double %tmin, double %tmax, ptr %VHR, ptr %unnamed_arg2) {
entry:
	%tmp80.i = getelementptr %struct.mrViewingHitRecord, ptr %VHR, i32 0, i32 1, i32 0, i32 0		; <ptr> [#uses=1]
	store double 0.000000e+00, ptr %tmp80.i
	br i1 false, label %return, label %cond_next.i

cond_next.i:		; preds = %entry
	br i1 false, label %return, label %cond_true

cond_true:		; preds = %cond_next.i
	%tmp3.i8 = getelementptr %struct.mrViewingHitRecord, ptr %VHR, i32 0, i32 1, i32 0, i32 0		; <ptr> [#uses=1]
	%tmp46 = load double, ptr %tmp3.i8		; <double> [#uses=0]
	ret i32 1

return:		; preds = %cond_next.i, %entry
	ret i32 0
}
