extern _print, _openfile, _readfile, _exit, _exit_with_err
global _exit_with_err

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
	jle _exit_with_err

	; skipping 1 argument (it is path to current executable)
	mov rdi, [rsp + 16]

	; reading file into some buffer
	; then printing it out
	call _openfile
	; descriptor in `rax`
	call _readfile
	; returns rax, rdx
	call _print

	; exiting
	call _exit

_exit:
	mov rax, 60
	mov rdi, 1
	syscall

_exit_with_err:
	lea rsi, [rel StrErrOpening]
	mov rdx, StrErrOpeningLen
	call _print
	call _exit