%include 'stdio32.asm'


SECTION .data
        msg1    db 'Ingrese su nombre: ', 0
        msg2   db 'Hola ', 0

SECTION .bss
        nombre: resb 255

SECTION .text
        global _start

_start:
        mov eax, msg1
        call printStr

        mov edx, 255
        mov ecx, nombre
        mov ebx, 1
        mov eax, 3
        int 80h

        mov eax, msg2
        call printStr

        mov eax, nombre
        call printStr

        call endP

