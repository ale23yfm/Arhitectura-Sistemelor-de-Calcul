bits 32
global  start

extern  exit
import  exit msvcrt.dll

segment data use32 class=data
    a   db  12
    b   dw  300
    c   dd  100000
    d   dq  4000000000


segment code use32 class=code
start:
    ;(a+c)-(d+b) 
    ;unsigned
    xor EAX, EAX
    xor EDX, EDX
    xor EBX, EBX
    xor ECX, ECX
    
    ;a+c
    movzx EAX, byte [a]
    add EAX, dword [c]
    adc EDX, 0
    mov EBX, EAX
    mov ECX, EDX
        
    ;d+b
    xor EAX, EAX
    xor EDX, EDX
    movzx EAX, word [b]
    add EAX, word [d]
    adc EDX, word [d+4]
    
    ;(a+c)-(d+b)
    sub EBX, EAX
    sbb ECX, EDX

    push    dword 0
    call    [exit]
