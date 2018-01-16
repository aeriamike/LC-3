#include <stdio.h>
#include <stdlib.h>

typedef struct _node{
	char fname[100000]; //the first and last name are max 15 characters
	char lname[100000];
	char loc[100000]; //The location is max 15 characters
	struct _node *next;
} Node;

typedef struct{
	Node *head;
	Node *tail;
} List;


List *list_create(void);
void list_append(List *L1, char*fn, char*ln, char*lc);
int list_search(List *L1, List *L2, char*match);
void list_print(List *L1);
void list_destroy(List *L1);
int str_comparison(char *str1, char *str2);


int main(){
	List *L1;
	List *L2; 	//we don't actually create the list until later
	L1 = list_create();
	int usernum; //the number of entries to be inputted in the directory
	int searchnum; //the number of search queries
	char searchq[15]; //the user's search queries
	char userfn[15];
	char userln[15];
	char userloc[15];
	
	//We start with getting the directory
	scanf("%d", &usernum);
	while (usernum != 0){
		int j;
		for (j=0; j<15; j++){	//we clear the string after each input
			userfn[j] = '\0';	
			}
		for (j=0; j<15; j++){	
			userln[j] = '\0';	
			}
		for (j=0; j<15; j++){
			userloc[j] = '\0';	
			}	
		//get the next input
		int i = 0;
		while (i<3){
			if (i==0){
				scanf("%s", &userfn); 
			} else if (i==1){
				scanf("%s", &userln);
			} else {
				scanf("%s", &userloc);
			}
			i++;
		}

		list_append(L1, userfn, userln, userloc); //append user's input to the node
		usernum--;
	}
	
	//now we get the user's search.
	
	scanf("%d", &searchnum); //get the number of search queries
	char *ptrsearch[searchnum]; //create an array of pointers.
	int i;
	int j;
	for (i=0; i<searchnum; i++){
		ptrsearch[i] = malloc(15 * sizeof(char)); //allocate memory space to strings
	}
	//get the user's search queries
	for (i=0; i<searchnum; i++){
		scanf("%s", &searchq);
		for (j=0; j<15||searchq[j]!='\0'; j++){ //store the user's query
			ptrsearch[i][j] = searchq[j];
			}
		for (j=0; j<15; j++){	//we clear the string after each input
			searchq[j] = '\0';	
			}	
	}

	//Search the directory
	for (i=0; i<searchnum; i++){
		int count; //the number of matches
		L2 = list_create();
		count = list_search(L1, L2, ptrsearch[i]);
		printf("%d\n", count);
		list_print(L2);
	}


	for (i=0; i<searchnum; i++){
		free(ptrsearch[i]); //free the memory space of search queries
		}
	list_destroy(L1); //free the linked list
	list_destroy(L2);
	
	return 0;
	
}


List *list_create(void){
	List *L1 = (List*)malloc(sizeof(List)); 
	L1->head = NULL;
	L1->tail = NULL;
	return L1;
}

void list_append(List *L1, char *fn, char*ln, char*lc){
	
	Node *n = (Node*)malloc(sizeof(Node));
	int i;
	for(i=0; i<15 || fn[i]!= '\0'; i++){
		n->fname[i] = fn[i];
		}
	for(i=0; i<15 || ln[i]!= '\0'; i++){
		n->lname[i] = ln[i];
		}
	for(i=0; i<15 || lc[i]!= '\0'; i++){
		n->loc[i] = lc[i];
		}

	n->next = NULL;	

	if(L1->head == NULL && L1->tail == NULL){
		L1->head = n;
		L1->tail = n;
	} else{
		L1->tail->next = n;
		L1->tail = n;
	}
	
}

int str_comparison(char *x, char *y){
	int same = 1;
	int i;
	for (i=0; i<15 && x[i]!='\0'; i++){
		if(x[i] != y[i]){
			same = 0; //will only return 1 if the strings are the same
		}
	}
	return same;
}

int list_search(List *L1, List *L2, char*match){
	int count = 0;
	int flag;
	Node *x = L1->head;
	Node *y = L2->head;
	while ( x!= NULL){
		flag = str_comparison(x->fname, match);
		if (flag){
			list_append(L2, x->fname, x->lname, x->loc);
			count++;
			goto NEXT;
		} else {
			flag = str_comparison(x->lname, match);
		}
		if (flag){
			list_append(L2, x->fname, x->lname, x->loc);
			count++;
		}		
		NEXT:
		x = x->next;
		}
	
	return count;
}


void list_print(List *L1){
	Node *x = L1->head;
	while (x != NULL){
		printf("%s ", x->lname);
		printf("%s ", x->fname);
		printf("%s", x->loc);
		printf("\n");
		x = x->next;
	}
}


void list_destroy(List *L1){
	Node *x = L1->head;
	while (x!=NULL){
		L1->head = L1->head->next; 
		free(x);
		x = L1->head;
	}
	free (L1);
	L1 = NULL;
}


