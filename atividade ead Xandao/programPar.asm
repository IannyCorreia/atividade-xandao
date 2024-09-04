.data
msg: .asciiz "Digite um número: "
contagemPares: .word 0

.text
.globl main

main:
    li $t0, 5               
    la $t1, contagemPares  

loop:
    beq $t0, $zero, fimLoop 

    la $a0, msg
    li $v0, 4
    syscall


    li $v0, 5
    syscall
    move $t2, $v0           

    
    andi $t3, $t2, 1
    beq $t3, $zero, incrementarContagemPares

    addi $t0, $t0, -1
    j loop

incrementarContagemPares:
    lw $t4, 0($t1)          
    addi $t4, $t4, 1        
    sw $t4, 0($t1)         

    addi $t0, $t0, -1
    j loop

fimLoop:
    lw $a0, contagemPares
    li $v0, 1
    syscall

    li $v0, 10
    syscall
