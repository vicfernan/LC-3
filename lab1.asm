		.ORIG x3000

		LDI R1, XVALUE        ; R1 = X

		ADD R1, R1, #0        ; check if X is negative
		BRzp X_OK             ; if X >= 0, skip fix
		NOT R1, R1            ; invert bits
		ADD R1, R1, #1        ; +1 -> absolute value
X_OK	STI R1, XABS          ; store |X|

		LDI R2, YVALUE        ; R2 = Y

		ADD R2, R2, #0        ; check if Y is negative
		BRzp Y_OK             ; if Y >= 0, skip fix
		NOT R2, R2            ; invert bits
		ADD R2, R2, #1        ; +1 -> absolute value
Y_OK	STI R2, YABS          ; store |Y|

		AND R3, R3, #0        ; result = 0
		ADD R4, R2, #0        ; counter = |Y|

MULT	ADD R4, R4, #0        ; set CC from counter
		BRz END               ; if counter = 0, stop
		ADD R3, R3, R1        ; result += |X|
		ADD R4, R4, #-1       ; counter--
		BRnzp MULT            ; repeat

END		STI R3, RESULT        ; store result
		HALT

XVALUE	.FILL x3120
YVALUE	.FILL x3121
XABS	.FILL x3122
YABS	.FILL x3123
RESULT	.FILL x3124


		.BLKW x0106		; fill space so data starts at x3120

X		.FILL xFFF6
Y		.FILL x0000
ABSX	.BLKW 1
ABSY	.BLKW 1
PROD	.BLKW 1

		.END
