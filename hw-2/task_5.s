	.globl 	sof
	.type 	sof, @function
sof:
	pushl	%ebp
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl	%edi
	pushl	%esi
	movl	%esp,	%ebp
	
	movl 28(%ebp), 	%edi
	movl 32(%ebp), 	%esi
	finit
	fldl	(%esi)
	movl	$1,	%ebx
.cycle:
	fldl	(%esi,%ebx,8)	
	faddp
	 inc	%ebx
	 cmpl	%edi,	%ebx
	 jl	.cycle
	
#	fstpl 	28(%ebp)
#	movl	$1,	%eax

	movl	%ebp,	%esp
	popl	%esi
	popl	%edi
	popl	%edx
	popl	%ecx
	popl	%ebx
	popl	%ebp
	ret

	.globl 	soi
	.type 	soi, @function
soi:
	pushl	%ebp
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl	%edi
	pushl	%esi
	movl	%esp,	%ebp
	
	movl 28(%ebp), 	%edi
	movl 32(%ebp), 	%esi
	movl	$0,	%ebx
	xor	%eax,	%eax
.circle:
	addl	(%esi,%ebx,4),	%eax	
	inc	%ebx
	cmpl	%edi,	%ebx
	jl	.circle
	
	movl	%ebp,	%esp
	popl	%esi
	popl	%edi
	popl	%edx
	popl	%ecx
	popl	%ebx
	popl	%ebp
	ret



