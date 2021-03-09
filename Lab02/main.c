#include <stdio.h>
extern long long int test();
extern long long int lab02b();
extern void lab02c(long long int a);
extern long long int lab02d(long long int b);
int main(void)
{
  test();
  lab02b();
  lab02c(100);
  long long int result = lab02d(100);
  printf("The address of the result is: %ld\n", result) ;
    return 0;
}
