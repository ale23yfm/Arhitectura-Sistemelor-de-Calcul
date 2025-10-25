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
	c dd 30
    x resq 1
    y resq 1
    
segment  code use32 class=code ; segmentul de cod
start: 

    ;(d+a)-(c-b)-(b-a)+(c+d)  
    
    ;a
    MOV AL, [a]
    cbw
    cwd
    cwde
    cdq
    
    ;d+a
    ADD EAX, [d]
    ADC EDX, [d+4]
    
    ;x=d+a
    MOV dword [x], 0
    MOV dword [x+4], 0
    MOV dword [x], EAX      
    MOV dword [x+4], EDX
    
    ;c
    MOV EAX, 0
    MOV EDX, 0
    MOV EAX, [c]
    cdq
    
    ;y=c
    MOV dword [y], 0
    MOV dword [y+4], 0
    MOV dword [y], EAX      
    MOV dword [y+4], EDX
    
    ;b
    MOV EAX, 0
    MOV EDX, 0
    MOV AX, [b]
    cdq
    
    ;y=c-b
    SUB dword [y], EAX
    SBB dword [y+4], EDX ;carry
    
    ;(d+a)-(c-b)
    MOV EAX, 0
    MOV EDX, 0
    MOV EAX, dword [x]
    MOV EDX, dword [x+4]

    SUB EAX, dword [y]
    SBB EDX, dword [y+4] ; Carry
    
    ;x=(d+a)-(c-b)
    MOV dword [x], 0
    MOV dword [x+4], 0
    MOV dword [x], EAX      
    MOV dword [x+4], EDX
    
    ;b
    MOV EAX, 0
    MOV EDX, 0
    MOV AX, [b]
    cdq
    
    ;y=b
    MOV dword [y], 0
    MOV dword [y+4], 0
    MOV dword [y], EAX      
    MOV dword [y+4], EDX
    
    ;a
    MOV EAX, 0
    MOV EDX, 0
    MOV AL, [a]
    cbw
    cwd
    cwde
    cdq
    
    ;y=b-a
    SUB dword [y], EAX
    SBB dword [y+4], EDX ;carry
      
    ;(d+a)-(c-b)-(b-a)
    MOV EAX, 0
    MOV EDX, 0
    MOV EAX, dword [x]
    MOV EDX, dword [x+4]
    
    SUB EAX, dword [y]
    SBB EDX, dword [y+4] ; Carry
    
    ;x=(d+a)-(c-b)-(b-a)
    MOV dword [x], 0
    MOV dword [x+4], 0
    MOV dword [x], EAX      
    MOV dword [x+4], EDX
    
    ;c
    MOV EAX, 0
    MOV EDX, 0
    MOV EAX, [c]
    cdq
    
    ;c+d
    ADD EAX, [d]
    ADC EDX, [d+4]
    
    ;y=c+d
    MOV dword [y], 0
    MOV dword [y+4], 0
    MOV dword [y], EAX      
    MOV dword [y+4], EDX
    
    ;(d+a)-(c-b)-(b-a)+(c+d)    
    MOV EAX, 0
    MOV EDX, 0
    MOV EAX, dword [x]
    MOV EDX, dword [x+4]
    
    ADD EAX, dword [y]
    ADC EDX, dword [y+4] ; Carry
    
	push dword 0 ;se pune pe stiva codul de retur al functiei exit
	call [exit] ;apelul functiei sistem exit pentru terminarea executiei programului	
