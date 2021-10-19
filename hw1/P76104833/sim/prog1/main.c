#include<stdlib.h>
int main() {
	extern int array_size;
	extern int array_addr;
	extern int _test_start;

	int num_list[array_size];

	int i, j, temp;

	for(i = 0; i < array_size; ++i) num_list[i] = *(&array_addr + i);

	for(i = array_size - 1; i ; --i) {
		for(j = 0; j < i ; ++j) {
			if(num_list[j] > num_list[j+1]) {
				temp = num_list[j];
				num_list[j] = num_list[j+1];
				num_list[j+1] = temp;
			}
		}
	}

	for(i = 0; i < array_size; ++i) *(&_test_start + i) = num_list[i];

