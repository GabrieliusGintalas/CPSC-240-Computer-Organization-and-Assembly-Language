#!/bin/bash

#Author: Gabrielius Gintalas
#Date: 11/06/23
#Program name: Assignment 04 - How to use strings
#Email: gabrieliusgintalas@csu.fullerton.edu
#CWID: 885861872

rm -f *.o
rm -f *.out

echo "Assemble the assembly modules"
nasm -f elf64 -l faraday.lis -o faraday.o faraday.asm
nasm -f elf64 -l isvalid.lis -o isvalid.o isvalid.asm

# Compile the C file without -fPIE
gcc -c ampere.c -o ampere.o

echo "Link the object files with debugging information"
g++ -m64 -g -o usestrings.out faraday.o isvalid.o ampere.o -fno-pie -no-pie -std=c++17 -lc

echo "Run the program - Sort By Pointers"
./usestrings.out

rm -f *.o
rm -f *.lis

echo "The bash script file is now closing."