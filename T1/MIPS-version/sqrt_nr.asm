# Programa MIPS - Newton-Raphson recursivo para raiz quadrada
# Caio Madeira | 24280006

.data
intro_msg:      .asciiz "\nPrograma de Raiz Quadrada – Newton-Raphson\nDesenvolvedores: Caio Madeira\n"
prompt_msg:     .asciiz "\Digite os parametros x e i para calcular sqrt_nr(x, i) ou -1 para abortar a execucao:\n"
input_x_msg:    .asciiz "x: "
input_i_msg:    .asciiz "i: "
result_msg:     .asciiz "Resultado: sqrt("
comma_msg:      .asciiz ", "
close_msg:      .asciiz ") = "

.text
.globl main

main:
    # Imprime mensagem de introducao
    li $v0, 4
    la $a0, intro_msg
    syscall

loop:
    # Solicita x
    li $v0, 4
    la $a0, prompt_msg
    syscall

    li $v0, 4
    la $a0, input_x_msg
    syscall

    li $v0, 5
    syscall
    move $s0, $v0     # s0 = x

    # Se x < 0, encerra
    bltz $s0, exit

    # Solicita i
    li $v0, 4
    la $a0, input_i_msg
    syscall

    li $v0, 5
    syscall
    move $s1, $v0     # s1 = i

    # Se i < 0, encerra
    bltz $s1, exit

    # Chamada da funcao sqrt_nr(x, i)
    move $a0, $s0     # a0 = x
    move $a1, $s1     # a1 = i
    jal sqrt_nr
    move $s2, $v0     # resultado em s2

    # Impressao do resultado: "sqrt(x, i) = r"
    li $v0, 4
    la $a0, result_msg
    syscall

    li $v0, 1
    move $a0, $s0
    syscall

    li $v0, 4
    la $a0, comma_msg
    syscall

    li $v0, 1
    move $a0, $s1
    syscall

    li $v0, 4
    la $a0, close_msg
    syscall

    li $v0, 1
    move $a0, $s2
    syscall

    j loop

exit:
    li $v0, 10
    syscall

# Funcao recursiva sqrt_nr(x, i)
sqrt_nr:
    # Base: se i == 0 retorna 1
    beqz $a1, base_case

    # Salva ra, a0, a1 na pilha
    addi $sp, $sp, -12
    sw $ra, 0($sp)
    sw $a0, 4($sp)
    sw $a1, 8($sp)

    # Chamada recursiva com i - 1
    addi $a1, $a1, -1
    jal sqrt_nr

    # Recupera argumentos
    lw $a0, 4($sp)     # x
    lw $t0, 8($sp)     # i (não necessário mais)
    move $t1, $v0      # t1 = sqrt_nr(x, i-1)

    # x / sqrt_nr(x, i-1)
    move $t2, $a0      # t2 = x
    div $t2, $t1
    mflo $t3           # t3 = x / r

    add $t4, $t1, $t3  # t4 = r + x/r
    sra $v0, $t4, 1    # v0 = (r + x/r) / 2

    # Restaura ra e desempilha
    lw $ra, 0($sp)
    addi $sp, $sp, 12
    jr $ra

base_case:
    li $v0, 1
    jr $ra
