#include <stdlib.h>
#include<stdio.h>

char *pointer(void) {
	char *c = NULL;
	c += 0xaa;
	return c;
}

int main(void) {
	char *c = pointer();
	printf("%p\n", c);
	return 0;
}
