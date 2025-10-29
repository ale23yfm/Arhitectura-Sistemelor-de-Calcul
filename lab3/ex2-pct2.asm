bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 2
    b db 3
	c db 4
    d dd 5
    e dq 6    

; our code starts here
segment code use32 class=code
    start:
        ;2. 2/(a+b*c-9)+e-d; a,b,c-byte; d-doubleword; e-qword
        
        ;a+b*c-9
        mov AL, byte [b]
        cbw
        imul byte [c]
        mov BX, AX
        mov AL, byte [a]
        cbw
        mov CX, AX
        mov AX, BX
        add AX, CX
        adc DX, 0
        sub AX, 9
        sbb DX, 0
        mov CX, DX
        mov BX, AX
        
        ;2
        mov AL, 2
        cbw
        cwd
        
        ;2/(a+b*c-9)
        xor DX, DX
        idiv BX
        
        ;2/(a+b*c-9)+e-d
        cdq
        add EAX, [e]
        adc EDX, [e+4]
        sub EAX, [d]
        sbb EDX, [d+4]
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
