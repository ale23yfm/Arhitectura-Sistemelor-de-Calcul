bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dw 0111_0111_0101_0111b
    b dw 1001_1011_1011_1110b
	  c dd 0 

; our code starts here
segment code use32 class=code
    start:
        ;3. The words A and B are given. To obtain the double word C:
            ;1. bits 0-2 of C coincide with bits 12-14 of A
            ;2. bits 3-8 of C coincide with bits 0-5 of B
            ;3. bits 9-15 of C coincide with bits 3-9 of A
            ;4. bits 16-31 of C coincide with bits of A
    
        ;DX:AX
        xor AX, AX
        xor DX, DX
        
        ; bits 0-2
        mov BX, [a]
        and BX, 0111000000000000b
        shr BX, 12
        or AX, BX
        
        ; bits 3-8
        mov BX, [b]
        and 0b111111
        shl BX, 3
        or AX, BX
        
        ; bits 9-15
        mov BX, [a]
        and BX, 0b1111111000
        shl BX, 6
        or AX, BX
        
        ; bits 16-31
        mov DX, [a]
        
        ;move in c
        mov [c], AX
        mov [c+2], DX
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
