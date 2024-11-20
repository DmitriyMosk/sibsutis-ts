#include <stdio.h>
#include <math.h>

void Winter() { printf("Winter. \n"); } 
void Spring() { printf("Spring. \n"); } 
void Summer() { printf("Summer. \n"); } 
void Autumn() { printf("Autumn. \n"); } 

int main()
{
    printf("Script Is Work. \n");
    
    int month; 
    scanf("%i", &month); 
    
    switch(month) 
    {
        case 1: 
        {
            Winter(); 
            break;
        }
        case 2: 
        { 
            Winter(); 
            break;
        } 
        case 3: 
        {
            Spring(); 
            break;
        }
        case 4: 
        { 
            Spring(); 
            break;
        }         
        case 5: 
        {
            Spring(); 
            break;
        }
        case 6: 
        { 
            Summer(); 
            break;
        } 
        case 7: 
        {
            Summer(); 
            break;
        }
        case 8: 
        { 
            Summer(); 
            break;
        } 
        case 9: 
        {
            Autumn(); 
            break;
        }
        case 10: 
        { 
            Autumn(); 
            break;
        } 
        case 11: 
        {
            Autumn(); 
            break;
        }
        case 12: 
        { 
            Winter(); 
            break;
        }         
    } 
    
    return 0;
}
