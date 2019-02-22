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
	
	jr $ra
else:
	addi $sp, $sp, -16
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	sw $a2, 8($sp)
	sw $a3, 12($sp)
	sw $ra, 16($sp)
	
	addi $sp, $sp, -4
	addi $a0, $a0, -1
	sw $a2, ($sp)
	andi $a2, $a2, 0
	add $a2, $a2, $a3
	lw $a3, ($sp)
	addi $sp, $sp, 4
	jal hanoiTower
	
	jal hanoiTower
exit:
