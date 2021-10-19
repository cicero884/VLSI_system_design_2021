extern int mul1;
extern int mul2;
extern int _test_start;

union splitter{
	unsigned int split[2];
	unsigned long long combined;
} mul_result;
int main(){
	unsigned long long mul1_l=(unsigned long long)mul1;
	unsigned long long mul2_l=(unsigned long long)mul2;
	mul_result.combined=0;

	//mul_result.combined=mul1*mul2;
	for(;mul1_l;mul1_l>>=1){
		if(mul1_l&1) mul_result.combined+=mul2_l;
		mul2_l<<=1;
	}
	
	*(&_test_start)=(int)mul_result.split[0];
	*(&_test_start+1)=(int)mul_result.split[1];
	return 0;
}
