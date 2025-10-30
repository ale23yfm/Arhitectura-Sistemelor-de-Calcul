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
    ;(d+d-c)-(c+c-a)+(c+a)
    xor EAX, EAX
    xor EDX, EDX
    mov EAX, [d]
    mov EDX, [d+4]
    add EAX, [d]
    adc EDX, [d+4] 
    sub EAX, [c]
    sbb EDX, 0
    
    xor EBX, EBX
    xor ECX, ECX
    mov EBX, [c]
    add EBX, [c]
    adc ECX, 0
    movsx ESI, byte[a]
    sub EBX, ESI
    sbb ECX, 0
    
    sub EAX, EBX
    sbb EDX, ECX
    
    mov EBX, EAX
    mov ECX, EDX
    
    xor EAX, EAX
    mov AL, [a]
    cbw
    cwde
    add EAX, [c]
    
    add EBX, EAX
    adc ECX, 0

    push    dword 0
    call    [exit]
