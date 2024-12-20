@__GLOBAL_VAR_A = global [100 x i32] zeroinitializer
@__GLOBAL_VAR_B = global [100 x i32] zeroinitializer
@__GLOBAL_VAR_C = global [100 x i32] zeroinitializer
@__GLOBAL_VAR_D = global [100 x i32] zeroinitializer
@__GLOBAL_CONST_p = global i32 234145
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
define void @f(ptr %v17, ptr %v18, ptr %v19, ptr %v20, i32 %v21) {
bb_0:
	%v27 = alloca i32
	%v22 = alloca i32
	store i32 %v21, ptr %v22
	%v23 = load i32, ptr %v22
	%v25 = icmp eq i32 %v23, 0
	br i1 %v25, label %bb_2, label %bb_3
bb_2:
	br label %bb_1
bb_3:
	%v26 = alloca i1
	store i32 0, ptr %v27
	br label %bb_4
bb_4:
	%v29 = load i32, ptr %v27
	%v31 = icmp slt i32 %v29, 100
	br i1 %v31, label %bb_5, label %bb_6
bb_5:
	%v33 = load i32, ptr %v27
	%v34 = getelementptr i32, i32* %v17, i32 %v33
	%v36 = load i32, ptr %v27
	%v37 = getelementptr i32, i32* %v19, i32 %v36
	%v38 = load i32, ptr %v37
	%v40 = load i32, ptr %v27
	%v41 = getelementptr i32, i32* %v18, i32 %v40
	%v42 = load i32, ptr %v41
	%v43 = add i32 %v38, %v42
	%v45 = load i32, ptr %v27
	%v46 = getelementptr i32, i32* %v20, i32 %v45
	%v47 = load i32, ptr %v46
	%v48 = add i32 %v43, %v47
	store i32 %v48, ptr %v34
	%v50 = load i32, ptr %v27
	%v51 = getelementptr i32, i32* %v18, i32 %v50
	%v53 = load i32, ptr %v27
	%v54 = getelementptr i32, i32* %v17, i32 %v53
	%v55 = load i32, ptr %v54
	%v57 = load i32, ptr %v27
	%v58 = getelementptr i32, i32* %v19, i32 %v57
	%v59 = load i32, ptr %v58
	%v60 = add i32 %v55, %v59
	%v62 = load i32, ptr %v27
	%v63 = getelementptr i32, i32* %v20, i32 %v62
	%v64 = load i32, ptr %v63
	%v65 = add i32 %v60, %v64
	store i32 %v65, ptr %v51
	%v67 = load i32, ptr %v27
	%v68 = getelementptr i32, i32* %v19, i32 %v67
	%v70 = load i32, ptr %v27
	%v71 = getelementptr i32, i32* %v18, i32 %v70
	%v72 = load i32, ptr %v71
	%v74 = load i32, ptr %v27
	%v75 = getelementptr i32, i32* %v17, i32 %v74
	%v76 = load i32, ptr %v75
	%v77 = add i32 %v72, %v76
	%v79 = load i32, ptr %v27
	%v80 = getelementptr i32, i32* %v20, i32 %v79
	%v81 = load i32, ptr %v80
	%v82 = add i32 %v77, %v81
	store i32 %v82, ptr %v68
	%v84 = load i32, ptr %v27
	%v85 = getelementptr i32, i32* %v17, i32 %v84
	%v87 = load i32, ptr %v27
	%v88 = getelementptr i32, i32* %v17, i32 %v87
	%v89 = load i32, ptr %v88
	%v91 = srem i32 %v89, 234145
	store i32 %v91, ptr %v85
	%v93 = load i32, ptr %v27
	%v94 = getelementptr i32, i32* %v18, i32 %v93
	%v96 = load i32, ptr %v27
	%v97 = getelementptr i32, i32* %v18, i32 %v96
	%v98 = load i32, ptr %v97
	%v100 = srem i32 %v98, 234145
	store i32 %v100, ptr %v94
	%v102 = load i32, ptr %v27
	%v103 = getelementptr i32, i32* %v19, i32 %v102
	%v105 = load i32, ptr %v27
	%v106 = getelementptr i32, i32* %v19, i32 %v105
	%v107 = load i32, ptr %v106
	%v109 = srem i32 %v107, 234145
	store i32 %v109, ptr %v103
	%v110 = load i32, ptr %v27
	%v112 = add i32 %v110, 1
	store i32 %v112, ptr %v27
	br label %bb_4
bb_6:
	%v113 = alloca i1
	%v114 = load i32, ptr %v22
	%v116 = sub i32 %v114, 1
	call void @f(ptr %v18, ptr %v19, ptr %v17, ptr %v20, i32 %v116)
	br label %bb_1
bb_1:
	ret void
}
define i32 @sum(ptr %v117) {
bb_7:
	%v121 = alloca i32
	%v119 = alloca i32
	%v118 = alloca i32
	store i32 0, ptr %v119
	store i32 0, ptr %v121
	br label %bb_9
bb_9:
	%v123 = load i32, ptr %v119
	%v125 = icmp slt i32 %v123, 100
	br i1 %v125, label %bb_10, label %bb_11
bb_10:
	%v126 = load i32, ptr %v121
	%v128 = load i32, ptr %v119
	%v129 = getelementptr i32, i32* %v117, i32 %v128
	%v130 = load i32, ptr %v129
	%v131 = add i32 %v126, %v130
	store i32 %v131, ptr %v121
	%v132 = load i32, ptr %v119
	%v134 = add i32 %v132, 1
	store i32 %v134, ptr %v119
	br label %bb_9
bb_11:
	%v135 = alloca i1
	%v136 = load i32, ptr %v121
	store i32 %v136, ptr %v118
	br label %bb_8
bb_8:
	%v137 = load i32, ptr %v118
	ret i32 %v137
}
define i32 @main() {
bb_12:
	%v182 = alloca i32
	%v139 = alloca i32
	%v138 = alloca i32
	store i32 0, ptr %v139
	br label %bb_14
bb_14:
	%v141 = load i32, ptr %v139
	%v143 = icmp slt i32 %v141, 100
	br i1 %v143, label %bb_15, label %bb_16
bb_15:
	%v146 = load i32, ptr %v139
	%v147 = getelementptr [100 x i32], ptr @__GLOBAL_VAR_A, i32 0, i32 %v146
	%v149 = load i32, ptr %v139
	%v151 = sdiv i32 %v149, 4
	%v152 = add i32 1, %v151
	store i32 %v152, ptr %v147
	%v155 = load i32, ptr %v139
	%v156 = getelementptr [100 x i32], ptr @__GLOBAL_VAR_B, i32 0, i32 %v155
	%v158 = load i32, ptr %v139
	%v160 = sdiv i32 %v158, 3
	%v161 = add i32 2, %v160
	store i32 %v161, ptr %v156
	%v164 = load i32, ptr %v139
	%v165 = getelementptr [100 x i32], ptr @__GLOBAL_VAR_C, i32 0, i32 %v164
	%v167 = load i32, ptr %v139
	%v169 = sdiv i32 %v167, 2
	%v170 = add i32 3, %v169
	store i32 %v170, ptr %v165
	%v173 = load i32, ptr %v139
	%v174 = getelementptr [100 x i32], ptr @__GLOBAL_VAR_D, i32 0, i32 %v173
	%v176 = load i32, ptr %v139
	%v177 = add i32 4, %v176
	store i32 %v177, ptr %v174
	%v178 = load i32, ptr %v139
	%v180 = add i32 %v178, 1
	store i32 %v180, ptr %v139
	br label %bb_14
bb_16:
	%v181 = alloca i1
	store i32 0, ptr %v182
	%v184 = load i32, ptr %v182
	%v186 = call i32  @sum(ptr @__GLOBAL_VAR_D)
	%v187 = add i32 %v184, %v186
	store i32 %v187, ptr %v182
	call void @f(ptr @__GLOBAL_VAR_A, ptr @__GLOBAL_VAR_B, ptr @__GLOBAL_VAR_C, ptr @__GLOBAL_VAR_D, i32 10)
	%v193 = load i32, ptr %v182
	%v195 = call i32  @sum(ptr @__GLOBAL_VAR_D)
	%v196 = add i32 %v193, %v195
	store i32 %v196, ptr %v182
	call void @f(ptr @__GLOBAL_VAR_A, ptr @__GLOBAL_VAR_A, ptr @__GLOBAL_VAR_A, ptr @__GLOBAL_VAR_D, i32 10)
	%v202 = load i32, ptr %v182
	%v204 = call i32  @sum(ptr @__GLOBAL_VAR_D)
	%v205 = add i32 %v202, %v204
	store i32 %v205, ptr %v182
	%v206 = load i32, ptr %v182
	%v208 = call i32  @sum(ptr @__GLOBAL_VAR_A)
	%v209 = add i32 %v206, %v208
	store i32 %v209, ptr %v182
	call void @f(ptr @__GLOBAL_VAR_D, ptr @__GLOBAL_VAR_D, ptr @__GLOBAL_VAR_D, ptr @__GLOBAL_VAR_A, i32 10)
	%v215 = load i32, ptr %v182
	%v217 = call i32  @sum(ptr @__GLOBAL_VAR_A)
	%v218 = add i32 %v215, %v217
	store i32 %v218, ptr %v182
	%v219 = load i32, ptr %v182
	%v221 = call i32  @sum(ptr @__GLOBAL_VAR_D)
	%v222 = add i32 %v219, %v221
	store i32 %v222, ptr %v182
	%v223 = load i32, ptr %v182
	call void @putint(i32 %v223)
	call void @putch(i32 10)
	call void @putarray(i32 100, ptr @__GLOBAL_VAR_A)
	call void @putarray(i32 100, ptr @__GLOBAL_VAR_B)
	call void @putarray(i32 100, ptr @__GLOBAL_VAR_C)
	call void @putarray(i32 100, ptr @__GLOBAL_VAR_D)
	store i32 0, ptr %v138
	br label %bb_13
bb_13:
	%v234 = load i32, ptr %v138
	ret i32 %v234
}
