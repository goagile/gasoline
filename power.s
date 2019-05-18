# As result 2^3 + 5^2

.section .data
.section .text

.globl _start

_start:
    # stack:
    #  0:| .    | <-%esp

    push $3     # push 1 long (-4 byte)
    # stack:
    #  0:| .    |
    # -4:| 3    | <-%esp

    push $2     # push 1 long (-4 byte)
    # stack:
    #  0:| .    |
    # -4:| 3    |
    # -8:| 2    | <-%esp

    call power

    add $8, %rsp # move stack back 2 long (+8 byte)
    # stack:
    #  0:| .    | <-%esp
    # -4:| 3    |
    # -8:| 2    | 

    # push %rax   # save first answer
    # stack:
    #  0:| .    | 
    # -4:| %eax | <-%esp
    # -8:| 2    | 

    mov %rax, %rbx
    mov $1, %rax
    int $0x80

.type power, @function
power:
    #
    # GOAL: base^power
    # 
    # IN: base, power
    #
    # OUT: base^power
    #
    # VAR:
    #   %rbx        power
    #   %rcx        base
    #   -4(%rbp)    current result
    #   %rax        temp
    #
    
    push %rbp       # return address ?
    # stack:
    #   0:| .        |
    #  -4:| 3        |
    #  -8:| 2        | 
    # -12:| %old_rbp | <-%rsp

    mov %rsp, %rbp
    # %rbp: -12

    # stack:
    #   0:| .        |
    #  -4:| 3        |
    #  -8:| 2        | 
    # -12:| %old_rbp | <-%rsp <-%rbp

    sub $4, %rsp    # local storage
    # stack:
    #   0:| .        |
    #  -4:| 3        |
    #  -8:| 2        | 
    # -12:| %old_rbp | <-%rbp
    # -16:|          | <-%rsp

    mov 8(%rbp), %rbx
    # power
    # %rbx: 3

    mov 12(%rbp), %rcx
    # base
    # %rcx: 2

    mov %rcx, -4(%rbp)
    # stack:
    #   0:| .        |
    #  -4:| 3        |
    #  -8:| 2        | 
    # -12:| %old_rbp | <-%rbp
    # -16:| 2        | <-%rsp

power_loop:
    cmp $1, %rax    # if tmp == 1 return
    je power_end

    mov -4(%rbp), %rax
    # %rax: 2

    imul %rbx, %rax
    # %rax: 3*2=6

    mov %rax, -4(%ebp)
    # stack:
    #   0:| .        |
    #  -4:| 3        |
    #  -8:| 2        |
    # -12:| %old_rbp | <-%rbp
    # -16:| 2        | <-%rsp

    dec %rcx
    jmp power_loop

power_end:
    mov -4(%rbp), %rax
    
    mov %rbp, %rsp
    # stack:
    #   0:| .        |
    #  -4:| 3        |
    #  -8:| 2        | 
    # -12:| %old_rbp | <-%rbp <-%rsp
    # -16:| resl     | 

    pop %rbp
    # %rbp: %old_rbp

    ret
