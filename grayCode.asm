#Author:	Alvaro Gutierrez Arce
#Date:		2-24-19
#Description:	algorithm to solve hanoi tower using gray code

.text
main:
	addi $a0, $a0, 3
	jal grayCode
	j exit
	
grayCode:
	beq $a0, $zero, breaK
	addi $a0, $a0, -1
	sw $ra, ($sp)
	addi $sp, $sp, -4
	jal grayCode
breaK:
	addi $sp, $sp, 4
	lw $ra, ($sp)
	jr $ra

exit:
	
