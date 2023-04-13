; ZONA DE TESTEOS

%include '../utils/stdio32.asm'
%include '../utils/string32.asm'


SECTION .data
    number db '5', 0
    msg1 db 'Numero como entero: ', 0
    msg2 db 'Numero como cadena: ', 0

SECTION .text
    global _start

    _start:
        mov eax, number
        call stoi

        mov ecx, eax
        call printIntLn

        mov eax, ecx
        call str
        call printStrLn

        call endP


; HOW TO EXCECUTE PROGRAM
; nasm -f elf32 archive_name.asm -o archive_name.o
; ld -m elf_i386 archive_name.o -o archive_name.e
; ./archive_name

; HOW TO CHECK FOR ERROR
; echo $?
