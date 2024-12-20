@__GLOBAL_CONST_RADIUS = global float 0x4016000000000000
@__GLOBAL_CONST_PI = global float 0x400921FB60000000
@__GLOBAL_CONST_EPS = global float 0x3EB0C6F7A0000000
@__GLOBAL_CONST_PI_HEX = global float 0x400921FB60000000
@__GLOBAL_CONST_HEX2 = global float 0x3FB4000000000000
@__GLOBAL_CONST_FACT = global float -33000.0
@__GLOBAL_CONST_EVAL1 = global float 0x4057C21FC0000000
@__GLOBAL_CONST_EVAL2 = global float 0x4041475CE0000000
@__GLOBAL_CONST_EVAL3 = global float 0x4041475CE0000000
@__GLOBAL_CONST_CONV1 = global float 233.0
@__GLOBAL_CONST_CONV2 = global float 4095.0
@__GLOBAL_CONST_MAX = global i32 1000000000
@__GLOBAL_CONST_TWO = global i32 2
@__GLOBAL_CONST_THREE = global i32 3
@__GLOBAL_CONST_FIVE = global i32 5
declare i32 @getint()
declare void @putint(i32 %v0)
declare i32 @getch()
declare void @putch(i32 %v1)
declare float @getfloat()
declare void @putfloat(float %v2)
declare i32 @getarray(ptr %v3)
declare void @putarray(i32 %v4, ptr %v5)
declare i32 @getfarray(ptr %v6)
declare void @putfarray(i32 %v7, ptr %v8)
declare void @starttime(i32 %v9)
declare void @stoptime(i32 %v10)
declare void @memset(ptr %v11, i32 %v12, i32 %v13)
declare void @memcpy(ptr %v14, ptr %v15, i32 %v16)
define float @float_abs(float %v17) {
bb_0:
	%v19 = alloca float
	%v18 = alloca float
	store float %v17, ptr %v18
	%v20 = load float, ptr %v18
	%v22 = sitofp i32 0 to float
	%v23 = fcmp ult float %v20, %v22
	br i1 %v23, label %bb_2, label %bb_3
bb_2:
	%v24 = load float, ptr %v18
	%v26 = fsub float 0.0, %v24
	store float %v26, ptr %v19
	br label %bb_1
bb_3:
	%v27 = alloca i1
	%v28 = load float, ptr %v18
	store float %v28, ptr %v19
	br label %bb_1
bb_1:
	%v29 = load float, ptr %v19
	ret float %v29
}
define float @circle_area(i32 %v30) {
bb_4:
	%v32 = alloca float
	%v31 = alloca i32
	store i32 %v30, ptr %v31
	%v34 = load i32, ptr %v31
	%v35 = sitofp i32 %v34 to float
	%v36 = fmul float 0x400921FB60000000, %v35
	%v37 = load i32, ptr %v31
	%v38 = sitofp i32 %v37 to float
	%v39 = fmul float %v36, %v38
	%v40 = load i32, ptr %v31
	%v41 = load i32, ptr %v31
	%v42 = mul i32 %v40, %v41
	%v43 = sitofp i32 %v42 to float
	%v45 = fmul float %v43, 0x400921FB60000000
	%v46 = fadd float %v39, %v45
	%v48 = sitofp i32 2 to float
	%v49 = fdiv float %v46, %v48
	store float %v49, ptr %v32
	br label %bb_5
bb_5:
	%v50 = load float, ptr %v32
	ret float %v50
}
define i32 @float_eq(float %v51, float %v52) {
bb_6:
	%v55 = alloca i32
	%v54 = alloca float
	%v53 = alloca float
	store float %v51, ptr %v53
	store float %v52, ptr %v54
	%v56 = load float, ptr %v53
	%v57 = load float, ptr %v54
	%v58 = fsub float %v56, %v57
	%v59 = call float  @float_abs(float %v58)
	%v61 = fcmp ult float %v59, 0x3EB0C6F7A0000000
	br i1 %v61, label %bb_8, label %bb_10
bb_8:
	store i32 1, ptr %v55
	br label %bb_7
bb_10:
	store i32 0, ptr %v55
	br label %bb_7
bb_9:
	br label %bb_7
bb_7:
	%v64 = load i32, ptr %v55
	ret i32 %v64
}
define void @error() {
bb_11:
	call void @putch(i32 101)
	call void @putch(i32 114)
	call void @putch(i32 114)
	call void @putch(i32 111)
	call void @putch(i32 114)
	call void @putch(i32 10)
	br label %bb_12
bb_12:
	ret void
}
define void @ok() {
bb_13:
	call void @putch(i32 111)
	call void @putch(i32 107)
	call void @putch(i32 10)
	br label %bb_14
bb_14:
	ret void
}
define void @assert(i32 %v74) {
bb_15:
	%v75 = alloca i32
	store i32 %v74, ptr %v75
	%v76 = load i32, ptr %v75
	%v78 = icmp ne i32 %v76, 0
	%v80 = xor i1 %v78, true
	br i1 %v80, label %bb_17, label %bb_19
bb_17:
	call void @error()
	br label %bb_18
bb_19:
	call void @ok()
	br label %bb_18
bb_18:
	%v81 = alloca i1
	br label %bb_16
bb_16:
	ret void
}
define i32 @main() {
bb_20:
	%v182 = alloca float
	%v176 = alloca float
	%v174 = alloca float
	%v168 = alloca i32
	%v127 = alloca [10 x float]
	%v125 = alloca i32
	%v123 = alloca i32
	%v82 = alloca i32
	%v85 = call i32  @float_eq(float 0x3FB4000000000000, float -33000.0)
	%v87 = icmp ne i32 %v85, 0
	%v89 = xor i1 %v87, true
	%v90 = zext i1 %v89 to i32
	call void @assert(i32 %v90)
	%v93 = call i32  @float_eq(float 0x4057C21FC0000000, float 0x4041475CE0000000)
	%v95 = icmp ne i32 %v93, 0
	%v97 = xor i1 %v95, true
	%v98 = zext i1 %v97 to i32
	call void @assert(i32 %v98)
	%v101 = call i32  @float_eq(float 0x4041475CE0000000, float 0x4041475CE0000000)
	call void @assert(i32 %v101)
	%v103 = call float  @circle_area(i32 5)
	%v105 = call float  @circle_area(i32 5)
	%v106 = call i32  @float_eq(float %v103, float %v105)
	call void @assert(i32 %v106)
	%v109 = call i32  @float_eq(float 233.0, float 4095.0)
	%v111 = icmp ne i32 %v109, 0
	%v113 = xor i1 %v111, true
	%v114 = zext i1 %v113 to i32
	call void @assert(i32 %v114)
	br i1 true, label %bb_22, label %bb_23
bb_22:
	call void @ok()
	br label %bb_23
bb_23:
	%v116 = alloca i1
	br i1 true, label %bb_24, label %bb_25
bb_24:
	call void @ok()
	br label %bb_25
bb_25:
	%v118 = alloca i1
	br i1 false, label %bb_26, label %bb_27
bb_26:
	call void @error()
	br label %bb_27
bb_27:
	%v120 = alloca i1
	br i1 true, label %bb_28, label %bb_29
bb_28:
	call void @ok()
	br label %bb_29
bb_29:
	%v122 = alloca i1
	store i32 1, ptr %v123
	store i32 0, ptr %v125
	%v130 = getelementptr [10 x float], ptr %v127, i32 0, i32 0
	store float 1.0, ptr %v130
	%v134 = getelementptr [10 x float], ptr %v127, i32 0, i32 1
	store float 2.0, ptr %v134
	%v138 = getelementptr [10 x float], ptr %v127, i32 0, i32 2
	store float 0.0, ptr %v138
	%v142 = getelementptr [10 x float], ptr %v127, i32 0, i32 3
	store float 0.0, ptr %v142
	%v146 = getelementptr [10 x float], ptr %v127, i32 0, i32 4
	store float 0.0, ptr %v146
	%v150 = getelementptr [10 x float], ptr %v127, i32 0, i32 5
	store float 0.0, ptr %v150
	%v154 = getelementptr [10 x float], ptr %v127, i32 0, i32 6
	store float 0.0, ptr %v154
	%v158 = getelementptr [10 x float], ptr %v127, i32 0, i32 7
	store float 0.0, ptr %v158
	%v162 = getelementptr [10 x float], ptr %v127, i32 0, i32 8
	store float 0.0, ptr %v162
	%v166 = getelementptr [10 x float], ptr %v127, i32 0, i32 9
	store float 0.0, ptr %v166
	%v169 = call float  @getfarray(ptr %v127)
	%v170 = fptosi float %v169 to i32
	store i32 %v170, ptr %v168
	br label %bb_30
bb_30:
	%v171 = load i32, ptr %v123
	%v173 = icmp slt i32 %v171, 1000000000
	br i1 %v173, label %bb_31, label %bb_32
bb_31:
	%v175 = call float  @getfloat()
	store float %v175, ptr %v174
	%v178 = load float, ptr %v174
	%v179 = fmul float 0x400921FB60000000, %v178
	%v180 = load float, ptr %v174
	%v181 = fmul float %v179, %v180
	store float %v181, ptr %v176
	%v183 = load float, ptr %v174
	%v184 = fptosi float %v183 to i32
	%v185 = call float  @circle_area(i32 %v184)
	store float %v185, ptr %v182
	%v187 = load i32, ptr %v125
	%v188 = getelementptr [10 x float], ptr %v127, i32 0, i32 %v187
	%v190 = load i32, ptr %v125
	%v191 = getelementptr [10 x float], ptr %v127, i32 0, i32 %v190
	%v192 = load float, ptr %v191
	%v193 = load float, ptr %v174
	%v194 = fadd float %v192, %v193
	store float %v194, ptr %v188
	%v195 = load float, ptr %v176
	call void @putfloat(float %v195)
	call void @putch(i32 32)
	%v197 = load float, ptr %v182
	%v198 = fptosi float %v197 to i32
	call void @putint(i32 %v198)
	call void @putch(i32 10)
	%v200 = load i32, ptr %v123
	%v201 = sitofp i32 %v200 to float
	%v203 = fmul float %v201, 10.0
	%v204 = fptosi float %v203 to i32
	store i32 %v204, ptr %v123
	%v205 = load i32, ptr %v125
	%v207 = add i32 %v205, 1
	store i32 %v207, ptr %v125
	br label %bb_30
bb_32:
	%v208 = alloca i1
	%v209 = load i32, ptr %v168
	call void @putfarray(i32 %v209, ptr %v127)
	store i32 0, ptr %v82
	br label %bb_21
bb_21:
	%v211 = load i32, ptr %v82
	ret i32 %v211
}
