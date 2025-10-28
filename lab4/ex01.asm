bits 32

global  start 

extern  exit
import  exit msvcrt.dll
        
segment  data use32 class=data
	a dw 0111_0111_0101_0111b
    b dw 1001_1011_1011_1110b
	c dd 0
    
    
segment  code use32 class=code ; segmentul de cod
start: 
    ;1. The words A and B are given. To obtain the double word C:
        ;1. bits 0-4 of C coincide with bits 11-15 of A
        ;2. bits 5-11 of C have the value 1
        ;3. bits 12-15 of C coincide with bits 8-11 of B
        ;4. bits 16-31 of C coincide with bits of A
    
    ;work on DX:AX instead of EAX
    xor AX, AX
    xor DX, DX
    
    ; 1. bits 0-4
    mov BX, [a]
    and BX, 1111_1000_0000_0000b
    shr BX, 11
    or AX, BX    
    
    ; 2. bits 5-11
    or AX, 0000_1111_1110_0000b
    
    ; 3. bits 12-15
    mov CX, [b]
    and CX, 0000_1111_0000_0000b
    shl CX, 4
    or AX, CX
    
    ; 4. bits 16-31
    mov DX, [a]
    
    ;result
    mov [c+2], DX
    mov [c], AX
    
	push dword 0 
	call [exit] 
