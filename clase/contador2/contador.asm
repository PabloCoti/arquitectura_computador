; Contador de 0 a 10
; 22/03/2023

%include 'stdio32.asm'


SECTION .text
    global _start

_start:
    mov ecx, 0

nextNum:
    mov eax, ecx
    call printIntLn

    inc ecx
    cmp ecx, 15
    jne nextNum
    call endP