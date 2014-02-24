int scanf(const char *format, ... );
int printf(const char *format, ... );
int power(int a, int n);
void print_bin(int a);
int main (void) {
	int a;
	scanf("%d", &a);
	print_bin(a);
	return 0;
}
void print_bin(int a) {
	int i;
	int p;
	for (i = 7; i >= 0; i--) {
		p = power(2, i);
		if (a / p) {
			putchar('1');
			a -= p;
		}
		else {putchar('0');}
	}
	putchar('\n');
}
int power(int a, int n) {
	if (n < 1) {return 1;}
	int i;
	int r = 1;
	for (i = 0; i < n; i++) {
		r = r*a;
	}
	return r;
}
