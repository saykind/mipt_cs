#include <stdio.h>
#include <string.h>
#define L 100
int parser(char s[L]);

//int myadd(int a, int b) {return a+b;}
//int mysub(int a, int b) {return a-b;}
//int mydiv(int a, int b) {return a/b;}
//int mymod(int a, int b) {return a%b}
//int mymul(int a, int b) {return a*b;}
//int myinc(int a)	{return ++a;}
//int mydec(int a)	{return --a;}

int main () {
	int a;
	int b;
	char s[L];
	fgets(s, L, stdin);
	printf("\n%d\n", parser(s));
	return 0;
}
int parser(char s[]) {
	int a = 0, b = 0, d = 0; char c = 0;
	sscanf(s,"%d %d %c", &a, &b, &c);
	switch (c) {
		case '+': {d = myadd(a, b); break;}
		case '-': {d = mysub(a, b); break;}
		case '*': {d = mymul(a, b); break;}
		case '/': {d = mydiv(a, b); break;}
		case '%': {d = mymod(a, b); break;}
		case 'i': {d = myinc(a);    break;}
		case 'd': {d = mydec(a);    break;}
		default:  {break;}
	}
	return d;
}
