		.data
fmt_d:	.string "%d"
fmt_dn:	.string "%d\n"

		.text
	.globl main
	.type	main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp
	
	addl	$-4,	%esp
	pushl	%esp
	pushl	$fmt_d
	call scanf
	movl  8(%esp),	%eax	
	addl	$0xc,	%esp

	movl	%eax, %edx		# tricky
	shrl	$31, %edx	 	# algorithm
	leal	(%edx,%eax), %eax	# dividing
	sarl	%eax	 		# by 2
	
	pushl	%eax
	pushl	$fmt_dn
	call printf
	addl	$8,	%esp

	movl	$0, %eax
	leave
	ret
