@__GLOBAL_VAR_n = global i32 zeroinitializer
@__GLOBAL_VAR_m = global i32 zeroinitializer
@__GLOBAL_CONST_maxn = global i32 1005
@__GLOBAL_CONST_maxm = global i32 5005
@__GLOBAL_VAR_to = global [5005 x i32] zeroinitializer
@__GLOBAL_VAR_next = global [5005 x i32] zeroinitializer
@__GLOBAL_VAR_head = global [1005 x i32] zeroinitializer
@__GLOBAL_VAR_cnt = global i32 0
@__GLOBAL_VAR_vis = global [1005 x i32] zeroinitializer
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
define i32 @quick_read() {
bb_0:
	%v22 = alloca i32
	%v20 = alloca i32
	%v18 = alloca i32
	%v17 = alloca i32
	%v19 = call i32  @getch()
	store i32 %v19, ptr %v18
	store i32 0, ptr %v20
	store i32 0, ptr %v22
	br label %bb_2
bb_2:
	%v24 = load i32, ptr %v18
	%v26 = icmp slt i32 %v24, 48
	br i1 %v26, label %bb_6, label %bb_5
bb_5:
	%v27 = load i32, ptr %v18
	%v29 = icmp slt i32 57, %v27
	br label %bb_6
bb_6:
	%v30 = phi i1[%v29, %bb_5], [true, %bb_2]
	br i1 %v30, label %bb_3, label %bb_4
bb_3:
	%v32 = load i32, ptr %v18
	%v34 = icmp eq i32 %v32, 45
	br i1 %v34, label %bb_7, label %bb_8
bb_7:
	store i32 1, ptr %v22
	br label %bb_8
bb_8:
	%v36 = alloca i1
	%v37 = call i32  @getch()
	store i32 %v37, ptr %v18
	br label %bb_2
bb_4:
	%v38 = alloca i1
	br label %bb_9
bb_9:
	%v39 = load i32, ptr %v18
	%v41 = icmp sle i32 48, %v39
	br i1 %v41, label %bb_12, label %bb_13
bb_12:
	%v42 = load i32, ptr %v18
	%v44 = icmp sle i32 %v42, 57
	br label %bb_13
bb_13:
	%v45 = phi i1[false, %bb_9], [%v44, %bb_12]
	br i1 %v45, label %bb_10, label %bb_11
bb_10:
	%v47 = load i32, ptr %v20
	%v49 = mul i32 %v47, 10
	%v50 = load i32, ptr %v18
	%v51 = add i32 %v49, %v50
	%v53 = sub i32 %v51, 48
	store i32 %v53, ptr %v20
	%v54 = call i32  @getch()
	store i32 %v54, ptr %v18
	br label %bb_9
bb_11:
	%v55 = alloca i1
	%v56 = load i32, ptr %v22
	%v58 = icmp ne i32 %v56, 0
	br i1 %v58, label %bb_14, label %bb_16
bb_14:
	%v59 = load i32, ptr %v20
	%v61 = sub i32 0, %v59
	store i32 %v61, ptr %v17
	br label %bb_1
bb_16:
	%v62 = load i32, ptr %v20
	store i32 %v62, ptr %v17
	br label %bb_1
bb_15:
	br label %bb_1
bb_1:
	%v63 = load i32, ptr %v17
	ret i32 %v63
}
define void @add_edge(i32 %v64, i32 %v65) {
bb_17:
	%v67 = alloca i32
	%v66 = alloca i32
	store i32 %v64, ptr %v66
	store i32 %v65, ptr %v67
	%v71 = load i32, ptr @__GLOBAL_VAR_cnt
	%v72 = getelementptr [5005 x i32], ptr @__GLOBAL_VAR_to, i32 0, i32 %v71
	%v73 = load i32, ptr %v67
	store i32 %v73, ptr %v72
	%v77 = load i32, ptr @__GLOBAL_VAR_cnt
	%v78 = getelementptr [5005 x i32], ptr @__GLOBAL_VAR_next, i32 0, i32 %v77
	%v81 = load i32, ptr %v66
	%v82 = getelementptr [1005 x i32], ptr @__GLOBAL_VAR_head, i32 0, i32 %v81
	%v83 = load i32, ptr %v82
	store i32 %v83, ptr %v78
	%v86 = load i32, ptr %v66
	%v87 = getelementptr [1005 x i32], ptr @__GLOBAL_VAR_head, i32 0, i32 %v86
	%v89 = load i32, ptr @__GLOBAL_VAR_cnt
	store i32 %v89, ptr %v87
	%v92 = load i32, ptr @__GLOBAL_VAR_cnt
	%v94 = add i32 %v92, 1
	store i32 %v94, ptr @__GLOBAL_VAR_cnt
	%v98 = load i32, ptr @__GLOBAL_VAR_cnt
	%v99 = getelementptr [5005 x i32], ptr @__GLOBAL_VAR_to, i32 0, i32 %v98
	%v100 = load i32, ptr %v66
	store i32 %v100, ptr %v99
	%v104 = load i32, ptr @__GLOBAL_VAR_cnt
	%v105 = getelementptr [5005 x i32], ptr @__GLOBAL_VAR_next, i32 0, i32 %v104
	%v108 = load i32, ptr %v67
	%v109 = getelementptr [1005 x i32], ptr @__GLOBAL_VAR_head, i32 0, i32 %v108
	%v110 = load i32, ptr %v109
	store i32 %v110, ptr %v105
	%v113 = load i32, ptr %v67
	%v114 = getelementptr [1005 x i32], ptr @__GLOBAL_VAR_head, i32 0, i32 %v113
	%v116 = load i32, ptr @__GLOBAL_VAR_cnt
	store i32 %v116, ptr %v114
	%v119 = load i32, ptr @__GLOBAL_VAR_cnt
	%v121 = add i32 %v119, 1
	store i32 %v121, ptr @__GLOBAL_VAR_cnt
	br label %bb_18
bb_18:
	ret void
}
define void @init() {
bb_19:
	%v122 = alloca i32
	store i32 0, ptr %v122
	br label %bb_21
bb_21:
	%v124 = load i32, ptr %v122
	%v126 = icmp slt i32 %v124, 1005
	br i1 %v126, label %bb_22, label %bb_23
bb_22:
	%v129 = load i32, ptr %v122
	%v130 = getelementptr [1005 x i32], ptr @__GLOBAL_VAR_head, i32 0, i32 %v129
	store i32 -1, ptr %v130
	%v132 = load i32, ptr %v122
	%v134 = add i32 %v132, 1
	store i32 %v134, ptr %v122
	br label %bb_21
bb_23:
	%v135 = alloca i1
	br label %bb_20
bb_20:
	ret void
}
define void @clear() {
bb_24:
	%v136 = alloca i32
	store i32 1, ptr %v136
	br label %bb_26
bb_26:
	%v138 = load i32, ptr %v136
	%v140 = load i32, ptr @__GLOBAL_VAR_n
	%v141 = icmp sle i32 %v138, %v140
	br i1 %v141, label %bb_27, label %bb_28
bb_27:
	%v144 = load i32, ptr %v136
	%v145 = getelementptr [1005 x i32], ptr @__GLOBAL_VAR_vis, i32 0, i32 %v144
	store i32 0, ptr %v145
	%v147 = load i32, ptr %v136
	%v149 = add i32 %v147, 1
	store i32 %v149, ptr %v136
	br label %bb_26
bb_28:
	%v150 = alloca i1
	br label %bb_25
bb_25:
	ret void
}
define i32 @same(i32 %v151, i32 %v152) {
bb_29:
	%v175 = alloca i32
	%v166 = alloca i32
	%v155 = alloca i32
	%v154 = alloca i32
	%v153 = alloca i32
	store i32 %v151, ptr %v153
	store i32 %v152, ptr %v154
	%v158 = load i32, ptr %v153
	%v159 = getelementptr [1005 x i32], ptr @__GLOBAL_VAR_vis, i32 0, i32 %v158
	store i32 1, ptr %v159
	%v161 = load i32, ptr %v153
	%v162 = load i32, ptr %v154
	%v163 = icmp eq i32 %v161, %v162
	br i1 %v163, label %bb_31, label %bb_32
bb_31:
	store i32 1, ptr %v155
	br label %bb_30
bb_32:
	%v165 = alloca i1
	%v169 = load i32, ptr %v153
	%v170 = getelementptr [1005 x i32], ptr @__GLOBAL_VAR_head, i32 0, i32 %v169
	%v171 = load i32, ptr %v170
	store i32 %v171, ptr %v166
	br label %bb_33
bb_33:
	%v172 = load i32, ptr %v166
	%v174 = icmp ne i32 %v172, -1
	br i1 %v174, label %bb_34, label %bb_35
bb_34:
	%v178 = load i32, ptr %v166
	%v179 = getelementptr [5005 x i32], ptr @__GLOBAL_VAR_to, i32 0, i32 %v178
	%v180 = load i32, ptr %v179
	store i32 %v180, ptr %v175
	%v183 = load i32, ptr %v175
	%v184 = getelementptr [1005 x i32], ptr @__GLOBAL_VAR_vis, i32 0, i32 %v183
	%v185 = load i32, ptr %v184
	%v187 = icmp ne i32 %v185, 0
	%v189 = xor i1 %v187, true
	br i1 %v189, label %bb_36, label %bb_37
bb_36:
	%v190 = load i32, ptr %v175
	%v191 = load i32, ptr %v154
	%v192 = call i32  @same(i32 %v190, i32 %v191)
	%v194 = icmp ne i32 %v192, 0
	br label %bb_37
bb_37:
	%v195 = phi i1[false, %bb_34], [%v194, %bb_36]
	br i1 %v195, label %bb_38, label %bb_39
bb_38:
	store i32 1, ptr %v155
	br label %bb_30
bb_39:
	%v198 = alloca i1
	%v201 = load i32, ptr %v166
	%v202 = getelementptr [5005 x i32], ptr @__GLOBAL_VAR_next, i32 0, i32 %v201
	%v203 = load i32, ptr %v202
	store i32 %v203, ptr %v166
	br label %bb_33
bb_35:
	%v204 = alloca i1
	store i32 0, ptr %v155
	br label %bb_30
bb_30:
	%v206 = load i32, ptr %v155
	ret i32 %v206
}
define i32 @main() {
bb_40:
	%v241 = alloca i32
	%v239 = alloca i32
	%v233 = alloca i32
	%v231 = alloca i32
	%v216 = alloca i32
	%v207 = alloca i32
	%v209 = call i32  @quick_read()
	store i32 %v209, ptr @__GLOBAL_VAR_n
	%v211 = call i32  @quick_read()
	store i32 %v211, ptr @__GLOBAL_VAR_m
	call void @init()
	br label %bb_42
bb_42:
	%v213 = load i32, ptr @__GLOBAL_VAR_m
	%v215 = icmp ne i32 %v213, 0
	br i1 %v215, label %bb_43, label %bb_44
bb_43:
	%v217 = call i32  @getch()
	store i32 %v217, ptr %v216
	br label %bb_45
bb_45:
	%v218 = load i32, ptr %v216
	%v220 = icmp ne i32 %v218, 81
	br i1 %v220, label %bb_48, label %bb_49
bb_48:
	%v221 = load i32, ptr %v216
	%v223 = icmp ne i32 %v221, 85
	br label %bb_49
bb_49:
	%v224 = phi i1[false, %bb_45], [%v223, %bb_48]
	br i1 %v224, label %bb_46, label %bb_47
bb_46:
	%v226 = call i32  @getch()
	store i32 %v226, ptr %v216
	br label %bb_45
bb_47:
	%v227 = alloca i1
	%v228 = load i32, ptr %v216
	%v230 = icmp eq i32 %v228, 81
	br i1 %v230, label %bb_50, label %bb_52
bb_50:
	%v232 = call i32  @quick_read()
	store i32 %v232, ptr %v231
	%v234 = call i32  @quick_read()
	store i32 %v234, ptr %v233
	call void @clear()
	%v235 = load i32, ptr %v231
	%v236 = load i32, ptr %v233
	%v237 = call i32  @same(i32 %v235, i32 %v236)
	call void @putint(i32 %v237)
	call void @putch(i32 10)
	br label %bb_51
bb_52:
	%v240 = call i32  @quick_read()
	store i32 %v240, ptr %v239
	%v242 = call i32  @quick_read()
	store i32 %v242, ptr %v241
	%v243 = load i32, ptr %v239
	%v244 = load i32, ptr %v241
	call void @add_edge(i32 %v243, i32 %v244)
	br label %bb_51
bb_51:
	%v245 = alloca i1
	%v248 = load i32, ptr @__GLOBAL_VAR_m
	%v250 = sub i32 %v248, 1
	store i32 %v250, ptr @__GLOBAL_VAR_m
	br label %bb_42
bb_44:
	%v251 = alloca i1
	store i32 0, ptr %v207
	br label %bb_41
bb_41:
	%v253 = load i32, ptr %v207
	ret i32 %v253
}
