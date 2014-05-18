extern exit
extern puts
extern scanf
extern printf

struc list
.int:	resd	1
.nxt:	resd	1
endstruc

	section .data
msg1 : db "%d",0
msg2 : db "%d", 0xA, 0
my:	istruc	list
	at list.int,	dd	1
	at list.nxt,	dd	0
	iend
 
	section .bss
a resd 1
b resd 1

	section .text
global main
main:
	push dword my
	push dword msg1
	call scanf
	sub esp, 8
 
	mov eax, dword [my + list.int]
	push eax
	push dword msg2
 
	call printf
	add esp, 8
 
	push dword 0
	call exit
 	
	ret
 
