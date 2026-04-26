		.ORIG x3000

START	LEA R0, PROMPT			; load prompt address
		PUTS					; print prompt
		LD R0, NEWLINE			; load newline
		OUT						; print newline

		GETC					; get char
		OUT						; Print char
		LD R1, NEG48			; Get value of -48
		ADD R2, R0, R1			; Add value of number
		BRn BAD					; If negative -> error

		LD R1, NEG54			; Get value -54
		ADD R2, R0, R1			; Add de number and if positive >6
		BRp BAD					; If positive -> error

		LEA R3, SUNDAY			; load first day on R3
		LD R4, NEG48			; r4 = -48

CHECK	ADD R5, R0, R4			; R5 = Input number - 48
		BRz MATCH				; If 0, found!
		ADD R4, R4, #-1			; R4 += 1
		LD R6, TEN				; R6 = 10 (size of the strings)
		ADD R3, R3, R6			; R3 first char of next day
		BRnzp CHECK

MATCH	LD R0, NEWLINE			; Load R0 -> NL
		OUT						; Print NL
		ADD R0, R3, #0			; R0 = string
		PUTS					; Print the entire string
		LD R0, NEWLINE			; R0 = NL
		OUT						; Print NL
		BRnzp START

BAD		LD R0, NEWLINE			; R0 = NL
		OUT						; print
		LEA R0, ERRMSG			; R0 = string for error
		PUTS					; print it
		LD R0, NEWLINE			; r0 = NL
		OUT						; print NL
		HALT

PROMPT	.STRINGZ "Please enter a number 0 through 6"
ERRMSG	.STRINGZ "Your number does not match a day of the week"

SUNDAY		.STRINGZ "Sunday   "
MONDAY		.STRINGZ "Monday   "
TUESDAY		.STRINGZ "Tuesday  "
WEDNESDAY	.STRINGZ "Wednesday"
THURSDAY	.STRINGZ "Thursday "
FRIDAY		.STRINGZ "Friday   "
SATURDAY	.STRINGZ "Saturday "

NEG48	.FILL xFFD0
NEG54	.FILL xFFCA
TEN		.FILL #10
NEWLINE	.FILL x000A

		.END
