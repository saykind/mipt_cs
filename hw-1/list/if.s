	.file	"if.c"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	movl	$1, -16(%ebp)
	movl	$2, -12(%ebp)
	movl	$3, -8(%ebp)
	
	movl	-16(%ebp), %eax
	cmpl	-12(%ebp), %eax
	jle	.L2
	movl	-16(%ebp), %eax
	cmpl	-8(%ebp), %eax
	jle	.L3
	movl	-16(%ebp), %eax
	movl	%eax, -4(%ebp)
	jmp	.L4
.L3:
	movl	-8(%ebp), %eax
	movl	%eax, -4(%ebp)
	jmp	.L4
.L2:
	movl	-12(%ebp), %eax
	cmpl	-8(%ebp), %eax
	jle	.L5
	movl	-12(%ebp), %eax
	movl	%eax, -4(%ebp)
	jmp	.L4
.L5:
	movl	-8(%ebp), %eax
	movl	%eax, -4(%ebp)
.L4:
	movl	$0, %eax
	leave
	ret
