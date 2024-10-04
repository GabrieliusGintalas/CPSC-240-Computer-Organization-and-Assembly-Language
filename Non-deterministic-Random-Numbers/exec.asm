global execute
extern fill_array, display_array, normalize_array
extern printf
extern scanf
extern atoi
extern fgets
extern printf
extern strlen
extern stdin
extern atoi


maxSize equ 100

section .data
    stringFormat db "%s", 0
    floatFormat db "%lf", 0
    printCount db  "NumberCount is: %lf", 0

    EnterName db "Please enter your name: ", 0
    EnterTitle db "Please enter your title (Mr, Ms, Sargeant, Chief, Project Leader, etc.): ", 0
    NiceToMeet db "Nice to meet you %s %s", 10, 0
    WhatWillDo db "This program will generate 64-bit IEEE float numbers.", 10, 0
    HowManyNums db "How many numbers do you want. Today's limit is 100 per customer. ", 0
    OriginalArray db "Your numbers have been stored in an array. Here is that array.", 10, 0
    NormalizedArray db "The array will now be normalized to the range 1.0 to 2.0. Here is the normalized array", 10, 0
    Goodbye db "Goodbye %s. You are welcome any time.", 10, 0


section .bss
    align 64
    Save resb 832

    array resq maxSize

    Name resb 64
    Title resb 64
    NumberCount resb 64


section .text
    execute:
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

        
        mov rax, 0
        mov rdi, EnterName
        call printf

        mov rax, 0
        mov rdi, Name
        mov rsi, maxSize  		            ; Accept 59, null at the end
        mov rdx, [stdin]
        call fgets			                ; Stops on \n

        ; Remove the newline character
        mov rax, 0
        mov rdi, Name
        call strlen
        mov byte[Name + rax - 1], byte 0

        mov rax, 0
        mov rdi, EnterTitle
        call printf

        mov rax, 0
        mov rdi, Title
        mov rsi, maxSize  		            ; Accept 59, null at the end
        mov rdx, [stdin]
        call fgets			                ; Stops on \n

        ; Remove the newline character
        mov rax, 0
        mov rdi, Title
        call strlen
        mov byte[Title + rax - 1], byte 0

        mov rax, 0
        mov rdi, NiceToMeet
        mov rsi, Title
        mov rdx, Name
        call printf

        mov rax, 0
        mov rdi, WhatWillDo
        call printf

        mov rax, 0
        mov rdi, HowManyNums
        call printf

        ;Get the count input
        mov rax, 0
        mov rdi, NumberCount           ;How many numbers do you want. Today’s limit is 100 per customer: 
        mov rsi, maxSize
        mov rdx, [stdin]
        call fgets

        ;Remove the newline character
        mov rax, 0
        mov rdi, NumberCount
        call strlen
        mov byte[NumberCount + rax - 1], byte 0

        ;Convert input_count from string to int
        mov rax, 0
        mov rdi, NumberCount
        call atoi
        mov r15, rax

        ;Print the prompt_print_num_1
        mov rax, 0
        mov rdi, OriginalArray  ;Your numbers have been stored in an array. Here is that array.
        call printf

        ;Generate random numbers inside the array
        mov rax, 0
        mov rdi, array
        mov rsi, r15
        call fill_array

        ;Show the content of the array
        mov rax, 0
        mov rdi, array
        mov rsi, r15
        call display_array

        mov rax, 0
        mov rdi, NormalizedArray
        call printf

        mov rax, 0
        mov rdi, array
        mov rsi, r15
        call normalize_array

        ;Show the content of the array
        mov rax, 0
        mov rdi, array
        mov rsi, r15
        call display_array
        
        mov rax, 0
        mov rdi, Goodbye
        mov rsi, Title
        call printf

        mov rax, 7
        mov rdx, 0
        xrstor [Save]

        mov rax, Name

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

