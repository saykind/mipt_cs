# White-space means end of line
	.data
fmt_d:	.string "%d"
fmt_c:	.string "%c"
fmt_s:	.string "%s"
fmt_dn:	.string "%d\n"
	
	.bss
str:	.space 100
c:	.byte 0

	.text
	.global main
	.type main, @function
main:
	pushl	%ebp
	movl	%esp,	%ebp

	pushl	$str
	pushl	$fmt_s
	call scanf
	addl	$8,	%esp

	xorl	%ebx,	%ebx	
	xorl	%ecx,	%ecx
	xorl	%edi,	%edi
	movl	$str,	%esi
.start:
	movl	(%esi),	%ebx
	cmpb	$0,	%bl
	je	.quit
	
	incl	%esi
	incl	%edi
	jmp	.start
.quit:
	pushl	%edi
	pushl	$fmt_dn
	call printf
	addl	$8,	%esp
	
	

	movl	%ebp,	%esp
	popl	%ebp
	ret
