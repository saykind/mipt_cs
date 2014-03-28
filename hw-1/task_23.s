	.data
fmt:	.string "%c %d %lf"
	.globl	glob_char_init
glob_char_init:
	.byte	54
.comm	glob_char_uninit,1,1
	.globl	glob_int_init
glob_int_init:
	.long	54
.comm	glob_int_uninit,4,4
.comm	glob_long_int_uninit,4,4
.comm	glob_long_long_int_uninit,8,8
	.globl	glob_float_init
glob_float_init:
	.long	1057635697
.comm	glob_float_uninit,4,4
	.globl	glob_double_init
glob_double_init:
	.long	343597384
	.long	1071728558
.comm	glob_double_uninit,8,8


	.text
	.globl	main
	.type	main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp

	pushl	$glob_double_uninit
	pushl	$glob_int_uninit
	pushl	$glob_char_uninit
	pushl	$fmt
	call scanf
	addl	$0x10,	%esp

	pushl	glob_double_uninit
	pushl	glob_int_uninit
	pushl	glob_char_uninit
	pushl	$fmt
	call printf
	addl	$0x10,	%esp
	
	movl	$0, %eax
	leave
	ret

