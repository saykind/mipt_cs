// Solution of problems #1.1 and #1.2
	.data
int:
	.space	4
str_hello:
	.string "\nEnter number from -1073741823 to 1073741823:\n"
fmt_int:
	.string	"%d"
fmt_endl:
	.string "\n\n"
str_pos:
	.string "+"
str_neg:
	.string "-"
str_32:
	.string "Signed integer value on 32-bit system will contain it like:\n"
	
	.text
	.globl	main
main:
	pushl	%ebp		#Prolog
	movl	%esp, 	%ebp	#Prolog

	pushl	$str_hello	##
	call	printf		##
	addl	$4,	%esp	##

	pushl	$int		
	pushl	$fmt_int	#"%d"
	call	scanf
	addl	$8, 	%esp

	pushl	$str_32		##
	call printf		##
	addl	$4,	%esp	##

	movl	int,	%eax	#scanned value is in eax

	cmpl	$0,	int
	jnl	positiv
#	if (eax < 0) {
	movl	$2147483648,	%ebx
	addl	%eax,	%ebx
	movl	%ebx,	%eax
	
	movl	%eax,	int

	pushl	$str_neg	##printf("(-)");
	call printf		##
	addl	$4,	%esp	##
	
	jmp	skip_print
#	} else
positiv:
	pushl	$str_pos	##printf("(+)");
	call printf		##
	addl	$4,	%esp	##

skip_print:
	movl	int,	%eax	

	movl	$0,	%edx	#edx = 0;
	movl	$0,	%ebx	#ebx is counter
	movl	$2,	%ecx	#ecx = 2;
	
start:
	cmpl	$0,	%eax	#(eax==0)?
	jng	middle
#	if (eax > 0) {
	movl	$0,	%edx	#NB! eax = (edx:eax)/ecx;
	divl	%ecx		#edx = eax mod ecx;	eax = (edx:eax)/ecx;
	pushl	%edx
	
	incl	%ebx		#ebx++;
	jmp	start	
#	}
middle:
	cmpl	$0,	%ebx	#ebx is counter
	jng	end	
#	if (eax > 0) {
	pushl	$fmt_int	#printf("%d", (esp)+ebx));	
	call printf
	addl	$8,	%esp

	decl	%ebx		#ebx--;
	jmp	middle	
#	}
end:	

	cmpl	$0,	int
	jne	not_zero
# 	if (int == 0) {
	pushl	$0
	pushl	$fmt_int
	call	printf
	addl	$8,	%esp
#	} else 
not_zero:

	pushl	$fmt_endl	#printf("\n");
	call printf
	addl	$4,	%esp
	
	movl	%ebp,	%esp
	popl	%ebp
	ret
