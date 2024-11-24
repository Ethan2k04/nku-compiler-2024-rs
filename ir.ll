@__GLOBAL_VAR_M = global i32 undef
@__GLOBAL_VAR_L = global i32 undef
@__GLOBAL_VAR_N = global i32 undef
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
define i32 @add(ptr %v17, ptr %v18, ptr %v19, ptr %v20, ptr %v21, ptr %v22, ptr %v23, ptr %v24, ptr %v25) {
bb_0:
	%v27 = alloca i32
	%v26 = alloca i32
	store i32 undef, ptr %v27
	store i32 0, ptr %v27
	br label %bb_2
bb_2:
	%v30 = load i32, ptr %v27
	%v32 = load i32, ptr @__GLOBAL_VAR_M
	%v33 = icmp slt i32 %v30, %v32
	br i1 %v33, label %bb_3, label %bb_4
bb_3:
	%v35 = load i32, ptr %v27
	%v36 = getelementptr i32, i32* %v23, i32 %v35
	%v38 = load i32, ptr %v27
	%v39 = getelementptr i32, i32* %v17, i32 %v38
	%v40 = load i32, ptr %v39
	%v42 = load i32, ptr %v27
	%v43 = getelementptr i32, i32* %v20, i32 %v42
	%v44 = load i32, ptr %v43
	%v45 = add i32 %v40, %v44
	store i32 %v45, ptr %v36
	%v47 = load i32, ptr %v27
	%v48 = getelementptr i32, i32* %v24, i32 %v47
	%v50 = load i32, ptr %v27
	%v51 = getelementptr i32, i32* %v18, i32 %v50
	%v52 = load i32, ptr %v51
	%v54 = load i32, ptr %v27
	%v55 = getelementptr i32, i32* %v21, i32 %v54
	%v56 = load i32, ptr %v55
	%v57 = add i32 %v52, %v56
	store i32 %v57, ptr %v48
	%v59 = load i32, ptr %v27
	%v60 = getelementptr i32, i32* %v25, i32 %v59
	%v62 = load i32, ptr %v27
	%v63 = getelementptr i32, i32* %v19, i32 %v62
	%v64 = load i32, ptr %v63
	%v66 = load i32, ptr %v27
	%v67 = getelementptr i32, i32* %v22, i32 %v66
	%v68 = load i32, ptr %v67
	%v69 = add i32 %v64, %v68
	store i32 %v69, ptr %v60
	%v70 = load i32, ptr %v27
	%v72 = add i32 %v70, 1
	store i32 %v72, ptr %v27
	br label %bb_2
bb_4:
	%v73 = alloca i1
	store i32 0, ptr %v26
	br label %bb_1
bb_1:
	%v75 = load i32, ptr %v26
	ret i32 %v75
}
define i32 @main() {
bb_5:
	%v137 = alloca i32
	%v101 = alloca i32
	%v99 = alloca [3 x i32]
	%v97 = alloca [3 x i32]
	%v95 = alloca [6 x i32]
	%v93 = alloca [3 x i32]
	%v91 = alloca [3 x i32]
	%v89 = alloca [3 x i32]
	%v87 = alloca [3 x i32]
	%v85 = alloca [3 x i32]
	%v83 = alloca [3 x i32]
	%v76 = alloca i32
	store i32 3, ptr @__GLOBAL_VAR_N
	store i32 3, ptr @__GLOBAL_VAR_M
	store i32 3, ptr @__GLOBAL_VAR_L
	store [3 x i32] undef, ptr %v83
	store [3 x i32] undef, ptr %v85
	store [3 x i32] undef, ptr %v87
	store [3 x i32] undef, ptr %v89
	store [3 x i32] undef, ptr %v91
	store [3 x i32] undef, ptr %v93
	store [6 x i32] undef, ptr %v95
	store [3 x i32] undef, ptr %v97
	store [3 x i32] undef, ptr %v99
	store i32 undef, ptr %v101
	store i32 0, ptr %v101
	br label %bb_7
bb_7:
	%v104 = load i32, ptr %v101
	%v106 = load i32, ptr @__GLOBAL_VAR_M
	%v107 = icmp slt i32 %v104, %v106
	br i1 %v107, label %bb_8, label %bb_9
bb_8:
	%v109 = load i32, ptr %v101
	%v110 = getelementptr [3 x i32], [3 x i32]* %v83, i32 %v109
	%v111 = load i32, ptr %v101
	store i32 %v111, ptr %v110
	%v113 = load i32, ptr %v101
	%v114 = getelementptr [3 x i32], [3 x i32]* %v85, i32 %v113
	%v115 = load i32, ptr %v101
	store i32 %v115, ptr %v114
	%v117 = load i32, ptr %v101
	%v118 = getelementptr [3 x i32], [3 x i32]* %v87, i32 %v117
	%v119 = load i32, ptr %v101
	store i32 %v119, ptr %v118
	%v121 = load i32, ptr %v101
	%v122 = getelementptr [3 x i32], [3 x i32]* %v89, i32 %v121
	%v123 = load i32, ptr %v101
	store i32 %v123, ptr %v122
	%v125 = load i32, ptr %v101
	%v126 = getelementptr [3 x i32], [3 x i32]* %v91, i32 %v125
	%v127 = load i32, ptr %v101
	store i32 %v127, ptr %v126
	%v129 = load i32, ptr %v101
	%v130 = getelementptr [3 x i32], [3 x i32]* %v93, i32 %v129
	%v131 = load i32, ptr %v101
	store i32 %v131, ptr %v130
	%v132 = load i32, ptr %v101
	%v134 = add i32 %v132, 1
	store i32 %v134, ptr %v101
	br label %bb_7
bb_9:
	%v135 = alloca i1
	%v136 = call i32  @add(ptr %v83, ptr %v85, ptr %v87, ptr %v89, ptr %v91, ptr %v93, ptr %v95, ptr %v97, ptr %v99)
	store i32 %v136, ptr %v101
	store i32 undef, ptr %v137
	br label %bb_10
bb_10:
	%v139 = load i32, ptr %v101
	%v141 = load i32, ptr @__GLOBAL_VAR_N
	%v142 = icmp slt i32 %v139, %v141
	br i1 %v142, label %bb_11, label %bb_12
bb_11:
	%v144 = load i32, ptr %v101
	%v145 = getelementptr [6 x i32], [6 x i32]* %v95, i32 %v144
	%v146 = load i32, ptr %v145
	store i32 %v146, ptr %v137
	%v147 = load i32, ptr %v137
	call void @putint(i32 %v147)
	%v148 = load i32, ptr %v101
	%v150 = add i32 %v148, 1
	store i32 %v150, ptr %v101
	br label %bb_10
bb_12:
	%v151 = alloca i1
	store i32 10, ptr %v137
	%v153 = load i32, ptr %v137
	call void @putch(i32 %v153)
	store i32 0, ptr %v101
	br label %bb_13
bb_13:
	%v155 = load i32, ptr %v101
	%v157 = load i32, ptr @__GLOBAL_VAR_N
	%v158 = icmp slt i32 %v155, %v157
	br i1 %v158, label %bb_14, label %bb_15
bb_14:
	%v160 = load i32, ptr %v101
	%v161 = getelementptr [3 x i32], [3 x i32]* %v97, i32 %v160
	%v162 = load i32, ptr %v161
	store i32 %v162, ptr %v137
	%v163 = load i32, ptr %v137
	call void @putint(i32 %v163)
	%v164 = load i32, ptr %v101
	%v166 = add i32 %v164, 1
	store i32 %v166, ptr %v101
	br label %bb_13
bb_15:
	%v167 = alloca i1
	store i32 10, ptr %v137
	%v169 = load i32, ptr %v137
	call void @putch(i32 %v169)
	store i32 0, ptr %v101
	br label %bb_16
bb_16:
	%v171 = load i32, ptr %v101
	%v173 = load i32, ptr @__GLOBAL_VAR_N
	%v174 = icmp slt i32 %v171, %v173
	br i1 %v174, label %bb_17, label %bb_18
bb_17:
	%v176 = load i32, ptr %v101
	%v177 = getelementptr [3 x i32], [3 x i32]* %v99, i32 %v176
	%v178 = load i32, ptr %v177
	store i32 %v178, ptr %v137
	%v179 = load i32, ptr %v137
	call void @putint(i32 %v179)
	%v180 = load i32, ptr %v101
	%v182 = add i32 %v180, 1
	store i32 %v182, ptr %v101
	br label %bb_16
bb_18:
	%v183 = alloca i1
	store i32 10, ptr %v137
	%v185 = load i32, ptr %v137
	call void @putch(i32 %v185)
	store i32 0, ptr %v76
	br label %bb_6
bb_6:
	%v187 = load i32, ptr %v76
	ret i32 %v187
}
