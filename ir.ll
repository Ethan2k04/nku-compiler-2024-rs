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
define i32 @main() {
bb_0:
	%v67 = alloca i32
	%v35 = alloca i32
	%v30 = alloca i32
	%v25 = alloca i32
	%v20 = alloca i32
	%v18 = alloca i32
	%v17 = alloca i32
	store i32 0, ptr %v18
	store i32 0, ptr %v20
	br label %bb_2
bb_2:
	%v22 = load i32, ptr %v20
	%v24 = icmp slt i32 %v22, 20
	br i1 %v24, label %bb_3, label %bb_4
bb_3:
	store i32 0, ptr %v25
	br label %bb_5
bb_5:
	%v27 = load i32, ptr %v25
	%v29 = icmp slt i32 %v27, 10
	br i1 %v29, label %bb_6, label %bb_7
bb_6:
	store i32 0, ptr %v30
	br label %bb_8
bb_8:
	%v32 = load i32, ptr %v30
	%v34 = icmp slt i32 %v32, 5
	br i1 %v34, label %bb_9, label %bb_10
bb_9:
	store i32 0, ptr %v35
	br label %bb_11
bb_11:
	%v37 = load i32, ptr %v35
	%v39 = icmp slt i32 %v37, 3
	br i1 %v39, label %bb_12, label %bb_13
bb_12:
	%v40 = load i32, ptr %v35
	%v42 = add i32 %v40, 1
	%v44 = icmp sle i32 3, %v42
	br i1 %v44, label %bb_14, label %bb_15
bb_14:
	%v45 = load i32, ptr %v35
	%v47 = icmp ne i32 %v45, 0
	br i1 %v47, label %bb_16, label %bb_17
bb_15:
	%v66 = alloca i1
	store i32 0, ptr %v67
	br label %bb_24
bb_16:
	%v48 = load i32, ptr %v35
	%v50 = icmp ne i32 %v48, 0
	br i1 %v50, label %bb_19, label %bb_18
bb_17:
	%v65 = alloca i1
	br label %bb_15
bb_18:
	%v51 = load i32, ptr %v35
	%v53 = icmp ne i32 %v51, 0
	%v55 = xor i1 %v53, true
	br label %bb_19
bb_19:
	%v56 = phi i1[%v55, %bb_18], [true, %bb_16]
	br i1 %v56, label %bb_20, label %bb_21
bb_20:
	%v58 = load i32, ptr %v35
	%v60 = sub i32 %v58, -1
	%v62 = icmp sle i32 3, %v60
	br i1 %v62, label %bb_22, label %bb_23
bb_21:
	%v64 = alloca i1
	br label %bb_17
bb_22:
	br label %bb_13
	br label %bb_11
bb_23:
	%v63 = alloca i1
	br label %bb_21
bb_24:
	%v69 = load i32, ptr %v67
	%v71 = icmp slt i32 %v69, 2
	br i1 %v71, label %bb_25, label %bb_26
bb_25:
	%v72 = load i32, ptr %v67
	%v74 = add i32 %v72, 1
	store i32 %v74, ptr %v67
	br label %bb_24
	br label %bb_26
	%v75 = load i32, ptr %v18
	%v77 = add i32 %v75, 1
	store i32 %v77, ptr %v18
	br label %bb_24
bb_26:
	%v78 = alloca i1
	%v79 = load i32, ptr %v35
	%v81 = add i32 %v79, 1
	store i32 %v81, ptr %v35
	%v82 = load i32, ptr %v18
	%v84 = add i32 %v82, 1
	store i32 %v84, ptr %v18
	br label %bb_11
bb_13:
	%v85 = alloca i1
	br label %bb_27
bb_27:
	br i1 true, label %bb_28, label %bb_29
bb_28:
	br label %bb_30
bb_30:
	br i1 true, label %bb_31, label %bb_32
bb_31:
	br label %bb_32
	br label %bb_30
bb_32:
	%v88 = alloca i1
	br label %bb_29
	br label %bb_27
bb_29:
	%v89 = alloca i1
	%v90 = load i32, ptr %v30
	%v92 = add i32 %v90, 1
	store i32 %v92, ptr %v30
	br label %bb_8
bb_10:
	%v93 = alloca i1
	%v94 = load i32, ptr %v25
	%v96 = add i32 %v94, 1
	store i32 %v96, ptr %v25
	br label %bb_5
	%v97 = load i32, ptr %v25
	%v99 = add i32 %v97, 1
	store i32 %v99, ptr %v25
	br label %bb_5
bb_7:
	%v100 = alloca i1
	%v101 = load i32, ptr %v20
	%v103 = add i32 %v101, 1
	store i32 %v103, ptr %v20
	br label %bb_2
bb_4:
	%v104 = alloca i1
	%v105 = load i32, ptr %v18
	store i32 %v105, ptr %v17
	br label %bb_1
bb_1:
	%v106 = load i32, ptr %v17
	ret i32 %v106
}
