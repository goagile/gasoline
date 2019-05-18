# find maximum of list elements

# %edi - i - current position
# %ebx - max - highest value
# %eax - a - current element
# list - contains item of data
# zero - terminating element

.section .data
list:
    .long 3,67,34,222,45,75,54,34,44,33,22,11,66,0

.section .text

.globl _start

_start:
    movl $0, %edi            # i = 0
    movl list(,%edi,4), %eax # a = list[i]
    movl %eax, %ebx          # max = a

start_loop:
    cmpl $0, %eax            # compare a, 0
    je exit_loop             # if a == 0    exit_loop
    incl %edi                # ++i
    movl list(,%edi,4), %eax # a = list[i]
    cmpl %ebx, %eax          # compare max, a
    jle start_loop           # if max <= a  start_loop
    movl %eax, %ebx          # max = a
    jmp start_loop

exit_loop:
    # %ebx - is the status code for exit system call
    # %ebx - has maximum element of list
    movl $1, %eax # a = #1 - exit() system call
    int $0x80
