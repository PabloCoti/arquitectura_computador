%include '../../../utils/stdio64.asm'


SECTION .data
    msg db 'Hola mundo!', 10, 0h 

SECTION .text
    global _start

    _start:
        mov rax, msg
        call printStr

        call endP