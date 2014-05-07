		.data
fmt_d:	.string "%d"
fmt_dn:	.string "%d\n"

		.text
	.globl main
	.type	main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp
	
#	addl	$-4,	%esp		# It's not essential 'cause of push
	pushl	%esp
	#movl	%esp,	%esi
	#subl	$4,	%esp
	#movl	%esp,	(%esp)
	pushl	$fmt_d
	call scanf
	movl  8(%esp),	%eax	
	addl	$8,	%esp

	movl	%eax, %edx
	shrl	$31, %edx	 
	leal	(%edx,%eax), %eax
	sarl	%eax	 
	
	pushl	%eax
	pushl	$fmt_dn
	call printf
	addl	$8,	%esp

	movl	$0, %eax
	leave
	ret
