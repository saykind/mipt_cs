	.data
fmt_in:	.string "%d %d"
fmt_out:.string "%d\n"
fmt_int:.string "%d"
fmt_li:	.string "%ld\n"
	.bss
a:	.space 4
b:	.space 4
li:	.space 8 # There is a way to use pointers to
		 # memory (~ global variables)

	.text
	.globl 	main
	.type	main,	@function
main:
	pushl	%ebp
	movl	%esp,	%ebp
	
	pushl	$b
	pushl	$a
	pushl	$fmt_in
	call scanf
	addl	$12,	%esp
	
	pushl	b
	pushl	a
	call mymul
	addl	$8,	%esp

	pushl  4(%eax)
	pushl	(%eax)
	pushl	$fmt_out
	call printf
	addl	$12,	%esp	

	movl	$0,	%eax	
	movl	%ebp,	%esp
	popl	%ebp
	ret


	.globl 	mymul
	.type	mymul,	@function
mymul:
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl	%ebp
	movl	%esp,	%ebp

	movl 20(%ebp),	%eax
	imull 24(%ebp)

	movl	%eax,	-8(%ebp)  # There is way to point to stack
	movl	%edx,	-4(%ebp)	
	movl	%ebp,	%eax
	subl	$8,	%eax
#	movl  	%edx,	4(%eax)	

	movl	%ebp,	%esp
	popl	%ebp
	popl	%edx
	popl	%ecx
	popl	%ebx	
	ret
