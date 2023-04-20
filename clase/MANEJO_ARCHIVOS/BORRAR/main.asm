%include '../../utils/stdio32.asm'
%include '../../utils/string32.asm'


SECTION .data
    filename db 'readme.txt'

SECTION .text
    global _start

    _start:
        mov ebx, filename
        mov eax, 10
        int 80h

        call endP

; HOW TO EXCECUTE PROGRAM
; nasm -f elf32 archive_name.asm -o archive_name.o
; ld -m elf_i386 archive_name.o -o archive_name.e
; ./archive_name

; HOW TO CHECK FOR ERROR
; echo $?
