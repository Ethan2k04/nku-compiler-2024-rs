	.attribute arch, "rv64imafdc_zba_zbb"
	.section .data
	.type __GLOBAL_VAR_a, @object
	.bss
	.global __GLOBAL_VAR_a
	.align 2
__GLOBAL_VAR_a:
	.zero 4


	.section .text
	.extern getint
	.extern putint
	.extern getch
	.extern putch
	.extern getfloat
	.extern putfloat
	.extern getarray
	.extern putarray
	.extern getfarray
	.extern putfarray
	.extern starttime
	.extern stoptime
	.extern memset
	.extern memcpy
	.global main
	.align 1
	.type main, @function
main:
.bb_0:
	sw zero, -8(sp)
	sw zero, -4(sp)
	li t6, 1
	sw t6, -4(sp)
	lw t5, -4(sp)
	sw t5, -12(sp)
	j .bb_1
.bb_1:
	lw t4, -12(sp)
	addi a0, t4, 0
	jr ra

