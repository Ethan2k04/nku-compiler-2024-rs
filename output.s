	.attribute arch, "rv64imafdc_zba_zbb"
	.text
	.global main
	.align 1
	.type main, @function
main:
.Lbb_0:
	addi sp, sp, -48
	sd ra, 40(sp)
	sd s0, 32(sp)
	sw zero, 4(sp)
	sw zero, 8(sp)
	sw zero, 12(sp)
	sw zero, 16(sp)
	sw zero, 4(sp)
	sw zero, 8(sp)
	sw zero, 12(sp)
	j .Lbb_2
.Lbb_2:
	lw t6, 4(sp)
	slti t5, t6, 21
	bne t5, zero, .Lbb_3
	j .Lbb_4
.Lbb_3:
	j .Lbb_5
.Lbb_5:
	lw t5, 8(sp)
	lw t6, 4(sp)
	addiw t4, t6, -101
	slt t6, t5, t4
	bne t6, zero, .Lbb_6
	j .Lbb_7
.Lbb_6:
	lw t6, 4(sp)
	addiw t4, t6, -100
	lw t6, 8(sp)
	subw t5, t4, t6
	sw t5, 12(sp)
	lw t5, 4(sp)
	li t6, 5
	mulw t4, t6, t5
	lw t6, 8(sp)
	li t5, 1
	mulw t3, t5, t6
	addw t5, t4, t3
	lw t3, 12(sp)
	li t4, 2
	divw t6, t3, t4
	addw t4, t5, t6
	li t6, 100
	xor t5, t4, t6
	sltiu t6, t5, 1
	bne t6, zero, .Lbb_8
	j .Lbb_9
.Lbb_8:
	lw t6, 4(sp)
	addi a0, t6, 0
	call putint
	lw t6, 8(sp)
	addi a0, t6, 0
	call putint
	lw t6, 12(sp)
	addi a0, t6, 0
	call putint
	li t6, 10
	sw t6, 16(sp)
	lw t6, 16(sp)
	addi a0, t6, 0
	call putch
	j .Lbb_9
.Lbb_9:
	lw t6, 8(sp)
	addiw t5, t6, 1
	sw t5, 8(sp)
	j .Lbb_5
.Lbb_7:
	lw t5, 4(sp)
	addiw t6, t5, 1
	sw t6, 4(sp)
	j .Lbb_2
.Lbb_4:
	sw zero, 0(sp)
	j .Lbb_1
.Lbb_1:
	lw t6, 0(sp)
	addi a0, t6, 0
	ld ra, 40(sp)
	ld s0, 32(sp)
	addi sp, sp, 48
	ret

