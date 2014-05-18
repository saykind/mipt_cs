#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define A -1.0
#define B 1.0
#define Cx 1
#define Cy 1
#define Kx 0.5
#define KX 2
#define Ky 0.5
#define KY 2
#define X(i,N) (A+1.0*i*(B-A)/N) 
#define Y(i,N) (A+1.0*i*(B-A)/N) 
#define O(i,N) (i>0 ? (i): (i+N))
#define ABS(a) (a>0 ? (a): (-a))

double **advection(int N);
double  U(double t, double x, double y);
double 	V(double t, double x, double y);
double  linear(double x1, double y1, double x2, double y2, double x0);
double *cubic(double dx, double K, double u1, double v1, double u2, double v2);
double 	Pu(double a, double b, double c, double d, double x);
double 	Pv(double a, double b, double c, double d, double x);
void	print_array(double **u, int N);
FILE   *gpinit(void);
void 	plot(FILE *gpp, double **u, int N);
void 	deviation(double **u, int N);
double	residual(double **u, int N);

int main(void) {
	int i, N = 100;
	double **u = advection(N);
//	deviation(u, N);
	double R = residual(u, N);
	printf("Max residual = %lg\n", R);
	for (i = 0; i < N; i++) {free(*(u+i));}	free(u);
	return 0;
}

