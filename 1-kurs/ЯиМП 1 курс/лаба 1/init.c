#include <stdio.h>    //библиотека ввода-вывода
#include <math.h> 

int main ()
{
    float x = 1; 
    
    long double Z1 = sqrt(pow((3*x+2),2) - 24*x)/(3*sqrt(x) - (2/sqrt(x)));
    long double Z2 = -(sqrt(x));

    printf ("Result math: \n z1: %Lf \n z2: %Lf \n ", Z1, Z2);
    
    return 0;
}
