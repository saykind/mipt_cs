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
.circle:				#	do {
	leal	array(,%ebx,4),	%eax	#	
	pushl	%eax			#	scanff("%d", array+4*ebx);
	pushl	$fmt_in			#	array is (int *)
	call scanf			#
	addl	$8,	%esp		#
					#
	inc	%ebx			#	ebx++
	cmpl	%edi,	%ebx		#
	jl	.circle			#	} while (ebx < ecx)
	
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
	movl	$0,	%ebx	#	ebx = 0; edi = N
.cycle:				#	while
	cmpl	%edi,	%ebx	#	(ebx < edi) {
	jnl	.out		#	
	pushl	array(,%ebx,4)	#	
	pushl	$fmt_int	#	
	call printf		#	printf("%d ", array+ebx*4);
	addl	$8,	%esp	#
				#
	inc	%ebx		#	ebx++;
	jmp	.cycle		#	}
.out:				
	
	movl	%ebp,	%esp
	popl	%esi
	popl	%edi
	popl	%edx
	popl	%ecx
	popl	%ebx
	popl	%eax
	popl	%ebp
	ret


