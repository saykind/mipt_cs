#include <string.h>
#define N 20
struct person {
	char surname[N];
	char name[N];
	char age;
} BigGuy;
int main (void) {
	struct person SmallBoy ;
	strcpy(SmallBoy.surname, "Small");
	strcpy(SmallBoy.name, "Boy");
	SmallBoy.age = 7;
	return 0;
}
