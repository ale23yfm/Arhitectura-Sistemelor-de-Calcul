bits 32 ;asamblare si compilare pentru arhitectura de 32 biti
; definim punctul de intrare in programul principal
global  start 

extern  exit ; indicam asamblorului ca exit exista, chiar daca noi nu o vom defini
import  exit msvcrt.dll; exit este o functie care incheie procesul, este definita in msvcrt.dll
        ; msvcrt.dll contine exit, printf si toate celelalte functii C-runtime importante
segment  data use32 class=data ; segmentul de date in care se vor defini variabilele 
	
   a db 2
   b db 3   
   c db 4
   d db 5
    
segment  code use32 class=code ; segmentul de cod
start: 
    ;Perform the calculations and analyze the results
        ;c-(a+d)+(b+d)
            ;c
        mov AL, [c]
        cbw
        mov BX, AX
            ;a
        mov AL, [a]
        cbw
            ;a+d
        add AX, [d]
        adc AH, 0
            ;c-(a+d)
        sub BX, AX
        sbb BH, 0
            ;b
        mov AL, [b]
        cbw
            ;b+d
        add AX, [d]
        adc AH, 0
            ;c-(a+d)+(b+d)
        add BX, AX
        adc BH, 0
        
        ;(b+b)+(c-a)+d
        mov BX, 0
            ;b
        mov AL, [b]
        cbw
            ;b+b
        add AX, [b]
        adc AH, 0
        mov BX, AX
            ;c
        mov AL, [c]
        cbw
            ;c-a
        sub AX, [a]   
        sbb AH, 0
            ;(b+b)+(c-a)
        add BX, AX
        adc BH, 0
            ;(b+b)+(c-a)+d
        add BX, [d]
        adc BH, 0
        
        ;(c+d)-(a+d)+b
            ;c
        mov AL, [c]
        cbw
            ;c+d
        add AX, [d]
        adc AH, 0
        mov BX, AX
            ;a
        mov AL, [a]
        cbw
            ;a+d
        add AX, [d]
        adc AH, 0
            ;(c+d)-(a+d)        
        sub BX, AX 
        sbb BH, 0
            ;(c+d)-(a+d)+b
        add BX, [b]
        adc BH, 0
        
        ;(a-b)+(c-b-d)+d
            ;a
        mov AL, [a]
        cbw
            ;a-b
        sub AX, [b]
        sbb AH, 0
        mov BX, AX
            ;c
        mov AL, [c]
        cbw
            ;c-b
        sub AX, [b]
        sbb AH, 0
            ;c-b-d
        sub AX, [d]
        sbb AH, 0
            ;(a-b)+(c-b-d)
        add BX, AX
        adc BH, 0
            ;(a-b)+(c-b-d)+d
        add BX, [d]
        adc BH, 0
        
        ;(c-a-d)+(c-b)-a
            ;c
        mov AL, [c]
        cbw
            ;c-a
        sub AX, [a]
        sbb AH, 0
            ;c-a-d
        sub AX, [d]
        sbb AH, 0
        mov BX, AX
            ;c
        mov AL, [c]
        cbw
            ;c-b
        sub AX, [b]
        sbb AH, 0
            ;(c-a-d)+(c-b)
        add BX, AX
        add BH, 0
            ;(c-a-d)+(c-b)-a
        sub BX, [a]
        sbb BH, 0
        
        ;(a+b)-(a+d)+(c-a)
            ;a
        mov AL, [a]
        cbw
            ;a+b
        add AX, [b]
        adc AH, 0
        mov BX, AX
            ;a
        mov AL, [a]
        cbw
            ;a+d
        add AX, [d]
        adc AH, 0
            ;(a+b)-(a+d)
        sub BX, AX
        sbb BH, 0
            ;c
        mov AL, [c]
        cbw
            ;c-a
        sub AX, [a]
        sbb AH, 0
            ;(a+b)-(a+d)+(c-a)
        add BX, AX
        adc AH, 0
        
        ;c-(d+d+d)+(a-b)
            ;c
        mov AL, [c]
        cbw
        mov BX, AX
            ;d+d+d
        mov AL, [d]
        cbw
        add AX, [d]
        adc AH, 0
        add AX, [d]
        adc AH, 0
            ;c-(d+d+d)
        sub BX, AX
        sbb BH, 0
            ;a
        mov AL, [a]
        cbw
            ;a-b
        sub AX, [b]
        sbb AH, 0
            ;c-(d+d+d)+(a-b)
        add BX, AX
        adc BH, 0
        
        ;(a+b-d)+(a-b-d)
            ;a
        mov AL, [a]
        cbw
            ;a
        add AX, [b]
        adc AH, 0
            ;a+b-d
        sub AX, [d]
        sbb AH, 0
        mov BX, AX
            ;a
        mov AL, [a]
        cbw
            ;a-b
        sub AX, [b]
        sbb AH, 0
            ;a-b-d
        sub AX, [d]
        sbb AH, 0
            ;(a+b-d)+(a-b-d)
        add BX, AX
        adc BH, 0
        
        (d+d-b)+(c-a)
            ;d
        mov AL, [d]
        cbw
            ;d+d
        add AX, [d]
        adc AH, 0
            ;d+d-b
        sub AX, [b]
        sbb AH, 0
        mov BX, AX
            ;c
        mov AL, [c]
        cbw
            ;c-a
        sub AX, [a]
        sbb AH, 0
            ;(d+d-b)+(c-a)
        add BX, AX
        adc BH, 0
            ;(d+d-b)+(c-a)
        add BX, [d]
        adc BH, 0
        
        ;(a+d+d)-c+(b+b)
        ;(a+c-d) +d - (b+b-c)
        ;2-(c+d)+(a+b-c)
        ;a+b-c+d-(a-d)
        ;(a+d-c)-(b+b)
        ;a-b-d+2+c+(10-b)
        ;a+13-c+d-7+b
        ;(a+a-c)-(b+b+b+d)
        ;d-(a+b)+c
        ;d-(a+b)-c
        ;(a+a)-(c+b+d)
        ;(a-b)+(d-c)
        ;(a+b+b)-(c+d)
        ;(a-c)+(b+b+d)
        ;(a-b-b-c)+(a-c-c-d)
        ;(c+d+d)-(a+a+b)
        ;(a+a)-(b+b)-c
        ;(a+b-c)-(a+d)
        ;a+b-c+d
        ;(b+c)+(a+b-d)
        ;d-(a+b)-(c+c)
    
	push dword 0 ;se pune pe stiva codul de retur al functiei exit
	call [exit] ;apelul functiei sistem exit pentru terminarea executiei programului	
