	.orig x3000

SETUP	ld R6, origin		; initialize r6 with x3000, the starting 
				; point of the user interface

	ld R2, key_stat		; intiialize r2 with the current status 
				; of the display system.


	ld R7, interrupt  	; initialize r7 with address to x2000, 
				; which is the address of the lc
				; start of interrupt service routine


	sti R7, interlo		; Store x2000 into x0180
				; the starting address of the
				; vector table plus
				; the interrupt vector for the keyboard




	lea R4, check_star	; r4 contains address of the first pattern

	sti R2, DSR 		; keyboard interruption activation
	
;-----------printing stars eight times-----------------

BEGIN_8
	and R0, R0, #0 		; intialize R0
	add R0, R0, #10 	; R0 becomes 'enter' in ASCII code
				; meaning that a new line is generated
	trap x21		; PUT at a new line based on the value of R0

	jsr DELAY		; delay slow down

	and R5, R5, #0		; initialize R5
	add R5, R5, #8  	; R5 count to eight
	add R0, R4, #0 		; R0 now has the address of the checkerboard pattern


EIGHT	trap x22		; print symbols

	add R5, R5 #-1		; Decrement the counter
	BRnp EIGHT		; If counter isn't zero, print again



; ****** TRANSITION: printing format change: from 8 symbols to 7 symbols ******


BEGIN_7
	and R0, R0, #0		; initialize R0
	add R0, R0, #10		; R0 stands for 'enter' in ASCII
				; meaning that a new line is created
	trap x21		; PUT a new line based on the value of R0

				
				; print the 3 empty space at very beginning
				; of a seven-symbol code line

	and R0, R0, #0		; Clear R0
	ld R0, space
	trap x21		; write out the char above
	trap x21		; which is spacebar
	trap x21

	jsr DELAY	 	; delay slow down

	add R5, R5, #7		; R5 count to 7
	add R0, R4, #0		; Transfer the address of pattern into R0


;-----------printing symbols seven times------------

SEVEN	TRAP x22		; print the symbol
	ADD R5, R5, #-1		; decrement counter for every symbol printed

	BRz BEGIN_8		; if the count is 0, jump back to TOP and do 
				; the eight-symbol print

	BRnp SEVEN 		; ...otherwise, loop back to AGAINST
				; and continue the seven-symbol print


STOP	trap x25		; halts program

; * SUBROUTINE *

; Delay subroutine: used to slow down the checkboard printing speed
; so that user can accurately see the interrupt key which he or she
; strike on the keyboard


DELAY	ST R1, SaveR1
	LD R1, COUNT

REP 	ADD R1, R1, #-1
	BRp REP
	LD R1, SaveR1
	RET


COUNT .FILL x6000			; use x6000 as a buffering number
					; for the delay subroutine
					; to slow down the speedy process
					; of pattern printing
SaveR1 .BLKW 1


check_star .stringz "**    "		; checkerboard star 
check_hash .stringz "##    "		; checkerboard hashtag

origin    .FILL x3000

DSR       .FILL xFE00

interrupt .FILL x2000 		; address of interupt service routine

key_stat  .FILL x4000;		; Changing the 14th bit in KBSR

interlo   .FILL x0180;		

space     .FILL #32



	.end
