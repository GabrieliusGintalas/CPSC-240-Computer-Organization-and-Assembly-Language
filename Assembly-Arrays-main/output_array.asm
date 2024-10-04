;Author: Gabrielius Gintalas
;Date: 09/22/23
;File Function: Print all variables in array
;Program name: Assignment 02 - Array Management
;NASM Version: 2.15.05

extern printf
global print_function

section .data
    floatFormat db "%.10lf",10,0    ;String format to printf a double 

section .bss
    align 64
    Save resb 832

section .text
    print_function:
        push       rbp              ;Save a copy of the stack base pointer
        mov        rbp, rsp         ;We do this in order to be 100% compatible with C and C++.
        push       rbx              ;Back up rbx
        push       rcx              ;Back up rcx
        push       rdx              ;Back up rdx
        push       rsi              ;Back up rsi
        push       rdi              ;Back up rdi
        push       r8               ;Back up r8
        push       r9               ;Back up r9
        push       r10              ;Back up r10
        push       r11              ;Back up r11
        push       r12              ;Back up r12
        push       r13              ;Back up r13
        push       r14              ;Back up r14
        push       r15              ;Back up r15
        pushf                       ;Back up rflags
        pushf                       ;Back up rflags

        mov rax, 7
        mov rdx, 0
        xsave [Save]

        xor r13, r13                ;Set r13 to 0   
        mov r14, rdi                ;Get the address of the array and set it to r14
        mov r15, rsi                ;Get the number of variables in array

    loop_start:
        cmp r13, r15                ;Check if the loop counter = variable count
        jge loop_end                ;If so, jump to end

        mov rax, 1                  ;1 float will be printed
        mov rdi, floatFormat        ;Argument for printf
        movsd xmm0, [r14 + r13 * 8] ;Get the variable at each address  
        call printf                 ;Print variable

        inc r13                     ;Increase counter
        jmp loop_start              ;Jump back to start

    loop_end:
        mov rax, 7
        mov rdx, 0
        xrstor [Save]

        popf                         ;Restore rflags
        popf                         ;Restore rflags
        pop        r15               ;Restore r15
        pop        r14               ;Restore r14
        pop        r13               ;Restore r13
        pop        r12               ;Restore r12
        pop        r11               ;Restore r11
        pop        r10               ;Restore r10
        pop        r9                ;Restore r9
        pop        r8                ;Restore r8
        pop        rdi               ;Restore rdi
        pop        rsi               ;Restore rsi
        pop        rdx               ;Restore rdx
        pop        rcx               ;Restore rcx
        pop        rbx               ;Restore rbx
        pop        rbp               ;Restore rbp
        ret                          ;End this function
