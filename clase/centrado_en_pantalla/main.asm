%include 'stdio32.asm'


SECTION .data
    msg db 'Arquitectura II!', 0
    posxy db 1Bh, '[12;32h', 0
    strCls db 1Bh, '[2J', 1Bh, '[3J', 0

SECTION .text
global _start

_start:
    mov eax, strCls
    call printStr

    mov eax, posxy
    call printStr

    mov eax, msg
    call printStrLn

    call endP
