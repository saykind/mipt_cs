#include <stdio.h>
#include <math.h>

int main(void) {
	double h1, h2, e1, e2;
	printf("h1 = "); scanf("%lf", &h1);
	printf("e1 = "); scanf("%lf", &e1);
	printf("h2 = "); scanf("%lf", &h2);
	printf("e2 = "); scanf("%lf", &e2);
	printf("= %lg\n", (log(e1/e2)/log(h1/h2)));
	return;
}
