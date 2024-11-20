#include <stdio.h>
#include <math.h>


int main()
{
    printf("Script Is Work. \n");
    
    int a,b,c; 
    
    scanf("%i %i %i", &a, &b, &c);
    
    if ( a < b ) 
    { 
        if ( b < c ) 
        {
            printf("Increase. \n");
        } 
        else 
        { 
            printf("Random. \n");
        } 
    } 
    else 
    { 
        if ( b > c )
        { 
            printf("Descending. \n");
        } 
        else 
        { 
            printf("Random. \n");
        } 
             
    } 
    
    return 0;
}
