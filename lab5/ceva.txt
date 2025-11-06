bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

segment data use32 class=data
    ; ...    
    s1 db '+', 4, 2, 'a', 8, 4, 'X', 5
    len1 equ $-s1
    s2 db 'a', 4, 5
    len 2 equ $-s2
    d times (len1/3 + 1 +len2) db 0
    
    
; our code starts here
segment code use32 class=code
        ;28. Two strings S1 and S2 are given. Build the string D by concatenating the elements on the multiple positions of 3 in the string S1 with the elements of the string S2 in reverse order.
    start:
        mov ESI, 0 ;source index
        mov EDI, 0 ;destination index
        mov ECX, len1
        JECXZ end_loop
        
        start_loop1:
            mov AL, [s1+ESI]
            mov [d+EDI], AL
            inc EDI
            add ESI, 3 ; jump to the next 3rd elements
            cmp ESI, len1 ; if ESI is less than len1, do again
            jl start_loop1; continue looping
            
        end_loop1:
            mov ESI, len2
            mov ECX, len2
            jecxz end_loop
            
        start_loop2:
            mov AL, [s2+ESI-1] ;'cause we came from 0
            mov [d+EDI], AL
            inc EDI
            dec ESI
        loop start_loop2    

        end_loop2:
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
