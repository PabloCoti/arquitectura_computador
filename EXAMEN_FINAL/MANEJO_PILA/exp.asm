extern printf


SECTION .data
    format: db "%f", 10, 0

SECTION .bss
    base: resq 1
    exponente: resq 1

SECTION .text
    global main

    main:
        mov eax, base
        pop eax
        mov eax, exponente


        call elevate

elevate:
    push rbp
    push ecx

    mov ecx, 1

    .elevateLoop:
        cmp ecx, [exponente]
            je .end

        fld qword [base]
        fmul qword [base]
        fstp qword [base]

        inc ecx
        jmp .elevateLoop

    .end:
        mov rdi, format
        movq xmm0, [base]
        mov rax, 3

        call printf

    pop rbp

    mov rax, 1
    xor rbx, rbx

    int 80h


; HOW TO EXECUTE
; nasm -f elf64 archive.asm -l arvhie.lst
; gcc -m64 archive.o -o archive.e -no-pie
; ./archive.e