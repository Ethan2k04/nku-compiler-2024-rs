	.attribute arch, "rv64imafdc_zba_zbb"
	.section .data
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
	addi sp, sp, -32
	sw sp, -28(sp)
	sw ra, -32(sp)
	la $r0, __GLOBAL_VAR_a
	lw t6, 0($r0)
	sw t6, 4(sp)
	sw zero, 0(sp)
	j .bb_1
.bb_1:
	sw sp, -28(sp)
	sw ra, -32(sp)
	lw t5, 0(sp)
	addi a0, t5, 0
	addi sp, sp, 32
	jr ra

