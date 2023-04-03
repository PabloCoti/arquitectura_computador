section .data
    string1 db "Hello, ", 0
    string2 db "World!", 0
    result db 20 dup(0)

section .text
    global _start

_start:
    ; Copy the first string to the result buffer
    mov eax, string1
    mov ebx, result
    call strcpy
    
    ; Append the second string to the result buffer
    mov eax, string2
    mov ebx, result
    call strcat
    
    ; Print the result string
    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, strlen ;(result)
    int 0x80

    ; Exit the program
    mov eax, 1
    xor ebx, ebx
    int 0x80

; strcpy implementation
strcpy:
    push ebx
    mov ebx, eax
    
loop:
    mov al, [eax]
    mov [ebx], al
    cmp al, 0
    je endloop
    inc eax
    inc ebx
    jmp loop
    
endloop:
    pop ebx
    ret

; strcat implementation
strcat:
    push ecx
    push edx
    mov ecx, eax
    mov edx, ebx
    call strlen
    add eax, edx
    mov ebx, eax
    mov eax, ecx
    call strlen
    
loop:
    mov al, [eax]
    mov [ebx], al
    cmp al, 0
    je endloop
    inc eax
    inc ebx
    jmp loop
    
endloop:
    pop edx
    pop ecx
    ret
    
; strlen implementation
strlen:
    push ebx
    mov ebx, eax
    
loop:
    cmp byte [eax], 0
    je endloop
    inc eax
    jmp loop
    
endloop:
    sub eax, ebx
    pop ebx
    ret
