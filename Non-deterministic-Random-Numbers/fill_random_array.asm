global fill_array
extern rdrand

section .data
section .bss
    align 64
    Save resb 832


section .text
    fill_array:
        push        rbp
        mov         rbp, rsp
        push        rbx
        push        rcx
        push        rdx
        push        rsi
        push        rdi
        push        r8
        push        r9
        push        r10
        push        r11
        push        r12
        push        r13
        push        r14
        push        r15
        pushf

        mov rax, 7
        mov rdx, 0
        xsave [Save]

        xor r13, r13
        mov r14, rdi  ; Set rdi to point to the beginning of the array
        mov r15, rsi

    generate_numbers:
        cmp r13, r15          
        jge end_generation      

        rdrand r12             
        
        mov [r14 + r13 * 8], r12

        inc r13
        jmp generate_numbers

    end_generation:
        mov rax, 7
        mov rdx, 0
        xrstor [Save]

        popf
        pop         r15
        pop         r14
        pop         r13
        pop         r12
        pop         r11
        pop         r10
        pop         r9
        pop         r8
        pop         rdi
        pop         rsi
        pop         rdx
        pop         rcx
        pop         rbx
        pop         rbp
