# 2^32 = 4294967296
	.data
fmt_u:	.string	"%u"
fmt_d:	.string "%d"
fmt_c:	.string "%c"
fmt_s:	.string "%s"
fmt_dn:	.string "%d\n"
fmt_lun:.string "%lu\n"
fmt_ou:	.string "4294967296 + %u\n"	

	.bss
a:	.space 4
b:	.space 4

	.text
	.global main
	.type main, @function
main:
	pushl	%ebp
	movl	%esp,	%ebp

	pushl	$a
	pushl	$fmt_u
	call scanf
	addl	$8,	%esp
	pushl	$b
	pushl	$fmt_u
	call scanf
	addl	$8,	%esp

	movl	a,	%eax
	movl	b,	%ebx
	addl	%ebx,	%eax
	jnc	.under

	pushl	%eax
	pushl	$fmt_ou
	call printf
	addl	$12,	%esp

	jmp	.end	
.under:	
	pushl	%eax
	pushl	$fmt_lun
	call printf
	addl	$12,	%esp
	jmp	.end
.end:
	movl	%ebp,	%esp
	popl	%ebp
	ret
