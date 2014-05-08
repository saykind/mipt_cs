#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "advection.h"

int main(int argv, char *argc[]) {
	info I, J;
	int N;
	double *u;

	if (argv > 1) {sscanf(argc[1],"%d", &N);}
	else {N = 100;}
//	if (scanf("%d", &N)) {} else {N = 40;}
	
	iinit(&I, N);
	u = advection(I.N, I.M);
	compare(u, I.N);
	residual(u, &I);
	iprint(I);
	free(u);

	N *= 2;
	iinit(&J, N);
	u = advection(J.N, J.M);
	compare(u, J.N);
	residual(u, &J);
	iprint(J);
	free(u);

	printf("Degree of convergence = %lg\n\n",
			log(I.S/J.S)/log(I.h/J.h));
	return 0;
}

double *advection(int N, int M) {
	double *u = (double *) malloc(N*sizeof(double));
	double *v = (double *) malloc(N*sizeof(double));
	double dx = (B-A)/N;	double *dd = NULL;
	int i, j;
	FILE *gpp = gpinit();
	for (i = 0; i < N; i++) {u[i] = U(0, X(i,N));}
	for (i = 0; i < N; i++) {v[i] = V(0, X(i,N));}
	plot(gpp, u, N);
	for (j = 0; j < M; j++) {
		for (i = N-1; i >= 0; i--) {
			dd = cubic(dx, u[O(i,N)-1], v[O(i,N)-1], u[i], v[i]); 
			u[i] = dd[0]; v[i] = dd[1];
//			u[i] = linear(-dx, u[O(i,N)-1], 0, u[i], -K*dx);
		}	plot(gpp, u, N);
	}		sleep(2);
	pclose(gpp);
	if(dd) {free(dd);}
	free(v);
	return u;
}
double U(double t, double x) {
	if (t == -1) {
		if ((x>=-0.5)&&(x<=0.5)){return 1;} 
		else 	{return 0;}
	}
	if (t == 1) {return sin(M_PI*x);}
	if (t == 0) {return pow(sin(M_PI*x),4);}
}
double V(double t, double x) {
	if (t == -1) {
		if ((x == -0.5) || (x == 0.5)) {return 10;}
		else {return 0;}
	}
	if (t == 1) {return M_PI*cos(M_PI*x);}
	if (t == 0) {return 4*pow(sin(M_PI*x),3)*M_PI*cos(M_PI*x);}
}
double linear(double x1, double y1, double x2, double y2, double x0) {
	double k = (y2-y1)/(x2-x1);
	double b =  y1-k*x1;
	return (k*x0+b);
}
double Pu(double a, double b, double c, double d, double x) {return a*x*x*x+b*x*x+c*x+d;}
double Pv(double a, double b, double c, double d, double x) {return 3*a*x*x+2*b*x+c;}
double *cubic(double dx, double u1, double v1, double u2, double v2) {
	double a, b, c, d;
	double *dd = (double *) malloc(2*sizeof(double));
	d = u2;
	c = v2;
	b = (3*u1+v1*dx+2*c*dx-3*d)/(dx*dx);
	a = (2*u1+v1*dx+1*c*dx-2*d)/(dx*dx*dx);
	dd[0] = Pu(a,b,c,d,-K*dx);
	dd[1] = Pv(a,b,c,d,-K*dx);
	return dd;
}


FILE *gpinit(void) {
	FILE *gpp = popen("gnuplot", "w");
	if (gpp == NULL) {return NULL;}
	fprintf(gpp, "set term x11\n");
	fprintf(gpp, "unset key\n");
	fprintf(gpp, "unset border\n");
//	fprintf(gpp, "unset tics\n");
	fprintf(gpp, "set style fill solid\n");
	fprintf(gpp, "set yrange [-0.01:1.01]\n");
	fprintf(gpp, "set xrange [-1.01:1.01]\n");
	return gpp;
}
void plot(FILE *gpp, double *a, int N) {
	int i;
	fprintf(gpp, "plot '-' w boxes\n");
	for (i = 0; i < N; i++) {
		fprintf(gpp, "%.6f %.6f\n", X(i,N), a[i]);
	}
	fprintf(gpp,"e\n");
	fflush(gpp);
	usleep(200);
}

void compare(double *u, int N) {
	int i;
	FILE *gpp = gpinit();
	fprintf(gpp,"set multiplot\n");
	fprintf(gpp,"plot '-' w line \n");
	for (i = 0; i < N; i++) {
		fprintf(gpp, "%.6f %.6f\n", X(i,N), U(0, X(i,N)));
	}	fprintf(gpp,"e\n");
	fprintf(gpp,"plot '-' w line lt 0 lw 3\n");
	for (i = 0; i < N; i++) {
		fprintf(gpp, "%.6f %.6f\n", X(i,N), u[i]);
	}	fprintf(gpp,"e\n");
	fflush(gpp);
	sleep(3);
	fprintf(gpp,"unset multiplot\n");
	pclose(gpp);
	return;
}
void	residual(double *u, info *I) {
	int N = I->N;
	double *r = (double *) malloc(N*sizeof(double));
	double max = 0.0, sum = 0.0; int i;
	for (i = 0; i < N; i++) {
		r[i] = ABS((U(0,X(i,N))-u[i]));
		sum += r[i];
		if (r[i] > max) {max = r[i];}
	}
	I->R = max;
	sum *= I->h;
	I->S = sum;
		FILE *gpp = gpinit();
		fprintf(gpp,"set yrange [0:*]\n");
		fprintf(gpp,"plot '-' w impulses\n");
		for (i = 0; i < N; i++) 
			{fprintf(gpp, "%.6f %.6f\n", X(i,N), r[i]);}
		fprintf(gpp,"e\n"); fflush(gpp);
		sleep(3);
	free(r);
	return;
}

void iinit(info *I, int N) {
	I->N = N;
	I->M = I->N*MN-1;
	I->h = (B-A)/I->N;
	I->k = K;
}
void iprint(info I) {
	if (I.N) {printf("N = %d\t", I.N);}
	if (I.M) {printf("M = %d\t", I.M);}
	if (I.k) {printf("K = %lg\t", I.k);}
	if (I.h) {printf("h = %lg\n", I.h);}
	if (I.R) {printf("R = %.8lf\t", I.R);}
	if (I.S) {printf("S = %.8lf\n", I.S);}
}
