#Author:	Alvaro
#Description:	hanoiTowers
#Date:		2-22-19

.data


.text
main:
	addi $a0, $a0, 4
	addi $a1, $a1, 1
	addi $a2, $a2, 3
	addi $a3, $a3, 2
	jal hanoiTower
	j exit

hanoiTower:
	jr $ra	

exit:
