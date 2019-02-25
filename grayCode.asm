#Author:	Alvaro Gutierrez Arce
#Date:		2-24-19
#Description:	algorithm to solve hanoi tower using gray code

.text
main:
	addi $a0, $a0, 8
	addi $a1, $a1, 1
	addi $a2, $sp, -4
	jal grayCode
	j exit
	
grayCode:
	beq $a0, $zero, else
	sll $t0, $a1, 0
while:
	lw $t1, ($sp)
	or $t1, $t1, $a1
	sw $t1, ($a2)
	addi $a2, $a2, -4
	addi $sp, $sp, 4
	addi $t0, $t0, -1
	bne $t0, $zero, while
	addi $a0, $a0, -1
	sll $a1, $a1, 1
	addi $sp, $a2, 4
	jal grayCode
else:
	andi $ra, $ra, 0x00000000
	addi $ra, $ra, 0x00400010
	jr $ra

exit:
	
