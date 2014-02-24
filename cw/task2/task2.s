	.data
msg_string:
	.string	"Hello %d\n"
long_value:	
	.long 321

	.text
	.globl	main
main:
	pushl	%ebp
	movl	%esp, %ebp

	pushl	long_value	
	pushl	$msg_string

	call	printf

	addl	$4, %esp

	movl	%ebp, %esp
	popl	%ebp
	ret
