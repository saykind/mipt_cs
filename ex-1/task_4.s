	.data
fmt_f:	.string "%lf\n"
fmt_fd:	.string "%lf %d"
fmt_d:	.string "%d"
fmt_c:	.string "%c"
fmt_s:	.string "%s"
fmt_dn:	.string "%d\n"
	
	.bss
x:	.double	0.1
N:	.long	0

	.text
	.global main
	.type main, @function
main:
	pushl	%ebp
	movl	%esp,	%ebp
	
	pushl	$N
	pushl	$x
	pushl	$fmt_fd
	call scanf
	addl	$8,	%esp

	finit
	subl	$8,	%esp
	fstl	(%esp)
	pushl	x
	pushl	N
	call my_exp
	addl	$8,	%esp

	fldl	x
	subl	$8,	%esp
	fstl	(%esp)
	pushl	$fmt_f
	call printf
	addl	$8,	%esp

	movl	$0,	%eax
	movl	%ebp,	%esp
	popl	%ebp
	ret

my_exp:
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl	%edi
	pushl	%esi
	pushl	%ebp
	movl	%esp,	%ebp

	movl	28(%ebp),	%ecx
	fstl	32(%ebp)

.loop:
	loop .loop	


	movl	%ebp,	%esp
	popl	%ebp
	popl	%esi
	popl	%edi
	popl	%edx
	popl	%ecx
	popl	%ebx
	ret
