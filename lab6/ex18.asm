bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

segment data use32 class=data
    ; ...    
    s dd 12345607h, 1A2B3C15h
    l equ $-s
    d times l db 0
    highs resw 3
       
; our code starts here
segment code use32 class=code
        ;18. A string of double words is given. Let the string of higher words of these double words be ordered in ascending order. The lower words remain unchanged.
            ;Example:
            ;sir DD 12AB5678h, 1256ABCDh, 12344344h 
            ;the result will be
            ;12345678h, 1256ABCDh, 12AB4344h.
    start:
        mov ECX, l
        JECXZ end_loop
        mov ESI, s
        mov EDI, highs
        CLD ; clear DF flag
        
        get_highs:
            lodsd
            shr EAX, 16 ; 4*4 bits
            stosw ; mov [edi], ax
            add EDI, 2 ; word
        loop get_highs
                 
        mov ECX, 2          
        sort:
                mov edi, 3
                mov ebx, 2
            sort_term:
                mov al, [edi]
                mov dl, [edi+1]
                cmp al, dl
                jle no_swap
                    mov [edi], dl
                    mov [edi+1], al
            no_swap:
                inc edi
                dec ebx
                jnz sort_term
        loop sort
        
        replace_highs:
            mov EAX, [ESI]
            and EAX, 0FFFFh
            mov BX, [EDI]
            shl EBX, 16 ;put on high part
            or EAX, EBX 
            mov [ESI], EAX
            add ESI, 4
            add EDI, 2
                    
        end_loop:
            ; exit(0)
            push    dword 0      ; push the parameter for exit onto the stack
            call    [exit]       ; call exit to terminate the program
