build: main.asm fs.asm stdout.asm
	nasm -f elf64 fs.asm -o fs.o
	nasm -f elf64 stdout.asm -o stdout.o
	nasm -f elf64 main.asm -o main.o
	ld main.o stdout.o fs.o -o main
