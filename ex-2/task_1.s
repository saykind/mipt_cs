		.data
fmt_d:	.string "%d"	
fmt_s:	.string "%s"
fmt_dn:	.string "%d\n"
int:	.space	4	

		.bss
str_in:	.space 1024
str_out:.space 1024
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

	pushl	$str_a
	pushl	$str_b
	call strpos
	addl	$8,	%esp
	pushl	%eax	
	pushl	$fmt_dn
	call printf
	addl	$8,	%esp

	movl	$0,	%eax
	movl	%ebp,	%esp
	popl	%ebp
	popl	%edx
	popl	%ecx
	popl	%ebx
	ret

	.type strpos, @function
strpos:
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl 	%ebp
	movl	%esp,	%ebp

	subl	$0x8,	%esp		# -4(%ebp) for length_b
					# -8(%ebp) for length_a
	cld				# a in b
	movl  20(%ebp),	%edi
	xorl	%eax, 	%eax		# s
	movl	$0xffffffff,	%ecx	# t
	repne	scasb			# r
	notl	%ecx			# l
	decl	%ecx			# e
	movl	%ecx,	-4(%ebp)	# n

	cld
	movl  24(%ebp),	%edi
	xorl	%eax, 	%eax		# s
	movl	$0xffffffff,	%ecx	# t
	repne	scasb			# r
	notl	%ecx			# l
	decl	%ecx			# e
	movl	%ecx,	-8(%ebp)	# n

	movl  -4(%ebp),	%ecx	# length_b
	movl  -8(%ebp),	%ebx	# length_a

	movl  20(%ebp),	%edi	# b
	movl  24(%ebp),	%esi	# a in b 

.again:	lodsb
#	movl  -4(%ebp),	%ecx	# length_b
	repne scasb
#	pushl	%esi
#	pushl	%edi
#	call strequ
#	test %eax,	%eax
#	jne .again
	
	movl -4(%ebp),	%eax
	subl	%ecx,	%eax
	cmpl	-4(%ebp),	%eax
	jne	.quit
	 movl	$-1,	%eax
	.quit:
	movl	%ebp,	%esp
	popl	%ebp
	popl	%edx
	popl	%ecx
	popl	%ebx
	ret

	.type strequ, @function
strequ:
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl 	%ebp
	movl	%esp,	%ebp
	
	movl  20(%ebp),	%edi	# b
	movl  24(%ebp),	%esi	# a in b 

	cld
	movl  24(%ebp),	%edi
	xorl	%eax, 	%eax		# s
	movl	$0xffffffff,	%ecx	# t
	repne	scasb			# r
	notl	%ecx			# l
	decl	%ecx			# e

	cld
	repe cmpsb	

	movl	%ecx,	%eax
	movl	%ebp,	%esp
	popl	%ebp
	popl	%edx
	popl	%ecx
	popl	%ebx
	ret

