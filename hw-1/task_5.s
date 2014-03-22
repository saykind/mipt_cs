	.data
int:
	.space	4
fmt_float:
	.string "%f"
fmt_int:
	.string	"%d"
fmt_intn:
	.string "%d\n"
fmt_endl:
	.string "\n"
	
	.text
	.globl	main
	.globl	show
main:
	pushl	%ebp		#prolog
	movl	%esp, 	%ebp	#prolog

	pushl	$int		
	pushl	$fmt_float	#"%f"
	call	scanf
	addl	$8, 	%esp
	
	pushl	int
	pushl	$32
	call	show
	addl	$8,	%esp

	pushl	$fmt_endl	#printf("\n");
	call printf
	addl	$4,	%esp
	
	movl	%ebp,	%esp	#epilog
	popl	%ebp		#epilog
	movl	$0,	%eax
	ret 

show:
	pushl	%ebx
	pushl	%ecx
	pushl	%edx	
	pushl	%ebp		#prolog
	movl	%esp, 	%ebp	#prolog
	
	movl 20(%ebp),	%ecx
	movl 24(%ebp),	%ebx

	movl 20(%ebp),	%ecx
loop_roll:
	movl	$1,	%edx
	rorl	$1,	%ebx
	jc	one
	movl	$0,	%edx
     	one:	
	pushl	%edx
	loop loop_roll	

	movl 20(%ebp),	%ecx
loop_print:
	movl	%ecx,	%ebx
	pushl $fmt_int
	call printf
	addl	$8,	%esp	
	movl	%ebx,	%ecx
	loop loop_print

	movl	%ebp,	%esp	#epilog
	popl	%ebp		#epilog
	popl	%edx
	popl	%ecx
	popl	%ebx
	ret 
	
