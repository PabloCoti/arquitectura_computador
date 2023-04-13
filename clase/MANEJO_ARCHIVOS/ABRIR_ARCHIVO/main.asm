; APERTURA DE ARCHIVO (EN MODO LECTURA)
%include '../../../utils/stdio32.asm'
%include '../../../utils/string32.asm'


SECTION .data
    filename db 'README.txt', 0h

SECTION .bss
    line: resb 255

SECTION .text
    global _start

    _start:
        ; ABRIR ARCHIVO
        mov ecx, 0          ; READ ONLY PERMISSION (O_RDONLY)
        mov ebx, filename
        mov eax, 5          ; INVOCAR SYS_OPEN
        int 80h

        ; IMPRIMIR CONTENIDO
        mov edx, 13         ; LONGITUD DE LINEA
        mov ecx, line
        mov ebx, eax
        mov eax, 3
        int 80h
        
        mov eax, line
        call printStrLn

        ; CERRAR ARCHIVO
        mov ebx, ebx
        mov eax, 6
        int 80h

        call endP


; HOW TO EXCECUTE PROGRAM
; nasm -f elf32 archive_name.asm -o archive_name.o
; ld -m elf_i386 archive_name.o -o archive_name.e
; ./archive_name

; HOW TO CHECK FOR ERROR
; echo $?