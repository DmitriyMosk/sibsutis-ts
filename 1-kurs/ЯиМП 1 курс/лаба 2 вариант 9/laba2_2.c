#include <stdio.h>
#include <math.h>

int Work2(float x) 
{
    return ( ( 16 - pow(x,2) ) > 0 );
}

int main()
{
    printf("Script Is Work. \n");
    
    float x = 6;

    if(Work2(x) == 1)
    {
        printf("Belongs: (%f) \n",x); 
    }
    else
    {
        printf("Do no belong: (%f) \n", x);
    }; 
    
    return 0;
}
