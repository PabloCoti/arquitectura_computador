; CONTROL CENTRAL DE CONVERSIONES


%include '../../utils/stdio32.asm'
%include '../../utils/string32.asm'


SECTION .data
    msg1 db 'Ingrese su entero: ', 0
    msg2 db 'El entero ingresado (cadena) es: ', 0
    msg3 db 'El entero ingresado (entero) es: ', 0

    entero dd 5

SECTION .text
    global _start

    _start:
        mov eax, msg3
        call printStr

        mov eax, entero
        call printIntLn

        mov eax, msg2
        call printStr

        mov eax, entero
        call str
        call printStrLn

        call endP


; HOW TO EXCECUTE PROGRAM
; nasm -f elf32 archive_name.asm -o archive_name.o
; ld -m elf_i386 archive_name.o -o archive_name.e
; ./archive_name

; HOW TO CHECK FOR ERROR
; echo $?
