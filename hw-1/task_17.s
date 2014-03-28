	.data
fmt_in:	.string "%d"
fmt_out:.string	"%d\n"
fmt_int:.string "%d "
	
	.bss
array:	.space 80
i:	.space 4
N:	.space 4

	.text
	.globl	main
	.type	main,	@function
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
	call print_array
	addl	$8,	%esp

	movl	$0, %eax
	leave
	ret

	.globl 	scan_array
	.type 	scan_array, @function
scan_array:
	pushl	%ebp
	pushl	%eax
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl	%edi
	pushl	%esi
	movl	%esp,	%ebp
	
	movl 32(%ebp), 	%edi
	movl 36(%ebp), 	%esi
	movl	$0,	%ebx
.circle:
	leal	array(,%ebx,4),	%eax
	pushl	%eax
	pushl	$fmt_in
	call scanf
	addl	$8,	%esp
	
	inc	%ebx
	cmpl	%edi,	%ebx
	jl	.circle
	
	movl	%ebp,	%esp
	popl	%esi
	popl	%edi
	popl	%edx
	popl	%ecx
	popl	%ebx
	popl	%eax
	popl	%ebp
	ret

	.globl 	print_array
	.type 	print_array, @function
print_array:
	pushl	%ebp
	pushl	%eax
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl	%edi
	pushl	%esi
	movl	%esp,	%ebp
	
	movl 32(%ebp), 	%edi
	movl 36(%ebp), 	%esi
	movl	$0,	%ebx
.cycle:
	pushl	array(,%ebx,4)
	pushl	$fmt_int
	call printf
	addl	$8,	%esp
	
	inc	%ebx
	cmpl	%edi,	%ebx
	jl	.cycle
	
	movl	%ebp,	%esp
	popl	%esi
	popl	%edi
	popl	%edx
	popl	%ecx
	popl	%ebx
	popl	%eax
	popl	%ebp
	ret


