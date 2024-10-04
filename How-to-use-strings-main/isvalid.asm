global isValid
extern printf, scanf

section .data
    stringFormat db "%s", 0
    InvalidInput db "Invalid Input!!!", 10, 0
    FunctionCalled db "isValid got called successfully!", 10, 0
    CheckingDecimals db "Decimal checking", 10

section .bss
    align 64
    Save resb 832

section .text
    isValid:
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

        ;Set up xsave
        mov rax, 7
        mov rdx, 0
        xsave [Save]

        mov r13, rdi ;Set the number we are looking at to r13
        xor rcx, rcx
        xor rdx, rdx
        mov rdi, r13 
        xor r14, r14

    check_value:
        mov al, byte [rdi]  
        cmp al, 0           
        je check_decimal     
        
        cmp al, '.'        
        je found_decimal  

        cmp al, '+'
        je found_sign 

        cmp al, '-'
        je found_sign

        cmp al, ' '
        je print_invalid

        cmp al, '0'
        jl print_invalid   ; If the character is less than '0', it's not a digit
        cmp al, '9'
        jg print_invalid   ; If the character is greater than '9', it's not a digit
                
        inc rdi             
        jmp check_value   

    found_decimal:
        inc rcx             ; Increment the decimal point counter

        cmp rcx, 2          ; Check if this is the second decimal point
        jge print_invalid   ; If it is, jump to print_invalid

        inc rdi             ; Move to the next character in the string
        jmp check_value   ; Otherwise, continue checking the rest of the string

    found_sign:
        inc rdx              ; Increment the plus sign counter

        cmp rdx, 2           ; Check if this is the second plus sign
        jge print_invalid   ; If it is, jump to print_invalid

        mov bl, byte [rdi+1] ; Peek the next character
        cmp bl, 0            ; Check if the next character is null terminator
        je print_invalid     ; If it is, it means '+' or '-' is at the end

        inc rdi             ; Move to the next character in the string
        jmp check_value     ; Otherwise, continue checking the rest of the string

    check_decimal:
        cmp rcx, 1
        jb print_invalid

        jmp finish

    print_invalid:
        mov r14, 1
        jmp finish       ; Jump to the end of the function to stop further execution

    finish:
        mov rax, 7
        mov rdx, 0
        xrstor [Save]

        mov rax, r14

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
   