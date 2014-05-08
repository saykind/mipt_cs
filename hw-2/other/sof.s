	.file	"sof.c"
	.text
	.globl	sof
	.type	sof, @function
sof:
.LFB2:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	movl	$0, -12(%ebp)
	jmp	.L2
.L3:
	movl	-12(%ebp), %eax
	leal	0(,%eax,8), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	fldl	(%eax)
	fldl	-8(%ebp)
	faddp	%st, %st(1)
	fstpl	-8(%ebp)
	addl	$1, -12(%ebp)
.L2:
	movl	-12(%ebp), %eax
	cmpl	8(%ebp), %eax
	jl	.L3
	fldl	-8(%ebp)
	leave
	ret
.LFE2:
	.size	sof, .-sof
	.section	.rodata
.LC1:
	.string	"%d"
.LC2:
	.string	"%lf"
.LC3:
	.string	"%lf\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB3:
	pushl	%ebp
	movl	%esp, %ebp
	andl	$-16, %esp
	subl	$32, %esp
	leal	20(%esp), %eax
	movl	%eax, 4(%esp)
	movl	$.LC1, (%esp)
	call	__isoc99_scanf
	movl	20(%esp), %eax
	sall	$3, %eax
	movl	%eax, (%esp)
	call	malloc
	movl	%eax, 28(%esp)
	movl	$0, 24(%esp)
	jmp	.L6
.L7:
	movl	24(%esp), %eax
	leal	0(,%eax,8), %edx
	movl	28(%esp), %eax
	addl	%edx, %eax
	movl	%eax, 4(%esp)
	movl	$.LC2, (%esp)
	call	__isoc99_scanf
	addl	$1, 24(%esp)
.L6:
	movl	20(%esp), %eax
	cmpl	%eax, 24(%esp)
	jl	.L7
	movl	20(%esp), %eax
	movl	28(%esp), %edx
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	sof
	fstpl	4(%esp)
	movl	$.LC3, (%esp)
	call	printf
	movl	$0, %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE3:
	.size	main, .-main
	.ident	"GCC: (Ubuntu/Linaro 4.7.3-1ubuntu1) 4.7.3"
	.section	.note.GNU-stack,"",@progbits
