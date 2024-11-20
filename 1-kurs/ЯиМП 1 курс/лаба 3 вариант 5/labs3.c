#include <stdio.h>
#include <stdlib.h>
#include <time.h> 

int main()
{
    printf("Script Is Work. \n");
    
    int a,k; 
    k = 0;
    
    srand(time(NULL));
    
    for ( int i = 0; i<=20; i++) 
    {
        a = rand() % 100 + 100; 
        printf("%i ",a); 
        
        if ( a % 5 == 2 && a % 8 == 3 ) { 
            k++; 
        }
        printf("[остаток 5, остаток 8] = %i, %i \n", a % 5, a % 8); 
        
    } 
    printf("\n");
    
    printf("Количество: %i \n",k);
    return 0;
}
