	.data
fmt_s:	.string "%d %d"
fmt_p:	.string "%d\n"	

	.text
	
	.globl main

main:	#come
prolog:	pushq	%rbp
	movq	%rsp,	%rbp

	#scan
	leaq  -16(%rbp), %rcx	# 4th argument
	leaq -20(%rbp), %rdx	# 3d  argument
	leaq -24(%rbp),	%rsi	# 2nd argument
	movl	$fmt_s,	%edi	# 1st argument
	call scanf
#########general############
	movq	$3,	%rcx	# 3 elements
	leaq -24(%rbp),	%rax
label:
	addq	-4(%rax,%rcx,4),	%rbx
#	addq	%rdx,	%rbx	
	loop label	
#########general############
	#print
	movq 	%rbx,	%rsi
	movl	$fmt_p,	%edi
	call printf
	#leave
epilog:	movq	%rbp,	%rsp
	popq	%rbp
	ret
