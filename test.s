	.text
	.attribute	4, 16
	.attribute	5, "rv64i2p0_m2p0_a2p0_f2p0_d2p0_c2p0"
	.file	"ir.ll"
	.section	.sdata,"aw",@progbits
	.p2align	2                               # -- Begin function DFS
.LCPI0_0:
	.word	0x40400000                      # float 3
.LCPI0_1:
	.word	0x3f800000                      # float 1
	.text
	.globl	DFS
	.p2align	1
	.type	DFS,@function
DFS:                                    # @DFS
	.cfi_startproc
# %bb.0:                                # %bb_0
	addi	sp, sp, -2032
	.cfi_def_cfa_offset 2032
	sd	ra, 2024(sp)                    # 8-byte Folded Spill
	sd	s0, 2016(sp)                    # 8-byte Folded Spill
	.cfi_offset ra, -8
	.cfi_offset s0, -16
	addi	s0, sp, 2032
	.cfi_def_cfa s0, 0
	addi	sp, sp, -2048
	addi	sp, sp, -48
	lui	a2, 1048575
	addiw	a2, a2, -24
	add	a2, a2, s0
	sd	a1, 0(a2)                       # 8-byte Folded Spill
	lui	a2, 1048575
	addiw	a2, a2, -12
	add	a2, a2, s0
	fsw	fa2, 0(a2)                      # 4-byte Folded Spill
	lui	a2, 1048575
	addiw	a2, a2, -8
	add	a2, a2, s0
	fsw	fa1, 0(a2)                      # 4-byte Folded Spill
	lui	a2, 1048575
	addiw	a2, a2, -4
	add	a2, a2, s0
	fsw	fa0, 0(a2)                      # 4-byte Folded Spill
                                        # kill: def $x12 killed $x10
	lui	a2, 1048575
	addiw	a2, a2, 40
	add	a2, a2, s0
	sw	a0, 0(a2)
	lui	a0, 1048575
	addiw	a0, a0, 40
	add	a0, a0, s0
	lui	a2, 1048575
	addiw	a2, a2, 36
	add	a2, a2, s0
	sd	a0, 0(a2)
	lui	a2, 1048575
	addiw	a2, a2, 36
	add	a2, a2, s0
	lw	a2, 0(a2)
	slli	a3, a2, 2
.LBB0_7:                                # %bb_0
                                        # Label of block must be emitted
	auipc	a2, %got_pcrel_hi(__GLOBAL_VAR_ff)
	ld	a2, %pcrel_lo(.LBB0_7)(a2)
	add	a3, a3, a2
	lui	a2, 1048575
	addiw	a2, a2, 32
	add	a2, a2, s0
	fsw	fa2, 0(a2)
	lui	a2, 1048575
	addiw	a2, a2, 32
	add	a2, a2, s0
	flw	ft0, 0(a2)
	lui	a2, 1048575
	addiw	a2, a2, 28
	add	a2, a2, s0
	sd	a0, 0(a2)
	lui	a2, 1048575
	addiw	a2, a2, 28
	add	a2, a2, s0
	lw	a2, 0(a2)
	slli	a4, a2, 2
.LBB0_8:                                # %bb_0
                                        # Label of block must be emitted
	auipc	a2, %got_pcrel_hi(__GLOBAL_VAR_a)
	ld	a2, %pcrel_lo(.LBB0_8)(a2)
	add	a4, a4, a2
	flw	ft1, 0(a4)
	lui	a4, 1048575
	addiw	a4, a4, 24
	add	a4, a4, s0
	fsw	fa0, 0(a4)
	lui	a4, 1048575
	addiw	a4, a4, 24
	add	a4, a4, s0
	flw	ft2, 0(a4)
.LBB0_9:                                # %bb_0
                                        # Label of block must be emitted
	auipc	a4, %pcrel_hi(.LCPI0_0)
	addi	a4, a4, %pcrel_lo(.LBB0_9)
	flw	ft4, 0(a4)
	fmul.s	ft2, ft2, ft4
	lui	a4, 1048575
	addiw	a4, a4, 20
	add	a4, a4, s0
	fsw	fa1, 0(a4)
	lui	a4, 1048575
	addiw	a4, a4, 20
	add	a4, a4, s0
	flw	ft3, 0(a4)
	fmul.s	ft3, ft3, ft4
	fadd.s	ft3, ft2, ft3
