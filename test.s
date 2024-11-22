	.text
	.def	@feat.00;
	.scl	3;
	.type	0;
	.endef
	.globl	@feat.00
.set @feat.00, 0
	.file	"ir.ll"
	.def	main;
	.scl	2;
	.type	32;
	.endef
	.globl	main                            # -- Begin function main
	.p2align	4, 0x90
main:                                   # @main
.seh_proc main
# %bb.0:                                # %bb_0
	subq	$32, %rsp
	.seh_stackalloc 32
	.seh_endprologue
                                        # implicit-def: $eax
	movl	%eax, 12(%rsp)
                                        # implicit-def: $eax
	movl	%eax, 16(%rsp)
                                        # implicit-def: $eax
	movl	%eax, 20(%rsp)
                                        # implicit-def: $eax
	movl	%eax, 24(%rsp)
                                        # implicit-def: $eax
	movl	%eax, 28(%rsp)
	movl	$5, 12(%rsp)
	movl	$5, 16(%rsp)
	movl	$1, 20(%rsp)
	movl	$-2, 24(%rsp)
	movl	$2, 28(%rsp)
	movl	24(%rsp), %eax
	shll	$0, %eax
	movl	$2, %ecx
	cltd
	idivl	%ecx
	cmpl	$0, %eax
	setl	%al
	movb	%al, 7(%rsp)                    # 1-byte Spill
	movl	12(%rsp), %eax
	subl	16(%rsp), %eax
	cmpl	$0, %eax
	setne	%cl
	movl	20(%rsp), %eax
	addl	$3, %eax
	movl	$2, %r8d
	cltd
	idivl	%r8d
	movb	7(%rsp), %al                    # 1-byte Reload
	cmpl	$0, %edx
	setne	%dl
	andb	%dl, %cl
	orb	%cl, %al
	testb	$1, %al
	jne	.LBB0_1
	jmp	.LBB0_2
.LBB0_1:                                # %bb_2
	movl	$3, 28(%rsp)
	jmp	.LBB0_3
.LBB0_2:                                # %bb_3
	jmp	.LBB0_3
.LBB0_3:                                # %bb_4
	movl	24(%rsp), %eax
	movl	$2, %ecx
	cltd
	idivl	%ecx
	addl	$67, %edx
	cmpl	$0, %edx
	setl	%al
	movb	%al, 6(%rsp)                    # 1-byte Spill
	movl	12(%rsp), %eax
	subl	16(%rsp), %eax
	cmpl	$0, %eax
	setne	%cl
	movl	20(%rsp), %eax
	addl	$2, %eax
	movl	$2, %r8d
	cltd
	idivl	%r8d
	movb	6(%rsp), %al                    # 1-byte Reload
	cmpl	$0, %edx
	setne	%dl
	andb	%dl, %cl
	orb	%cl, %al
	testb	$1, %al
	jne	.LBB0_4
	jmp	.LBB0_5
.LBB0_4:                                # %bb_5
	movl	$4, 28(%rsp)
	jmp	.LBB0_6
.LBB0_5:                                # %bb_6
	jmp	.LBB0_6
.LBB0_6:                                # %bb_7
	movl	$0, 8(%rsp)
# %bb.7:                                # %bb_1
	movl	8(%rsp), %eax
	addq	$32, %rsp
	retq
	.seh_endproc
                                        # -- End function
	.addrsig
