nasm -f elf32 calculator.asm
ld -m elf_i386 -s -o calculator calculator.o