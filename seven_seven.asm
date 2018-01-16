.ORIG x3000 
AND R5, R5, #0 
ADD R5, R5, #1 ;R5 will act as a mask to ;mask out the unneeded bit 
AND R1, R1, #0 ;zero out the result register 
AND R2, R2, #0 ;R2 will act as a counter 
LD R3, NegSixt 
MskLoop AND R4, R0, R5 ;mask off the bit BRz NotOne ;if bit is zero then don't ;increment the result 
ADD R1, R1, #1 ;if bit is one increment ;the result 
NotOne ADD R5, R5, R5 ;shift the mask one bit left 
ADD R2, R2, #1 ;increment counter (tells us ;where we are in bit pattern) 
ADD R6, R2, R3 
BRn MskLoop ;not done yet go back and ;check other bits 
HALT 
NegSixt .FILL #-16 
.END