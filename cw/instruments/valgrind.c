#include <stdio.h>
#include <stdlib.h>
#define size 15

//char a[size][size];
int main()
{
	char x;
	x = (long long int *) malloc(size);
	printf("%lld", (long long int*) x);
	free((long long int*)x);	
	return 0;
}
