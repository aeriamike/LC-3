.ORIG x3000

;Main function___________________

	LEA R0, START
	JMP R0
	RSTACK	.Fill x3000

        ROWS	.Fill x3200
	COLUMNS	.Fill x3201

	MATRIX	.Fill x3202

START	LD R6, RSTACK        ;Loads base of Runtime stack pointer
	LD R5, RSTACK        ;Loads frame pointer

	AND R1, R1, #0       ;Sets R1 to 0
	AND R2, R2, #0
	ADD R2, R2, #7       ;Sets loop counter to 6

LOOP1	ADD R6, R6, #-1      ;Decrements runtime stack ptr
	STR R1, R6, #0       ;Allocates 4 local vars and sets them to 0
	ADD R2, R2, #-1
	BRp LOOP1            ;int variables are listaddress, answer, tempanswer, rows, columns, i, ii


;-----------------^^^^^^ Build STACKS --------------


	LD R2, MATRIX       ;Stores the matrix address to the listaddress variables
	STR R2, R5, #-1     

	LDI R2, ROWS
	STR R2, R5, #-4     ;Stores the number of rows to the row variable

	LDI R2, COLUMNS
	STR R2, R5, #-5     ;Stores the number of columns to the columns variable
		
LOOP5	ADD R6, R6, #-1     ;Passes variable ii in stack
	LDR R3, R5, #-7
	STR R3, R6, #0
	ADD R6, R6, #-1     ;Passes variable i in stack
	LDR R3, R5, #-6
	STR R3, R6, #0
	ADD R6, R6, #-1     ;Passes variable COLUMNS in stack
	LDR R3, R5, #-5
	STR R3, R6, #0
	ADD R6, R6, #-1     ;Passes variable ROWS in stack
	LDR R3, R5, #-4
	STR R3, R6, #0
	ADD R6, R6, #-1     ;Passes list address in stack
	LDR R3, R5, #-1
	STR R3, R6, #0

	JSR FUNCTION

	LDR R3, R6, #0
	STR R3, R5, #-3
	ADD R6, R6, #6
	
	LDR R2, R5, #-3      ;loads temp answer to R2
	LDR R3, R5, #-2	     ;loads answer to R3

	JSR COMPARE 
	ADD R1, R1, #0
	BRnz SKIP5           ;if R3 is bigger skip to SKIP5
	STR R2, R5, #-2

SKIP5	LDR R1, R5, #-7     ;load ii
	LDR R2, R5, #-5     ;load columns
	ADD R2, R2, #-1
	NOT R2, R2
	ADD R2, R2, #1
	ADD R3, R1, R2      ;Subtract ii with columns
	BRnp SKIP6          ;checks if ii has reached its parameters
	AND R3, R3, #0      ;Set R3 to 0 
	STR R3, R5, #-7     ;Set ii to 0
	LDR R2, R5, #-6     ;Loads i
	ADD R2, R2, #1      ;Increments i
	STR R2, R5, #-6     ;Stores i
	LDR R3, R5, #-4     ;Loads rows
	NOT R3, R3
	ADD R3, R3, #1
	ADD R3, R2, R3      ;Subtract i with rows

	BRz ENDLOOP	    ;detects if main loop ends
	BRnzp #3

SKIP6   LDR R1, R5, #-7
	ADD R1, R1, #1
	STR R1, R5, #-7

        BRnzp LOOP5

ENDLOOP	LDR R2, R5, #-2
	TRAP x25

	



;Function__________________________________________________________________

FUNCTION ADD R6, R6, #-1     ;Allocates space for return value
	 ADD R6, R6, #-1 
	 STR R7, R6, #0      ;Pushes return address
	 ADD R6, R6, #-1 
	 STR R5, R6, #0      ;Pushes frame pointer
	 ADD R5, R6, #0      ;Sets frame pointer
	 
	 AND R1, R1, #0       ;Sets R1 to 0
	 AND R2, R2, #0
	 ADD R2, R2, #5       ;Sets loop counter to 5

