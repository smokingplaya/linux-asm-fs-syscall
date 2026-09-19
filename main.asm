section .data
	; Go
	StrErrOpening db "an error occured while trying open file", 10
	StrErrOpeningLen equ $ - StrErrOpening
	StrFilePath db "/tmp/testfile", 0
	StrFilePathLen equ $ - StrFilePath

section .bss
	; buffer with size = 1024 bytes
	ReadFileBuffer resb 1024
	ReadFileBufferLen equ $ - ReadFileBuffer

section .text
	global _start

_start:
	; reading file into some buffer
	; then printing it out

	call _openfile

	; descriptor in `rax`
	call _readfile

	lea rsi, [rel ReadFileBuffer]
	mov rdx, ReadFileBufferLen

	call _print

	; exiting
	call _exit

; кидает в регистр SomeText и вызывает сисько(л)
_print:
	mov rax, 1 ; write сиськол номер
	mov rdi, 1 ; file descriptor stdout
	syscall
	ret

_openfile:
	mov rax, 2
	lea rdi, [rel StrFilePath]
	xor rsi, rsi
	xor rdx, rdx
	syscall
	ret

; arguments: `rax` file descriptor
_readfile:
	cmp rax, 0
	; if `open` syscall returns error, not a file descriptor (err = number < 0)
	; jump on exit
	jl _exit_with_err

	mov rdi, rax

	mov rax, 0
	lea rsi, [rel ReadFileBuffer]
	mov rdx, ReadFileBufferLen
	syscall
	ret

_exit:
	mov rax, 60
	mov rdi, 1
	syscall

_exit_with_err:
	lea rsi, [rel StrErrOpening]
	mov rdx, StrErrOpeningLen
	call _print
	call _exit
