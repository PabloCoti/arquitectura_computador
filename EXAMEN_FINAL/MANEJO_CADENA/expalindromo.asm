%include '../../utils/stdio32.asm'
%include '../../utils/string32.asm'


SECTION .data
    msg1 db 'Ingrese cadena: ', 0h
    msgt db 'Palindromo', 0h
    msgf db 'NO Palindromo', 0h

SECTION .bss
    buffer: resb 255
    olstr: resb 255

SECTION .text
    global _start

    _start:
    mov eax, msg1
    call printStr
    call input
    
    mov eax, [olstr]

    call expalindromo

expalindromo:
    push ebx
    push ecx
    push esi

    mov esi, buffer
    mov ebx, eax

    .expLoop:
        movzx ecx, byte[ebx]

        cmp ecx, 0
            jle .revert

        mov byte[esi], ecx

        inc ebx
        
        jmp .expLoop

    .revert:
        push edi
        push esi

        mov eax, buffer

        call strLen

        mov edi, eax
        mov esi, buffer

        lea edi, [esi+edi-1]

        .revertLoop:
            mov al, [esi]
            xchg al, [edi]

            mov [esi], al
            inc esi
            dec edi
            cmp esi, edi
                jl .revertLoop

    .end:
        pop esi
        mov byte[esi], 0h
        mov eax, buffer
        mov ebx, olstr

        cmp eax, ebx
            jl .equals

        jmp .nequals

    .equals:
        mov eax, msgt
        call printStrLn
        
    .nequals:
        mov eax, msgf
        call printStrLn
        
    pop ebx
    pop ecx
    pop esi

    call endP
    

; HOW TO EXCECUTE PROGRAM
; nasm -f elf32 archive_name.asm -o archive_name.o
; ld -m elf_i386 archive_name.o -o archive_name.e
; ./archive_name

; HOW TO CHECK FOR ERROR
; echo $?
