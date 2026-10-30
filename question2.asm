# MARS 4.5: delayed branching disabled.

.data
a:      .word 10
b:      .word 3
result: .word 0

.text
.globl main
main:
    lw   $t0, a
    lw   $t1, b
    addu $t3, $zero, $zero

    slt  $t2, $t1, $t0
    beq  $t2, $zero, main_else

    move $a0, $t0
    move $a1, $t1
    jal  process_data
    move $t3, $v0
    j    show_result

main_else:
    addu $t3, $t0, $t1
    sll  $t3, $t3, 2

show_result:
    sw   $t3, result
    move $a0, $t3
    addi $v0, $zero, 1
    syscall

    addi $v0, $zero, 10
    syscall

# a0: a, a1: b; v0: result.
# s0: a, s1: b, s2: whether a is even.
process_data:
    addiu $sp, $sp, -16
    sw    $s0, 0($sp)
    sw    $s1, 4($sp)
    sw    $s2, 8($sp)
    sw    $ra, 12($sp)

    move $s0, $a0
    move $s1, $a1
    andi $s2, $s0, 1
    xori $s2, $s2, 1

    move $a0, $s0
    move $a1, $s1
    bne  $s2, $zero, call_alpha

    jal  compute_beta
    j    process_done

call_alpha:
    jal  compute_alpha

process_done:
    lw    $s0, 0($sp)
    lw    $s1, 4($sp)
    lw    $s2, 8($sp)
    lw    $ra, 12($sp)
    addiu $sp, $sp, 16
    jr    $ra

# a0: a, a1: b; v0: 4*a - b.
compute_alpha:
    sll  $t0, $a0, 2
    subu $v0, $t0, $a1
    jr   $ra

# a0: a, a1: b; v0: 2*a + 3*b.
compute_beta:
    sll  $t0, $a0, 1
    sll  $t1, $a1, 1
    addu $t1, $t1, $a1
    addu $v0, $t0, $t1
    jr   $ra
