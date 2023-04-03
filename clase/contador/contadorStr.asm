; contador hasta 10
; fecha 17/03/2023
; prorama que realiza impresion de valores del 0 al 9 en pantalla

%include 'stdio32.asm'


SECTION .text
    global _start

_start:
    ; ecx = 0
    mov ecx, 0


nextNum:
    ; eax = ecx
    mov eax, ecx

    ; eax += 48 (CAMBIA EL CARACTER POR EL NUMERO)
    add eax, 48

    ; coloco eax en pila
    push eax

    ; eax = posicion actual de la pila  (contenido que tenia antes)
    mov eax, esp

    ; imprimir en pantalla el contenido
    call printStrLn

    ; sacar datos de la pila
    pop eax

    inc ecx

    cmp ecx, 10
    jne nextNum

    call endP
