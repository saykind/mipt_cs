#include <stdio.h>
int array[2][3] = {	{1, 2, 5}, 
		 	{-1, 10, 0}	};
int main (void) {
	int M = 2, N =3;	
	int max = array[0][0];
	int i, j;
	for (i = 0; i < M; i++) {
		for (j = 0; j < N; j++) {
			if (array[i][j] > max) {max = array[i][j];}
		}
	}
	printf("%d\n", max);
	return 0;
}
