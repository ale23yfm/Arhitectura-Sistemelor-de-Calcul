bits 32 ;asamblare si compilare pentru arhitectura de 32 biti
; definim punctul de intrare in programul principal
global  start 

extern  exit ; indicam asamblorului ca exit exista, chiar daca noi nu o vom defini
import  exit msvcrt.dll; exit este o functie care incheie procesul, este definita in msvcrt.dll
        ; msvcrt.dll contine exit, printf si toate celelalte functii C-runtime importante
segment  data use32 class=data ; segmentul de date in care se vor defini variabilele 
	
    
    
segment  code use32 class=code ; segmentul de cod
start: 
    ;Perform the calculations and analyze the results
        ;1+9
    mov AL, 1
    add AL, 9
    
        ;1+15
    mov AL, 1
    add AL, 15
    
        ;128+128
    mov AX, 128
    add AX, 128
    
        ;5-6
    mov AL, 5
    sub AL, 6
    
        ;10/4
    mov AL, 10
    mov AH, 0
    mov Bl, 4
    div BL
    
        ;256*1
    mov AL, 1
    cbw
    mov BX, AX
    mov AX, 256
    mul BX
    
        ;256/1
    mov AH, 0
    mov AL, 1
    cbw
    mov BX, AX
    mov AX, 256
    div BX
    
        ;128+127
    mov AL, 128
    add AL, 127 
    
        ;3*4
    mov AL, 3
    mov BL, 4
    mul BL
    
        ;9+7
    mov AL, 9
    add AL, 7
    
        ;128*2
    mov AL, 2
    cbw
    mov BX, AX
    mov AX, 128
    mul BX
    
        ;4-5
    mov AL, 4
    sub AL, 5
    
        ;2+8
    mov AL, 2
    add AL, 8
    
        ;-2*5
    mov AL, -2
    mov BL, 5
    mul BL
    
        ;6*3
    mov AL, 6
    mov BL, 3
    mul BL
    
        ;4*4
    mov AL, 4
    mul AL
    
        ;14+2
    mov AL, 14
    add AL, 2
    
        ;127+129
    mov AX, 127
    add AX, 129
    
        ;12/4
    mov AH, 0
    mov AL, 12
    mov BL, 4
    div BL
    
        ;13/3
    mov AH, 0
    mov AL, 13
    mov BL, 3
    div BL

        ;15/3
    mov AH, 0
    mov AL, 15
    mov BL, 3
    div BL
    
        ;16/4
    mov AH, 0
    mov AL, 16
    mov BL, 4
    div BL
    
        ;256*1
    mov AL, 1
    cbw
    mov BX, AX
    mov AX, 256
    mul BX
    
        ;256/1
    mov AL, 1
    cbw
    mov BX, AX
    mov AX, 256
    div BX
    
        ;64*4
    mov AL, 64
    cbw
    mov BX, AX 
    mov AL, 4
    cbw
    div BX  
    
        ;3-4
    mov AL, 3
    sub AL, 4
    
        ;4+12
    mov AL, 4
    add AL, 12
    
        ;13/5
    mov AH, 0
    mov AL, 13
    mov BL, 5
    div BL
    
        ;14/6
    mov AH, 0
    mov AL, 14
    mov BL, 6
    div, BL
    
        ;11+5
    mov AL, 11
    add AL, 5
    
	push dword 0 ;se pune pe stiva codul de retur al functiei exit
	call [exit] ;apelul functiei sistem exit pentru terminarea executiei programului	
