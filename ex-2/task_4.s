		.data
fmt_d:	.string "%d"	
fmt_s:	.string "%s"
fmt_dn:	.string "%d\n"
int:	.space	4
var:	.space 	4	

		.bss
str_in:	.space 1024
str_out:.space 1024
buff:	.space 1024
str_a:	.space 1024
str_b:	.space 1024

		.text
	.globl main
	.type main, @function	
main:
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl 	%ebp
	movl	%esp,	%ebp
	
	pushl	$str_a
	pushl	$fmt_s
	call scanf
	addl	$8,	%esp
	pushl	$str_b
	pushl	$fmt_s
	call scanf
	addl	$8,	%esp
	
	pushl	$var
	pushl	$fmt_d
	call scanf
	addl	$8,	%esp
	decl	var

	pushl	var
	pushl	$str_b
	pushl	$str_a
	call strpst
	addl	$0xc,	%esp
	pushl	%eax	
	pushl	$fmt_s
	call printf
	addl	$8,	%esp

	movl	$0,	%eax
	movl	%ebp,	%esp
	popl	%ebp
	popl	%edx
	popl	%ecx
	popl	%ebx
	ret

	.type strpst, @function
strpst:
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl 	%ebp
	movl	%esp,	%ebp


	movl 28(%ebp), 	%ecx
	movl 24(%ebp), 	%esi
	movl	$buff,	%edi
	cld
	rep movsb
	push	%edi

	cld
	movl  20(%ebp),	%edi
	xorl	%eax, 	%eax		# s
	movl	$0xffffffff,	%ecx	# t
	repne	scasb			# r
	notl	%ecx			# l
	decl	%ecx			# e

	pop	%edi
	movl  20(%ebp),	%esi	# a
	cld
	rep	movsb
	
	movl  24(%ebp),	%esi	# b
	movl  28(%ebp),	%edx	# pos
	addl	%edx,	%esi

.circle:
	lodsb	
	cmpb	$0,	%al
	je .quit
	 stosb
	 jmp .circle
.quit:

	movb	$0,	%al
	stosb

	movl 	$buff,	%eax
	movl	%ebp,	%esp
	popl	%ebp
	popl	%edx
	popl	%ecx
	popl	%ebx
	ret

