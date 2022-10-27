.text
.global main
fib:
	MOV r0, #13 @N
	MOV r1, #0  @current
	MOV r2, #1  @previous
	MOV r3, #0  @temporary
	loop:
		CMP r0, #0
		BEQ exit	
		MOV r3, r1
		ADD r1, r2, r1
		MOV r2, r3
		SUB r0, #1
		B loop
	exit:
		MOV r0,r1
		BX lr
main:
	MOV r0, #13
	PUSH {lr}
	BL fib
    MOV r0, r1
    LDR r0, = output_string
    BL printf
	POP {lr}
    BX lr
.data
output_string:
    .asciz "%d\n"
