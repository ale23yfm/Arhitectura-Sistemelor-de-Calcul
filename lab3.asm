bits 32 ;asamblare si compilare pentru arhitectura de 32 biti
; definim punctul de intrare in programul principal
global  start 

extern  exit ; indicam asamblorului ca exit exista, chiar daca noi nu o vom defini
import  exit msvcrt.dll; exit este o functie care incheie procesul, este definita in msvcrt.dll
        ; msvcrt.dll contine exit, printf si toate celelalte functii C-runtime importante
segment  data use32 class=data ; segmentul de date in care se vor defini variabilele 
	d dq 50
	a db 20
	b dw 10
	c dd 10
    
segment  code use32 class=code ; segmentul de cod
start: 
;(d+d)-(a+a)-(b+b)-(c+c)  
    ;d+d
    MOV EAX, 0
    MOV EAX, [d+0]
    MOV EDX, [d+4]
    ADD EAX, [d+0]
    ADC EDX, [d+4]
    
    ;a+a
    MOV EBX,0
    MOV BL, [a]         
    ADD BL, [a]         
    MOV BH, 0           ;BX
    
    ;(d+d)-(a+a)
    SUB EAX, EBX
    SBB EDX, 0
    
    ;b+b 
    MOV EBX,0   
    MOV BX, 0
    MOV BX, [b]
    ADD BX, [b]
    
    ;(d+d)-(a+a)-(b+b)
    SUB EAX, EBX
    SBB EDX, 0
    
    ;c+c
    MOV ECX, 0
    MOV CX, [c]
    ADD CX, [c]
    MOV CH, 0
    
    ;(d+d)-(a+a)-(b+b)-(c+c)
    SUB EAX, EBX
    SBB EDX, 0
    
	push dword 0 ;se pune pe stiva codul de retur al functiei exit
	call [exit] ;apelul functiei sistem exit pentru terminarea executiei programului	
