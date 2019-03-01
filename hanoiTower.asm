#Author:	Alvaro
#Description:	hanoiTowers
#Date:		2-22-19

.text
main:
	addi $a0, $a0, 8		#total number of disks
	addi $a1, $a1, 1		#origin rod
	addi $a2, $a2, 3		#destiny rod
	addi $a3, $a3, 2		#temporary rod
	addi $t2, $t2, 1		#value used to compare
	addi $t3, $t3, 2		#value used to compare
	addi $s1, $s1, 0x10010000	#value of data segment where origin rod will be drawn
	addi $s2, $s2, 0x10010020	#value of data segment where temporary rod will be drawn
	addi $s3, $s3, 0x10010040	#value of data segment where destiny rod will be drawn
	addi $t1, $a0, 0
while:					#print the number of disks in data segment
	sw $t1, ($s1)
	addi $s1, $s1, 4
	addi $t1, $t1, -1
	bne $t1, $zero, while
	jal hanoiTower			#solve hanoi tower
	j exit

hanoiTower:
	bne $a0, $t2, else	#if number of disks is not equal to one then store parameter values and call function again
	sw $ra, ($sp)
	jal draw		#move disks accrodingly
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
	jal draw		#move disks accrodingly
	lw $ra, ($sp)
	
	addi $a0, $a0, -1	#reduce the number of disks by one
	sll $t1, $a1, 0		#temporarly store destiny rod
	sll $a1, $a3, 0		#change destiny rod with temporary rod
	sll $a3, $t1, 0
	
	jal hanoiTower		#call hanoi tower again
	addi $sp, $sp, 20	#free memory from most recent to hanoi Tower
	lw $ra, ($sp)		#load return address from most recent call to hanoi Tower
	jr $ra

draw:
	bne $a1, $t2, notOne	#if origin rod is 1
	addi $s1, $s1, -4	#decrease origin rod pointer
	lw $t1, ($s1)		#load disk
	sw $zero, ($s1)		#remove disk
	j destinyRod
notOne:
	bne $a1, $t3, notTwo	#if origin rod is 2
	addi $s2, $s2, -4	#decrease origin rod pointer
	lw $t1, ($s2)		#load disk
	sw $zero, ($s2)		#remove disk
	j destinyRod
notTwo:	
	addi $s3, $s3, -4	#if origin rod is 3
	lw $t1, ($s3)		#load disk
	sw $zero, ($s3)		#remove disk
	
destinyRod:
	bne $a2, $t2, isTwo	#if destiny rod is 1
	sw $t1, ($s1)		#store disk
	addi $s1, $s1, 4	#increase pointer
	jr $ra
isTwo:	
	bne $a2, $t3, isThree	#if destiny rod is 2
	sw $t1, ($s2)		#store disk
	addi $s2, $s2, 4	#increase pointer
	jr $ra
isThree:	
	sw $t1, ($s3)		#if destiny rod is 3
	addi $s3, $s3, 4	#store disk and increase pointer
	jr $ra

exit:
