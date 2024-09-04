.data
    array: .space 40
    promptMensagem: .asciiz "Digite um número: "
    resultadoMensagem: .asciiz "Os 5 maiores números são: "
    novaLinha: .asciiz "\n"

.text
.globl main

main:
    li $indiceArray, 0
    li $contadorEntradas, 10

lerNumeros:
    la $a0, promptMensagem
    li $v0, 4
    syscall

    li $v0, 5
    syscall
    sw $v0, array($indiceArray)
    addi $indiceArray, $indiceArray, 4

    subi $contadorEntradas, $contadorEntradas, 1
    bnez $contadorEntradas, lerNumeros

ordenarArray:
    li $tamanhoArray, 10
    li $indiceI, 0
    li $indiceJ, 1

loopExterno:
    beq $indiceI, $tamanhoArray, fimOrdenacao
    add $indiceJAtual, $indiceI, $indiceJ
    beq $indiceJAtual, $tamanhoArray, incrementarIndiceI

    sll $indiceIBytes, $indiceI, 2
    sll $indiceJBytes, $indiceJAtual, 2
    lw $valorI, array($indiceIBytes)
    lw $valorJ, array($indiceJBytes)

    ble $valorI, $valorJ, incrementarIndiceJ

    sw $valorJ, array($indiceIBytes)
    sw $valorI, array($indiceJBytes)

incrementarIndiceJ:
    addi $indiceJ, $indiceJ, 1
    j loopExterno

incrementarIndiceI:
    addi $indiceI, $indiceI, 1
    li $indiceJ, 1
    j loopExterno

fimOrdenacao:
    la $a0, resultadoMensagem
    li $v0, 4
    syscall

    li $indiceArray, 0
    li $contadorImpressao, 5

imprimirNumeros:
    lw $a0, array($indiceArray)
    li $v0, 1
    syscall

    la $a0, novaLinha
    li $v0, 4
    syscall

    addi $indiceArray, $indiceArray, 4
    subi $contadorImpressao, $contadorImpressao, 1
    bnez $contadorImpressao, imprimirNumeros

    li $v0, 10
    syscall