LOOP2	 ADD R6, R6, #-1      ;Decrements runtime stack ptr
	 STR R1, R6, #0       ;Allocates 4 local vars and sets them to 0
	 ADD R2, R2, #-1
	 BRp LOOP2            ;int variables value, n, w, s, e are set to 0  

	 LDR R1, R5, #6       ;Loads argument i into R1
	 LDR R2, R5, #7       ;Loads argument ii into R2
	 JSR ACCESSA
	 STR R3, R5, #-1      ;Stores that value into variable R3.

IFN	 LDR R1, R5, #6       ;Loads i into R1
	 BRz IFW              ;Check if 0
	 LDR R2, R5, #7	      ;Loads ii into R2
	 ADD R1, R1, #-1      ;Decrements i
	 JSR ACCESSA
	 LDR R2, R5, #-1      ;loads value variable to R2
	 JSR COMPARE          
	 ADD R1, R1, #0
	 BRnz IFW
	 LDR R3, R5, #7       ;Loads ii into R3
	 LDR R2, R5, #6       ;Loads i into R2
	 ADD R2, R2, #-1      ;Decrements i
	 LDR R1, R5, #5       ;Loads Columns into R1
	 LDR R0, R5, #4       ;Loads Rows into R0
	 JSR PUSHA
	 JSR FUNCTION
	 LDR R3, R6, #0
	 STR R3, R5, #-2      ;Stores return value to N
	 ADD R6, R6, #6

IFW	 LDR R2, R5, #7       ;Loads ii into R2
	 BRz IFS              ;Check if 0
	 LDR R1, R5, #6       ;Loads i into R1
	 ADD R2, R2, #-1      ;Decrements ii
	 JSR ACCESSA
	 LDR R2, R5, #-1      ;loads value variable to R2
	 JSR COMPARE          
	 ADD R1, R1, #0
	 BRnz IFS
	 LDR R3, R5, #7       ;Loads ii into R3
	 LDR R2, R5, #6       ;Loads i into R2
	 ADD R3, R3, #-1      ;Decrements ii
	 LDR R1, R5, #5       ;Loads Columns into R1
	 LDR R0, R5, #4       ;Loads Rows into R0
	 JSR PUSHA
	 JSR FUNCTION
	 LDR R3, R6, #0
	 STR R3, R5, #-3      ;Stores return value to W
	 ADD R6, R6, #6


IFS	 LDR R3, R5, #6       ;Loads i into R3
	 LDR R2, R5, #4       ;Loads rows into R2
	 ADD R2, R2, #-1
	 JSR COMPARE
	 ADD R1, R1, #0     
	 BRnz IFE             ;Check if i+1 is in parameters
	 LDR R1, R5, #6       ;Loads i into R1
	 LDR R2, R5, #7       ;Loads ii into R2
	 ADD R1, R1, #1       ;Increments i
	 JSR ACCESSA
	 LDR R2, R5, #-1      ;loads value variable to R2
	 JSR COMPARE          
	 ADD R1, R1, #0
	 BRnz IFE
	 LDR R3, R5, #7       ;Loads ii into R3
	 LDR R2, R5, #6       ;Loads i into R2
	 ADD R2, R2, #1       ;Increments i
	 LDR R1, R5, #5       ;Loads Columns into R1
	 LDR R0, R5, #4       ;Loads Rows into R0
	 JSR PUSHA
	 JSR FUNCTION
	 LDR R3, R6, #0
	 STR R3, R5, #-4      ;Stores return value to s
	 ADD R6, R6, #6


