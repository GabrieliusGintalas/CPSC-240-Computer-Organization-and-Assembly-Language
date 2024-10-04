;****************************************************************************************************************************
;Program name: "How to use strings".  
;Copyright (C) 2023 Gabrielius Gintalas.                                                                                    *
;                                                                                                                           *
;This file is part of the software program "How to use stringss".                                                        *
;How to use strings is free software: you can redistribute it and/or modify it under the terms of the GNU General Public*
;License version 3 as published by the Free Software Foundation.                                                            *
;Basic Float Operations is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the       *
;implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more      *
;details.  A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                  *
;****************************************************************************************************************************

;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;
;Author information
;  Author name: Gabrielius Gintalas
;  Author email: gabrieliusgintalas@csu.fullerton.edu
;  Author CWID: 885861872
;  Author NASM: NASM version 2.15.05 
;  Author Class: 240-03
;
;Program information
;  Program name: How to use strings
;  Programming languages: One module in C++ and one module in X86
;  Date program began: Nov-6-2023
;  Date of last update: Nov-6-2023
;  Date comments upgraded: Nov-6-2023
;  Due Date: Nov-11-2023 - Midnight
;  Date open source license added: Nov-6-2023
;  Files in this program: faraday.asm, ampere.cpp
;  Status: WIP.
;
;Purpose
; ...
;
;This file
;  File name: faraday.asm
;  File purpose: 
;  Language: X86 with Intel syntax.
;  Max page width: 132 columns
;  Assemble: nasm -f elf64 -l faraday.lis -o faraday.o faraday.asm

global faraday
extern printf, scanf, atof, isValid

section .data
    stringFormat db "%s", 0
    floatFormat db "%lf", 0

    EnterName db "Please enter your name: ", 0
    EnterProfession db "Please enter your title or profession: ", 0
    Welcome db "We always welcome a %s to our electrical lab. ", 10, 0
    EnterVoltage db "Please enter the voltage of the electrical system at your site (volts): ", 0
    EnterOhms db "Please enter the electrical resistance in the system at your site (ohms): ", 0
    EnterTime db "Please enter the time your system was operating (seconds): ", 0
    ThankYou db "Thank you %s. We at Majestic are pleased to inform you that your system performed %lf joules of work.", 0
    Congrats db "Congratulations %s. Come back any time and make use of our software.",10 ,0
    TitleCard db "Everyone with title %s is welcome to use our programs at a reduced price.", 10, 0
    Attention db "Attention %s. Invalid inputs have been encountered. Please run the program again.", 10, 0

section .bss
    align 64
    Save resb 832

    Name resq 1 ;Users name
    Profession resq 1 ;Users profession
    Voltage resb 64 ;Voltage amount
    Ohms resb 64 ;Ohm amount
    Time resb 64 ;Time amount

    Power resq 1 ;Total power
    Joules resq 1 ;Total Joules 


section .text
    faraday:
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

        xorpd xmm10, xmm10
        xorpd xmm11, xmm11
        xorpd xmm12, xmm12

        mov rax, 0
        mov rdi, stringFormat
        mov rsi, EnterName
        call printf

        mov rax, 0
        mov rdi, stringFormat
        mov rsi, Name            
        call scanf

        mov rax, 0
        mov rdi, stringFormat
        mov rsi, EnterProfession
        call printf

        mov rax, 0
        mov rdi, stringFormat
        mov rsi, Profession           
        call scanf

        mov rax, 0
        mov rdi, Welcome
        mov rsi, Profession
        call printf

        mov rax, 0
        mov rdi, stringFormat
        mov rsi, EnterVoltage
        call printf

        mov rax, 0
        mov rdi, stringFormat
        mov rsi, Voltage           
        call scanf

        mov rax, 0
        mov rdi, Voltage
        call isValid
        cmp rax, 1
        je invalid_input

        mov rdi, Voltage
        call atof
        movsd xmm10, xmm0

        mov rax, 0
        mov rdi, stringFormat
        mov rsi, EnterOhms
        call printf

        mov rax, 0
        mov rdi, stringFormat
        mov rsi, Ohms           
        call scanf

        mov rax, 0
        mov rdi, Ohms
        call isValid
        cmp rax, 1
        je invalid_input

        mov rdi, Ohms
        call atof
        movsd xmm11, xmm0

        mov rax, 0
        mov rdi, stringFormat
        mov rsi, EnterTime
        call printf

        mov rax, 0
        mov rdi, stringFormat
        mov rsi, Time           
        call scanf

        mov rax, 0
        mov rdi, Time
        call isValid
        cmp rax, 1
        je invalid_input

        mov rdi, Time
        call atof
        movsd xmm12, xmm0

        mulsd xmm10, xmm10 ;(V^2)

        mulsd xmm10, xmm12 ;((V^2) x T)
    
        divsd xmm10, xmm11 ;((V^2) x T) / R

        movsd qword [Joules], xmm10

        jmp exit

    invalid_input:
        mov rax, 0
        mov rdi, Attention
        mov rsi, Profession
        call printf

        jmp exit

    exit:
        mov rax, 7
        mov rdx, 0
        xrstor [Save]

        ;Move the value of r11 to xmm0 to return it to the main.c file  
        movsd xmm0, [Joules]               ;Move the value of the sum to xmm0 for return

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
