	.text
	.attribute	4, 16
	.attribute	5, "rv64i2p0_m2p0_a2p0_f2p0_d2p0_c2p0"
	.file	"ir.ll"
	.globl	modx                            # -- Begin function modx
	.p2align	1
	.type	modx,@function
modx:                                   # @modx
	.cfi_startproc
# %bb.0:                                # %bb_0
.LBB0_2:                                # %bb_0
                                        # Label of block must be emitted
	auipc	a1, %got_pcrel_hi(__GLOBAL_VAR_x)
	ld	a1, %pcrel_lo(.LBB0_2)(a1)
	lw	a0, 0(a1)
	addiw	a0, a0, 2
	sw	a0, 0(a1)
	lw	a0, 4(a1)
	addiw	a0, a0, 2
	sw	a0, 0(a1)
	lw	a0, 8(a1)
	addiw	a0, a0, 2
	sw	a0, 0(a1)
	j	.LBB0_1
.LBB0_1:                                # %bb_1
	ret
.Lfunc_end0:
	.size	modx, .Lfunc_end0-modx
	.cfi_endproc
                                        # -- End function
	.globl	mody                            # -- Begin function mody
	.p2align	1
	.type	mody,@function
mody:                                   # @mody
	.cfi_startproc
# %bb.0:                                # %bb_2
.LBB1_2:                                # %bb_2
                                        # Label of block must be emitted
	auipc	a1, %got_pcrel_hi(__GLOBAL_VAR_y)
	ld	a1, %pcrel_lo(.LBB1_2)(a1)
	lw	a0, 0(a1)
	addiw	a0, a0, 2
	sw	a0, 0(a1)
	lw	a0, 4(a1)
	addiw	a0, a0, 2
	sw	a0, 0(a1)
	lw	a0, 8(a1)
	addiw	a0, a0, 2
	sw	a0, 0(a1)
	j	.LBB1_1
.LBB1_1:                                # %bb_3
	ret
.Lfunc_end1:
	.size	mody, .Lfunc_end1-mody
	.cfi_endproc
                                        # -- End function
	.globl	refx                            # -- Begin function refx
	.p2align	1
	.type	refx,@function
refx:                                   # @refx
	.cfi_startproc
# %bb.0:                                # %bb_4
.LBB2_2:                                # %bb_4
                                        # Label of block must be emitted
	auipc	a1, %got_pcrel_hi(__GLOBAL_VAR_x)
	ld	a1, %pcrel_lo(.LBB2_2)(a1)
	lw	a0, 0(a1)
	lw	a2, 4(a1)
	addw	a0, a0, a2
	lw	a1, 8(a1)
	addw	a0, a0, a1
.LBB2_3:                                # %bb_4
                                        # Label of block must be emitted
	auipc	a1, %got_pcrel_hi(__GLOBAL_VAR_d)
	ld	a1, %pcrel_lo(.LBB2_3)(a1)
	sw	a0, 0(a1)
	j	.LBB2_1
.LBB2_1:                                # %bb_5
	ret
.Lfunc_end2:
	.size	refx, .Lfunc_end2-refx
	.cfi_endproc
                                        # -- End function
	.globl	refy                            # -- Begin function refy
	.p2align	1
	.type	refy,@function
refy:                                   # @refy
	.cfi_startproc
# %bb.0:                                # %bb_6
.LBB3_2:                                # %bb_6
                                        # Label of block must be emitted
	auipc	a1, %got_pcrel_hi(__GLOBAL_VAR_y)
	ld	a1, %pcrel_lo(.LBB3_2)(a1)
	lw	a0, 0(a1)
	lw	a2, 4(a1)
	addw	a0, a0, a2
	lw	a1, 8(a1)
	addw	a0, a0, a1
.LBB3_3:                                # %bb_6
                                        # Label of block must be emitted
	auipc	a1, %got_pcrel_hi(__GLOBAL_VAR_d)
	ld	a1, %pcrel_lo(.LBB3_3)(a1)
	sw	a0, 0(a1)
	j	.LBB3_1
.LBB3_1:                                # %bb_7
	ret
.Lfunc_end3:
	.size	refy, .Lfunc_end3-refy
	.cfi_endproc
                                        # -- End function
	.globl	modxrefy                        # -- Begin function modxrefy
	.p2align	1
	.type	modxrefy,@function
modxrefy:                               # @modxrefy
	.cfi_startproc
# %bb.0:                                # %bb_8
.LBB4_2:                                # %bb_8
                                        # Label of block must be emitted
	auipc	a0, %got_pcrel_hi(__GLOBAL_VAR_y)
	ld	a0, %pcrel_lo(.LBB4_2)(a0)
	lw	a1, 0(a0)
	addiw	a2, a1, 3
.LBB4_3:                                # %bb_8
                                        # Label of block must be emitted
	auipc	a1, %got_pcrel_hi(__GLOBAL_VAR_x)
	ld	a1, %pcrel_lo(.LBB4_3)(a1)
	sw	a2, 0(a1)
	lw	a2, 4(a0)
	addiw	a2, a2, 4
	sw	a2, 0(a1)
	lw	a0, 8(a0)
	addiw	a0, a0, 5
	sw	a0, 0(a1)
	j	.LBB4_1
