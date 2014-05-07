typedef struct Info {
	int N;
	int M;
	double h;
	double k;
	double R;
	double S;
} info;

double *advection(int N, int M);
double  U(double t, double x);
double 	V(double t, double x);
double  linear(double x1, double y1, double x2, double y2, double x0);
double *cubic(double dx, double u1, double v1, double u2, double v2);
FILE   *gpinit(void);
void 	plot(FILE *gpp, double *a, int N);
void 	compare(double *u, int N);
void	residual(double *u, info *I);
void 	iprint(info I);
void	iinit(info *I, int N);

#define A -1.0
#define B 1.0
#define C 1
#define K 0.2
#define MN 5
#define X(i,N) (A+1.0*i*(B-A)/N) 
#define O(i,N) (i>0 ? (i): (i+N))
#define ABS(a) (a>0 ? (a): (-a))

