rm -f *.o
rm -f *.out

echo "Assemble the assembly modules"
nasm -f elf64 -l exec.lis -o exec.o exec.asm
nasm -f elf64 -l display_array.lis -o display_array.o display_array.asm
nasm -f elf64 -l fill_random_array.lis -o fill_random_array.o fill_random_array.asm
nasm -f elf64 -l normalize_array.lis -o normalize_array.o normalize_array.asm


# Compile the C file without -fPIE
gcc -c driver.c -o driver.o

echo "Link the object files with debugging information"
g++ -m64 -g -o nondeterministic.out exec.o display_array.o driver.o normalize_array.o fill_random_array.o -fno-pie -no-pie -std=c++17 -lc

echo "Run the program - Non-Deterministic Random Numbers"
./nondeterministic.out

rm -f *.o
rm -f *.lis

echo "The bash script file is now closing."