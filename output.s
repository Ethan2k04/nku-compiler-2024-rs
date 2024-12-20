	.text
	.attribute	4, 16
	.attribute	5, "rv64i2p0_m2p0_a2p0_f2p0_d2p0_c2p0"
	.file	"ir.ll"
	.globl	equal                           # -- Begin function equal
	.p2align	1
	.type	equal,@function
equal:                                  # @equal
	.cfi_startproc
# %bb.0:                                # %bb_0
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sd	ra, 24(sp)                      # 8-byte Folded Spill
	sd	s0, 16(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	.cfi_offset s0, -16
	addi	s0, sp, 32
	.cfi_def_cfa s0, 0
                                        # kill: def $x12 killed $x11
                                        # kill: def $x12 killed $x10
	sw	a0, -28(s0)
	sw	a1, -24(s0)
	lw	a0, -28(s0)
	lw	a1, -24(s0)
	bne	a0, a1, .LBB0_2
	j	.LBB0_1
.LBB0_1:                                # %bb_2
	li	a0, 1
	sw	a0, -20(s0)
	j	.LBB0_3
.LBB0_2:                                # %bb_3
	mv	a0, sp
	addi	a0, a0, -16
	mv	sp, a0
	li	a0, 0
	sw	a0, -20(s0)
	j	.LBB0_3
.LBB0_3:                                # %bb_1
	lw	a0, -20(s0)
	addi	sp, s0, -32
	ld	ra, 24(sp)                      # 8-byte Folded Reload
	ld	s0, 16(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end0:
	.size	equal, .Lfunc_end0-equal
	.cfi_endproc
                                        # -- End function
	.globl	dfs                             # -- Begin function dfs
	.p2align	1
	.type	dfs,@function
dfs:                                    # @dfs
	.cfi_startproc
# %bb.0:                                # %bb_4
	addi	sp, sp, -160
	.cfi_def_cfa_offset 160
	sd	ra, 152(sp)                     # 8-byte Folded Spill
	sd	s0, 144(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	.cfi_offset s0, -16
	addi	s0, sp, 160
	.cfi_def_cfa s0, 0
                                        # kill: def $x16 killed $x15
                                        # kill: def $x16 killed $x14
                                        # kill: def $x16 killed $x13
                                        # kill: def $x16 killed $x12
                                        # kill: def $x16 killed $x11
                                        # kill: def $x16 killed $x10
	sw	a0, -48(s0)
	sw	a1, -44(s0)
	sw	a2, -40(s0)
	sw	a3, -36(s0)
	sw	a4, -32(s0)
	sw	a5, -28(s0)
	lw	a0, -48(s0)
	lw	a5, -44(s0)
	lw	a4, -40(s0)
	lw	a3, -36(s0)
	lw	a2, -32(s0)
	lw	a1, -28(s0)
	lui	a6, 40
	addiw	a6, a6, -544
	mul	a5, a5, a6
	lui	a6, 718
	addiw	a6, a6, -1600
	mul	a6, a0, a6
.LBB1_16:                               # %bb_4
                                        # Label of block must be emitted
	auipc	a0, %got_pcrel_hi(__GLOBAL_VAR_dp)
	ld	a0, %pcrel_lo(.LBB1_16)(a0)
	add	a0, a0, a6
	add	a0, a0, a5
	lui	a5, 2
	addiw	a5, a5, 880
	mul	a4, a4, a5
	add	a0, a0, a4
	li	a4, 504
	mul	a3, a3, a4
	add	a0, a0, a3
	li	a3, 28
	mul	a2, a2, a3
	add	a0, a0, a2
	slli	a1, a1, 2
	add	a0, a0, a1
	lw	a0, 0(a0)
	li	a1, -1
	beq	a0, a1, .LBB1_2
	j	.LBB1_1
.LBB1_1:                                # %bb_6
	lw	a0, -48(s0)
	lw	a5, -44(s0)
	lw	a4, -40(s0)
	lw	a3, -36(s0)
	lw	a2, -32(s0)
	lw	a1, -28(s0)
	lui	a6, 40
	addiw	a6, a6, -544
	mul	a5, a5, a6
	lui	a6, 718
	addiw	a6, a6, -1600
	mul	a6, a0, a6
.LBB1_17:                               # %bb_6
                                        # Label of block must be emitted
	auipc	a0, %got_pcrel_hi(__GLOBAL_VAR_dp)
	ld	a0, %pcrel_lo(.LBB1_17)(a0)
	add	a0, a0, a6
	add	a0, a0, a5
	lui	a5, 2
	addiw	a5, a5, 880
	mul	a4, a4, a5
	add	a0, a0, a4
	li	a4, 504
	mul	a3, a3, a4
	add	a0, a0, a3
	li	a3, 28
	mul	a2, a2, a3
	add	a0, a0, a2
	slli	a1, a1, 2
	add	a0, a0, a1
	lw	a0, 0(a0)
	sw	a0, -24(s0)
	j	.LBB1_15
.LBB1_2:                                # %bb_7
	mv	a0, sp
	addi	a0, a0, -16
	mv	sp, a0
	lw	a0, -48(s0)
	lw	a1, -44(s0)
	addw	a0, a0, a1
	lw	a1, -40(s0)
	addw	a0, a0, a1
	lw	a1, -36(s0)
	addw	a0, a0, a1
	lw	a1, -32(s0)
	addw	a0, a0, a1
	li	a1, 0
	bne	a0, a1, .LBB1_4
	j	.LBB1_3
.LBB1_3:                                # %bb_8
	li	a0, 1
	sw	a0, -24(s0)
	j	.LBB1_15
.LBB1_4:                                # %bb_9
	mv	a0, sp
	addi	a0, a0, -16
	mv	sp, a0
	li	a1, 0
	sw	a1, -20(s0)
	lw	a0, -48(s0)
	beq	a0, a1, .LBB1_6
	j	.LBB1_5
.LBB1_5:                                # %bb_10
	lw	a0, -20(s0)
	sd	a0, -56(s0)                     # 8-byte Folded Spill
	lw	a0, -48(s0)
	sd	a0, -72(s0)                     # 8-byte Folded Spill
	lw	a0, -28(s0)
	li	a1, 2
	call	equal@plt
	mv	a1, a0
	ld	a0, -72(s0)                     # 8-byte Folded Reload
	subw	a0, a0, a1
	sd	a0, -64(s0)                     # 8-byte Folded Spill
	lw	a0, -48(s0)
	addiw	a0, a0, -1
	lw	a4, -32(s0)
	lw	a3, -36(s0)
	lw	a2, -40(s0)
	lw	a1, -44(s0)
	li	a5, 1
	call	dfs@plt
	ld	a1, -64(s0)                     # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, -56(s0)                     # 8-byte Folded Reload
	mulw	a1, a1, a2
	addw	a0, a0, a1
	lui	a1, 281475
	addiw	a1, a1, -103
	mul	a1, a0, a1
	srli	a2, a1, 63
	srai	a1, a1, 60
	addw	a1, a1, a2
	lui	a2, 244141
	addiw	a2, a2, -1529
	mulw	a1, a1, a2
	subw	a0, a0, a1
	sw	a0, -20(s0)
	j	.LBB1_6
.LBB1_6:                                # %bb_11
	mv	a0, sp
	addi	a0, a0, -16
	mv	sp, a0
	lw	a0, -44(s0)
	li	a1, 0
	beq	a0, a1, .LBB1_8
	j	.LBB1_7
.LBB1_7:                                # %bb_12
	lw	a0, -20(s0)
	sd	a0, -80(s0)                     # 8-byte Folded Spill
	lw	a0, -44(s0)
	sd	a0, -96(s0)                     # 8-byte Folded Spill
	lw	a0, -28(s0)
	li	a1, 3
	call	equal@plt
	mv	a1, a0
	ld	a0, -96(s0)                     # 8-byte Folded Reload
	subw	a0, a0, a1
	sd	a0, -88(s0)                     # 8-byte Folded Spill
	lw	a0, -48(s0)
	addiw	a0, a0, 1
	lw	a1, -44(s0)
	addiw	a1, a1, -1
	lw	a4, -32(s0)
	lw	a3, -36(s0)
	lw	a2, -40(s0)
	li	a5, 2
	call	dfs@plt
	ld	a1, -88(s0)                     # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, -80(s0)                     # 8-byte Folded Reload
	mulw	a1, a1, a2
	addw	a0, a0, a1
	lui	a1, 281475
	addiw	a1, a1, -103
	mul	a1, a0, a1
	srli	a2, a1, 63
	srai	a1, a1, 60
	addw	a1, a1, a2
	lui	a2, 244141
	addiw	a2, a2, -1529
	mulw	a1, a1, a2
	subw	a0, a0, a1
	sw	a0, -20(s0)
	j	.LBB1_8
.LBB1_8:                                # %bb_13
	mv	a0, sp
	addi	a0, a0, -16
	mv	sp, a0
	lw	a0, -40(s0)
	li	a1, 0
	beq	a0, a1, .LBB1_10
	j	.LBB1_9
.LBB1_9:                                # %bb_14
	lw	a0, -20(s0)
	sd	a0, -104(s0)                    # 8-byte Folded Spill
	lw	a0, -40(s0)
	sd	a0, -120(s0)                    # 8-byte Folded Spill
	lw	a0, -28(s0)
	li	a1, 4
	call	equal@plt
	mv	a1, a0
	ld	a0, -120(s0)                    # 8-byte Folded Reload
	subw	a0, a0, a1
	sd	a0, -112(s0)                    # 8-byte Folded Spill
	lw	a0, -44(s0)
	addiw	a1, a0, 1
	lw	a0, -40(s0)
	addiw	a2, a0, -1
	lw	a4, -32(s0)
	lw	a3, -36(s0)
	lw	a0, -48(s0)
	li	a5, 3
	call	dfs@plt
	ld	a1, -112(s0)                    # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, -104(s0)                    # 8-byte Folded Reload
	mulw	a1, a1, a2
	addw	a0, a0, a1
	lui	a1, 281475
	addiw	a1, a1, -103
	mul	a1, a0, a1
	srli	a2, a1, 63
	srai	a1, a1, 60
	addw	a1, a1, a2
	lui	a2, 244141
	addiw	a2, a2, -1529
	mulw	a1, a1, a2
	subw	a0, a0, a1
	sw	a0, -20(s0)
	j	.LBB1_10
.LBB1_10:                               # %bb_15
	mv	a0, sp
	addi	a0, a0, -16
	mv	sp, a0
	lw	a0, -36(s0)
	li	a1, 0
	beq	a0, a1, .LBB1_12
	j	.LBB1_11
.LBB1_11:                               # %bb_16
	lw	a0, -20(s0)
	sd	a0, -128(s0)                    # 8-byte Folded Spill
	lw	a0, -36(s0)
	sd	a0, -144(s0)                    # 8-byte Folded Spill
	lw	a0, -28(s0)
	li	a1, 5
	call	equal@plt
	mv	a1, a0
	ld	a0, -144(s0)                    # 8-byte Folded Reload
	subw	a0, a0, a1
	sd	a0, -136(s0)                    # 8-byte Folded Spill
	lw	a0, -40(s0)
	addiw	a2, a0, 1
	lw	a0, -36(s0)
	addiw	a3, a0, -1
	lw	a4, -32(s0)
	lw	a1, -44(s0)
	lw	a0, -48(s0)
	li	a5, 4
	call	dfs@plt
	ld	a1, -136(s0)                    # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, -128(s0)                    # 8-byte Folded Reload
	mulw	a1, a1, a2
	addw	a0, a0, a1
	lui	a1, 281475
	addiw	a1, a1, -103
	mul	a1, a0, a1
	srli	a2, a1, 63
	srai	a1, a1, 60
	addw	a1, a1, a2
	lui	a2, 244141
	addiw	a2, a2, -1529
	mulw	a1, a1, a2
	subw	a0, a0, a1
	sw	a0, -20(s0)
	j	.LBB1_12
.LBB1_12:                               # %bb_17
	mv	a0, sp
	addi	a0, a0, -16
	mv	sp, a0
	lw	a0, -32(s0)
	li	a1, 0
	beq	a0, a1, .LBB1_14
	j	.LBB1_13
.LBB1_13:                               # %bb_18
	lw	a0, -20(s0)
	sd	a0, -152(s0)                    # 8-byte Folded Spill
	lw	a0, -32(s0)
	sd	a0, -160(s0)                    # 8-byte Folded Spill
	lw	a1, -36(s0)
	addiw	a3, a1, 1
	addiw	a4, a0, -1
	lw	a2, -40(s0)
	lw	a1, -44(s0)
	lw	a0, -48(s0)
	li	a5, 5
	call	dfs@plt
	ld	a1, -160(s0)                    # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, -152(s0)                    # 8-byte Folded Reload
	mulw	a1, a1, a2
	addw	a0, a0, a1
	lui	a1, 281475
	addiw	a1, a1, -103
	mul	a1, a0, a1
	srli	a2, a1, 63
	srai	a1, a1, 60
	addw	a1, a1, a2
	lui	a2, 244141
	addiw	a2, a2, -1529
	mulw	a1, a1, a2
	subw	a0, a0, a1
	sw	a0, -20(s0)
	j	.LBB1_14
.LBB1_14:                               # %bb_19
	mv	a0, sp
	addi	a0, a0, -16
	mv	sp, a0
	lw	a0, -48(s0)
	lw	a1, -44(s0)
	lw	a5, -40(s0)
	lw	a3, -36(s0)
	lw	a4, -32(s0)
	lw	a2, -28(s0)
	lui	a6, 40
	addiw	t3, a6, -544
	mul	a6, a1, t3
	lui	a1, 718
	addiw	t2, a1, -1600
	mul	a1, a0, t2
.LBB1_18:                               # %bb_19
                                        # Label of block must be emitted
	auipc	a0, %got_pcrel_hi(__GLOBAL_VAR_dp)
	ld	a0, %pcrel_lo(.LBB1_18)(a0)
	add	a1, a1, a0
	add	a1, a1, a6
	lui	a6, 2
	addiw	a7, a6, 880
	mul	a5, a5, a7
	add	a1, a1, a5
	li	a5, 504
	mul	a3, a3, a5
	add	a1, a1, a3
	li	a3, 28
	mul	a4, a4, a3
	add	a1, a1, a4
	slli	a2, a2, 2
	add	a2, a2, a1
	lw	a1, -20(s0)
	lui	a4, 281475
	addiw	a4, a4, -103
	mul	a4, a1, a4
	srli	a6, a4, 63
	srai	a4, a4, 60
	addw	a4, a4, a6
	lui	a6, 244141
	addiw	a6, a6, -1529
	mulw	a4, a4, a6
	subw	a1, a1, a4
	sw	a1, 0(a2)
	lw	t1, -48(s0)
	lw	t0, -44(s0)
	lw	a6, -40(s0)
	lw	a4, -36(s0)
	lw	a2, -32(s0)
	lw	a1, -28(s0)
	mul	t0, t0, t3
	mul	t1, t1, t2
	add	a0, a0, t1
	add	a0, a0, t0
	mul	a6, a6, a7
	add	a0, a0, a6
	mul	a4, a4, a5
	add	a0, a0, a4
	mul	a2, a2, a3
	add	a0, a0, a2
	slli	a1, a1, 2
	add	a0, a0, a1
	lw	a0, 0(a0)
	sw	a0, -24(s0)
	j	.LBB1_15
.LBB1_15:                               # %bb_5
	lw	a0, -24(s0)
	addi	sp, s0, -160
	ld	ra, 152(sp)                     # 8-byte Folded Reload
	ld	s0, 144(sp)                     # 8-byte Folded Reload
	addi	sp, sp, 160
	ret
.Lfunc_end1:
	.size	dfs, .Lfunc_end1-dfs
	.cfi_endproc
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	1
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:                                # %bb_20
	addi	sp, sp, -80
	.cfi_def_cfa_offset 80
	sd	ra, 72(sp)                      # 8-byte Folded Spill
	sd	s0, 64(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	.cfi_offset s0, -16
	addi	s0, sp, 80
	.cfi_def_cfa s0, 0
	call	getint@plt
	sw	a0, -48(s0)
	li	a0, 0
	sw	a0, -44(s0)
	j	.LBB2_1
.LBB2_1:                                # %bb_22
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_3 Depth 2
                                        #       Child Loop BB2_5 Depth 3
                                        #         Child Loop BB2_7 Depth 4
                                        #           Child Loop BB2_9 Depth 5
                                        #             Child Loop BB2_11 Depth 6
	lw	a1, -44(s0)
	li	a0, 17
	blt	a0, a1, .LBB2_18
	j	.LBB2_2
.LBB2_2:                                # %bb_23
                                        #   in Loop: Header=BB2_1 Depth=1
	li	a0, 0
	sw	a0, -40(s0)
	j	.LBB2_3
.LBB2_3:                                # %bb_25
                                        #   Parent Loop BB2_1 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB2_5 Depth 3
                                        #         Child Loop BB2_7 Depth 4
                                        #           Child Loop BB2_9 Depth 5
                                        #             Child Loop BB2_11 Depth 6
	lw	a1, -40(s0)
	li	a0, 17
	blt	a0, a1, .LBB2_17
	j	.LBB2_4
.LBB2_4:                                # %bb_26
                                        #   in Loop: Header=BB2_3 Depth=2
	li	a0, 0
	sw	a0, -36(s0)
	j	.LBB2_5
.LBB2_5:                                # %bb_28
                                        #   Parent Loop BB2_1 Depth=1
                                        #     Parent Loop BB2_3 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB2_7 Depth 4
                                        #           Child Loop BB2_9 Depth 5
                                        #             Child Loop BB2_11 Depth 6
	lw	a1, -36(s0)
	li	a0, 17
	blt	a0, a1, .LBB2_16
	j	.LBB2_6
.LBB2_6:                                # %bb_29
                                        #   in Loop: Header=BB2_5 Depth=3
	li	a0, 0
	sw	a0, -32(s0)
	j	.LBB2_7
.LBB2_7:                                # %bb_31
                                        #   Parent Loop BB2_1 Depth=1
                                        #     Parent Loop BB2_3 Depth=2
                                        #       Parent Loop BB2_5 Depth=3
                                        # =>      This Loop Header: Depth=4
                                        #           Child Loop BB2_9 Depth 5
                                        #             Child Loop BB2_11 Depth 6
	lw	a1, -32(s0)
	li	a0, 17
	blt	a0, a1, .LBB2_15
	j	.LBB2_8
.LBB2_8:                                # %bb_32
                                        #   in Loop: Header=BB2_7 Depth=4
	li	a0, 0
	sw	a0, -28(s0)
	j	.LBB2_9
.LBB2_9:                                # %bb_34
                                        #   Parent Loop BB2_1 Depth=1
                                        #     Parent Loop BB2_3 Depth=2
                                        #       Parent Loop BB2_5 Depth=3
                                        #         Parent Loop BB2_7 Depth=4
                                        # =>        This Loop Header: Depth=5
                                        #             Child Loop BB2_11 Depth 6
	lw	a1, -28(s0)
	li	a0, 17
	blt	a0, a1, .LBB2_14
	j	.LBB2_10
.LBB2_10:                               # %bb_35
                                        #   in Loop: Header=BB2_9 Depth=5
	li	a0, 0
	sw	a0, -24(s0)
	j	.LBB2_11
.LBB2_11:                               # %bb_37
                                        #   Parent Loop BB2_1 Depth=1
                                        #     Parent Loop BB2_3 Depth=2
                                        #       Parent Loop BB2_5 Depth=3
                                        #         Parent Loop BB2_7 Depth=4
                                        #           Parent Loop BB2_9 Depth=5
                                        # =>          This Inner Loop Header: Depth=6
	lw	a1, -24(s0)
	li	a0, 6
	blt	a0, a1, .LBB2_13
	j	.LBB2_12
.LBB2_12:                               # %bb_38
                                        #   in Loop: Header=BB2_11 Depth=6
	lw	a0, -44(s0)
	lw	a5, -40(s0)
	lw	a4, -36(s0)
	lw	a3, -32(s0)
	lw	a2, -28(s0)
	lw	a1, -24(s0)
	lui	a6, 40
	addiw	a6, a6, -544
	mul	a5, a5, a6
	lui	a6, 718
	addiw	a6, a6, -1600
	mul	a6, a0, a6
.LBB2_23:                               # %bb_38
                                        #   in Loop: Header=BB2_11 Depth=6
                                        # Label of block must be emitted
	auipc	a0, %got_pcrel_hi(__GLOBAL_VAR_dp)
	ld	a0, %pcrel_lo(.LBB2_23)(a0)
	add	a0, a0, a6
	add	a0, a0, a5
	lui	a5, 2
	addiw	a5, a5, 880
	mul	a4, a4, a5
	add	a0, a0, a4
	li	a4, 504
	mul	a3, a3, a4
	add	a0, a0, a3
	li	a3, 28
	mul	a2, a2, a3
	add	a0, a0, a2
	slli	a1, a1, 2
	add	a1, a1, a0
	li	a0, -1
	sw	a0, 0(a1)
	lw	a0, -24(s0)
	addiw	a0, a0, 1
	sw	a0, -24(s0)
	j	.LBB2_11
.LBB2_13:                               # %bb_39
                                        #   in Loop: Header=BB2_9 Depth=5
	mv	a0, sp
	addi	a0, a0, -16
	mv	sp, a0
	lw	a0, -28(s0)
	addiw	a0, a0, 1
	sw	a0, -28(s0)
	j	.LBB2_9
.LBB2_14:                               # %bb_36
                                        #   in Loop: Header=BB2_7 Depth=4
	mv	a0, sp
	addi	a0, a0, -16
	mv	sp, a0
	lw	a0, -32(s0)
	addiw	a0, a0, 1
	sw	a0, -32(s0)
	j	.LBB2_7
.LBB2_15:                               # %bb_33
                                        #   in Loop: Header=BB2_5 Depth=3
	mv	a0, sp
	addi	a0, a0, -16
	mv	sp, a0
	lw	a0, -36(s0)
	addiw	a0, a0, 1
	sw	a0, -36(s0)
	j	.LBB2_5
.LBB2_16:                               # %bb_30
                                        #   in Loop: Header=BB2_3 Depth=2
	mv	a0, sp
	addi	a0, a0, -16
	mv	sp, a0
	lw	a0, -40(s0)
	addiw	a0, a0, 1
	sw	a0, -40(s0)
	j	.LBB2_3
.LBB2_17:                               # %bb_27
                                        #   in Loop: Header=BB2_1 Depth=1
	mv	a0, sp
	addi	a0, a0, -16
	mv	sp, a0
	lw	a0, -44(s0)
	addiw	a0, a0, 1
	sw	a0, -44(s0)
	j	.LBB2_1
.LBB2_18:                               # %bb_24
	mv	a0, sp
	addi	a0, a0, -16
	mv	sp, a0
	li	a0, 0
	sw	a0, -44(s0)
	j	.LBB2_19
.LBB2_19:                               # %bb_40
                                        # =>This Inner Loop Header: Depth=1
	lw	a0, -44(s0)
	lw	a1, -48(s0)
	bge	a0, a1, .LBB2_21
	j	.LBB2_20
.LBB2_20:                               # %bb_41
                                        #   in Loop: Header=BB2_19 Depth=1
	lw	a0, -44(s0)
	slli	a1, a0, 2
.LBB2_24:                               # %bb_41
                                        #   in Loop: Header=BB2_19 Depth=1
                                        # Label of block must be emitted
	auipc	a0, %got_pcrel_hi(__GLOBAL_VAR_list)
	ld	a0, %pcrel_lo(.LBB2_24)(a0)
	sd	a0, -64(s0)                     # 8-byte Folded Spill
	add	a0, a0, a1
	sd	a0, -72(s0)                     # 8-byte Folded Spill
	call	getint@plt
	ld	a2, -72(s0)                     # 8-byte Folded Reload
	mv	a1, a0
	ld	a0, -64(s0)                     # 8-byte Folded Reload
	sw	a1, 0(a2)
	lw	a1, -44(s0)
	slli	a1, a1, 2
	add	a0, a0, a1
	lw	a0, 0(a0)
	slli	a1, a0, 2
.LBB2_25:                               # %bb_41
                                        #   in Loop: Header=BB2_19 Depth=1
                                        # Label of block must be emitted
	auipc	a0, %got_pcrel_hi(__GLOBAL_VAR_cns)
	ld	a0, %pcrel_lo(.LBB2_25)(a0)
	add	a1, a1, a0
	lw	a0, 0(a1)
	addiw	a0, a0, 1
	sw	a0, 0(a1)
	lw	a0, -44(s0)
	addiw	a0, a0, 1
	sw	a0, -44(s0)
	j	.LBB2_19
.LBB2_21:                               # %bb_42
	mv	a0, sp
	addi	a0, a0, -16
	mv	sp, a0
.LBB2_26:                               # %bb_42
                                        # Label of block must be emitted
	auipc	a0, %got_pcrel_hi(__GLOBAL_VAR_cns)
	ld	a0, %pcrel_lo(.LBB2_26)(a0)
	lw	a4, 20(a0)
	lw	a3, 16(a0)
	lw	a2, 12(a0)
	lw	a1, 8(a0)
	lw	a0, 4(a0)
	li	a5, 0
	call	dfs@plt
	sw	a0, -20(s0)
	lw	a0, -20(s0)
	call	putint@plt
	lw	a0, -20(s0)
	sw	a0, -52(s0)
	j	.LBB2_22
.LBB2_22:                               # %bb_21
	lw	a0, -52(s0)
	addi	sp, s0, -80
	ld	ra, 72(sp)                      # 8-byte Folded Reload
	ld	s0, 64(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 80
	ret
.Lfunc_end2:
	.size	main, .Lfunc_end2-main
	.cfi_endproc
                                        # -- End function
	.type	__GLOBAL_CONST_maxn,@object     # @__GLOBAL_CONST_maxn
	.section	.sdata,"aw",@progbits
	.globl	__GLOBAL_CONST_maxn
	.p2align	2
__GLOBAL_CONST_maxn:
	.word	18                              # 0x12
	.size	__GLOBAL_CONST_maxn, 4

	.type	__GLOBAL_CONST_mod,@object      # @__GLOBAL_CONST_mod
	.globl	__GLOBAL_CONST_mod
	.p2align	2
__GLOBAL_CONST_mod:
	.word	1000000007                      # 0x3b9aca07
	.size	__GLOBAL_CONST_mod, 4

	.type	__GLOBAL_VAR_dp,@object         # @__GLOBAL_VAR_dp
	.bss
	.globl	__GLOBAL_VAR_dp
	.p2align	4
__GLOBAL_VAR_dp:
	.zero	52907904
	.size	__GLOBAL_VAR_dp, 52907904

	.type	__GLOBAL_VAR_list,@object       # @__GLOBAL_VAR_list
	.globl	__GLOBAL_VAR_list
	.p2align	4
__GLOBAL_VAR_list:
	.zero	800
	.size	__GLOBAL_VAR_list, 800

	.type	__GLOBAL_VAR_cns,@object        # @__GLOBAL_VAR_cns
	.globl	__GLOBAL_VAR_cns
	.p2align	4
__GLOBAL_VAR_cns:
	.zero	80
	.size	__GLOBAL_VAR_cns, 80

	.section	".note.GNU-stack","",@progbits
