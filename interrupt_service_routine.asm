	.orig x2000

	and r2, r2, #0		; initialize r2
	add r2, r2, #10		; r2 is a counter to 10

print	ldi R0, KBDR		; Load inputted character (ASCII hex) into R0

dis_stat
	ldi R1, DSR		; check the display status
				; if the program is ready 
				; for printing out the char

	BRzp dis_stat		; loop until ready

; ****** print out char ******
	sti R0, DDR		; print out the typed char
				; if the status is enabled

	add R2, R2, #-1		; r2 minus itself by 1
	BRp print		; if it's above 0, continue printing

	BRn TRANS		; once the program is done printing
				; the type char, go to TRANS

; ****** after the printing ******
				
	ld R0, enter		; r0 turns into ASCII 'enter'
	BRzp dis_stat		; to print out new line 
				; after printing out 10 typed chars


TRANS	add R3, R3, #1		; let r3 be a mask for AND check

	and R0, R3, #1		; determine whether r0 is odd or even
				; if it is odd, then print hashtag
				; if it is even, then print star

	BRnp hashtag		; if it's 1, that means it's odd, print crosses



star	add R4, R4, #-7		; print lines of stars	
				; if the crosses are printed previously,
				; then r4 goes up seven addresses from hastag
				; to get to the start of star string.

	BRnzp clear		; jump to clear after start.



hashtag	add R4, R4, #7		; print lines of hashtag
				; if the stars are printed previously,
				; then r4 goes down seven addresses from star
				; to get to the start of hashtag string.


clear	add R0, R4, #0		; get out of the interrupt system as a result
				; waiting for the next key being typed 
				; for operation

	 RTI

DSR	.FILL 	xFE04
DDR	.FILL 	xFE06
KBDR 	.FILL	xFE02

enter   .FILL	#10 

	.end
