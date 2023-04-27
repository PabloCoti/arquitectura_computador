%include '../../../utils/stdio64.asm'


SECTION .data
    pi dq 3.14159
    radion dq 5.0
    buf db 64
    format db "%f", 10, 0

SECTION .text
    extern printF
    
    global _start

_start:
    fld qword [radio] ; carga el radio al registro st0
    fld qword [pi] ; carga pi al registro st1
    fmul ; multiplica los valores de st0 y st1
    fstp qword [radio] ; guarda el resultado en el registro st0

    fistp qword [esp] ; copia el valor de st0 a formato entero

    push dword format
    push dword buf

    call prinF

    add esp, 8 ; limpiar la pila

    mov eax, 1
    xor ebx, ebx

    int 80h


; HOW TO EXCECUTE PROGRAM
; nasm -f elf64 archive_name.asm -o archive_name.o
; ld -m elf_i386 archive_name.o -o archive_name.e
; ./archive_name

; HOW TO CHECK FOR ERROR
; echo $?
