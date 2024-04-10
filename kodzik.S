.code32
SYSEXIT = 1
EXIT_SUCCESS = 0
SYSCALL = 0x80

.data
liczba1:
    	.long 0x10000001, 0x00000001, 0x00000001, 0xF0000001
elements = (. - liczba1)/4
liczba2:
    	.long 0xF0000002, 0x00000001, 0x00000001, 0x10000001

.text

.global _start

_start:
    movl $0, %ecx
    clc
    pushf
add:
    popf
    movl liczba1(,%ecx,4), %eax
    adcl liczba2(,%ecx,4), %eax
    pushl %eax
    pushf
    incl %ecx
    cmpl $elements, %ecx
    jne add
    popf
    jc addcarry
    push $0
    jmp exit
addcarry:
    push $1
exit:
    mov $SYSEXIT, %eax
    mov $EXIT_SUCCESS, %ebx
    int $SYSCALL
