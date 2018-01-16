#include <stdio.h>
#include <stdlib.h>

typedef struct professor {
	char first_name[20];
	char last_name[20];
	char room[20];
	struct professor *next;
} prof;

typedef struct linked_list {
	prof *head;
	prof *tail;
}point;


prof* list_create(void) 

{
	prof *list_size;
	list_size = (prof *)malloc (sizeof(prof));
	if (list_size == NULL){
		return NULL;
		}
	list_size->next = NULL;
	
	return list_size;		
}

prof* add_prof (prof* test1)

{
	prof *adder;
	adder = (prof*)malloc (sizeof(prof));
	if (adder == NULL){
		return NULL;
		}
	adder->next = NULL;
	test1->next = adder;	
	return adder;
	
}



int main()
{
	point test1;

	test1.head = list_create();
	test1.tail = test1.head;
	
	int num_prof = 0;

	int query = 0; 
	int flag = 0; 



	char find_input[20][20];

	char first[20];
	char last[20];
	char roomy[20];

	scanf("%d", &num_prof);

	int num = num_prof;

	for (num;num > 0;num--){
		
		scanf("%s", first);
		scanf("%s", last);
		scanf("%s", roomy);
	
		strcpy(test1.tail->last_name, last);
		strcpy(test1.tail->first_name, first);
		strcpy(test1.tail->room, roomy);
	
		if (num != 1){
			test1.tail = add_prof(test1.tail);
			}	
	}

	scanf("%d", &query);
	
	

	int i = 0;
	
	for (i=0;i<query;i++)
	{
		scanf("%s", find_input[i]);		
	}
 
	int a = 0;
	prof* checker;
	prof* final[20];

	int count = 0; 

	for(a=0; a<query; a++)
	{
		for(i=0, count = 0, checker = test1.head; checker != NULL;)
		{	
			if (strcmp (checker -> first_name, find_input[a]) == 0){
				flag = 1; 
				}
				
			if (strcmp (checker -> last_name, find_input[a]) == 0){
				flag = 1;
				}		
				
		if (flag == 1){
			final[i] = checker;
			count++;
			i++;
			}
		checker = checker->next;	
		flag = 0;
	
	}

	printf("%d\n", count);
	
	for(i=0;i<count;i++)
	{
		printf("%s ",
					final[i]->last_name);
		printf("%s ",
				    final[i]->first_name);
		printf("%s\n",
					final[i]->room);			
	}	
}

}





	
	
	
	
	
	
	
