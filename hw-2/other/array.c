#include <stdio.h>
double sumOfArray(double *a, int N) {
	int i;
	double s = 0;
	for (i = 0; i < N; i++) {
		s += *(a+i);
	}
	return s;
}
		
int main(void) {
	double a[] = {1.1,2,3,4,5,6};
	int N = 6;
	printf("= %f\n",a[5], sumOfArray(a, N));
	return 0;
}
