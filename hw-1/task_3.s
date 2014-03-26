		.data
fmt_d:.string "%d"	
fmt_c:.string "%c"
fmt_x:.string "%x\n"
int:	.space	4	

		.bss
a:	.space 10
b:	.space 1024

		.text
	.globl main
	
main:
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl 	%ebp
	movl	%esp,	%ebp
	
	xor	%edi,	%edi
	xor	%esi,	%esi
	movl	$0,	int

	movl	$32,	%edi	# Max number (< 33)
start:
	cmpl	$0,	%edi	# if (edi <= 0)
	jng	out		# {jump out:}
	
	pushl	$int		
	pushl	$fmt_c
	call scanf		# scanf("%c", &int)
	addl	$8,	%esp

	subl	$48,	int

	cmpl	$0,	int	# if (edi <= 0)
	jl	out		# {jump out;}

	shll	$1,	%esi
	addl	int,	%esi

	decl	%edi		# edi--
	jmp	start
out:

	pushl	%esi
	pushl	$fmt_x
	call	printf
	addl	$8,	%esp

	movl	$0,	%eax
	movl	%ebp,	%esp
	popl	%ebp
	popl	%edx
	popl	%ecx
	popl	%ebx
	ret