.LBB0_10:                               # %bb_0
                                        # Label of block must be emitted
	auipc	a4, %pcrel_hi(.LCPI0_1)
	addi	a4, a4, %pcrel_lo(.LBB0_10)
	flw	ft2, 0(a4)
	fadd.s	ft3, ft3, ft2
	fmul.s	ft1, ft1, ft3
	fadd.s	ft0, ft0, ft1
	fsw	ft0, 0(a3)
	lui	a3, 1048575
	addiw	a3, a3, 16
	add	a3, a3, s0
	sd	a0, 0(a3)
	lui	a3, 1048575
	addiw	a3, a3, 16
	add	a3, a3, s0
	lw	a3, 0(a3)
	slli	a3, a3, 2
	add	a1, a1, a3
	lui	a3, 1048575
	addiw	a3, a3, 12
	add	a3, a3, s0
	sd	a0, 0(a3)
	lui	a3, 1048575
	addiw	a3, a3, 12
	add	a3, a3, s0
	lw	a3, 0(a3)
	slli	a3, a3, 2
	add	a2, a2, a3
	flw	ft0, 0(a2)
	lui	a2, 1048575
	addiw	a2, a2, 8
	add	a2, a2, s0
	fsw	fa0, 0(a2)
	lui	a2, 1048575
	addiw	a2, a2, 8
	add	a2, a2, s0
	flw	ft1, 0(a2)
	fadd.s	ft1, ft1, ft2
	fmul.s	ft0, ft0, ft1
	fsw	ft0, 0(a1)
	lui	a1, 1048575
	addiw	a1, a1, 4
	add	a1, a1, s0
	sd	a0, 0(a1)
	lui	a0, 1048575
	addiw	a0, a0, 4
	add	a0, a0, s0
	lw	a0, 0(a0)
.LBB0_11:                               # %bb_0
                                        # Label of block must be emitted
	auipc	a1, %got_pcrel_hi(__GLOBAL_VAR_n)
	ld	a1, %pcrel_lo(.LBB0_11)(a1)
	lui	a2, 1048575
	add	a2, a2, s0
	sd	a1, 0(a2)
	lui	a1, 1048575
	add	a1, a1, s0
	lw	a1, 0(a1)
	bne	a0, a1, .LBB0_2
	j	.LBB0_1
.LBB0_1:                                # %bb_2
	lui	a0, 1048575
	addiw	a0, a0, -24
	add	a0, a0, s0
	ld	a1, 0(a0)                       # 8-byte Folded Reload
	mv	a0, sp
	addi	a2, a0, -16
	mv	sp, a2
	lui	a2, 1048575
	addiw	a2, a2, 40
	add	a2, a2, s0
	sd	a2, -16(a0)
	lw	a0, -16(a0)
	fcvt.s.w	fa0, a0
	mv	a0, sp
	addi	a2, a0, -16
	mv	sp, a2
	sd	a1, -16(a0)
	ld	a0, -16(a0)
	call	putfarray@plt
	lui	a0, 1048575
	addiw	a0, a0, -8
	add	a0, a0, s0
	flw	ft0, 0(a0)                      # 4-byte Folded Reload
	mv	a0, sp
	addi	a1, a0, -16
	mv	sp, a1
	fsw	ft0, -16(a0)
	flw	ft0, -16(a0)
	lui	a0, 1048575
	addiw	a0, a0, 44
	add	a0, a0, s0
	fsw	ft0, 0(a0)
	j	.LBB0_6
.LBB0_2:                                # %bb_3
	mv	a0, sp
	addi	a0, a0, -16
	mv	sp, a0
	li	a0, 0
	sw	a0, -28(s0)
	j	.LBB0_3
.LBB0_3:                                # %bb_4
                                        # =>This Inner Loop Header: Depth=1
	mv	a0, sp
	addi	a1, a0, -16
	mv	sp, a1
	addi	a1, s0, -28
	sd	a1, -16(a0)
	lw	a0, -16(a0)
	mv	a1, sp
	addi	a2, a1, -16
	mv	sp, a2
