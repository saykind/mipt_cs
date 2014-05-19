		.data
fmt_d:	.string "%d"	
fmt_s:	.string "%s"
fmt_dn:	.string "%d\n"
int:	.space	4
var:	.space 4
var_:	.space 4	

		.bss
str_in:	.space 1024
str_out:.space 1024
buff:	.space 1024
str_a:	.space 1024
str_b:	.space 1024

		.text
	.globl main
	.type main, @function	
main:
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl 	%ebp
	movl	%esp,	%ebp
	
	pushl	$str_a
	pushl	$fmt_s
	call scanf
	addl	$8,	%esp
	
	pushl	$var
	pushl	$fmt_d
	call scanf
	addl	$8,	%esp
	decl	var

	pushl	$var_
	pushl	$fmt_d
	call scanf
	addl	$8,	%esp
	decl	var


	pushl	var_
	pushl	var
	pushl	$str_a
	call strpst
	addl	$0xc,	%esp
	pushl	%eax	
	pushl	$fmt_s
	call printf
	addl	$8,	%esp

	movl	$0,	%eax
	movl	%ebp,	%esp
	popl	%ebp
	popl	%edx
	popl	%ecx
	popl	%ebx
	ret

	.type strpst, @function
strpst:
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl 	%ebp
	movl	%esp,	%ebp

	movl 24(%ebp), 	%ecx
	movl 20(%ebp), 	%esi
	movl	$buff,	%edi
	cld
	rep movsb

	addl	28(%ebp), %esi
	
.circle:
	lodsb	
	cmpb	$0,	%al
	je .quit
	 stosb
	 jmp .circle
.quit:

	movb	$0,	%al
	stosb

	movl 	$buff,	%eax
	movl	%ebp,	%esp
	popl	%ebp
	popl	%edx
	popl	%ecx
	popl	%ebx
	ret

