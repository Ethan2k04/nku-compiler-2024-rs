	.text
	.attribute	4, 16
	.attribute	5, "rv64i2p0_m2p0_a2p0_f2p0_d2p0_c2p0"
	.file	"ir.ll"
	.globl	f                               # -- Begin function f
	.p2align	1
	.type	f,@function
f:                                      # @f
	.cfi_startproc
# %bb.0:                                # %bb_0
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	sd	ra, 56(sp)                      # 8-byte Folded Spill
	sd	s0, 48(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	.cfi_offset s0, -16
	addi	s0, sp, 64
	.cfi_def_cfa s0, 0
	sd	a3, -56(s0)                     # 8-byte Folded Spill
	sd	a2, -48(s0)                     # 8-byte Folded Spill
	sd	a1, -40(s0)                     # 8-byte Folded Spill
	sd	a0, -32(s0)                     # 8-byte Folded Spill
                                        # kill: def $x10 killed $x14
	sw	a4, -24(s0)
	lw	a0, -24(s0)
	li	a1, 0
	bne	a0, a1, .LBB0_2
	j	.LBB0_1
.LBB0_1:                                # %bb_2
	j	.LBB0_6
.LBB0_2:                                # %bb_3
	mv	a0, sp
	addi	a0, a0, -16
	mv	sp, a0
	li	a0, 0
	sw	a0, -20(s0)
	j	.LBB0_3
.LBB0_3:                                # %bb_4
                                        # =>This Inner Loop Header: Depth=1
	lw	a1, -20(s0)
	li	a0, 99
	blt	a0, a1, .LBB0_5
	j	.LBB0_4
.LBB0_4:                                # %bb_5
                                        #   in Loop: Header=BB0_3 Depth=1
	ld	a0, -48(s0)                     # 8-byte Folded Reload
	ld	a1, -40(s0)                     # 8-byte Folded Reload
	ld	a2, -32(s0)                     # 8-byte Folded Reload
	ld	a5, -56(s0)                     # 8-byte Folded Reload
	lw	a3, -20(s0)
	slli	a6, a3, 2
	add	a4, a2, a6
	add	a3, a0, a6
	lw	a3, 0(a3)
	add	a7, a1, a6
	lw	a7, 0(a7)
	addw	a3, a3, a7
	add	a6, a6, a5
	lw	a6, 0(a6)
	addw	a3, a3, a6
	sw	a3, 0(a4)
	lw	a3, -20(s0)
	slli	a6, a3, 2
	add	a4, a1, a6
	add	a3, a2, a6
	lw	a3, 0(a3)
	add	a7, a0, a6
	lw	a7, 0(a7)
	addw	a3, a3, a7
	add	a6, a6, a5
	lw	a6, 0(a6)
	addw	a3, a3, a6
	sw	a3, 0(a4)
	lw	a3, -20(s0)
	slli	a6, a3, 2
	add	a4, a0, a6
	add	a3, a1, a6
	lw	a3, 0(a3)
	add	a7, a2, a6
	lw	a7, 0(a7)
	addw	a3, a3, a7
	add	a5, a5, a6
	lw	a5, 0(a5)
	addw	a3, a3, a5
	sw	a3, 0(a4)
	lw	a3, -20(s0)
	slli	a3, a3, 2
	add	a5, a2, a3
	lw	a4, 0(a5)
	lui	a2, 586982
	addiw	a2, a2, 929
	mul	a3, a4, a2
	srli	a3, a3, 32
	addw	a3, a3, a4
	srliw	a6, a3, 31
	sraiw	a3, a3, 17
	addw	a6, a3, a6
	lui	a3, 57
	addiw	a3, a3, 673
	mulw	a6, a6, a3
	subw	a4, a4, a6
	sw	a4, 0(a5)
	lw	a4, -20(s0)
	slli	a4, a4, 2
	add	a4, a4, a1
	lw	a1, 0(a4)
	mul	a5, a1, a2
	srli	a5, a5, 32
	addw	a5, a5, a1
	srliw	a6, a5, 31
	sraiw	a5, a5, 17
	addw	a5, a5, a6
	mulw	a5, a5, a3
	subw	a1, a1, a5
	sw	a1, 0(a4)
	lw	a1, -20(s0)
	slli	a1, a1, 2
	add	a1, a1, a0
	lw	a0, 0(a1)
	mul	a2, a0, a2
	srli	a2, a2, 32
	addw	a2, a2, a0
	srliw	a4, a2, 31
	sraiw	a2, a2, 17
	addw	a2, a2, a4
	mulw	a2, a2, a3
	subw	a0, a0, a2
	sw	a0, 0(a1)
	lw	a0, -20(s0)
	addiw	a0, a0, 1
	sw	a0, -20(s0)
	j	.LBB0_3
.LBB0_5:                                # %bb_6
	ld	a3, -56(s0)                     # 8-byte Folded Reload
	ld	a2, -32(s0)                     # 8-byte Folded Reload
	ld	a1, -48(s0)                     # 8-byte Folded Reload
	ld	a0, -40(s0)                     # 8-byte Folded Reload
	mv	a4, sp
	addi	a4, a4, -16
	mv	sp, a4
	lw	a4, -24(s0)
	addiw	a4, a4, -1
	call	f@plt
	j	.LBB0_6
.LBB0_6:                                # %bb_1
	addi	sp, s0, -64
	ld	ra, 56(sp)                      # 8-byte Folded Reload
	ld	s0, 48(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 64
	ret
.Lfunc_end0:
	.size	f, .Lfunc_end0-f
	.cfi_endproc
                                        # -- End function
	.globl	sum                             # -- Begin function sum
	.p2align	1
	.type	sum,@function
sum:                                    # @sum
	.cfi_startproc
# %bb.0:                                # %bb_7
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sd	ra, 40(sp)                      # 8-byte Folded Spill
	sd	s0, 32(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	.cfi_offset s0, -16
	addi	s0, sp, 48
	.cfi_def_cfa s0, 0
	sd	a0, -40(s0)                     # 8-byte Folded Spill
	li	a0, 0
	sw	a0, -24(s0)
	sw	a0, -20(s0)
	j	.LBB1_1
.LBB1_1:                                # %bb_9
                                        # =>This Inner Loop Header: Depth=1
	lw	a1, -24(s0)
	li	a0, 99
	blt	a0, a1, .LBB1_3
	j	.LBB1_2
.LBB1_2:                                # %bb_10
                                        #   in Loop: Header=BB1_1 Depth=1
	ld	a1, -40(s0)                     # 8-byte Folded Reload
	lw	a0, -20(s0)
	lw	a2, -24(s0)
	slli	a2, a2, 2
	add	a1, a1, a2
	lw	a1, 0(a1)
	addw	a0, a0, a1
	sw	a0, -20(s0)
	lw	a0, -24(s0)
	addiw	a0, a0, 1
	sw	a0, -24(s0)
	j	.LBB1_1
.LBB1_3:                                # %bb_11
	mv	a0, sp
	addi	a0, a0, -16
	mv	sp, a0
	lw	a0, -20(s0)
	sw	a0, -28(s0)
	j	.LBB1_4
.LBB1_4:                                # %bb_8
	lw	a0, -28(s0)
	addi	sp, s0, -48
	ld	ra, 40(sp)                      # 8-byte Folded Reload
	ld	s0, 32(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 48
	ret
.Lfunc_end1:
	.size	sum, .Lfunc_end1-sum
	.cfi_endproc
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	1
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:                                # %bb_12
	addi	sp, sp, -144
	.cfi_def_cfa_offset 144
	sd	ra, 136(sp)                     # 8-byte Folded Spill
	sd	s0, 128(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	.cfi_offset s0, -16
	addi	s0, sp, 144
	.cfi_def_cfa s0, 0
	li	a0, 0
	sw	a0, -24(s0)
	j	.LBB2_1
.LBB2_1:                                # %bb_14
                                        # =>This Inner Loop Header: Depth=1
	lw	a1, -24(s0)
	li	a0, 99
	blt	a0, a1, .LBB2_3
	j	.LBB2_2
.LBB2_2:                                # %bb_15
                                        #   in Loop: Header=BB2_1 Depth=1
	lw	a0, -24(s0)
	slli	a2, a0, 2
.LBB2_5:                                # %bb_15
                                        #   in Loop: Header=BB2_1 Depth=1
                                        # Label of block must be emitted
	auipc	a1, %got_pcrel_hi(__GLOBAL_VAR_A)
	ld	a1, %pcrel_lo(.LBB2_5)(a1)
	add	a1, a1, a2
	slli	a2, a0, 1
	srli	a2, a2, 62
	addw	a0, a0, a2
	sraiw	a0, a0, 2
	addiw	a0, a0, 1
	sw	a0, 0(a1)
	lw	a0, -24(s0)
	slli	a2, a0, 2
.LBB2_6:                                # %bb_15
                                        #   in Loop: Header=BB2_1 Depth=1
                                        # Label of block must be emitted
	auipc	a1, %got_pcrel_hi(__GLOBAL_VAR_B)
	ld	a1, %pcrel_lo(.LBB2_6)(a1)
	add	a1, a1, a2
	lui	a2, 349525
	addiw	a2, a2, 1366
	mul	a0, a0, a2
	srli	a2, a0, 63
	srli	a0, a0, 32
	addw	a0, a0, a2
	addiw	a0, a0, 2
	sw	a0, 0(a1)
	lwu	a0, -24(s0)
	sext.w	a1, a0
	slli	a2, a1, 2
.LBB2_7:                                # %bb_15
                                        #   in Loop: Header=BB2_1 Depth=1
                                        # Label of block must be emitted
	auipc	a1, %got_pcrel_hi(__GLOBAL_VAR_C)
	ld	a1, %pcrel_lo(.LBB2_7)(a1)
	add	a1, a1, a2
	srli	a2, a0, 31
	addw	a0, a0, a2
	sraiw	a0, a0, 1
	addiw	a0, a0, 3
	sw	a0, 0(a1)
	lw	a0, -24(s0)
	slli	a2, a0, 2
.LBB2_8:                                # %bb_15
                                        #   in Loop: Header=BB2_1 Depth=1
                                        # Label of block must be emitted
	auipc	a1, %got_pcrel_hi(__GLOBAL_VAR_D)
	ld	a1, %pcrel_lo(.LBB2_8)(a1)
	add	a1, a1, a2
	addiw	a0, a0, 4
	sw	a0, 0(a1)
	lw	a0, -24(s0)
	addiw	a0, a0, 1
	sw	a0, -24(s0)
	j	.LBB2_1
.LBB2_3:                                # %bb_16
	mv	a0, sp
	addi	a0, a0, -16
	mv	sp, a0
	li	a0, 0
	sd	a0, -40(s0)                     # 8-byte Folded Spill
	sw	a0, -20(s0)
	lw	a0, -20(s0)
	sd	a0, -136(s0)                    # 8-byte Folded Spill
.LBB2_9:                                # %bb_16
                                        # Label of block must be emitted
	auipc	a0, %got_pcrel_hi(__GLOBAL_VAR_D)
	ld	a0, %pcrel_lo(.LBB2_9)(a0)
	sd	a0, -48(s0)                     # 8-byte Folded Spill
	call	sum@plt
	ld	a3, -48(s0)                     # 8-byte Folded Reload
	mv	a1, a0
	ld	a0, -136(s0)                    # 8-byte Folded Reload
	addw	a0, a0, a1
	sw	a0, -20(s0)
.LBB2_10:                               # %bb_16
                                        # Label of block must be emitted
	auipc	a0, %got_pcrel_hi(__GLOBAL_VAR_A)
	ld	a0, %pcrel_lo(.LBB2_10)(a0)
	sd	a0, -80(s0)                     # 8-byte Folded Spill
.LBB2_11:                               # %bb_16
                                        # Label of block must be emitted
	auipc	a1, %got_pcrel_hi(__GLOBAL_VAR_B)
	ld	a1, %pcrel_lo(.LBB2_11)(a1)
	sd	a1, -72(s0)                     # 8-byte Folded Spill
.LBB2_12:                               # %bb_16
                                        # Label of block must be emitted
	auipc	a2, %got_pcrel_hi(__GLOBAL_VAR_C)
	ld	a2, %pcrel_lo(.LBB2_12)(a2)
	sd	a2, -64(s0)                     # 8-byte Folded Spill
	li	a4, 10
	sd	a4, -88(s0)                     # 8-byte Folded Spill
	call	f@plt
	ld	a0, -48(s0)                     # 8-byte Folded Reload
	lw	a1, -20(s0)
	sd	a1, -128(s0)                    # 8-byte Folded Spill
	call	sum@plt
	ld	a4, -88(s0)                     # 8-byte Folded Reload
	ld	a2, -80(s0)                     # 8-byte Folded Reload
	ld	a3, -48(s0)                     # 8-byte Folded Reload
	mv	a1, a0
	ld	a0, -128(s0)                    # 8-byte Folded Reload
	addw	a0, a0, a1
	sw	a0, -20(s0)
	mv	a0, a2
	mv	a1, a2
	call	f@plt
	ld	a0, -48(s0)                     # 8-byte Folded Reload
	lw	a1, -20(s0)
	sd	a1, -120(s0)                    # 8-byte Folded Spill
	call	sum@plt
	ld	a1, -120(s0)                    # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, -80(s0)                     # 8-byte Folded Reload
	addw	a1, a1, a2
	sw	a1, -20(s0)
	lw	a1, -20(s0)
	sd	a1, -112(s0)                    # 8-byte Folded Spill
	call	sum@plt
	ld	a4, -88(s0)                     # 8-byte Folded Reload
	ld	a3, -80(s0)                     # 8-byte Folded Reload
	ld	a2, -48(s0)                     # 8-byte Folded Reload
	mv	a1, a0
	ld	a0, -112(s0)                    # 8-byte Folded Reload
	addw	a0, a0, a1
	sw	a0, -20(s0)
	mv	a0, a2
	mv	a1, a2
	call	f@plt
	ld	a0, -80(s0)                     # 8-byte Folded Reload
	lw	a1, -20(s0)
	sd	a1, -104(s0)                    # 8-byte Folded Spill
	call	sum@plt
	ld	a1, -104(s0)                    # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, -48(s0)                     # 8-byte Folded Reload
	addw	a1, a1, a2
	sw	a1, -20(s0)
	lw	a1, -20(s0)
	sd	a1, -96(s0)                     # 8-byte Folded Spill
	call	sum@plt
	mv	a1, a0
	ld	a0, -96(s0)                     # 8-byte Folded Reload
	addw	a0, a0, a1
	sw	a0, -20(s0)
	lw	a0, -20(s0)
	call	putint@plt
	ld	a0, -88(s0)                     # 8-byte Folded Reload
	call	putch@plt
	ld	a1, -80(s0)                     # 8-byte Folded Reload
	li	a0, 100
	sd	a0, -56(s0)                     # 8-byte Folded Spill
	call	putarray@plt
	ld	a1, -72(s0)                     # 8-byte Folded Reload
	ld	a0, -56(s0)                     # 8-byte Folded Reload
	call	putarray@plt
	ld	a1, -64(s0)                     # 8-byte Folded Reload
	ld	a0, -56(s0)                     # 8-byte Folded Reload
	call	putarray@plt
	ld	a0, -56(s0)                     # 8-byte Folded Reload
	ld	a1, -48(s0)                     # 8-byte Folded Reload
	call	putarray@plt
	ld	a0, -40(s0)                     # 8-byte Folded Reload
	sw	a0, -28(s0)
	j	.LBB2_4
.LBB2_4:                                # %bb_13
	lw	a0, -28(s0)
	addi	sp, s0, -144
	ld	ra, 136(sp)                     # 8-byte Folded Reload
	ld	s0, 128(sp)                     # 8-byte Folded Reload
	addi	sp, sp, 144
	ret
.Lfunc_end2:
	.size	main, .Lfunc_end2-main
	.cfi_endproc
                                        # -- End function
	.type	__GLOBAL_VAR_A,@object          # @__GLOBAL_VAR_A
	.bss
	.globl	__GLOBAL_VAR_A
	.p2align	4
__GLOBAL_VAR_A:
	.zero	400
	.size	__GLOBAL_VAR_A, 400

	.type	__GLOBAL_VAR_B,@object          # @__GLOBAL_VAR_B
	.globl	__GLOBAL_VAR_B
	.p2align	4
__GLOBAL_VAR_B:
	.zero	400
	.size	__GLOBAL_VAR_B, 400

	.type	__GLOBAL_VAR_C,@object          # @__GLOBAL_VAR_C
	.globl	__GLOBAL_VAR_C
	.p2align	4
__GLOBAL_VAR_C:
	.zero	400
	.size	__GLOBAL_VAR_C, 400

	.type	__GLOBAL_VAR_D,@object          # @__GLOBAL_VAR_D
	.globl	__GLOBAL_VAR_D
	.p2align	4
__GLOBAL_VAR_D:
	.zero	400
	.size	__GLOBAL_VAR_D, 400

	.type	__GLOBAL_CONST_p,@object        # @__GLOBAL_CONST_p
	.section	.sdata,"aw",@progbits
	.globl	__GLOBAL_CONST_p
	.p2align	2
__GLOBAL_CONST_p:
	.word	234145                          # 0x392a1
	.size	__GLOBAL_CONST_p, 4

	.section	".note.GNU-stack","",@progbits
