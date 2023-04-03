; CONTROL GENERAL DE CADENAS


%include '../../utils/stdio32.asm'
%include '../../utils/string32.asm'

SECTION .data
    msgn db 'Nombre: ', 0
    msgln db 'Apellido: ', 0
    msgc db 'Pais: ', 0

    msggn db 'Hola ', 0
    msggc db ' del pais ', 0
    
    msgip db 'Impresion de entero: ', 0
    msggt db 'GOTO HERE', 0

    msgl db 'minusculas', 0
    msgu db 'MAYUSCULAS', 0

    msgspc db ' ', 0

SECTION .bss
    name: resb 255
    last_name: resb 255
    country: resb 255

SECTION .text
    global _start

    _start:
        ; mayusculas a minusculas
        mov eax, msgu
        call lower
        call printStrLn

        ; minusculas a mayusculas
        mov eax, msgl
        call upper
        call printStrLn

        ; pedido de nombre, apellido y pais con su impresion en pantalla
        call NAP

        ; concatenacion de texto
        call concatenate

        ; printInt
        call print_number

        ; gotoxy
        call goto_action

        call endP

    goto_action:
        call clear

        mov dl, 57
        mov dh, 57
        call gotoxy

        mov eax, msggt
        call printStrLn
    
    print_number:
        mov eax, msgip
        call printStr

        mov eax, 19
        call printIntLn

    concatenate:
        mov         eax, msgc
        mov         ebx, msggc
        call        concat
        call        printStrLn
        ret

    NAP:
        ask_name:
            mov eax, msgn
            call lower
            call printStr

            call input
            call upper

            mov esi, eax
            mov edi, name
            push eax
            
            call strLen

            mov ecx, eax
            pop eax

            cld
            rep movsb

        ask_last_name:
            mov eax, msgln
            call printStr
            call input
            call upper

            mov esi, eax
            mov edi, last_name
            push eax
            
            call strLen

            mov ecx, eax
            pop eax

            cld
            rep movsb

        ask_country:
            mov eax, msgc
            call printStr
            call input
            call upper

            mov esi, eax
            mov edi, country
            push eax
            
            call strLen

            mov ecx, eax
            pop eax

            cld
            rep movsb

        NAP_output:
            mov eax, msggn
            call printStr

            mov eax, name
            call printStr

            mov eax, msgspc
            call printStr

            mov eax, last_name
            call printStr

            mov eax, msggc
            call printStr

            mov eax, country
            call printStrLn

        ret



; HOW TO EXCECUTE PROGRAM
; nasm -f elf32 archive_name.asm -o archive_name.o
; ld -m elf_i386 archive_name.o -o archive_name.e
; ./archive_name

; HOW TO CHECK FOR ERROR
; echo $?
