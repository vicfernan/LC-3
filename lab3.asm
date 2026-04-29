		.ORIG x3000

		LD   R0, XPTR       ; R0 = address of X
		LDR  R1, R0, #0     ; R1 = X

		LD   R0, YPTR       ; R0 = address of Y
		LDR  R2, R0, #0     ; R2 = Y

		AND  R3, R3, #0     ; R3 = Z = 0
		ADD  R4, R1, #0     ; R4 = R = X

		NOT  R5, R2
		ADD  R5, R5, #1     ; R5 = -Y

LOOP	ADD  R4, R4, R5     ; R = R - Y
		ADD  R3, R3, #1     ; Z = Z + 1
		ADD  R6, R4, #0     ; set CC from R4
		BRzp LOOP           ; keep going while R >= 0

		ADD  R4, R4, R2     ; fix remainder
		ADD  R3, R3, #-1    ; fix quotient

STORE	LD   R0, ZPTR       ; R0 = address of Z
		STR  R3, R0, #0     ; store Z

		LD   R0, RPTR       ; R0 = address of R
		STR  R4, R0, #0     ; store R

		HALT

XPTR	.FILL X
YPTR	.FILL Y
ZPTR	.FILL Z
RPTR	.FILL R

X		.FILL x00B7
Y		.FILL x0002
Z		.BLKW 1
R		.BLKW 1

		.END
