	.text
	.attribute	4, 16
	.attribute	5, "rv64i2p0_m2p0_a2p0_f2p0_d2p0_c2p0"
	.file	"ir.ll"
	.globl	foo                             # -- Begin function foo
	.p2align	1
	.type	foo,@function
foo:                                    # @foo
	.cfi_startproc
# %bb.0:                                # %bb_0
	mv	a1, a0
	li	a0, 1
	sw	a0, 0(a1)
	j	.LBB0_1
.LBB0_1:                                # %bb_1
	ret
.Lfunc_end0:
	.size	foo, .Lfunc_end0-foo
	.cfi_endproc
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	1
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:                                # %bb_2
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sd	ra, 40(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	li	a1, 1
	sw	a1, 16(sp)
	li	a0, 2
	sw	a0, 20(sp)
	li	a2, 3
	sw	a2, 24(sp)
	li	a2, 4
	sw	a2, 28(sp)
	sw	a1, 32(sp)
	sw	a0, 36(sp)
	addi	a0, sp, 16
	call	foo@plt
	li	a0, 0
	sw	a0, 12(sp)
	j	.LBB1_1
.LBB1_1:                                # %bb_3
	lw	a0, 12(sp)
	ld	ra, 40(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 48
	ret
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
	.cfi_endproc
                                        # -- End function
	.section	".note.GNU-stack","",@progbits
