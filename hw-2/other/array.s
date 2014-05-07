	.file	"array.c"
	.text
.globl sumOfArray
	.type	sumOfArray, @function
sumOfArray:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	fldz
	fstpl	-8(%ebp)
	movl	$0, -12(%ebp)
	jmp	.L2
.L3:
	movl	-12(%ebp), %eax
	sall	$3, %eax
	addl	8(%ebp), %eax
	fldl	(%eax)
	fldl	-8(%ebp)
	faddp	%st, %st(1)
	fstpl	-8(%ebp)
	addl	$1, -12(%ebp)
.L2:
	movl	-12(%ebp), %eax
	cmpl	12(%ebp), %eax
	jl	.L3
	fldl	-8(%ebp)
	leave
	ret
	.size	sumOfArray, .-sumOfArray
	.section	.rodata
.LC8:
	.string	"= %f\n"
	.text
.globl main
	.type	main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp
	andl	$-16, %esp
	subl	$96, %esp
	fldl	.LC2
	fstpl	40(%esp)
	fldl	.LC3
	fstpl	48(%esp)
	fldl	.LC4
	fstpl	56(%esp)
	fldl	.LC5
	fstpl	64(%esp)
	fldl	.LC6
	fstpl	72(%esp)
	fldl	.LC7
	fstpl	80(%esp)
	movl	$6, 92(%esp)
	movl	92(%esp), %eax
	movl	%eax, 4(%esp)
	leal	40(%esp), %eax
	movl	%eax, (%esp)
	call	sumOfArray
	fldl	80(%esp)
	fxch	%st(1)
	movl	$.LC8, %eax
	fstpl	12(%esp)
	fstpl	4(%esp)
	movl	%eax, (%esp)
	call	printf
	movl	$0, %eax
	leave
	ret
	.size	main, .-main
	.section	.rodata
	.align 8
.LC2:
	.long	2576980378
	.long	1072798105
	.align 8
.LC3:
	.long	0
	.long	1073741824
	.align 8
.LC4:
	.long	0
	.long	1074266112
	.align 8
.LC5:
	.long	0
	.long	1074790400
	.align 8
.LC6:
	.long	0
	.long	1075052544
	.align 8
.LC7:
	.long	0
	.long	1075314688
	.ident	"GCC: (GNU) 4.4.7 20120313 (Red Hat 4.4.7-3)"
	.section	.note.GNU-stack,"",@progbits
