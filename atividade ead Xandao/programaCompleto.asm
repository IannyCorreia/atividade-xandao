.data
prompt: .asciiz "Digite um número: "
msgContagemPares: .asciiz "Quantidade de números pares: "
msgMaiorValor: .asciiz "O maior número digitado é: "
msgMaioresNumeros: .asciiz "Os 5 maiores números digitados em ordem decrescente são:"
novaLinha: .asciiz "\n"
numeros: .space 20
contagemPares: .word 0
maiorValor: .word -2147483648

.text
.globl main

main:
    li $t0, 5
    la $t1, contagemPares
    la $t5, maiorValor
    la $t7, numeros
    li $t8, 0

loop:
    beq $t0, $zero, fimLoop

    la $a0, prompt
    li $v0, 4
    syscall

    li $v0, 5
    syscall
    move $t2, $v0
    sw $t2, 0($t7)
    addi $t7, $t7, 4

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
    la $a0, msgContagemPares
    li $v0, 4
    syscall
    lw $a0, contagemPares
    li $v0, 1
    syscall
    la $a0, novaLinha
    li $v0, 4
    syscall

    la $a0, msgMaiorValor
    li $v0, 4
    syscall
    lw $a0, maiorValor
    li $v0, 1
    syscall
    la $a0, novaLinha
    li $v0, 4
    syscall

    la $t7, numeros
    li $t0, 5
    li $t8, 0
    li $t9, 1

sortLoopI:
    bge $t8, 4, fimOrdenacao

    la $t7, numeros
    li $t9, 0

sortLoopJ:
    bge $t9, 4, incrementI

    lw $t2, 0($t7)
    lw $t3, 4($t7)
    bge $t2, $t3, skipSwap

    sw $t3, 0($t7)
    sw $t2, 4($t7)

skipSwap:
    addi $t7, $t7, 4
    addi $t9, $t9, 1
    j sortLoopJ

incrementI:
    addi $t8, $t8, 1
    j sortLoopI

fimOrdenacao:
    la $a0, msgMaioresNumeros
    li $v0, 4
    syscall
    la $a0, novaLinha
    li $v0, 4
    syscall
    la $t7, numeros
    li $t0, 5

printLoop:
    beq $t0, $zero, fim

    lw $a0, 0($t7)
    li $v0, 1
    syscall
    la $a0, novaLinha
    li $v0, 4
    syscall

    addi $t7, $t7, 4
    addi $t0, $t0, -1
    j printLoop

fim:
    li $v0, 10
    syscall
