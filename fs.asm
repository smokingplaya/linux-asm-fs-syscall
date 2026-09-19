extern _exit_with_err

global _openfile, _readfile

section .bss
	; buffer with size = 1024 bytes
	ReadFileBuffer resb 1024
	ReadFileBufferLen equ $ - ReadFileBuffer

section .text

; `rdi` - *char
_openfile:
	mov rax, 2
	xor rsi, rsi
	xor rdx, rdx
	syscall
	ret

; arguments: `rax` file descriptor
; `raw` - result buffer
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

	lea rsi, [rel ReadFileBuffer]
	mov rdx, ReadFileBufferLen
	ret

;_get_file_size:
