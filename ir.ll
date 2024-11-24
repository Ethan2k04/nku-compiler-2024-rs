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
	%v20 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_x, i32 0, i32 0
	%v24 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_x, i32 0, i32 0
	%v25 = load i32, ptr %v24
	%v27 = add i32 %v25, 2
	store i32 %v27, ptr %v20
	%v31 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_x, i32 0, i32 1
	%v35 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_x, i32 0, i32 1
	%v36 = load i32, ptr %v35
	%v38 = add i32 %v36, 2
	store i32 %v38, ptr %v31
	%v42 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_x, i32 0, i32 2
	%v46 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_x, i32 0, i32 2
	%v47 = load i32, ptr %v46
	%v49 = add i32 %v47, 2
	store i32 %v49, ptr %v42
	br label %bb_1
bb_1:
	ret void
}
define void @mody() {
bb_2:
	%v53 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_y, i32 0, i32 0
	%v57 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_y, i32 0, i32 0
	%v58 = load i32, ptr %v57
	%v60 = add i32 %v58, 2
	store i32 %v60, ptr %v53
	%v64 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_y, i32 0, i32 1
	%v68 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_y, i32 0, i32 1
	%v69 = load i32, ptr %v68
	%v71 = add i32 %v69, 2
	store i32 %v71, ptr %v64
	%v75 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_y, i32 0, i32 2
	%v79 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_y, i32 0, i32 2
	%v80 = load i32, ptr %v79
	%v82 = add i32 %v80, 2
	store i32 %v82, ptr %v75
	br label %bb_3
bb_3:
	ret void
}
define void @refx() {
bb_4:
	%v87 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_x, i32 0, i32 0
	%v88 = load i32, ptr %v87
	%v92 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_x, i32 0, i32 1
	%v93 = load i32, ptr %v92
	%v94 = add i32 %v88, %v93
	%v98 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_x, i32 0, i32 2
	%v99 = load i32, ptr %v98
	%v100 = add i32 %v94, %v99
	store i32 %v100, ptr @__GLOBAL_VAR_d
	br label %bb_5
bb_5:
	ret void
}
define void @refy() {
bb_6:
	%v105 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_y, i32 0, i32 0
	%v106 = load i32, ptr %v105
	%v110 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_y, i32 0, i32 1
	%v111 = load i32, ptr %v110
	%v112 = add i32 %v106, %v111
	%v116 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_y, i32 0, i32 2
	%v117 = load i32, ptr %v116
	%v118 = add i32 %v112, %v117
	store i32 %v118, ptr @__GLOBAL_VAR_d
	br label %bb_7
bb_7:
	ret void
}
define void @modxrefy() {
bb_8:
	%v122 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_x, i32 0, i32 0
	%v126 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_y, i32 0, i32 0
	%v127 = load i32, ptr %v126
	%v129 = add i32 %v127, 3
	store i32 %v129, ptr %v122
	%v133 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_x, i32 0, i32 1
	%v137 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_y, i32 0, i32 1
	%v138 = load i32, ptr %v137
	%v140 = add i32 %v138, 4
	store i32 %v140, ptr %v133
	%v144 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_x, i32 0, i32 2
	%v148 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_y, i32 0, i32 2
	%v149 = load i32, ptr %v148
	%v151 = add i32 %v149, 5
	store i32 %v151, ptr %v144
	br label %bb_9
bb_9:
	ret void
}
define void @modyrefx() {
bb_10:
	%v155 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_y, i32 0, i32 0
	%v159 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_x, i32 0, i32 0
	%v160 = load i32, ptr %v159
	%v162 = add i32 %v160, 5
	store i32 %v162, ptr %v155
	%v166 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_y, i32 0, i32 1
	%v170 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_x, i32 0, i32 1
	%v171 = load i32, ptr %v170
	%v173 = add i32 %v171, 6
	store i32 %v173, ptr %v166
	%v177 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_y, i32 0, i32 2
	%v181 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_x, i32 0, i32 2
	%v182 = load i32, ptr %v181
	%v184 = add i32 %v182, 7
	store i32 %v184, ptr %v177
	br label %bb_11
bb_11:
	ret void
}
define i32 @main() {
bb_12:
	%v186 = alloca i32
	%v185 = alloca i32
	%v190 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_x, i32 0, i32 2
	%v191 = load i32, ptr %v190
	store i32 %v191, ptr %v186
	%v195 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_y, i32 0, i32 2
	store i32 3, ptr %v195
	%v197 = load i32, ptr %v186
	%v201 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_x, i32 0, i32 2
	%v202 = load i32, ptr %v201
	%v203 = add i32 %v197, %v202
	store i32 %v203, ptr %v186
	%v207 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_x, i32 0, i32 2
	store i32 3, ptr %v207
	%v209 = load i32, ptr %v186
	%v213 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_x, i32 0, i32 2
	%v214 = load i32, ptr %v213
	%v215 = add i32 %v209, %v214
	%v217 = load i32, ptr @__GLOBAL_VAR_d
	%v218 = add i32 %v215, %v217
	store i32 %v218, ptr %v186
	store i32 5, ptr @__GLOBAL_VAR_d
	%v221 = load i32, ptr %v186
	%v225 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_x, i32 0, i32 2
	%v226 = load i32, ptr %v225
	%v227 = add i32 %v221, %v226
	%v229 = load i32, ptr @__GLOBAL_VAR_d
	%v230 = add i32 %v227, %v229
	%v232 = load i32, ptr @__GLOBAL_VAR_d
	%v233 = add i32 %v230, %v232
	store i32 %v233, ptr %v186
	call void @refx()
	%v234 = load i32, ptr %v186
	%v238 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_x, i32 0, i32 2
	%v239 = load i32, ptr %v238
	%v240 = add i32 %v234, %v239
	%v242 = load i32, ptr @__GLOBAL_VAR_d
	%v243 = add i32 %v240, %v242
	store i32 %v243, ptr %v186
	call void @modx()
	%v244 = load i32, ptr %v186
	%v248 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_x, i32 0, i32 2
	%v249 = load i32, ptr %v248
	%v250 = add i32 %v244, %v249
	%v252 = load i32, ptr @__GLOBAL_VAR_d
	%v253 = add i32 %v250, %v252
	store i32 %v253, ptr %v186
	call void @mody()
	%v254 = load i32, ptr %v186
	%v258 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_x, i32 0, i32 2
	%v259 = load i32, ptr %v258
	%v260 = add i32 %v254, %v259
	%v262 = load i32, ptr @__GLOBAL_VAR_d
	%v263 = add i32 %v260, %v262
	store i32 %v263, ptr %v186
	call void @modyrefx()
	%v264 = load i32, ptr %v186
	%v268 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_x, i32 0, i32 2
	%v269 = load i32, ptr %v268
	%v270 = add i32 %v264, %v269
	%v274 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_y, i32 0, i32 2
	%v275 = load i32, ptr %v274
	%v276 = add i32 %v270, %v275
	%v278 = load i32, ptr @__GLOBAL_VAR_d
	%v279 = add i32 %v276, %v278
	store i32 %v279, ptr %v186
	call void @modxrefy()
	%v280 = load i32, ptr %v186
	%v284 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_x, i32 0, i32 2
	%v285 = load i32, ptr %v284
	%v286 = add i32 %v280, %v285
	%v288 = load i32, ptr @__GLOBAL_VAR_d
	%v289 = add i32 %v286, %v288
	store i32 %v289, ptr %v186
	%v290 = load i32, ptr %v186
	%v294 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_y, i32 0, i32 1
	%v295 = load i32, ptr %v294
	%v296 = add i32 %v290, %v295
	%v300 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_y, i32 0, i32 2
	%v301 = load i32, ptr %v300
	%v302 = add i32 %v296, %v301
	%v304 = load i32, ptr @__GLOBAL_VAR_d
	%v305 = add i32 %v302, %v304
	store i32 %v305, ptr %v186
	call void @modyrefx()
	%v306 = load i32, ptr %v186
	%v310 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_y, i32 0, i32 1
	%v311 = load i32, ptr %v310
	%v312 = add i32 %v306, %v311
	%v316 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_y, i32 0, i32 2
	%v317 = load i32, ptr %v316
	%v318 = add i32 %v312, %v317
	%v320 = load i32, ptr @__GLOBAL_VAR_d
	%v321 = add i32 %v318, %v320
	store i32 %v321, ptr %v186
	call void @refy()
	%v322 = load i32, ptr %v186
	%v326 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_y, i32 0, i32 1
	%v327 = load i32, ptr %v326
	%v328 = add i32 %v322, %v327
	%v332 = getelementptr [3 x i32], ptr @__GLOBAL_VAR_y, i32 0, i32 2
	%v333 = load i32, ptr %v332
	%v334 = add i32 %v328, %v333
	%v336 = load i32, ptr @__GLOBAL_VAR_d
	%v337 = add i32 %v334, %v336
	store i32 %v337, ptr %v186
	%v338 = load i32, ptr %v186
	call void @putint(i32 %v338)
	call void @putch(i32 10)
	call void @putarray(i32 3, ptr @__GLOBAL_VAR_x)
	call void @putarray(i32 3, ptr @__GLOBAL_VAR_y)
	%v345 = load i32, ptr @__GLOBAL_VAR_d
	call void @putint(i32 %v345)
	call void @putch(i32 10)
	store i32 0, ptr %v185
	br label %bb_13
bb_13:
	%v348 = load i32, ptr %v185
	ret i32 %v348
}
