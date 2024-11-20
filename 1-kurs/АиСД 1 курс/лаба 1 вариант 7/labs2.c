#include <stdio.h>
#include <math.h>

int main()
{
    int N, digit, rev_N; 
    printf("Insert number N: "); 
    scanf("%i",&N); 
    
    rev_N = 0; 
    while ( N != 0 ) 
    {
        digit = N % 10; 
        
        rev_N = rev_N * 10 + digit;
        
        N = N / 10;
    } 
    printf("Output: %i \n", rev_N); 
    return 0;
}
