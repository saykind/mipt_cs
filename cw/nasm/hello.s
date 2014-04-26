SECTION .data
msg: db "Hello, world", 10
len: equ $-msg
 
SECTION .text
;global _start
;_start: mov edx, len
global main
main:
 
       mov ecx, msg
        mov ebx, 1    ; stdout
        mov eax, 4    ; write(2)
        int 0x80
 
        mov ebx, 0
        mov eax, 1    ; exit(2)
        int 0x80
