; string32


SECTION .data
    cls db 1Bh, '[2J', 0
    pos db 1Bh, '[01;01H', 0

    base dd 10

SECTION .bss
    input1: resb 127
    input2: resb 128
    temp: resb 255

SECTION .text
    ; eax.upper()
    upper:
        push eax
        push ebx
        mov ebx, eax

        upperLoop:
            cmp byte[ebx], 0
                jz uplEnd

            cmp byte[ebx], 97
                jl uplContinue

            cmp byte[ebx], 122
                jg uplContinue

            mov al, [ebx]
            sub al, 32
            mov byte[ebx], al

        uplContinue:
            inc ebx
            jmp upperLoop

        uplEnd:
            pop ebx
            pop eax

            ret

    ; eax.lower()
    lower:
        push eax
        push ebx
        mov ebx, eax

            lowerLoop:
                cmp byte[ebx], 0
                    jz lolEnd

                cmp byte[ebx], 65
                    jl lolContinue

                cmp byte[ebx], 90
                    jg lolContinue

                mov al, [ebx]
                add al, 32
                mov byte[ebx], al

            lolContinue:
                inc ebx
                jmp lowerLoop

            lolEnd:
                pop ebx
                pop eax

                ret

    ; eax = input1 + input2
    concat:
        push ecx
        push esi
        push edi

        concatCopyData:
            mov esi, eax
            mov edi, input1
            push eax
            call strLen

            mov ecx, eax
            pop eax
            cld

            rep movsb

            mov esi, ebx
            mov edi, input2
            push eax
            call strLen

            mov ecx, eax
            pop eax
            cld

            rep movsb

        mov esi, input1
        mov edi, temp

        mov eax, input1
        call strLen
        
        mov ecx, eax
        rep movsb

        mov esi, input2
        mov eax, input2
        call strLen

        mov ecx, temp
        add ecx, eax
        mov edi, ecx
        mov eax, input2
        call strLen

        inc eax
        mov ecx, eax
        rep movsb

        mov eax, temp

        pop edi
        pop esi
        pop ecx

        ret

    ; system('cls')
    clear:
        mov eax, cls
        call printStr

        ret

    gotoxy:
        mov eax, pos
        mov ebx, eax

        gotoxyLoop:
            cmp byte[ebx], 0
                jz golEnd

            cmp byte[ebx], '['
                je gol_x

            cmp byte[ebx], ';'
                je gol_y
            
            inc ebx
            jmp gotoxyLoop

        gol_x:
            add ebx, 2
            mov byte[ebx], dh
            jmp gotoxyLoop

        gol_y:
            add ebx, 2
            mov byte[ebx], dl
            jmp gotoxyLoop

        golEnd:
            call printStr
            int 80

        ret

    ; eax = int(eax)
    stoi:
        ; limpiar pilas
        push ebx
        push ecx

        ; declarar variables
        mov ebx, eax

        xor eax, eax

        ; ciclo que recorre la cadena
        stoiLoop:
            movzx ecx, byte[ebx]

            ; verificar si estoy al final
            cmp ecx, 0
                ;si cumple terminar ciclo
                je stlEnd

            ; verificar si es una letra
            cmp ecx, 48
                ; si cumple continue
                jl stlContinue

            ; verificar si es una letra
            cmp ecx, 57
                ; si cumple continue
                jg stlContinue

            ; si NO sumar 48 y continuar ciclo
            sub ecx, 48
            imul eax, 10
            add eax, ecx

        stlContinue:
            inc ebx
            jmp stoiLoop

        stlEnd:
            ; reestablecer valores de pila
            pop ebx
            pop ecx
            
            ;retornar eax
            ret

    ; string number_to_string = number.str()
    str:
        ; limpiar pilas
        push ebx
        push ecx
        push edx
        push esi

        ; declarar variables
        mov esi, temp

        xor ecx, ecx

        ; ciclo que recorre la cadena
        strLoop:
            ; verificar si estoy al final
            cmp eax, 0
                jle strEnd

            ; vaciar edx (resultado de la division)
            xor edx, edx

            ; edx = 10
            mov ebx, [base]

            ; edx/10
            div ebx

            ; si NO sumar 48 y continuar ciclo
            add dl, 48
            ; agregar a la 'lista'
            mov byte[esi], dl
            inc esi

            jmp strLoop

        strEnd:
            ; INVERTIR LA CADENA Y RETORNAR EL VALOR

            push esi

            ; calcular longitud de cadena
            mov eax, temp
            call strLen
            ; edx = len(cadena)
            mov edi, eax

            mov esi, temp ; cadena[0]
            lea edi, [esi+edi-1]

            reverseLoop:
                mov al, [esi]
                xchg al, [edi]
                mov [esi], al
                inc esi
                dec edi

                cmp esi, edi
                    jl reverseLoop

            pop esi
            mov byte[esi], 0h ; agregar teminacion de cadena
            mov eax, temp

            pop ebx
            pop ecx
            pop edx
            pop esi

            ret

            