global print

; кидает в регистр SomeText и вызывает сисько(л)
print:
  mov rax, 1;
	mov rdi, 1 ; file descriptor stdout
	syscall
	ret
