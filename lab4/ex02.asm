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
        ;2. The words A and B are given. The double word C is required:
            ;1. bits 0-3 of C coincide with bits 5-8 of B
            ;2. bits 4-8 of C coincide with bits 0-4 of A
            ;3. bits 9-15 of C coincide with bits 6-12 of A
            ;4. bits 16-31 of C coincide with bits of B 
    
        ;DX:AX
        xor AX, AX
        xor DX, DX
        
        ;bits 0-3
        mov BX, [b]
        and BX, 0000_0001_1110_0000b
        shr BX, 5
        or AX, BX
        
        ;bits 4-8
        mov BX, [a]
        and BX, 11111b
        shl BX, 4
        or AX, BX
        
        ;bits 9-15
        mov BX, [a]
        and BX, 1111111000000b
        shl BX, 3
        or AX, BX
        
        ;bits 16-31
        mov DX, [b]
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
