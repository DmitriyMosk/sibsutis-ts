#include <stdio.h>
#include <stdlib.h> 
#include <math.h> 
#include <time.h> 

int main()
{
    printf("Script Is Work. \n");
    
    srand(time(0)); 
    int xi_last; 
    
    int x0 = rand() % 10;
    int x1 = (x0 * x0) % 11; 
    int x2 = (x1 * x1) % 11;
    
    printf("X = { %i %i ", x1, x2); 
    
    while ( x1 != x2)
    {   
        x2 = (x2 * x2) % 11;
        
        if ( x1 == x2 ) break; 
        printf("%i ",x2);
    }
    
    printf("} \n");
    return 0;
}
