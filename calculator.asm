SECTION .bss
    option resb 4
    num1 resb 4
    num2 resb 4
    ans resb 4

SECTION .data
title: db "===== SIMPLE CALCULATOR ====="
lentitle: equ 29

optionmsg: db "Addition (+) : 1", 10, 13, "Substraction (-) : 2", 10, 13
lenoption: equ 40
inputline: db "> "
leninputline: equ 2
wronginputmsg: db "WRONG INPUT!! PLEASE ENTER AGAIN!!", 10, 13
lenwronginputmsg: equ 36

input1stnum: db "Enter 1st Number : "
input2ndnum: db "Enter 2nd Number : "
leninputnum: equ 19

resultmsg: db "The Result are : "
lenresultmsg: equ 17

nl: db 10
carr: db 13

SECTION .text

global _start
global _newline
global _readoption
global _read1stnum
global _read2ndnum
global _printans

_start:
    push ebp
    mov ebp, esp

    mov edx, lentitle ;print title
    mov ecx, title
    mov	ebx, 1
	mov	eax, 4
	int	0x80

    call _newline

    call _readoption

    call _read1stnum

    call _read2ndnum

    cmp dword [option], "1"
    je add
    cmp dword [option], "2"
    je sub

    add:
        mov eax, [num1]
        sub eax, 0x30
        mov ebx, [num2]
        sub ebx, 0x30
        add eax, ebx

        add eax, 0x30
        mov dword [ans], eax

        jmp printans

    sub:
        mov eax, [num1]
        sub eax, 0x30
        mov ebx, [num2]
        sub ebx, 0x30
        sub eax, ebx

        add eax, 0x30
        mov dword [ans], eax

        jmp printans

    printans:
        mov edx, lenresultmsg
        mov ecx, resultmsg
        mov	ebx, 1
        mov	eax, 4
        int	0x80
        
        mov edx, 1
        mov ecx, ans
        mov	ebx, 1
        mov	eax, 4
        int	0x80

        call _newline

    mov eax, 1
    mov ebx, 0
    int 0x80

_newline:
    push ebp
	mov ebp, esp

	mov edx, 1
    mov ecx, nl
    mov	ebx, 1
    mov	eax, 4
    int	0x80

	leave
	ret

_readoption:
    push ebp
    mov ebp, esp

    mov edx, lenoption
    mov ecx, optionmsg
    mov	ebx, 1
    mov	eax, 4
    int	0x80

    mov edx, leninputline
    mov ecx, inputline
    mov	ebx, 1
    mov	eax, 4
    int	0x80

    mov eax, 3    
    mov ebx, 0 
    mov ecx, option
    mov edx, 2
    int 0x80

    and dword [option], 0xff

    leave 
    ret

_read1stnum:
    push ebp
    mov ebp, esp

    mov edx, leninputnum
    mov ecx, input1stnum
    mov	ebx, 1
    mov	eax, 4
    int	0x80

    mov eax, 3    
    mov ebx, 0 
    mov ecx, num1
    mov edx, 2
    int 0x80

    and dword [num1], 0xff

    leave 
    ret

_read2ndnum:
    push ebp
    mov ebp, esp

    mov edx, leninputnum
    mov ecx, input2ndnum
    mov	ebx, 1
    mov	eax, 4
    int	0x80

    mov eax, 3    
    mov ebx, 0 
    mov ecx, num2
    mov edx, 2
    int 0x80

    and dword [num2], 0xff

    leave 
    ret