	.data
fmt_in:	.string "%d %d %c"
fmt_out:.string "%d\n"
fmt_int:.string "%d"

	.bss
a:	.space 4
b:	.space 4
c:	.space 1	

	.text
	.globl 	main
	.type	main,	@function
main:
	pushl	%ebp
	movl	%esp,	%ebp
	
	pushl	$c
	pushl	$b
	pushl	$a
	pushl	$fmt_in
	call scanf
	addl	$0x10,	%esp
	
	pushl	b	# Arguments for function
	pushl	a	#

#	switch(c)
	cmpl	$0x2B,	c	# '+'
	 je	LBadd
	cmpl	$0x2D,	c	# '-'
	 je	LBsub
	cmpl	$0x2A,	c	# '*'
	 je	LBmul
	cmpl	$0x2F,	c	# '/'
	 je	LBdiv
	cmpl	$0x25,	c	# '%'
	 je	LBmod
	cmpl	$0x69,	c	# 'i'
	 je	LBinc
	cmpl	$0x64,	c	# 'd'
	 je	LBdec
	jmp	default
  LBadd:
	call myadd
	jmp break
  LBsub:	
	call mysub
	jmp break
  LBmul:
	call mymul
	jmp break
  LBdiv:
	call mydiv
	jmp break
  LBmod:
	call mymod
	jmp break
  LBinc:
	call myinc
	jmp break
  LBdec:
	call mydec
	jmp break

  break:	
	addl	$8,	%esp

	pushl	%eax
	pushl	$fmt_out
	call printf
	addl	$8,	%esp	

  default:
	movl	$0,	%eax	
	movl	%ebp,	%esp
	popl	%ebp
	ret


	.globl 	myadd
	.type	myadd,	@function
myadd:
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl	%ebp
	movl	%esp,	%ebp

	movl	20(%ebp),	%eax
	addl	24(%ebp),	%eax

	movl	%ebp,	%esp
	popl	%ebp
	popl	%edx
	popl	%ecx
	popl	%ebx	
	ret

	.globl 	mysub
	.type	mysub,	@function
mysub:
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl	%ebp
	movl	%esp,	%ebp

	movl	20(%ebp),	%eax
	subl	24(%ebp),	%eax

	movl	%ebp,	%esp
	popl	%ebp
	popl	%edx
	popl	%ecx
	popl	%ebx	
	ret

	.globl 	mymul
	.type	mymul,	@function
mymul:
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl	%ebp
	movl	%esp,	%ebp

	movl	20(%ebp),	%eax
	imull	24(%ebp)

	movl	%ebp,	%esp
	popl	%ebp
	popl	%edx
	popl	%ecx
	popl	%ebx	
	ret

	.globl 	mydiv
	.type	mydiv,	@function
mydiv:
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl	%ebp
	movl	%esp,	%ebp
	
	movl	20(%ebp),	%eax
	movl	%eax,	%edx
	sarl	$31,	%edx
	idivl	24(%ebp)

	movl	%ebp,	%esp
	popl	%ebp
	popl	%edx
	popl	%ecx
	popl	%ebx	
	ret

	.globl 	mymod
	.type	mymod,	@function
mymod:
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl	%ebp
	movl	%esp,	%ebp

	movl	20(%ebp),	%eax
	movl	%eax,	%edx
	sarl	$31,	%edx
	divl	24(%ebp)
	movl	%edx,	%eax

	movl	%ebp,	%esp
	popl	%ebp
	popl	%edx
	popl	%ecx
	popl	%ebx	
	ret

	.globl 	myinc
	.type	myinc,	@function
myinc:
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl	%ebp
	movl	%esp,	%ebp

	movl	20(%ebp),	%eax
	incl	%eax

	movl	%ebp,	%esp
	popl	%ebp
	popl	%edx
	popl	%ecx
	popl	%ebx	
	ret

	.globl 	mydec
	.type 	mydec,	@function
mydec:
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl	%ebp
	movl	%esp,	%ebp

	movl 20(%ebp),	%eax
	decl	%eax

	movl	%ebp,	%esp
	popl	%ebp
	popl	%edx
	popl	%ecx
	popl	%ebx	
	ret

	.globl 	show
	.type 	show, @function
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


