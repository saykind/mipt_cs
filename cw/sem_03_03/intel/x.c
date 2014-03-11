"mov	ebx,	0	\n\t"

"loop:			\n\t"
"cmp	eax,	0	\n\t"
"jng	end		\n\t"
"inc	ebx		\n\t"

"mov	edx,	0	\n\t"
"div	ebx		\n\t"

"cmp	edx,	0	\n\t"
"je	loop		\n\t"

"end:			\n\t"
"dec	ebx		\n\t"
