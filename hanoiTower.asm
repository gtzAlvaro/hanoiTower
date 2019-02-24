#Author:	Alvaro
#Description:	hanoiTowers
#Date:		2-22-19

.text
main:
	addi $a0, $a0, 8		#total number of disks
	sll $a0, $a0, 4
	addi $a0, $a0, 1		#origin rod
	sll $a0, $a0, 4
	addi $a0, $a0, 3		#destiny rod
	sll $a0, $a0, 4
	addi $a0, $a0, 2		#temporary rod
	addi $t0, $t0, 0x00001000
	
##	add $t1, $t1, $a0	#value used to draw disk in data segment
##draw: 
##	sw $t1, ($a1)
##	addi $t1, $t1, -1
##	addi $a1, $a1, 4
##	bne $t1, $zero, draw
	jal hanoiTower
	j exit

hanoiTower:
	andi $t1, $a0, 0x0000F000
	bne $t1, $t0, else		#if number of disks is not equal to one then store parameter values and call function again
	andi $t7, $a0, 0x00000FF0	#print area
	jr $ra
else:
	addi $sp, $sp, -4	#save space in stack for 2 data packages
	sw $a0, 0($sp)		#store number of disks first, origin rod, destiny rod and temporary rod
	sw $ra, 4($sp)		#store return address
	addi $sp, $sp, -4
	
	addi $a0, $a0, -0x00001000	#reduce the number of disks by one
	andi $t1, $a0, 0x000000F0
	srl $t1, $t1, 4
	andi $t2, $a0, 0x0000000F
	sll $t2, $t2, 4
	add $t1, $t1, $t2
	andi $a0, $a0, 0x0000FF00
	add $a0, $a0, $t1
	
	jal hanoiTower
	
	lw $a0, 4($sp)		#load number of disks from parent function
	lw $a1, 8($sp)		#load origin rod from parent function

	andi $t7, $a0, 0x00000FF0	#print area

	addi $a0, $a0, -0x00001000	#reduce the number of disks by one
	andi $t1, $a0, 0x00000F00
	srl $t1, $t1, 8
	andi $t2, $a0, 0x0000000F
	sll $t2, $t2, 8
	add $t1, $t1, $t2
	andi $a0, $a0, 0x0000F0F0
	add $a0, $a0, $t1
	
	jal hanoiTower
	addi $sp, $sp, 8
	lw $ra, ($sp)
	jr $ra
	
exit:
