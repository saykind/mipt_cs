#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define A -1.0
#define B 1.0
#define C 1
#define K 0.5
#define K1 2
#define X(i,N) (A+1.0*i*(B-A)/N) 
#define O(i,N) (i>0 ? (i): (i+N))
#define ABS(a) (a>0 ? (a): (-a))

double *advection(int N, int M);
double  U(double t, double x);
double 	V(double t, double x);
double  linear(double x1, double y1, double x2, double y2, double x0);
double *cubic(double dx, double u1, double v1, double u2, double v2);
double 	Pu(double a, double b, double c, double d, double x);
double 	Pv(double a, double b, double c, double d, double x);
FILE   *gpinit(void);
void 	plot(FILE *gpp, double *a, int N);
void 	deviation(double *u, int N);
double	residual(double *u, int N);

int main(void) {
	int N = 100;
	int M = N*K1-1;
	printf("h = %lg\n", 1.0*(B-A)/N);
	double *u = advection(N, M);
	deviation(u, N);
	double R = residual(u, N);
	printf("Max residual = %lg\n", R);
	free(u);
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
		}
		plot(gpp, u, N);
	}
	sleep(2);
	pclose(gpp);
	if(dd) {free(dd);}
	free(v);
	return u;
}
double U(double t, double x) {
	if (t == 0) {
//		return sin(M_PI*x);
		return pow(sin(M_PI*x),4);
//		if ((x>=-0.5)&&(x<=0.5)){return 1;} 
//		else 	{return 0;}
	}
}
double V(double t, double x) {
	if (t == 0) {
//		return M_PI*cos(M_PI*x);
		return 4*pow(sin(M_PI*x),3)*M_PI*cos(M_PI*x);
//		if ((x == -0.5) || (x == 0.5)) {return 10;}
//		else {return 0;}
	}
}
double linear(double x1, double y1, double x2, double y2, double x0) {
	double k = (y2-y1)/(x2-x1);
	double b =  y1-k*x1;
	return (k*x0+b);
}
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
double Pu(double a, double b, double c, double d, double x) {return a*x*x*x+b*x*x+c*x+d;}
double Pv(double a, double b, double c, double d, double x) {return 3*a*x*x+2*b*x+c;}


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
void deviation(double *u, int N) {
	int i;
	FILE *gpp = gpinit();
	fprintf(gpp,"set multiplot\n");
	fprintf(gpp,"plot '-' w line \n");
	for (i = 0; i < N; i++) {
		fprintf(gpp, "%.6f %.6f\n", X(i,N), U(0, X(i,N)));
	}
	fprintf(gpp,"e\n");
	fprintf(gpp,"plot '-' w line lt 0 lw 3\n");
	for (i = 0; i < N; i++) {
		fprintf(gpp, "%.6f %.6f\n", X(i,N), u[i]);
	}
	fprintf(gpp,"e\n");
	fflush(gpp);
	sleep(3);
	fprintf(gpp,"unset multiplot\n");
	pclose(gpp);
	return;
}
double residual(double *u, int N) {
	double *r = (double *) malloc(N*sizeof(double));
	double max = 0.0, sum = 0.0;
	int i;
	for (i = 2; i < N-2; i++) {
		r[i] = ABS((U(0,X(i,N))-u[i]));
		sum += r[i];
		if (r[i] > max) {max = r[i];}
	}
	 FILE *gpp = gpinit();
	 fprintf(gpp,"set yrange [0:*]\n");
	 fprintf(gpp,"plot '-' w impulses\n");
	 for (i = 0; i < N; i++) {
	 	fprintf(gpp, "%.6f %.6f\n", X(i,N), r[i]);
	 }
	 fprintf(gpp,"e\n");
	 fflush(gpp);
	 sleep(3);
	free(r);
	printf("sum = %lg\n", sum*(B-A)/N);
	return max;
}

