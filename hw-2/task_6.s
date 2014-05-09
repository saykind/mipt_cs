	.data
fmt_x:	.string "%x\n"
fmt_int:.string "%d"
flagstr:.string "CF\tZF\tSF\tOF\n"
fmt_f:	.string "%d\t%d\t%d\t%d\n"	
fmt_n:	.string "\n"
fmt_in:	.string "%c"

	.bss
cf:	.space 1
zf:	.space 1
sf:	.space 1
of:	.space 1

	.text
.macro OUTF
	pushfl
	call showf
	popfl
.endm
	.globl 	main
main:
	pushl	%ebp
	movl	%esp,	%ebp

	pushl	$cf
	pushl	$fmt_in
	call scanf
	addl	$8,	%esp
	movl	cf,	%ebx	
	
	pushl	$flagstr
	call printf
	addl	$4,	%esp
	
	cmpw	$0x63,	%bx
	je	.Czso
	cmpb	$0x7a,	%bl
	je	.cZso
	cmpb	$0x73,	%bl
	je	.czSo
	cmpb	$0x6f,	%bl
	je	.czsO
	jmp	.czso
.Czso:
	movl	$0b11,	%eax	# mov doesn't set flags
	shrl	%eax		# sets CF
	OUTF
	jmp	.break
.cZso:
	xorl	%eax,	%eax	# sets ZF
	OUTF
	jmp	.break
.czSo:
	movl	$-1,	%eax
	andl	%eax,	%eax	# sets SF
	OUTF
	jmp	.break
.czsO:
	movl	$-1,	%eax
	addl	$2,	%eax
	rcrl	$2,	%eax	# sets OF
	OUTF
	jmp	.break
.czso:
	movl	$0x10,	%eax
	addl	$0x10,	%eax
	OUTF
	jmp	.break
.CzSo:
	movl	$0,	%eax
	subl	$1,	%eax	# sets CF and SF
	OUTF
	jmp	.break
.CZso:
	movl	$0b01,	%eax	# mov doesn't set flags
	shrl	%eax		# sets CF and ZF
	OUTF
	jmp	.break
.break:
	
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
        popl    %ebp            #
        popl    %edx            #
        popl    %ecx            #
        popl    %ebx            #
        ret