.LBB4_1:                                # %bb_9
	ret
.Lfunc_end4:
	.size	modxrefy, .Lfunc_end4-modxrefy
	.cfi_endproc
                                        # -- End function
	.globl	modyrefx                        # -- Begin function modyrefx
	.p2align	1
	.type	modyrefx,@function
modyrefx:                               # @modyrefx
	.cfi_startproc
# %bb.0:                                # %bb_10
.LBB5_2:                                # %bb_10
                                        # Label of block must be emitted
	auipc	a0, %got_pcrel_hi(__GLOBAL_VAR_x)
	ld	a0, %pcrel_lo(.LBB5_2)(a0)
	lw	a1, 0(a0)
	addiw	a2, a1, 5
.LBB5_3:                                # %bb_10
                                        # Label of block must be emitted
	auipc	a1, %got_pcrel_hi(__GLOBAL_VAR_y)
	ld	a1, %pcrel_lo(.LBB5_3)(a1)
	sw	a2, 0(a1)
	lw	a2, 4(a0)
	addiw	a2, a2, 6
	sw	a2, 0(a1)
	lw	a0, 8(a0)
	addiw	a0, a0, 7
	sw	a0, 0(a1)
	j	.LBB5_1
.LBB5_1:                                # %bb_11
	ret
.Lfunc_end5:
	.size	modyrefx, .Lfunc_end5-modyrefx
	.cfi_endproc
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	1
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:                                # %bb_12
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sd	ra, 40(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
.LBB6_2:                                # %bb_12
                                        # Label of block must be emitted
	auipc	a0, %got_pcrel_hi(__GLOBAL_VAR_x)
	ld	a0, %pcrel_lo(.LBB6_2)(a0)
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	lw	a0, 8(a0)
	sw	a0, 36(sp)
	lw	a0, 36(sp)
	call	putint@plt
	li	a0, 10
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	call	putch@plt
	ld	a1, 8(sp)                       # 8-byte Folded Reload
.LBB6_3:                                # %bb_12
                                        # Label of block must be emitted
	auipc	a2, %got_pcrel_hi(__GLOBAL_VAR_y)
	ld	a2, %pcrel_lo(.LBB6_3)(a2)
	li	a0, 3
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	sw	a0, 0(a2)
	lw	a0, 36(sp)
	lw	a1, 8(a1)
	addw	a0, a0, a1
	sw	a0, 36(sp)
	lw	a0, 36(sp)
	call	putint@plt
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	call	putch@plt
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	sw	a0, 0(a1)
	lw	a0, 36(sp)
	lw	a1, 8(a1)
	addw	a0, a0, a1
.LBB6_4:                                # %bb_12
                                        # Label of block must be emitted
	auipc	a1, %got_pcrel_hi(__GLOBAL_VAR_d)
	ld	a1, %pcrel_lo(.LBB6_4)(a1)
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	lw	a1, 0(a1)
	addw	a0, a0, a1
	sw	a0, 36(sp)
	lw	a0, 36(sp)
	call	putint@plt
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	call	putch@plt
	ld	a2, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	li	a0, 5
	sw	a0, 0(a1)
	lw	a0, 36(sp)
	lw	a2, 8(a2)
	addw	a0, a0, a2
	lw	a1, 0(a1)
	addw	a0, a0, a1
	addw	a0, a0, a1
	sw	a0, 36(sp)
	lw	a0, 36(sp)
	call	putint@plt
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	call	putch@plt
	call	refx@plt
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	lw	a0, 0(a0)
	call	putint@plt
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	call	putch@plt
	j	.LBB6_1
.LBB6_1:                                # %bb_13
	lw	a0, 32(sp)
	ld	ra, 40(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 48
	ret
.Lfunc_end6:
	.size	main, .Lfunc_end6-main
	.cfi_endproc
                                        # -- End function
	.type	__GLOBAL_VAR_x,@object          # @__GLOBAL_VAR_x
	.data
	.globl	__GLOBAL_VAR_x
	.p2align	2
__GLOBAL_VAR_x:
	.word	2344                            # 0x928
	.word	1232                            # 0x4d0
	.word	3435                            # 0xd6b
	.size	__GLOBAL_VAR_x, 12

	.type	__GLOBAL_VAR_y,@object          # @__GLOBAL_VAR_y
	.globl	__GLOBAL_VAR_y
	.p2align	2
__GLOBAL_VAR_y:
	.word	234                             # 0xea
	.word	566                             # 0x236
	.word	127378                          # 0x1f192
	.size	__GLOBAL_VAR_y, 12

	.type	__GLOBAL_VAR_d,@object          # @__GLOBAL_VAR_d
	.section	.sbss,"aw",@nobits
	.globl	__GLOBAL_VAR_d
	.p2align	2
__GLOBAL_VAR_d:
	.zero	4
	.size	__GLOBAL_VAR_d, 4

	.section	".note.GNU-stack","",@progbits
