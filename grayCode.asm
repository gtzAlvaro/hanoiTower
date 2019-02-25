#Author:	Alvaro Gutierrez Arce
#Date:		2-24-19
#Description:	algorithm to solve hanoi tower using gray code

.text
main:
	addi $a0, $a0, 3
	jal grayCode
	j exit
	
grayCode:
	
	jal grayCode
	jr $ra

exit:
	
