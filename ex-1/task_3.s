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

	xorl	%eax,	%eax
	xorl	%ebx,	%ebx	
	xorl	%ecx,	%ecx
	xorl	%edi,	%edi
	movl	$str,	%esi
.start:
	movl	(%esi),	%ebx
	cmpb	$0,	%bl
	je	.quit
	
	movl	$8,	%ecx
 .loop:	
	rclb	$1,	%bl
	rcrb	$1,	%al	
	loop	.loop
	
	movb	%al,	(%esi)

	incl	%esi
	jmp	.start
.quit:
	pushl	$str	
	pushl	$fmt_s
	call printf
	addl	$8,	%esp
	
	movl	$0,	%eax
	movl	%ebp,	%esp
	popl	%ebp
	ret
