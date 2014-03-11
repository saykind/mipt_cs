	.file	"c.c"
	.section	.rodata
.LC0:
	.string	"%d"
.LC1:
	.string	"%d\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	pushq	%rbp
	movq	%rsp, %rbp
	
	subq	$16, %rsp
	leaq	-4(%rbp), %rax
	movq	%rax, %rsi
	movl	$.LC0, %edi
#	movl	$0, %eax
	call	scanf
	movl	-4(%rbp), %eax	#

	movl	%eax, %esi
	movl	$.LC1, %edi
#	movl	$0, %eax
	call	printf
	movl	$0, %eax

	leave
	ret
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu/Linaro 4.7.3-1ubuntu1) 4.7.3"
	.section	.note.GNU-stack,"",@progbits
