/*
*****************************************************************************************************************************
*Program name: "How to use strings".                                                                                        *
*Copyright (C) 2023 Gabrielius Gintalas.                                                                                    *
*                                                                                                                           *
*This file is part of the software program "How to use stringss".                                                           *
*How to use strings is free software: you can redistribute it and/or modify it under the terms of the GNU General Public    *
*License version 3 as published by the Free Software Foundation.                                                            *
*Basic Float Operations is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY without even the        *
*implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more      *
*details.  A copy of the GNU General Public License v3 is available here:  <https:www.gnu.org/licenses/>.                   *
*****************************************************************************************************************************

========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

Author information
  Author name: Gabrielius Gintalas
  Author email: gabrieliusgintalas@csu.fullerton.edu
  Author CWID: 885861872
  Author NASM: NASM version 2.15.05 
  Author Class: 240-03

Program information
  Program name: How to use strings
  Programming languages: One module in C++ and one module in X86
  Date program began: Nov-6-2023
  Date of last update: Nov-6-2023
  Date comments upgraded: Nov-6-2023
  Due Date: Nov-11-2023 - Midnight
  Date open source license added: Nov-6-2023
  Files in this program: faraday.asm, ampere.cpp
  Status: WIP.

Purpose
 ...

This file
  File name: faraday.asm
  File purpose: 
  Language: X86 with Intel syntax.
  Max page width: 132 columns
  Assemble: nasm -f elf64 -l faraday.lis -o faraday.o faraday.asm
*/

#include <stdio.h>

extern double faraday();

int main(){
    printf("Welcome to Majestic Power Systems, LLC \n");
    printf("Project Director, Gabrielius Gintalas, Senior Software Engineer. \n");
    double joules = faraday();
    printf("The main function received %f and will keep it for future study. \n", joules);
    printf("A zero will be returned to the operating system. Bye");
    return 0;   
}