/* main.c simple program to test assembler program */

#include <stdio.h>

extern long long int test(long long int a, long long int b);
extern long long int lab03b();
extern long long int lab03c();

int main(void)
{
    long long int a = test(3, 5);
    printf("Result of test(3, 5) = %ld\n", a);
    long long int ans = lab03b();
    printf("My UIN is 627003137, total 29. Result of lab03b() is = %ld\n", ans);
    long long int ans2 = lab03c();
    printf("My array is updated. Check by using x/10dw in gdb\n");
    return 0;
}
