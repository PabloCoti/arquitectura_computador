%include '../../utils/stdio32.asm'
%include '../../utils/string32.asm'


SECTION .data
    filename db 'readme.txt', 0h
    content db '-actualizado-', 10, 0h

SECTION .text
    global _start

    _start:
        mov ecx, 1
        mov ebx, filename
        mov eax, 5
        int 80h

        mov edx, 2
        mov ecx, 0
        mov ebx, eax
        mov eax, 19
        int 80h

        push eax
        mov eax, filecontent
        call strLen

        mov edx, eax
        pop eax
        mov ecx, filecontent
        mov ebx, ebx
        mov eax, 4
        int 80h

        call endP


; HOW TO EXCECUTE PROGRAM
; nasm -f elf32 archive_name.asm -o archive_name.o
; ld -m elf_i386 archive_name.o -o archive_name.e
; ./archive_name

; HOW TO CHECK FOR ERROR
; echo $?