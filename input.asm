.orig x3000

start 	st r1, saver1
	st r2, saver2
	st r3, saver3

	ld	r2, newline
L1	ldi	r3, DSR
	BRzp	L1
	sti	r2, DDR

	lea	r1, prompt
	
loop	ldr	r0, r1, #0
	BRz	input
L2	ldi	r3, DSR
	BRzp	L2
	STI	R0, DDR

	ADD 	r1, r1, #1
	BRnzp	loop

input	ldi	r3, KBSR
	BRzp	input
	ldi	r0, KBDR
L3	ldi	r3, DSR
	BRzp	L3
	sti	r0, DDR

L4	ldi	r3, DSR
	BRzp	L4
	sti	r2, DDR
	ld	r1, saver1
	ld	r3, saver3
	RET

saver1	.blkw	1
saver2	.blkw	1
saver3	.blkw	1
DSR	.fill	xfe04
DDR	.fill	xfe06
KBSR	.fill	xfe00
KBDR	.fill	xfe02
newline	.fill	x000a
prompt	.stringz	"Input a character: "

.end