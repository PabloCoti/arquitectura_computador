%include 'stdio32.asm'


SECTION .text
    askinpt db 'Ingrese sus dos numeros: '

SECTION .data

global _start

_start:
    mov eax, askinpt
    call printStr

    call input

    call strConcatenate
