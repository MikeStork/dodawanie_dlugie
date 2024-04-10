.code32
SYSEXIT = 1
EXIT_SUCCESS = 0
SYSCALL = 0x80

.data
liczba1:
    	.long 0x10000002, 0x00000002, 0x00000001, 0x00000001
elements = (. - liczba1)/4
liczba2:
    	.long 0xF0000002, 0x00000001, 0x00000001, 0x00000001

.text

.global _start

_start:
    movl $0, %ecx #iterator pętli
    clc #czyścimy flagę przeniasienia
    pushf
sub:
    popf
    movl liczba1(,%ecx,4), %eax
    sbbl liczba2(,%ecx,4), %eax
    pushl %eax  #odkładamy na stos
    pushf
    incl %ecx
    cmpl $elements, %ecx #porównujemy z liczbą części liczby
    jne sub
    popf
    jc addcarry
    push $0
    jmp exit
addcarry:
    push $0xFFFFFFFF
exit:
    mov $SYSEXIT, %eax
    mov $EXIT_SUCCESS, %ebx
    int $SYSCALL
