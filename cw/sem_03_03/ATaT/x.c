"movl	$0,	%ebx	\n\t"

"loop:			\n\t"
"cmpl	$0,	%eax	\n\t"
"jng	end		\n\t"
"incl	%ebx		\n\t"

"movl	$0,	%edx	\n\t"
"divl	%ebx		\n\t"

"cmpl	$0,	%edx	\n\t"
"je	loop		\n\t"

"end:			\n\t"
"decl	%ebx		\n\t"
