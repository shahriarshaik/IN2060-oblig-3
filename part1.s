
.text
.global main

main:
    MOV r0, #13 @ N
    MOV r1, #0  @ current
    MOV r2, #1  @ previous
    MOV r3, #0  @ temporary

loop:
	CMP r0, #0 @ if r0 = 0
	BEQ exit @  hopper til exit
		
	MOV r3, r1 @ temporary = current
	ADD r1, r2, r1 @ current = previous + current
	MOV r2, r3 @ previous = temporary
	SUB r0, #1 @ n = n - 1
    B loop @ while, sender den opp igjen for å bli sjekka om den er = null, begge de funker sammen som while n > 0: 
exit:
    MOV r0,r1 @ vi flytter r1 til r0 fordi r0 kan retunerer
    BX lr