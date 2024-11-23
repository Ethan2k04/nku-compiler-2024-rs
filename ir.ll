@__GLOBAL_VAR_x = global [3 x i32] [i32 2344, i32 1232, i32 3435]
@__GLOBAL_VAR_y = global [3 x i32] [i32 234, i32 566, i32 127378]
@__GLOBAL_VAR_d = global i32 undef
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
define void @modx() {
bb_0:
	%v21 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_x, i32 0, i32 0
	%v22 = load i32, ptr %v21
	%v24 = add i32 %v22, 2
	store i32 %v24, ptr @__GLOBAL_VAR_x
	%v29 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_x, i32 0, i32 1
	%v30 = load i32, ptr %v29
	%v32 = add i32 %v30, 2
	store i32 %v32, ptr @__GLOBAL_VAR_x
	%v37 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_x, i32 0, i32 2
	%v38 = load i32, ptr %v37
	%v40 = add i32 %v38, 2
	store i32 %v40, ptr @__GLOBAL_VAR_x
	br label %bb_1
bb_1:
	ret void
}
define void @mody() {
bb_2:
	%v45 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_y, i32 0, i32 0
	%v46 = load i32, ptr %v45
	%v48 = add i32 %v46, 2
	store i32 %v48, ptr @__GLOBAL_VAR_y
	%v53 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_y, i32 0, i32 1
	%v54 = load i32, ptr %v53
	%v56 = add i32 %v54, 2
	store i32 %v56, ptr @__GLOBAL_VAR_y
	%v61 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_y, i32 0, i32 2
	%v62 = load i32, ptr %v61
	%v64 = add i32 %v62, 2
	store i32 %v64, ptr @__GLOBAL_VAR_y
	br label %bb_3
bb_3:
	ret void
}
define void @refx() {
bb_4:
	%v69 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_x, i32 0, i32 0
	%v70 = load i32, ptr %v69
	%v74 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_x, i32 0, i32 1
	%v75 = load i32, ptr %v74
	%v76 = add i32 %v70, %v75
	%v80 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_x, i32 0, i32 2
	%v81 = load i32, ptr %v80
	%v82 = add i32 %v76, %v81
	store i32 %v82, ptr @__GLOBAL_VAR_d
	br label %bb_5
bb_5:
	ret void
}
define void @refy() {
bb_6:
	%v87 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_y, i32 0, i32 0
	%v88 = load i32, ptr %v87
	%v92 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_y, i32 0, i32 1
	%v93 = load i32, ptr %v92
	%v94 = add i32 %v88, %v93
	%v98 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_y, i32 0, i32 2
	%v99 = load i32, ptr %v98
	%v100 = add i32 %v94, %v99
	store i32 %v100, ptr @__GLOBAL_VAR_d
	br label %bb_7
bb_7:
	ret void
}
define void @modxrefy() {
bb_8:
	%v105 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_y, i32 0, i32 0
	%v106 = load i32, ptr %v105
	%v108 = add i32 %v106, 3
	store i32 %v108, ptr @__GLOBAL_VAR_x
	%v113 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_y, i32 0, i32 1
	%v114 = load i32, ptr %v113
	%v116 = add i32 %v114, 4
	store i32 %v116, ptr @__GLOBAL_VAR_x
	%v121 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_y, i32 0, i32 2
	%v122 = load i32, ptr %v121
	%v124 = add i32 %v122, 5
	store i32 %v124, ptr @__GLOBAL_VAR_x
	br label %bb_9
bb_9:
	ret void
}
define void @modyrefx() {
bb_10:
	%v129 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_x, i32 0, i32 0
	%v130 = load i32, ptr %v129
	%v132 = add i32 %v130, 5
	store i32 %v132, ptr @__GLOBAL_VAR_y
	%v137 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_x, i32 0, i32 1
	%v138 = load i32, ptr %v137
	%v140 = add i32 %v138, 6
	store i32 %v140, ptr @__GLOBAL_VAR_y
	%v145 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_x, i32 0, i32 2
	%v146 = load i32, ptr %v145
	%v148 = add i32 %v146, 7
	store i32 %v148, ptr @__GLOBAL_VAR_y
	br label %bb_11
bb_11:
	ret void
}
define i32 @main() {
bb_12:
	%v150 = alloca i32
	%v149 = alloca i32
	%v154 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_x, i32 0, i32 2
	%v155 = load i32, ptr %v154
	store i32 %v155, ptr %v150
	%v156 = load i32, ptr %v150
	call void @putint(i32 %v156)
	call void @putch(i32 10)
	store i32 3, ptr @__GLOBAL_VAR_y
	%v160 = load i32, ptr %v150
	%v164 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_x, i32 0, i32 2
	%v165 = load i32, ptr %v164
	%v166 = add i32 %v160, %v165
	store i32 %v166, ptr %v150
	%v167 = load i32, ptr %v150
	call void @putint(i32 %v167)
	call void @putch(i32 10)
	store i32 3, ptr @__GLOBAL_VAR_x
	%v171 = load i32, ptr %v150
	%v175 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_x, i32 0, i32 2
	%v176 = load i32, ptr %v175
	%v177 = add i32 %v171, %v176
	%v179 = load i32, ptr @__GLOBAL_VAR_d
	%v180 = add i32 %v177, %v179
	store i32 %v180, ptr %v150
	%v181 = load i32, ptr %v150
	call void @putint(i32 %v181)
	call void @putch(i32 10)
	store i32 5, ptr @__GLOBAL_VAR_d
	%v185 = load i32, ptr %v150
	%v189 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_x, i32 0, i32 2
	%v190 = load i32, ptr %v189
	%v191 = add i32 %v185, %v190
	%v193 = load i32, ptr @__GLOBAL_VAR_d
	%v194 = add i32 %v191, %v193
	%v196 = load i32, ptr @__GLOBAL_VAR_d
	%v197 = add i32 %v194, %v196
	store i32 %v197, ptr %v150
	%v198 = load i32, ptr %v150
	call void @putint(i32 %v198)
	call void @putch(i32 10)
	call void @refx()
	%v201 = load i32, ptr @__GLOBAL_VAR_d
	call void @putint(i32 %v201)
	call void @putch(i32 10)
	br label %bb_13
bb_13:
	%v203 = load i32, ptr %v149
	ret i32 %v203
}