IFE	 LDR R3, R5, #7       ;Loads ii into R3
	 LDR R2, R5, #5       ;Loads column into R3
	 ADD R2, R2, #-1
	 JSR COMPARE
	 ADD R1, R1, #0     
	 BRnz BIGGEST         ;Check if i+1 is in parameters
	 LDR R1, R5, #6       ;Loads i into R1
	 LDR R2, R5, #7       ;Loads ii into R2
	 ADD R2, R2, #1       ;Increments ii
	 JSR ACCESSA
	 LDR R2, R5, #-1      ;loads value variable to R2
	 JSR COMPARE          
	 ADD R1, R1, #0
	 BRnz BIGGEST
	 LDR R3, R5, #7       ;Loads ii into R3
	 LDR R2, R5, #6       ;Loads i into R2
	 ADD R3, R3, #1       ;Increments ii
	 LDR R1, R5, #5       ;Loads Columns into R1
	 LDR R0, R5, #4       ;Loads Rows into R0
	 JSR PUSHA
	 JSR FUNCTION
	 LDR R3, R6, #0
	 STR R3, R5, #-5      ;Stores return value to e
	 ADD R6, R6, #6

BIGGEST	 LDR R3, R5, #-2      ;Load n var in R3
	 LDR R2, R5, #-3      ;Load w var in R2
	 JSR COMPARE
	 ADD R1, R1, #0          
	 BRp SKIP2            ;If R3 < R2 skip to skip2
	 LDR R0, R5, #-2      ;load N
	 BRnzp #1

SKIP2	 LDR R0, R5, #-3
	 LDR R3, R5, #-4      ;Loads s
         ADD R2, R0, #0       ;Loads R0
	 JSR COMPARE
	 ADD R1, R1, #0          
	 BRp SKIP3            ;If R3 < R2 skip to skip2
	 LDR R0, R5, #-4      ;load S
	 BRnzp #1

SKIP3	 ADD R0, R2, #0       ;load R0
	 LDR R3, R5, #-5      ;Loads e
         ADD R2, R0, #0       ;Loads R0
	 JSR COMPARE
	 ADD R1, R1, #0          
	 BRp SKIP4            ;If R3 < R2 skip to skip2
	 LDR R0, R5, #-5      ;load e
	 BRnzp #1

SKIP4	 ADD R0, R2, #0       ;load R0

	 
;    
	
	 ADD R0, R0, #1       ;Increment R0
	 STR R0, R5, #2       ;Set return value 
	 ADD R6, R6, #5       ;Local variables popped
	 LDR R5, R6, #0       ;Frame pointer loaded    
	 LDR R7, R6, #1       ;Return address loaded
	 ADD R6, R6, #2       ;Both above are popped
	 RET
;___________________________________________________________________________________________________________

PUSHA   ADD R6, R6, #-1      ;Pushes ii 
	STR R3, R6, #0
	ADD R6, R6, #-1      ;Pushes i
	STR R2, R6, #0
	ADD R6, R6, #-1      ;Pushes Columns
	STR R1, R6, #0
	ADD R6, R6, #-1      ;Pushes Rows 
	STR R0, R6, #0 
	ADD R6, R6, #-1      ;Pushes list address 
	LDR R3, R5, #3   
	STR R3, R6, #0
	RET	
;___________________________________________________________________________________________________________
;Compare both numbers in R2 and R3. Has a 1 in R1 if R3 < R2, 0 otherwise.

COMPARE  AND R1, R1, #0
	 NOT R3, R3
	 ADD R3, R3, #1
	 ADD R3, R3, R2
	 BRnz END1
	 ADD R1, R1, #1
END1     RET 	 
;___________________________________________________________________________________________________________
;Access array subroutine, will take R1 as i and R2 as ii and will place the value in R3

ACCESSA	 LDR R3, R5, #3       ;Loads argument array address into R3
	 ADD R3, R3, R2       ;Changes R3 to point to the address of the iith column
	 
	 LDR R0, R5, #4       ;Loads number of rows into R1
	 ADD R1, R1, #0
	 BRz SKIP1
LOOP3	 ADD R3, R3, R0       ;Adds R3 with the number of rows to get the dersired column
	 ADD R1, R1, #-1      ;Decrement loop counter
	 BRp LOOP3
SKIP1	 LDR R3, R3, #0
         RET
;______________________________________
.END