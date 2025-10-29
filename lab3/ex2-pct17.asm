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
    b dd 3
	c db 4
    x dq 6    

; our code starts here
segment code use32 class=code
    start:
        ;17. x-(a*a+b)/(a+c/a); a,c-byte; b-doubleword; x-qword
        
        ;c/a
        xor EDX, EDX
        movsx EAX, byte[c]        
        movsx EBX, byte [a]
        cdq
        idiv EBX
        add EAX, EBX
        
        mov ECX, EDX
        mov EBX, EAX
        
        ;a*a+b
        xor EDX, EDX
        movsx EAX, byte [a]
        imul EAX
        mov EBX, [b]
        add EAX, EBX
        adc EDX, 0
        
        idiv EBX
        
        mov ECX, EDX
        mov EBX, EAX
        
        mov EAX, [x]
        mov EDX, [x+4]
        
        sub EAX, EBX
        sbb EDX, ECX
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
