#Author:	Alvaro
#Description:	hanoiTowers
#Date:		2-22-19

.text
main:
	addi $a0, $a0, 8		#total number of disks
	addi $a1, $a1, 1		#origin rod
	addi $a2, $a2, 3		#destiny rod
	addi $a3, $a3, 2		#temporary rod
	addi $t0, $t0, 1
	addi $s1, $s1, 0x10010000
	addi $s2, $s2, 0x10010020
	addi $s3, $s3, 0x10010040
	addi $t1, $a0, 0
while:
	sw $t1, ($s1)
	addi $s1, $s1, 4
	addi $t1, $t1, -1
	bne $t1, $zero, while
	jal hanoiTower
	j exit

hanoiTower:
	bne $a0, $t0, else	#if number of disks is not equal to one then store parameter values and call function again
	sw $ra, ($sp)
	jal draw
	lw $ra, ($sp)
	jr $ra
else:
	addi $sp, $sp, -20	#save space in stack for 2 data packages
	sw $a0, 4($sp)		#store number of disks
	sw $a1, 8($sp)		#store origin rod
	sw $a2, 12($sp)		#store destiny rod
	sw $a3, 16($sp)		#store temporary rod
	sw $ra, 20($sp)		#store return address
	
	addi $a0, $a0, -1	#reduce the number of disks by one
	sll $t1, $a2, 0		#temporarly store destiny rod
	sll $a2, $a3, 0		#change destiny rod with temporary rod
	sll $a3, $t1, 0
	
	jal hanoiTower
	
	lw $a0, 4($sp)		#load number of disks
	lw $a1, 8($sp)		#load origin rod
	lw $a2, 12($sp)		#load destiny rod
	lw $a3, 16($sp)		#load temporary rod
	lw $ra, 20($sp)		#load return address

	sw $ra, ($sp)
	jal draw
	lw $ra, ($sp)
	
	addi $a0, $a0, -1	#reduce the number of disks by one
	sll $t1, $a1, 0		#temporarly store destiny rod
	sll $a1, $a3, 0		#change destiny rod with temporary rod
	sll $a3, $t1, 0
	
	jal hanoiTower
	addi $sp, $sp, 20
	lw $ra, ($sp)
	jr $ra

draw:
	bne $a1, 1, notOne
	addi $s1, $s1, -4
	lw $t1, ($s1)
	sw $zero, ($s1)
	j destinyRod
notOne:
	bne $a1, 2, notTwo
	addi $s2, $s2, -4
	lw $t1, ($s2)
	sw $zero, ($s2)
	j destinyRod
notTwo:	
	addi $s3, $s3, -4
	lw $t1, ($s3)
	sw $zero, ($s3)
	
destinyRod:
	bne $a2, 1, isTwo
	sw $t1, ($s1)
	addi $s1, $s1, 4
	jr $ra
isTwo:	
	bne $a2, 2, isThree
	sw $t1, ($s2)
	addi $s2, $s2, 4
	jr $ra
isThree:	
	sw $t1, ($s3)
	addi $s3, $s3, 4	
	jr $ra

exit:
