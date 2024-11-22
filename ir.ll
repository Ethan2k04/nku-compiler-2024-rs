define i32 @main() {
bb_0:
	%v9 = alloca i32
	%v7 = alloca i32
	%v5 = alloca i32
	%v3 = alloca i32
	%v1 = alloca i32
	%v0 = alloca i32
	store i32 undef, ptr %v1
	store i32 undef, ptr %v3
	store i32 undef, ptr %v5
	store i32 undef, ptr %v7
	store i32 undef, ptr %v9
	store i32 5, ptr %v1
	store i32 5, ptr %v3
	store i32 1, ptr %v5
	store i32 -2, ptr %v7
	store i32 2, ptr %v9
	%v16 = load i32, ptr %v7
	%v18 = mul i32 %v16, 1
	%v20 = sdiv i32 %v18, 2
	%v22 = icmp slt i32 %v20, 0
	%v23 = load i32, ptr %v1
	%v24 = load i32, ptr %v3
	%v25 = sub i32 %v23, %v24
	%v27 = icmp ne i32 %v25, 0
	%v28 = load i32, ptr %v5
	%v30 = add i32 %v28, 3
	%v32 = srem i32 %v30, 2
	%v34 = icmp ne i32 %v32, 0
	%v35 = and i1 %v27, %v34
	%v36 = or i1 %v22, %v35
	br i1 %v36, label %bb_2, label %bb_3
bb_2:
	store i32 3, ptr %v9
	br label %bb_4
bb_3:
	br label %bb_4
bb_4:
	%v38 = load i32, ptr %v7
	%v40 = srem i32 %v38, 2
	%v42 = add i32 %v40, 67
	%v44 = icmp slt i32 %v42, 0
	%v45 = load i32, ptr %v1
	%v46 = load i32, ptr %v3
	%v47 = sub i32 %v45, %v46
	%v49 = icmp ne i32 %v47, 0
	%v50 = load i32, ptr %v5
	%v52 = add i32 %v50, 2
	%v54 = srem i32 %v52, 2
	%v56 = icmp ne i32 %v54, 0
	%v57 = and i1 %v49, %v56
	%v58 = or i1 %v44, %v57
	br i1 %v58, label %bb_5, label %bb_6
bb_5:
	store i32 4, ptr %v9
	br label %bb_7
bb_6:
	br label %bb_7
bb_7:
	store i32 0, ptr %v0
	br label %bb_1
bb_1:
	%v61 = load i32, ptr %v0
	ret i32 %v61
}
