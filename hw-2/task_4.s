# White-space means end of line
	.data
fmt_d:	.string "%d"
fmt_c:	.string "%c"
fmt_s:	.string "%s"
fmt_dn:	.string "%d\n"
fmt_xn:	.string "%x\n"
	
	.bss
str:	.space 100
c:	.byte 0

	.text
	.global main
	.type main, @function
main:
	pushl	%ebp
	movl	%esp,	%ebp
	
	pushl	%ebp
	pushl	$fmt_xn
	call printf
	addl	$8,	%esp
	movl	%ebp,	%esp
	
	pushl	%esp
	pushl	$fmt_xn
	call printf
#	addl	$8,	%esp
#	movl	%ebp,	%esp
	
	movl	4(%esp),	%eax
	
	pushl 	%eax
	pushl 	$fmt_xn
	call printf	


	movl	$0,	%eax
	movl	%ebp,	%esp
	popl	%ebp
	ret
