	.data
fmt_x:	.string "%x\n"
fmt_int:.string "%d"
flags:	.string "CF\tZF\tSF\tOF\n"
fmt_f:	.string "%d\t%d\t%d\t%d\n"	
fmt_n:	.string "\n"

	.bss
cf:	.space 1
zf:	.space 1
sf:	.space 1
of:	.space 1

	.text
	.globl 	main
main:
	pushl	%ebp
	movl	%esp,	%ebp

	pushl	$flags
	call printf
	addl	$4,	%esp
	
	pushfl	
	call showf
	pushl	$16
	call show
	addl	$8,	%esp
	pushl	$fmt_n
	call printf
	addl	$4,	%esp

#test	
	movl	$0,	%eax
	addl	$1, 	%eax
	shrl	%eax
	pushfl
	call showf
	pushl	$16
	call show
	addl	$8,	%esp
	pushl	$fmt_n
	call printf
	addl	$4,	%esp

	movl	$0,	%eax	
	movl	%ebp,	%esp
	popl	%ebp
	ret



.globl  showf
.type   showf,   @function
showf:
        pushl   %ebx            #prolog
        pushl   %ecx            #
        pushl   %edx            #
        pushl   %ebp            #
        movl    %esp,   %ebp    #

        movl 20(%ebp),  %ebx
	
	movb	$0,	cf
	shrl	$1,	%ebx
	jnc	.lbl1
	movb	$1,	cf
  .lbl1:
	movb	$0,	zf
	shrl	$6,	%ebx
	jnc	.lbl2
	movb	$1,	zf
  .lbl2:
	movb	$0,	sf
	shrl	$1,	%ebx
	jnc	.lbl3
	movb	$1,	sf
  .lbl3:
	movb	$0,	of
	shrl	$4,	%ebx
	jnc	.lbl4
	movb	$1,	of
  .lbl4:

	xor	%eax,	%eax
	movb	of,	%al
	pushl	%eax
	xor	%eax,	%eax
	movb	sf,	%al
	pushl	%eax
	xor	%eax,	%eax
	movb	zf,	%al
	pushl	%eax
	xor	%eax,	%eax
	movb	cf,	%al
	pushl	%eax
        pushl 	$fmt_f
        call printf
        addl    $0x14,     %esp

        movl    %ebp,   %esp    #epilog
        popl    %ebp            #epilog
        popl    %edx            #
        popl    %ecx            #
        popl    %ebx            #
        ret

.globl  show
.type   show,   @function
show:
        pushl   %ebx            #prolog
        pushl   %ecx            #
        pushl   %edx            #
        pushl   %ebp            #
        movl    %esp,   %ebp    #

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
        pushl $fmt_int
        call printf
        addl    $8,     %esp
        movl    %ebx,   %ecx
        loop loop_print

        movl    %ebp,   %esp    #epilog
        popl    %ebp            #epilog
        popl    %edx            #
        popl    %ecx            #
        popl    %ebx            #
        ret

