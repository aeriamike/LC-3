
/* Change the map into a 16-base .hex file */
#include<stdio.h>

int main() {
	char file1[50];
	char file2[50];
	printf("Դ�ļ���:");
	scanf("%s",file1);
	printf("Ŀ���ļ���(��.hex��β)");
	scanf("%s",file2);
	freopen(file1,"r",stdin);
	freopen(file2,"w",stdout); 
	printf("3200\n");
	int n;
	while(scanf("%d",&n)==1) {
		printf("%04x\n", n);
	}
	return 0;
	
}
