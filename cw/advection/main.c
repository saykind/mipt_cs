#include <stdio.h>
#include <stdlib.h>

#define A -1.0
#define B 1.0
#define C 1
#define K 0.6
#define X(i,N) (A + 1.0*i*(B-A)/N) 

double *advection(int N, int M);
double  u(double x, double t);
double  between(double x1, double y1, double x2, double y2, double x0);
FILE   *gpinit(void);
void 	plot(FILE *gp, double *a, int N);

int main(void) {
	int N = 1000;
	int M = N/K;
	double *a = advection(N, M);
	free(a);
	return 0;
}

double *advection(int N, int M) {
	double *a = (double *) malloc(N*sizeof(double));
	double *b = (double *) malloc(N*sizeof(double));
	double h = (B-A)/N;
	int i, j, ii;
	FILE *gp = gpinit();
	plot(gp, a, N);
	for (i = 0; i < N; i++) {a[i] = u(X(i,N),0);}
	for (j = 0; j < M; j++) {
		for (i = 0; i < N; i++) {
			ii = i; if (ii >= N-1) {ii = ii-N;}
			b[ii+1] = between(-h, a[i], 0, a[ii+1], -K*h);
		}
		for (i = 0; i < N; i++) {a[i] = b[i];}
		plot(gp, a, N);
	}
	pclose(gp);
	free(b);
	return a;
}
double u(double x, double t) {
	if (t == 0) {
		if ((x>=-0.5)&&(x<=0.5)){return 1;} 
		else 	{return 0;}
	}
}
double between(double x1, double y1, double x2, double y2, double x0) {
	double k = (y2-y1)/(x2-x1);
	double b =  y1-k*x1;
	return (k*x0+b);
}

FILE *gpinit(void) {
	FILE *gp = popen("gnuplot", "w");
	if (gp == NULL) {return NULL;}
	fprintf(gp, "set term wxt\n");
	fprintf(gp, "unset key\n unset border\n");
	fprintf(gp, "unset border\n");
//	fprintf(gp, "unset tics\n");
	fprintf(gp, "set yrange [0:1.01]\n");
	fprintf(gp, "set xrange [-1:1]\n");
	return gp;
}
void plot(FILE *gp, double *a, int N) {
	int i;
	fprintf(gp, "plot '-' w impulses\n");
	for (i = 0; i < N; i++) {
		fprintf(gp, "%.6f %.6f\n", X(i,N), a[i]);
	}
	fprintf(gp,"e\n");
	fflush(gp);
	usleep(200);
}
