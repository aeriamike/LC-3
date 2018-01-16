#include<stdio.h>
#include<stdlib.h>

typedef struct professor{  
						  
	char first_name[20]; 
	char last_name[20];
	char room[200]; 
	struct professor *next;
} Node;

typedef struct{	
	Node *head; 
	Node *tail;
} linked_list;

linked_list *list_create(void);
int compa(char *x, char *y);
void add_prof(linked_list *test, char *first, char*last, char*room);
int find_prof(linked_list *test, linked_list *test2, char*match);
void printer(linked_list *test, int count);
void list_destroy(linked_list *test);


void add_prof(linked_list *test, char *first, char*last, char*room){ 
	Node *n = (Node*)malloc(sizeof(Node));
	int i = 0;

	for(i=0; i<15 || last[i]!= '\0'; i++){	 
		
		n->last_name[i] = last[i];	
		n->first_name[i] = first[i];
		
		}

	for(i=0; i<25 || room[i]!= '\0'; i++){     
		n->room[i] = room[i];
		}

	n->next = NULL;	

	if(test->head == NULL && test->tail == NULL){     
		test->head = n;								   
		test->tail = n;
	} else{
		test->tail->next = n;							
		test->tail = n;								
	}
	
}

int find_prof(linked_list *test, linked_list *test2, char*match){
	
	int count = 0;		
							
	int flag;				
	
	Node *x = test->head;
	Node *y = test2->head;
	while ( x!= NULL){
		flag = compa(x->first_name, match); 
		if (flag){
			
			add_prof(test2, x->first_name, x->last_name, x->room); 
			count++;	
			
			goto NEXT;
			
		} else {
			flag = compa(x->last_name, match);
		}
		
		if (flag){
			add_prof(test2, x->first_name, x->last_name, x->room);
			count++; 
		}	
		
		NEXT:
		x = x->next;	
		}
	
	return count;
}

int compa(char *x, char *y){
	int indicator = 1;
	int i;
	for (i=0; i<20 && x[i]!='\0'; i++){
		if(x[i] != y[i]){
			indicator = 0; 			
		}
	}
	return indicator;
}

void printer(linked_list *test, int count){
	Node *x = test->head;
	int a = count;
	int i = 1;
	while (x != NULL){
		
		if(i<a){
			printf("%s %s %s\n", x->last_name, x->first_name, x->room);
			
		}else{
			printf("%s %s %s\n", x->last_name, x->first_name, x->room);
		}
		
		i++;
		
		x = x->next;
	}
}


void list_destroy(linked_list *test){   
	Node *x = test->head;
	while (x!=NULL){
		test->head = test->head->next; 
		free(x);
		x = test->head;
	}
	free (test);
	test = NULL;
}

linked_list *list_create(void){ 
	linked_list *test = (linked_list*)malloc(sizeof(linked_list)); 
	test->head = NULL;
	test->tail = NULL;
	return test;
}

int main(){
	linked_list *test;	
	linked_list *test2; 	
							
	
	test = list_create();
	
	int num_prof = 0; 
	int query = 0; 
	
	char search_name[20]; 
	
	char last_input[20];
	char first_input[20];
	char room_num_input[25];
	
	
	scanf("%d", &num_prof); 
	
	
	while (num_prof != 0){
		
		int j;
		scanf("%s", first_input); 
		scanf("%s", last_input);
		scanf("%s", room_num_input);
			
		add_prof(test, first_input, last_input, room_num_input);
		num_prof--;		
	}
	
	scanf("%d", &query); 
	
	int i = 0;
	int j = 0;
	
	char *array[query]; 
	
	for (i=0; i<query; i++){
		array[i] = malloc(15 * sizeof(char)); 
	}
	

	for (i=0; i<query; i++){
		scanf("%s", search_name);  
		for (j=0; j<15||search_name[j]!='\0'; j++){ 
			array[i][j] = search_name[j];
			}
			
	}
	
	
	for (i=0; i<query; i++){
		int count = 0; 
		test2 = list_create();
		count = find_prof(test, test2, array[i]);
		printf("%d\n", count);
		printer(test2,count);
	}

	for (i=0; i<query; i++){
		free(array[i]); 
		}

	list_destroy(test); 
	list_destroy(test2);

	return 0;
	
}


