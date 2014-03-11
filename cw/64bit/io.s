	.file	"io.c"
	.section	.rodata
.LC0:
	.string	"%d %d %d"
.LC1:
	.string	"%d %d %d\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp

	leaq	-4(%rbp), %rcx
	leaq	-8(%rbp), %rdx
	leaq	-12(%rbp), %rsi
	movl	$.LC0, %edi
	call	scanf

	movl	-4(%rbp), %ecx
	movl	-8(%rbp), %edx
	movl	-12(%rbp), %esi
	movl	$.LC1, %edi
	call	printf
	
	leave
	ret
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu/Linaro 4.7.3-1ubuntu1) 4.7.3"
	.section	.note.GNU-stack,"",@progbits
