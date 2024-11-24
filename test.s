	.text
	.attribute	4, 16
	.attribute	5, "rv64i2p0_m2p0_a2p0_f2p0_d2p0_c2p0"
	.file	"ir.ll"
	.globl	add                             # -- Begin function add
	.p2align	1
	.type	add,@function
add:                                    # @add
	.cfi_startproc
# %bb.0:                                # %bb_0
	addi	sp, sp, -96
	.cfi_def_cfa_offset 96
	sd	ra, 88(sp)                      # 8-byte Folded Spill
	sd	s0, 80(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	.cfi_offset s0, -16
	addi	s0, sp, 96
	.cfi_def_cfa s0, 0
	sd	a7, -96(s0)                     # 8-byte Folded Spill
	sd	a6, -88(s0)                     # 8-byte Folded Spill
	sd	a5, -80(s0)                     # 8-byte Folded Spill
	sd	a4, -72(s0)                     # 8-byte Folded Spill
	sd	a3, -64(s0)                     # 8-byte Folded Spill
	sd	a2, -56(s0)                     # 8-byte Folded Spill
	sd	a1, -48(s0)                     # 8-byte Folded Spill
	sd	a0, -40(s0)                     # 8-byte Folded Spill
	ld	a0, 0(s0)
	sd	a0, -32(s0)                     # 8-byte Folded Spill
	li	a0, 0
	sw	a0, -20(s0)
	j	.LBB0_1
.LBB0_1:                                # %bb_2
                                        # =>This Inner Loop Header: Depth=1
	lw	a0, -20(s0)
.LBB0_5:                                # %bb_2
                                        #   in Loop: Header=BB0_1 Depth=1
                                        # Label of block must be emitted
	auipc	a1, %got_pcrel_hi(__GLOBAL_VAR_M)
	ld	a1, %pcrel_lo(.LBB0_5)(a1)
	lw	a1, 0(a1)
	bge	a0, a1, .LBB0_3
	j	.LBB0_2
.LBB0_2:                                # %bb_3
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a2, -80(s0)                     # 8-byte Folded Reload
	ld	a0, -56(s0)                     # 8-byte Folded Reload
	ld	a1, -32(s0)                     # 8-byte Folded Reload
	ld	a5, -72(s0)                     # 8-byte Folded Reload
	ld	a3, -48(s0)                     # 8-byte Folded Reload
	ld	a4, -96(s0)                     # 8-byte Folded Reload
	ld	t0, -64(s0)                     # 8-byte Folded Reload
	ld	a6, -40(s0)                     # 8-byte Folded Reload
	ld	a7, -88(s0)                     # 8-byte Folded Reload
	lw	t1, -20(s0)
	slli	t1, t1, 2
	add	a7, a7, t1
	add	a6, a6, t1
	lw	a6, 0(a6)
	add	t0, t0, t1
	lw	t0, 0(t0)
	addw	a6, a6, t0
	sw	a6, 0(a7)
	lw	a6, -20(s0)
	slli	a6, a6, 2
	add	a4, a4, a6
	add	a3, a3, a6
	lw	a3, 0(a3)
	add	a5, a5, a6
	lw	a5, 0(a5)
	addw	a3, a3, a5
	sw	a3, 0(a4)
	lw	a3, -20(s0)
	slli	a3, a3, 2
	add	a1, a1, a3
	add	a0, a0, a3
	lw	a0, 0(a0)
	add	a2, a2, a3
	lw	a2, 0(a2)
	addw	a0, a0, a2
	sw	a0, 0(a1)
	lw	a0, -20(s0)
	addiw	a0, a0, 1
	sw	a0, -20(s0)
	j	.LBB0_1
.LBB0_3:                                # %bb_4
	mv	a0, sp
	addi	a0, a0, -16
	mv	sp, a0
	li	a0, 0
	sw	a0, -24(s0)
	j	.LBB0_4
.LBB0_4:                                # %bb_1
	lw	a0, -24(s0)
	addi	sp, s0, -96
	ld	ra, 88(sp)                      # 8-byte Folded Reload
	ld	s0, 80(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 96
	ret
.Lfunc_end0:
	.size	add, .Lfunc_end0-add
	.cfi_endproc
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	1
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:                                # %bb_5
	addi	sp, sp, -160
	.cfi_def_cfa_offset 160
	sd	ra, 152(sp)                     # 8-byte Folded Spill
	sd	s0, 144(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	.cfi_offset s0, -16
	addi	s0, sp, 160
	.cfi_def_cfa s0, 0
.LBB1_14:                               # %bb_5
                                        # Label of block must be emitted
	auipc	a1, %got_pcrel_hi(__GLOBAL_VAR_N)
	ld	a1, %pcrel_lo(.LBB1_14)(a1)
	li	a0, 3
	sw	a0, 0(a1)
.LBB1_15:                               # %bb_5
                                        # Label of block must be emitted
	auipc	a1, %got_pcrel_hi(__GLOBAL_VAR_M)
	ld	a1, %pcrel_lo(.LBB1_15)(a1)
	sw	a0, 0(a1)
.LBB1_16:                               # %bb_5
                                        # Label of block must be emitted
	auipc	a1, %got_pcrel_hi(__GLOBAL_VAR_L)
	ld	a1, %pcrel_lo(.LBB1_16)(a1)
	sw	a0, 0(a1)
	li	a0, 0
	sw	a0, -24(s0)
	j	.LBB1_1
.LBB1_1:                                # %bb_7
                                        # =>This Inner Loop Header: Depth=1
	lw	a0, -24(s0)
.LBB1_17:                               # %bb_7
                                        #   in Loop: Header=BB1_1 Depth=1
                                        # Label of block must be emitted
	auipc	a1, %got_pcrel_hi(__GLOBAL_VAR_M)
	ld	a1, %pcrel_lo(.LBB1_17)(a1)
	lw	a1, 0(a1)
	bge	a0, a1, .LBB1_3
	j	.LBB1_2
.LBB1_2:                                # %bb_8
                                        #   in Loop: Header=BB1_1 Depth=1
	lw	a0, -24(s0)
	li	a1, 12
	mul	a3, a0, a1
	addi	a2, s0, -144
	add	a2, a2, a3
	sw	a0, 0(a2)
	lw	a0, -24(s0)
	mul	a3, a0, a1
	addi	a2, s0, -132
	add	a2, a2, a3
	sw	a0, 0(a2)
	lw	a0, -24(s0)
	mul	a3, a0, a1
	addi	a2, s0, -120
	add	a2, a2, a3
	sw	a0, 0(a2)
	lw	a0, -24(s0)
	mul	a3, a0, a1
	addi	a2, s0, -108
	add	a2, a2, a3
	sw	a0, 0(a2)
	lw	a0, -24(s0)
	mul	a3, a0, a1
	addi	a2, s0, -96
	add	a2, a2, a3
	sw	a0, 0(a2)
	lw	a0, -24(s0)
	mul	a2, a0, a1
	addi	a1, s0, -84
	add	a1, a1, a2
	sw	a0, 0(a1)
	lw	a0, -24(s0)
	addiw	a0, a0, 1
	sw	a0, -24(s0)
	j	.LBB1_1
.LBB1_3:                                # %bb_9
	mv	a0, sp
	addi	a0, a0, -16
	mv	sp, a0
	addi	sp, sp, -16
	mv	a1, sp
	addi	a0, s0, -36
	sd	a0, 0(a1)
	addi	a0, s0, -144
	addi	a1, s0, -132
	addi	a2, s0, -120
	addi	a3, s0, -108
	addi	a4, s0, -96
	addi	a5, s0, -84
	addi	a6, s0, -72
	addi	a7, s0, -48
	call	add@plt
	addi	sp, sp, 16
	sw	a0, -24(s0)
	j	.LBB1_4
.LBB1_4:                                # %bb_10
                                        # =>This Inner Loop Header: Depth=1
	lw	a0, -24(s0)
.LBB1_18:                               # %bb_10
                                        #   in Loop: Header=BB1_4 Depth=1
                                        # Label of block must be emitted
	auipc	a1, %got_pcrel_hi(__GLOBAL_VAR_N)
	ld	a1, %pcrel_lo(.LBB1_18)(a1)
	lw	a1, 0(a1)
	bge	a0, a1, .LBB1_6
	j	.LBB1_5
.LBB1_5:                                # %bb_11
                                        #   in Loop: Header=BB1_4 Depth=1
	lw	a0, -24(s0)
	li	a1, 24
	mul	a1, a0, a1
	addi	a0, s0, -72
	add	a0, a0, a1
	lw	a0, 0(a0)
	sw	a0, -20(s0)
	lw	a0, -20(s0)
	call	putint@plt
	lw	a0, -24(s0)
	addiw	a0, a0, 1
	sw	a0, -24(s0)
	j	.LBB1_4
.LBB1_6:                                # %bb_12
	mv	a0, sp
	addi	a0, a0, -16
	mv	sp, a0
	li	a0, 10
	sw	a0, -20(s0)
	lw	a0, -20(s0)
	call	putch@plt
	li	a0, 0
	sw	a0, -24(s0)
	j	.LBB1_7
.LBB1_7:                                # %bb_13
                                        # =>This Inner Loop Header: Depth=1
	lw	a0, -24(s0)
.LBB1_19:                               # %bb_13
                                        #   in Loop: Header=BB1_7 Depth=1
                                        # Label of block must be emitted
	auipc	a1, %got_pcrel_hi(__GLOBAL_VAR_N)
	ld	a1, %pcrel_lo(.LBB1_19)(a1)
	lw	a1, 0(a1)
	bge	a0, a1, .LBB1_9
	j	.LBB1_8
.LBB1_8:                                # %bb_14
                                        #   in Loop: Header=BB1_7 Depth=1
	lw	a0, -24(s0)
	li	a1, 12
	mul	a1, a0, a1
	addi	a0, s0, -48
	add	a0, a0, a1
	lw	a0, 0(a0)
	sw	a0, -20(s0)
	lw	a0, -20(s0)
	call	putint@plt
	lw	a0, -24(s0)
	addiw	a0, a0, 1
	sw	a0, -24(s0)
	j	.LBB1_7
.LBB1_9:                                # %bb_15
	mv	a0, sp
	addi	a0, a0, -16
	mv	sp, a0
	li	a0, 10
	sw	a0, -20(s0)
	lw	a0, -20(s0)
	call	putch@plt
	li	a0, 0
	sw	a0, -24(s0)
	j	.LBB1_10
.LBB1_10:                               # %bb_16
                                        # =>This Inner Loop Header: Depth=1
	lw	a0, -24(s0)
.LBB1_20:                               # %bb_16
                                        #   in Loop: Header=BB1_10 Depth=1
                                        # Label of block must be emitted
	auipc	a1, %got_pcrel_hi(__GLOBAL_VAR_N)
	ld	a1, %pcrel_lo(.LBB1_20)(a1)
	lw	a1, 0(a1)
	bge	a0, a1, .LBB1_12
	j	.LBB1_11
.LBB1_11:                               # %bb_17
                                        #   in Loop: Header=BB1_10 Depth=1
	lw	a0, -24(s0)
	li	a1, 12
	mul	a1, a0, a1
	addi	a0, s0, -36
	add	a0, a0, a1
	lw	a0, 0(a0)
	sw	a0, -20(s0)
	lw	a0, -20(s0)
	call	putint@plt
	lw	a0, -24(s0)
	addiw	a0, a0, 1
	sw	a0, -24(s0)
	j	.LBB1_10
.LBB1_12:                               # %bb_18
	mv	a0, sp
	addi	a0, a0, -16
	mv	sp, a0
	li	a0, 10
	sw	a0, -20(s0)
	lw	a0, -20(s0)
	call	putch@plt
	li	a0, 0
	sw	a0, -148(s0)
	j	.LBB1_13
.LBB1_13:                               # %bb_6
	lw	a0, -148(s0)
	addi	sp, s0, -160
	ld	ra, 152(sp)                     # 8-byte Folded Reload
	ld	s0, 144(sp)                     # 8-byte Folded Reload
	addi	sp, sp, 160
	ret
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
	.cfi_endproc
                                        # -- End function
	.type	__GLOBAL_VAR_M,@object          # @__GLOBAL_VAR_M
	.section	.sbss,"aw",@nobits
	.globl	__GLOBAL_VAR_M
	.p2align	2
__GLOBAL_VAR_M:
	.zero	4
	.size	__GLOBAL_VAR_M, 4

	.type	__GLOBAL_VAR_L,@object          # @__GLOBAL_VAR_L
	.globl	__GLOBAL_VAR_L
	.p2align	2
__GLOBAL_VAR_L:
	.zero	4
	.size	__GLOBAL_VAR_L, 4

	.type	__GLOBAL_VAR_N,@object          # @__GLOBAL_VAR_N
	.globl	__GLOBAL_VAR_N
	.p2align	2
__GLOBAL_VAR_N:
	.zero	4
	.size	__GLOBAL_VAR_N, 4

	.section	".note.GNU-stack","",@progbits
