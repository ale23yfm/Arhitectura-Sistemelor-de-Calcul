bits 32 ;asamblare si compilare pentru arhitectura de 32 biti
; definim punctul de intrare in programul principal
global  start 

extern  exit ; indicam asamblorului ca exit exista, chiar daca noi nu o vom defini
import  exit msvcrt.dll; exit este o functie care incheie procesul, este definita in msvcrt.dll
        ; msvcrt.dll contine exit, printf si toate celelalte functii C-runtime importante
segment  data use32 class=data ; segmentul de date in care se vor defini variabilele 
	a dw 0111_0111_0101_0111b
    b dw 1001_1011_1011_1110b
	c dd 0
    
    
segment  code use32 class=code ; segmentul de cod
start: 
    ;12. Two words A and B are given. To obtain the double word C:
        ;1. bits 0-6 of C have the value 0
        ;2. bits 7-9 of C coincide with bits 0-2 of A
        ;3. bits 10-15 of C coincide with bits 8-13 of B
        ;4. bits 16-31 of C have the value 1
    
    ;work on DX:AX instead of EAX
    mov AX, 0
    mov DX, 0
    
    ; 1. bits 0-6
    and AX, 1111_1111_1000_0000b
    
    ; 2. bits 7-9
    mov BX, [a]
    and AX, 0000_0011_1000_0000b
    shl AX, 7
    or AX, BX
    
    ; 3. bits 10-15
    mov CX, [b]
    and CX, 0011_1111_0000_0000b
    shl CX, 2
    or AX, CX
    
    ; 4. bits 16-31
    or DX, 1111_1111_1111_1111b
    
    ;result
    mov [c+16], DX
    mov [c], AX
    
	push dword 0 ;se pune pe stiva codul de retur al functiei exit
	call [exit] ;apelul functiei sistem exit pentru terminarea executiei programului	
