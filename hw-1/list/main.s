	.data
str1:	.string "1: %x\n"
str2:	.string "2: %d\n"
str3:	.string "3: %d\n"
fmt_int:.string "%d"

	.file	"main.c"
	.text
	.globl	main
	.type	main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp

	movl	4(%ebp),	%eax
	pushl	%eax
	pushl	$str1
	call printf
	addl	$8,	%esp
	
	movl	8(%ebp),	%eax
	pushl	%eax
	pushl	$str2
	call printf
	addl	$8,	%esp

	movl	12(%ebp),	%eax
	pushl	%eax
	pushl	$str3
	call printf
	addl	$8,	%esp
		
	movl	$0, %eax
	leave
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
	

