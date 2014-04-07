		.data
fmt_d:	.string "%d"	
fmt_c:	.string "%c"
fmt_x:	.string "%x"
fmt_s:	.string "%s"
fmt_dn:	.string "%d\n"
fmt_xn: .string "%x\n"
fmt_sn:	.string "%s\n"
int:	.space	4	

		.bss
str_in:	.space 1024
str_out:.space 1024

		.text
	.globl main
	.type main, @function	
main:
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl 	%ebp
	movl	%esp,	%ebp
	
	pushl	$str_in
	pushl	$fmt_s
	call scanf
	addl	$8,	%esp
	pushl	$str_out
	pushl	$fmt_s
	call scanf
	addl	$8,	%esp

	pushl	$str_out
	pushl	$str_in
	call strcpy
	addl	$8,	%esp
	pushl	%eax	

#	pushl	$str_out
#	pushl	$fmt_sn
#	call printf
#	addl	$8,	%esp
	pushl	$fmt_dn
	call printf
	addl	$8,	%esp
	

	movl	$0,	%eax
	movl	%ebp,	%esp
	popl	%ebp
	popl	%edx
	popl	%ecx
	popl	%ebx
	ret



	.type strcmp, @function
strcmp:
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl 	%ebp
	movl	%esp,	%ebp

	movl  20(%ebp),	%esi
	movl  24(%ebp),	%edi
	

	movl	$0xffffffff,	%ecx
	xorl	%eax, 	%eax
	repne	scasb
	notl	%ecx
	decl	%ecx
	movl	%ecx,	%ebx

	repne cmpsb
#	cmpl	%ecx,	$0

	movl	%ecx,	%eax
	movl	%ebp,	%esp
	popl	%ebp
	popl	%edx
	popl	%ecx
	popl	%ebx
	ret

