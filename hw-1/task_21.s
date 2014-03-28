	.globl array
	.data
fmt_in:	.string "%d"
fmt_out:.string	"%d\n"
fmt_int:.string "%d "
	
	.bss
array:	.space 80
i:	.space 4
M:	.space 4
N:	.space 4

	.text
	.globl	main
main:
	pushl	%ebp
	movl	%esp, %ebp
	
	pushl	$M
	pushl	$fmt_in
	call scanf
	addl	$8,	%esp
	pushl	$N
	pushl	$fmt_in
	call scanf
	addl	$8,	%esp
	movl	M,	%eax
	mull	N
	movl	%eax,	N

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
	
	.globl 	minof_array
	.type 	minof_array, @function
minof_array:
	pushl	%ebp
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl	%edi
	pushl	%esi
	movl	%esp,	%ebp
	
	movl 28(%ebp), 	%edi
	movl 32(%ebp), 	%esi
	movl	$0,	%ebx
	movl	array,	%eax
.start:
	cmpl	%eax,	array(,%ebx,4)	
	jg	.skip	
	movl	array(,%ebx,4),	%eax
  .skip:
	inc	%ebx
	cmpl	%edi,	%ebx
	jl	.start
	
	movl	%ebp,	%esp
	popl	%esi
	popl	%edi
	popl	%edx
	popl	%ecx
	popl	%ebx
	popl	%ebp
	ret




