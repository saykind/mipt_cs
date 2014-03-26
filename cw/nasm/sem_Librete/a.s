section .data
str:	db "Liberté, égalité, fraternité!"
len:	equ $-str

section .text
global _start
_start:
;global	main
;main:
	mov	edx,	len
	mov	ecx,	str
	mov	ebx,	1
	mov	eax,	4
	int 0x80

	mov	ebx,	0
	mov	eax,	1
	int 0x80
	ret
