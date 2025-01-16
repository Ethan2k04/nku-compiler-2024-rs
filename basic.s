	.attribute arch, "rv64imafdc_zba_zbb"
	.text
	.extern getint
	.global getint

	.extern putint
	.global putint

	.extern getch
	.global getch

	.extern putch
	.global putch

	.extern getfloat
	.global getfloat

	.extern putfloat
	.global putfloat

	.extern getarray
	.global getarray

	.extern putarray
	.global putarray

	.extern getfarray
	.global getfarray

	.extern putfarray
	.global putfarray

	.extern starttime
	.global starttime

	.extern stoptime
	.global stoptime

	.extern memset
	.global memset

	.extern memcpy
	.global memcpy

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

	.type __GLOBAL_VAR_a, @object
	.bss
	.global __GLOBAL_VAR_a
	.align 2
__GLOBAL_VAR_a:
	.zero 4


