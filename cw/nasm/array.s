extern scanf
extern printf

SECTION .data
fmt_d:	db "%d", 0
fmt_ds:	db "%d ",0

SECTION .bss
array:	resd	10
N:	resd	1

SECTION .text
global main
main:
	push	ebp
	mov	ebp,	esp

	push	N
	push	fmt_d
	call scanf
	add	esp,	8


	mov	ecx,	0	
.loops:
	mov	ebx,	ecx
	lea	eax,	[array+ecx*4]
	push	eax
	push	fmt_d
	call scanf
	add	esp,	8
	mov	ecx,	ebx
	 inc	ecx
	 cmp	ecx,	[N]
	 jl .loops


	
	

;	mov	edi,	0
;	mov	esi,	[N]
;	dec	esi
;.change:
;	mov	eax,	[array+edi*4]
;	mov	ebx,	[array+esi*4]
;	mov	[array+esi*4],  eax
;	mov	[array+edi*4], 	ebx	
;	 inc	edi
;	 dec	esi
;	 cmp	edi,	esi
;	 jl .change


	mov	ecx,	0
.loopp:
	push	ecx
	push DWORD	[array+ecx*4]
	push	fmt_ds
	call printf
	add	esp,	8
	pop	ecx
	 inc	ecx
	 cmp	ecx,	[N]
	 jl .loopp
	

	mov	esp,	ebp
	pop	ebp
	ret


global bubble
bubble:
	push	ebx
	push	ecx
	push	edx
	push	edi
	push 	esi
	push	ebp
	mov	ebp,	esp

	xor	edi,	edi
.ext:
	mov	eax,	[array+edi*4]
	lea	ebx,	[array+edi*4]
	xor	esi,	esi
	.int:
		mov	ecx,	[ebx+esi*4]
		cmp	eax,	ecx
		jg .move
	   .next:
		inc	esi
		jmp	.int
	   .move:
		
	

	mov	eax,	0
	mov	esp,	ebp
	pop	ebp
	pop	esi
	pop	edi
	pop	edx
	pop	ecx
	pop	ebx
	ret
