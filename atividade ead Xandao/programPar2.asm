.data
mensagemPrompt: .asciiz "Digite um número: "
mensagemContagemPares: .asciiz "Quantidade de números pares: "
mensagemMaiorValor: .asciiz "O maior número digitado é: "
novaLinha: .asciiz "\n"
contagemPares: .word 0
maiorValor: .word 0

.text
.globl main

main:
    li $t0, 5
    la $t1, contagemPares
    la $t5, maiorValor

loop:
    beq $t0, $zero, fimLoop

    la $a0, mensagemPrompt
    li $v0, 4
    syscall

    li $v0, 5
    syscall
    move $t2, $v0

    andi $t3, $t2, 1
    beq $t3, $zero, incrementarContagemPares

    lw $t6, 0($t5)
    ble $t2, $t6, verificarProximo
    sw $t2, 0($t5)

verificarProximo:
    addi $t0, $t0, -1
    j loop

incrementarContagemPares:
    lw $t4, 0($t1)
    addi $t4, $t4, 1
    sw $t4, 0($t1)

    lw $t6, 0($t5)
    ble $t2, $t6, verificarProximoPares
    sw $t2, 0($t5)

verificarProximoPares:
    addi $t0, $t0, -1
    j loop

fimLoop:
    la $a0, mensagemContagemPares
    li $v0, 4
    syscall

    lw $a0, contagemPares
    li $v0, 1
    syscall

    la $a0, novaLinha
    li $v0, 4
    syscall

    la $a0, mensagemMaiorValor
    li $v0, 4
    syscall

    lw $a0, maiorValor
    li $v0, 1
    syscall

    la $a0, novaLinha
    li $v0, 4
    syscall

    li $v0, 10
    syscall
