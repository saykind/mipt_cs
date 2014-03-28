	.file	"switch.c"
	.section	.rodata
.LC0:
	.string	"%c"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	pushl	%ebp
	movl	%esp, %ebp

	andl	$-16, %esp
	subl	$32, %esp
	leal	31(%esp), %eax
	movl	%eax, 4(%esp)
	movl	$.LC0, (%esp)
	call	__isoc99_scanf

	movzbl	31(%esp), %eax
	movsbl	%al, %eax
	cmpl	$43, %eax
	je	.L3
	cmpl	$45, %eax
	je	.L4
	jmp	.L7
.L3:
	movl	$43, (%esp)
	call	putchar
	jmp	.L5
.L4:
	movl	$45, (%esp)
	call	putchar
	jmp	.L5
.L7:
	nop
.L5:
	movl	$0, %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu/Linaro 4.7.3-1ubuntu1) 4.7.3"
	.section	.note.GNU-stack,"",@progbits
