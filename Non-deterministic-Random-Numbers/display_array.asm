global display_array
extern printf

section .data
    TypeOfNum db "IEEE754			Scientific Decimal", 10, 0
    NumFormat db "0x%016llx      %18.13g", 10, 0

section .bss
    align 64
    Save resb 832


section .text
    display_array:
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


        xor r13, r13            ; Initialize loop counter
        mov r14, rdi          ; Address of the array
        mov r15, rsi          ; Number of elements in the array

        mov rax, 0
        mov rdi, TypeOfNum 
        call printf 
        
    print_loop:
        cmp r13, r15          ; Compare counter with number of elements
        jge end_print          ; If counter >= number of elements, exit loop

        mov rax, 1
        mov rdi, NumFormat  
        mov rsi, [r14 + r13  * 8]
        movsd xmm0, [r14 + r13 * 8]
        call printf   

        ; Inrease the index and repeat the loop
        inc r13      
        jmp print_loop      ; Loop back to the start

    end_print:
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

        ret