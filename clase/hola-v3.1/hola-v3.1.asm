; este es el hola mundo version 4
; creador: pacoti
; fecha: 8 de marzo del 2023
; Ejemplo no. 4 del ensamblador, subrutinas

SECTION .data
    ; msg to acces memory space
    msg db  'Hola Arquitectura I', 0AH      ; msg string declaration

SECTION .text
global _start           ; global _start is like a class declaration

_start:
    mov eax, msg        ; eax = msg

    mov edx, eax        ; edx = string lenght
    mov ecx, msg        ; ecx = msg
    mov ebx, 1          ; STDOUT file
    mov eax, 4          ; SYS_WRITE function
    int 80h

    call endP

    call strLen
    
; Calc string lenght
strLen:
    ; strLen(eax=cadena) -> eax int n = longitud
    push ebx        ; ebx en pila
    mov eax, ebx    ; set memory dir to ebx

sigChar:                ; sigChar is the function name
    cmp byte[eax], 0    ; if msg[eax] == 0
    jz  finLen           ; GOTO finLen if if statement is true
    inc eax             ; eax++
    jmp sigChar         ; recall function

finLen:
    sub eax, ebx        ; get string lenght
    pop ebx             ; like list.pop, but moves the value to ebx
    ret                 ; return

; end program
endP:
    mov ebx, 0          ; return 0
    mov eax, 1          ; llama a SYS_EXIT (kernel.opcode 1)
    int 80h             

; compilamos nasm -f <TIPO_FORMATO> (32 bits, 64...) <ARCHIVO>
;       elf = i386 (32 bits)
;       clf64 = arquitectura 64 bits
; compilamos con nasm -f elf nombre.asm

; linkear objetos con "ld"
; ld -m <FORMATO> <ARCHIVO> -o <NOMBRE EXE>
; ld -m elf_i386 hola.o -o hola

; ejecuta con ./<NOMBRE>
; ./hola

