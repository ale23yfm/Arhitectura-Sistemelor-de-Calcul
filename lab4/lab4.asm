bits 32 ;asamblare si compilare pentru arhitectura de 32 biti
; definim punctul de intrare in programul principal
global  start 

extern  exit ; indicam asamblorului ca exit exista, chiar daca noi nu o vom defini
import  exit msvcrt.dll; exit este o functie care incheie procesul, este definita in msvcrt.dll
        ; msvcrt.dll contine exit, printf si toate celelalte functii C-runtime importante
segment  data use32 class=data ; segmentul de date in care se vor defini variabilele 
	a dw 0111_0111_0101_0111b
    b dw 1001_1011_1011_1110b
    c dw 0
    
segment  code use32 class=code ; segmentul de cod
start: 
    ;build the word c in BX
    mov BX, 0 ;BX = 00000000 00000000

        ;the bits 0-2 of c are the same as the bits 10-12 of b
    mov AX, [a]
    ;or mov BX, 0001_1100_0000_0000b and the and AX, BX
    and AX, 0001_1100_0000_0000b
    ;move from 10 pos. to 0 pos.
    ;shr AX, 10
    mov CL, 10
    shr AX, CL 
    ;concatenation
    or BX, AX

        ;the bits 3-6 of c have the same value 1
    or BX, 0000_0000_0111_1000b

        ;the bits 7-10 of c are the same bits 1-4 of a
    mov DX, [a]
    and DX, 0000_0000_0001_1110b
    shl DX, 6
    or BX, DX

        ;the bits 11-12 have the value 0
    ; in bits mask 0 for and, 1 for or
    and bx, 1110_0111_1111_1111b

        ;the bits 13-15 of c are the invert of the bits 9-11 of b
    mov AX, [b]
    not AX
    and AX, 0000_1110_0000_0000b
    shl ax, 4
    or bx, ax
    
    mov [c], bc
    
	push dword 0 ;se pune pe stiva codul de retur al functiei exit
	call [exit] ;apelul functiei sistem exit pentru terminarea executiei programului	