.LBB0_12:                               # %bb_4
                                        #   in Loop: Header=BB0_3 Depth=1
                                        # Label of block must be emitted
	auipc	a2, %got_pcrel_hi(__GLOBAL_VAR_n)
	ld	a2, %pcrel_lo(.LBB0_12)(a2)
	sd	a2, -16(a1)
	lw	a1, -16(a1)
	bge	a0, a1, .LBB0_5
	j	.LBB0_4
.LBB0_4:                                # %bb_5
                                        #   in Loop: Header=BB0_3 Depth=1
	lui	a0, 1048575
	addiw	a0, a0, -12
	add	a0, a0, s0
	flw	ft1, 0(a0)                      # 4-byte Folded Reload
	lui	a0, 1048575
	addiw	a0, a0, -8
	add	a0, a0, s0
	flw	ft2, 0(a0)                      # 4-byte Folded Reload
	lui	a0, 1048575
	addiw	a0, a0, -4
	add	a0, a0, s0
	flw	ft3, 0(a0)                      # 4-byte Folded Reload
	lui	a0, 1048575
	addiw	a0, a0, -24
	add	a0, a0, s0
	ld	a2, 0(a0)                       # 8-byte Folded Reload
	mv	a0, sp
	addi	a1, a0, -16
	mv	sp, a1
	addi	a1, s0, -28
	sd	a1, -16(a0)
	lw	a0, -16(a0)
	slli	a3, a0, 2
	lui	a0, 1048575
	addiw	a0, a0, 48
	add	a0, a0, s0
	add	a0, a0, a3
	mv	a3, sp
	addi	a4, a3, -16
	mv	sp, a4
	sd	a1, -16(a3)
	lw	a3, -16(a3)
	slli	a3, a3, 2
	add	a2, a2, a3
	flw	ft0, 0(a2)
	mv	a2, sp
	addi	a3, a2, -16
	mv	sp, a3
	fsw	ft3, -16(a2)
	flw	ft3, -16(a2)
	fadd.s	ft0, ft0, ft3
	mv	a2, sp
	addi	a3, a2, -16
	mv	sp, a3
	fsw	ft2, -16(a2)
	flw	ft2, -16(a2)
	fadd.s	ft0, ft0, ft2
	mv	a2, sp
	addi	a3, a2, -16
	mv	sp, a3
	fsw	ft1, -16(a2)
	flw	ft1, -16(a2)
	fadd.s	ft0, ft0, ft1
	fsw	ft0, 0(a0)
	mv	a0, sp
	addi	a2, a0, -16
	mv	sp, a2
	sd	a1, -16(a0)
	lw	a0, -16(a0)
	addiw	a0, a0, 1
	sw	a0, -28(s0)
	j	.LBB0_3
.LBB0_5:                                # %bb_6
	lui	a0, 1048575
	addiw	a0, a0, -8
	add	a0, a0, s0
	flw	ft2, 0(a0)                      # 4-byte Folded Reload
	lui	a0, 1048575
	addiw	a0, a0, -4
	add	a0, a0, s0
	flw	ft1, 0(a0)                      # 4-byte Folded Reload
	lui	a0, 1048575
	addiw	a0, a0, -24
	add	a0, a0, s0
	ld	a1, 0(a0)                       # 8-byte Folded Reload
	mv	a0, sp
	addi	a0, a0, -16
	mv	sp, a0
	mv	a0, sp
	addi	a2, a0, -16
	mv	sp, a2
	lui	a2, 1048575
	addiw	a2, a2, 40
	add	a2, a2, s0
	sd	a2, -16(a0)
	lw	a0, -16(a0)
	addiw	a0, a0, 1
	mv	a3, sp
	addi	a4, a3, -16
	mv	sp, a4
	sd	a2, -16(a3)
	lw	a3, -16(a3)
	slli	a3, a3, 2
	add	a1, a1, a3
	flw	fa0, 0(a1)
	mv	a1, sp
	addi	a3, a1, -16
	mv	sp, a3
	sd	a2, -16(a1)
	lw	a1, -16(a1)
	slli	a3, a1, 2
.LBB0_13:                               # %bb_6
                                        # Label of block must be emitted
	auipc	a1, %got_pcrel_hi(__GLOBAL_VAR_a)
	ld	a1, %pcrel_lo(.LBB0_13)(a1)
	add	a1, a1, a3
	flw	ft0, 0(a1)
	mv	a1, sp
	addi	a3, a1, -16
	mv	sp, a3
	fsw	ft1, -16(a1)
	flw	ft1, -16(a1)
	mv	a1, sp
	addi	a3, a1, -16
	mv	sp, a3
	fsw	ft2, -16(a1)
	flw	ft2, -16(a1)
	fadd.s	ft2, ft2, ft2
	fadd.s	ft1, ft1, ft2
