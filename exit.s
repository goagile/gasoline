# FIRST PROG
.section .data
.section .text
.globl _start

_start:
    movl $1, %eax # $1 - syscall number exit a program
    
    movl $0, %ebx # $0 - return status OK

    int $0x80 # system interrupt
