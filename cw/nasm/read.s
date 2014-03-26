	section .data
yes: 	db "Accepted!"
no: 	db "Wrong key!"
N:	equ 20

	section .bss
str: 	resb 20
a	resb 4
b	resb 4
buffer 	resb 20

	section .text
global _start
_start:
	push	ebp
	push	ebx
	push	ecx
	push	edx
	mov	ebp,	esp

	mov	edx,	N
	mov	ecx,	str
	mov	ebx,	2
	mov	eax,	3
	int	0x80
	
	push	str
	call 	int_parser		
	mov	[a],	eax
	call	int_parser
	add	esp,	4
	mov	[b],	eax


	 mov	eax,	[a]
	push	eax
	call 	int_print
	add 	esp,	4
	 mov	eax,	[b]
	push	eax
	call 	int_print
	add 	esp,	4


;	mov	edx,	N
;	mov	ecx,	str
;	mov	ebx,	1
;	mov	eax,	4
;	int	0x80

	mov	esp,	ebp
	pop	edx
	pop	ecx
	pop	ebx
	pop	ebp
	
	mov	ebx,	0
	mov	eax,	1
	int	0x80




int_parser:
	push	ebp
	push	ebx
	push	ecx
	push	edx
	mov	ebp,	esp

	xor	eax,	eax
	xor	ebx,	ebx
	xor	ecx,	ecx
	xor	edx,	edx
	mov	ecx,	[ebp+20]
	
.loop:
	mov byte bl,	[ecx]
	cmp	ebx,	32		; if(ebx == SPACE)
	jna	.out			; ASCII(' ') = 32
	
	mov	edx,	10
	mul	edx
	sub	ebx,	48		; ASCII('0') = 48
	add	eax,	ebx	
	
	inc	ecx
	jmp 	.loop
.out:	
	inc	ecx
	mov	[ebp+20],	ecx
	
	mov	esp,	ebp
	pop	edx
	pop	ecx
	pop	ebx
	pop	ebp
	ret




int_print:
    ; функция печати целого числа в stdout
    ; аргумент (4-байтовое целое число)
    ; находится в вершине стека
    ; ebp содержит адрес начала stack frame
    ; esp содержит адрес вершины стека
    ; esp < ebp, то есть вершина имеет меньший адрес
    ; в начале по адресам (ebp-4, ebp-3, ebp -2, ebp -1) лежат
    ; четыре байта целого числа, которое нам передали 
    ; в качестве аргумента

    push ebp 
    mov ebp, esp   
                   
    mov ecx, [ebp+8] 

    xor edx, edx  
    mov esi, 10  

    mov edi, 18      ; символы-цифры нашего числа мы будем помещать
                     ; по адресам buffer + 17, buffer+16, buffer+15, ...

    mov byte [buffer + 18], 0xA ; 19-й и 20-й символы — это перенос строчки
    mov byte [buffer + 19], 0   ; и символ конца строки

.loop:
    mov eax, ecx   ;
    xor edx, edx   ; данные четыре строки дают
    div esi        ; ecx = ecx / 10 
    mov ecx, eax   ; edx = ecx mod 10


    add edx, '0'  ; '0' ассемблером интерпретируется как ASCII код символа '0'
    dec edi
    mov byte [buffer+edi], dl
    cmp ecx, 0
    jne .loop

    mov eax, 4        ; эквивалентно write( 1, buffer + edi, 19 - edi )
    mov ebx, 1
    mov ecx, buffer   ; можно короче — lea ecx, [buffer+edi]
    add ecx, edi
    mov edx, 19
    sub edx, edi
    int 0x80

    leave       ; эквивалентно  mov esp, ebp
                ;               pop ebp 
    ret  