double **advection(int N) {
	int i, j, t, M, K;
	double **u = (double **) malloc(N*sizeof(double *));
		for (i = 0; i < N; i++) 
		{*(u+i) = (double *) malloc(N*sizeof(double));}
	double **vx = (double **) malloc(N*sizeof(double *));
		for (i = 0; i < N; i++) 
		{*(vx+i) = (double *) malloc(N*sizeof(double));}
	double **vy = (double **) malloc(N*sizeof(double *));
		for (i = 0; i < N; i++) 
		{*(vy+i) = (double *) malloc(N*sizeof(double));}
	double dx = (B-A)/N;	
	double *dd = NULL;
	for (i = 0; i < N; i++) {for (j = 0; j < N; j++) {
		u[i][j] = U(0, X(i,N), Y(j,N));}}
	for (i = 0; i < N; i++) {for (j = 0; j < N; j++) {
		vx[i][j] = V(0, X(i,N), Y(j,N));}}
	for (i = 0; i < N; i++) {for (j = 0; j < N; j++) {
		vy[i][j] = V(0, X(i,N), Y(j,N));}}
	FILE *gpp = gpinit();
	plot(gpp, u, N);
	sleep(4);

	M = N*KX-1;
	for (t = 0; t < M; t++) {
		for (j = 0; j < N; j++) {
			for (i = N-1; i >= 0; i--) {
				dd = cubic(dx, Kx, u[O(i,N)-1][j], vx[O(i,N)-1][j], u[i][j], vx[i][j]); 
				u[i][j] = dd[0]; vx[i][j] = dd[1]; free(dd);
//				u[i][j] = linear(-dx, u[O(i,N)-1][j], 0, u[i][j], -Kx*dx);
				vy[i][j] = vy[O(i,N)-1][j];
			}
		}
		for (i = 0; i < N; i++) {
			for (j = N-1; j >= 0; j--) {
				dd = cubic(dx, Ky, u[i][O(j,N)-1], vy[i][O(j,N)-1], u[i][j], vy[i][j]); 
				u[i][j] = dd[0]; vy[i][j] = dd[1]; free(dd);
//				u[i][j] = linear(-dx, u[i][O(j,N)-1], 0, u[i][j], -Kx*dx);
				vx[i][j] = vx[i][O(j,N)-1];
			}
		}
		plot(gpp, u, N);
	}

	plot(gpp, u, N);
	sleep(4);
	pclose(gpp);
	for (i = 0; i < N; i++) {free(*(vx+i));}	free(vx);
	for (i = 0; i < N; i++) {free(*(vy+i));}	free(vy);
	return u;
}
double U(double t, double x, double y) {
	if (t == 0) {
		if ((x>=-0.5)&&(x<=0.5)&&(y>=-0.5)&&(y<=0.5)){return 1;} 
		else 	{return 0;}
	}
}
double V(double t, double x, double y) {
	if (t == 0) {
		if ( ( (x == -0.5)&&((y>=-0.5)&&(y<=0.5)) ) || ( (x == 0.5)&&((y>=-0.5)&&(y<=0.5)) ) ) {return 0;}
		else {return 0;}
	}
}
double linear(double x1, double y1, double x2, double y2, double x0) {
	double k = (y2-y1)/(x2-x1);
	double b =  y1-k*x1;
	return (k*x0+b);
}
double *cubic(double dx, double K, double u1, double v1, double u2, double v2) {
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
	fprintf(gpp, "set term wxt\n");
	fprintf(gpp, "unset key\n");
	fprintf(gpp, "unset border\n");
	fprintf(gpp, "set xlabel \"X\" \nset ylabel \"Y\" \n");
	fprintf(gpp, "set style fill solid\n");
	fprintf(gpp, "set zrange [-0.5:3.0]\n");
	fprintf(gpp, "set yrange [-1.5:1.5]\n");
	fprintf(gpp, "set xrange [-1.5:1.5]\n");
	return gpp;
}
void plot(FILE *gpp, double **u, int N) {
	int i, j;
	fprintf(gpp, "\nsplot '-' w boxes\n");
	for (i = 0; i < N; i++) {
		for (j = 0; j < N; j++) {
			fprintf(gpp, "%.6f %.6f %.6f\n", X(i,N), Y(j,N), u[i][j]);
		}
	}
	fprintf(gpp,"e\n");
	fflush(gpp);
	usleep(100);
}
void deviation(double **u, int N) {
	int i, j;
	FILE *gpp = gpinit();
	fprintf(gpp,"set multiplot\n");
	fprintf(gpp,"splot '-' w line \n");
	for (i = 0; i < N; i++) {
		for (j = 0; j < N; j++) {
			fprintf(gpp, "%.6f %.6f %.6f\n", X(i,N), Y(j,N), U(0, X(i,N), Y(j,N)));
		}
	}
	fprintf(gpp,"e\n");
	fprintf(gpp,"splot '-' w line lt 3 lw 0.5\n");
	for (i = 0; i < N; i++) {
		for (j = 0; j < N; j++) {
			fprintf(gpp, "%.6f %.6f %.6f\n", X(i,N), Y(j,N), u[i][j]);
		}
	}
	fprintf(gpp,"e\n");
	fflush(gpp);
	fprintf(gpp,"unset multiplot\n");
	sleep(10);
	pclose(gpp);
	return;
}
double residual(double **u, int N) {
	int i, j;
	double **r = (double **) malloc(N*sizeof(double *));
		for (i = 0; i < N; i++) 
		{*(r+i) = (double *) malloc(N*sizeof(double));}
	double max = 0.0;
	for (i = 0; i < N; i++) {
		for (j = 0; j < N; j++) {
			r[i][j] = ABS((U(0, X(i,N), Y(j,N))-u[i][j]));
			if (r[i][j] > max) {max = r[i][j];}
		}
	}
	 FILE *gpp = gpinit();
	 fprintf(gpp,"set zrange [0:*]\n");
	 fprintf(gpp,"splot '-' w impulses\n");
	 for (i = 0; i < N; i++) {
		 for (j = 0; j < N; j++)
	 	fprintf(gpp, "%.6f %.6f %.6f\n", X(i,N), Y(j,N), r[i][j]);
	 }
	 fprintf(gpp,"e\n");
	 fflush(gpp);
	 sleep(10);
	for (i = 0; i < N; i++) {free(*(r+i));} free(r);
	return max;
}

void	print_array(double **u, int N) {
	int i, j;
	for (i = 0; i < N; i++) {
		for (j = 0; j < N; j++) {
			printf("u[%d][%d] = \t%lg\n", i, j, u[i][j]);
		}
	}
}


