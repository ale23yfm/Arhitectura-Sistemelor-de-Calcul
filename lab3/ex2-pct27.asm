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
	c dw 4
    e dd 5
    x dq 6    

; our code starts here
segment code use32 class=code
    start:
        ;27. (100+a+b*c)/(a-100)+e+x/a; a,b-byte; c-word; e-doubleword; x-qword
        
        ;100+a+b*c
        movsx EAX, byte [b]
        movsx ECX, word [c]
        imul ECX
        movsx ECX, byte [a]
        add EAX, ECX
        adc EDX, 0
        add EAX, 100
        adc EDX, 0
        
        ;(a-100)
        xor EBX, EBX
        sub ECX, 100
        sbb EBX, 0
        
        ;(100+a+b*c)/(a-100)
        cdq
        idiv ECX
        
        ;(100+a+b*c)/(a-100)+e
        mov EBX, [e]
        mov ECX, [e+4]
        add EAX, EBX
        adc EDX, ECX
        
        mov EBX, EAX
        mov ECX, EDX
        
        ;x/a
        mov EAX, [x]
        mov EDX, [x+4]
        
        movsx ESI, byte [a]
        
        idiv ESI
        
        ;(100+a+b*c)/(a-100)+e+x/a
        add EBX, EAX
        adc ECX, EDX
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
