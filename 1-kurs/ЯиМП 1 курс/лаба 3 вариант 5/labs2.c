#include <stdio.h>
#include <math.h>

int main()
{
    printf("Script Is Work. \n");
    
    int k, S; 
    printf("Insert summ: "); scanf("%i", &S); 
    
    k = 0;
    while ( S != 0 ) 
    { 
        if ( S - 500 >= 0 ) { S -= 500; k++; printf("Отдано 500 \n"); }  
        else if ( S - 100 >= 0 ) { S -= 100; k++; printf("Отдано 100 \n"); } 
        else if ( S - 50  >= 0 ) { S -= 50 ; k++; printf("Отдано 50 \n"); } 
        else if ( S - 10  >= 0 ) { S -= 10 ; k++; printf("Отдано 10 \n"); } 
        else if ( S - 5   >= 0 ) { S -= 5  ; k++; printf("Отдано 5 \n"); } 
        else if ( S - 2   >= 0 ) { S -= 2  ; k++; printf("Отдано 2 \n"); } 
        else if ( S - 1   >= 0 ) { S -= 1  ; k++; printf("Отдано 1 \n"); }         
    } 
    
    printf("Купюр отдано: %i \n", k);
    return 0;
}
