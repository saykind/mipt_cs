#include <stdio.h>
#include <stdlib.h>

#define A -1.0
#define B 1.0
#define C 1i
#define K 0.6i
#define dt 1e-3
#define dx 1e-3

double *advection(int N, int M);
double u(double x, double t);
double X(int i, double h) {return A + h*i;}
double between(double x1, double y1, double x2, double y2, double x0);
void plot(FILE *gp, double *a, int N);



int main(void) {
	int N = 19;
	int M = 10;
	double h = (B-A)/N;
	double x;
	int i, j;
	double *a;
	a = advection(N, M);
	free(a);
	return 0;
}


double *advection(int N, int M) {
	double *a = (double *) malloc(N*sizeof(double));
	double *b = (double *) malloc(N*sizeof(double));
	double h = (B-A)/N, x, x1, x2, y1, y2, x0;
	//double dt = K*h/(1.0*C);
	int t = 0;
	int i, j, ii;
	for (i = 0; i < N; i++) {
		x = A + h*i;
		a[i] = u(x,0);
	}
	FILE *gp = popen("gnuplot", "w");
	if (gp == NULL) {printf("!@@!\n");}
	fprintf(gp, "set yrange [0:1.01]\n");
	fprintf(gp, "set xrange [-1:1]\n");
	plot(gp, a, N);
	for (j = 0; j < M; j++) {
		for (i = 0; i < N; i++) {
			ii = i;
			if (ii >= N-1) {ii = ii-N;}
			x1 = A+h*(i);
			y1 = a[i];
			x2 = A+h*(ii+1);
			y2 = a[ii+1];
			x0 = x2 - K*h;
			b[ii+1] = between(-h, y1, 0, y2, -K*h);
		}
		for (i = 0; i < N; i++) {a[i] = b[i];}
		plot(gp, a, N);
	}
	free(b);
	pclose(gp);
	return a;
}
double u(double x, double t) {
	if (t < 0) {return -1;}
	if (t == 0) {
		if ( (x >= -0.5) && (x <= 0.5) ){
			return 1;
		} else {return 0;}
	} else {
	}	
}

double between(double x1, double y1, double x2, double y2, double x0) {
	double k = (y2-y1)/(x2-x1);
	double b = y1 - k*x1;
	return (k*x0+b);
}

void plot(FILE *gp, double *a, int N) {
	fprintf(gp, "set term x11\n");
	int i;
	double h = (B-A)/N;
	fprintf(gp, "plot '-' w lines\n");
	for (i = 0; i < N; i++) {
		fprintf(gp, "%.4f %.4f\n", X(i,h), a[i]);
	}
	fprintf(gp,"e\n");
	fflush(gp);
	sleep(1);
}

