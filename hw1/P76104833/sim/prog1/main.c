#include<stdlib.h>
#define MAX_SIZE 100

extern int array_size;
extern int array_addr;
extern int _test_start;

int num_list[MAX_SIZE];

int main() {

	int tmp,i,j;

	for(i=0;i<array_size;++i) num_list[i] = *(&array_addr+i);

	for(i=array_size-1;i;--i){
		for(j=0;j<i;++j) {
			if(num_list[j]>num_list[j+1]) {
				tmp = num_list[j];
				num_list[j]=num_list[j+1];
				num_list[j+1]=tmp;
			}
		}
	}

	for(i=0;i<array_size;++i) *(&_test_start+i) = num_list[i];

	return 0;
}

