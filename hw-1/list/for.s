	.globl	array
	.data
array:
	.long	1
	.long	2
	.long	5
	.long	-1
	.long	10
	.long	0
.LC0:
	.string	"%d\n"

	.text
	.globl	main
	.type	main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp
	
	andl	$-16, %esp
	subl	$48, %esp
	
	movl	$2, 40(%esp)	# M
	movl	$3, 44(%esp)	# N
	movl	array, %eax
	movl	%eax, 28(%esp)
	movl	$0, 32(%esp)	# (i = 0; ; )
	jmp	.L2
.L6:
	movl	$0, 36(%esp)	# (j = 0; ; )
	jmp	.L3
.L5:
	movl	32(%esp), %edx
	movl	%edx, %eax	# eax = 3*i
	addl	%eax, %eax	#
	addl	%edx, %eax	#
	movl	36(%esp), %edx	# eax += j
	addl	%edx, %eax	#
	movl	array(,%eax,4), %eax
	cmpl	28(%esp), %eax	# max <> a[i][j]
	jle	.L4
	movl	32(%esp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	movl	36(%esp), %edx
	addl	%edx, %eax
	movl	array(,%eax,4), %eax
	movl	%eax, 28(%esp)
.L4:
	addl	$1, 36(%esp)	# ( ; ; j++)
.L3:
	movl	36(%esp), %eax
	cmpl	44(%esp), %eax 	# ( ; j < N; )
	jl	.L5
	addl	$1, 32(%esp)	# ( ; ; i++)	
.L2:
	movl	32(%esp), %eax
	cmpl	40(%esp), %eax	# ( ; i < M; )
	jl	.L6

	movl	28(%esp), %eax	# eax = max
	movl	%eax, 4(%esp)
	movl	$.LC0, (%esp)
	call	printf
	movl	$0, %eax
	leave
	ret
