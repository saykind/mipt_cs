call_1: 
	.string "My first sentance!\n"
call_2: 
	.string "My second sentance!\n"
	.text
	.globl main
	.globl my_printf

my_printf:
//	Prolog
	push %ebp
	movl %esp, %ebp
	
	pushl %eax
	movl  8(%ebp), %eax
	pushl %eax

	call printf
		
	movl 12(%ebp), %eax
	pushl %eax

	call printf

	addl $8, %esp
	popl %eax
//	subl $16, %esp
	
//	Epilog
	movl %ebp, %esp
	popl %ebp	
	ret

main:
//	Prolog
	pushl %ebp
	movl %esp, %ebp

	pushl $call_2
	pushl $call_1

	call my_printf 

	addl $8, %esp

//	Epilog
	movl %ebp, %esp
	popl %ebp	
	ret

