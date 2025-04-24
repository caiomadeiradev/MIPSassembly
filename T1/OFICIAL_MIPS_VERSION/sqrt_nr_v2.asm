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
space_mg:       .asciiz "\n"


# -------------------------------
# Macros
# -------------------------------
.macro print_str (%str)
    li $v0, 4
    la $a0, %str
    syscall
.end_macro

.macro print_int (%reg)
    li $v0, 1
    move $a0, %reg
    syscall
.end_macro

.text
.globl main

main:
    print_str(intro_msg)

loop:
    print_str(prompt_msg)
    print_str(input_x_msg)

    li $v0, 5
    syscall
    move $s0, $v0     # $s0 = x
    bltz $s0, exit    # se x < 0, encerra

    print_str(input_i_msg)
    li $v0, 5
    syscall
    move $s1, $v0     # $s1 = i
    bltz $s1, exit    # se i < 0, encerra

    # chama de sqrt_nr(x, i)
    move $a0, $s0     # $a0 = x
    move $a1, $s1     # $a1 = i
    jal sqrt_nr
    move $s2, $v0     # $s2 = resultado

    # print do resultado
    print_str(result_msg)
    print_int($s0)
    print_str(comma_msg)
    print_int($s1)
    print_str(close_msg)
    print_int($s2)
    print_str(space_mg)
    j loop

exit:
    li $v0, 10
    syscall

# -------------------------------
# Função recursiva sqrt_nr(x, i)
# -------------------------------
sqrt_nr:
    beqz $a1, base_case  # se i == 0, retorna 1

    # salvando contexto de ra, a0, a1
    addi $sp, $sp, -12
    sw $ra, 0($sp)
    sw $a0, 4($sp)
    sw $a1, 8($sp)

    # recursividade sqrt_nr(x, i - 1)
    addi $a1, $a1, -1
    jal sqrt_nr

    # recupera o contexto
    lw $a0, 4($sp)    # x
    lw $t0, 8($sp)    # i (opcional, não usado depois)
    move $t1, $v0     # t1 = r = sqrt_nr(x, i-1)

    # Calcula x / r
    move $t2, $a0     # x
    move $t3, $t1     # r
    div $t2, $t3
    mflo $t4          # t4 = x / r

    add $t5, $t1, $t4 # t5 = r + (x / r)

    # divide por 2 com sra (shift)
    sra $v0, $t5, 1   # v0 = (r + x/r) / 2

    # restaura registrador de retorno e desempilha
    lw $ra, 0($sp)
    addi $sp, $sp, 12
    jr $ra

base_case:
    li $v0, 1
    jr $ra
