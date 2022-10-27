@ The two numbers we want to add
num1:       .word   0x40d00000 @ num1
num2:       .word   0x3fe00800 @ num2
expmask:    .word   0x807FFFFF
fracmask:   .word   0xFF800000
leadingnum: .word   0x00800000

.text
.global main
main:
    @ Load numbers
    LDR r0, num1 @loader fra num1 til r0
    LDR r1, num2
    LDR r2, expmask
    LDR r3, fracmask
    @ ! Perform addition here !
    BIC r4, r0, r2 @ exponent
    BIC r5, r1, r2 @ exponent
    BIC r6, r0, r3 @ fraction
    BIC r7, r1, r3 @ fraction

    @ Exp calculations
    CMP r4, r5
    SUBGE r2, r4, r5 
@   If (r4 >= r5){
@       r2 = r4 - r5;
@   }
    SUBLT r2, r5, r4 
@   If (r4 < r5) {
@   r2 = r5 - r4;
@   }

    ADDGE r5, r5, r2 
@   If r4 >= r5 {
@       r5 = r5 - r2;
@   }
    ADDLT r4, r4, r2 
@   If (r4 < r5) {
@   r4 = r4 - r2;
@   }

    @ matrissa calculations
    LDR r0, leadingnum @ load
    ADD r6, r6, r0 @ r6 = r6 + num1
    ADD r7, r7, r0 @ r7 = r7 + num1

    @gjør r2 til vanlig tall og shifter den inn
    ASR r2, #23 
    LSRLT r6, r2
    LSRGE r7, r2


    ADD r8, r6, r7
    @ Must check if leading num became larger than 1, then correct
    CMP r8, r0
    LSRGE r8, r8, #1
    ADDGE r5, #1
    ADD r0, r5, r8

    @ When done, return
    BX lr
