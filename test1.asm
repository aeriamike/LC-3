.ORIG x3000 
JSR A 
OUT 
BRnzp DONE 
A AND R0,R0,#0 
ADD R0,R0,#5 
JSR B 
RET 
DONE HALT 
ASCII .FILL x0030 
B LD R1,ASCII 
ADD R0,R0,R1 
RET 
.END 