.LBB0_14:                               # %bb_6
                                        # Label of block must be emitted
	auipc	a1, %pcrel_hi(.LCPI0_1)
	addi	a1, a1, %pcrel_lo(.LBB0_14)
	flw	ft2, 0(a1)
	fadd.s	ft1, ft1, ft2
	fmul.s	fa1, ft0, ft1
	mv	a1, sp
	addi	a3, a1, -16
	mv	sp, a3
	sd	a2, -16(a1)
	lw	a1, -16(a1)
	slli	a2, a1, 2
.LBB0_15:                               # %bb_6
                                        # Label of block must be emitted
	auipc	a1, %got_pcrel_hi(__GLOBAL_VAR_ff)
	ld	a1, %pcrel_lo(.LBB0_15)(a1)
	add	a1, a1, a2
	flw	fa2, 0(a1)
	lui	a1, 1048575
	addiw	a1, a1, 48
	add	a1, a1, s0
	call	DFS@plt
	lui	a0, 1048575
	addiw	a0, a0, 44
	add	a0, a0, s0
	fsw	fa0, 0(a0)
	j	.LBB0_6
.LBB0_6:                                # %bb_1
	lui	a0, 1048575
	addiw	a0, a0, 44
	add	a0, a0, s0
	flw	fa0, 0(a0)
	lui	a0, 1
	addiw	a0, a0, 32
	sub	sp, s0, a0
	addi	sp, sp, 2032
	addi	sp, sp, 64
	ld	ra, 2024(sp)                    # 8-byte Folded Reload
	ld	s0, 2016(sp)                    # 8-byte Folded Reload
	addi	sp, sp, 2032
	ret
.Lfunc_end0:
	.size	DFS, .Lfunc_end0-DFS
	.cfi_endproc
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	1
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:                                # %bb_7
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sd	ra, 8(sp)                       # 8-byte Folded Spill
	.cfi_offset ra, -8
.LBB1_2:                                # %bb_7
                                        # Label of block must be emitted
	auipc	a0, %got_pcrel_hi(__GLOBAL_VAR_a)
	ld	a0, %pcrel_lo(.LBB1_2)(a0)
	call	getfarray@plt
	li	a0, 0
	sw	a0, 4(sp)
	j	.LBB1_1
.LBB1_1:                                # %bb_8
	lw	a0, 4(sp)
	ld	ra, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
	.cfi_endproc
                                        # -- End function
	.type	__GLOBAL_CONST_maxn,@object     # @__GLOBAL_CONST_maxn
	.section	.sdata,"aw",@progbits
	.globl	__GLOBAL_CONST_maxn
	.p2align	2
__GLOBAL_CONST_maxn:
	.word	1005                            # 0x3ed
	.size	__GLOBAL_CONST_maxn, 4

	.type	__GLOBAL_VAR_n,@object          # @__GLOBAL_VAR_n
	.globl	__GLOBAL_VAR_n
	.p2align	2
__GLOBAL_VAR_n:
	.word	1000                            # 0x3e8
	.size	__GLOBAL_VAR_n, 4

	.type	__GLOBAL_VAR_m,@object          # @__GLOBAL_VAR_m
	.section	.sbss,"aw",@nobits
	.globl	__GLOBAL_VAR_m
	.p2align	2
__GLOBAL_VAR_m:
	.zero	4
	.size	__GLOBAL_VAR_m, 4

	.type	__GLOBAL_VAR_a,@object          # @__GLOBAL_VAR_a
	.bss
	.globl	__GLOBAL_VAR_a
	.p2align	4
__GLOBAL_VAR_a:
	.zero	4020
	.size	__GLOBAL_VAR_a, 4020

	.type	__GLOBAL_VAR_ff,@object         # @__GLOBAL_VAR_ff
	.globl	__GLOBAL_VAR_ff
	.p2align	4
__GLOBAL_VAR_ff:
	.zero	4020
	.size	__GLOBAL_VAR_ff, 4020

	.section	".note.GNU-stack","",@progbits
