	.data
fmt:	.string "%x\n"

	.text
	.global main
main:
	pushl	%ebp
	movl	%esp,	%ebp
	
	pushl	$0	
	pushl	%esp
	pushl	$fmt
	call printf
	movl	%ebp,	%esp

	movl	$0,	(%esp)
	pushl	%esp
	pushl	$fmt
	call printf
	movl	%ebp,	%esp
		
	xor	%eax,	%eax
	leave
	ret
