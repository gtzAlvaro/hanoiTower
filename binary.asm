#Author:	Alvaro
#Description:	hanoiTowers
#Date:		2-28-19

.text
main:
	jal binary
	j exit
	
binary:
	bne $a0, 256, else
	jr $ra
else:
	addi $a0, $a0, 1
	addi $sp, $sp, -4
	sw $ra, 4($sp)
	jal binary
	addi $sp, $sp, 4
	lw $ra, ($sp)
	jr $ra

exit:
