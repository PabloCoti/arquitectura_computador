%include '../../utils/stdio32.asm'
%include '../../utils/string32.asm'


SECTION .data
    top db 218, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 0H
    msg db 'Hola mundo!', 0H
    msg2 db 'Arquitectura I', 0H

SECTION .text
    global _start

    _start:
        mov eax, top
        call printStrLn

        mov eax, msg
        call printStrLn

        call endP


; HOW TO EXCECUTE PROGRAM
; nasm -f elf32 archive_name.asm -o archive_name.o
; ld -m elf_i386 archive_name.o -o archive_name.e
; ./archive_name

; HOW TO CHECK FOR ERROR
; echo $?