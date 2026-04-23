;========================================================
; Name: Victor Fernandez Barrado
; Created Date: 04/23/2026
; Last modified: 04/23/2026
; Class: EGR 212
; Program: Major Project 2
; File name: MajorPro2.asm
;
; Summary:
; This program prompts the user to enter a sentence
; terminated by Enter, stores up to 30 characters,
; and then accepts one-letter commands:
; p = print sentence
; r = print sentence in reverse
; c = print number of characters
; w = print number of words
; n = enter a new sentence
; x = exit
;
; Notes / assumptions:
; - Sentence is terminated by Enter.
; - Up to 30 chars are stored.
; - Sentence is stored as a zero-terminated string.
; - Counts can be printed in hex or decimal.
;========================================================

		.ORIG x3000

;========================
; MAIN PROGRAM
;========================
MAIN
		JSR SHOW_FIRST_PROMPT
		JSR GET_SENTENCE

COMMAND_LOOP
		JSR SHOW_COMMAND_PROMPT
		JSR GET_COMMAND          ; command returned in R0

        ; compare command in R0 to p, r, c, w, n, x

		LD  R1, NEGP
		ADD R2, R0, R1
		BRz DO_P

		LD  R1, NEGR
		ADD R2, R0, R1
		BRz DO_R

		LD  R1, NEGC
		ADD R2, R0, R1
		BRz DO_C

		LD  R1, NEGW
		ADD R2, R0, R1
		BRz DO_W

		LD  R1, NEGN
		ADD R2, R0, R1
		BRz DO_N

		LD  R1, NEGX
		ADD R2, R0, R1
		BRz DO_X

		; illegal command
		JSR PRINT_ILLEGAL
		BRnzp COMMAND_LOOP

DO_P
		JSR PRINT_NEWLINE
		JSR PRINT_SENTENCE
		BRnzp COMMAND_LOOP

DO_R
		JSR PRINT_NEWLINE
		JSR PRINT_REVERSE
		BRnzp COMMAND_LOOP

DO_C
		JSR PRINT_NEWLINE
		JSR COUNT_CHARS          ; result maybe in R0
		JSR PRINT_NUMBER
		BRnzp COMMAND_LOOP

DO_W
		JSR PRINT_NEWLINE
		JSR COUNT_WORDS          ; result maybe in R0
		JSR PRINT_NUMBER
		BRnzp COMMAND_LOOP

DO_N
		BRnzp MAIN

DO_X
		HALT

;========================
; SUBROUTINES
;========================

;----------------------------------------
; SHOW_FIRST_PROMPT
; prints:
; Enter a sentence terminated by Enter
; > 
;----------------------------------------
SHOW_FIRST_PROMPT
		LEA R0, PROMPT1
		PUTS
		LEA R0, PROMPT1B
		PUTS
		RET

;----------------------------------------
; GET_SENTENCE
; reads chars until Enter
; stores sentence in SENTENCE
; zero-terminates the string
;----------------------------------------
GET_SENTENCE
		; save registers if needed

		LEA R1, SENTENCE         ; pointer to sentence buffer

READ_SENT_CHAR
		GETC
		; optional echo:
		OUT

		; check for Enter
		LD  R2, NEGENTER
		ADD R3, R0, R2
		BRz END_SENTENCE

		; store char
		STR R0, R1, #0
		ADD R1, R1, #1
		BRnzp READ_SENT_CHAR

END_SENTENCE
		AND R0, R0, #0
		STR R0, R1, #0           ; store zero terminator
		RET

;----------------------------------------
; SHOW_COMMAND_PROMPT
; prints:
; newline
; Enter command >
;----------------------------------------
SHOW_COMMAND_PROMPT
		JSR PRINT_NEWLINE
		LEA R0, PROMPT2
		PUTS
		RET

;----------------------------------------
; GET_COMMAND
; reads one command char into R0
; echoes the command
;----------------------------------------
GET_COMMAND
		GETC
		OUT
		RET

;----------------------------------------
; PRINT_SENTENCE
; prints the stored sentence
;----------------------------------------
PRINT_SENTENCE
		LEA R1, SENTENCE

PS_LOOP
		LDR R0, R1, #0
		BRz PS_DONE
		OUT
		ADD R1, R1, #1
		BRnzp PS_LOOP

PS_DONE
		RET

;----------------------------------------
; PRINT_REVERSE
; find end of sentence, then print backward
;----------------------------------------
PRINT_REVERSE
		; to do
		RET

;----------------------------------------
; COUNT_CHARS
; count chars in sentence
; return count in R0
;----------------------------------------
COUNT_CHARS
		; to do
		RET

;----------------------------------------
; COUNT_WORDS
; count words in sentence
; return count in R0
;----------------------------------------
COUNT_WORDS
		; to do
		RET

;----------------------------------------
; PRINT_NUMBER
; prints number in R0
; can be hex or decimal
;----------------------------------------
PRINT_NUMBER
		; to do
		RET

;----------------------------------------
; PRINT_ILLEGAL
; prints:
; newline
; Illegal Command
;----------------------------------------
PRINT_ILLEGAL
		JSR PRINT_NEWLINE
		LEA R0, ILLEGALMSG
		PUTS
		RET

;----------------------------------------
; PRINT_NEWLINE
;----------------------------------------
PRINT_NEWLINE
		LD  R0, NEWLINE
		OUT
		RET

;========================
; DATA
;========================

PROMPT1		.STRINGZ "Enter a sentence terminated by Enter"
PROMPT1B	.STRINGZ "\n> "
PROMPT2		.STRINGZ "Enter command > "
ILLEGALMSG	.STRINGZ "Illegal Command"

SENTENCE	.BLKW 31             ; 30 chars + zero terminator

NEWLINE		.FILL x000A
ENTER		.FILL x000A
NEGENTER	.FILL xFFF6          ; -10

NEGP		.FILL xFF90          ; -'p'
NEGR		.FILL xFF8E          ; -'r'
NEGC		.FILL xFF9D          ; -'c'
NEGW		.FILL xFF89          ; -'w'
NEGN		.FILL xFF92          ; -'n'
NEGX		.FILL xFF88          ; -'x'

SPACE		.FILL x0020
NEGSPACE	.FILL xFFE0

			.END
