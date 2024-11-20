#include <stdio.h>
void dectobit(int n) 
{   
    if (n != 0) 
    {
        dectobit(n >> 1); 
        printf("%i",n&1);
    } 
}

int main()
{
    int N; 
    printf("Insert number N: ");scanf("%i",&N);
    
    printf("Output: "); 
        dectobit(N);
    printf("\n"); 
    return 0;
}
