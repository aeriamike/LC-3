	.ORIG x4000
	
	.FILL x4001
N0  
    .FILL x0000 ; Null		;1
    .FILL P0 ; Room(Place)*
    .FILL F0 ; Firstname*
    .FILL L0 ; Lastname*

F0 
    .STRINGZ "Wenzhi" 		;5
L0 
    .STRINGZ "Chen" 
P0 
    .STRINGZ "201"			

.END