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
	%v24 = alloca i32
	%v22 = alloca i32
	%v20 = alloca i32
	%v18 = alloca i32
	%v17 = alloca i32
	store i32 undef, ptr %v18
	store i32 undef, ptr %v20
	store i32 undef, ptr %v22
	store i32 undef, ptr %v24
	store i32 0, ptr %v18
	store i32 0, ptr %v20
	store i32 0, ptr %v22
	br label %bb_2
bb_2:
	%v29 = load i32, ptr %v18
	%v31 = icmp slt i32 %v29, 21
	br i1 %v31, label %bb_3, label %bb_4
bb_3:
	br label %bb_5
bb_5:
	%v32 = load i32, ptr %v20
	%v34 = load i32, ptr %v18
	%v35 = sub i32 101, %v34
	%v36 = icmp slt i32 %v32, %v35
	br i1 %v36, label %bb_6, label %bb_7
bb_6:
	%v38 = load i32, ptr %v18
	%v39 = sub i32 100, %v38
	%v40 = load i32, ptr %v20
	%v41 = sub i32 %v39, %v40
	store i32 %v41, ptr %v22
	%v43 = load i32, ptr %v18
	%v44 = mul i32 5, %v43
	%v46 = load i32, ptr %v20
	%v47 = mul i32 1, %v46
	%v48 = add i32 %v44, %v47
	%v49 = load i32, ptr %v22
	%v51 = sdiv i32 %v49, 2
	%v52 = add i32 %v48, %v51
	%v54 = icmp eq i32 %v52, 100
	br i1 %v54, label %bb_8, label %bb_9
bb_8:
	%v55 = load i32, ptr %v18
	call void @putint(i32 %v55)
	%v56 = load i32, ptr %v20
	call void @putint(i32 %v56)
	%v57 = load i32, ptr %v22
	call void @putint(i32 %v57)
	store i32 10, ptr %v24
	%v59 = load i32, ptr %v24
	call void @putch(i32 %v59)
	br label %bb_9
bb_9:
	%v61 = load i32, ptr %v20
	%v63 = add i32 %v61, 1
	store i32 %v63, ptr %v20
	br label %bb_5
bb_7:
	%v65 = load i32, ptr %v18
	%v67 = add i32 %v65, 1
	store i32 %v67, ptr %v18
	br label %bb_2
bb_4:
	store i32 0, ptr %v17
	br label %bb_1
bb_1:
	%v70 = load i32, ptr %v17
	ret i32 %v70
}
