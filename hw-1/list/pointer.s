	.file	"pointer.c"
	.text
	.globl	pointer
	.type	pointer, @function
pointer:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	movl	$0, -4(%ebp)
	addl	$170, -4(%ebp)
	movl	-4(%ebp), %eax
	leave
	ret
.LC0:
	.string	"%p\n"

	.text
	.globl	main
	.type	main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp
	andl	$-16, %esp
	subl	$32, %esp
	call	pointer
	movl	%eax, 28(%esp)
	movl	28(%esp), %eax
	movl	%eax, 4(%esp)
	movl	$.LC0, (%esp)
	call	printf
	movl	$0, %eax
	leave
	ret
