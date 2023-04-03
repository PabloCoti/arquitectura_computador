; ------------------ CALCULO DE LONGITUD DE CADENA ------------------ ;
; strLen(eax=<CADENA>) -> eax int n = <LONGITUD>
strLen:
    push ebx            ; GUARDAMOS EL DATO EN LA PILA PARA LUEGO RECUPERARLO
    mov ebx, eax        ; eax = ebx | ebx = direccion de memroia de msg

sigCharLen: ; yo decidi ponerle el nombre sigCharLen, puede tener cualquier nombre
    cmp byte[eax], 0    ; seria como decir en C msg[eax] == 0?
    jz finLen           ; GOTO finLen si se cumple la condicion de arriba
    inc eax             ; increamenta eax si no ha terminado la cadena
    jmp sigCharLen      ; salta a la etiqueta siguiente

finLen:
    sub eax, ebx    ; longitud de la cadena
    pop ebx         ; obtemos lo que sea que hay en la ultima posicion de pila
    ret             ; implementa un return porque es una funcion


; ; ------------------ IMPRESION  ------------------ ;
; imprime una cadena de texto con salto de linea
printStrLn:
    call printStr       ; imprime el texto
    push    eax         ;
    mov     eax, 0AH    ;
    push    eax         ; 
    mov     eax, esp    ; asigna a eax la direccion ESP stack pointer
    call printStr       ; imprime el salto de linea
    pop     eax
    pop     eax
    ret


; ------------------ IMPRESION EN PANTALLA ------------------ ;
; void printStr(eax = cadena)
printStr:
    ; guardamos todos los datos para recuperarlos luego
    push edx
    push ecx
    push ebx
    push eax
    call strLen ; calculamos la longitud (se guarda longitud en eax)

    mov edx, eax    ; edx = lo que retorna strLen
    pop eax         ; eax = primer registro de la pila
    mov ecx, eax    ; movemos el valor a ecx
    mov ebx, 1      ; salida 1 = pantalla
    mov eax, 4      ; SYS_WRITE
    int 80h         ;

    ; restauramos los valores del programa
    pop ebx
    pop ecx
    pop edx
    ret

; ------------------ FIN DEL PROGRAMA ------------------ ;
endP: ; C = void endP()
    mov     ebx, 0      ; return 0
    mov     eax, 1      ; llama a SYS_EXIT (kernel.opcode 1)
    int 80h             ; llamada de interrupscion de kernel