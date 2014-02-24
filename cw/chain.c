		.data

str_format:
	.string	"%s\n"
str_in:
	.string	"abcdef"
//	Define new symbol using arithmetic.
	.set	str_in_length, . - str_in
//	Special data section. All bytes was initialized by zeroes.
	.bss
str_out:
	.space	str_in_length



		.text
	.globl	main

main:
	pushl	%ebp
	movl	%esp, %ebp

//	Sourse address in %esi.
	movl	$str_in, %esi
//	Destination address in %edi.
	movl	$str_out, %edi
//	In %ecx write lenght of str_in without last 0x0.
	movl	$str_in_length - 1, %ecx

label_1:
//	All chain-like commands depends on Direction Flag. 
//	df = 0 - forward.
//	df = 1 - backward.
//	std - set DF, cld - unset DF.

//	Read data from str_in[i] to %al (%eax, %ax, %al).
	lodsb

//	%al++.

	incb	%al

//	Write data from %al to str_out[i].
	stosb

//	Loop for working with full string.
	loop	label_1

//	Copy last 0x0 from %esi to %edi.
	movsb

//	Print result.
	pushl	$str_out
	pushl	$str_format
	call	printf
	addl	$8, %esp

	movl	%ebp, %esp
	popl	%ebp
	ret
