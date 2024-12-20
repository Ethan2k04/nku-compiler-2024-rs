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
declare void @putfarray(float %v7, ptr %v8)
declare void @starttime(i32 %v9)
declare void @stoptime(i32 %v10)
declare void @memset(ptr %v11, i32 %v12, i32 %v13)
declare void @memcpy(ptr %v14, ptr %v15, i32 %v16)
define float @DFS(i32 %v17, float %v18, float %v19, float %v20, ptr %v21) {
bb_0:
	%v4093 = alloca i32
	%v72 = alloca [1005 x float]
	%v26 = alloca float
	%v25 = alloca float
	%v24 = alloca float
	%v23 = alloca float
	%v22 = alloca i32
	store i32 %v17, ptr %v22
	store float %v18, ptr %v23
	store float %v19, ptr %v24
	store float %v20, ptr %v25
	%v29 = load i32, ptr %v22
	%v30 = getelementptr [1005 x float], ptr @__GLOBAL_VAR_ff, i32 0, i32 %v29
	%v31 = load float, ptr %v25
	%v34 = load i32, ptr %v22
	%v35 = getelementptr [1005 x float], ptr @__GLOBAL_VAR_a, i32 0, i32 %v34
	%v36 = load float, ptr %v35
	%v38 = sitofp i32 3 to float
	%v39 = load float, ptr %v23
	%v40 = fmul float %v38, %v39
	%v42 = sitofp i32 3 to float
	%v43 = load float, ptr %v24
	%v44 = fmul float %v42, %v43
	%v45 = fadd float %v40, %v44
	%v47 = sitofp i32 1 to float
	%v48 = fadd float %v45, %v47
	%v49 = fmul float %v36, %v48
	%v50 = fadd float %v31, %v49
	store float %v50, ptr %v30
	%v52 = load i32, ptr %v22
	%v53 = getelementptr float, float* %v21, i32 %v52
	%v56 = load i32, ptr %v22
	%v57 = getelementptr [1005 x float], ptr @__GLOBAL_VAR_a, i32 0, i32 %v56
	%v58 = load float, ptr %v57
	%v59 = load float, ptr %v23
	%v61 = sitofp i32 1 to float
	%v62 = fadd float %v59, %v61
	%v63 = fmul float %v58, %v62
	store float %v63, ptr %v53
	%v64 = load i32, ptr %v22
	%v66 = load i32, ptr @__GLOBAL_VAR_n
	%v67 = icmp eq i32 %v64, %v66
	br i1 %v67, label %bb_2, label %bb_3
bb_2:
	%v68 = load i32, ptr %v22
	%v69 = sitofp i32 %v68 to float
	call void @putfarray(float %v69, ptr %v21)
	%v70 = load float, ptr %v24
	store float %v70, ptr %v26
	br label %bb_1
bb_3:
	%v71 = alloca i1
	%v75 = getelementptr [1005 x float], ptr %v72, i32 0, i32 0
	store float 0.0, ptr %v75
	%v79 = getelementptr [1005 x float], ptr %v72, i32 0, i32 1
	store float 0.0, ptr %v79
	%v83 = getelementptr [1005 x float], ptr %v72, i32 0, i32 2
	store float 0.0, ptr %v83
	%v87 = getelementptr [1005 x float], ptr %v72, i32 0, i32 3
	store float 0.0, ptr %v87
	%v91 = getelementptr [1005 x float], ptr %v72, i32 0, i32 4
	store float 0.0, ptr %v91
	%v95 = getelementptr [1005 x float], ptr %v72, i32 0, i32 5
	store float 0.0, ptr %v95
	%v99 = getelementptr [1005 x float], ptr %v72, i32 0, i32 6
	store float 0.0, ptr %v99
	%v103 = getelementptr [1005 x float], ptr %v72, i32 0, i32 7
	store float 0.0, ptr %v103
	%v107 = getelementptr [1005 x float], ptr %v72, i32 0, i32 8
	store float 0.0, ptr %v107
	%v111 = getelementptr [1005 x float], ptr %v72, i32 0, i32 9
	store float 0.0, ptr %v111
	%v115 = getelementptr [1005 x float], ptr %v72, i32 0, i32 10
	store float 0.0, ptr %v115
	%v119 = getelementptr [1005 x float], ptr %v72, i32 0, i32 11
	store float 0.0, ptr %v119
	%v123 = getelementptr [1005 x float], ptr %v72, i32 0, i32 12
	store float 0.0, ptr %v123
	%v127 = getelementptr [1005 x float], ptr %v72, i32 0, i32 13
	store float 0.0, ptr %v127
	%v131 = getelementptr [1005 x float], ptr %v72, i32 0, i32 14
	store float 0.0, ptr %v131
	%v135 = getelementptr [1005 x float], ptr %v72, i32 0, i32 15
	store float 0.0, ptr %v135
	%v139 = getelementptr [1005 x float], ptr %v72, i32 0, i32 16
	store float 0.0, ptr %v139
	%v143 = getelementptr [1005 x float], ptr %v72, i32 0, i32 17
	store float 0.0, ptr %v143
	%v147 = getelementptr [1005 x float], ptr %v72, i32 0, i32 18
	store float 0.0, ptr %v147
	%v151 = getelementptr [1005 x float], ptr %v72, i32 0, i32 19
	store float 0.0, ptr %v151
	%v155 = getelementptr [1005 x float], ptr %v72, i32 0, i32 20
	store float 0.0, ptr %v155
	%v159 = getelementptr [1005 x float], ptr %v72, i32 0, i32 21
	store float 0.0, ptr %v159
	%v163 = getelementptr [1005 x float], ptr %v72, i32 0, i32 22
	store float 0.0, ptr %v163
	%v167 = getelementptr [1005 x float], ptr %v72, i32 0, i32 23
	store float 0.0, ptr %v167
	%v171 = getelementptr [1005 x float], ptr %v72, i32 0, i32 24
	store float 0.0, ptr %v171
	%v175 = getelementptr [1005 x float], ptr %v72, i32 0, i32 25
	store float 0.0, ptr %v175
	%v179 = getelementptr [1005 x float], ptr %v72, i32 0, i32 26
	store float 0.0, ptr %v179
	%v183 = getelementptr [1005 x float], ptr %v72, i32 0, i32 27
	store float 0.0, ptr %v183
	%v187 = getelementptr [1005 x float], ptr %v72, i32 0, i32 28
	store float 0.0, ptr %v187
	%v191 = getelementptr [1005 x float], ptr %v72, i32 0, i32 29
	store float 0.0, ptr %v191
	%v195 = getelementptr [1005 x float], ptr %v72, i32 0, i32 30
	store float 0.0, ptr %v195
	%v199 = getelementptr [1005 x float], ptr %v72, i32 0, i32 31
	store float 0.0, ptr %v199
	%v203 = getelementptr [1005 x float], ptr %v72, i32 0, i32 32
	store float 0.0, ptr %v203
	%v207 = getelementptr [1005 x float], ptr %v72, i32 0, i32 33
	store float 0.0, ptr %v207
	%v211 = getelementptr [1005 x float], ptr %v72, i32 0, i32 34
	store float 0.0, ptr %v211
	%v215 = getelementptr [1005 x float], ptr %v72, i32 0, i32 35
	store float 0.0, ptr %v215
	%v219 = getelementptr [1005 x float], ptr %v72, i32 0, i32 36
	store float 0.0, ptr %v219
	%v223 = getelementptr [1005 x float], ptr %v72, i32 0, i32 37
	store float 0.0, ptr %v223
	%v227 = getelementptr [1005 x float], ptr %v72, i32 0, i32 38
	store float 0.0, ptr %v227
	%v231 = getelementptr [1005 x float], ptr %v72, i32 0, i32 39
	store float 0.0, ptr %v231
	%v235 = getelementptr [1005 x float], ptr %v72, i32 0, i32 40
	store float 0.0, ptr %v235
	%v239 = getelementptr [1005 x float], ptr %v72, i32 0, i32 41
	store float 0.0, ptr %v239
	%v243 = getelementptr [1005 x float], ptr %v72, i32 0, i32 42
	store float 0.0, ptr %v243
	%v247 = getelementptr [1005 x float], ptr %v72, i32 0, i32 43
	store float 0.0, ptr %v247
	%v251 = getelementptr [1005 x float], ptr %v72, i32 0, i32 44
	store float 0.0, ptr %v251
	%v255 = getelementptr [1005 x float], ptr %v72, i32 0, i32 45
	store float 0.0, ptr %v255
	%v259 = getelementptr [1005 x float], ptr %v72, i32 0, i32 46
	store float 0.0, ptr %v259
	%v263 = getelementptr [1005 x float], ptr %v72, i32 0, i32 47
	store float 0.0, ptr %v263
	%v267 = getelementptr [1005 x float], ptr %v72, i32 0, i32 48
	store float 0.0, ptr %v267
	%v271 = getelementptr [1005 x float], ptr %v72, i32 0, i32 49
	store float 0.0, ptr %v271
	%v275 = getelementptr [1005 x float], ptr %v72, i32 0, i32 50
	store float 0.0, ptr %v275
	%v279 = getelementptr [1005 x float], ptr %v72, i32 0, i32 51
	store float 0.0, ptr %v279
	%v283 = getelementptr [1005 x float], ptr %v72, i32 0, i32 52
	store float 0.0, ptr %v283
	%v287 = getelementptr [1005 x float], ptr %v72, i32 0, i32 53
	store float 0.0, ptr %v287
	%v291 = getelementptr [1005 x float], ptr %v72, i32 0, i32 54
	store float 0.0, ptr %v291
	%v295 = getelementptr [1005 x float], ptr %v72, i32 0, i32 55
	store float 0.0, ptr %v295
	%v299 = getelementptr [1005 x float], ptr %v72, i32 0, i32 56
	store float 0.0, ptr %v299
	%v303 = getelementptr [1005 x float], ptr %v72, i32 0, i32 57
	store float 0.0, ptr %v303
	%v307 = getelementptr [1005 x float], ptr %v72, i32 0, i32 58
	store float 0.0, ptr %v307
	%v311 = getelementptr [1005 x float], ptr %v72, i32 0, i32 59
	store float 0.0, ptr %v311
	%v315 = getelementptr [1005 x float], ptr %v72, i32 0, i32 60
	store float 0.0, ptr %v315
	%v319 = getelementptr [1005 x float], ptr %v72, i32 0, i32 61
	store float 0.0, ptr %v319
	%v323 = getelementptr [1005 x float], ptr %v72, i32 0, i32 62
	store float 0.0, ptr %v323
	%v327 = getelementptr [1005 x float], ptr %v72, i32 0, i32 63
	store float 0.0, ptr %v327
	%v331 = getelementptr [1005 x float], ptr %v72, i32 0, i32 64
	store float 0.0, ptr %v331
	%v335 = getelementptr [1005 x float], ptr %v72, i32 0, i32 65
	store float 0.0, ptr %v335
	%v339 = getelementptr [1005 x float], ptr %v72, i32 0, i32 66
	store float 0.0, ptr %v339
	%v343 = getelementptr [1005 x float], ptr %v72, i32 0, i32 67
	store float 0.0, ptr %v343
	%v347 = getelementptr [1005 x float], ptr %v72, i32 0, i32 68
	store float 0.0, ptr %v347
	%v351 = getelementptr [1005 x float], ptr %v72, i32 0, i32 69
	store float 0.0, ptr %v351
	%v355 = getelementptr [1005 x float], ptr %v72, i32 0, i32 70
	store float 0.0, ptr %v355
	%v359 = getelementptr [1005 x float], ptr %v72, i32 0, i32 71
	store float 0.0, ptr %v359
	%v363 = getelementptr [1005 x float], ptr %v72, i32 0, i32 72
	store float 0.0, ptr %v363
	%v367 = getelementptr [1005 x float], ptr %v72, i32 0, i32 73
	store float 0.0, ptr %v367
	%v371 = getelementptr [1005 x float], ptr %v72, i32 0, i32 74
	store float 0.0, ptr %v371
	%v375 = getelementptr [1005 x float], ptr %v72, i32 0, i32 75
	store float 0.0, ptr %v375
	%v379 = getelementptr [1005 x float], ptr %v72, i32 0, i32 76
	store float 0.0, ptr %v379
	%v383 = getelementptr [1005 x float], ptr %v72, i32 0, i32 77
	store float 0.0, ptr %v383
	%v387 = getelementptr [1005 x float], ptr %v72, i32 0, i32 78
	store float 0.0, ptr %v387
	%v391 = getelementptr [1005 x float], ptr %v72, i32 0, i32 79
	store float 0.0, ptr %v391
	%v395 = getelementptr [1005 x float], ptr %v72, i32 0, i32 80
	store float 0.0, ptr %v395
	%v399 = getelementptr [1005 x float], ptr %v72, i32 0, i32 81
	store float 0.0, ptr %v399
	%v403 = getelementptr [1005 x float], ptr %v72, i32 0, i32 82
	store float 0.0, ptr %v403
	%v407 = getelementptr [1005 x float], ptr %v72, i32 0, i32 83
	store float 0.0, ptr %v407
	%v411 = getelementptr [1005 x float], ptr %v72, i32 0, i32 84
	store float 0.0, ptr %v411
	%v415 = getelementptr [1005 x float], ptr %v72, i32 0, i32 85
	store float 0.0, ptr %v415
	%v419 = getelementptr [1005 x float], ptr %v72, i32 0, i32 86
	store float 0.0, ptr %v419
	%v423 = getelementptr [1005 x float], ptr %v72, i32 0, i32 87
	store float 0.0, ptr %v423
	%v427 = getelementptr [1005 x float], ptr %v72, i32 0, i32 88
	store float 0.0, ptr %v427
	%v431 = getelementptr [1005 x float], ptr %v72, i32 0, i32 89
	store float 0.0, ptr %v431
	%v435 = getelementptr [1005 x float], ptr %v72, i32 0, i32 90
	store float 0.0, ptr %v435
	%v439 = getelementptr [1005 x float], ptr %v72, i32 0, i32 91
	store float 0.0, ptr %v439
	%v443 = getelementptr [1005 x float], ptr %v72, i32 0, i32 92
	store float 0.0, ptr %v443
	%v447 = getelementptr [1005 x float], ptr %v72, i32 0, i32 93
	store float 0.0, ptr %v447
	%v451 = getelementptr [1005 x float], ptr %v72, i32 0, i32 94
	store float 0.0, ptr %v451
	%v455 = getelementptr [1005 x float], ptr %v72, i32 0, i32 95
	store float 0.0, ptr %v455
	%v459 = getelementptr [1005 x float], ptr %v72, i32 0, i32 96
	store float 0.0, ptr %v459
	%v463 = getelementptr [1005 x float], ptr %v72, i32 0, i32 97
	store float 0.0, ptr %v463
	%v467 = getelementptr [1005 x float], ptr %v72, i32 0, i32 98
	store float 0.0, ptr %v467
	%v471 = getelementptr [1005 x float], ptr %v72, i32 0, i32 99
	store float 0.0, ptr %v471
	%v475 = getelementptr [1005 x float], ptr %v72, i32 0, i32 100
	store float 0.0, ptr %v475
	%v479 = getelementptr [1005 x float], ptr %v72, i32 0, i32 101
	store float 0.0, ptr %v479
	%v483 = getelementptr [1005 x float], ptr %v72, i32 0, i32 102
	store float 0.0, ptr %v483
	%v487 = getelementptr [1005 x float], ptr %v72, i32 0, i32 103
	store float 0.0, ptr %v487
	%v491 = getelementptr [1005 x float], ptr %v72, i32 0, i32 104
	store float 0.0, ptr %v491
	%v495 = getelementptr [1005 x float], ptr %v72, i32 0, i32 105
	store float 0.0, ptr %v495
	%v499 = getelementptr [1005 x float], ptr %v72, i32 0, i32 106
	store float 0.0, ptr %v499
	%v503 = getelementptr [1005 x float], ptr %v72, i32 0, i32 107
	store float 0.0, ptr %v503
	%v507 = getelementptr [1005 x float], ptr %v72, i32 0, i32 108
	store float 0.0, ptr %v507
	%v511 = getelementptr [1005 x float], ptr %v72, i32 0, i32 109
	store float 0.0, ptr %v511
	%v515 = getelementptr [1005 x float], ptr %v72, i32 0, i32 110
	store float 0.0, ptr %v515
	%v519 = getelementptr [1005 x float], ptr %v72, i32 0, i32 111
	store float 0.0, ptr %v519
	%v523 = getelementptr [1005 x float], ptr %v72, i32 0, i32 112
	store float 0.0, ptr %v523
	%v527 = getelementptr [1005 x float], ptr %v72, i32 0, i32 113
	store float 0.0, ptr %v527
	%v531 = getelementptr [1005 x float], ptr %v72, i32 0, i32 114
	store float 0.0, ptr %v531
	%v535 = getelementptr [1005 x float], ptr %v72, i32 0, i32 115
	store float 0.0, ptr %v535
	%v539 = getelementptr [1005 x float], ptr %v72, i32 0, i32 116
	store float 0.0, ptr %v539
	%v543 = getelementptr [1005 x float], ptr %v72, i32 0, i32 117
	store float 0.0, ptr %v543
	%v547 = getelementptr [1005 x float], ptr %v72, i32 0, i32 118
	store float 0.0, ptr %v547
	%v551 = getelementptr [1005 x float], ptr %v72, i32 0, i32 119
	store float 0.0, ptr %v551
	%v555 = getelementptr [1005 x float], ptr %v72, i32 0, i32 120
	store float 0.0, ptr %v555
	%v559 = getelementptr [1005 x float], ptr %v72, i32 0, i32 121
	store float 0.0, ptr %v559
	%v563 = getelementptr [1005 x float], ptr %v72, i32 0, i32 122
	store float 0.0, ptr %v563
	%v567 = getelementptr [1005 x float], ptr %v72, i32 0, i32 123
	store float 0.0, ptr %v567
	%v571 = getelementptr [1005 x float], ptr %v72, i32 0, i32 124
	store float 0.0, ptr %v571
	%v575 = getelementptr [1005 x float], ptr %v72, i32 0, i32 125
	store float 0.0, ptr %v575
	%v579 = getelementptr [1005 x float], ptr %v72, i32 0, i32 126
	store float 0.0, ptr %v579
	%v583 = getelementptr [1005 x float], ptr %v72, i32 0, i32 127
	store float 0.0, ptr %v583
	%v587 = getelementptr [1005 x float], ptr %v72, i32 0, i32 128
	store float 0.0, ptr %v587
	%v591 = getelementptr [1005 x float], ptr %v72, i32 0, i32 129
	store float 0.0, ptr %v591
	%v595 = getelementptr [1005 x float], ptr %v72, i32 0, i32 130
	store float 0.0, ptr %v595
	%v599 = getelementptr [1005 x float], ptr %v72, i32 0, i32 131
	store float 0.0, ptr %v599
	%v603 = getelementptr [1005 x float], ptr %v72, i32 0, i32 132
	store float 0.0, ptr %v603
	%v607 = getelementptr [1005 x float], ptr %v72, i32 0, i32 133
	store float 0.0, ptr %v607
	%v611 = getelementptr [1005 x float], ptr %v72, i32 0, i32 134
	store float 0.0, ptr %v611
	%v615 = getelementptr [1005 x float], ptr %v72, i32 0, i32 135
	store float 0.0, ptr %v615
	%v619 = getelementptr [1005 x float], ptr %v72, i32 0, i32 136
	store float 0.0, ptr %v619
	%v623 = getelementptr [1005 x float], ptr %v72, i32 0, i32 137
	store float 0.0, ptr %v623
	%v627 = getelementptr [1005 x float], ptr %v72, i32 0, i32 138
	store float 0.0, ptr %v627
	%v631 = getelementptr [1005 x float], ptr %v72, i32 0, i32 139
	store float 0.0, ptr %v631
	%v635 = getelementptr [1005 x float], ptr %v72, i32 0, i32 140
	store float 0.0, ptr %v635
	%v639 = getelementptr [1005 x float], ptr %v72, i32 0, i32 141
	store float 0.0, ptr %v639
	%v643 = getelementptr [1005 x float], ptr %v72, i32 0, i32 142
	store float 0.0, ptr %v643
	%v647 = getelementptr [1005 x float], ptr %v72, i32 0, i32 143
	store float 0.0, ptr %v647
	%v651 = getelementptr [1005 x float], ptr %v72, i32 0, i32 144
	store float 0.0, ptr %v651
	%v655 = getelementptr [1005 x float], ptr %v72, i32 0, i32 145
	store float 0.0, ptr %v655
	%v659 = getelementptr [1005 x float], ptr %v72, i32 0, i32 146
	store float 0.0, ptr %v659
	%v663 = getelementptr [1005 x float], ptr %v72, i32 0, i32 147
	store float 0.0, ptr %v663
	%v667 = getelementptr [1005 x float], ptr %v72, i32 0, i32 148
	store float 0.0, ptr %v667
	%v671 = getelementptr [1005 x float], ptr %v72, i32 0, i32 149
	store float 0.0, ptr %v671
	%v675 = getelementptr [1005 x float], ptr %v72, i32 0, i32 150
	store float 0.0, ptr %v675
	%v679 = getelementptr [1005 x float], ptr %v72, i32 0, i32 151
	store float 0.0, ptr %v679
	%v683 = getelementptr [1005 x float], ptr %v72, i32 0, i32 152
	store float 0.0, ptr %v683
	%v687 = getelementptr [1005 x float], ptr %v72, i32 0, i32 153
	store float 0.0, ptr %v687
	%v691 = getelementptr [1005 x float], ptr %v72, i32 0, i32 154
	store float 0.0, ptr %v691
	%v695 = getelementptr [1005 x float], ptr %v72, i32 0, i32 155
	store float 0.0, ptr %v695
	%v699 = getelementptr [1005 x float], ptr %v72, i32 0, i32 156
	store float 0.0, ptr %v699
	%v703 = getelementptr [1005 x float], ptr %v72, i32 0, i32 157
	store float 0.0, ptr %v703
	%v707 = getelementptr [1005 x float], ptr %v72, i32 0, i32 158
	store float 0.0, ptr %v707
	%v711 = getelementptr [1005 x float], ptr %v72, i32 0, i32 159
	store float 0.0, ptr %v711
	%v715 = getelementptr [1005 x float], ptr %v72, i32 0, i32 160
	store float 0.0, ptr %v715
	%v719 = getelementptr [1005 x float], ptr %v72, i32 0, i32 161
	store float 0.0, ptr %v719
	%v723 = getelementptr [1005 x float], ptr %v72, i32 0, i32 162
	store float 0.0, ptr %v723
	%v727 = getelementptr [1005 x float], ptr %v72, i32 0, i32 163
	store float 0.0, ptr %v727
	%v731 = getelementptr [1005 x float], ptr %v72, i32 0, i32 164
	store float 0.0, ptr %v731
	%v735 = getelementptr [1005 x float], ptr %v72, i32 0, i32 165
	store float 0.0, ptr %v735
	%v739 = getelementptr [1005 x float], ptr %v72, i32 0, i32 166
	store float 0.0, ptr %v739
	%v743 = getelementptr [1005 x float], ptr %v72, i32 0, i32 167
	store float 0.0, ptr %v743
	%v747 = getelementptr [1005 x float], ptr %v72, i32 0, i32 168
	store float 0.0, ptr %v747
	%v751 = getelementptr [1005 x float], ptr %v72, i32 0, i32 169
	store float 0.0, ptr %v751
	%v755 = getelementptr [1005 x float], ptr %v72, i32 0, i32 170
	store float 0.0, ptr %v755
	%v759 = getelementptr [1005 x float], ptr %v72, i32 0, i32 171
	store float 0.0, ptr %v759
	%v763 = getelementptr [1005 x float], ptr %v72, i32 0, i32 172
	store float 0.0, ptr %v763
	%v767 = getelementptr [1005 x float], ptr %v72, i32 0, i32 173
	store float 0.0, ptr %v767
	%v771 = getelementptr [1005 x float], ptr %v72, i32 0, i32 174
	store float 0.0, ptr %v771
	%v775 = getelementptr [1005 x float], ptr %v72, i32 0, i32 175
	store float 0.0, ptr %v775
	%v779 = getelementptr [1005 x float], ptr %v72, i32 0, i32 176
	store float 0.0, ptr %v779
	%v783 = getelementptr [1005 x float], ptr %v72, i32 0, i32 177
	store float 0.0, ptr %v783
	%v787 = getelementptr [1005 x float], ptr %v72, i32 0, i32 178
	store float 0.0, ptr %v787
	%v791 = getelementptr [1005 x float], ptr %v72, i32 0, i32 179
	store float 0.0, ptr %v791
	%v795 = getelementptr [1005 x float], ptr %v72, i32 0, i32 180
	store float 0.0, ptr %v795
	%v799 = getelementptr [1005 x float], ptr %v72, i32 0, i32 181
	store float 0.0, ptr %v799
	%v803 = getelementptr [1005 x float], ptr %v72, i32 0, i32 182
	store float 0.0, ptr %v803
	%v807 = getelementptr [1005 x float], ptr %v72, i32 0, i32 183
	store float 0.0, ptr %v807
	%v811 = getelementptr [1005 x float], ptr %v72, i32 0, i32 184
	store float 0.0, ptr %v811
	%v815 = getelementptr [1005 x float], ptr %v72, i32 0, i32 185
	store float 0.0, ptr %v815
	%v819 = getelementptr [1005 x float], ptr %v72, i32 0, i32 186
	store float 0.0, ptr %v819
	%v823 = getelementptr [1005 x float], ptr %v72, i32 0, i32 187
	store float 0.0, ptr %v823
	%v827 = getelementptr [1005 x float], ptr %v72, i32 0, i32 188
	store float 0.0, ptr %v827
	%v831 = getelementptr [1005 x float], ptr %v72, i32 0, i32 189
	store float 0.0, ptr %v831
	%v835 = getelementptr [1005 x float], ptr %v72, i32 0, i32 190
	store float 0.0, ptr %v835
	%v839 = getelementptr [1005 x float], ptr %v72, i32 0, i32 191
	store float 0.0, ptr %v839
	%v843 = getelementptr [1005 x float], ptr %v72, i32 0, i32 192
	store float 0.0, ptr %v843
	%v847 = getelementptr [1005 x float], ptr %v72, i32 0, i32 193
	store float 0.0, ptr %v847
	%v851 = getelementptr [1005 x float], ptr %v72, i32 0, i32 194
	store float 0.0, ptr %v851
	%v855 = getelementptr [1005 x float], ptr %v72, i32 0, i32 195
	store float 0.0, ptr %v855
	%v859 = getelementptr [1005 x float], ptr %v72, i32 0, i32 196
	store float 0.0, ptr %v859
	%v863 = getelementptr [1005 x float], ptr %v72, i32 0, i32 197
	store float 0.0, ptr %v863
	%v867 = getelementptr [1005 x float], ptr %v72, i32 0, i32 198
	store float 0.0, ptr %v867
	%v871 = getelementptr [1005 x float], ptr %v72, i32 0, i32 199
	store float 0.0, ptr %v871
	%v875 = getelementptr [1005 x float], ptr %v72, i32 0, i32 200
	store float 0.0, ptr %v875
	%v879 = getelementptr [1005 x float], ptr %v72, i32 0, i32 201
	store float 0.0, ptr %v879
	%v883 = getelementptr [1005 x float], ptr %v72, i32 0, i32 202
	store float 0.0, ptr %v883
	%v887 = getelementptr [1005 x float], ptr %v72, i32 0, i32 203
	store float 0.0, ptr %v887
	%v891 = getelementptr [1005 x float], ptr %v72, i32 0, i32 204
	store float 0.0, ptr %v891
	%v895 = getelementptr [1005 x float], ptr %v72, i32 0, i32 205
	store float 0.0, ptr %v895
	%v899 = getelementptr [1005 x float], ptr %v72, i32 0, i32 206
	store float 0.0, ptr %v899
	%v903 = getelementptr [1005 x float], ptr %v72, i32 0, i32 207
	store float 0.0, ptr %v903
	%v907 = getelementptr [1005 x float], ptr %v72, i32 0, i32 208
	store float 0.0, ptr %v907
	%v911 = getelementptr [1005 x float], ptr %v72, i32 0, i32 209
	store float 0.0, ptr %v911
	%v915 = getelementptr [1005 x float], ptr %v72, i32 0, i32 210
	store float 0.0, ptr %v915
	%v919 = getelementptr [1005 x float], ptr %v72, i32 0, i32 211
	store float 0.0, ptr %v919
	%v923 = getelementptr [1005 x float], ptr %v72, i32 0, i32 212
	store float 0.0, ptr %v923
	%v927 = getelementptr [1005 x float], ptr %v72, i32 0, i32 213
	store float 0.0, ptr %v927
	%v931 = getelementptr [1005 x float], ptr %v72, i32 0, i32 214
	store float 0.0, ptr %v931
	%v935 = getelementptr [1005 x float], ptr %v72, i32 0, i32 215
	store float 0.0, ptr %v935
	%v939 = getelementptr [1005 x float], ptr %v72, i32 0, i32 216
	store float 0.0, ptr %v939
	%v943 = getelementptr [1005 x float], ptr %v72, i32 0, i32 217
	store float 0.0, ptr %v943
	%v947 = getelementptr [1005 x float], ptr %v72, i32 0, i32 218
	store float 0.0, ptr %v947
	%v951 = getelementptr [1005 x float], ptr %v72, i32 0, i32 219
	store float 0.0, ptr %v951
	%v955 = getelementptr [1005 x float], ptr %v72, i32 0, i32 220
	store float 0.0, ptr %v955
	%v959 = getelementptr [1005 x float], ptr %v72, i32 0, i32 221
	store float 0.0, ptr %v959
	%v963 = getelementptr [1005 x float], ptr %v72, i32 0, i32 222
	store float 0.0, ptr %v963
	%v967 = getelementptr [1005 x float], ptr %v72, i32 0, i32 223
	store float 0.0, ptr %v967
	%v971 = getelementptr [1005 x float], ptr %v72, i32 0, i32 224
	store float 0.0, ptr %v971
	%v975 = getelementptr [1005 x float], ptr %v72, i32 0, i32 225
	store float 0.0, ptr %v975
	%v979 = getelementptr [1005 x float], ptr %v72, i32 0, i32 226
	store float 0.0, ptr %v979
	%v983 = getelementptr [1005 x float], ptr %v72, i32 0, i32 227
	store float 0.0, ptr %v983
	%v987 = getelementptr [1005 x float], ptr %v72, i32 0, i32 228
	store float 0.0, ptr %v987
	%v991 = getelementptr [1005 x float], ptr %v72, i32 0, i32 229
	store float 0.0, ptr %v991
	%v995 = getelementptr [1005 x float], ptr %v72, i32 0, i32 230
	store float 0.0, ptr %v995
	%v999 = getelementptr [1005 x float], ptr %v72, i32 0, i32 231
	store float 0.0, ptr %v999
	%v1003 = getelementptr [1005 x float], ptr %v72, i32 0, i32 232
	store float 0.0, ptr %v1003
	%v1007 = getelementptr [1005 x float], ptr %v72, i32 0, i32 233
	store float 0.0, ptr %v1007
	%v1011 = getelementptr [1005 x float], ptr %v72, i32 0, i32 234
	store float 0.0, ptr %v1011
	%v1015 = getelementptr [1005 x float], ptr %v72, i32 0, i32 235
	store float 0.0, ptr %v1015
	%v1019 = getelementptr [1005 x float], ptr %v72, i32 0, i32 236
	store float 0.0, ptr %v1019
	%v1023 = getelementptr [1005 x float], ptr %v72, i32 0, i32 237
	store float 0.0, ptr %v1023
	%v1027 = getelementptr [1005 x float], ptr %v72, i32 0, i32 238
	store float 0.0, ptr %v1027
	%v1031 = getelementptr [1005 x float], ptr %v72, i32 0, i32 239
	store float 0.0, ptr %v1031
	%v1035 = getelementptr [1005 x float], ptr %v72, i32 0, i32 240
	store float 0.0, ptr %v1035
	%v1039 = getelementptr [1005 x float], ptr %v72, i32 0, i32 241
	store float 0.0, ptr %v1039
	%v1043 = getelementptr [1005 x float], ptr %v72, i32 0, i32 242
	store float 0.0, ptr %v1043
	%v1047 = getelementptr [1005 x float], ptr %v72, i32 0, i32 243
	store float 0.0, ptr %v1047
	%v1051 = getelementptr [1005 x float], ptr %v72, i32 0, i32 244
	store float 0.0, ptr %v1051
	%v1055 = getelementptr [1005 x float], ptr %v72, i32 0, i32 245
	store float 0.0, ptr %v1055
	%v1059 = getelementptr [1005 x float], ptr %v72, i32 0, i32 246
	store float 0.0, ptr %v1059
	%v1063 = getelementptr [1005 x float], ptr %v72, i32 0, i32 247
	store float 0.0, ptr %v1063
	%v1067 = getelementptr [1005 x float], ptr %v72, i32 0, i32 248
	store float 0.0, ptr %v1067
	%v1071 = getelementptr [1005 x float], ptr %v72, i32 0, i32 249
	store float 0.0, ptr %v1071
	%v1075 = getelementptr [1005 x float], ptr %v72, i32 0, i32 250
	store float 0.0, ptr %v1075
	%v1079 = getelementptr [1005 x float], ptr %v72, i32 0, i32 251
	store float 0.0, ptr %v1079
	%v1083 = getelementptr [1005 x float], ptr %v72, i32 0, i32 252
	store float 0.0, ptr %v1083
	%v1087 = getelementptr [1005 x float], ptr %v72, i32 0, i32 253
	store float 0.0, ptr %v1087
	%v1091 = getelementptr [1005 x float], ptr %v72, i32 0, i32 254
	store float 0.0, ptr %v1091
	%v1095 = getelementptr [1005 x float], ptr %v72, i32 0, i32 255
	store float 0.0, ptr %v1095
	%v1099 = getelementptr [1005 x float], ptr %v72, i32 0, i32 256
	store float 0.0, ptr %v1099
	%v1103 = getelementptr [1005 x float], ptr %v72, i32 0, i32 257
	store float 0.0, ptr %v1103
	%v1107 = getelementptr [1005 x float], ptr %v72, i32 0, i32 258
	store float 0.0, ptr %v1107
	%v1111 = getelementptr [1005 x float], ptr %v72, i32 0, i32 259
	store float 0.0, ptr %v1111
	%v1115 = getelementptr [1005 x float], ptr %v72, i32 0, i32 260
	store float 0.0, ptr %v1115
	%v1119 = getelementptr [1005 x float], ptr %v72, i32 0, i32 261
	store float 0.0, ptr %v1119
	%v1123 = getelementptr [1005 x float], ptr %v72, i32 0, i32 262
	store float 0.0, ptr %v1123
	%v1127 = getelementptr [1005 x float], ptr %v72, i32 0, i32 263
	store float 0.0, ptr %v1127
	%v1131 = getelementptr [1005 x float], ptr %v72, i32 0, i32 264
	store float 0.0, ptr %v1131
	%v1135 = getelementptr [1005 x float], ptr %v72, i32 0, i32 265
	store float 0.0, ptr %v1135
	%v1139 = getelementptr [1005 x float], ptr %v72, i32 0, i32 266
	store float 0.0, ptr %v1139
	%v1143 = getelementptr [1005 x float], ptr %v72, i32 0, i32 267
	store float 0.0, ptr %v1143
	%v1147 = getelementptr [1005 x float], ptr %v72, i32 0, i32 268
	store float 0.0, ptr %v1147
	%v1151 = getelementptr [1005 x float], ptr %v72, i32 0, i32 269
	store float 0.0, ptr %v1151
	%v1155 = getelementptr [1005 x float], ptr %v72, i32 0, i32 270
	store float 0.0, ptr %v1155
	%v1159 = getelementptr [1005 x float], ptr %v72, i32 0, i32 271
	store float 0.0, ptr %v1159
	%v1163 = getelementptr [1005 x float], ptr %v72, i32 0, i32 272
	store float 0.0, ptr %v1163
	%v1167 = getelementptr [1005 x float], ptr %v72, i32 0, i32 273
	store float 0.0, ptr %v1167
	%v1171 = getelementptr [1005 x float], ptr %v72, i32 0, i32 274
	store float 0.0, ptr %v1171
	%v1175 = getelementptr [1005 x float], ptr %v72, i32 0, i32 275
	store float 0.0, ptr %v1175
	%v1179 = getelementptr [1005 x float], ptr %v72, i32 0, i32 276
	store float 0.0, ptr %v1179
	%v1183 = getelementptr [1005 x float], ptr %v72, i32 0, i32 277
	store float 0.0, ptr %v1183
	%v1187 = getelementptr [1005 x float], ptr %v72, i32 0, i32 278
	store float 0.0, ptr %v1187
	%v1191 = getelementptr [1005 x float], ptr %v72, i32 0, i32 279
	store float 0.0, ptr %v1191
	%v1195 = getelementptr [1005 x float], ptr %v72, i32 0, i32 280
	store float 0.0, ptr %v1195
	%v1199 = getelementptr [1005 x float], ptr %v72, i32 0, i32 281
	store float 0.0, ptr %v1199
	%v1203 = getelementptr [1005 x float], ptr %v72, i32 0, i32 282
	store float 0.0, ptr %v1203
	%v1207 = getelementptr [1005 x float], ptr %v72, i32 0, i32 283
	store float 0.0, ptr %v1207
	%v1211 = getelementptr [1005 x float], ptr %v72, i32 0, i32 284
	store float 0.0, ptr %v1211
	%v1215 = getelementptr [1005 x float], ptr %v72, i32 0, i32 285
	store float 0.0, ptr %v1215
	%v1219 = getelementptr [1005 x float], ptr %v72, i32 0, i32 286
	store float 0.0, ptr %v1219
	%v1223 = getelementptr [1005 x float], ptr %v72, i32 0, i32 287
	store float 0.0, ptr %v1223
	%v1227 = getelementptr [1005 x float], ptr %v72, i32 0, i32 288
	store float 0.0, ptr %v1227
	%v1231 = getelementptr [1005 x float], ptr %v72, i32 0, i32 289
	store float 0.0, ptr %v1231
	%v1235 = getelementptr [1005 x float], ptr %v72, i32 0, i32 290
	store float 0.0, ptr %v1235
	%v1239 = getelementptr [1005 x float], ptr %v72, i32 0, i32 291
	store float 0.0, ptr %v1239
	%v1243 = getelementptr [1005 x float], ptr %v72, i32 0, i32 292
	store float 0.0, ptr %v1243
	%v1247 = getelementptr [1005 x float], ptr %v72, i32 0, i32 293
	store float 0.0, ptr %v1247
	%v1251 = getelementptr [1005 x float], ptr %v72, i32 0, i32 294
	store float 0.0, ptr %v1251
	%v1255 = getelementptr [1005 x float], ptr %v72, i32 0, i32 295
	store float 0.0, ptr %v1255
	%v1259 = getelementptr [1005 x float], ptr %v72, i32 0, i32 296
	store float 0.0, ptr %v1259
	%v1263 = getelementptr [1005 x float], ptr %v72, i32 0, i32 297
	store float 0.0, ptr %v1263
	%v1267 = getelementptr [1005 x float], ptr %v72, i32 0, i32 298
	store float 0.0, ptr %v1267
	%v1271 = getelementptr [1005 x float], ptr %v72, i32 0, i32 299
	store float 0.0, ptr %v1271
	%v1275 = getelementptr [1005 x float], ptr %v72, i32 0, i32 300
	store float 0.0, ptr %v1275
	%v1279 = getelementptr [1005 x float], ptr %v72, i32 0, i32 301
	store float 0.0, ptr %v1279
	%v1283 = getelementptr [1005 x float], ptr %v72, i32 0, i32 302
	store float 0.0, ptr %v1283
	%v1287 = getelementptr [1005 x float], ptr %v72, i32 0, i32 303
	store float 0.0, ptr %v1287
	%v1291 = getelementptr [1005 x float], ptr %v72, i32 0, i32 304
	store float 0.0, ptr %v1291
	%v1295 = getelementptr [1005 x float], ptr %v72, i32 0, i32 305
	store float 0.0, ptr %v1295
	%v1299 = getelementptr [1005 x float], ptr %v72, i32 0, i32 306
	store float 0.0, ptr %v1299
	%v1303 = getelementptr [1005 x float], ptr %v72, i32 0, i32 307
	store float 0.0, ptr %v1303
	%v1307 = getelementptr [1005 x float], ptr %v72, i32 0, i32 308
	store float 0.0, ptr %v1307
	%v1311 = getelementptr [1005 x float], ptr %v72, i32 0, i32 309
	store float 0.0, ptr %v1311
	%v1315 = getelementptr [1005 x float], ptr %v72, i32 0, i32 310
	store float 0.0, ptr %v1315
	%v1319 = getelementptr [1005 x float], ptr %v72, i32 0, i32 311
	store float 0.0, ptr %v1319
	%v1323 = getelementptr [1005 x float], ptr %v72, i32 0, i32 312
	store float 0.0, ptr %v1323
	%v1327 = getelementptr [1005 x float], ptr %v72, i32 0, i32 313
	store float 0.0, ptr %v1327
	%v1331 = getelementptr [1005 x float], ptr %v72, i32 0, i32 314
	store float 0.0, ptr %v1331
	%v1335 = getelementptr [1005 x float], ptr %v72, i32 0, i32 315
	store float 0.0, ptr %v1335
	%v1339 = getelementptr [1005 x float], ptr %v72, i32 0, i32 316
	store float 0.0, ptr %v1339
	%v1343 = getelementptr [1005 x float], ptr %v72, i32 0, i32 317
	store float 0.0, ptr %v1343
	%v1347 = getelementptr [1005 x float], ptr %v72, i32 0, i32 318
	store float 0.0, ptr %v1347
	%v1351 = getelementptr [1005 x float], ptr %v72, i32 0, i32 319
	store float 0.0, ptr %v1351
	%v1355 = getelementptr [1005 x float], ptr %v72, i32 0, i32 320
	store float 0.0, ptr %v1355
	%v1359 = getelementptr [1005 x float], ptr %v72, i32 0, i32 321
	store float 0.0, ptr %v1359
	%v1363 = getelementptr [1005 x float], ptr %v72, i32 0, i32 322
	store float 0.0, ptr %v1363
	%v1367 = getelementptr [1005 x float], ptr %v72, i32 0, i32 323
	store float 0.0, ptr %v1367
	%v1371 = getelementptr [1005 x float], ptr %v72, i32 0, i32 324
	store float 0.0, ptr %v1371
	%v1375 = getelementptr [1005 x float], ptr %v72, i32 0, i32 325
	store float 0.0, ptr %v1375
	%v1379 = getelementptr [1005 x float], ptr %v72, i32 0, i32 326
	store float 0.0, ptr %v1379
	%v1383 = getelementptr [1005 x float], ptr %v72, i32 0, i32 327
	store float 0.0, ptr %v1383
	%v1387 = getelementptr [1005 x float], ptr %v72, i32 0, i32 328
	store float 0.0, ptr %v1387
	%v1391 = getelementptr [1005 x float], ptr %v72, i32 0, i32 329
	store float 0.0, ptr %v1391
	%v1395 = getelementptr [1005 x float], ptr %v72, i32 0, i32 330
	store float 0.0, ptr %v1395
	%v1399 = getelementptr [1005 x float], ptr %v72, i32 0, i32 331
	store float 0.0, ptr %v1399
	%v1403 = getelementptr [1005 x float], ptr %v72, i32 0, i32 332
	store float 0.0, ptr %v1403
	%v1407 = getelementptr [1005 x float], ptr %v72, i32 0, i32 333
	store float 0.0, ptr %v1407
	%v1411 = getelementptr [1005 x float], ptr %v72, i32 0, i32 334
	store float 0.0, ptr %v1411
	%v1415 = getelementptr [1005 x float], ptr %v72, i32 0, i32 335
	store float 0.0, ptr %v1415
	%v1419 = getelementptr [1005 x float], ptr %v72, i32 0, i32 336
	store float 0.0, ptr %v1419
	%v1423 = getelementptr [1005 x float], ptr %v72, i32 0, i32 337
	store float 0.0, ptr %v1423
	%v1427 = getelementptr [1005 x float], ptr %v72, i32 0, i32 338
	store float 0.0, ptr %v1427
	%v1431 = getelementptr [1005 x float], ptr %v72, i32 0, i32 339
	store float 0.0, ptr %v1431
	%v1435 = getelementptr [1005 x float], ptr %v72, i32 0, i32 340
	store float 0.0, ptr %v1435
	%v1439 = getelementptr [1005 x float], ptr %v72, i32 0, i32 341
	store float 0.0, ptr %v1439
	%v1443 = getelementptr [1005 x float], ptr %v72, i32 0, i32 342
	store float 0.0, ptr %v1443
	%v1447 = getelementptr [1005 x float], ptr %v72, i32 0, i32 343
	store float 0.0, ptr %v1447
	%v1451 = getelementptr [1005 x float], ptr %v72, i32 0, i32 344
	store float 0.0, ptr %v1451
	%v1455 = getelementptr [1005 x float], ptr %v72, i32 0, i32 345
	store float 0.0, ptr %v1455
	%v1459 = getelementptr [1005 x float], ptr %v72, i32 0, i32 346
	store float 0.0, ptr %v1459
	%v1463 = getelementptr [1005 x float], ptr %v72, i32 0, i32 347
	store float 0.0, ptr %v1463
	%v1467 = getelementptr [1005 x float], ptr %v72, i32 0, i32 348
	store float 0.0, ptr %v1467
	%v1471 = getelementptr [1005 x float], ptr %v72, i32 0, i32 349
	store float 0.0, ptr %v1471
	%v1475 = getelementptr [1005 x float], ptr %v72, i32 0, i32 350
	store float 0.0, ptr %v1475
	%v1479 = getelementptr [1005 x float], ptr %v72, i32 0, i32 351
	store float 0.0, ptr %v1479
	%v1483 = getelementptr [1005 x float], ptr %v72, i32 0, i32 352
	store float 0.0, ptr %v1483
	%v1487 = getelementptr [1005 x float], ptr %v72, i32 0, i32 353
	store float 0.0, ptr %v1487
	%v1491 = getelementptr [1005 x float], ptr %v72, i32 0, i32 354
	store float 0.0, ptr %v1491
	%v1495 = getelementptr [1005 x float], ptr %v72, i32 0, i32 355
	store float 0.0, ptr %v1495
	%v1499 = getelementptr [1005 x float], ptr %v72, i32 0, i32 356
	store float 0.0, ptr %v1499
	%v1503 = getelementptr [1005 x float], ptr %v72, i32 0, i32 357
	store float 0.0, ptr %v1503
	%v1507 = getelementptr [1005 x float], ptr %v72, i32 0, i32 358
	store float 0.0, ptr %v1507
	%v1511 = getelementptr [1005 x float], ptr %v72, i32 0, i32 359
	store float 0.0, ptr %v1511
	%v1515 = getelementptr [1005 x float], ptr %v72, i32 0, i32 360
	store float 0.0, ptr %v1515
	%v1519 = getelementptr [1005 x float], ptr %v72, i32 0, i32 361
	store float 0.0, ptr %v1519
	%v1523 = getelementptr [1005 x float], ptr %v72, i32 0, i32 362
	store float 0.0, ptr %v1523
	%v1527 = getelementptr [1005 x float], ptr %v72, i32 0, i32 363
	store float 0.0, ptr %v1527
	%v1531 = getelementptr [1005 x float], ptr %v72, i32 0, i32 364
	store float 0.0, ptr %v1531
	%v1535 = getelementptr [1005 x float], ptr %v72, i32 0, i32 365
	store float 0.0, ptr %v1535
	%v1539 = getelementptr [1005 x float], ptr %v72, i32 0, i32 366
	store float 0.0, ptr %v1539
	%v1543 = getelementptr [1005 x float], ptr %v72, i32 0, i32 367
	store float 0.0, ptr %v1543
	%v1547 = getelementptr [1005 x float], ptr %v72, i32 0, i32 368
	store float 0.0, ptr %v1547
	%v1551 = getelementptr [1005 x float], ptr %v72, i32 0, i32 369
	store float 0.0, ptr %v1551
	%v1555 = getelementptr [1005 x float], ptr %v72, i32 0, i32 370
	store float 0.0, ptr %v1555
	%v1559 = getelementptr [1005 x float], ptr %v72, i32 0, i32 371
	store float 0.0, ptr %v1559
	%v1563 = getelementptr [1005 x float], ptr %v72, i32 0, i32 372
	store float 0.0, ptr %v1563
	%v1567 = getelementptr [1005 x float], ptr %v72, i32 0, i32 373
	store float 0.0, ptr %v1567
	%v1571 = getelementptr [1005 x float], ptr %v72, i32 0, i32 374
	store float 0.0, ptr %v1571
	%v1575 = getelementptr [1005 x float], ptr %v72, i32 0, i32 375
	store float 0.0, ptr %v1575
	%v1579 = getelementptr [1005 x float], ptr %v72, i32 0, i32 376
	store float 0.0, ptr %v1579
	%v1583 = getelementptr [1005 x float], ptr %v72, i32 0, i32 377
	store float 0.0, ptr %v1583
	%v1587 = getelementptr [1005 x float], ptr %v72, i32 0, i32 378
	store float 0.0, ptr %v1587
	%v1591 = getelementptr [1005 x float], ptr %v72, i32 0, i32 379
	store float 0.0, ptr %v1591
	%v1595 = getelementptr [1005 x float], ptr %v72, i32 0, i32 380
	store float 0.0, ptr %v1595
	%v1599 = getelementptr [1005 x float], ptr %v72, i32 0, i32 381
	store float 0.0, ptr %v1599
	%v1603 = getelementptr [1005 x float], ptr %v72, i32 0, i32 382
	store float 0.0, ptr %v1603
	%v1607 = getelementptr [1005 x float], ptr %v72, i32 0, i32 383
	store float 0.0, ptr %v1607
	%v1611 = getelementptr [1005 x float], ptr %v72, i32 0, i32 384
	store float 0.0, ptr %v1611
	%v1615 = getelementptr [1005 x float], ptr %v72, i32 0, i32 385
	store float 0.0, ptr %v1615
	%v1619 = getelementptr [1005 x float], ptr %v72, i32 0, i32 386
	store float 0.0, ptr %v1619
	%v1623 = getelementptr [1005 x float], ptr %v72, i32 0, i32 387
	store float 0.0, ptr %v1623
	%v1627 = getelementptr [1005 x float], ptr %v72, i32 0, i32 388
	store float 0.0, ptr %v1627
	%v1631 = getelementptr [1005 x float], ptr %v72, i32 0, i32 389
	store float 0.0, ptr %v1631
	%v1635 = getelementptr [1005 x float], ptr %v72, i32 0, i32 390
	store float 0.0, ptr %v1635
	%v1639 = getelementptr [1005 x float], ptr %v72, i32 0, i32 391
	store float 0.0, ptr %v1639
	%v1643 = getelementptr [1005 x float], ptr %v72, i32 0, i32 392
	store float 0.0, ptr %v1643
	%v1647 = getelementptr [1005 x float], ptr %v72, i32 0, i32 393
	store float 0.0, ptr %v1647
	%v1651 = getelementptr [1005 x float], ptr %v72, i32 0, i32 394
	store float 0.0, ptr %v1651
	%v1655 = getelementptr [1005 x float], ptr %v72, i32 0, i32 395
	store float 0.0, ptr %v1655
	%v1659 = getelementptr [1005 x float], ptr %v72, i32 0, i32 396
	store float 0.0, ptr %v1659
	%v1663 = getelementptr [1005 x float], ptr %v72, i32 0, i32 397
	store float 0.0, ptr %v1663
	%v1667 = getelementptr [1005 x float], ptr %v72, i32 0, i32 398
	store float 0.0, ptr %v1667
	%v1671 = getelementptr [1005 x float], ptr %v72, i32 0, i32 399
	store float 0.0, ptr %v1671
	%v1675 = getelementptr [1005 x float], ptr %v72, i32 0, i32 400
	store float 0.0, ptr %v1675
	%v1679 = getelementptr [1005 x float], ptr %v72, i32 0, i32 401
	store float 0.0, ptr %v1679
	%v1683 = getelementptr [1005 x float], ptr %v72, i32 0, i32 402
	store float 0.0, ptr %v1683
	%v1687 = getelementptr [1005 x float], ptr %v72, i32 0, i32 403
	store float 0.0, ptr %v1687
	%v1691 = getelementptr [1005 x float], ptr %v72, i32 0, i32 404
	store float 0.0, ptr %v1691
	%v1695 = getelementptr [1005 x float], ptr %v72, i32 0, i32 405
	store float 0.0, ptr %v1695
	%v1699 = getelementptr [1005 x float], ptr %v72, i32 0, i32 406
	store float 0.0, ptr %v1699
	%v1703 = getelementptr [1005 x float], ptr %v72, i32 0, i32 407
	store float 0.0, ptr %v1703
	%v1707 = getelementptr [1005 x float], ptr %v72, i32 0, i32 408
	store float 0.0, ptr %v1707
	%v1711 = getelementptr [1005 x float], ptr %v72, i32 0, i32 409
	store float 0.0, ptr %v1711
	%v1715 = getelementptr [1005 x float], ptr %v72, i32 0, i32 410
	store float 0.0, ptr %v1715
	%v1719 = getelementptr [1005 x float], ptr %v72, i32 0, i32 411
	store float 0.0, ptr %v1719
	%v1723 = getelementptr [1005 x float], ptr %v72, i32 0, i32 412
	store float 0.0, ptr %v1723
	%v1727 = getelementptr [1005 x float], ptr %v72, i32 0, i32 413
	store float 0.0, ptr %v1727
	%v1731 = getelementptr [1005 x float], ptr %v72, i32 0, i32 414
	store float 0.0, ptr %v1731
	%v1735 = getelementptr [1005 x float], ptr %v72, i32 0, i32 415
	store float 0.0, ptr %v1735
	%v1739 = getelementptr [1005 x float], ptr %v72, i32 0, i32 416
	store float 0.0, ptr %v1739
	%v1743 = getelementptr [1005 x float], ptr %v72, i32 0, i32 417
	store float 0.0, ptr %v1743
	%v1747 = getelementptr [1005 x float], ptr %v72, i32 0, i32 418
	store float 0.0, ptr %v1747
	%v1751 = getelementptr [1005 x float], ptr %v72, i32 0, i32 419
	store float 0.0, ptr %v1751
	%v1755 = getelementptr [1005 x float], ptr %v72, i32 0, i32 420
	store float 0.0, ptr %v1755
	%v1759 = getelementptr [1005 x float], ptr %v72, i32 0, i32 421
	store float 0.0, ptr %v1759
	%v1763 = getelementptr [1005 x float], ptr %v72, i32 0, i32 422
	store float 0.0, ptr %v1763
	%v1767 = getelementptr [1005 x float], ptr %v72, i32 0, i32 423
	store float 0.0, ptr %v1767
	%v1771 = getelementptr [1005 x float], ptr %v72, i32 0, i32 424
	store float 0.0, ptr %v1771
	%v1775 = getelementptr [1005 x float], ptr %v72, i32 0, i32 425
	store float 0.0, ptr %v1775
	%v1779 = getelementptr [1005 x float], ptr %v72, i32 0, i32 426
	store float 0.0, ptr %v1779
	%v1783 = getelementptr [1005 x float], ptr %v72, i32 0, i32 427
	store float 0.0, ptr %v1783
	%v1787 = getelementptr [1005 x float], ptr %v72, i32 0, i32 428
	store float 0.0, ptr %v1787
	%v1791 = getelementptr [1005 x float], ptr %v72, i32 0, i32 429
	store float 0.0, ptr %v1791
	%v1795 = getelementptr [1005 x float], ptr %v72, i32 0, i32 430
	store float 0.0, ptr %v1795
	%v1799 = getelementptr [1005 x float], ptr %v72, i32 0, i32 431
	store float 0.0, ptr %v1799
	%v1803 = getelementptr [1005 x float], ptr %v72, i32 0, i32 432
	store float 0.0, ptr %v1803
	%v1807 = getelementptr [1005 x float], ptr %v72, i32 0, i32 433
	store float 0.0, ptr %v1807
	%v1811 = getelementptr [1005 x float], ptr %v72, i32 0, i32 434
	store float 0.0, ptr %v1811
	%v1815 = getelementptr [1005 x float], ptr %v72, i32 0, i32 435
	store float 0.0, ptr %v1815
	%v1819 = getelementptr [1005 x float], ptr %v72, i32 0, i32 436
	store float 0.0, ptr %v1819
	%v1823 = getelementptr [1005 x float], ptr %v72, i32 0, i32 437
	store float 0.0, ptr %v1823
	%v1827 = getelementptr [1005 x float], ptr %v72, i32 0, i32 438
	store float 0.0, ptr %v1827
	%v1831 = getelementptr [1005 x float], ptr %v72, i32 0, i32 439
	store float 0.0, ptr %v1831
	%v1835 = getelementptr [1005 x float], ptr %v72, i32 0, i32 440
	store float 0.0, ptr %v1835
	%v1839 = getelementptr [1005 x float], ptr %v72, i32 0, i32 441
	store float 0.0, ptr %v1839
	%v1843 = getelementptr [1005 x float], ptr %v72, i32 0, i32 442
	store float 0.0, ptr %v1843
	%v1847 = getelementptr [1005 x float], ptr %v72, i32 0, i32 443
	store float 0.0, ptr %v1847
	%v1851 = getelementptr [1005 x float], ptr %v72, i32 0, i32 444
	store float 0.0, ptr %v1851
	%v1855 = getelementptr [1005 x float], ptr %v72, i32 0, i32 445
	store float 0.0, ptr %v1855
	%v1859 = getelementptr [1005 x float], ptr %v72, i32 0, i32 446
	store float 0.0, ptr %v1859
	%v1863 = getelementptr [1005 x float], ptr %v72, i32 0, i32 447
	store float 0.0, ptr %v1863
	%v1867 = getelementptr [1005 x float], ptr %v72, i32 0, i32 448
	store float 0.0, ptr %v1867
	%v1871 = getelementptr [1005 x float], ptr %v72, i32 0, i32 449
	store float 0.0, ptr %v1871
	%v1875 = getelementptr [1005 x float], ptr %v72, i32 0, i32 450
	store float 0.0, ptr %v1875
	%v1879 = getelementptr [1005 x float], ptr %v72, i32 0, i32 451
	store float 0.0, ptr %v1879
	%v1883 = getelementptr [1005 x float], ptr %v72, i32 0, i32 452
	store float 0.0, ptr %v1883
	%v1887 = getelementptr [1005 x float], ptr %v72, i32 0, i32 453
	store float 0.0, ptr %v1887
	%v1891 = getelementptr [1005 x float], ptr %v72, i32 0, i32 454
	store float 0.0, ptr %v1891
	%v1895 = getelementptr [1005 x float], ptr %v72, i32 0, i32 455
	store float 0.0, ptr %v1895
	%v1899 = getelementptr [1005 x float], ptr %v72, i32 0, i32 456
	store float 0.0, ptr %v1899
	%v1903 = getelementptr [1005 x float], ptr %v72, i32 0, i32 457
	store float 0.0, ptr %v1903
	%v1907 = getelementptr [1005 x float], ptr %v72, i32 0, i32 458
	store float 0.0, ptr %v1907
	%v1911 = getelementptr [1005 x float], ptr %v72, i32 0, i32 459
	store float 0.0, ptr %v1911
	%v1915 = getelementptr [1005 x float], ptr %v72, i32 0, i32 460
	store float 0.0, ptr %v1915
	%v1919 = getelementptr [1005 x float], ptr %v72, i32 0, i32 461
	store float 0.0, ptr %v1919
	%v1923 = getelementptr [1005 x float], ptr %v72, i32 0, i32 462
	store float 0.0, ptr %v1923
	%v1927 = getelementptr [1005 x float], ptr %v72, i32 0, i32 463
	store float 0.0, ptr %v1927
	%v1931 = getelementptr [1005 x float], ptr %v72, i32 0, i32 464
	store float 0.0, ptr %v1931
	%v1935 = getelementptr [1005 x float], ptr %v72, i32 0, i32 465
	store float 0.0, ptr %v1935
	%v1939 = getelementptr [1005 x float], ptr %v72, i32 0, i32 466
	store float 0.0, ptr %v1939
	%v1943 = getelementptr [1005 x float], ptr %v72, i32 0, i32 467
	store float 0.0, ptr %v1943
	%v1947 = getelementptr [1005 x float], ptr %v72, i32 0, i32 468
	store float 0.0, ptr %v1947
	%v1951 = getelementptr [1005 x float], ptr %v72, i32 0, i32 469
	store float 0.0, ptr %v1951
	%v1955 = getelementptr [1005 x float], ptr %v72, i32 0, i32 470
	store float 0.0, ptr %v1955
	%v1959 = getelementptr [1005 x float], ptr %v72, i32 0, i32 471
	store float 0.0, ptr %v1959
	%v1963 = getelementptr [1005 x float], ptr %v72, i32 0, i32 472
	store float 0.0, ptr %v1963
	%v1967 = getelementptr [1005 x float], ptr %v72, i32 0, i32 473
	store float 0.0, ptr %v1967
	%v1971 = getelementptr [1005 x float], ptr %v72, i32 0, i32 474
	store float 0.0, ptr %v1971
	%v1975 = getelementptr [1005 x float], ptr %v72, i32 0, i32 475
	store float 0.0, ptr %v1975
	%v1979 = getelementptr [1005 x float], ptr %v72, i32 0, i32 476
	store float 0.0, ptr %v1979
	%v1983 = getelementptr [1005 x float], ptr %v72, i32 0, i32 477
	store float 0.0, ptr %v1983
	%v1987 = getelementptr [1005 x float], ptr %v72, i32 0, i32 478
	store float 0.0, ptr %v1987
	%v1991 = getelementptr [1005 x float], ptr %v72, i32 0, i32 479
	store float 0.0, ptr %v1991
	%v1995 = getelementptr [1005 x float], ptr %v72, i32 0, i32 480
	store float 0.0, ptr %v1995
	%v1999 = getelementptr [1005 x float], ptr %v72, i32 0, i32 481
	store float 0.0, ptr %v1999
	%v2003 = getelementptr [1005 x float], ptr %v72, i32 0, i32 482
	store float 0.0, ptr %v2003
	%v2007 = getelementptr [1005 x float], ptr %v72, i32 0, i32 483
	store float 0.0, ptr %v2007
	%v2011 = getelementptr [1005 x float], ptr %v72, i32 0, i32 484
	store float 0.0, ptr %v2011
	%v2015 = getelementptr [1005 x float], ptr %v72, i32 0, i32 485
	store float 0.0, ptr %v2015
	%v2019 = getelementptr [1005 x float], ptr %v72, i32 0, i32 486
	store float 0.0, ptr %v2019
	%v2023 = getelementptr [1005 x float], ptr %v72, i32 0, i32 487
	store float 0.0, ptr %v2023
	%v2027 = getelementptr [1005 x float], ptr %v72, i32 0, i32 488
	store float 0.0, ptr %v2027
	%v2031 = getelementptr [1005 x float], ptr %v72, i32 0, i32 489
	store float 0.0, ptr %v2031
	%v2035 = getelementptr [1005 x float], ptr %v72, i32 0, i32 490
	store float 0.0, ptr %v2035
	%v2039 = getelementptr [1005 x float], ptr %v72, i32 0, i32 491
	store float 0.0, ptr %v2039
	%v2043 = getelementptr [1005 x float], ptr %v72, i32 0, i32 492
	store float 0.0, ptr %v2043
	%v2047 = getelementptr [1005 x float], ptr %v72, i32 0, i32 493
	store float 0.0, ptr %v2047
	%v2051 = getelementptr [1005 x float], ptr %v72, i32 0, i32 494
	store float 0.0, ptr %v2051
	%v2055 = getelementptr [1005 x float], ptr %v72, i32 0, i32 495
	store float 0.0, ptr %v2055
	%v2059 = getelementptr [1005 x float], ptr %v72, i32 0, i32 496
	store float 0.0, ptr %v2059
	%v2063 = getelementptr [1005 x float], ptr %v72, i32 0, i32 497
	store float 0.0, ptr %v2063
	%v2067 = getelementptr [1005 x float], ptr %v72, i32 0, i32 498
	store float 0.0, ptr %v2067
	%v2071 = getelementptr [1005 x float], ptr %v72, i32 0, i32 499
	store float 0.0, ptr %v2071
	%v2075 = getelementptr [1005 x float], ptr %v72, i32 0, i32 500
	store float 0.0, ptr %v2075
	%v2079 = getelementptr [1005 x float], ptr %v72, i32 0, i32 501
	store float 0.0, ptr %v2079
	%v2083 = getelementptr [1005 x float], ptr %v72, i32 0, i32 502
	store float 0.0, ptr %v2083
	%v2087 = getelementptr [1005 x float], ptr %v72, i32 0, i32 503
	store float 0.0, ptr %v2087
	%v2091 = getelementptr [1005 x float], ptr %v72, i32 0, i32 504
	store float 0.0, ptr %v2091
	%v2095 = getelementptr [1005 x float], ptr %v72, i32 0, i32 505
	store float 0.0, ptr %v2095
	%v2099 = getelementptr [1005 x float], ptr %v72, i32 0, i32 506
	store float 0.0, ptr %v2099
	%v2103 = getelementptr [1005 x float], ptr %v72, i32 0, i32 507
	store float 0.0, ptr %v2103
	%v2107 = getelementptr [1005 x float], ptr %v72, i32 0, i32 508
	store float 0.0, ptr %v2107
	%v2111 = getelementptr [1005 x float], ptr %v72, i32 0, i32 509
	store float 0.0, ptr %v2111
	%v2115 = getelementptr [1005 x float], ptr %v72, i32 0, i32 510
	store float 0.0, ptr %v2115
	%v2119 = getelementptr [1005 x float], ptr %v72, i32 0, i32 511
	store float 0.0, ptr %v2119
	%v2123 = getelementptr [1005 x float], ptr %v72, i32 0, i32 512
	store float 0.0, ptr %v2123
	%v2127 = getelementptr [1005 x float], ptr %v72, i32 0, i32 513
	store float 0.0, ptr %v2127
	%v2131 = getelementptr [1005 x float], ptr %v72, i32 0, i32 514
	store float 0.0, ptr %v2131
	%v2135 = getelementptr [1005 x float], ptr %v72, i32 0, i32 515
	store float 0.0, ptr %v2135
	%v2139 = getelementptr [1005 x float], ptr %v72, i32 0, i32 516
	store float 0.0, ptr %v2139
	%v2143 = getelementptr [1005 x float], ptr %v72, i32 0, i32 517
	store float 0.0, ptr %v2143
	%v2147 = getelementptr [1005 x float], ptr %v72, i32 0, i32 518
	store float 0.0, ptr %v2147
	%v2151 = getelementptr [1005 x float], ptr %v72, i32 0, i32 519
	store float 0.0, ptr %v2151
	%v2155 = getelementptr [1005 x float], ptr %v72, i32 0, i32 520
	store float 0.0, ptr %v2155
	%v2159 = getelementptr [1005 x float], ptr %v72, i32 0, i32 521
	store float 0.0, ptr %v2159
	%v2163 = getelementptr [1005 x float], ptr %v72, i32 0, i32 522
	store float 0.0, ptr %v2163
	%v2167 = getelementptr [1005 x float], ptr %v72, i32 0, i32 523
	store float 0.0, ptr %v2167
	%v2171 = getelementptr [1005 x float], ptr %v72, i32 0, i32 524
	store float 0.0, ptr %v2171
	%v2175 = getelementptr [1005 x float], ptr %v72, i32 0, i32 525
	store float 0.0, ptr %v2175
	%v2179 = getelementptr [1005 x float], ptr %v72, i32 0, i32 526
	store float 0.0, ptr %v2179
	%v2183 = getelementptr [1005 x float], ptr %v72, i32 0, i32 527
	store float 0.0, ptr %v2183
	%v2187 = getelementptr [1005 x float], ptr %v72, i32 0, i32 528
	store float 0.0, ptr %v2187
	%v2191 = getelementptr [1005 x float], ptr %v72, i32 0, i32 529
	store float 0.0, ptr %v2191
	%v2195 = getelementptr [1005 x float], ptr %v72, i32 0, i32 530
	store float 0.0, ptr %v2195
	%v2199 = getelementptr [1005 x float], ptr %v72, i32 0, i32 531
	store float 0.0, ptr %v2199
	%v2203 = getelementptr [1005 x float], ptr %v72, i32 0, i32 532
	store float 0.0, ptr %v2203
	%v2207 = getelementptr [1005 x float], ptr %v72, i32 0, i32 533
	store float 0.0, ptr %v2207
	%v2211 = getelementptr [1005 x float], ptr %v72, i32 0, i32 534
	store float 0.0, ptr %v2211
	%v2215 = getelementptr [1005 x float], ptr %v72, i32 0, i32 535
	store float 0.0, ptr %v2215
	%v2219 = getelementptr [1005 x float], ptr %v72, i32 0, i32 536
	store float 0.0, ptr %v2219
	%v2223 = getelementptr [1005 x float], ptr %v72, i32 0, i32 537
	store float 0.0, ptr %v2223
	%v2227 = getelementptr [1005 x float], ptr %v72, i32 0, i32 538
	store float 0.0, ptr %v2227
	%v2231 = getelementptr [1005 x float], ptr %v72, i32 0, i32 539
	store float 0.0, ptr %v2231
	%v2235 = getelementptr [1005 x float], ptr %v72, i32 0, i32 540
	store float 0.0, ptr %v2235
	%v2239 = getelementptr [1005 x float], ptr %v72, i32 0, i32 541
	store float 0.0, ptr %v2239
	%v2243 = getelementptr [1005 x float], ptr %v72, i32 0, i32 542
	store float 0.0, ptr %v2243
	%v2247 = getelementptr [1005 x float], ptr %v72, i32 0, i32 543
	store float 0.0, ptr %v2247
	%v2251 = getelementptr [1005 x float], ptr %v72, i32 0, i32 544
	store float 0.0, ptr %v2251
	%v2255 = getelementptr [1005 x float], ptr %v72, i32 0, i32 545
	store float 0.0, ptr %v2255
	%v2259 = getelementptr [1005 x float], ptr %v72, i32 0, i32 546
	store float 0.0, ptr %v2259
	%v2263 = getelementptr [1005 x float], ptr %v72, i32 0, i32 547
	store float 0.0, ptr %v2263
	%v2267 = getelementptr [1005 x float], ptr %v72, i32 0, i32 548
	store float 0.0, ptr %v2267
	%v2271 = getelementptr [1005 x float], ptr %v72, i32 0, i32 549
	store float 0.0, ptr %v2271
	%v2275 = getelementptr [1005 x float], ptr %v72, i32 0, i32 550
	store float 0.0, ptr %v2275
	%v2279 = getelementptr [1005 x float], ptr %v72, i32 0, i32 551
	store float 0.0, ptr %v2279
	%v2283 = getelementptr [1005 x float], ptr %v72, i32 0, i32 552
	store float 0.0, ptr %v2283
	%v2287 = getelementptr [1005 x float], ptr %v72, i32 0, i32 553
	store float 0.0, ptr %v2287
	%v2291 = getelementptr [1005 x float], ptr %v72, i32 0, i32 554
	store float 0.0, ptr %v2291
	%v2295 = getelementptr [1005 x float], ptr %v72, i32 0, i32 555
	store float 0.0, ptr %v2295
	%v2299 = getelementptr [1005 x float], ptr %v72, i32 0, i32 556
	store float 0.0, ptr %v2299
	%v2303 = getelementptr [1005 x float], ptr %v72, i32 0, i32 557
	store float 0.0, ptr %v2303
	%v2307 = getelementptr [1005 x float], ptr %v72, i32 0, i32 558
	store float 0.0, ptr %v2307
	%v2311 = getelementptr [1005 x float], ptr %v72, i32 0, i32 559
	store float 0.0, ptr %v2311
	%v2315 = getelementptr [1005 x float], ptr %v72, i32 0, i32 560
	store float 0.0, ptr %v2315
	%v2319 = getelementptr [1005 x float], ptr %v72, i32 0, i32 561
	store float 0.0, ptr %v2319
	%v2323 = getelementptr [1005 x float], ptr %v72, i32 0, i32 562
	store float 0.0, ptr %v2323
	%v2327 = getelementptr [1005 x float], ptr %v72, i32 0, i32 563
	store float 0.0, ptr %v2327
	%v2331 = getelementptr [1005 x float], ptr %v72, i32 0, i32 564
	store float 0.0, ptr %v2331
	%v2335 = getelementptr [1005 x float], ptr %v72, i32 0, i32 565
	store float 0.0, ptr %v2335
	%v2339 = getelementptr [1005 x float], ptr %v72, i32 0, i32 566
	store float 0.0, ptr %v2339
	%v2343 = getelementptr [1005 x float], ptr %v72, i32 0, i32 567
	store float 0.0, ptr %v2343
	%v2347 = getelementptr [1005 x float], ptr %v72, i32 0, i32 568
	store float 0.0, ptr %v2347
	%v2351 = getelementptr [1005 x float], ptr %v72, i32 0, i32 569
	store float 0.0, ptr %v2351
	%v2355 = getelementptr [1005 x float], ptr %v72, i32 0, i32 570
	store float 0.0, ptr %v2355
	%v2359 = getelementptr [1005 x float], ptr %v72, i32 0, i32 571
	store float 0.0, ptr %v2359
	%v2363 = getelementptr [1005 x float], ptr %v72, i32 0, i32 572
	store float 0.0, ptr %v2363
	%v2367 = getelementptr [1005 x float], ptr %v72, i32 0, i32 573
	store float 0.0, ptr %v2367
	%v2371 = getelementptr [1005 x float], ptr %v72, i32 0, i32 574
	store float 0.0, ptr %v2371
	%v2375 = getelementptr [1005 x float], ptr %v72, i32 0, i32 575
	store float 0.0, ptr %v2375
	%v2379 = getelementptr [1005 x float], ptr %v72, i32 0, i32 576
	store float 0.0, ptr %v2379
	%v2383 = getelementptr [1005 x float], ptr %v72, i32 0, i32 577
	store float 0.0, ptr %v2383
	%v2387 = getelementptr [1005 x float], ptr %v72, i32 0, i32 578
	store float 0.0, ptr %v2387
	%v2391 = getelementptr [1005 x float], ptr %v72, i32 0, i32 579
	store float 0.0, ptr %v2391
	%v2395 = getelementptr [1005 x float], ptr %v72, i32 0, i32 580
	store float 0.0, ptr %v2395
	%v2399 = getelementptr [1005 x float], ptr %v72, i32 0, i32 581
	store float 0.0, ptr %v2399
	%v2403 = getelementptr [1005 x float], ptr %v72, i32 0, i32 582
	store float 0.0, ptr %v2403
	%v2407 = getelementptr [1005 x float], ptr %v72, i32 0, i32 583
	store float 0.0, ptr %v2407
	%v2411 = getelementptr [1005 x float], ptr %v72, i32 0, i32 584
	store float 0.0, ptr %v2411
	%v2415 = getelementptr [1005 x float], ptr %v72, i32 0, i32 585
	store float 0.0, ptr %v2415
	%v2419 = getelementptr [1005 x float], ptr %v72, i32 0, i32 586
	store float 0.0, ptr %v2419
	%v2423 = getelementptr [1005 x float], ptr %v72, i32 0, i32 587
	store float 0.0, ptr %v2423
	%v2427 = getelementptr [1005 x float], ptr %v72, i32 0, i32 588
	store float 0.0, ptr %v2427
	%v2431 = getelementptr [1005 x float], ptr %v72, i32 0, i32 589
	store float 0.0, ptr %v2431
	%v2435 = getelementptr [1005 x float], ptr %v72, i32 0, i32 590
	store float 0.0, ptr %v2435
	%v2439 = getelementptr [1005 x float], ptr %v72, i32 0, i32 591
	store float 0.0, ptr %v2439
	%v2443 = getelementptr [1005 x float], ptr %v72, i32 0, i32 592
	store float 0.0, ptr %v2443
	%v2447 = getelementptr [1005 x float], ptr %v72, i32 0, i32 593
	store float 0.0, ptr %v2447
	%v2451 = getelementptr [1005 x float], ptr %v72, i32 0, i32 594
	store float 0.0, ptr %v2451
	%v2455 = getelementptr [1005 x float], ptr %v72, i32 0, i32 595
	store float 0.0, ptr %v2455
	%v2459 = getelementptr [1005 x float], ptr %v72, i32 0, i32 596
	store float 0.0, ptr %v2459
	%v2463 = getelementptr [1005 x float], ptr %v72, i32 0, i32 597
	store float 0.0, ptr %v2463
	%v2467 = getelementptr [1005 x float], ptr %v72, i32 0, i32 598
	store float 0.0, ptr %v2467
	%v2471 = getelementptr [1005 x float], ptr %v72, i32 0, i32 599
	store float 0.0, ptr %v2471
	%v2475 = getelementptr [1005 x float], ptr %v72, i32 0, i32 600
	store float 0.0, ptr %v2475
	%v2479 = getelementptr [1005 x float], ptr %v72, i32 0, i32 601
	store float 0.0, ptr %v2479
	%v2483 = getelementptr [1005 x float], ptr %v72, i32 0, i32 602
	store float 0.0, ptr %v2483
	%v2487 = getelementptr [1005 x float], ptr %v72, i32 0, i32 603
	store float 0.0, ptr %v2487
	%v2491 = getelementptr [1005 x float], ptr %v72, i32 0, i32 604
	store float 0.0, ptr %v2491
	%v2495 = getelementptr [1005 x float], ptr %v72, i32 0, i32 605
	store float 0.0, ptr %v2495
	%v2499 = getelementptr [1005 x float], ptr %v72, i32 0, i32 606
	store float 0.0, ptr %v2499
	%v2503 = getelementptr [1005 x float], ptr %v72, i32 0, i32 607
	store float 0.0, ptr %v2503
	%v2507 = getelementptr [1005 x float], ptr %v72, i32 0, i32 608
	store float 0.0, ptr %v2507
	%v2511 = getelementptr [1005 x float], ptr %v72, i32 0, i32 609
	store float 0.0, ptr %v2511
	%v2515 = getelementptr [1005 x float], ptr %v72, i32 0, i32 610
	store float 0.0, ptr %v2515
	%v2519 = getelementptr [1005 x float], ptr %v72, i32 0, i32 611
	store float 0.0, ptr %v2519
	%v2523 = getelementptr [1005 x float], ptr %v72, i32 0, i32 612
	store float 0.0, ptr %v2523
	%v2527 = getelementptr [1005 x float], ptr %v72, i32 0, i32 613
	store float 0.0, ptr %v2527
	%v2531 = getelementptr [1005 x float], ptr %v72, i32 0, i32 614
	store float 0.0, ptr %v2531
	%v2535 = getelementptr [1005 x float], ptr %v72, i32 0, i32 615
	store float 0.0, ptr %v2535
	%v2539 = getelementptr [1005 x float], ptr %v72, i32 0, i32 616
	store float 0.0, ptr %v2539
	%v2543 = getelementptr [1005 x float], ptr %v72, i32 0, i32 617
	store float 0.0, ptr %v2543
	%v2547 = getelementptr [1005 x float], ptr %v72, i32 0, i32 618
	store float 0.0, ptr %v2547
	%v2551 = getelementptr [1005 x float], ptr %v72, i32 0, i32 619
	store float 0.0, ptr %v2551
	%v2555 = getelementptr [1005 x float], ptr %v72, i32 0, i32 620
	store float 0.0, ptr %v2555
	%v2559 = getelementptr [1005 x float], ptr %v72, i32 0, i32 621
	store float 0.0, ptr %v2559
	%v2563 = getelementptr [1005 x float], ptr %v72, i32 0, i32 622
	store float 0.0, ptr %v2563
	%v2567 = getelementptr [1005 x float], ptr %v72, i32 0, i32 623
	store float 0.0, ptr %v2567
	%v2571 = getelementptr [1005 x float], ptr %v72, i32 0, i32 624
	store float 0.0, ptr %v2571
	%v2575 = getelementptr [1005 x float], ptr %v72, i32 0, i32 625
	store float 0.0, ptr %v2575
	%v2579 = getelementptr [1005 x float], ptr %v72, i32 0, i32 626
	store float 0.0, ptr %v2579
	%v2583 = getelementptr [1005 x float], ptr %v72, i32 0, i32 627
	store float 0.0, ptr %v2583
	%v2587 = getelementptr [1005 x float], ptr %v72, i32 0, i32 628
	store float 0.0, ptr %v2587
	%v2591 = getelementptr [1005 x float], ptr %v72, i32 0, i32 629
	store float 0.0, ptr %v2591
	%v2595 = getelementptr [1005 x float], ptr %v72, i32 0, i32 630
	store float 0.0, ptr %v2595
	%v2599 = getelementptr [1005 x float], ptr %v72, i32 0, i32 631
	store float 0.0, ptr %v2599
	%v2603 = getelementptr [1005 x float], ptr %v72, i32 0, i32 632
	store float 0.0, ptr %v2603
	%v2607 = getelementptr [1005 x float], ptr %v72, i32 0, i32 633
	store float 0.0, ptr %v2607
	%v2611 = getelementptr [1005 x float], ptr %v72, i32 0, i32 634
	store float 0.0, ptr %v2611
	%v2615 = getelementptr [1005 x float], ptr %v72, i32 0, i32 635
	store float 0.0, ptr %v2615
	%v2619 = getelementptr [1005 x float], ptr %v72, i32 0, i32 636
	store float 0.0, ptr %v2619
	%v2623 = getelementptr [1005 x float], ptr %v72, i32 0, i32 637
	store float 0.0, ptr %v2623
	%v2627 = getelementptr [1005 x float], ptr %v72, i32 0, i32 638
	store float 0.0, ptr %v2627
	%v2631 = getelementptr [1005 x float], ptr %v72, i32 0, i32 639
	store float 0.0, ptr %v2631
	%v2635 = getelementptr [1005 x float], ptr %v72, i32 0, i32 640
	store float 0.0, ptr %v2635
	%v2639 = getelementptr [1005 x float], ptr %v72, i32 0, i32 641
	store float 0.0, ptr %v2639
	%v2643 = getelementptr [1005 x float], ptr %v72, i32 0, i32 642
	store float 0.0, ptr %v2643
	%v2647 = getelementptr [1005 x float], ptr %v72, i32 0, i32 643
	store float 0.0, ptr %v2647
	%v2651 = getelementptr [1005 x float], ptr %v72, i32 0, i32 644
	store float 0.0, ptr %v2651
	%v2655 = getelementptr [1005 x float], ptr %v72, i32 0, i32 645
	store float 0.0, ptr %v2655
	%v2659 = getelementptr [1005 x float], ptr %v72, i32 0, i32 646
	store float 0.0, ptr %v2659
	%v2663 = getelementptr [1005 x float], ptr %v72, i32 0, i32 647
	store float 0.0, ptr %v2663
	%v2667 = getelementptr [1005 x float], ptr %v72, i32 0, i32 648
	store float 0.0, ptr %v2667
	%v2671 = getelementptr [1005 x float], ptr %v72, i32 0, i32 649
	store float 0.0, ptr %v2671
	%v2675 = getelementptr [1005 x float], ptr %v72, i32 0, i32 650
	store float 0.0, ptr %v2675
	%v2679 = getelementptr [1005 x float], ptr %v72, i32 0, i32 651
	store float 0.0, ptr %v2679
	%v2683 = getelementptr [1005 x float], ptr %v72, i32 0, i32 652
	store float 0.0, ptr %v2683
	%v2687 = getelementptr [1005 x float], ptr %v72, i32 0, i32 653
	store float 0.0, ptr %v2687
	%v2691 = getelementptr [1005 x float], ptr %v72, i32 0, i32 654
	store float 0.0, ptr %v2691
	%v2695 = getelementptr [1005 x float], ptr %v72, i32 0, i32 655
	store float 0.0, ptr %v2695
	%v2699 = getelementptr [1005 x float], ptr %v72, i32 0, i32 656
	store float 0.0, ptr %v2699
	%v2703 = getelementptr [1005 x float], ptr %v72, i32 0, i32 657
	store float 0.0, ptr %v2703
	%v2707 = getelementptr [1005 x float], ptr %v72, i32 0, i32 658
	store float 0.0, ptr %v2707
	%v2711 = getelementptr [1005 x float], ptr %v72, i32 0, i32 659
	store float 0.0, ptr %v2711
	%v2715 = getelementptr [1005 x float], ptr %v72, i32 0, i32 660
	store float 0.0, ptr %v2715
	%v2719 = getelementptr [1005 x float], ptr %v72, i32 0, i32 661
	store float 0.0, ptr %v2719
	%v2723 = getelementptr [1005 x float], ptr %v72, i32 0, i32 662
	store float 0.0, ptr %v2723
	%v2727 = getelementptr [1005 x float], ptr %v72, i32 0, i32 663
	store float 0.0, ptr %v2727
	%v2731 = getelementptr [1005 x float], ptr %v72, i32 0, i32 664
	store float 0.0, ptr %v2731
	%v2735 = getelementptr [1005 x float], ptr %v72, i32 0, i32 665
	store float 0.0, ptr %v2735
	%v2739 = getelementptr [1005 x float], ptr %v72, i32 0, i32 666
	store float 0.0, ptr %v2739
	%v2743 = getelementptr [1005 x float], ptr %v72, i32 0, i32 667
	store float 0.0, ptr %v2743
	%v2747 = getelementptr [1005 x float], ptr %v72, i32 0, i32 668
	store float 0.0, ptr %v2747
	%v2751 = getelementptr [1005 x float], ptr %v72, i32 0, i32 669
	store float 0.0, ptr %v2751
	%v2755 = getelementptr [1005 x float], ptr %v72, i32 0, i32 670
	store float 0.0, ptr %v2755
	%v2759 = getelementptr [1005 x float], ptr %v72, i32 0, i32 671
	store float 0.0, ptr %v2759
	%v2763 = getelementptr [1005 x float], ptr %v72, i32 0, i32 672
	store float 0.0, ptr %v2763
	%v2767 = getelementptr [1005 x float], ptr %v72, i32 0, i32 673
	store float 0.0, ptr %v2767
	%v2771 = getelementptr [1005 x float], ptr %v72, i32 0, i32 674
	store float 0.0, ptr %v2771
	%v2775 = getelementptr [1005 x float], ptr %v72, i32 0, i32 675
	store float 0.0, ptr %v2775
	%v2779 = getelementptr [1005 x float], ptr %v72, i32 0, i32 676
	store float 0.0, ptr %v2779
	%v2783 = getelementptr [1005 x float], ptr %v72, i32 0, i32 677
	store float 0.0, ptr %v2783
	%v2787 = getelementptr [1005 x float], ptr %v72, i32 0, i32 678
	store float 0.0, ptr %v2787
	%v2791 = getelementptr [1005 x float], ptr %v72, i32 0, i32 679
	store float 0.0, ptr %v2791
	%v2795 = getelementptr [1005 x float], ptr %v72, i32 0, i32 680
	store float 0.0, ptr %v2795
	%v2799 = getelementptr [1005 x float], ptr %v72, i32 0, i32 681
	store float 0.0, ptr %v2799
	%v2803 = getelementptr [1005 x float], ptr %v72, i32 0, i32 682
	store float 0.0, ptr %v2803
	%v2807 = getelementptr [1005 x float], ptr %v72, i32 0, i32 683
	store float 0.0, ptr %v2807
	%v2811 = getelementptr [1005 x float], ptr %v72, i32 0, i32 684
	store float 0.0, ptr %v2811
	%v2815 = getelementptr [1005 x float], ptr %v72, i32 0, i32 685
	store float 0.0, ptr %v2815
	%v2819 = getelementptr [1005 x float], ptr %v72, i32 0, i32 686
	store float 0.0, ptr %v2819
	%v2823 = getelementptr [1005 x float], ptr %v72, i32 0, i32 687
	store float 0.0, ptr %v2823
	%v2827 = getelementptr [1005 x float], ptr %v72, i32 0, i32 688
	store float 0.0, ptr %v2827
	%v2831 = getelementptr [1005 x float], ptr %v72, i32 0, i32 689
	store float 0.0, ptr %v2831
	%v2835 = getelementptr [1005 x float], ptr %v72, i32 0, i32 690
	store float 0.0, ptr %v2835
	%v2839 = getelementptr [1005 x float], ptr %v72, i32 0, i32 691
	store float 0.0, ptr %v2839
	%v2843 = getelementptr [1005 x float], ptr %v72, i32 0, i32 692
	store float 0.0, ptr %v2843
	%v2847 = getelementptr [1005 x float], ptr %v72, i32 0, i32 693
	store float 0.0, ptr %v2847
	%v2851 = getelementptr [1005 x float], ptr %v72, i32 0, i32 694
	store float 0.0, ptr %v2851
	%v2855 = getelementptr [1005 x float], ptr %v72, i32 0, i32 695
	store float 0.0, ptr %v2855
	%v2859 = getelementptr [1005 x float], ptr %v72, i32 0, i32 696
	store float 0.0, ptr %v2859
	%v2863 = getelementptr [1005 x float], ptr %v72, i32 0, i32 697
	store float 0.0, ptr %v2863
	%v2867 = getelementptr [1005 x float], ptr %v72, i32 0, i32 698
	store float 0.0, ptr %v2867
	%v2871 = getelementptr [1005 x float], ptr %v72, i32 0, i32 699
	store float 0.0, ptr %v2871
	%v2875 = getelementptr [1005 x float], ptr %v72, i32 0, i32 700
	store float 0.0, ptr %v2875
	%v2879 = getelementptr [1005 x float], ptr %v72, i32 0, i32 701
	store float 0.0, ptr %v2879
	%v2883 = getelementptr [1005 x float], ptr %v72, i32 0, i32 702
	store float 0.0, ptr %v2883
	%v2887 = getelementptr [1005 x float], ptr %v72, i32 0, i32 703
	store float 0.0, ptr %v2887
	%v2891 = getelementptr [1005 x float], ptr %v72, i32 0, i32 704
	store float 0.0, ptr %v2891
	%v2895 = getelementptr [1005 x float], ptr %v72, i32 0, i32 705
	store float 0.0, ptr %v2895
	%v2899 = getelementptr [1005 x float], ptr %v72, i32 0, i32 706
	store float 0.0, ptr %v2899
	%v2903 = getelementptr [1005 x float], ptr %v72, i32 0, i32 707
	store float 0.0, ptr %v2903
	%v2907 = getelementptr [1005 x float], ptr %v72, i32 0, i32 708
	store float 0.0, ptr %v2907
	%v2911 = getelementptr [1005 x float], ptr %v72, i32 0, i32 709
	store float 0.0, ptr %v2911
	%v2915 = getelementptr [1005 x float], ptr %v72, i32 0, i32 710
	store float 0.0, ptr %v2915
	%v2919 = getelementptr [1005 x float], ptr %v72, i32 0, i32 711
	store float 0.0, ptr %v2919
	%v2923 = getelementptr [1005 x float], ptr %v72, i32 0, i32 712
	store float 0.0, ptr %v2923
	%v2927 = getelementptr [1005 x float], ptr %v72, i32 0, i32 713
	store float 0.0, ptr %v2927
	%v2931 = getelementptr [1005 x float], ptr %v72, i32 0, i32 714
	store float 0.0, ptr %v2931
	%v2935 = getelementptr [1005 x float], ptr %v72, i32 0, i32 715
	store float 0.0, ptr %v2935
	%v2939 = getelementptr [1005 x float], ptr %v72, i32 0, i32 716
	store float 0.0, ptr %v2939
	%v2943 = getelementptr [1005 x float], ptr %v72, i32 0, i32 717
	store float 0.0, ptr %v2943
	%v2947 = getelementptr [1005 x float], ptr %v72, i32 0, i32 718
	store float 0.0, ptr %v2947
	%v2951 = getelementptr [1005 x float], ptr %v72, i32 0, i32 719
	store float 0.0, ptr %v2951
	%v2955 = getelementptr [1005 x float], ptr %v72, i32 0, i32 720
	store float 0.0, ptr %v2955
	%v2959 = getelementptr [1005 x float], ptr %v72, i32 0, i32 721
	store float 0.0, ptr %v2959
	%v2963 = getelementptr [1005 x float], ptr %v72, i32 0, i32 722
	store float 0.0, ptr %v2963
	%v2967 = getelementptr [1005 x float], ptr %v72, i32 0, i32 723
	store float 0.0, ptr %v2967
	%v2971 = getelementptr [1005 x float], ptr %v72, i32 0, i32 724
	store float 0.0, ptr %v2971
	%v2975 = getelementptr [1005 x float], ptr %v72, i32 0, i32 725
	store float 0.0, ptr %v2975
	%v2979 = getelementptr [1005 x float], ptr %v72, i32 0, i32 726
	store float 0.0, ptr %v2979
	%v2983 = getelementptr [1005 x float], ptr %v72, i32 0, i32 727
	store float 0.0, ptr %v2983
	%v2987 = getelementptr [1005 x float], ptr %v72, i32 0, i32 728
	store float 0.0, ptr %v2987
	%v2991 = getelementptr [1005 x float], ptr %v72, i32 0, i32 729
	store float 0.0, ptr %v2991
	%v2995 = getelementptr [1005 x float], ptr %v72, i32 0, i32 730
	store float 0.0, ptr %v2995
	%v2999 = getelementptr [1005 x float], ptr %v72, i32 0, i32 731
	store float 0.0, ptr %v2999
	%v3003 = getelementptr [1005 x float], ptr %v72, i32 0, i32 732
	store float 0.0, ptr %v3003
	%v3007 = getelementptr [1005 x float], ptr %v72, i32 0, i32 733
	store float 0.0, ptr %v3007
	%v3011 = getelementptr [1005 x float], ptr %v72, i32 0, i32 734
	store float 0.0, ptr %v3011
	%v3015 = getelementptr [1005 x float], ptr %v72, i32 0, i32 735
	store float 0.0, ptr %v3015
	%v3019 = getelementptr [1005 x float], ptr %v72, i32 0, i32 736
	store float 0.0, ptr %v3019
	%v3023 = getelementptr [1005 x float], ptr %v72, i32 0, i32 737
	store float 0.0, ptr %v3023
	%v3027 = getelementptr [1005 x float], ptr %v72, i32 0, i32 738
	store float 0.0, ptr %v3027
	%v3031 = getelementptr [1005 x float], ptr %v72, i32 0, i32 739
	store float 0.0, ptr %v3031
	%v3035 = getelementptr [1005 x float], ptr %v72, i32 0, i32 740
	store float 0.0, ptr %v3035
	%v3039 = getelementptr [1005 x float], ptr %v72, i32 0, i32 741
	store float 0.0, ptr %v3039
	%v3043 = getelementptr [1005 x float], ptr %v72, i32 0, i32 742
	store float 0.0, ptr %v3043
	%v3047 = getelementptr [1005 x float], ptr %v72, i32 0, i32 743
	store float 0.0, ptr %v3047
	%v3051 = getelementptr [1005 x float], ptr %v72, i32 0, i32 744
	store float 0.0, ptr %v3051
	%v3055 = getelementptr [1005 x float], ptr %v72, i32 0, i32 745
	store float 0.0, ptr %v3055
	%v3059 = getelementptr [1005 x float], ptr %v72, i32 0, i32 746
	store float 0.0, ptr %v3059
	%v3063 = getelementptr [1005 x float], ptr %v72, i32 0, i32 747
	store float 0.0, ptr %v3063
	%v3067 = getelementptr [1005 x float], ptr %v72, i32 0, i32 748
	store float 0.0, ptr %v3067
	%v3071 = getelementptr [1005 x float], ptr %v72, i32 0, i32 749
	store float 0.0, ptr %v3071
	%v3075 = getelementptr [1005 x float], ptr %v72, i32 0, i32 750
	store float 0.0, ptr %v3075
	%v3079 = getelementptr [1005 x float], ptr %v72, i32 0, i32 751
	store float 0.0, ptr %v3079
	%v3083 = getelementptr [1005 x float], ptr %v72, i32 0, i32 752
	store float 0.0, ptr %v3083
	%v3087 = getelementptr [1005 x float], ptr %v72, i32 0, i32 753
	store float 0.0, ptr %v3087
	%v3091 = getelementptr [1005 x float], ptr %v72, i32 0, i32 754
	store float 0.0, ptr %v3091
	%v3095 = getelementptr [1005 x float], ptr %v72, i32 0, i32 755
	store float 0.0, ptr %v3095
	%v3099 = getelementptr [1005 x float], ptr %v72, i32 0, i32 756
	store float 0.0, ptr %v3099
	%v3103 = getelementptr [1005 x float], ptr %v72, i32 0, i32 757
	store float 0.0, ptr %v3103
	%v3107 = getelementptr [1005 x float], ptr %v72, i32 0, i32 758
	store float 0.0, ptr %v3107
	%v3111 = getelementptr [1005 x float], ptr %v72, i32 0, i32 759
	store float 0.0, ptr %v3111
	%v3115 = getelementptr [1005 x float], ptr %v72, i32 0, i32 760
	store float 0.0, ptr %v3115
	%v3119 = getelementptr [1005 x float], ptr %v72, i32 0, i32 761
	store float 0.0, ptr %v3119
	%v3123 = getelementptr [1005 x float], ptr %v72, i32 0, i32 762
	store float 0.0, ptr %v3123
	%v3127 = getelementptr [1005 x float], ptr %v72, i32 0, i32 763
	store float 0.0, ptr %v3127
	%v3131 = getelementptr [1005 x float], ptr %v72, i32 0, i32 764
	store float 0.0, ptr %v3131
	%v3135 = getelementptr [1005 x float], ptr %v72, i32 0, i32 765
	store float 0.0, ptr %v3135
	%v3139 = getelementptr [1005 x float], ptr %v72, i32 0, i32 766
	store float 0.0, ptr %v3139
	%v3143 = getelementptr [1005 x float], ptr %v72, i32 0, i32 767
	store float 0.0, ptr %v3143
	%v3147 = getelementptr [1005 x float], ptr %v72, i32 0, i32 768
	store float 0.0, ptr %v3147
	%v3151 = getelementptr [1005 x float], ptr %v72, i32 0, i32 769
	store float 0.0, ptr %v3151
	%v3155 = getelementptr [1005 x float], ptr %v72, i32 0, i32 770
	store float 0.0, ptr %v3155
	%v3159 = getelementptr [1005 x float], ptr %v72, i32 0, i32 771
	store float 0.0, ptr %v3159
	%v3163 = getelementptr [1005 x float], ptr %v72, i32 0, i32 772
	store float 0.0, ptr %v3163
	%v3167 = getelementptr [1005 x float], ptr %v72, i32 0, i32 773
	store float 0.0, ptr %v3167
	%v3171 = getelementptr [1005 x float], ptr %v72, i32 0, i32 774
	store float 0.0, ptr %v3171
	%v3175 = getelementptr [1005 x float], ptr %v72, i32 0, i32 775
	store float 0.0, ptr %v3175
	%v3179 = getelementptr [1005 x float], ptr %v72, i32 0, i32 776
	store float 0.0, ptr %v3179
	%v3183 = getelementptr [1005 x float], ptr %v72, i32 0, i32 777
	store float 0.0, ptr %v3183
	%v3187 = getelementptr [1005 x float], ptr %v72, i32 0, i32 778
	store float 0.0, ptr %v3187
	%v3191 = getelementptr [1005 x float], ptr %v72, i32 0, i32 779
	store float 0.0, ptr %v3191
	%v3195 = getelementptr [1005 x float], ptr %v72, i32 0, i32 780
	store float 0.0, ptr %v3195
	%v3199 = getelementptr [1005 x float], ptr %v72, i32 0, i32 781
	store float 0.0, ptr %v3199
	%v3203 = getelementptr [1005 x float], ptr %v72, i32 0, i32 782
	store float 0.0, ptr %v3203
	%v3207 = getelementptr [1005 x float], ptr %v72, i32 0, i32 783
	store float 0.0, ptr %v3207
	%v3211 = getelementptr [1005 x float], ptr %v72, i32 0, i32 784
	store float 0.0, ptr %v3211
	%v3215 = getelementptr [1005 x float], ptr %v72, i32 0, i32 785
	store float 0.0, ptr %v3215
	%v3219 = getelementptr [1005 x float], ptr %v72, i32 0, i32 786
	store float 0.0, ptr %v3219
	%v3223 = getelementptr [1005 x float], ptr %v72, i32 0, i32 787
	store float 0.0, ptr %v3223
	%v3227 = getelementptr [1005 x float], ptr %v72, i32 0, i32 788
	store float 0.0, ptr %v3227
	%v3231 = getelementptr [1005 x float], ptr %v72, i32 0, i32 789
	store float 0.0, ptr %v3231
	%v3235 = getelementptr [1005 x float], ptr %v72, i32 0, i32 790
	store float 0.0, ptr %v3235
	%v3239 = getelementptr [1005 x float], ptr %v72, i32 0, i32 791
	store float 0.0, ptr %v3239
	%v3243 = getelementptr [1005 x float], ptr %v72, i32 0, i32 792
	store float 0.0, ptr %v3243
	%v3247 = getelementptr [1005 x float], ptr %v72, i32 0, i32 793
	store float 0.0, ptr %v3247
	%v3251 = getelementptr [1005 x float], ptr %v72, i32 0, i32 794
	store float 0.0, ptr %v3251
	%v3255 = getelementptr [1005 x float], ptr %v72, i32 0, i32 795
	store float 0.0, ptr %v3255
	%v3259 = getelementptr [1005 x float], ptr %v72, i32 0, i32 796
	store float 0.0, ptr %v3259
	%v3263 = getelementptr [1005 x float], ptr %v72, i32 0, i32 797
	store float 0.0, ptr %v3263
	%v3267 = getelementptr [1005 x float], ptr %v72, i32 0, i32 798
	store float 0.0, ptr %v3267
	%v3271 = getelementptr [1005 x float], ptr %v72, i32 0, i32 799
	store float 0.0, ptr %v3271
	%v3275 = getelementptr [1005 x float], ptr %v72, i32 0, i32 800
	store float 0.0, ptr %v3275
	%v3279 = getelementptr [1005 x float], ptr %v72, i32 0, i32 801
	store float 0.0, ptr %v3279
	%v3283 = getelementptr [1005 x float], ptr %v72, i32 0, i32 802
	store float 0.0, ptr %v3283
	%v3287 = getelementptr [1005 x float], ptr %v72, i32 0, i32 803
	store float 0.0, ptr %v3287
	%v3291 = getelementptr [1005 x float], ptr %v72, i32 0, i32 804
	store float 0.0, ptr %v3291
	%v3295 = getelementptr [1005 x float], ptr %v72, i32 0, i32 805
	store float 0.0, ptr %v3295
	%v3299 = getelementptr [1005 x float], ptr %v72, i32 0, i32 806
	store float 0.0, ptr %v3299
	%v3303 = getelementptr [1005 x float], ptr %v72, i32 0, i32 807
	store float 0.0, ptr %v3303
	%v3307 = getelementptr [1005 x float], ptr %v72, i32 0, i32 808
	store float 0.0, ptr %v3307
	%v3311 = getelementptr [1005 x float], ptr %v72, i32 0, i32 809
	store float 0.0, ptr %v3311
	%v3315 = getelementptr [1005 x float], ptr %v72, i32 0, i32 810
	store float 0.0, ptr %v3315
	%v3319 = getelementptr [1005 x float], ptr %v72, i32 0, i32 811
	store float 0.0, ptr %v3319
	%v3323 = getelementptr [1005 x float], ptr %v72, i32 0, i32 812
	store float 0.0, ptr %v3323
	%v3327 = getelementptr [1005 x float], ptr %v72, i32 0, i32 813
	store float 0.0, ptr %v3327
	%v3331 = getelementptr [1005 x float], ptr %v72, i32 0, i32 814
	store float 0.0, ptr %v3331
	%v3335 = getelementptr [1005 x float], ptr %v72, i32 0, i32 815
	store float 0.0, ptr %v3335
	%v3339 = getelementptr [1005 x float], ptr %v72, i32 0, i32 816
	store float 0.0, ptr %v3339
	%v3343 = getelementptr [1005 x float], ptr %v72, i32 0, i32 817
	store float 0.0, ptr %v3343
	%v3347 = getelementptr [1005 x float], ptr %v72, i32 0, i32 818
	store float 0.0, ptr %v3347
	%v3351 = getelementptr [1005 x float], ptr %v72, i32 0, i32 819
	store float 0.0, ptr %v3351
	%v3355 = getelementptr [1005 x float], ptr %v72, i32 0, i32 820
	store float 0.0, ptr %v3355
	%v3359 = getelementptr [1005 x float], ptr %v72, i32 0, i32 821
	store float 0.0, ptr %v3359
	%v3363 = getelementptr [1005 x float], ptr %v72, i32 0, i32 822
	store float 0.0, ptr %v3363
	%v3367 = getelementptr [1005 x float], ptr %v72, i32 0, i32 823
	store float 0.0, ptr %v3367
	%v3371 = getelementptr [1005 x float], ptr %v72, i32 0, i32 824
	store float 0.0, ptr %v3371
	%v3375 = getelementptr [1005 x float], ptr %v72, i32 0, i32 825
	store float 0.0, ptr %v3375
	%v3379 = getelementptr [1005 x float], ptr %v72, i32 0, i32 826
	store float 0.0, ptr %v3379
	%v3383 = getelementptr [1005 x float], ptr %v72, i32 0, i32 827
	store float 0.0, ptr %v3383
	%v3387 = getelementptr [1005 x float], ptr %v72, i32 0, i32 828
	store float 0.0, ptr %v3387
	%v3391 = getelementptr [1005 x float], ptr %v72, i32 0, i32 829
	store float 0.0, ptr %v3391
	%v3395 = getelementptr [1005 x float], ptr %v72, i32 0, i32 830
	store float 0.0, ptr %v3395
	%v3399 = getelementptr [1005 x float], ptr %v72, i32 0, i32 831
	store float 0.0, ptr %v3399
	%v3403 = getelementptr [1005 x float], ptr %v72, i32 0, i32 832
	store float 0.0, ptr %v3403
	%v3407 = getelementptr [1005 x float], ptr %v72, i32 0, i32 833
	store float 0.0, ptr %v3407
	%v3411 = getelementptr [1005 x float], ptr %v72, i32 0, i32 834
	store float 0.0, ptr %v3411
	%v3415 = getelementptr [1005 x float], ptr %v72, i32 0, i32 835
	store float 0.0, ptr %v3415
	%v3419 = getelementptr [1005 x float], ptr %v72, i32 0, i32 836
	store float 0.0, ptr %v3419
	%v3423 = getelementptr [1005 x float], ptr %v72, i32 0, i32 837
	store float 0.0, ptr %v3423
	%v3427 = getelementptr [1005 x float], ptr %v72, i32 0, i32 838
	store float 0.0, ptr %v3427
	%v3431 = getelementptr [1005 x float], ptr %v72, i32 0, i32 839
	store float 0.0, ptr %v3431
	%v3435 = getelementptr [1005 x float], ptr %v72, i32 0, i32 840
	store float 0.0, ptr %v3435
	%v3439 = getelementptr [1005 x float], ptr %v72, i32 0, i32 841
	store float 0.0, ptr %v3439
	%v3443 = getelementptr [1005 x float], ptr %v72, i32 0, i32 842
	store float 0.0, ptr %v3443
	%v3447 = getelementptr [1005 x float], ptr %v72, i32 0, i32 843
	store float 0.0, ptr %v3447
	%v3451 = getelementptr [1005 x float], ptr %v72, i32 0, i32 844
	store float 0.0, ptr %v3451
	%v3455 = getelementptr [1005 x float], ptr %v72, i32 0, i32 845
	store float 0.0, ptr %v3455
	%v3459 = getelementptr [1005 x float], ptr %v72, i32 0, i32 846
	store float 0.0, ptr %v3459
	%v3463 = getelementptr [1005 x float], ptr %v72, i32 0, i32 847
	store float 0.0, ptr %v3463
	%v3467 = getelementptr [1005 x float], ptr %v72, i32 0, i32 848
	store float 0.0, ptr %v3467
	%v3471 = getelementptr [1005 x float], ptr %v72, i32 0, i32 849
	store float 0.0, ptr %v3471
	%v3475 = getelementptr [1005 x float], ptr %v72, i32 0, i32 850
	store float 0.0, ptr %v3475
	%v3479 = getelementptr [1005 x float], ptr %v72, i32 0, i32 851
	store float 0.0, ptr %v3479
	%v3483 = getelementptr [1005 x float], ptr %v72, i32 0, i32 852
	store float 0.0, ptr %v3483
	%v3487 = getelementptr [1005 x float], ptr %v72, i32 0, i32 853
	store float 0.0, ptr %v3487
	%v3491 = getelementptr [1005 x float], ptr %v72, i32 0, i32 854
	store float 0.0, ptr %v3491
	%v3495 = getelementptr [1005 x float], ptr %v72, i32 0, i32 855
	store float 0.0, ptr %v3495
	%v3499 = getelementptr [1005 x float], ptr %v72, i32 0, i32 856
	store float 0.0, ptr %v3499
	%v3503 = getelementptr [1005 x float], ptr %v72, i32 0, i32 857
	store float 0.0, ptr %v3503
	%v3507 = getelementptr [1005 x float], ptr %v72, i32 0, i32 858
	store float 0.0, ptr %v3507
	%v3511 = getelementptr [1005 x float], ptr %v72, i32 0, i32 859
	store float 0.0, ptr %v3511
	%v3515 = getelementptr [1005 x float], ptr %v72, i32 0, i32 860
	store float 0.0, ptr %v3515
	%v3519 = getelementptr [1005 x float], ptr %v72, i32 0, i32 861
	store float 0.0, ptr %v3519
	%v3523 = getelementptr [1005 x float], ptr %v72, i32 0, i32 862
	store float 0.0, ptr %v3523
	%v3527 = getelementptr [1005 x float], ptr %v72, i32 0, i32 863
	store float 0.0, ptr %v3527
	%v3531 = getelementptr [1005 x float], ptr %v72, i32 0, i32 864
	store float 0.0, ptr %v3531
	%v3535 = getelementptr [1005 x float], ptr %v72, i32 0, i32 865
	store float 0.0, ptr %v3535
	%v3539 = getelementptr [1005 x float], ptr %v72, i32 0, i32 866
	store float 0.0, ptr %v3539
	%v3543 = getelementptr [1005 x float], ptr %v72, i32 0, i32 867
	store float 0.0, ptr %v3543
	%v3547 = getelementptr [1005 x float], ptr %v72, i32 0, i32 868
	store float 0.0, ptr %v3547
	%v3551 = getelementptr [1005 x float], ptr %v72, i32 0, i32 869
	store float 0.0, ptr %v3551
	%v3555 = getelementptr [1005 x float], ptr %v72, i32 0, i32 870
	store float 0.0, ptr %v3555
	%v3559 = getelementptr [1005 x float], ptr %v72, i32 0, i32 871
	store float 0.0, ptr %v3559
	%v3563 = getelementptr [1005 x float], ptr %v72, i32 0, i32 872
	store float 0.0, ptr %v3563
	%v3567 = getelementptr [1005 x float], ptr %v72, i32 0, i32 873
	store float 0.0, ptr %v3567
	%v3571 = getelementptr [1005 x float], ptr %v72, i32 0, i32 874
	store float 0.0, ptr %v3571
	%v3575 = getelementptr [1005 x float], ptr %v72, i32 0, i32 875
	store float 0.0, ptr %v3575
	%v3579 = getelementptr [1005 x float], ptr %v72, i32 0, i32 876
	store float 0.0, ptr %v3579
	%v3583 = getelementptr [1005 x float], ptr %v72, i32 0, i32 877
	store float 0.0, ptr %v3583
	%v3587 = getelementptr [1005 x float], ptr %v72, i32 0, i32 878
	store float 0.0, ptr %v3587
	%v3591 = getelementptr [1005 x float], ptr %v72, i32 0, i32 879
	store float 0.0, ptr %v3591
	%v3595 = getelementptr [1005 x float], ptr %v72, i32 0, i32 880
	store float 0.0, ptr %v3595
	%v3599 = getelementptr [1005 x float], ptr %v72, i32 0, i32 881
	store float 0.0, ptr %v3599
	%v3603 = getelementptr [1005 x float], ptr %v72, i32 0, i32 882
	store float 0.0, ptr %v3603
	%v3607 = getelementptr [1005 x float], ptr %v72, i32 0, i32 883
	store float 0.0, ptr %v3607
	%v3611 = getelementptr [1005 x float], ptr %v72, i32 0, i32 884
	store float 0.0, ptr %v3611
	%v3615 = getelementptr [1005 x float], ptr %v72, i32 0, i32 885
	store float 0.0, ptr %v3615
	%v3619 = getelementptr [1005 x float], ptr %v72, i32 0, i32 886
	store float 0.0, ptr %v3619
	%v3623 = getelementptr [1005 x float], ptr %v72, i32 0, i32 887
	store float 0.0, ptr %v3623
	%v3627 = getelementptr [1005 x float], ptr %v72, i32 0, i32 888
	store float 0.0, ptr %v3627
	%v3631 = getelementptr [1005 x float], ptr %v72, i32 0, i32 889
	store float 0.0, ptr %v3631
	%v3635 = getelementptr [1005 x float], ptr %v72, i32 0, i32 890
	store float 0.0, ptr %v3635
	%v3639 = getelementptr [1005 x float], ptr %v72, i32 0, i32 891
	store float 0.0, ptr %v3639
	%v3643 = getelementptr [1005 x float], ptr %v72, i32 0, i32 892
	store float 0.0, ptr %v3643
	%v3647 = getelementptr [1005 x float], ptr %v72, i32 0, i32 893
	store float 0.0, ptr %v3647
	%v3651 = getelementptr [1005 x float], ptr %v72, i32 0, i32 894
	store float 0.0, ptr %v3651
	%v3655 = getelementptr [1005 x float], ptr %v72, i32 0, i32 895
	store float 0.0, ptr %v3655
	%v3659 = getelementptr [1005 x float], ptr %v72, i32 0, i32 896
	store float 0.0, ptr %v3659
	%v3663 = getelementptr [1005 x float], ptr %v72, i32 0, i32 897
	store float 0.0, ptr %v3663
	%v3667 = getelementptr [1005 x float], ptr %v72, i32 0, i32 898
	store float 0.0, ptr %v3667
	%v3671 = getelementptr [1005 x float], ptr %v72, i32 0, i32 899
	store float 0.0, ptr %v3671
	%v3675 = getelementptr [1005 x float], ptr %v72, i32 0, i32 900
	store float 0.0, ptr %v3675
	%v3679 = getelementptr [1005 x float], ptr %v72, i32 0, i32 901
	store float 0.0, ptr %v3679
	%v3683 = getelementptr [1005 x float], ptr %v72, i32 0, i32 902
	store float 0.0, ptr %v3683
	%v3687 = getelementptr [1005 x float], ptr %v72, i32 0, i32 903
	store float 0.0, ptr %v3687
	%v3691 = getelementptr [1005 x float], ptr %v72, i32 0, i32 904
	store float 0.0, ptr %v3691
	%v3695 = getelementptr [1005 x float], ptr %v72, i32 0, i32 905
	store float 0.0, ptr %v3695
	%v3699 = getelementptr [1005 x float], ptr %v72, i32 0, i32 906
	store float 0.0, ptr %v3699
	%v3703 = getelementptr [1005 x float], ptr %v72, i32 0, i32 907
	store float 0.0, ptr %v3703
	%v3707 = getelementptr [1005 x float], ptr %v72, i32 0, i32 908
	store float 0.0, ptr %v3707
	%v3711 = getelementptr [1005 x float], ptr %v72, i32 0, i32 909
	store float 0.0, ptr %v3711
	%v3715 = getelementptr [1005 x float], ptr %v72, i32 0, i32 910
	store float 0.0, ptr %v3715
	%v3719 = getelementptr [1005 x float], ptr %v72, i32 0, i32 911
	store float 0.0, ptr %v3719
	%v3723 = getelementptr [1005 x float], ptr %v72, i32 0, i32 912
	store float 0.0, ptr %v3723
	%v3727 = getelementptr [1005 x float], ptr %v72, i32 0, i32 913
	store float 0.0, ptr %v3727
	%v3731 = getelementptr [1005 x float], ptr %v72, i32 0, i32 914
	store float 0.0, ptr %v3731
	%v3735 = getelementptr [1005 x float], ptr %v72, i32 0, i32 915
	store float 0.0, ptr %v3735
	%v3739 = getelementptr [1005 x float], ptr %v72, i32 0, i32 916
	store float 0.0, ptr %v3739
	%v3743 = getelementptr [1005 x float], ptr %v72, i32 0, i32 917
	store float 0.0, ptr %v3743
	%v3747 = getelementptr [1005 x float], ptr %v72, i32 0, i32 918
	store float 0.0, ptr %v3747
	%v3751 = getelementptr [1005 x float], ptr %v72, i32 0, i32 919
	store float 0.0, ptr %v3751
	%v3755 = getelementptr [1005 x float], ptr %v72, i32 0, i32 920
	store float 0.0, ptr %v3755
	%v3759 = getelementptr [1005 x float], ptr %v72, i32 0, i32 921
	store float 0.0, ptr %v3759
	%v3763 = getelementptr [1005 x float], ptr %v72, i32 0, i32 922
	store float 0.0, ptr %v3763
	%v3767 = getelementptr [1005 x float], ptr %v72, i32 0, i32 923
	store float 0.0, ptr %v3767
	%v3771 = getelementptr [1005 x float], ptr %v72, i32 0, i32 924
	store float 0.0, ptr %v3771
	%v3775 = getelementptr [1005 x float], ptr %v72, i32 0, i32 925
	store float 0.0, ptr %v3775
	%v3779 = getelementptr [1005 x float], ptr %v72, i32 0, i32 926
	store float 0.0, ptr %v3779
	%v3783 = getelementptr [1005 x float], ptr %v72, i32 0, i32 927
	store float 0.0, ptr %v3783
	%v3787 = getelementptr [1005 x float], ptr %v72, i32 0, i32 928
	store float 0.0, ptr %v3787
	%v3791 = getelementptr [1005 x float], ptr %v72, i32 0, i32 929
	store float 0.0, ptr %v3791
	%v3795 = getelementptr [1005 x float], ptr %v72, i32 0, i32 930
	store float 0.0, ptr %v3795
	%v3799 = getelementptr [1005 x float], ptr %v72, i32 0, i32 931
	store float 0.0, ptr %v3799
	%v3803 = getelementptr [1005 x float], ptr %v72, i32 0, i32 932
	store float 0.0, ptr %v3803
	%v3807 = getelementptr [1005 x float], ptr %v72, i32 0, i32 933
	store float 0.0, ptr %v3807
	%v3811 = getelementptr [1005 x float], ptr %v72, i32 0, i32 934
	store float 0.0, ptr %v3811
	%v3815 = getelementptr [1005 x float], ptr %v72, i32 0, i32 935
	store float 0.0, ptr %v3815
	%v3819 = getelementptr [1005 x float], ptr %v72, i32 0, i32 936
	store float 0.0, ptr %v3819
	%v3823 = getelementptr [1005 x float], ptr %v72, i32 0, i32 937
	store float 0.0, ptr %v3823
	%v3827 = getelementptr [1005 x float], ptr %v72, i32 0, i32 938
	store float 0.0, ptr %v3827
	%v3831 = getelementptr [1005 x float], ptr %v72, i32 0, i32 939
	store float 0.0, ptr %v3831
	%v3835 = getelementptr [1005 x float], ptr %v72, i32 0, i32 940
	store float 0.0, ptr %v3835
	%v3839 = getelementptr [1005 x float], ptr %v72, i32 0, i32 941
	store float 0.0, ptr %v3839
	%v3843 = getelementptr [1005 x float], ptr %v72, i32 0, i32 942
	store float 0.0, ptr %v3843
	%v3847 = getelementptr [1005 x float], ptr %v72, i32 0, i32 943
	store float 0.0, ptr %v3847
	%v3851 = getelementptr [1005 x float], ptr %v72, i32 0, i32 944
	store float 0.0, ptr %v3851
	%v3855 = getelementptr [1005 x float], ptr %v72, i32 0, i32 945
	store float 0.0, ptr %v3855
	%v3859 = getelementptr [1005 x float], ptr %v72, i32 0, i32 946
	store float 0.0, ptr %v3859
	%v3863 = getelementptr [1005 x float], ptr %v72, i32 0, i32 947
	store float 0.0, ptr %v3863
	%v3867 = getelementptr [1005 x float], ptr %v72, i32 0, i32 948
	store float 0.0, ptr %v3867
	%v3871 = getelementptr [1005 x float], ptr %v72, i32 0, i32 949
	store float 0.0, ptr %v3871
	%v3875 = getelementptr [1005 x float], ptr %v72, i32 0, i32 950
	store float 0.0, ptr %v3875
	%v3879 = getelementptr [1005 x float], ptr %v72, i32 0, i32 951
	store float 0.0, ptr %v3879
	%v3883 = getelementptr [1005 x float], ptr %v72, i32 0, i32 952
	store float 0.0, ptr %v3883
	%v3887 = getelementptr [1005 x float], ptr %v72, i32 0, i32 953
	store float 0.0, ptr %v3887
	%v3891 = getelementptr [1005 x float], ptr %v72, i32 0, i32 954
	store float 0.0, ptr %v3891
	%v3895 = getelementptr [1005 x float], ptr %v72, i32 0, i32 955
	store float 0.0, ptr %v3895
	%v3899 = getelementptr [1005 x float], ptr %v72, i32 0, i32 956
	store float 0.0, ptr %v3899
	%v3903 = getelementptr [1005 x float], ptr %v72, i32 0, i32 957
	store float 0.0, ptr %v3903
	%v3907 = getelementptr [1005 x float], ptr %v72, i32 0, i32 958
	store float 0.0, ptr %v3907
	%v3911 = getelementptr [1005 x float], ptr %v72, i32 0, i32 959
	store float 0.0, ptr %v3911
	%v3915 = getelementptr [1005 x float], ptr %v72, i32 0, i32 960
	store float 0.0, ptr %v3915
	%v3919 = getelementptr [1005 x float], ptr %v72, i32 0, i32 961
	store float 0.0, ptr %v3919
	%v3923 = getelementptr [1005 x float], ptr %v72, i32 0, i32 962
	store float 0.0, ptr %v3923
	%v3927 = getelementptr [1005 x float], ptr %v72, i32 0, i32 963
	store float 0.0, ptr %v3927
	%v3931 = getelementptr [1005 x float], ptr %v72, i32 0, i32 964
	store float 0.0, ptr %v3931
	%v3935 = getelementptr [1005 x float], ptr %v72, i32 0, i32 965
	store float 0.0, ptr %v3935
	%v3939 = getelementptr [1005 x float], ptr %v72, i32 0, i32 966
	store float 0.0, ptr %v3939
	%v3943 = getelementptr [1005 x float], ptr %v72, i32 0, i32 967
	store float 0.0, ptr %v3943
	%v3947 = getelementptr [1005 x float], ptr %v72, i32 0, i32 968
	store float 0.0, ptr %v3947
	%v3951 = getelementptr [1005 x float], ptr %v72, i32 0, i32 969
	store float 0.0, ptr %v3951
	%v3955 = getelementptr [1005 x float], ptr %v72, i32 0, i32 970
	store float 0.0, ptr %v3955
	%v3959 = getelementptr [1005 x float], ptr %v72, i32 0, i32 971
	store float 0.0, ptr %v3959
	%v3963 = getelementptr [1005 x float], ptr %v72, i32 0, i32 972
	store float 0.0, ptr %v3963
	%v3967 = getelementptr [1005 x float], ptr %v72, i32 0, i32 973
	store float 0.0, ptr %v3967
	%v3971 = getelementptr [1005 x float], ptr %v72, i32 0, i32 974
	store float 0.0, ptr %v3971
	%v3975 = getelementptr [1005 x float], ptr %v72, i32 0, i32 975
	store float 0.0, ptr %v3975
	%v3979 = getelementptr [1005 x float], ptr %v72, i32 0, i32 976
	store float 0.0, ptr %v3979
	%v3983 = getelementptr [1005 x float], ptr %v72, i32 0, i32 977
	store float 0.0, ptr %v3983
	%v3987 = getelementptr [1005 x float], ptr %v72, i32 0, i32 978
	store float 0.0, ptr %v3987
	%v3991 = getelementptr [1005 x float], ptr %v72, i32 0, i32 979
	store float 0.0, ptr %v3991
	%v3995 = getelementptr [1005 x float], ptr %v72, i32 0, i32 980
	store float 0.0, ptr %v3995
	%v3999 = getelementptr [1005 x float], ptr %v72, i32 0, i32 981
	store float 0.0, ptr %v3999
	%v4003 = getelementptr [1005 x float], ptr %v72, i32 0, i32 982
	store float 0.0, ptr %v4003
	%v4007 = getelementptr [1005 x float], ptr %v72, i32 0, i32 983
	store float 0.0, ptr %v4007
	%v4011 = getelementptr [1005 x float], ptr %v72, i32 0, i32 984
	store float 0.0, ptr %v4011
	%v4015 = getelementptr [1005 x float], ptr %v72, i32 0, i32 985
	store float 0.0, ptr %v4015
	%v4019 = getelementptr [1005 x float], ptr %v72, i32 0, i32 986
	store float 0.0, ptr %v4019
	%v4023 = getelementptr [1005 x float], ptr %v72, i32 0, i32 987
	store float 0.0, ptr %v4023
	%v4027 = getelementptr [1005 x float], ptr %v72, i32 0, i32 988
	store float 0.0, ptr %v4027
	%v4031 = getelementptr [1005 x float], ptr %v72, i32 0, i32 989
	store float 0.0, ptr %v4031
	%v4035 = getelementptr [1005 x float], ptr %v72, i32 0, i32 990
	store float 0.0, ptr %v4035
	%v4039 = getelementptr [1005 x float], ptr %v72, i32 0, i32 991
	store float 0.0, ptr %v4039
	%v4043 = getelementptr [1005 x float], ptr %v72, i32 0, i32 992
	store float 0.0, ptr %v4043
	%v4047 = getelementptr [1005 x float], ptr %v72, i32 0, i32 993
	store float 0.0, ptr %v4047
	%v4051 = getelementptr [1005 x float], ptr %v72, i32 0, i32 994
	store float 0.0, ptr %v4051
	%v4055 = getelementptr [1005 x float], ptr %v72, i32 0, i32 995
	store float 0.0, ptr %v4055
	%v4059 = getelementptr [1005 x float], ptr %v72, i32 0, i32 996
	store float 0.0, ptr %v4059
	%v4063 = getelementptr [1005 x float], ptr %v72, i32 0, i32 997
	store float 0.0, ptr %v4063
	%v4067 = getelementptr [1005 x float], ptr %v72, i32 0, i32 998
	store float 0.0, ptr %v4067
	%v4071 = getelementptr [1005 x float], ptr %v72, i32 0, i32 999
	store float 0.0, ptr %v4071
	%v4075 = getelementptr [1005 x float], ptr %v72, i32 0, i32 1000
	store float 0.0, ptr %v4075
	%v4079 = getelementptr [1005 x float], ptr %v72, i32 0, i32 1001
	store float 0.0, ptr %v4079
	%v4083 = getelementptr [1005 x float], ptr %v72, i32 0, i32 1002
	store float 0.0, ptr %v4083
	%v4087 = getelementptr [1005 x float], ptr %v72, i32 0, i32 1003
	store float 0.0, ptr %v4087
	%v4091 = getelementptr [1005 x float], ptr %v72, i32 0, i32 1004
	store float 0.0, ptr %v4091
	store i32 0, ptr %v4093
	br label %bb_4
bb_4:
	%v4095 = load i32, ptr %v4093
	%v4097 = load i32, ptr @__GLOBAL_VAR_n
	%v4098 = icmp slt i32 %v4095, %v4097
	br i1 %v4098, label %bb_5, label %bb_6
bb_5:
	%v4100 = load i32, ptr %v4093
	%v4101 = getelementptr [1005 x float], ptr %v72, i32 0, i32 %v4100
	%v4103 = load i32, ptr %v4093
	%v4104 = getelementptr float, float* %v21, i32 %v4103
	%v4105 = load float, ptr %v4104
	%v4106 = load float, ptr %v23
	%v4107 = fadd float %v4105, %v4106
	%v4108 = load float, ptr %v24
	%v4109 = fadd float %v4107, %v4108
	%v4110 = load float, ptr %v25
	%v4111 = fadd float %v4109, %v4110
	store float %v4111, ptr %v4101
	%v4112 = load i32, ptr %v4093
	%v4114 = add i32 %v4112, 1
	store i32 %v4114, ptr %v4093
	br label %bb_4
bb_6:
	%v4115 = alloca i1
	%v4116 = load i32, ptr %v22
	%v4118 = add i32 %v4116, 1
	%v4120 = load i32, ptr %v22
	%v4121 = getelementptr float, float* %v21, i32 %v4120
	%v4122 = load float, ptr %v4121
	%v4125 = load i32, ptr %v22
	%v4126 = getelementptr [1005 x float], ptr @__GLOBAL_VAR_a, i32 0, i32 %v4125
	%v4127 = load float, ptr %v4126
	%v4128 = load float, ptr %v23
	%v4130 = sitofp i32 2 to float
	%v4131 = load float, ptr %v24
	%v4132 = fmul float %v4130, %v4131
	%v4133 = fadd float %v4128, %v4132
	%v4135 = sitofp i32 1 to float
	%v4136 = fadd float %v4133, %v4135
	%v4137 = fmul float %v4127, %v4136
	%v4140 = load i32, ptr %v22
	%v4141 = getelementptr [1005 x float], ptr @__GLOBAL_VAR_ff, i32 0, i32 %v4140
	%v4142 = load float, ptr %v4141
	%v4143 = call float  @DFS(i32 %v4118, float %v4122, float %v4137, float %v4142, ptr %v72)
	store float %v4143, ptr %v26
	br label %bb_1
bb_1:
	%v4144 = load float, ptr %v26
	ret float %v4144
}
define i32 @main() {
bb_7:
	%v8186 = alloca float
	%v4148 = alloca [1005 x float]
	%v4145 = alloca i32
	%v4147 = call float  @getfarray(ptr @__GLOBAL_VAR_a)
	%v4151 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 0
	store float 0.0, ptr %v4151
	%v4155 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 1
	store float 0.0, ptr %v4155
	%v4159 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 2
	store float 0.0, ptr %v4159
	%v4163 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 3
	store float 0.0, ptr %v4163
	%v4167 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 4
	store float 0.0, ptr %v4167
	%v4171 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 5
	store float 0.0, ptr %v4171
	%v4175 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 6
	store float 0.0, ptr %v4175
	%v4179 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 7
	store float 0.0, ptr %v4179
	%v4183 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 8
	store float 0.0, ptr %v4183
	%v4187 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 9
	store float 0.0, ptr %v4187
	%v4191 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 10
	store float 0.0, ptr %v4191
	%v4195 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 11
	store float 0.0, ptr %v4195
	%v4199 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 12
	store float 0.0, ptr %v4199
	%v4203 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 13
	store float 0.0, ptr %v4203
	%v4207 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 14
	store float 0.0, ptr %v4207
	%v4211 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 15
	store float 0.0, ptr %v4211
	%v4215 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 16
	store float 0.0, ptr %v4215
	%v4219 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 17
	store float 0.0, ptr %v4219
	%v4223 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 18
	store float 0.0, ptr %v4223
	%v4227 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 19
	store float 0.0, ptr %v4227
	%v4231 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 20
	store float 0.0, ptr %v4231
	%v4235 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 21
	store float 0.0, ptr %v4235
	%v4239 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 22
	store float 0.0, ptr %v4239
	%v4243 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 23
	store float 0.0, ptr %v4243
	%v4247 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 24
	store float 0.0, ptr %v4247
	%v4251 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 25
	store float 0.0, ptr %v4251
	%v4255 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 26
	store float 0.0, ptr %v4255
	%v4259 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 27
	store float 0.0, ptr %v4259
	%v4263 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 28
	store float 0.0, ptr %v4263
	%v4267 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 29
	store float 0.0, ptr %v4267
	%v4271 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 30
	store float 0.0, ptr %v4271
	%v4275 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 31
	store float 0.0, ptr %v4275
	%v4279 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 32
	store float 0.0, ptr %v4279
	%v4283 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 33
	store float 0.0, ptr %v4283
	%v4287 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 34
	store float 0.0, ptr %v4287
	%v4291 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 35
	store float 0.0, ptr %v4291
	%v4295 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 36
	store float 0.0, ptr %v4295
	%v4299 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 37
	store float 0.0, ptr %v4299
	%v4303 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 38
	store float 0.0, ptr %v4303
	%v4307 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 39
	store float 0.0, ptr %v4307
	%v4311 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 40
	store float 0.0, ptr %v4311
	%v4315 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 41
	store float 0.0, ptr %v4315
	%v4319 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 42
	store float 0.0, ptr %v4319
	%v4323 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 43
	store float 0.0, ptr %v4323
	%v4327 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 44
	store float 0.0, ptr %v4327
	%v4331 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 45
	store float 0.0, ptr %v4331
	%v4335 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 46
	store float 0.0, ptr %v4335
	%v4339 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 47
	store float 0.0, ptr %v4339
	%v4343 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 48
	store float 0.0, ptr %v4343
	%v4347 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 49
	store float 0.0, ptr %v4347
	%v4351 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 50
	store float 0.0, ptr %v4351
	%v4355 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 51
	store float 0.0, ptr %v4355
	%v4359 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 52
	store float 0.0, ptr %v4359
	%v4363 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 53
	store float 0.0, ptr %v4363
	%v4367 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 54
	store float 0.0, ptr %v4367
	%v4371 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 55
	store float 0.0, ptr %v4371
	%v4375 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 56
	store float 0.0, ptr %v4375
	%v4379 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 57
	store float 0.0, ptr %v4379
	%v4383 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 58
	store float 0.0, ptr %v4383
	%v4387 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 59
	store float 0.0, ptr %v4387
	%v4391 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 60
	store float 0.0, ptr %v4391
	%v4395 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 61
	store float 0.0, ptr %v4395
	%v4399 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 62
	store float 0.0, ptr %v4399
	%v4403 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 63
	store float 0.0, ptr %v4403
	%v4407 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 64
	store float 0.0, ptr %v4407
	%v4411 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 65
	store float 0.0, ptr %v4411
	%v4415 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 66
	store float 0.0, ptr %v4415
	%v4419 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 67
	store float 0.0, ptr %v4419
	%v4423 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 68
	store float 0.0, ptr %v4423
	%v4427 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 69
	store float 0.0, ptr %v4427
	%v4431 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 70
	store float 0.0, ptr %v4431
	%v4435 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 71
	store float 0.0, ptr %v4435
	%v4439 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 72
	store float 0.0, ptr %v4439
	%v4443 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 73
	store float 0.0, ptr %v4443
	%v4447 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 74
	store float 0.0, ptr %v4447
	%v4451 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 75
	store float 0.0, ptr %v4451
	%v4455 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 76
	store float 0.0, ptr %v4455
	%v4459 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 77
	store float 0.0, ptr %v4459
	%v4463 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 78
	store float 0.0, ptr %v4463
	%v4467 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 79
	store float 0.0, ptr %v4467
	%v4471 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 80
	store float 0.0, ptr %v4471
	%v4475 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 81
	store float 0.0, ptr %v4475
	%v4479 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 82
	store float 0.0, ptr %v4479
	%v4483 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 83
	store float 0.0, ptr %v4483
	%v4487 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 84
	store float 0.0, ptr %v4487
	%v4491 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 85
	store float 0.0, ptr %v4491
	%v4495 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 86
	store float 0.0, ptr %v4495
	%v4499 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 87
	store float 0.0, ptr %v4499
	%v4503 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 88
	store float 0.0, ptr %v4503
	%v4507 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 89
	store float 0.0, ptr %v4507
	%v4511 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 90
	store float 0.0, ptr %v4511
	%v4515 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 91
	store float 0.0, ptr %v4515
	%v4519 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 92
	store float 0.0, ptr %v4519
	%v4523 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 93
	store float 0.0, ptr %v4523
	%v4527 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 94
	store float 0.0, ptr %v4527
	%v4531 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 95
	store float 0.0, ptr %v4531
	%v4535 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 96
	store float 0.0, ptr %v4535
	%v4539 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 97
	store float 0.0, ptr %v4539
	%v4543 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 98
	store float 0.0, ptr %v4543
	%v4547 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 99
	store float 0.0, ptr %v4547
	%v4551 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 100
	store float 0.0, ptr %v4551
	%v4555 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 101
	store float 0.0, ptr %v4555
	%v4559 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 102
	store float 0.0, ptr %v4559
	%v4563 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 103
	store float 0.0, ptr %v4563
	%v4567 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 104
	store float 0.0, ptr %v4567
	%v4571 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 105
	store float 0.0, ptr %v4571
	%v4575 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 106
	store float 0.0, ptr %v4575
	%v4579 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 107
	store float 0.0, ptr %v4579
	%v4583 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 108
	store float 0.0, ptr %v4583
	%v4587 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 109
	store float 0.0, ptr %v4587
	%v4591 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 110
	store float 0.0, ptr %v4591
	%v4595 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 111
	store float 0.0, ptr %v4595
	%v4599 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 112
	store float 0.0, ptr %v4599
	%v4603 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 113
	store float 0.0, ptr %v4603
	%v4607 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 114
	store float 0.0, ptr %v4607
	%v4611 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 115
	store float 0.0, ptr %v4611
	%v4615 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 116
	store float 0.0, ptr %v4615
	%v4619 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 117
	store float 0.0, ptr %v4619
	%v4623 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 118
	store float 0.0, ptr %v4623
	%v4627 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 119
	store float 0.0, ptr %v4627
	%v4631 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 120
	store float 0.0, ptr %v4631
	%v4635 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 121
	store float 0.0, ptr %v4635
	%v4639 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 122
	store float 0.0, ptr %v4639
	%v4643 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 123
	store float 0.0, ptr %v4643
	%v4647 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 124
	store float 0.0, ptr %v4647
	%v4651 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 125
	store float 0.0, ptr %v4651
	%v4655 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 126
	store float 0.0, ptr %v4655
	%v4659 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 127
	store float 0.0, ptr %v4659
	%v4663 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 128
	store float 0.0, ptr %v4663
	%v4667 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 129
	store float 0.0, ptr %v4667
	%v4671 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 130
	store float 0.0, ptr %v4671
	%v4675 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 131
	store float 0.0, ptr %v4675
	%v4679 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 132
	store float 0.0, ptr %v4679
	%v4683 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 133
	store float 0.0, ptr %v4683
	%v4687 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 134
	store float 0.0, ptr %v4687
	%v4691 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 135
	store float 0.0, ptr %v4691
	%v4695 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 136
	store float 0.0, ptr %v4695
	%v4699 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 137
	store float 0.0, ptr %v4699
	%v4703 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 138
	store float 0.0, ptr %v4703
	%v4707 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 139
	store float 0.0, ptr %v4707
	%v4711 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 140
	store float 0.0, ptr %v4711
	%v4715 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 141
	store float 0.0, ptr %v4715
	%v4719 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 142
	store float 0.0, ptr %v4719
	%v4723 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 143
	store float 0.0, ptr %v4723
	%v4727 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 144
	store float 0.0, ptr %v4727
	%v4731 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 145
	store float 0.0, ptr %v4731
	%v4735 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 146
	store float 0.0, ptr %v4735
	%v4739 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 147
	store float 0.0, ptr %v4739
	%v4743 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 148
	store float 0.0, ptr %v4743
	%v4747 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 149
	store float 0.0, ptr %v4747
	%v4751 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 150
	store float 0.0, ptr %v4751
	%v4755 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 151
	store float 0.0, ptr %v4755
	%v4759 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 152
	store float 0.0, ptr %v4759
	%v4763 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 153
	store float 0.0, ptr %v4763
	%v4767 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 154
	store float 0.0, ptr %v4767
	%v4771 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 155
	store float 0.0, ptr %v4771
	%v4775 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 156
	store float 0.0, ptr %v4775
	%v4779 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 157
	store float 0.0, ptr %v4779
	%v4783 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 158
	store float 0.0, ptr %v4783
	%v4787 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 159
	store float 0.0, ptr %v4787
	%v4791 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 160
	store float 0.0, ptr %v4791
	%v4795 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 161
	store float 0.0, ptr %v4795
	%v4799 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 162
	store float 0.0, ptr %v4799
	%v4803 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 163
	store float 0.0, ptr %v4803
	%v4807 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 164
	store float 0.0, ptr %v4807
	%v4811 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 165
	store float 0.0, ptr %v4811
	%v4815 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 166
	store float 0.0, ptr %v4815
	%v4819 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 167
	store float 0.0, ptr %v4819
	%v4823 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 168
	store float 0.0, ptr %v4823
	%v4827 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 169
	store float 0.0, ptr %v4827
	%v4831 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 170
	store float 0.0, ptr %v4831
	%v4835 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 171
	store float 0.0, ptr %v4835
	%v4839 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 172
	store float 0.0, ptr %v4839
	%v4843 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 173
	store float 0.0, ptr %v4843
	%v4847 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 174
	store float 0.0, ptr %v4847
	%v4851 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 175
	store float 0.0, ptr %v4851
	%v4855 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 176
	store float 0.0, ptr %v4855
	%v4859 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 177
	store float 0.0, ptr %v4859
	%v4863 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 178
	store float 0.0, ptr %v4863
	%v4867 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 179
	store float 0.0, ptr %v4867
	%v4871 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 180
	store float 0.0, ptr %v4871
	%v4875 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 181
	store float 0.0, ptr %v4875
	%v4879 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 182
	store float 0.0, ptr %v4879
	%v4883 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 183
	store float 0.0, ptr %v4883
	%v4887 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 184
	store float 0.0, ptr %v4887
	%v4891 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 185
	store float 0.0, ptr %v4891
	%v4895 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 186
	store float 0.0, ptr %v4895
	%v4899 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 187
	store float 0.0, ptr %v4899
	%v4903 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 188
	store float 0.0, ptr %v4903
	%v4907 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 189
	store float 0.0, ptr %v4907
	%v4911 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 190
	store float 0.0, ptr %v4911
	%v4915 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 191
	store float 0.0, ptr %v4915
	%v4919 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 192
	store float 0.0, ptr %v4919
	%v4923 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 193
	store float 0.0, ptr %v4923
	%v4927 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 194
	store float 0.0, ptr %v4927
	%v4931 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 195
	store float 0.0, ptr %v4931
	%v4935 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 196
	store float 0.0, ptr %v4935
	%v4939 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 197
	store float 0.0, ptr %v4939
	%v4943 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 198
	store float 0.0, ptr %v4943
	%v4947 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 199
	store float 0.0, ptr %v4947
	%v4951 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 200
	store float 0.0, ptr %v4951
	%v4955 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 201
	store float 0.0, ptr %v4955
	%v4959 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 202
	store float 0.0, ptr %v4959
	%v4963 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 203
	store float 0.0, ptr %v4963
	%v4967 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 204
	store float 0.0, ptr %v4967
	%v4971 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 205
	store float 0.0, ptr %v4971
	%v4975 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 206
	store float 0.0, ptr %v4975
	%v4979 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 207
	store float 0.0, ptr %v4979
	%v4983 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 208
	store float 0.0, ptr %v4983
	%v4987 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 209
	store float 0.0, ptr %v4987
	%v4991 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 210
	store float 0.0, ptr %v4991
	%v4995 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 211
	store float 0.0, ptr %v4995
	%v4999 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 212
	store float 0.0, ptr %v4999
	%v5003 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 213
	store float 0.0, ptr %v5003
	%v5007 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 214
	store float 0.0, ptr %v5007
	%v5011 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 215
	store float 0.0, ptr %v5011
	%v5015 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 216
	store float 0.0, ptr %v5015
	%v5019 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 217
	store float 0.0, ptr %v5019
	%v5023 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 218
	store float 0.0, ptr %v5023
	%v5027 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 219
	store float 0.0, ptr %v5027
	%v5031 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 220
	store float 0.0, ptr %v5031
	%v5035 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 221
	store float 0.0, ptr %v5035
	%v5039 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 222
	store float 0.0, ptr %v5039
	%v5043 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 223
	store float 0.0, ptr %v5043
	%v5047 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 224
	store float 0.0, ptr %v5047
	%v5051 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 225
	store float 0.0, ptr %v5051
	%v5055 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 226
	store float 0.0, ptr %v5055
	%v5059 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 227
	store float 0.0, ptr %v5059
	%v5063 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 228
	store float 0.0, ptr %v5063
	%v5067 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 229
	store float 0.0, ptr %v5067
	%v5071 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 230
	store float 0.0, ptr %v5071
	%v5075 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 231
	store float 0.0, ptr %v5075
	%v5079 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 232
	store float 0.0, ptr %v5079
	%v5083 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 233
	store float 0.0, ptr %v5083
	%v5087 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 234
	store float 0.0, ptr %v5087
	%v5091 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 235
	store float 0.0, ptr %v5091
	%v5095 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 236
	store float 0.0, ptr %v5095
	%v5099 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 237
	store float 0.0, ptr %v5099
	%v5103 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 238
	store float 0.0, ptr %v5103
	%v5107 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 239
	store float 0.0, ptr %v5107
	%v5111 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 240
	store float 0.0, ptr %v5111
	%v5115 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 241
	store float 0.0, ptr %v5115
	%v5119 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 242
	store float 0.0, ptr %v5119
	%v5123 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 243
	store float 0.0, ptr %v5123
	%v5127 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 244
	store float 0.0, ptr %v5127
	%v5131 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 245
	store float 0.0, ptr %v5131
	%v5135 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 246
	store float 0.0, ptr %v5135
	%v5139 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 247
	store float 0.0, ptr %v5139
	%v5143 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 248
	store float 0.0, ptr %v5143
	%v5147 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 249
	store float 0.0, ptr %v5147
	%v5151 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 250
	store float 0.0, ptr %v5151
	%v5155 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 251
	store float 0.0, ptr %v5155
	%v5159 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 252
	store float 0.0, ptr %v5159
	%v5163 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 253
	store float 0.0, ptr %v5163
	%v5167 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 254
	store float 0.0, ptr %v5167
	%v5171 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 255
	store float 0.0, ptr %v5171
	%v5175 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 256
	store float 0.0, ptr %v5175
	%v5179 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 257
	store float 0.0, ptr %v5179
	%v5183 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 258
	store float 0.0, ptr %v5183
	%v5187 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 259
	store float 0.0, ptr %v5187
	%v5191 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 260
	store float 0.0, ptr %v5191
	%v5195 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 261
	store float 0.0, ptr %v5195
	%v5199 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 262
	store float 0.0, ptr %v5199
	%v5203 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 263
	store float 0.0, ptr %v5203
	%v5207 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 264
	store float 0.0, ptr %v5207
	%v5211 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 265
	store float 0.0, ptr %v5211
	%v5215 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 266
	store float 0.0, ptr %v5215
	%v5219 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 267
	store float 0.0, ptr %v5219
	%v5223 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 268
	store float 0.0, ptr %v5223
	%v5227 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 269
	store float 0.0, ptr %v5227
	%v5231 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 270
	store float 0.0, ptr %v5231
	%v5235 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 271
	store float 0.0, ptr %v5235
	%v5239 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 272
	store float 0.0, ptr %v5239
	%v5243 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 273
	store float 0.0, ptr %v5243
	%v5247 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 274
	store float 0.0, ptr %v5247
	%v5251 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 275
	store float 0.0, ptr %v5251
	%v5255 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 276
	store float 0.0, ptr %v5255
	%v5259 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 277
	store float 0.0, ptr %v5259
	%v5263 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 278
	store float 0.0, ptr %v5263
	%v5267 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 279
	store float 0.0, ptr %v5267
	%v5271 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 280
	store float 0.0, ptr %v5271
	%v5275 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 281
	store float 0.0, ptr %v5275
	%v5279 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 282
	store float 0.0, ptr %v5279
	%v5283 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 283
	store float 0.0, ptr %v5283
	%v5287 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 284
	store float 0.0, ptr %v5287
	%v5291 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 285
	store float 0.0, ptr %v5291
	%v5295 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 286
	store float 0.0, ptr %v5295
	%v5299 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 287
	store float 0.0, ptr %v5299
	%v5303 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 288
	store float 0.0, ptr %v5303
	%v5307 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 289
	store float 0.0, ptr %v5307
	%v5311 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 290
	store float 0.0, ptr %v5311
	%v5315 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 291
	store float 0.0, ptr %v5315
	%v5319 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 292
	store float 0.0, ptr %v5319
	%v5323 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 293
	store float 0.0, ptr %v5323
	%v5327 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 294
	store float 0.0, ptr %v5327
	%v5331 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 295
	store float 0.0, ptr %v5331
	%v5335 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 296
	store float 0.0, ptr %v5335
	%v5339 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 297
	store float 0.0, ptr %v5339
	%v5343 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 298
	store float 0.0, ptr %v5343
	%v5347 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 299
	store float 0.0, ptr %v5347
	%v5351 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 300
	store float 0.0, ptr %v5351
	%v5355 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 301
	store float 0.0, ptr %v5355
	%v5359 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 302
	store float 0.0, ptr %v5359
	%v5363 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 303
	store float 0.0, ptr %v5363
	%v5367 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 304
	store float 0.0, ptr %v5367
	%v5371 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 305
	store float 0.0, ptr %v5371
	%v5375 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 306
	store float 0.0, ptr %v5375
	%v5379 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 307
	store float 0.0, ptr %v5379
	%v5383 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 308
	store float 0.0, ptr %v5383
	%v5387 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 309
	store float 0.0, ptr %v5387
	%v5391 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 310
	store float 0.0, ptr %v5391
	%v5395 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 311
	store float 0.0, ptr %v5395
	%v5399 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 312
	store float 0.0, ptr %v5399
	%v5403 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 313
	store float 0.0, ptr %v5403
	%v5407 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 314
	store float 0.0, ptr %v5407
	%v5411 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 315
	store float 0.0, ptr %v5411
	%v5415 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 316
	store float 0.0, ptr %v5415
	%v5419 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 317
	store float 0.0, ptr %v5419
	%v5423 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 318
	store float 0.0, ptr %v5423
	%v5427 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 319
	store float 0.0, ptr %v5427
	%v5431 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 320
	store float 0.0, ptr %v5431
	%v5435 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 321
	store float 0.0, ptr %v5435
	%v5439 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 322
	store float 0.0, ptr %v5439
	%v5443 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 323
	store float 0.0, ptr %v5443
	%v5447 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 324
	store float 0.0, ptr %v5447
	%v5451 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 325
	store float 0.0, ptr %v5451
	%v5455 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 326
	store float 0.0, ptr %v5455
	%v5459 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 327
	store float 0.0, ptr %v5459
	%v5463 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 328
	store float 0.0, ptr %v5463
	%v5467 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 329
	store float 0.0, ptr %v5467
	%v5471 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 330
	store float 0.0, ptr %v5471
	%v5475 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 331
	store float 0.0, ptr %v5475
	%v5479 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 332
	store float 0.0, ptr %v5479
	%v5483 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 333
	store float 0.0, ptr %v5483
	%v5487 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 334
	store float 0.0, ptr %v5487
	%v5491 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 335
	store float 0.0, ptr %v5491
	%v5495 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 336
	store float 0.0, ptr %v5495
	%v5499 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 337
	store float 0.0, ptr %v5499
	%v5503 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 338
	store float 0.0, ptr %v5503
	%v5507 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 339
	store float 0.0, ptr %v5507
	%v5511 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 340
	store float 0.0, ptr %v5511
	%v5515 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 341
	store float 0.0, ptr %v5515
	%v5519 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 342
	store float 0.0, ptr %v5519
	%v5523 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 343
	store float 0.0, ptr %v5523
	%v5527 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 344
	store float 0.0, ptr %v5527
	%v5531 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 345
	store float 0.0, ptr %v5531
	%v5535 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 346
	store float 0.0, ptr %v5535
	%v5539 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 347
	store float 0.0, ptr %v5539
	%v5543 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 348
	store float 0.0, ptr %v5543
	%v5547 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 349
	store float 0.0, ptr %v5547
	%v5551 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 350
	store float 0.0, ptr %v5551
	%v5555 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 351
	store float 0.0, ptr %v5555
	%v5559 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 352
	store float 0.0, ptr %v5559
	%v5563 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 353
	store float 0.0, ptr %v5563
	%v5567 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 354
	store float 0.0, ptr %v5567
	%v5571 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 355
	store float 0.0, ptr %v5571
	%v5575 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 356
	store float 0.0, ptr %v5575
	%v5579 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 357
	store float 0.0, ptr %v5579
	%v5583 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 358
	store float 0.0, ptr %v5583
	%v5587 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 359
	store float 0.0, ptr %v5587
	%v5591 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 360
	store float 0.0, ptr %v5591
	%v5595 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 361
	store float 0.0, ptr %v5595
	%v5599 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 362
	store float 0.0, ptr %v5599
	%v5603 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 363
	store float 0.0, ptr %v5603
	%v5607 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 364
	store float 0.0, ptr %v5607
	%v5611 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 365
	store float 0.0, ptr %v5611
	%v5615 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 366
	store float 0.0, ptr %v5615
	%v5619 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 367
	store float 0.0, ptr %v5619
	%v5623 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 368
	store float 0.0, ptr %v5623
	%v5627 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 369
	store float 0.0, ptr %v5627
	%v5631 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 370
	store float 0.0, ptr %v5631
	%v5635 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 371
	store float 0.0, ptr %v5635
	%v5639 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 372
	store float 0.0, ptr %v5639
	%v5643 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 373
	store float 0.0, ptr %v5643
	%v5647 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 374
	store float 0.0, ptr %v5647
	%v5651 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 375
	store float 0.0, ptr %v5651
	%v5655 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 376
	store float 0.0, ptr %v5655
	%v5659 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 377
	store float 0.0, ptr %v5659
	%v5663 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 378
	store float 0.0, ptr %v5663
	%v5667 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 379
	store float 0.0, ptr %v5667
	%v5671 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 380
	store float 0.0, ptr %v5671
	%v5675 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 381
	store float 0.0, ptr %v5675
	%v5679 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 382
	store float 0.0, ptr %v5679
	%v5683 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 383
	store float 0.0, ptr %v5683
	%v5687 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 384
	store float 0.0, ptr %v5687
	%v5691 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 385
	store float 0.0, ptr %v5691
	%v5695 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 386
	store float 0.0, ptr %v5695
	%v5699 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 387
	store float 0.0, ptr %v5699
	%v5703 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 388
	store float 0.0, ptr %v5703
	%v5707 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 389
	store float 0.0, ptr %v5707
	%v5711 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 390
	store float 0.0, ptr %v5711
	%v5715 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 391
	store float 0.0, ptr %v5715
	%v5719 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 392
	store float 0.0, ptr %v5719
	%v5723 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 393
	store float 0.0, ptr %v5723
	%v5727 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 394
	store float 0.0, ptr %v5727
	%v5731 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 395
	store float 0.0, ptr %v5731
	%v5735 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 396
	store float 0.0, ptr %v5735
	%v5739 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 397
	store float 0.0, ptr %v5739
	%v5743 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 398
	store float 0.0, ptr %v5743
	%v5747 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 399
	store float 0.0, ptr %v5747
	%v5751 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 400
	store float 0.0, ptr %v5751
	%v5755 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 401
	store float 0.0, ptr %v5755
	%v5759 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 402
	store float 0.0, ptr %v5759
	%v5763 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 403
	store float 0.0, ptr %v5763
	%v5767 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 404
	store float 0.0, ptr %v5767
	%v5771 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 405
	store float 0.0, ptr %v5771
	%v5775 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 406
	store float 0.0, ptr %v5775
	%v5779 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 407
	store float 0.0, ptr %v5779
	%v5783 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 408
	store float 0.0, ptr %v5783
	%v5787 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 409
	store float 0.0, ptr %v5787
	%v5791 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 410
	store float 0.0, ptr %v5791
	%v5795 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 411
	store float 0.0, ptr %v5795
	%v5799 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 412
	store float 0.0, ptr %v5799
	%v5803 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 413
	store float 0.0, ptr %v5803
	%v5807 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 414
	store float 0.0, ptr %v5807
	%v5811 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 415
	store float 0.0, ptr %v5811
	%v5815 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 416
	store float 0.0, ptr %v5815
	%v5819 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 417
	store float 0.0, ptr %v5819
	%v5823 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 418
	store float 0.0, ptr %v5823
	%v5827 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 419
	store float 0.0, ptr %v5827
	%v5831 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 420
	store float 0.0, ptr %v5831
	%v5835 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 421
	store float 0.0, ptr %v5835
	%v5839 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 422
	store float 0.0, ptr %v5839
	%v5843 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 423
	store float 0.0, ptr %v5843
	%v5847 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 424
	store float 0.0, ptr %v5847
	%v5851 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 425
	store float 0.0, ptr %v5851
	%v5855 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 426
	store float 0.0, ptr %v5855
	%v5859 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 427
	store float 0.0, ptr %v5859
	%v5863 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 428
	store float 0.0, ptr %v5863
	%v5867 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 429
	store float 0.0, ptr %v5867
	%v5871 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 430
	store float 0.0, ptr %v5871
	%v5875 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 431
	store float 0.0, ptr %v5875
	%v5879 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 432
	store float 0.0, ptr %v5879
	%v5883 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 433
	store float 0.0, ptr %v5883
	%v5887 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 434
	store float 0.0, ptr %v5887
	%v5891 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 435
	store float 0.0, ptr %v5891
	%v5895 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 436
	store float 0.0, ptr %v5895
	%v5899 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 437
	store float 0.0, ptr %v5899
	%v5903 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 438
	store float 0.0, ptr %v5903
	%v5907 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 439
	store float 0.0, ptr %v5907
	%v5911 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 440
	store float 0.0, ptr %v5911
	%v5915 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 441
	store float 0.0, ptr %v5915
	%v5919 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 442
	store float 0.0, ptr %v5919
	%v5923 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 443
	store float 0.0, ptr %v5923
	%v5927 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 444
	store float 0.0, ptr %v5927
	%v5931 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 445
	store float 0.0, ptr %v5931
	%v5935 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 446
	store float 0.0, ptr %v5935
	%v5939 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 447
	store float 0.0, ptr %v5939
	%v5943 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 448
	store float 0.0, ptr %v5943
	%v5947 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 449
	store float 0.0, ptr %v5947
	%v5951 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 450
	store float 0.0, ptr %v5951
	%v5955 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 451
	store float 0.0, ptr %v5955
	%v5959 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 452
	store float 0.0, ptr %v5959
	%v5963 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 453
	store float 0.0, ptr %v5963
	%v5967 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 454
	store float 0.0, ptr %v5967
	%v5971 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 455
	store float 0.0, ptr %v5971
	%v5975 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 456
	store float 0.0, ptr %v5975
	%v5979 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 457
	store float 0.0, ptr %v5979
	%v5983 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 458
	store float 0.0, ptr %v5983
	%v5987 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 459
	store float 0.0, ptr %v5987
	%v5991 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 460
	store float 0.0, ptr %v5991
	%v5995 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 461
	store float 0.0, ptr %v5995
	%v5999 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 462
	store float 0.0, ptr %v5999
	%v6003 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 463
	store float 0.0, ptr %v6003
	%v6007 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 464
	store float 0.0, ptr %v6007
	%v6011 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 465
	store float 0.0, ptr %v6011
	%v6015 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 466
	store float 0.0, ptr %v6015
	%v6019 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 467
	store float 0.0, ptr %v6019
	%v6023 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 468
	store float 0.0, ptr %v6023
	%v6027 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 469
	store float 0.0, ptr %v6027
	%v6031 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 470
	store float 0.0, ptr %v6031
	%v6035 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 471
	store float 0.0, ptr %v6035
	%v6039 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 472
	store float 0.0, ptr %v6039
	%v6043 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 473
	store float 0.0, ptr %v6043
	%v6047 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 474
	store float 0.0, ptr %v6047
	%v6051 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 475
	store float 0.0, ptr %v6051
	%v6055 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 476
	store float 0.0, ptr %v6055
	%v6059 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 477
	store float 0.0, ptr %v6059
	%v6063 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 478
	store float 0.0, ptr %v6063
	%v6067 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 479
	store float 0.0, ptr %v6067
	%v6071 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 480
	store float 0.0, ptr %v6071
	%v6075 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 481
	store float 0.0, ptr %v6075
	%v6079 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 482
	store float 0.0, ptr %v6079
	%v6083 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 483
	store float 0.0, ptr %v6083
	%v6087 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 484
	store float 0.0, ptr %v6087
	%v6091 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 485
	store float 0.0, ptr %v6091
	%v6095 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 486
	store float 0.0, ptr %v6095
	%v6099 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 487
	store float 0.0, ptr %v6099
	%v6103 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 488
	store float 0.0, ptr %v6103
	%v6107 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 489
	store float 0.0, ptr %v6107
	%v6111 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 490
	store float 0.0, ptr %v6111
	%v6115 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 491
	store float 0.0, ptr %v6115
	%v6119 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 492
	store float 0.0, ptr %v6119
	%v6123 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 493
	store float 0.0, ptr %v6123
	%v6127 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 494
	store float 0.0, ptr %v6127
	%v6131 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 495
	store float 0.0, ptr %v6131
	%v6135 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 496
	store float 0.0, ptr %v6135
	%v6139 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 497
	store float 0.0, ptr %v6139
	%v6143 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 498
	store float 0.0, ptr %v6143
	%v6147 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 499
	store float 0.0, ptr %v6147
	%v6151 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 500
	store float 0.0, ptr %v6151
	%v6155 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 501
	store float 0.0, ptr %v6155
	%v6159 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 502
	store float 0.0, ptr %v6159
	%v6163 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 503
	store float 0.0, ptr %v6163
	%v6167 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 504
	store float 0.0, ptr %v6167
	%v6171 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 505
	store float 0.0, ptr %v6171
	%v6175 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 506
	store float 0.0, ptr %v6175
	%v6179 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 507
	store float 0.0, ptr %v6179
	%v6183 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 508
	store float 0.0, ptr %v6183
	%v6187 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 509
	store float 0.0, ptr %v6187
	%v6191 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 510
	store float 0.0, ptr %v6191
	%v6195 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 511
	store float 0.0, ptr %v6195
	%v6199 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 512
	store float 0.0, ptr %v6199
	%v6203 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 513
	store float 0.0, ptr %v6203
	%v6207 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 514
	store float 0.0, ptr %v6207
	%v6211 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 515
	store float 0.0, ptr %v6211
	%v6215 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 516
	store float 0.0, ptr %v6215
	%v6219 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 517
	store float 0.0, ptr %v6219
	%v6223 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 518
	store float 0.0, ptr %v6223
	%v6227 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 519
	store float 0.0, ptr %v6227
	%v6231 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 520
	store float 0.0, ptr %v6231
	%v6235 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 521
	store float 0.0, ptr %v6235
	%v6239 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 522
	store float 0.0, ptr %v6239
	%v6243 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 523
	store float 0.0, ptr %v6243
	%v6247 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 524
	store float 0.0, ptr %v6247
	%v6251 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 525
	store float 0.0, ptr %v6251
	%v6255 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 526
	store float 0.0, ptr %v6255
	%v6259 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 527
	store float 0.0, ptr %v6259
	%v6263 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 528
	store float 0.0, ptr %v6263
	%v6267 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 529
	store float 0.0, ptr %v6267
	%v6271 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 530
	store float 0.0, ptr %v6271
	%v6275 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 531
	store float 0.0, ptr %v6275
	%v6279 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 532
	store float 0.0, ptr %v6279
	%v6283 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 533
	store float 0.0, ptr %v6283
	%v6287 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 534
	store float 0.0, ptr %v6287
	%v6291 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 535
	store float 0.0, ptr %v6291
	%v6295 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 536
	store float 0.0, ptr %v6295
	%v6299 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 537
	store float 0.0, ptr %v6299
	%v6303 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 538
	store float 0.0, ptr %v6303
	%v6307 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 539
	store float 0.0, ptr %v6307
	%v6311 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 540
	store float 0.0, ptr %v6311
	%v6315 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 541
	store float 0.0, ptr %v6315
	%v6319 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 542
	store float 0.0, ptr %v6319
	%v6323 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 543
	store float 0.0, ptr %v6323
	%v6327 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 544
	store float 0.0, ptr %v6327
	%v6331 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 545
	store float 0.0, ptr %v6331
	%v6335 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 546
	store float 0.0, ptr %v6335
	%v6339 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 547
	store float 0.0, ptr %v6339
	%v6343 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 548
	store float 0.0, ptr %v6343
	%v6347 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 549
	store float 0.0, ptr %v6347
	%v6351 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 550
	store float 0.0, ptr %v6351
	%v6355 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 551
	store float 0.0, ptr %v6355
	%v6359 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 552
	store float 0.0, ptr %v6359
	%v6363 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 553
	store float 0.0, ptr %v6363
	%v6367 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 554
	store float 0.0, ptr %v6367
	%v6371 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 555
	store float 0.0, ptr %v6371
	%v6375 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 556
	store float 0.0, ptr %v6375
	%v6379 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 557
	store float 0.0, ptr %v6379
	%v6383 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 558
	store float 0.0, ptr %v6383
	%v6387 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 559
	store float 0.0, ptr %v6387
	%v6391 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 560
	store float 0.0, ptr %v6391
	%v6395 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 561
	store float 0.0, ptr %v6395
	%v6399 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 562
	store float 0.0, ptr %v6399
	%v6403 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 563
	store float 0.0, ptr %v6403
	%v6407 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 564
	store float 0.0, ptr %v6407
	%v6411 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 565
	store float 0.0, ptr %v6411
	%v6415 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 566
	store float 0.0, ptr %v6415
	%v6419 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 567
	store float 0.0, ptr %v6419
	%v6423 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 568
	store float 0.0, ptr %v6423
	%v6427 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 569
	store float 0.0, ptr %v6427
	%v6431 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 570
	store float 0.0, ptr %v6431
	%v6435 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 571
	store float 0.0, ptr %v6435
	%v6439 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 572
	store float 0.0, ptr %v6439
	%v6443 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 573
	store float 0.0, ptr %v6443
	%v6447 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 574
	store float 0.0, ptr %v6447
	%v6451 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 575
	store float 0.0, ptr %v6451
	%v6455 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 576
	store float 0.0, ptr %v6455
	%v6459 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 577
	store float 0.0, ptr %v6459
	%v6463 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 578
	store float 0.0, ptr %v6463
	%v6467 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 579
	store float 0.0, ptr %v6467
	%v6471 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 580
	store float 0.0, ptr %v6471
	%v6475 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 581
	store float 0.0, ptr %v6475
	%v6479 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 582
	store float 0.0, ptr %v6479
	%v6483 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 583
	store float 0.0, ptr %v6483
	%v6487 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 584
	store float 0.0, ptr %v6487
	%v6491 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 585
	store float 0.0, ptr %v6491
	%v6495 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 586
	store float 0.0, ptr %v6495
	%v6499 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 587
	store float 0.0, ptr %v6499
	%v6503 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 588
	store float 0.0, ptr %v6503
	%v6507 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 589
	store float 0.0, ptr %v6507
	%v6511 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 590
	store float 0.0, ptr %v6511
	%v6515 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 591
	store float 0.0, ptr %v6515
	%v6519 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 592
	store float 0.0, ptr %v6519
	%v6523 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 593
	store float 0.0, ptr %v6523
	%v6527 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 594
	store float 0.0, ptr %v6527
	%v6531 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 595
	store float 0.0, ptr %v6531
	%v6535 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 596
	store float 0.0, ptr %v6535
	%v6539 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 597
	store float 0.0, ptr %v6539
	%v6543 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 598
	store float 0.0, ptr %v6543
	%v6547 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 599
	store float 0.0, ptr %v6547
	%v6551 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 600
	store float 0.0, ptr %v6551
	%v6555 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 601
	store float 0.0, ptr %v6555
	%v6559 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 602
	store float 0.0, ptr %v6559
	%v6563 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 603
	store float 0.0, ptr %v6563
	%v6567 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 604
	store float 0.0, ptr %v6567
	%v6571 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 605
	store float 0.0, ptr %v6571
	%v6575 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 606
	store float 0.0, ptr %v6575
	%v6579 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 607
	store float 0.0, ptr %v6579
	%v6583 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 608
	store float 0.0, ptr %v6583
	%v6587 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 609
	store float 0.0, ptr %v6587
	%v6591 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 610
	store float 0.0, ptr %v6591
	%v6595 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 611
	store float 0.0, ptr %v6595
	%v6599 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 612
	store float 0.0, ptr %v6599
	%v6603 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 613
	store float 0.0, ptr %v6603
	%v6607 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 614
	store float 0.0, ptr %v6607
	%v6611 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 615
	store float 0.0, ptr %v6611
	%v6615 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 616
	store float 0.0, ptr %v6615
	%v6619 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 617
	store float 0.0, ptr %v6619
	%v6623 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 618
	store float 0.0, ptr %v6623
	%v6627 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 619
	store float 0.0, ptr %v6627
	%v6631 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 620
	store float 0.0, ptr %v6631
	%v6635 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 621
	store float 0.0, ptr %v6635
	%v6639 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 622
	store float 0.0, ptr %v6639
	%v6643 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 623
	store float 0.0, ptr %v6643
	%v6647 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 624
	store float 0.0, ptr %v6647
	%v6651 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 625
	store float 0.0, ptr %v6651
	%v6655 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 626
	store float 0.0, ptr %v6655
	%v6659 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 627
	store float 0.0, ptr %v6659
	%v6663 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 628
	store float 0.0, ptr %v6663
	%v6667 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 629
	store float 0.0, ptr %v6667
	%v6671 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 630
	store float 0.0, ptr %v6671
	%v6675 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 631
	store float 0.0, ptr %v6675
	%v6679 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 632
	store float 0.0, ptr %v6679
	%v6683 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 633
	store float 0.0, ptr %v6683
	%v6687 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 634
	store float 0.0, ptr %v6687
	%v6691 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 635
	store float 0.0, ptr %v6691
	%v6695 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 636
	store float 0.0, ptr %v6695
	%v6699 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 637
	store float 0.0, ptr %v6699
	%v6703 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 638
	store float 0.0, ptr %v6703
	%v6707 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 639
	store float 0.0, ptr %v6707
	%v6711 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 640
	store float 0.0, ptr %v6711
	%v6715 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 641
	store float 0.0, ptr %v6715
	%v6719 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 642
	store float 0.0, ptr %v6719
	%v6723 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 643
	store float 0.0, ptr %v6723
	%v6727 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 644
	store float 0.0, ptr %v6727
	%v6731 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 645
	store float 0.0, ptr %v6731
	%v6735 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 646
	store float 0.0, ptr %v6735
	%v6739 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 647
	store float 0.0, ptr %v6739
	%v6743 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 648
	store float 0.0, ptr %v6743
	%v6747 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 649
	store float 0.0, ptr %v6747
	%v6751 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 650
	store float 0.0, ptr %v6751
	%v6755 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 651
	store float 0.0, ptr %v6755
	%v6759 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 652
	store float 0.0, ptr %v6759
	%v6763 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 653
	store float 0.0, ptr %v6763
	%v6767 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 654
	store float 0.0, ptr %v6767
	%v6771 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 655
	store float 0.0, ptr %v6771
	%v6775 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 656
	store float 0.0, ptr %v6775
	%v6779 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 657
	store float 0.0, ptr %v6779
	%v6783 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 658
	store float 0.0, ptr %v6783
	%v6787 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 659
	store float 0.0, ptr %v6787
	%v6791 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 660
	store float 0.0, ptr %v6791
	%v6795 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 661
	store float 0.0, ptr %v6795
	%v6799 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 662
	store float 0.0, ptr %v6799
	%v6803 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 663
	store float 0.0, ptr %v6803
	%v6807 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 664
	store float 0.0, ptr %v6807
	%v6811 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 665
	store float 0.0, ptr %v6811
	%v6815 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 666
	store float 0.0, ptr %v6815
	%v6819 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 667
	store float 0.0, ptr %v6819
	%v6823 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 668
	store float 0.0, ptr %v6823
	%v6827 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 669
	store float 0.0, ptr %v6827
	%v6831 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 670
	store float 0.0, ptr %v6831
	%v6835 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 671
	store float 0.0, ptr %v6835
	%v6839 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 672
	store float 0.0, ptr %v6839
	%v6843 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 673
	store float 0.0, ptr %v6843
	%v6847 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 674
	store float 0.0, ptr %v6847
	%v6851 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 675
	store float 0.0, ptr %v6851
	%v6855 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 676
	store float 0.0, ptr %v6855
	%v6859 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 677
	store float 0.0, ptr %v6859
	%v6863 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 678
	store float 0.0, ptr %v6863
	%v6867 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 679
	store float 0.0, ptr %v6867
	%v6871 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 680
	store float 0.0, ptr %v6871
	%v6875 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 681
	store float 0.0, ptr %v6875
	%v6879 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 682
	store float 0.0, ptr %v6879
	%v6883 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 683
	store float 0.0, ptr %v6883
	%v6887 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 684
	store float 0.0, ptr %v6887
	%v6891 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 685
	store float 0.0, ptr %v6891
	%v6895 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 686
	store float 0.0, ptr %v6895
	%v6899 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 687
	store float 0.0, ptr %v6899
	%v6903 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 688
	store float 0.0, ptr %v6903
	%v6907 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 689
	store float 0.0, ptr %v6907
	%v6911 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 690
	store float 0.0, ptr %v6911
	%v6915 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 691
	store float 0.0, ptr %v6915
	%v6919 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 692
	store float 0.0, ptr %v6919
	%v6923 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 693
	store float 0.0, ptr %v6923
	%v6927 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 694
	store float 0.0, ptr %v6927
	%v6931 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 695
	store float 0.0, ptr %v6931
	%v6935 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 696
	store float 0.0, ptr %v6935
	%v6939 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 697
	store float 0.0, ptr %v6939
	%v6943 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 698
	store float 0.0, ptr %v6943
	%v6947 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 699
	store float 0.0, ptr %v6947
	%v6951 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 700
	store float 0.0, ptr %v6951
	%v6955 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 701
	store float 0.0, ptr %v6955
	%v6959 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 702
	store float 0.0, ptr %v6959
	%v6963 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 703
	store float 0.0, ptr %v6963
	%v6967 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 704
	store float 0.0, ptr %v6967
	%v6971 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 705
	store float 0.0, ptr %v6971
	%v6975 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 706
	store float 0.0, ptr %v6975
	%v6979 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 707
	store float 0.0, ptr %v6979
	%v6983 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 708
	store float 0.0, ptr %v6983
	%v6987 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 709
	store float 0.0, ptr %v6987
	%v6991 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 710
	store float 0.0, ptr %v6991
	%v6995 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 711
	store float 0.0, ptr %v6995
	%v6999 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 712
	store float 0.0, ptr %v6999
	%v7003 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 713
	store float 0.0, ptr %v7003
	%v7007 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 714
	store float 0.0, ptr %v7007
	%v7011 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 715
	store float 0.0, ptr %v7011
	%v7015 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 716
	store float 0.0, ptr %v7015
	%v7019 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 717
	store float 0.0, ptr %v7019
	%v7023 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 718
	store float 0.0, ptr %v7023
	%v7027 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 719
	store float 0.0, ptr %v7027
	%v7031 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 720
	store float 0.0, ptr %v7031
	%v7035 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 721
	store float 0.0, ptr %v7035
	%v7039 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 722
	store float 0.0, ptr %v7039
	%v7043 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 723
	store float 0.0, ptr %v7043
	%v7047 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 724
	store float 0.0, ptr %v7047
	%v7051 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 725
	store float 0.0, ptr %v7051
	%v7055 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 726
	store float 0.0, ptr %v7055
	%v7059 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 727
	store float 0.0, ptr %v7059
	%v7063 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 728
	store float 0.0, ptr %v7063
	%v7067 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 729
	store float 0.0, ptr %v7067
	%v7071 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 730
	store float 0.0, ptr %v7071
	%v7075 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 731
	store float 0.0, ptr %v7075
	%v7079 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 732
	store float 0.0, ptr %v7079
	%v7083 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 733
	store float 0.0, ptr %v7083
	%v7087 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 734
	store float 0.0, ptr %v7087
	%v7091 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 735
	store float 0.0, ptr %v7091
	%v7095 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 736
	store float 0.0, ptr %v7095
	%v7099 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 737
	store float 0.0, ptr %v7099
	%v7103 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 738
	store float 0.0, ptr %v7103
	%v7107 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 739
	store float 0.0, ptr %v7107
	%v7111 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 740
	store float 0.0, ptr %v7111
	%v7115 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 741
	store float 0.0, ptr %v7115
	%v7119 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 742
	store float 0.0, ptr %v7119
	%v7123 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 743
	store float 0.0, ptr %v7123
	%v7127 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 744
	store float 0.0, ptr %v7127
	%v7131 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 745
	store float 0.0, ptr %v7131
	%v7135 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 746
	store float 0.0, ptr %v7135
	%v7139 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 747
	store float 0.0, ptr %v7139
	%v7143 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 748
	store float 0.0, ptr %v7143
	%v7147 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 749
	store float 0.0, ptr %v7147
	%v7151 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 750
	store float 0.0, ptr %v7151
	%v7155 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 751
	store float 0.0, ptr %v7155
	%v7159 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 752
	store float 0.0, ptr %v7159
	%v7163 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 753
	store float 0.0, ptr %v7163
	%v7167 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 754
	store float 0.0, ptr %v7167
	%v7171 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 755
	store float 0.0, ptr %v7171
	%v7175 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 756
	store float 0.0, ptr %v7175
	%v7179 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 757
	store float 0.0, ptr %v7179
	%v7183 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 758
	store float 0.0, ptr %v7183
	%v7187 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 759
	store float 0.0, ptr %v7187
	%v7191 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 760
	store float 0.0, ptr %v7191
	%v7195 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 761
	store float 0.0, ptr %v7195
	%v7199 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 762
	store float 0.0, ptr %v7199
	%v7203 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 763
	store float 0.0, ptr %v7203
	%v7207 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 764
	store float 0.0, ptr %v7207
	%v7211 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 765
	store float 0.0, ptr %v7211
	%v7215 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 766
	store float 0.0, ptr %v7215
	%v7219 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 767
	store float 0.0, ptr %v7219
	%v7223 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 768
	store float 0.0, ptr %v7223
	%v7227 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 769
	store float 0.0, ptr %v7227
	%v7231 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 770
	store float 0.0, ptr %v7231
	%v7235 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 771
	store float 0.0, ptr %v7235
	%v7239 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 772
	store float 0.0, ptr %v7239
	%v7243 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 773
	store float 0.0, ptr %v7243
	%v7247 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 774
	store float 0.0, ptr %v7247
	%v7251 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 775
	store float 0.0, ptr %v7251
	%v7255 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 776
	store float 0.0, ptr %v7255
	%v7259 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 777
	store float 0.0, ptr %v7259
	%v7263 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 778
	store float 0.0, ptr %v7263
	%v7267 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 779
	store float 0.0, ptr %v7267
	%v7271 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 780
	store float 0.0, ptr %v7271
	%v7275 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 781
	store float 0.0, ptr %v7275
	%v7279 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 782
	store float 0.0, ptr %v7279
	%v7283 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 783
	store float 0.0, ptr %v7283
	%v7287 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 784
	store float 0.0, ptr %v7287
	%v7291 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 785
	store float 0.0, ptr %v7291
	%v7295 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 786
	store float 0.0, ptr %v7295
	%v7299 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 787
	store float 0.0, ptr %v7299
	%v7303 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 788
	store float 0.0, ptr %v7303
	%v7307 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 789
	store float 0.0, ptr %v7307
	%v7311 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 790
	store float 0.0, ptr %v7311
	%v7315 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 791
	store float 0.0, ptr %v7315
	%v7319 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 792
	store float 0.0, ptr %v7319
	%v7323 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 793
	store float 0.0, ptr %v7323
	%v7327 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 794
	store float 0.0, ptr %v7327
	%v7331 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 795
	store float 0.0, ptr %v7331
	%v7335 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 796
	store float 0.0, ptr %v7335
	%v7339 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 797
	store float 0.0, ptr %v7339
	%v7343 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 798
	store float 0.0, ptr %v7343
	%v7347 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 799
	store float 0.0, ptr %v7347
	%v7351 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 800
	store float 0.0, ptr %v7351
	%v7355 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 801
	store float 0.0, ptr %v7355
	%v7359 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 802
	store float 0.0, ptr %v7359
	%v7363 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 803
	store float 0.0, ptr %v7363
	%v7367 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 804
	store float 0.0, ptr %v7367
	%v7371 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 805
	store float 0.0, ptr %v7371
	%v7375 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 806
	store float 0.0, ptr %v7375
	%v7379 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 807
	store float 0.0, ptr %v7379
	%v7383 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 808
	store float 0.0, ptr %v7383
	%v7387 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 809
	store float 0.0, ptr %v7387
	%v7391 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 810
	store float 0.0, ptr %v7391
	%v7395 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 811
	store float 0.0, ptr %v7395
	%v7399 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 812
	store float 0.0, ptr %v7399
	%v7403 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 813
	store float 0.0, ptr %v7403
	%v7407 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 814
	store float 0.0, ptr %v7407
	%v7411 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 815
	store float 0.0, ptr %v7411
	%v7415 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 816
	store float 0.0, ptr %v7415
	%v7419 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 817
	store float 0.0, ptr %v7419
	%v7423 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 818
	store float 0.0, ptr %v7423
	%v7427 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 819
	store float 0.0, ptr %v7427
	%v7431 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 820
	store float 0.0, ptr %v7431
	%v7435 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 821
	store float 0.0, ptr %v7435
	%v7439 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 822
	store float 0.0, ptr %v7439
	%v7443 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 823
	store float 0.0, ptr %v7443
	%v7447 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 824
	store float 0.0, ptr %v7447
	%v7451 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 825
	store float 0.0, ptr %v7451
	%v7455 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 826
	store float 0.0, ptr %v7455
	%v7459 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 827
	store float 0.0, ptr %v7459
	%v7463 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 828
	store float 0.0, ptr %v7463
	%v7467 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 829
	store float 0.0, ptr %v7467
	%v7471 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 830
	store float 0.0, ptr %v7471
	%v7475 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 831
	store float 0.0, ptr %v7475
	%v7479 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 832
	store float 0.0, ptr %v7479
	%v7483 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 833
	store float 0.0, ptr %v7483
	%v7487 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 834
	store float 0.0, ptr %v7487
	%v7491 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 835
	store float 0.0, ptr %v7491
	%v7495 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 836
	store float 0.0, ptr %v7495
	%v7499 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 837
	store float 0.0, ptr %v7499
	%v7503 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 838
	store float 0.0, ptr %v7503
	%v7507 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 839
	store float 0.0, ptr %v7507
	%v7511 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 840
	store float 0.0, ptr %v7511
	%v7515 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 841
	store float 0.0, ptr %v7515
	%v7519 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 842
	store float 0.0, ptr %v7519
	%v7523 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 843
	store float 0.0, ptr %v7523
	%v7527 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 844
	store float 0.0, ptr %v7527
	%v7531 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 845
	store float 0.0, ptr %v7531
	%v7535 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 846
	store float 0.0, ptr %v7535
	%v7539 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 847
	store float 0.0, ptr %v7539
	%v7543 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 848
	store float 0.0, ptr %v7543
	%v7547 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 849
	store float 0.0, ptr %v7547
	%v7551 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 850
	store float 0.0, ptr %v7551
	%v7555 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 851
	store float 0.0, ptr %v7555
	%v7559 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 852
	store float 0.0, ptr %v7559
	%v7563 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 853
	store float 0.0, ptr %v7563
	%v7567 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 854
	store float 0.0, ptr %v7567
	%v7571 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 855
	store float 0.0, ptr %v7571
	%v7575 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 856
	store float 0.0, ptr %v7575
	%v7579 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 857
	store float 0.0, ptr %v7579
	%v7583 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 858
	store float 0.0, ptr %v7583
	%v7587 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 859
	store float 0.0, ptr %v7587
	%v7591 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 860
	store float 0.0, ptr %v7591
	%v7595 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 861
	store float 0.0, ptr %v7595
	%v7599 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 862
	store float 0.0, ptr %v7599
	%v7603 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 863
	store float 0.0, ptr %v7603
	%v7607 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 864
	store float 0.0, ptr %v7607
	%v7611 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 865
	store float 0.0, ptr %v7611
	%v7615 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 866
	store float 0.0, ptr %v7615
	%v7619 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 867
	store float 0.0, ptr %v7619
	%v7623 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 868
	store float 0.0, ptr %v7623
	%v7627 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 869
	store float 0.0, ptr %v7627
	%v7631 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 870
	store float 0.0, ptr %v7631
	%v7635 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 871
	store float 0.0, ptr %v7635
	%v7639 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 872
	store float 0.0, ptr %v7639
	%v7643 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 873
	store float 0.0, ptr %v7643
	%v7647 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 874
	store float 0.0, ptr %v7647
	%v7651 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 875
	store float 0.0, ptr %v7651
	%v7655 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 876
	store float 0.0, ptr %v7655
	%v7659 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 877
	store float 0.0, ptr %v7659
	%v7663 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 878
	store float 0.0, ptr %v7663
	%v7667 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 879
	store float 0.0, ptr %v7667
	%v7671 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 880
	store float 0.0, ptr %v7671
	%v7675 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 881
	store float 0.0, ptr %v7675
	%v7679 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 882
	store float 0.0, ptr %v7679
	%v7683 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 883
	store float 0.0, ptr %v7683
	%v7687 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 884
	store float 0.0, ptr %v7687
	%v7691 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 885
	store float 0.0, ptr %v7691
	%v7695 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 886
	store float 0.0, ptr %v7695
	%v7699 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 887
	store float 0.0, ptr %v7699
	%v7703 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 888
	store float 0.0, ptr %v7703
	%v7707 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 889
	store float 0.0, ptr %v7707
	%v7711 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 890
	store float 0.0, ptr %v7711
	%v7715 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 891
	store float 0.0, ptr %v7715
	%v7719 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 892
	store float 0.0, ptr %v7719
	%v7723 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 893
	store float 0.0, ptr %v7723
	%v7727 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 894
	store float 0.0, ptr %v7727
	%v7731 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 895
	store float 0.0, ptr %v7731
	%v7735 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 896
	store float 0.0, ptr %v7735
	%v7739 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 897
	store float 0.0, ptr %v7739
	%v7743 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 898
	store float 0.0, ptr %v7743
	%v7747 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 899
	store float 0.0, ptr %v7747
	%v7751 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 900
	store float 0.0, ptr %v7751
	%v7755 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 901
	store float 0.0, ptr %v7755
	%v7759 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 902
	store float 0.0, ptr %v7759
	%v7763 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 903
	store float 0.0, ptr %v7763
	%v7767 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 904
	store float 0.0, ptr %v7767
	%v7771 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 905
	store float 0.0, ptr %v7771
	%v7775 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 906
	store float 0.0, ptr %v7775
	%v7779 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 907
	store float 0.0, ptr %v7779
	%v7783 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 908
	store float 0.0, ptr %v7783
	%v7787 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 909
	store float 0.0, ptr %v7787
	%v7791 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 910
	store float 0.0, ptr %v7791
	%v7795 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 911
	store float 0.0, ptr %v7795
	%v7799 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 912
	store float 0.0, ptr %v7799
	%v7803 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 913
	store float 0.0, ptr %v7803
	%v7807 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 914
	store float 0.0, ptr %v7807
	%v7811 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 915
	store float 0.0, ptr %v7811
	%v7815 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 916
	store float 0.0, ptr %v7815
	%v7819 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 917
	store float 0.0, ptr %v7819
	%v7823 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 918
	store float 0.0, ptr %v7823
	%v7827 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 919
	store float 0.0, ptr %v7827
	%v7831 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 920
	store float 0.0, ptr %v7831
	%v7835 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 921
	store float 0.0, ptr %v7835
	%v7839 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 922
	store float 0.0, ptr %v7839
	%v7843 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 923
	store float 0.0, ptr %v7843
	%v7847 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 924
	store float 0.0, ptr %v7847
	%v7851 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 925
	store float 0.0, ptr %v7851
	%v7855 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 926
	store float 0.0, ptr %v7855
	%v7859 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 927
	store float 0.0, ptr %v7859
	%v7863 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 928
	store float 0.0, ptr %v7863
	%v7867 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 929
	store float 0.0, ptr %v7867
	%v7871 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 930
	store float 0.0, ptr %v7871
	%v7875 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 931
	store float 0.0, ptr %v7875
	%v7879 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 932
	store float 0.0, ptr %v7879
	%v7883 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 933
	store float 0.0, ptr %v7883
	%v7887 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 934
	store float 0.0, ptr %v7887
	%v7891 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 935
	store float 0.0, ptr %v7891
	%v7895 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 936
	store float 0.0, ptr %v7895
	%v7899 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 937
	store float 0.0, ptr %v7899
	%v7903 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 938
	store float 0.0, ptr %v7903
	%v7907 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 939
	store float 0.0, ptr %v7907
	%v7911 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 940
	store float 0.0, ptr %v7911
	%v7915 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 941
	store float 0.0, ptr %v7915
	%v7919 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 942
	store float 0.0, ptr %v7919
	%v7923 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 943
	store float 0.0, ptr %v7923
	%v7927 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 944
	store float 0.0, ptr %v7927
	%v7931 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 945
	store float 0.0, ptr %v7931
	%v7935 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 946
	store float 0.0, ptr %v7935
	%v7939 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 947
	store float 0.0, ptr %v7939
	%v7943 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 948
	store float 0.0, ptr %v7943
	%v7947 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 949
	store float 0.0, ptr %v7947
	%v7951 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 950
	store float 0.0, ptr %v7951
	%v7955 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 951
	store float 0.0, ptr %v7955
	%v7959 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 952
	store float 0.0, ptr %v7959
	%v7963 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 953
	store float 0.0, ptr %v7963
	%v7967 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 954
	store float 0.0, ptr %v7967
	%v7971 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 955
	store float 0.0, ptr %v7971
	%v7975 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 956
	store float 0.0, ptr %v7975
	%v7979 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 957
	store float 0.0, ptr %v7979
	%v7983 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 958
	store float 0.0, ptr %v7983
	%v7987 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 959
	store float 0.0, ptr %v7987
	%v7991 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 960
	store float 0.0, ptr %v7991
	%v7995 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 961
	store float 0.0, ptr %v7995
	%v7999 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 962
	store float 0.0, ptr %v7999
	%v8003 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 963
	store float 0.0, ptr %v8003
	%v8007 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 964
	store float 0.0, ptr %v8007
	%v8011 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 965
	store float 0.0, ptr %v8011
	%v8015 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 966
	store float 0.0, ptr %v8015
	%v8019 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 967
	store float 0.0, ptr %v8019
	%v8023 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 968
	store float 0.0, ptr %v8023
	%v8027 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 969
	store float 0.0, ptr %v8027
	%v8031 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 970
	store float 0.0, ptr %v8031
	%v8035 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 971
	store float 0.0, ptr %v8035
	%v8039 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 972
	store float 0.0, ptr %v8039
	%v8043 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 973
	store float 0.0, ptr %v8043
	%v8047 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 974
	store float 0.0, ptr %v8047
	%v8051 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 975
	store float 0.0, ptr %v8051
	%v8055 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 976
	store float 0.0, ptr %v8055
	%v8059 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 977
	store float 0.0, ptr %v8059
	%v8063 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 978
	store float 0.0, ptr %v8063
	%v8067 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 979
	store float 0.0, ptr %v8067
	%v8071 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 980
	store float 0.0, ptr %v8071
	%v8075 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 981
	store float 0.0, ptr %v8075
	%v8079 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 982
	store float 0.0, ptr %v8079
	%v8083 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 983
	store float 0.0, ptr %v8083
	%v8087 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 984
	store float 0.0, ptr %v8087
	%v8091 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 985
	store float 0.0, ptr %v8091
	%v8095 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 986
	store float 0.0, ptr %v8095
	%v8099 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 987
	store float 0.0, ptr %v8099
	%v8103 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 988
	store float 0.0, ptr %v8103
	%v8107 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 989
	store float 0.0, ptr %v8107
	%v8111 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 990
	store float 0.0, ptr %v8111
	%v8115 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 991
	store float 0.0, ptr %v8115
	%v8119 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 992
	store float 0.0, ptr %v8119
	%v8123 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 993
	store float 0.0, ptr %v8123
	%v8127 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 994
	store float 0.0, ptr %v8127
	%v8131 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 995
	store float 0.0, ptr %v8131
	%v8135 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 996
	store float 0.0, ptr %v8135
	%v8139 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 997
	store float 0.0, ptr %v8139
	%v8143 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 998
	store float 0.0, ptr %v8143
	%v8147 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 999
	store float 0.0, ptr %v8147
	%v8151 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 1000
	store float 0.0, ptr %v8151
	%v8155 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 1001
	store float 0.0, ptr %v8155
	%v8159 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 1002
	store float 0.0, ptr %v8159
	%v8163 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 1003
	store float 0.0, ptr %v8163
	%v8167 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 1004
	store float 0.0, ptr %v8167
	%v8171 = getelementptr [1005 x float], ptr %v4148, i32 0, i32 0
	%v8175 = getelementptr [1005 x float], ptr @__GLOBAL_VAR_a, i32 0, i32 0
	%v8176 = load float, ptr %v8175
	store float %v8176, ptr %v8171
	%v8180 = getelementptr [1005 x float], ptr @__GLOBAL_VAR_ff, i32 0, i32 0
	%v8184 = getelementptr [1005 x float], ptr @__GLOBAL_VAR_a, i32 0, i32 0
	%v8185 = load float, ptr %v8184
	store float %v8185, ptr %v8180
	store float undef, ptr %v8186
	%v8192 = getelementptr [1005 x float], ptr @__GLOBAL_VAR_a, i32 0, i32 0
	%v8193 = load float, ptr %v8192
	%v8197 = getelementptr [1005 x float], ptr @__GLOBAL_VAR_a, i32 0, i32 0
	%v8198 = load float, ptr %v8197
	%v8202 = getelementptr [1005 x float], ptr @__GLOBAL_VAR_a, i32 0, i32 0
	%v8203 = load float, ptr %v8202
	%v8204 = call float  @DFS(i32 1, float %v8193, float %v8198, float %v8203, ptr %v4148)
	store float %v8204, ptr %v8186
	%v8205 = load float, ptr %v8186
	call void @putfloat(float %v8205)
	call void @putch(i32 32)
	%v8208 = load i32, ptr @__GLOBAL_VAR_n
	%v8209 = sitofp i32 %v8208 to float
	call void @putfarray(float %v8209, ptr @__GLOBAL_VAR_ff)
	store i32 0, ptr %v4145
	br label %bb_8
bb_8:
	%v8212 = load i32, ptr %v4145
	ret i32 %v8212
}
