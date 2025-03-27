.data
message: .asciiz "Hello, World!\n"

.text
.globl main
main:
	li $v0, 4 # codigo syscall p/ imprimir uma string
	la $a0, message # carrega o endereco da string
	syscall # chama o sistema
	
	li $v0, 10 # codigo de syscall pra sair
	syscall # finaliza o programa
	