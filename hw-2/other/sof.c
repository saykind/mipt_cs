#include <stdio.h>
#include <stdlib.h>

double sof(int N, double *a) {
	int i = 0; double s;
	while (i < N) {s += *(a+i); i++;}
	return s;
}

int main(void) {
	int i, N, M;
	 scanf("%d", &M);
	 double *aof = (double *) malloc(M*sizeof(double));
	for (i=0;i<M;i++) {scanf("%lf", aof+i);}
	printf("%lf\n", sof(M, aof));
	return 0;
}

