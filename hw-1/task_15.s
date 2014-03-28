# Max of three numbers
	.data
fmt_in:	.string "%d %d %d"
fmt_out:.string "%d\n"

	.bss
a:	.space 4
b:	.space 4
c:	.space 4

	.text
	.globl	main
	.type	main, @function
main:
	pushl	%ebp
	movl	%esp, 	%ebp
	
	pushl	$c
	pushl	$b
	pushl	$a
	pushl	$fmt_in
	call scanf
	addl	$0x10,	%esp

	movl	a,	%eax
	movl	b,	%ebx
	movl	c,	%ecx

	cmpl	%ebx, %eax
	jg	.agb
	cmpl	%ecx,	%ebx
	jg	.bgac
	movl	%ecx,	%edi
	jmp .break
.agb:	
	cmpl	%ecx,	%eax
	jg	.agbc
	movl	%ecx,	%edi
	jmp .break
.agbc:
	movl	%eax,	%edi
	jmp .break
.bgac:	
	movl	%ebx,	%edi
	jmp .break	
.break:	
	
	pushl	%edi
	pushl	$fmt_out
	call printf
	addl	$8,	%esp

	movl	$0, %eax
	leave
	ret
