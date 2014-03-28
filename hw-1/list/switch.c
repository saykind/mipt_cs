#include <stdio.h>
int main (void) {
	char c;
	scanf("%c", &c);
	switch (c) {
	case '+': { printf("+"); break; }
	case '-': { printf("-"); break; }
	default : { break; }
	}
	return 0;
}
