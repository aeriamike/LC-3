.ORIG x3000

;Calling Routine         ;Main Calling function

	JSR InSub        ;Jumps to InSub subroutine
	JSR REVERSE      ;Jumps to Reverse subroutine
	AND R6, R6, #0   ;Clears R6 to be used as a counter
	ADD R6, R6, #1	 ;R6 set to 1, to be used to show if name is found or not	
	LD R1, ListPTR   ;loads the address of the first node into R1
MAIN1	LEA R3, INPUT    ;loads the head address of input string into R3
	ADD R2, R1, #2   ;increments R2 so it can point to the first name of the current node
	LDR R2, R2, #0   ;loads the head address of the string of the first name
	JSR COMPARE      ;jumps to compare subroutine
	BRz MAIN2	 ;if string isnt matched, skip to MAIN2
	JSR PRINT        ;jumps to Print subroutine
	AND R6, R6, #0   ;Sets the R6 counter to 0 indicating that a name has been found
	BRnzp MAIN3	 ;automatically skip to MAIN3
MAIN2   ADD R2, R1 #3    ;Increments R2 so it can point to last name
	LDR R2, R2, #0   ;Loads head string address of the last name of the current node
	JSR COMPARE      ;Jump to compare subroutine
	BRz MAIN3        ;if string isnt matched, skip to MAIN3
	JSR PRINT	 ;Jump to print subroutine
	AND R6, R6, #0   ;Set R6 to 0
MAIN3   LDR R1, R1, #0   ;Reloads R1 into itself
	BRnp MAIN1       ;If R1 is 0, it indicated list has ended, but if not, it PC loops back to MAIN1
	ADD R6, R6, #0   ;Rewrites R6 register to itself
	BRz MAIN4        ;IF R6 is 0, indicates a name has been found, so skip to MAIN4
	LEA R0, NEG      ;if R6 is 1, name hasnt been found, so saves NEG string
	TRAP x22 	 ;prints the NEG string
MAIN4	TRAP x25         ;End Program
	.BLKW 1

;PRINT subroutine       ;Prints all the info on the current node if matched string is found

PRINT 	AND R4, R4, #0
	ADD R4, R4, #1
	ADD R4, R4, #15
	ADD R4, R4, R4
	ADD R6, R7, #0
	ADD R0, R1, #3
	LDR R0, R0, #0
	TRAP x22
	ADD R0, R4, #0
	TRAP x21
	ADD R0, R1, #2
	LDR R0, R0, #0
	TRAP x22
	ADD R0, R4, #0
	TRAP x21
	ADD R0, R1, #1
	LDR R0, R0, #0
	TRAP x22
	AND R0, R0, #0
	ADD R0, R0, #10
	TRAP x21
	ADD R7, R6, #0
	RET
       	
;Compare subroutine              ;Must have 2 head string addresses in R2, R3 before calling
				 ;Outputs 1 into R6 if strings match, if not outputs 0

COMPARE LDR R4, R2 #0
	BRz ENDLP2 
	LDR R5, R3 #0
	BRz ENDLP3
	ADD R5, R4, R5
	ADD R5, R5, #1
	BRnp ENDLP1
	ADD R2, R2, #1
	ADD R3, R3, #1
	BRnzp COMPARE
ENDLP1  AND R5, R5, #0
	RET
ENDLP2  LDR R5, R3, #0
	BRnp ENDLP1
	BRz ENDLP4
ENDLP3  LDR R4, R2, #0
	BRnp ENDLP1
ENDLP4  AND R5, R5, #0
	ADD R5, R5, #1
	RET

;Reverse SubRoutine                 ;Applies the not instruction to every character in INPUT for easier comparisons

REVERSE LEA R1, INPUT
LOOP2	LDR R2, R1, #0
	NOT R2, R2
	STR R2, R1, #0
	ADD R1, R1, #1
	LDR R2, R1, #0
	BRnp LOOP2
	RET

;Input SubRoutine
	
InSub	LEA R0 PROMPT                ;Loads address of prompt to be printed
	LEA R1 INPUT                 ;Loads Address of Input Space
	AND R6, R6, #0               ;clears register 6
	ADD R6, R7, #0               ;Moves linkage address to R6 so it is not affected by TRAP instructions
        TRAP x22                     ;Prints prompt
LOOP1   TRAP x20                     ;Getchar
	TRAP x21                     ;echos character
	STR R0, R1, #0               ;Stores keystroke into input space
	ADD R1, R1, #1               ;Increment Address counter
	AND R0, R0, #-11             ;Checks if last keystroke was enter key
	BRnp LOOP1                   ;loops back for more input if not 0.
	ADD R1, R1, #-1              ;Get the address counter to point to the enter key
	STR R0, R1, #0               ;replaces enter key with a 0
	AND R7, R7, #0               ;clears R7
	ADD R7, R6, #0               ;moves linkage address back to R7
	RET
          

;Space for input

INPUT   .BLKW 20               

;Presaved Strings  

PROMPT  .STRINGZ "Type a Name and Press Enter:" 
NEG     .STRINGZ "No Entry"    
               

;___________________________________
;Code for linked list directory
;___________________________________

ListPTR .FILL N0
.BLKW x20
N0 .FILL N1 ; Node*
.FILL P0 ; Room(Place)*
.FILL F0 ; Firstname*
.FILL L0 ; Lastname*
.BLKW x54
L4 .STRINGZ "Chen"
F6 .STRINGZ "Yueting"
N3 .FILL N4
.FILL P3
.FILL F3
.FILL L3
F1 .STRINGZ "Xiaofei"
N6 .FILL N7
.FILL P6
.FILL F6
.FILL L6
.BLKW #98
P0 .STRINGZ "201"
F0 .STRINGZ "Wenzhi"
P3 .STRINGZ "301"
N2 .FILL N3
.FILL P2
.FILL F2
.FILL L2
P2 .STRINGZ "533"
P6 .STRINGZ "110"
P7 .STRINGZ "512"
.BLKW #7
N7 .FILL N8
.FILL P7
.FILL F7
.FILL L7
P4 .STRINGZ "412"
L5 .STRINGZ "Jiang"
F3 .STRINGZ "Shi"

N8 .FILL #0
.FILL P8
.FILL F8
.FILL L8
L8 .STRINGZ "Jin"
P1 .STRINGZ "Didi Research Institute"
L6 .STRINGZ "Zhuang"
F5 .STRINGZ "Xiaohong"
N4 .FILL N5
.FILL P4
.FILL F4
.FILL L4
L1 .STRINGZ "He"
L3 .STRINGZ "Cai"
L2 .STRINGZ "Pan"
N5 .FILL N6
.FILL P5
.FILL F5
.FILL L5
P8 .STRINGZ "T.A."
F4 .STRINGZ "Gang"
L0 .STRINGZ "Chen"
N1 .FILL N2
.FILL P1
.FILL F1
.FILL L1
F2 .STRINGZ "Gang"
F8 .STRINGZ "Tao"
P5 .STRINGZ "520"
F7 .STRINGZ "Qingsong"
L7 .STRINGZ "Shi"
.END
