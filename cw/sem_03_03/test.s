	.data
	#Section of data
int:	.space	8
fb2:	.space	4
sfmt_int:	.string "%d"
pfmt_int:	.string "%d\n"
pfmt_hex:	.string "%xd\t(hex)\n"

	.text	#Section of code
	.global	main

main:
prolog:	pushq	%rbp
	movq	%rsp,	%rbp
	
	movq	$int,	%rsi
	movl	$sfmt_int,	%edi
	call scanf
	addq	$16,	%rsp
	movq	int,	%rax	

#	movl	$1,	%ecx
#loop:	
#	cmpl	$0,	%ecx
#	jng	end
#	decl	%ecx
	
#	addl	%ecx(%eax),	%ebx

#	jmp loop

#end:
	movq	%rax,	%rsi
	movl	$pfmt_int,	%edi
	call printf
	addq	$16,	%rsp
	
epilog:	movq	%rbp,	%rsp
	popq	%rbp
	ret
