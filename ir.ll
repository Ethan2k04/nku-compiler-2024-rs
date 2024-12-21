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
	%v18 = alloca i32
	%v17 = alloca i32
	store i32 undef, ptr %v18
	store i32 0, ptr %v17
	br label %bb_1
bb_1:
	%v21 = load i32, ptr %v17
	ret i32 %v21
}
