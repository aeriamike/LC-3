#include <stdio.h>
#include <stdlib.h>


int a = 0; 
int b = 0; 

int i = 0;
int j = 0;

int mountain[100][100];                   
int peak[100][100] = {0}; 
           
int pass_x[4] = {0, 0, 1,-1},            
    pass_y[4] = {1,-1, 0, 0};   
 
                      
int within (int x, int y) {
 return x > 0 && x <= a && y > 0 && y <= b;  
}


int root (int i, int j) {
	
 int pos_x, pos_y;     
 int k;           
 
 int temp_max = 0;        
             
 if (peak[i][j] > 0)             
  return peak[i][j];
  
 for (k = 0; k < 4; k++) { 
        
  pos_x = i + pass_x[k];             
  pos_y = j + pass_y[k];          
      
  if (within(pos_x, pos_y) && mountain[pos_x][pos_y] < mountain[i][j]) {  
               
                  peak[pos_x][pos_y] = root(pos_x, pos_y);
                  
				  if (root(pos_x, pos_y) > temp_max){
				             temp_max = root(pos_x, pos_y);
					  }        
         }
 
}
 
 peak[i][j] = temp_max + 1; 
                  
 return peak[i][j];
 
 
}



int main () {
	
 int max = 0;
 scanf ("%d %d", &a, &b); 
 
 
 for (i = 1; i <= a; i++){
 	
 	 for (j = 1; j <= b; j++){
 	 	
 	 	scanf ("%d", &mountain[i][j]); 
	  }
    
 }
   
 for (i = 1; i <= a; i++){
 	
 	for (j = 1; j <= b; j++) {
 		
   	 if (root(i, j) > max) {
   	 	
   	 max = peak[i][j];
   }
   
   }
   
 }

  
 printf ("%d\n", max);
 
 return 0;
 
}
 
 
