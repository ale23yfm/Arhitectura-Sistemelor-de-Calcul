bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 0101_0111b
    b db 1011_1110b
	c dd 0 

; our code starts here
segment code use32 class=code
    start:
        ;5. The bytes A and B are given. To obtain the double word C:
            ;1. bits 16-31 of C are 1
            ;2. bits 0-3 of C coincide with bits 3-6 of B
            ;3. bits 4-7 of C have the value 0
            ;4. bits 8-10 of C have the value 110
            ;5. bits 11-15 of C coincide with bits 0-4 of A
            
        ;DX:AX
        xor AX, AX
        xor DX, DX        
                  
        ; bits 0-3
        mov BX, [b]
        and BX, 01111000b
        shr BX, 3
        or AX, BX
                
        ; bits 4-7 are already 0
            
        ; bits 8-10
        mov BX, 0b110
        shl BX, 8
        or AX, BX
        
        ; bits 11-15
        mov BX, [a]
        and BX, 00011111b
        shl BX, 11
        or AX, BX
        
        ; bits 16-31
        or DX, 0xFFFF
        
        ; move in c
        mov [c], AX
        mov [c+2], DX
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
