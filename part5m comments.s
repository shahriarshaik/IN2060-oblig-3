@ The two numbers we want to add
num1:       .word   0x3F800000 @ num1
num2:       .word   0x3F800000 @ num2
expmask:    .word   0x807FFFFF
fracmask:   .word   0xFF800000
leadingnum: .word   0x00800000

.text
.global main
main:
    @ Load numbers
    LDR r0, num1
    LDR r1, num2
    LDR r2, expmask
    LDR r3, fracmask
    @ Extract exponent and fraction bits.
    BIC r4, r0, r2 @ num1 exp
    BIC r5, r1, r2 @ num2 exp
    BIC r6, r0, r3 @ num1 frac
    BIC r7, r1, r3 @ num2 frac

    @ Compare exponents and adjust exponent if necessary.
    CMP r4, r5
    SUBGE r2, r4, r5 @ If r4 >= r5 {r2 = r4 - r5}
    SUBLT r2, r5, r4 @ If r4 < r5 {r2 = r5 - r4}

    ADDGE r5, r5, r2 @ If r4 >= r5 {r5 = r5 - r2}
    ADDLT r4, r4, r2 @ If r4 < r5 {r4 = r4 - r2}

    @ Step 2: matrissa calculations
    LDR r0, leadingnum
    ADD r6, r6, r0 @ adding leadingnum to frac
    ADD r7, r7, r0 @ adding leadingnum til frac

    @ Step 4: shift smaller mantissa if necessary
    ASR r2, r2, #23 @ difference between num1 exp and num2 exp, but in binary
    @ Logic shift the lowest num to right, by as many steps as r2
    LSRLT r6, r6, r2
    LSRGE r7, r7, r2

    @ Step 5: add mantissas
    ADD r8, r6, r7
    @ Must check if leading num became larger than 1, then correct
    CMP r8, r0
    LSRGE r8, r8, #1
    ADDGE r5, #1
    ADD r0, r5, r8
    SUB



    @ When done, return
    BX lr
