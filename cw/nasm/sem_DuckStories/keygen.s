global main

extern	scanf
extern	printf

	section .data
fmt:	db "%d", 0x0

	section	.bss
a	resd	1
b	resd	1

	section	.text
main:
	push	ebp
	mov	ebp,	esp
	
	push	a
	push	fmt
	call scanf
	add	esp,	8
	
	mov	eax,	[a]
	sub	eax,	100500
	
	push	eax
	push	fmt
	call	printf
	add	esp,	8
	
	leave
	mov	eax,	0
	ret	
