;Author: Gabrielius Gintalas
;Date: 09/22/23
;File Function: Input data into the array
;Program name: Assignment 02 - Array Management
;NASM Version: 2.15.05
extern scanf
global input_function

section .data
    floatFormat db "%lf", 0             ;String format to scanf a double

section .bss
    align 64
    Save resb 832
    input resq 1                        ;Temporarily hold the user input

section .text
    input_function:
        push       rbp                  ;Save a copy of the stack base pointer
        mov        rbp, rsp             ;We do this in order to be 100% compatible with C and C++.
        push       rbx                  ;Back up rbx
        push       rcx                  ;Back up rcx
        push       rdx                  ;Back up rdx
        push       rsi                  ;Back up rsi
        push       rdi                  ;Back up rdi
        push       r8                   ;Back up r8
        push       r9                   ;Back up r9
        push       r10                  ;Back up r10
        push       r11                  ;Back up r11
        push       r12                  ;Back up r12
        push       r13                  ;Back up r13
        push       r14                  ;Back up r14
        push       r15                  ;Back up r15
        pushf                           ;Back up rflags
        pushf                           ;Back up rflags

        mov rax, 7
        mov rdx, 0
        xsave [Save]

        xor r13, r13                    ;Set r13 to 0 (loop counter)
        xor r15, r15                    ;Set r15 to 0 (variable counter)
        mov r14, rdi                    ;Set address of array to r14        
        mov r12, rsi                    ;Set the value of maxSize to r12

    loop_start:
        cmp r13, r12                    ;Check if r13 = maxSize
        jge loop_end                    ;If so, jump to end

        xorpd xmm0, xmm0                ;Clean up xmm0
        movsd [input], xmm0             ;Move the value of xmm0 into the input var

        mov rax, 0                      ;No floats will be printed
        mov rdi, floatFormat            ;Prepare to enter a float
        mov rsi, input                  ;This value will be set to the user input
        call scanf                      ;Scan for user input

        cmp rax, -1                     ;Check if user clicked ctrl-d
        je loop_end                     ;If so, jump to end

        cmp rax, 1                      ;Check if there is valid user input
        je addTor15                     ;Jump to variable counter fucntion which increases the value

    addVar:
        movsd xmm0, [input]             ;Move the input back to xmm0
        movsd [r14 + r13 * 8], xmm0     ;Move xmm0 into the correct address of the array

        inc r13                         ;Increase loop counter
        jmp loop_start                  ;Jump back to start

    addTor15:   
        inc r15                         ;Increase variable counter
        jmp addVar                      ;Jump to function that is responsible for adding user input to function
        
    loop_end: 
        mov rax, 7
        mov rdx, 0
        xrstor [Save]

        mov rax, r15
        
        popf                            ;Restore rflags
        popf                            ;Restore rflags
        pop        r15                  ;Restore r15
        pop        r14                  ;Restore r14
        pop        r13                  ;Restore r13
        pop        r12                  ;Restore r12
        pop        r11                  ;Restore r11
        pop        r10                  ;Restore r10
        pop        r9                   ;Restore r9
        pop        r8                   ;Restore r8
        pop        rdi                  ;Restore rdi
        pop        rsi                  ;Restore rsi
        pop        rdx                  ;Restore rdx
        pop        rcx                  ;Restore rcx
        pop        rbx                  ;Restore rbx
        pop        rbp                  ;Restore rbp
        ret                             ;End this function
