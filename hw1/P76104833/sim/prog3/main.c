extern int div1;
extern int div2;
extern int _test_start;

int main(){
	int a=div1;
	int b=div2;

	while(a!=b){
		if(a > b) a-=b;
		else b-=a;
	}

	*(&_test_start)=a;
}
