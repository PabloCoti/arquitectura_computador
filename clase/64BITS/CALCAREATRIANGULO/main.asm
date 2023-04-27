extern printf


SECTION .data
    base: dq 10.0
    altura: dq 2.0
    div_base: dq 2.0
    format: db "C = (B*A)/2 = (%f * %f)/2 = %f", 10, 0

SECTION .bss
    r: resq 1
    c: resq 1

SECTION .text
    global main

    main:
        ; CALCULO DEL VALOR
        push rbp
        fld qword [altura]          ; carga el radio al registro ST0
        fmul qword [base]           ; radio * pi
        fstp qword [r]              ; guarda el resultado en el registro ST0

        fld qword [r]               ; carga el radio al registro ST1
        fdiv qword [div_base]       ; r/div_base
        fstp qword [c]              ; guarda el resultado en el registro ST1

        ; PRINT EN PANTALLA
        mov rdi, format             ; cadena con formato de impresion
        movq xmm0, qword [base]     ; 1er parametro de coma flotante pi
        movq xmm1, qword [altura]   ; 2do parametro de coma flotante racio
        movq xmm2, qword [c]        ; 3er parametro de coma flotante C
        mov rax, 3                  ; numero de parametros de coma flotante

        call printf

        pop rbp

        mov rax, 1
        xor rbx,rbx

        int 80h

; HOW TO EXECUTE
; nasm -f elf64 archive.asm -l arvhie.lst
; gcc -m64 archive.o -o archive.e -no-pie
; ./archive.e
