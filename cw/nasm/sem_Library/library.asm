global subroutine
subroutine:
	push	ebx
	push	ecx
	push	edx
	push	esi
	push	edi
	push	ebp
	mov	ebp,	esp
	
	mov	eax,	[ebp+24]
	mov	ebx,	[ebp+28]
	cmp	eax,	ebx
	jg .plus
	 sub	eax,	ebx
	 jmp	.end
	.plus:
	 add	eax,	ebx
	.end:
	
	mov	esp,	ebp
	pop	ebp
	pop	edi
	pop	esi
	pop	edx
	pop	ecx
	pop	ebx
	ret
