	.attribute arch, "rv64imafdc_zba_zbb"
	.text
	.global main
	.align 1
	.type main, @function
main:
.Lbb_0:
	addi sp, sp, -32
	sd ra, 24(sp)
	sd s0, 16(sp)
	call getint
	addi t6, a0, 0
	call getint
	addi t5, a0, 0
	addi a0, t5, 0
	call putint
	li t5, 10
	addi a0, t5, 0
	call putch
	addi a0, t6, 0
	call putint
	li t6, 10
	addi a0, t6, 0
	call putch
	sw zero, 0(sp)
	j .Lbb_1
.Lbb_1:
	lw t6, 0(sp)
	addi a0, t6, 0
	ld ra, 24(sp)
	ld s0, 16(sp)
	addi sp, sp, 32
	ret

	.type __GLOBAL_VAR_n, @object
	.bss
	.global __GLOBAL_VAR_n
	.align 2
__GLOBAL_VAR_n:
	.zero 4


