	.globl array
	.data
fmt_in:	.string "%d"
fmt_out:.string	"%d\n"
fmt_int:.string "%d "
	
	.bss
i:	.space 4
N:	.space 4

	.text
	.globl	main
main:
	pushl	%ebp
	movl	%esp, %ebp
	
	pushl	$N
	pushl	$fmt_in
	call scanf
	addl	$8,	%esp

	pushl	$array
	pushl	N
	call scan_array
	addl	$8,	%esp	

	pushl	$array
	pushl	N
	call minof_array
	addl	$8,	%esp
	
	pushl	%eax
	pushl	$fmt_out
	call printf
	addl	$8,	%esp
		
	movl	$0, %eax
	leave
	ret
