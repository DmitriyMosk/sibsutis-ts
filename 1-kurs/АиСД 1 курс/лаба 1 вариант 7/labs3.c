#include <stdio.h>

int main()
{
    int a,b; 
    printf("Введите числa a, b: "); 
    scanf("%i %i",&a, &b); 
    
    while ( a != 0 && b != 0 ) 
    {
        if ( a > b ) 
            a = a % b;
        else 
            b = b % a;
    } 
    printf("Output: %i \n", a + b); 
    return 0;
}
