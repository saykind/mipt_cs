		.data
a:
	.single	1.01
b:
	.single 1.02
fmt:
	.string	"%f\n"

		.globl main
		.text
main :
	pushl	%ebp
	movl	%esp,	%ebp

	finit
	flds	a
	flds	b
	faddp	

	subl	$8,	%esp	
	fstpl	(%esp)
	pushl	$fmt
	call printf
	addl	$12,	%esp
	
	movl	%ebp,	%esp
	popl	%ebp
	movl	$0,	%eax
	ret
	
