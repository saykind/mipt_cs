	.data
fmt_s:	.string "%s"
fmt_d:	.string " %d"
fmt_cc:	.string "%c%c"
adr:	.long 	0x00000010

	.bss
str:	.space 64

	.text
	.globl 	main
	.type 	main, @function
main:
	pushl	%ebp
	movl	%esp,	%ebp	# Непосредственная адресация
	
	pushl	$str
	pushl	$fmt_s
	call scanf
	addl	$8,	%esp
	
	movl	$str,	%ebx	#
	movl	(%ebx),	%eax	# Косвенная адресация
	addl	$0x01,	%ebx	#
	pushl	(%ebx)
	pushl	%eax
	pushl	$fmt_cc
	call printf
	addl	$12,	%esp

	movl	adr,	%eax	# Непосредственная адресация
	pushl	%eax
	pushl	$fmt_d
	call printf
	addl 	$8,	%esp	
	movl	(adr),	%eax	# Прямая адресация
	pushl	%eax
	pushl	$fmt_d
	call printf
	addl 	$8,	%esp
	movl	$adr,	%eax	# 
	pushl	%eax
	pushl	$fmt_d
	call printf
	addl 	$8,	%esp

	movl	$0,	%eax
	movl	%ebp,	%esp
	popl	%ebp
	ret
