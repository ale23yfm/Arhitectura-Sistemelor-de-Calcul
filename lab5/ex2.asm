bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

segment data use32 class=data
    ; ...    
    s1 db '+', '4', '2', 'a', '@', '3', '$', '*'
    len1 equ $-s1
    special db '!', '@', '#', '$', '%', '^', '&', '*'
    lens equ $-special
    d times len1 db 0
    
    
; our code starts here
segment code use32 class=code
        ;2. Give a string of characters S. Build the string D that contains all the special characters (!@#$%^&*) from the S string.

    start:
        mov ESI, 0 ;source index
        mov EDI, 0 ;destination index
        mov EDX, 0 ;special characters index
        mov ECX, len1
        JECXZ end_loop
        
        start_loop:
            mov AL, [s1+ESI]
            start_loop_s:
                mov BL, [special+EDX]
                cmp AL, BL
                je is_special
                cmp AL, BL
                jne not_special
            jmp start_loop_s
        jmp start_loop
        
        is_special:
            mov [d+EDI], AL
            inc EDI
            inc EDX
            inc ESI
            cmp ESI, len1
            jmp start_loop
        
        not_special:
            inc ESI
            inc EDX
            cmp ESI, len1
            jmp start_loop
            
        loop start_loop    
        end_loop:
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
