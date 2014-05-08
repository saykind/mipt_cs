# It compares two strings (divided by space) and prints
#	0  - if the're completaly equal
#	%d - number of first different symbol
# Also it copies them first
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
	
	pushl	$str_in
	pushl	$fmt_s
	call scanf
	addl	$8,	%esp
	 pushl	$str_in
	 pushl	$str_a
	 call strcop
	 addl	$8,	%esp
	pushl	$str_in
	pushl	$fmt_s
	call scanf
	addl	$8,	%esp
	 pushl	$str_in
	 pushl	$str_b
	 call strcop
	 addl	$8,	%esp

	pushl	$str_a
	pushl	$str_b
	call strise
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

	.type strise, @function
strise:
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl 	%ebp
	movl	%esp,	%ebp

	subl	$0x8,	%esp		# -4(%ebp) for length_1
					# -8(%ebp) for length_2
	cld
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

	movl	-4(%ebp),	%ebx	
	movl	-8(%ebp),	%ecx	
	cmpl	%ebx,	%ecx	
	jge	.skip
	movl	%ebx,	%ecx
	.skip:				# ecx = max(length_1,length_2)
	movl	%ecx,	%ebx	

	inc	%ecx
	movl  20(%ebp),	%esi
	movl  24(%ebp),	%edi
	cld
	repe cmpsb
	cmp	$0,	%ecx
	je	.next
	notl	%ecx
	inc	%ecx
	add	%ebx,	%ecx
	inc	%ecx
	.next:

	movl	%ecx,	%eax
	movl	%ebp,	%esp
	popl	%ebp
	popl	%edx
	popl	%ecx
	popl	%ebx
	ret


	.type strsim, @function
strsim:
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl 	%ebp
	movl	%esp,	%ebp

	subl	$0x8,	%esp		# -4(%ebp) for length_1
					# -8(%ebp) for length_2
	cld
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


	inc	%ecx
	movl  20(%ebp),	%esi
	movl  24(%ebp),	%edi
	cld
	repe cmpsb

	movl	%ecx,	%eax
	movl	%ebp,	%esp
	popl	%ebp
	popl	%edx
	popl	%ecx
	popl	%ebx
	ret



	.type strcop, @function
strcop:
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl 	%ebp
	movl	%esp,	%ebp

	movl  24(%ebp),	%esi
	movl  20(%ebp),	%edi
	xorl	%ecx,	%ecx
	
  .loop:
	lodsb	
	cmpb	$0,	%al
	je	.out
	stosb
	incl	%ecx
	jmp	.loop
  .out:
	movl	%ecx,	%eax
	movl	%ebp,	%esp
	popl	%ebp
	popl	%edx
	popl	%ecx
	popl	%ebx
	ret


