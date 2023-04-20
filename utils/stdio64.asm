SECTION .text
    endP:
        mov rax, 60
        xor rdi, rdi
        syscall

        strLen:
            push rbx
            mov rbx, rax

            stlLoop:
                cmp byte[rax], 0
                    jz stlEnd

                inc rax
                jmp stlLoop

            stlEnd:
                sub rax, rbx
                pop rbx
                ret

    printStr:
        push rax
        push rbx
        push rcx
        push rdx
        push rax

        push rax
        call strLen

        mov rdx, rax
        pop rax

        mov rdx, rdx
        mov rsi, rax
        mov rdi, 1
        mov rax, 1
        syscall
        
        pop rax
        pop rbx
        pop rcx
        pop rdx
        pop rax

        ret