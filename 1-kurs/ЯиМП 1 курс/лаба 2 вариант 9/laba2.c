#include <stdio.h>
#include <math.h>


int main()
{
    printf("Script Is Work. \n");
    
    int x,y;
    
    printf("Insert numbers (x,y):  "); scanf("%i %i", &x, &y);
    
    if ( y <= 3 && y >= -1 && x + y <= 2 && 2*x + y >= -3 )
    { 
        printf("Yes!\n");
    } 
    else 
    { 
        printf("No!\n"); 
    } 
    return 0;
}
