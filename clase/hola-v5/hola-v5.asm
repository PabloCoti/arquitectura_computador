; Hello world using heather file with print screen
; date: mar 10 2023
; Example of screen print with the use of heather files

%include        'stdio32.asm'

SECTION .data
        msg1    db      'Hola Arquitectura II!', 0h
        msg2    db      'Reutilizando funciones...', 0h
        msg3    db      'Es todo por hoy...', 0h

SECTION .text
        global  _start

_start:
        mov     eax, msg1
        call    printStrLn

        mov     eax, msg2
        call    printStrLn

        call    endP

; compilamos nasm -f <TIPO_FORMATO> (32 bits, 64...) <ARCHIVO>
;       elf = i386 (32 bits)
;       clf64 = arquitectura 64 bits
; compilamos con nasm -f elf nombre.asm

; linkear objetos con "ld"
; ld -m <FORMATO> <ARCHIVO> -o <NOMBRE EXE>
; ld -m elf_i386 hola.o -o hola

; ejecuta con ./<NOMBRE>
