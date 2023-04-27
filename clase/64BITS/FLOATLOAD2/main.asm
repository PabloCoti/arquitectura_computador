extern printf


SECTION .data
    pi: dq 3.14159
    radio: dq 5.0
    format: db "C = ¶*R = %f * %f = %f", 10, 0

SECTION .bss
    c: resq 1

SECTION .text
    global main

    main:
        push rbp
        fld qword [radio]           ; carga el radio al registro ST0
        fmul qword [pi]             ; radio * pi
        fstp qword [c]              ; guarda el resultado en el registro ST0

        mov rdi, format             ; cadena con formato de impresion
        movq xmm0, qword [pi]       ; 1er parametro de coma flotante pi
        movq xmm1, qword [radio]    ; 2do parametro de coma flotante racio
        movq xmm2, qword [c]         ; 3er parametro de coma flotante C
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
