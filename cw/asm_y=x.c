#include <stdio.h>
int main (int argv, char *args[]) {
	int x = 1;
	int y = 2;
	// y = x;
	printf("(start)\tx = %d\ty = %d\n", x, y);
	__asm__ __volatile__(
		"movl %1, %0 \n\t"
		: "=r"	(y)
		: "r"	(x)
		: "memory"
	   );
	printf("(end)\tx = %d\ty = %d\n", x, y);
	return 0;
}

