extern printf

	section	.rodata
fmt:	db "%d", 0x0

	section .text
	global	main
main:
	push	ebp
	mov	ebp, esp
	
	mov	eax, DWORD [ebp+8]
	dec	eax
	push	eax
	push	fmt
	;call printf
	sub	esp,	8
	
	mov	eax, DWORD [ebp+8]
	dec	eax
	leave
	ret
