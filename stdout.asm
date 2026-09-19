global _print

; кидает в регистр SomeText и вызывает сисько(л)
_print:
  mov rax, 1;
	mov rdi, 1 ; file descriptor stdout
	syscall
	ret
