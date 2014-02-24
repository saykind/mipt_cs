	.data
variable:
	.long 9
scan_format:
	.string "%d"
print_format:
	.string "%d\n"
int_format:
	.string "%d"

	.text
	.global main

main:
	pushl	%eax
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl	%ebp
	movl	%esp, %ebp
	
	pushl	%ebx
	pushl	$scan_format
	call scanf			# %ebx contains a pointer to scanned int
	addl 	$8, %esp
	movl	(%ebx),	%ecx		# %ecx contains scanned int
	movl	%ecx, 	%ebx		# %ebx contaons scanned int. %ecx is free
#start
#256
	movl	$0,	%eax	
	cmpl	$256,	%ebx
	jl	skip_256
	movl	$1,	%eax#
	subl	$256,	%ebx#
skip_256:
	pushl	%eax
	pushl	$int_format
	call printf
	addl 	$8,	%esp
#128
	movl	$0,	%eax	
	cmpl	$128,	%ebx
	jl	skip_128
	movl	$1,	%eax#
	subl	$128,	%ebx#
skip_128:
	pushl	%eax
	pushl	$int_format
	call printf			# printf changes %eax, %ecx, %edx ?! But not %ebx !
	addl 	$8,	%esp
#64
	movl	$0,	%eax	
	cmpl	$64,	%ebx
	jl	skip_64
	movl	$1,	%eax#
	subl	$64,	%ebx#
skip_64:
	pushl	%eax
	pushl	$int_format
	call printf
	addl 	$8,	%esp
#32
	movl	$0,	%eax	
	cmpl	$32,	%ebx
	jl	skip_32
	movl	$1,	%eax#
	subl	$32,	%ebx#
skip_32:
	pushl	%eax
	pushl	$int_format
	call printf
	addl 	$8,	%esp
#16
	movl	$0,	%eax	
	cmpl	$16,	%ebx
	jl	skip_16
	movl	$1,	%eax#
	subl	$16,	%ebx#
skip_16:
	pushl	%eax
	pushl	$int_format
	call printf
	addl 	$8,	%esp
#8
	movl	$0,	%eax	
	cmpl	$8,	%ebx
	jl	skip_8
	movl	$1,	%eax#
	subl	$8,	%ebx#
skip_8:
	pushl	%eax
	pushl	$int_format
	call printf
	addl 	$8,	%esp
#4
	movl	$0,	%eax	
	cmpl	$4,	%ebx
	jl	skip_4
	movl	$1,	%eax#
	subl	$4,	%ebx#
skip_4:
	pushl	%eax
	pushl	$int_format
	call printf
	addl 	$8,	%esp
#2
	movl	$0,	%eax	
	cmpl	$2,	%ebx
	jl	skip_2
	movl	$1,	%eax#
	subl	$2,	%ebx#
skip_2:
	pushl	%eax
	pushl	$int_format
	call printf
	addl 	$8,	%esp
#end









	pushl 	%ebx
	pushl	$print_format
	call printf
	addl	$8, 	%esp

	
	movl	%ebp, %esp
	popl	%ebp
	popl	%edx
	popl	%ecx
	popl	%ebx
	popl	%eax
	ret

#greater:
#	pushl	%ebp
#	movl	%esp,	%ebp


#	movl	%ebp,	%esp
#	popl	%ebp
#	ret
