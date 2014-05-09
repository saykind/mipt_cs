		.data
fmt_d:	.string "%d"	
fmt_c:	.string "%c"
fmt_s:	.string "%s"
fmt_dn:	.string "%d\n"
endl:	.byte 0xa, 0x0
origin:	.string "{Here is an original text:}\n"
rule_1: .string "\n{Text transformed accroding to rule No.1:\nA->B, B->C, ..., Z->A}\n"
rule_2: .string "\n{Text transformed accroding to rule No.2:\nMove numbers to the beginnig}\n"

		.bss
textin:	.space 2048
textout:.space 2048
length:	.space 4
char:	.space 1

		.text
	.globl main
	.type main, @function	
main:
	pushl 	%ebp
	movl	%esp,	%ebp

	pushl	$textin
	call scan_text
	addl	$4, %esp
	movl	%eax,	length
	
	 pushl	$origin
	 call printf
	 addl	$4,	%esp
	pushl	$textin
	call print_text
	addl	$4, %esp

	pushl	length
	pushl	$textin
	call is_text
	addl	$8,	%esp

	testl	%eax,	%eax
	je .is
	 pushl $rule_2
	 call printf
	 addl	$4,	%esp
	pushl	$textout
	pushl	$textin
	call transform_2
	addl	$8,	%esp
	 jmp .after
.is:
	 pushl $rule_1
	 call printf
	 addl	$4,	%esp
	pushl	$textout
	pushl	$textin
	call transform_1
	addl	$8,	%esp
	 jmp .after
.after:

	 pushl	$textout
	 call print_text
	 addl	$4,	%esp

	

#	movl	$4,	%eax
#	movl	$1,	%ebx
#	movl	$endl,	%ecx
#	movl	$1,	%edx
#	int $0x80

	movl	$0,	%eax
	movl	%ebp,	%esp
	popl	%ebp
	ret

	.type scan_text, @function
scan_text:
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl 	%ebp
	pushl	%esi
	pushl	%edi
	movl	%esp,	%ebp

	movl  28(%ebp),	%esi	

	xorl	%eax,	%eax
.cycle:
	 pushl	%esi
	 pushl	$fmt_c
	 call scanf
	 addl	$8,	%esp
	movl	(%esi),	%ecx
	inc %esi
	inc %ecx
	loop .cycle	
	
	movl  28(%ebp),	%eax
	sub	%eax,	%esi
	movl	%esi,	%eax
	decl	%eax

	movl	%ebp,	%esp
	popl	%edi
	popl	%esi
	popl	%ebp
	popl	%edx
	popl	%ecx
	popl	%ebx
	ret


	.type print_text, @function
print_text:
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl 	%ebp
	pushl	%esi
	pushl	%edi
	movl	%esp,	%ebp

	movl  28(%ebp),	%esi	
	
	xor	%ecx,	%ecx
	xor	%ebx,	%ebx
.circle:
	movb	(%esi),	%bl
	 pushl	%ebx
	 pushl	$fmt_c
	 call printf
	 addl 	$8,	%esp
	incl	%esi
	movb	%bl,	%cl
	incb	%cl
	loop .circle

	movl  28(%ebp),	%eax
	sub	%eax,	%esi
	movl	%esi,	%eax
	decl	%eax

	movl	%ebp,	%esp
	popl	%edi
	popl	%esi
	popl	%ebp
	popl	%edx
	popl	%ecx
	popl	%ebx
	ret


	.type is_text, @function
is_text:
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl 	%ebp
	pushl	%esi
	pushl	%edi
	movl	%esp,	%ebp

	movl  28(%ebp),	%edi	
	movl  32(%ebp), %ecx	

	addl	%ecx,	%edi
	decl	%edi
	movb	(%edi),	%al
	
	cmpb	$0x41,	%al
	jl .zero
	cmpb	$0x5a,	%al
	jg .zero

	movl  28(%ebp),	%edi	
	movl  32(%ebp), %ecx	
	cld
	repne scasb

	movl	%ecx,	%eax
	jmp	.skip
.zero:
	movl	$-1,	%eax
.skip:
	movl	%ebp,	%esp
	popl	%edi
	popl	%esi
	popl	%ebp
	popl	%edx
	popl	%ecx
	popl	%ebx
	ret

	.type transform_1, @function
transform_1:
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl 	%ebp
	pushl	%esi
	pushl	%edi
	movl	%esp,	%ebp

	movl  28(%ebp),	%esi	
	movl  32(%ebp),	%edi

	xorl	%eax,	%eax
	cld
.start:	
	lodsb
	cmpb	$0x41,	%al
	jl .next
	cmpb	$0x5a,	%al
	jg .next
	 incb	%al
	 cmpb 	$0x5a,	%al
	 jng .next
	  subb	$0x1a,	%al	
	.next:
	stosb
	testb	%al,	%al
	jne .start

	movl	%ebp,	%esp
	popl	%edi
	popl	%esi
	popl	%ebp
	popl	%edx
	popl	%ecx
	popl	%ebx
	ret

	.type transform_2, @function
transform_2:
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl 	%ebp
	pushl	%esi
	pushl	%edi
	movl	%esp,	%ebp

	movl  28(%ebp),	%esi	
	movl  32(%ebp),	%edi
 	 xorl	%eax,	%eax
	 cld
.Beginn:
	lodsb
	cmpb	$0x30,	%al
	jl .weiter
	cmpb	$0x39,	%al
	jg .weiter
	 stosb
	.weiter:
	testb	%al,	%al
	jne .Beginn
	
	movl  28(%ebp),	%esi	
	 xorl	%eax,	%eax
	 cld
.Anfang:
	lodsb
	cmpb	$0x30,	%al
	jl .dann
	cmpb	$0x39,	%al
	jg .dann
	jmp .nacher
	.dann:
	 stosb
	.nacher:
	testb	%al,	%al
	jne .Anfang

	movl	%ebp,	%esp
	popl	%edi
	popl	%esi
	popl	%ebp
	popl	%edx
	popl	%ecx
	popl	%ebx
	ret

