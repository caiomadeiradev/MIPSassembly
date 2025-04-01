.text
.globl print_int

print_int:
	li $v0, 1
	move $a0, $t0
    	syscall