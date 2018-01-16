#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct node {
	char fname[256];
	char lname[256];
	char room_num[256];
	struct node *next;
} linkedList;

typedef struct listpters {
	linkedList *head;
	linkedList *tail;
}listPtrs;

//Initialized Functions//
linkedList* CreateLinkedList(void);
linkedList* AddNode(linkedList*);


//Main//


int main()
{


listPtrs listptr1;
listptr1.head = CreateLinkedList();
listptr1.tail = listptr1.head;
int directorysize, searchnum, flag, namecounter;
linkedList* ptr[256];
char searchlist[256][256];
char tempname[256];
char tempfirst[256];
char templast[256];
char temproom[256];

scanf("%d", &directorysize);

for (;directorysize > 0;directorysize--)
{
	scanf("%s", tempfirst);
	scanf("%s", templast);
	scanf("%s", temproom);
	strcpy(listptr1.tail->lname, templast);
	strcpy(listptr1.tail->fname, tempfirst);
	strcpy(listptr1.tail->room_num, temproom);
	if (directorysize != 1){
		listptr1.tail = AddNode(listptr1.tail);}	
}

scanf("%d", &searchnum);

int i, ii;
for (i=0;i<searchnum;i++)
{
	scanf("%s", &searchlist[i]);		
}
 
linkedList* lister;

for(ii=0; ii<searchnum;ii++)
{
	for(i=0, namecounter = 0, lister = listptr1.head;lister != NULL;)
	{	
		if (strcmp(lister->fname, searchlist[ii])==0){
			flag = 1; }	
		if (strcmp(lister->lname, searchlist[ii])==0){
			flag = 1;}	
		if (flag == 1){
			ptr[i] = lister;
			namecounter++;
			i++;}
		flag = 0;
		lister = lister->next;	
	}

	printf("%d\n", namecounter);
	
	for(i=0;i<namecounter;i++)
	{
		printf("%s %s %s\n",ptr[i]->lname, ptr[i]->fname, ptr[i]->room_num);
	}	
}

}

//Functions//



linkedList* CreateLinkedList(void) 
//Creates the first node of the linked list. 
//Returns the pointer to that first node
{
	linkedList *ptr;
	ptr = (linkedList *)malloc (sizeof(linkedList));
	if (ptr == NULL){
		printf("Action failed. Not enough memory");
		return NULL;}
	ptr->next = NULL;
	
	return ptr;		
}

linkedList* AddNode (linkedList* linkptr)
//Creates additional nodes 
//Uses first arguement as a pointer to the PREVIOUS node
//Uses second arguement  as a int to  be added in that node.
//Returns pointer of the  current node

{
	linkedList *ptr;
	ptr = (linkedList*)malloc (sizeof(linkedList));
	if (ptr == NULL){
		printf("Action failed. Not enough memory");
		return NULL;}
	ptr->next = NULL;
	linkptr->next = ptr;	
	return ptr;
	
}






	
	
	
	
	
	
	
