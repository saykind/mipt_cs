# White-space means end of line
	.data
fmt_d:	.string "%d"
fmt_f:	.string "%lf"
fmt_fn:	.string "%.10lf\n"
fmt_in:	.string "%lf %lf"
fmt_xn:	.string "%x\n"
	
a:	.double	-3.1
b:	.double 2.0
c:	.double 1.5
d:	.double -0.9

	.bss
buf:	.space 100
x:	.space 8
y:	.space 8
z:	.space 8
log2:	.space 8
lod10:	.space 8


	.text
	.global main
	.type main, @function
main:
	pushl	%ebp
	movl	%esp,	%ebp

	pushl	$y
	pushl	$x
	pushl	$fmt_in
	call scanf
	addl	$0xc,	%esp
	
	finit
	 fld1
	 fldl	y
	 fldl	x
	 fsubp
	 fyl2x		
	fldl2t
	fld1
	fldl	y
	fldl	x
	faddp
	fyl2x	
	 fdivp
	 faddp



#	 fldl	y
#	 fldl	x
#	 fyl2x
#	frndint	
#	fld1
#	fscale
#	 fldl	y
#	 fldl	x
#	 fyl2x
#	frndint
#	 fldl	y
#	 fldl	x
#	 fyl2x
#	fsubp
#	f2xm1
#	fld1
#	faddp
#	fmulp

	sub	$8,	%esp
	fstpl	(%esp)
	pushl	$fmt_fn
	call printf
	addl	$12,	%esp

	movl	$0,	%eax
	movl	%ebp,	%esp
	popl	%ebp
	ret
