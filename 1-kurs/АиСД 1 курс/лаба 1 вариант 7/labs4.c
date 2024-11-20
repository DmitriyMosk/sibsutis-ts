#include <stdio.h>
#include <stdio.h>

int Evklid(int a, int b)
{
    while ( a != 0 && b != 0 ) 
    {
        if ( a > b ) 
            a = a % b;
        else 
            b = b % a;
    } 
    return a + b;
}

int main()
{
    int a,b,c,d; 
    
    for (int a=1; a <= 10000; a++) 
    { 
        for (int b=1; b <= 10000; b++) 
        { 
            for (int c=1; c <= 10000; c++)
            {
                for ( int d=1; d<= 10000; d++ ) 
                { 
                    if ( Evklid(a*d-c*b, b*d) == 1) 
                    { 
                        printf("a = %i b = %i c = %i d = %i\n",a,b,c,d);
                        printf("Числитель: %i\nЗнаменатель: %i\n",a*d-c*b,b*d);
                    } 
                } 
            } 
        } 
        printf("---------------------\n");
    } 
    return 0;
}
