#include <stdio.h>

char 	glob_char_init = 54;
char	glob_char_uninit;
int 	glob_int_init = 54;
int 	glob_int_uninit;
long int 	glob_long_int_uninit;
long long int 	glob_long_long_int_uninit;

float 	glob_float_init = 0.54;
float 	glob_float_uninit;
double 	glob_double_init = 0.54;
double 	glob_double_uninit;

int main(void) {
	return 0;
}

int *my_func(int a) {
	a++;
	return &a;
}
