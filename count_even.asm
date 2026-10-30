# MARS 4.5: delayed branching disabled.

.data
A: .word 2, 13, 1, 4, 8, 20, 5, 6, 9, 14
K: .word 10

.text
.globl main
main:
    la $t1, A
    lw $t2, K

    move $a0, $t1
    move $a1, $t2
    addi $a2, $zero, 10
    jal  countMatches

    move $a0, $v0
    li   $v0, 1
    syscall

    li   $v0, 10
    syscall

# a0: array address, a1: K, a2: length; v0: count.
# s0: cursor, s1: K, s2: remaining, s3: count, s4: parity, s5: combined test.
countMatches:
    addi $sp, $sp, -32
    sw   $s0, 0($sp)
    sw   $s1, 4($sp)
    sw   $s2, 8($sp)
    sw   $s3, 12($sp)
    sw   $s4, 16($sp)
    sw   $s5, 20($sp)
    sw   $ra, 24($sp)

    move $s0, $a0
    move $s1, $a1
    move $s2, $a2
    li   $s3, 0

countLoop:
    beq  $s2, $zero, countDone

    lw   $a0, 0($s0)
    jal  isEven
    move $s4, $v0            # Keep this result across the next call.

    lw   $a0, 0($s0)
    move $a1, $s1
    jal  isLessThan

    and  $s5, $s4, $v0
    beq  $s5, $zero, nextElement
    addi $s3, $s3, 1

nextElement:
    addi $s0, $s0, 4
    addi $s2, $s2, -1
    j    countLoop

countDone:
    move $v0, $s3

    lw   $s0, 0($sp)
    lw   $s1, 4($sp)
    lw   $s2, 8($sp)
    lw   $s3, 12($sp)
    lw   $s4, 16($sp)
    lw   $s5, 20($sp)
    lw   $ra, 24($sp)
    addi $sp, $sp, 32
    jr   $ra

# a0: value; v0: 1 if even, otherwise 0.
isEven:
    andi $v0, $a0, 1
    xori $v0, $v0, 1
    jr   $ra

# a0: value, a1: K; v0: 1 if value < K (signed), otherwise 0.
isLessThan:
    slt  $v0, $a0, $a1
    jr   $ra
