#include <stdio.h>
#include <stdlib.h>
#include <math.h> 

int main()
{   
    int weights[2];
    printf("Enter the weight of two weights.. "); scanf("%i %i", &weights[0], &weights[1]);

    if ( weights[0] % 2 == 0 && weights[1] % 2 == 0 || weights[0] == weights[1] ) printf("Ben: No.\n");
    else 
    { 
        printf("Weight 1: %i\nWeight 2: %i\n",weights[0], weights[1]);

        int storage_1 = 0, storage_2 = 0; 
        int k1_s,k2_s,k3_s,k4_s,exit;
        
        for ( int k1 = 0; k1 <= 100; k1++ )
        { 
            if ( exit == 1 ) break; 
            for ( int k2 = 0; k2 <= 100; k2++ ) 
            {
                if ( exit == 1 ) break; 
                for ( int k3 = 0; k3 <= 100; k3++ ) 
                {
                    if ( exit == 1 ) break; 
                    for ( int k4 = 0; k4 <= 100; k4++ )
                    {
                        if ( abs( ( k1*weights[0] + k2*weights[1] ) - ( k3*weights[1] + k4*weights[0] ) ) == 1 ) 
                        { 
                            printf("[k1 = %i] [k2 = %i] [k3 = %i] [k4 = %i] \n", k1,k2,k3,k4);
                            k1_s = k1; k2_s = k2; k3_s = k3; k4_s = k4;
                            exit = 1;
                            break;
                        }
                    }             
                }
            }
        } 
        
        printf("Weitght Left: %i\n", k1_s*weights[0] + k2_s*weights[1]);
        printf("Weitght Right: %i\n", k3_s*weights[1] + k4_s*weights[0]);
    }
    return 0;
}
