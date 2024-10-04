#!/bin/bash

# Compile the assembly files
nasm -f elf64 input_array.asm -o input_array.o
nasm -f elf64 manage.asm -o manage.o
nasm -f elf64 output_array.asm -o output_array.o
nasm -f elf64 sum_array.asm -o sum_array.o

# Compile the C file without -fPIE
gcc -c main.c -o main.o

# Link all object files together with -no-pie
gcc -no-pie main.o input_array.o output_array.o sum_array.o manage.o -o array_manager

# Run the program
./array_manager

# Clean up the object files and executable
rm *.o array_manager

