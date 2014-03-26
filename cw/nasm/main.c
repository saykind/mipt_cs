#include <stdio.h>


int main (int argv, char *argc[]) {
	int i = 0;
	for (i = 0; i < argv; i++) {
		printf("%s [%d]\n", argc[i], i);
	}
	return 1;
}
