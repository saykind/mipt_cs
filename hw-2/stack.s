	.data
fmt_d:	.string "%d"
fmt_c:	.string "%c"
fmt_s:	.string "%s"
fmt_dn:	.string "%d\n"
fmt_xn:	.string "%x\n"
	
	.bss
str:	.space 100
c:	.byte 0

	.text
	.global main
	.type main, @function
main:
#	 ______  __0x0
#	:      :
#	|______|
#	|______|
#	|______| __esp
#	|_%eip_|
#	:      :
	pushl	%ebp		# It's not essential to save %ebp value actually
	movl	%esp, 	%ebp	# But it's one more (and only) step from %eip, which must be untouched	
#	 ______  __0x0
#	:      :
#	|______|
#	|______|
#	|______| __esp,	ebp
#	|_%ebp_| 
#	|_%eip_|
#	:      :
	pushl	%ebp
	pushl	$fmt_xn
	movl	(%esp),	%eax
	addl	$4,	%esp
#	pushl	%eax
 	 subl	$4,	%esp
	 movl	%eax,	(%esp)	
	call printf	#printf("%x\n", %ebp)
	addl	$8,	%esp

	movl  -4(%esp),	%eax	# Great argument!
	pushl	%eax
	pushl	$fmt_xn
	call printf
	addl	$8,	%esp

	pushl	%esp
	pushl	$fmt_xn
	call printf
	addl	$8,	%esp

	pushl	%ebp
	pushl	$fmt_d
	call scanf
	addl	$8,	%esp
	
	movl	(%ebp),	%eax
	pushl	%eax
	pushl	$fmt_dn
	call printf
	addl	$8,	%esp	
	

	movl	$0,	%eax
	movl	%ebp,	%esp
#	popl	%ebp
	 movl	(%esp),	%ebp
	 addl	$4,	%esp 
	movl	$54,	%ebp
	ret

#	 ______ __0x0		 ______
#	:      :		:      :
#	:______:		:______:
#	|______|		|______|
#	|______|		|______|
#	|______|		|______|
#	|______|		|______|
#	|______|		|______|
#	|______|		|
#	|______|		|
#	|______| __esp		|
#	|_%eip_|		|
#	:      :		:
#	:      :		:


