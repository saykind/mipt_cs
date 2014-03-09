	.data
	#Section of data
int:	.space	4
fb2:	.space	4
sfmt_int:	.string "%d"
pfmt_int:	.string "%d\n"
pfmt_hex:	.string "%xd\t(hex)\n"

	.text	#Section of code
	.global	main

main:
prolog:	pushl	%ebp
	movl	%esp,	%ebp
	
	pushl	$int
	pushl	$sfmt_int
	call scanf
	addl	$8,	%esp
	movl	int,	%eax	

	movl	$0,	%ebx
loop:	
	cmpl	$0,	%eax
	jng	end
	incl	%ebx

	movl	$0,	%edx
	divl	%ebx

	cmpl	$0,	%edx
	je	loop
end:
	decl	%ebx
	pushl	%ebx
	pushl	$pfmt_int
	call printf
	addl	$8,	%esp
	
epilog:	movl	%ebp,	%esp
	popl	%ebp
	ret
