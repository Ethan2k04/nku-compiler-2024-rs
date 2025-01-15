	.attribute arch, "rv64imafdc_zba_zbb"
	.text
	.global getint
	.align 1
	.type getint, @function
getint:

	.global putint
	.align 1
	.type putint, @function
putint:

	.global getch
	.align 1
	.type getch, @function
getch:

	.global putch
	.align 1
	.type putch, @function
putch:

	.global getfloat
	.align 1
	.type getfloat, @function
getfloat:

	.global putfloat
	.align 1
	.type putfloat, @function
putfloat:

	.global getarray
	.align 1
	.type getarray, @function
getarray:

	.global putarray
	.align 1
	.type putarray, @function
putarray:

	.global getfarray
	.align 1
	.type getfarray, @function
getfarray:

	.global putfarray
	.align 1
	.type putfarray, @function
putfarray:

	.global starttime
	.align 1
	.type starttime, @function
starttime:

	.global stoptime
	.align 1
	.type stoptime, @function
stoptime:

	.global memset
	.align 1
	.type memset, @function
memset:

	.global memcpy
	.align 1
	.type memcpy, @function
memcpy:

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

	.type __GLOBAL_VAR_a, @object
	.bss
	.global __GLOBAL_VAR_a
	.align 2
__GLOBAL_VAR_a:
	.zero 0


