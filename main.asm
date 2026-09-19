extern print, openfile, readfile, exit, exit_with_err
global exit_with_err

section .data
	StrErrOpening db "an error occured while trying open file", 10
	StrErrOpeningLen equ $ - StrErrOpening

section .text
	global _start

_start:
	; if argc (arg count) less than or equal 1
	; then exiting program
	mov rax, [rsp]
	cmp rax, 1
	jle exit_with_err

	; skipping 1 argument (it is path to current executable)
	mov rdi, [rsp + 16]

	; reading file into some buffer
	; then printing it out
	call openfile
	; descriptor in `rax`
	call readfile
	; returns rax, rdx
	call print

	; exiting
	call exit

exit:
	mov rax, 60
	mov rdi, 1
	syscall

exit_with_err:
	lea rsi, [rel StrErrOpening]
	mov rdx, StrErrOpeningLen
	call print
	call exit