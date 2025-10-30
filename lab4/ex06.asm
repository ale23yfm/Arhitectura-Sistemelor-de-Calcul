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
    b dw 0
	c dd 0 

; our code starts here
segment code use32 class=code
    start:
        ;6. The word A is given. Obtain the integer n represented by bits 0-2 of A. Then obtain the resulting word in B by rotating A to the right (without carry) with n positions. To obtain the double word C:
            ;1. bits 8-15 of C are 0
            ;2. bits 16-23 of C coincide with bits 2-9 of B
            ;3. bits 24-31 of C coincide with bits 7-14 of A
            ;4. bits 0-7 of C are 1
        ; n
        mov BX, word [a]
        and BX, 0b111
        
        ; b
        mov CX, word [a]
        ror CX, BL
        mov word [b], CX
        
        ; DX:AX
        xor DX, DX
        xor AX, AX
        
        ; bits 0-7
        mov AX, 0x00FF
        
        ; bits 8-15 are already 0
        
        ; bits 16-23
        mov BX, word [b]
        and BX, 0b1111111100
        shl BX, 14
        or DX, BX
        
        ; bits 24-31
        mov BX, word [a]
        and BX, 0111111110000000b
        shl BX, 17
        or DX, BX
        
        ; move in c
        mov word [c], AX
        mov word [c+2], DX
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
