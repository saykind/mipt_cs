		.data
fmt_d:.string "%d"	
fmt_c:.string "%c"
fmt_x:.string "%x\n"
fmt_n:.string "\n"
int:	.space	4	

		.text
	.globl main
	
main:
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl 	%ebp
	movl	%esp,	%ebp
	
	xor	%edi,	%edi
#	xor	%esi,	%esi
	movl	$0,	int

	movl	$12,	%edi	# Max number 
start:
	cmpl	$0,	%edi	# if (edi <= 0)
	jng	out		# {jump out:}
	
	pushl	$int		
	pushl	$fmt_c
	call scanf		# scanf("%c", &int)
	addl	$8,	%esp

	subl	$48,	int

	cmpl	$0,	int	# if (edi <= 0)
	jl	out		# {jump out;}

	pushl	int	
	pushl	$4
	call	show
	addl	$8,	%esp

#	shll	$1,	%esi
#	addl	int,	%esi

	decl	%edi		# edi--
	jmp	start
out:

	pushl	$fmt_n
	call	printf
	addl	$4,	%esp

	movl	$0,	%eax
	movl	%ebp,	%esp
	popl	%ebp
	popl	%edx
	popl	%ecx
	popl	%ebx
	ret


show:
        pushl   %ebx
        pushl   %ecx
        pushl   %edx
        pushl   %ebp            #prolog
        movl    %esp,   %ebp    #prolog

        movl 20(%ebp),  %ecx
        movl 24(%ebp),  %ebx
        
	movl 20(%ebp),  %ecx
loop_roll:
        movl    $1,     %edx
        rorl    $1,     %ebx
        jc      one
        movl    $0,     %edx
        one:
        pushl   %edx
        loop loop_roll

        movl 20(%ebp),  %ecx
loop_print:
        movl    %ecx,   %ebx
        pushl 	$fmt_d
        call printf
        addl    $8,     %esp
        movl    %ebx,   %ecx
        loop loop_print

        movl    %ebp,   %esp    #epilog
        popl    %ebp            #epilog
        popl    %edx
        popl    %ecx
        popl    %ebx
        ret

