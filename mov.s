.global main

main:
    mov $1, %rax
    mov $0, %rbx
    int $0x80
