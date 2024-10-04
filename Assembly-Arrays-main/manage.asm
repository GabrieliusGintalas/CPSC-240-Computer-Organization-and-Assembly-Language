;Author: Gabrielius Gintalas
;Date: 09/22/23
;File Function: Call all functions and print message
;Program name: Assignment 02 - Array Management
;NASM Version: 2.15.05
extern printf
extern input_function, print_function, sum_array            
global manage

maxSize equ 8                         ;Set maxSize as a constant value of 8

section .data
    welcomeMsg db "We will take care of all your array needs.", 10, 0
    inputMsg db "Please input float numbers separated by ws.  After the last number press ws followed by control-d.", 10, 0
    yourNum db "Thank you.  The numbers in the array are:", 10, 0
    yourSum db "The sum of numbers in the array is %.10lf", 10, 0
    thankyouMsg db "Thank you for using Array Management System.", 10, 0

section .bss
    align 64
    Save resb 832
    array resq maxSize                ;Initialize array of the maximum size of 8 quadwords
    

section .text
    manage:
        push       rbp                ;Save a copy of the stack base pointer
        mov        rbp, rsp           ;We do this in order to be 100% compatible with C and C++.
        push       rbx                ;Back up rbx
        push       rcx                ;Back up rcx
        push       rdx                ;Back up rdx
        push       rsi                ;Back up rsi
        push       rdi                ;Back up rdi
        push       r8                 ;Back up r8
        push       r9                 ;Back up r9
        push       r10                ;Back up r10
        push       r11                ;Back up r11
        push       r12                ;Back up r12
        push       r13                ;Back up r13
        push       r14                ;Back up r14
        push       r15                ;Back up r15
        pushf                         ;Back up rflags
        pushf                         ;Back up rflags

        mov rax, 7
        mov rdx, 0
        xsave [Save]

        ;Print welcomeMsg
        mov qword rax, 0           
        push rax
        mov rdi, welcomeMsg
        call printf 
        pop rax

        ;Print inputMsg
        mov qword rax, 0 
        push rax
        mov rdi, inputMsg
        call printf
        pop rax

        mov rdi, array                 ;Move array address to rdi
        mov rsi, maxSize               ;Move maxSize address to rsi
        call input_function            ;Call the input function
        mov r15, rax

        ;Print yourNum
        mov qword rax, 0
        push rax
        mov rdi, yourNum
        call printf
        pop rax

        mov rsi, r15                   ;Set the variable counter value to rsi
        mov rdi, array                 ;Set the array address to rdi
        call print_function            ;Print the values in the function

        mov rsi, r15                   ;Move the variable counter value to rsi
        mov rdi, array                 ;Move the array address to rdi
        call sum_array                 ;Call the sum array
        movq xmm0, [r12]                 ;Move the value of the sum to xmm1

        ;Print yourSum + value of sum (this prints the correct number)
        push rax                     
        mov rdi, yourSum
        call printf
        pop rax

        ;Print thankyouMsg
        mov qword rax, 0
        push rax
        mov rdi, thankyouMsg
        call printf
        pop rax

        mov rax, 7
        mov rdx, 0
        xrstor [Save]

        ;Move the value of r11 to xmm0 to return it to the main.c file  
        movsd xmm0, [r12]               ;Move the value of the sum to xmm0 for return

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

        ret