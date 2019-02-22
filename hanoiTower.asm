#Author:	Alvaro
#Description:	hanoiTowers
#Date:		2-22-19

.data


.text
main:
	addi $a0, $a0, 3
	addi $a1, $a1, 1
	addi $a2, $a2, 3
	addi $a3, $a3, 2
	addi $t0, $t0, 1
	jal hanoiTower
	j exit

hanoiTower:
	bne $a0, $t0, else
	andi $t1, $t2, 0
	andi $t2, $t2, 0
	add $t1, $t1, $a1
	add $t2, $t2, $a2
	jr $ra
else:
	addi $a0, $a0, -1
	andi $a1, $a1, 0
	andi $a2, $a2, 0
	andi $a3, $a3, 0
	addi $a1, $a1, 1
	addi $a2, $a2, 2
	addi $a3, $a3, 3
	sw $ra, ($sp)
	addi $sp, $sp, -4
	jal hanoiTower	
	
	andi $t1, $t2, 0
	andi $t2, $t2, 0
	add $t1, $t1, $a1
	add $t2, $t2, $a2
	
	andi $a1, $a1, 0
	andi $a2, $a2, 0
	andi $a3, $a3, 0
	addi $a1, $a1, 3
	addi $a2, $a2, 2
	addi $a3, $a3, 1
	jal hanoiTower
exit:
