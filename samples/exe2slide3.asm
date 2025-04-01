begin:
	ADDI $t0, $zero, 0
	ADDI $t1, $zero, 0
loop:
	SLT $t2, $a0, $t1
	BNE $t2, $zero, finish
	
	ADD $t0, $t0, $t1
	ADDI $t1, $t1, 2
	J loop
finish:
	ADD $v0, $t0, $zero