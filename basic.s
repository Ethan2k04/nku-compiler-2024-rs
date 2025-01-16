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
	.global foo
	.align 1
	.type foo, @function
foo:
.bb_0:
	addi sp, sp, -32
	sw sp, -28(sp)
	sw ra, -32(sp)
	sw a0, -8(sp)
	sw zero, -4(sp)
	j .bb_1
.bb_1:
	lw t6, -4(sp)
	addi a0, t6, 0
	addi sp, sp, 32
	jr ra

	.global main
	.align 1
	.type main, @function
main:
.bb_2:
	addi sp, sp, -32
	sw sp, -28(sp)
	sw ra, -32(sp)
	sw zero, -8(sp)
	sw zero, -4(sp)
	li t5, 1
	sw t5, -4(sp)
	lw t4, -4(sp)
	sw t4, -12(sp)
	j .bb_3
.bb_3:
	lw t3, -12(sp)
	addi a0, t3, 0
	addi sp, sp, 32
	jr ra

