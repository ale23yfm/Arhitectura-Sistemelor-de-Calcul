bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

segment data use32 class=data
    ; ...    
    s dd 0702090Ah, 0B0C0304h, 05060108h
    l equ $-s
    d times l db 0
       
; our code starts here
segment code use32 class=code
        ;3. A string of 3 double words is given, each double word containing 2 values per word (unpacked, so each hex digit is preceded by a 0). To create a string of bytes that contains those values (so packed on a single byte), ordered ascending in memory, these being considered signed numbers.
                ;Example:
                ;for the initial string:
                ;0702090Ah, 0B0C0304h, 05060108h
                
                ;shall be obtained:
                ;72h, 9Ah, 0BCh,  34h, 56h, 18h
                
                ;which will be ordered ascending:
                ;9Ah, 0BCh, 18h, 34h, 56h, 72h
    start:
        mov ECX, l
        JECXZ end_loop
        mov ESI, s
        mov EDI, d
        CLD ; clear DF flag
        
        start_loop:
            lodsd ; EAX -> 0702_090A
            mov BX, AX ; 090A
            mov AH, BH ; 09 
            shl AH, 4 ; 90_0A
            add AH, BL ; 9A_0A
            mov AL, AH
            stosb

            shr EAX, 16 ; 0702
            mov BX, AX ; 0702
            mov AH, BH ; 07
            shl AH, 4
            add AH, BL 
            mov AL, AH
            stosb
            
        loop start_loop  

        mov ecx, 5          
        sort:
                mov edi, 6
                mov ebx, 5
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
        
        end_loop:
            ; exit(0)
            push    dword 0      ; push the parameter for exit onto the stack
            call    [exit]       ; call exit to terminate the program
