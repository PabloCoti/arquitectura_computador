; este es el hola mundo version 4
; creador: pacoti
; fecha: 8 de marzo del 2023
; Ejemplo no. 4 del ensamblador, subrutinas


; Calc string lenght
strLen:
; strLen(eax=string) -> eax int n = longitud
    push ebx            ; ebx en pila
    mov eax, edx        ; set memory dir to edx

sigChar:                ; sigChar is the function name
    cmp byte[eax], 0    ; if msg[eax] == 0
    jz  finLen           ; GOTO finLen if if statement is true
    inc eax             ; eax++

    jmp sigChar         ; recall function

finLen:
    sub eax, ebx        ; get string lenght
    pop ebx             ; like list.pop, but moves the value to ebx

    ret                 ; return

;---------------------------Screen Print------------------------------------
; void printStr(string=eax)
printStr:
        ; guardar los registros de los valores en la pila
        push edx
        push ecx
        push ebx
        push eax

        call strLen     ; eax = strLen(string=eax)
        mov edx, eax
        pop eax
        mov ecx, eax
        mov ebx, 1
        mov eax, 4
        int 80h

        pop ebx
        pop ecx
        pop edx

        ret

; --------------------------print str w line jmp----------------------------
; void printStrLen(eax = string)
; prints the sting w a line jump at the end
printStrLn:
        call    printStr
        push    eax
        mov     eax, 0Ah
        push    eax
        
        mov     eax, esp
        call    printStr

        pop     eax
        pop     eax

        ret

; ---------------------------end program------------------------------------
; void endP()
endP:
    mov ebx, 0          ; return 0
    mov eax, 1          ; llama a SYS_EXIT (kernel.opcode 1)
    int 80h             
