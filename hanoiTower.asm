#Author:	Alvaro
#Description:	hanoiTowers
#Date:		2-22-19

.text
main:
	addi $a0, $a0, 3		#total number of disks
	addi $a1, $a1, 1		#origin rod
	addi $a2, $a2, 3		#destiny rod
	addi $a3, $a3, 2		#temporary rod
	addi $t0, $t0, 1
	addi $s1, $s1, 0x10010000
	addi $s2, $s2, 0x10010040
	addi $s3, $s3, 0x10010020
	addi $t1, $a0, 0
while:
	sw $t1, ($s1)
	addi $s1, $s1, 4
	addi $t1, $t1, -1
	bne $t1, $zero, while
	jal hanoiTower
	j exit

hanoiTower:
	bne $a0, $t0, else		#if number of disks is not equal to one then store parameter values and call function again
		#print area
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

		#print area

	addi $a0, $a0, -1	#reduce the number of disks by one
	
	sll $t1, $a1, 0		#temporarly store destiny rod
	sll $a1, $a3, 0		#change destiny rod with temporary rod
	sll $a3, $t1, 0
	
	jal hanoiTower
	addi $sp, $sp, 20
	lw $ra, ($sp)
	jr $ra
	
exit:
