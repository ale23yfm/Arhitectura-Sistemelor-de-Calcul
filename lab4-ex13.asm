bits 32 ;asamblare si compilare pentru arhitectura de 32 biti
; definim punctul de intrare in programul principal
global  start 

extern  exit ; indicam asamblorului ca exit exista, chiar daca noi nu o vom defini
import  exit msvcrt.dll; exit este o functie care incheie procesul, este definita in msvcrt.dll
        ; msvcrt.dll contine exit, printf si toate celelalte functii C-runtime importante
segment  data use32 class=data ; segmentul de date in care se vor defini variabilele 
	a db 1
	b db 2
	c db 3
	d db 4
    ;01020304
    
    
segment  code use32 class=code ; segmentul de cod
start: 
    ;Giving 4 bytes, obtain in AX the sum of the integers represented by bits 4-6 of the 4 bytes.
    mov AX, 0
    ;MOV BX, [A] is 0201h from memory
    mov BL, [a] ; is 01
    and bl, 0111_0000b
    shr BX, 4
    mov BH, 0 ; conversion to BX
    add AX, BX ; OR add al, bl and adc ah, 0
    
	push dword 0 ;se pune pe stiva codul de retur al functiei exit
	call [exit] ;apelul functiei sistem exit pentru terminarea executiei programului	
