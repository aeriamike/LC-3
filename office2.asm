.ORIG x3000			     ; Program starts at x3000 

Start_In
	AND R1, R1, #0               ; intialize several registers       
	ADD R2, R2, #0    	     ; at the beginning to
	LEA R0 Quest                 ; prepare for many loading and
	LEA R1 Input                 ; storing activities
	AND R6, R6, #0               
	ADD R6, R7, #0               ;
        TRAP x22                     ; Reads and prints questions 
				     ; both and input
				     
store_char
        TRAP x20                     
	TRAP x21                     

	STR R0, R1, #0               ;Begins to store input char
	ADD R1, R1, #1               ;to memory space
	AND R0, R0, #-11             ;If the 'Enter' key is checked
	BRnp store_char              ;Stop the storing. Otherwise,
				     ;continue the storing

	ADD R1, R1, #-1              
	STR R0, R1, #0               
	AND R7, R7, #0               
	ADD R7, R6, #0               


; change every character to NOT(character) 
; in preparation for comparison.
	
NOT_IN  
	LEA R1, Input	

not_again
	LDR R2, R1, #0
	NOT R2, R2	;intialize R2 as a NOT operand
	STR R2, R1, #0  
	ADD R1, R1, #1  
	LDR R2, R1, #0
	BRnp not_again	;if there are still chars waiting to be checked
			;then go back up and continue the checking

;Ready to load linked list
	AND R6, R6, #0   
	ADD R6, R6, #1	 
	LD R1, lisDirect 

;Ready to load input string
Start	LEA R3, Input    
	ADD R2, R1, #2   
	LDR R2, R2, #0   

;Do comparison for First Name
	JSR Compa        ; go to the comparison function
	BRz try_l	 ; If the input does not match any first name sets
			 ; in the linked database, try the last name ones.
	JSR Print        ; go to the printing function
	AND R6, R6, #0   
	BRnzp decision	 

;Do comparison for Last Name
try_l   ADD R2, R1 #3    
	LDR R2, R2, #0   
	JSR Compa        ; go to the comparison function
	BRz decision     ;
	JSR Print	 ; go to the printing function
	AND R6, R6, #0   ;


decision
        LDR R1, R1, #0   
	BRnp Start       ; if there are chars reamined to
			 ; be checked, then go back to Start 
			 ; to continue
	ADD R6, R6, #0   

;Decision: name found
	BRz finalEND     ;
;Decision: no name found
	LEA R0, NONE     ;
	TRAP x22 	 ;

finalEND	
	TRAP x25         ; Halts program


;Subroutine section: the label (Print and Compa)
;represent their own function and 
;they will be called up for execution.

;Subroutine Print 
;Prints all the info on the current node if matched string is found

Print 	
	AND R4, R4, #0
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

;Compare subroutine  
;Find out whether the characters between the 
;input string and the data string are the same or not.           

Compa   LDR R4, R2 #0
	BRz Stage2 
	LDR R5, R3 #0
	BRz Stage3
	ADD R5, R4, R5
	ADD R5, R5, #1
	BRnp Stage1
	ADD R2, R2, #1
	ADD R3, R3, #1
	BRnzp Compa


Stage1  AND R5, R5, #0
	RET


Stage2  LDR R5, R3, #0
	BRnp Stage1
	BRz Stage4


Stage3  LDR R4, R2, #0
	BRnp Stage1


Stage4  AND R5, R5, #0
	ADD R5, R5, #1
	RET
          

;Input

Input   .BLKW 15; This input stores at most 15 characters 
		; (15 addresses reserved)              

;Strings for Question and No Entry

Quest   .Stringz "Type a name and press Enter: " 
NONE    .Stringz "No Entry"    
               

; Linked List Directory 
; lisDirect points to address location x4000.
; The label is waiting to be loaded for comparison

lisDirect .FILL x4000

.END