#include <stdlib.h>
int main(void){
	char* p1 = malloc(5);
	p1[3] = 'd';
	free(p1);
	char* p2 = realloc(p1, 5);
	return p2[3];
}
