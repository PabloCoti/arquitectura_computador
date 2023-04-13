; CREACION Y ESCRITURA A ARCHIVO
%include '../../../utils/stdio32.asm'
%include '../../../utils/string32.asm'


SECTION .data
    filename db 'README.txt', 0h
    content db '¡HOLA MUNDO!', 0h

SECTION .text
    global _start

    _start:
        ; CREAR ARCHIVO
        mov ecx, 0754o
        mov ebx, filename
        mov eax, 8
        int 80h

        ; ESCRIBIR EN ARCHIVO
        mov edx, 13
        mov ecx, content
        mov ebx, eax        ; COLOCAR DESCRPITOR DEVUELTO EN eax
        mov eax,  4
        int 80h

        call endP


; HOW TO EXCECUTE PROGRAM
; nasm -f elf32 archive_name.asm -o archive_name.o
; ld -m elf_i386 archive_name.o -o archive_name.e
; ./archive_name

; HOW TO CHECK FOR ERROR
; echo $?