 .386
.model flat, stdcall
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;includem biblioteci, si declaram ce functii vrem sa importam
includelib msvcrt.lib
extern exit: proc
extern printf: proc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;declaram simbolul start ca public - de acolo incepe executia
public start
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;sectiunile programului, date, respectiv cod
.data
;aici declaram date
vec dw 15, 2, 3, 6, 11, 12, 14, 7, 22, 19
format db "%d " , 0
nr dd 10
sum db 0
.code
start:
;$1 - index
;$2 - nr de elemente
;$3 - ecx / suma
;$4 - ax 
;$6 - elementul 1 care ajuta la aflarea paritatii
;$7 - and

	;Algoritul ales calculeaza suma elementelor impare de pe pozitii pare dintr-un sir dat.
	
	;0: addi $6, $0, 1 -- b"001_000_110_0000001" --2301 
	;1: lw $2, $0, 10 -- b"010_ 0 00_01 0_0001010" --410A 
	mov esi ,0  ;2: sub $1 , $1 , $1 --b"000_0 01_00 1_001_0_000" --0490       [initializez index-ul la 0]
	xor ecx, ecx  ;3: sub $3 ,  $3 ,  $3 --b"000_011_011_011_0_000" --0DB0     [initializez registrul pentru suma la 0]
	
	for_loop:
	xor eax,eax   ;4: sub $4 ,  $4 ,  $4 --b"000_100_100_100_0_000" --1240     [initializez registrul 4 -pentru memorarea elementelor- la 0]
	mov ax , vec[esi*2]  ;5: lw $4 , $1, 0 -- b"010_001_100_0000000" --4600    [memorez in registrul 4 fiecare element de pe pozitie para]
	
	and eax, 1 ;6: and $7 , $4, $6 --b"000_100_110_111_0_100" --1374           [se verifica daca numarul e impar]
	jz peste ;7: beq $7, $0, 1  --b"111_000_111_0000001" --E381                [in cazul in care e par se sare peste adaugarea in suma in registrul 3]
	
	mov ax , vec[esi*2]                                                       
	
	add ecx, eax ;8: add $3, $3, $4 --b"000_011_100_011_0_001" --0E31          [adun la registrul pentru suma elementului din eax daca in registrul 4 e nr impar]
	
	peste:
	
	add esi, 2 ;9: addi $1 , $1 , 2 --b"001_0 01_00 1_000 0010"  --2482        [incrementez registrul index cu 2]
			   ;10: beq $1 , $2 , 1 --b"111_0 10_00 1_0000001" --E881          [in cazul in care s-a ajuns la nr de elemente se iese din bucla]
	cmp esi , nr 
	jne for_loop  ;11: j 4 --b"100_0 00000000 0100" --8004                     [compar daca registrul index a ajuns la valoarea numarului de numere]
	                                                                          ;[In caz negativ sar la instructiunea 4]
	;12: sw $3, $0, 10 --b"101_0 00_011_0001011" --A18B
	
	push ecx
	push offset format
	call printf
	add esp , 8
	
	push 0
	call exit
end start
