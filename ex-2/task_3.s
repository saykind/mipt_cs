	.data
fmt_in:	.string "%d %d %d %d %d" 
fmt_out:.string "pos = %d\tneg = %d\n"
fmt_int:.string "%d"
fmt_n:	.string "\n"

	.bss
A1:	.space 4
A2:	.space 4
A3:	.space 4
A4:	.space 4
A5:	.space 4

	.text
.macro my_macro a1, a2, a3, a4, a5
	cmpl $0, \a1
	jng .L1
	 incl	%eax
	.L1:
	cmpb $0, \a2
	jng .L2
	 incl	%eax
	.L2:
	cmpb $0, \a3
	jng .L3
	 incl	%eax
	.L3:
	cmpb $0, \a4
	jng .L4
	 incl	%eax
	.L4:
	cmpb $0, \a5
	jng .L5
	 incl	%eax
	.L5:
	cmpl $0, \a1
	jnl .K1
	 incl	%ebx
	.K1:
	cmpb $0, \a2
	jnl .K2
	 incl	%ebx
	.K2:
	cmpb $0, \a3
	jnl .K3
	 incl	%ebx
	.K3:
	cmpb $0, \a4
	jnl .K4
	 incl	%ebx
	.K4:
	cmpb $0, \a5
	jnl .K5
	 incl	%ebx
	.K5:
.endm


	.globl 	main
main:
	pushl	%ebp
	movl	%esp,	%ebp

	pushl	$A5
	pushl	$A4
	pushl	$A3
	pushl	$A2
	pushl	$A1
	pushl	$fmt_in
	call scanf
	addl	$0x18,	%esp

	movl	$0,	%eax
	movl	$0,	%ebx
	my_macro A1, A2, A3, A4, A5
#	my_macro $1, $2, $3, $4, $5
	
	pushl	%ebx
	pushl	%eax
	pushl	$fmt_out
	call printf
	addl	$0xc,	%esp


	movl	$0,	%eax
	leave
	ret

