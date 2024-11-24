@__GLOBAL_CONST_maxn = global i32 1005
@__GLOBAL_VAR_n = global i32 1000
@__GLOBAL_VAR_m = global i32 undef
@__GLOBAL_VAR_a = global [1005 x float] undef
@__GLOBAL_VAR_ff = global [1005 x float] undef
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
define float @DFS(i32 %v17, float %v18, float %v19, float %v20, ptr %v21) {
bb_0:
	%v85 = alloca i32
	%v83 = alloca [1005 x float]
	%v23 = alloca float
	%v22 = alloca i32
	store i32 %v17, ptr %v22
	%v26 = alloca float
	store ptr %v22, ptr %v26
	%v27 = load i32, ptr %v26
	%v28 = getelementptr [1005 x float], ptr @__GLOBAL_VAR_ff, i32 0, i32 %v27
	%v29 = alloca float
	store float %v20, ptr %v29
	%v30 = load float, ptr %v29
	%v33 = alloca float
	store ptr %v22, ptr %v33
	%v34 = load i32, ptr %v33
	%v35 = getelementptr [1005 x float], ptr @__GLOBAL_VAR_a, i32 0, i32 %v34
	%v36 = load float, ptr %v35
	%v38 = sitofp i32 3 to float
	%v39 = alloca float
	store float %v18, ptr %v39
	%v40 = load float, ptr %v39
	%v41 = fmul float %v38, %v40
	%v43 = sitofp i32 3 to float
	%v44 = alloca float
	store float %v19, ptr %v44
	%v45 = load float, ptr %v44
	%v46 = fmul float %v43, %v45
	%v47 = fadd float %v41, %v46
	%v49 = sitofp i32 1 to float
	%v50 = fadd float %v47, %v49
	%v51 = fmul float %v36, %v50
	%v52 = fadd float %v30, %v51
	store float %v52, ptr %v28
	%v54 = alloca float
	store ptr %v22, ptr %v54
	%v55 = load i32, ptr %v54
	%v56 = getelementptr float, float* %v21, i32 %v55
	%v59 = alloca float
	store ptr %v22, ptr %v59
	%v60 = load i32, ptr %v59
	%v61 = getelementptr [1005 x float], ptr @__GLOBAL_VAR_a, i32 0, i32 %v60
	%v62 = load float, ptr %v61
	%v63 = alloca float
	store float %v18, ptr %v63
	%v64 = load float, ptr %v63
	%v66 = sitofp i32 1 to float
	%v67 = fadd float %v64, %v66
	%v68 = fmul float %v62, %v67
	store float %v68, ptr %v56
	%v69 = alloca float
	store ptr %v22, ptr %v69
	%v70 = load i32, ptr %v69
	%v72 = alloca float
	store ptr @__GLOBAL_VAR_n, ptr %v72
	%v73 = load i32, ptr %v72
	%v74 = icmp eq i32 %v70, %v73
	br i1 %v74, label %bb_2, label %bb_3
bb_2:
	%v75 = alloca float
	store ptr %v22, ptr %v75
	%v76 = load i32, ptr %v75
	%v77 = sitofp i32 %v76 to float
	%v78 = alloca float
	store ptr %v21, ptr %v78
	%v79 = load ptr, ptr %v78
	call void @putfarray(float %v77, ptr %v79)
	%v80 = alloca float
	store float %v19, ptr %v80
	%v81 = load float, ptr %v80
	store float %v81, ptr %v23
	br label %bb_1
bb_3:
	%v82 = alloca i1
	store [1005 x float] undef, ptr %v83
	store i32 0, ptr %v85
	br label %bb_4
bb_4:
	%v87 = alloca float
	store ptr %v85, ptr %v87
	%v88 = load i32, ptr %v87
	%v90 = alloca float
	store ptr @__GLOBAL_VAR_n, ptr %v90
	%v91 = load i32, ptr %v90
	%v92 = icmp slt i32 %v88, %v91
	br i1 %v92, label %bb_5, label %bb_6
bb_5:
	%v94 = alloca float
	store ptr %v85, ptr %v94
	%v95 = load i32, ptr %v94
	%v96 = getelementptr [1005 x float], ptr %v83, i32 0, i32 %v95
	%v98 = alloca float
	store ptr %v85, ptr %v98
	%v99 = load i32, ptr %v98
	%v100 = getelementptr float, float* %v21, i32 %v99
	%v101 = load float, ptr %v100
	%v102 = alloca float
	store float %v18, ptr %v102
	%v103 = load float, ptr %v102
	%v104 = fadd float %v101, %v103
	%v105 = alloca float
	store float %v19, ptr %v105
	%v106 = load float, ptr %v105
	%v107 = fadd float %v104, %v106
	%v108 = alloca float
	store float %v20, ptr %v108
	%v109 = load float, ptr %v108
	%v110 = fadd float %v107, %v109
	store float %v110, ptr %v96
	%v111 = alloca float
	store ptr %v85, ptr %v111
	%v112 = load i32, ptr %v111
	%v114 = add i32 %v112, 1
	store i32 %v114, ptr %v85
	br label %bb_4
bb_6:
	%v115 = alloca i1
	%v116 = alloca float
	store ptr %v22, ptr %v116
	%v117 = load i32, ptr %v116
	%v119 = add i32 %v117, 1
	%v121 = alloca float
	store ptr %v22, ptr %v121
	%v122 = load i32, ptr %v121
	%v123 = getelementptr float, float* %v21, i32 %v122
	%v124 = load float, ptr %v123
	%v127 = alloca float
	store ptr %v22, ptr %v127
	%v128 = load i32, ptr %v127
	%v129 = getelementptr [1005 x float], ptr @__GLOBAL_VAR_a, i32 0, i32 %v128
	%v130 = load float, ptr %v129
	%v131 = alloca float
	store float %v18, ptr %v131
	%v132 = load float, ptr %v131
	%v134 = sitofp i32 2 to float
	%v135 = alloca float
	store float %v19, ptr %v135
	%v136 = load float, ptr %v135
	%v137 = fmul float %v134, %v136
	%v138 = fadd float %v132, %v137
	%v140 = sitofp i32 1 to float
	%v141 = fadd float %v138, %v140
	%v142 = fmul float %v130, %v141
	%v145 = alloca float
	store ptr %v22, ptr %v145
	%v146 = load i32, ptr %v145
	%v147 = getelementptr [1005 x float], ptr @__GLOBAL_VAR_ff, i32 0, i32 %v146
	%v148 = load float, ptr %v147
	%v149 = call float  @DFS(i32 %v119, float %v124, float %v142, float %v148, ptr %v83)
	store float %v149, ptr %v23
	br label %bb_1
bb_1:
	%v150 = load float, ptr %v23
	ret float %v150
}
define i32 @main() {
bb_7:
	%v151 = alloca i32
	%v153 = call float  @getfarray(ptr @__GLOBAL_VAR_a)
	store i32 0, ptr %v151
	br label %bb_8
bb_8:
	%v155 = load i32, ptr %v151
	ret i32 %v155
}
