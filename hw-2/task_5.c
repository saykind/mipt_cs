#include <stdio.h>
#include <stdlib.h>

int soi(int N, int *aoi);
double sof(int M, double *aof);

int main(void) {
	int i, N, M;
	 scanf("%d", &N);
	 int *aoi = (int *) malloc(N*sizeof(int));
	for (i=0;i<N;i++) {scanf("%d", aoi+i);}
	 scanf("%d", &M);
	 double *aof = (double *) malloc(M*sizeof(double));
	for (i=0;i<M;i++) {scanf("%lf", aof+i);}
	 printf("%d %lf", soi(N, aoi), sof(M, aof));
	return 0;
}

