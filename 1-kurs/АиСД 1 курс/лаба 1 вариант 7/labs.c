#include <stdio.h>
#include <math.h>

int main()
{
    int a,b,c; 
    int katet; 
    
    printf("Insert numbers (a,b,c): "); 
    scanf("%i %i %i",&a,&b,&c); 
    
    if ( a > b && b > c ) 
    {
        katet = a;
        a = 0; 
    } 
    if ( b > a && b > c ) 
    { 
        katet = b; 
        b = 0; 
    } 
    if ( c > a && c > b )  
    { 
        katet = c; 
        c = 0;
    } 
    
    if ( pow(katet,2) == ( pow(a,2) + pow(b,2) + pow(c,2) ) ) { printf("Yes!\n"); }  
    else { printf("No!\n"); } 
    return 0;
}
