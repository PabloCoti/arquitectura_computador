; stdio32


SECTION .bss
    tmp: resb 255

SECTION .text
    ; eax = input()
    input:
        push ebx
        push ecx
        push edx

        mov edx, 255        
        mov ecx, tmp    
        mov ebx, 0          
        mov eax, 3          
        int 80h              

        push edi
        mov edi, ecx
        mov ecx, eax
        xor eax, eax
        cld
        repne scasb
        je nto0

        mov byte[edi+ecx], 0

        nto0:
            mov byte [edi+eax-1], 0

        pop edi
        pop edx
        pop ecx
        pop ebx
        
        mov eax, tmp

        ret

    ; len(eax=string)
    strLen:
        push ebx            
        mov ebx, eax        

        sigCharLen: 
            cmp byte[eax], 0    ; seria como decir en C msg[eax] == 0?
            jz finLen           ; GOTO finLen si se cumple la condicion de arriba
            inc eax             ; increamenta eax si no ha terminado la cadena
            jmp sigCharLen      ; salta a la etiqueta siguiente

        finLen:
            sub eax, ebx    ; longitud de la cadena
            pop ebx         ; obtemos lo que sea que hay en la ultima posicion de pila
            ret             ; implementa un return porque es una funcion

    ; print(f"{eax}\n")
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

    ; print(eax)
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

    ;print(f"{int(eax)}\n")
    printIntLn:
        call printInt

        push eax
        mov eax, 0AH

        push eax
        mov eax, esp
        call printStr

        pop eax
        pop eax

        ret

    ; print(int(eax))
    printInt:
        ; limpiar las pilas
        push eax
        push ecx
        push edx
        push esi

        mov ecx, 0

        divLoop:
            inc ecx     ; conteo digits
            mov edx, 0  ; limpiar parte alta del dividendo

            mov esi, 10 ; esi = 10 (divisor)
            idiv esi    ; división entera <edx:eax> / esi

            add edx, 48
            push edx
            cmp eax, 0
            jnz divLoop

        printLoop:
            dec ecx
            mov eax, esp
            call printStr
            pop eax

            cmp ecx, 0
            jnz printLoop

        pop esi
        pop edx
        pop ecx
        pop eax

        ret

    ; exit(0)
    endP: 
        mov     ebx, 0      ; return 0
        mov     eax, 1      ; llama a SYS_EXIT (kernel.opcode 1)
        int 80h             ; llamada de interrupscion de kernel