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
    b db 0
	  c dd 0 

; our code starts here
segment code use32 class=code
    start:
        ;4. Byte A is given. Obtain the integer n represented by bits 2-4 of A. Then obtain in B the resulting byte by rotating A to the right with n positions. To obtain the double word C:
            ;1. bits 8-15 of C are 0
            ;2. bits 16-23 of C coincide with bits of B
            ;3. bits 24-31 of C coincide with bits of A
            ;4. bits 0-7 of C are 1
            
        ; n
        mov BL, [a]
        and BL, 0b11100
        shr BL, 2
        mov CL, BL
        
        ; b
        mov BL, [a]
        ror BL, CL
        mov [b], BL
        
        ;DX:AX
        xor AX, AX
        xor DX, DX
        
        ; bits 0-7
        or AX, 0b11111111b
                
        ; bits 8-15 are already 0
            
        ; bits 16-23
        mov DL, [b]
        
        ; bits 24-31
        mov DH, [a]
        
        ;move in c
        mov [c], AX
        mov [c+2], DX
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
