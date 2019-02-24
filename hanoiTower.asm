#Author:	Alvaro
#Description:	hanoiTowers
#Date:		2-22-19

.text
main:
	addi $a0, $a0, 3	#total number of disks
	addi $a1, $a1, 1	#origin rod
	addi $a2, $a2, 3	#destiny rod
	addi $a3, $a3, 2	#temporary rod
	addi $t0, $t0, 1	#value used to compare when number of disks is reduced to one
	add $t1, $t1, $a0	#value used to draw disk in data segment
	addi $s0, $s0, 0x10010000
	addi $s1, $s1, 0x10010020
	addi $s2, $s2, 0x10010040
draw: 
	sw $t1, ($s0)
	addi $t1, $t1, -1
	addi $s0, $s0, 4
	bne $t1, $zero, draw
	
	jal hanoiTower
	j exit

hanoiTower:
	bne $a0, $t0, else	#if number of disks is not equal to one then store parameter values and call function again

	jr $ra
else:
	addi $sp, $sp, -16	#save space in stack for 5 data packages
	sw $a0, 0($sp)		#store number of disks first
	sw $a1, 4($sp)		#store origin rod second
	sw $a2, 8($sp)		#store destiny rod third
	sw $a3, 12($sp)		#store temporary rod fourth
	sw $ra, 16($sp)		#store return address last

	addi $sp, $sp, -8	#save one extra sapce in stack to change values from destiny rod and temporary rod
	addi $a0, $a0, -1	#reduce the number of disks by one
	sw $a2, ($sp)		#temporarly store contents of destiny rod in stack
	andi $a2, $a2, 0	#clear destiny rod parameter
	add $a2, $a2, $a3	#store value of temporary rod in destiny rod
	lw $a3, ($sp)		#sotre value of destiny rod in temporary rod
	addi $sp, $sp, 4	#return stack to normal
	jal hanoiTower
	
	lw $a0, 4($sp)		#load number of disks from parent function
	lw $a1, 8($sp)		#load origin rod from parent function
	lw $a2, 12($sp)		#load destiny rod from parent function
	lw $a3, 16($sp)		#load temporary rod from parent function
	lw $ra, 20($sp)		#load return address from parent function


	
	addi $sp, $sp, -4	#save one extra sapce in stack to change values from origin rod and temporary rod
	addi $a0, $a0, -1	#reduce the number of disks by one
	sw $a1, ($sp)		#temporarly store contents of origin rod in stack
	andi $a1, $a1, 0	#clear origin rod parameter
	add $a1, $a1, $a3	#store value of temporary rod in origin rod
	lw $a3, ($sp)		#sotre value of origin rod in temporary rod
	addi $sp, $sp, 4	#return stack to normal
	jal hanoiTower
	addi $sp, $sp, 20
	lw $ra, ($sp)
	jr $ra
	
exit:
