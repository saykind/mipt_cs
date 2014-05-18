#include <stdio.h>
#include "header.h"
int subroutine(int a, int b);

int main(void) {
	int a, b;
	scanf("%d%d", &a, &b);
	subroutine(a, b);
	return 0;
}
