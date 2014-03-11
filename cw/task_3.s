	.data
	
	.text
	.globl myadd
	.globl mysub
	.globl mymul
	.globl mydiv
	.globl mymod
	.globl myinc
	.globl mydec


myadd:
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl	%ebp
	movl	%esp,	%ebp

	movl	20(%ebp),	%eax
	addl	24(%ebp),	%eax

	movl	%ebp,	%esp
	popl	%ebp
	popl	%edx
	popl	%ecx
	popl	%ebx	
	ret

mysub:
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl	%ebp
	movl	%esp,	%ebp

	movl	20(%ebp),	%eax
	subl	24(%ebp),	%eax

	movl	%ebp,	%esp
	popl	%ebp
	popl	%edx
	popl	%ecx
	popl	%ebx	
	ret

mymul:
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl	%ebp
	movl	%esp,	%ebp

	movl	20(%ebp),	%eax
	imull	24(%ebp)

	movl	%ebp,	%esp
	popl	%ebp
	popl	%edx
	popl	%ecx
	popl	%ebx	
	ret

mydiv:
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl	%ebp
	movl	%esp,	%ebp

	movl	%eax,	%edx
	sarl	$31,	%edx
	movl	20(%ebp),	%eax
	idivl	24(%ebp)

	movl	%ebp,	%esp
	popl	%ebp
	popl	%edx
	popl	%ecx
	popl	%ebx	
	ret

mymod:
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl	%ebp
	movl	%esp,	%ebp

	movl	%eax,	%edx
	sarl	$31,	%edx
	movl	20(%ebp),	%eax
	divl	24(%ebp)
	movl	%edx,	%eax

	movl	%ebp,	%esp
	popl	%ebp
	popl	%edx
	popl	%ecx
	popl	%ebx	
	ret

myinc:
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl	%ebp
	movl	%esp,	%ebp

	movl	20(%ebp),	%eax
	incl	%eax

	movl	%ebp,	%esp
	popl	%ebp
	popl	%edx
	popl	%ecx
	popl	%ebx	
	ret

mydec:
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl	%ebp
	movl	%esp,	%ebp

	movl	20(%ebp),	%eax
	decl	%eax

	movl	%ebp,	%esp
	popl	%ebp
	popl	%edx
	popl	%ecx
	popl	%ebx	
	ret



