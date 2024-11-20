#include <stdio.h> 
#include <stdlib.h> 
#include <math.h> 
#include <time.h>

#define Work1_ArrLen 7
#define Work2_ArrLen 20 
#define Work3_ArrLen 6 

#define Work4_MLen 3 
#define Work4_WLen 23 

int min_value(int a, int b) 
{ 
    if ( a < b ) return a; 
    if ( a > b ) return b; 
}

void Work1() 
{
    int arr[Work1_ArrLen][Work1_ArrLen] = { 
        {   0,   43,  15,  30,  35,  40,  20    }, 
        {   0,   0,   25,  34,  70,  62,  60    }, 
        {   0,   0,   0,   55,  10,  38,  27    },
        {   0,   0,   0,   0,   86,  12,  35    },
        {   0,   0,   0,   0,   0,   16,  37    },
        {   0,   0,   0,   0,   0,   0,   28    },
        {   0,   0,   0,   0,   0,   0,   0     },
    };
    
    for ( int i = 0; i < Work1_ArrLen; i++ ) 
    { 
        for ( int k = 0; k < Work1_ArrLen; k++ ) 
            printf("%i\t", arr[i][k]); 
        
        printf("\n\n");
    } 
    
    int summ = 0; 
    for ( int i = 0; i < Work1_ArrLen; i++ ) 
    { 
        int  min = 100000; 
        for ( int k = 0; k < Work1_ArrLen; k++ )
        {  
            if ( arr[k][i] < min && arr[k][i] != 0 ) min = arr[k][i];  
        } 
        summ+=min;
    } 
    
    printf("\nMin price: %i\n", summ - 100000);
} 


void Work2() 
{ 
    int inf = 2147483647;
    
     
    int arr[Work2_ArrLen][Work2_ArrLen] = { 
        //  1      2     3     4     5    6     7     8     9     10    11    12    13    14    15    16    17    18    19    20
        {   0,    9,    inf,  inf,  inf,  8,    inf,  inf,  inf,  inf,  inf,  inf,  inf,  inf,  inf,  inf,  inf,  inf,  inf,  inf }, // 1
        {   9,    0,    6,    inf,  inf,  10,   4,    inf,  inf,  inf,  inf,  inf,  inf,  inf,  inf,  inf,  inf,  inf,  inf,  inf }, // 2
        {   inf,  6,    0,    5,    inf,  inf,  8,    3,    7,    inf,  inf,  inf,  inf,  inf,  inf,  inf,  inf,  inf,  inf,  inf }, // 3
        {   inf,  inf,  5,    0,    4,    inf,  inf,  inf,  3,    inf,  inf,  inf,  inf,  inf,  inf,  inf,  inf,  inf,  inf,  inf }, // 4 
        {   inf,  inf,  inf,  4,    0,    inf,  inf,  inf,  4,    7,    inf,  inf,  inf,  inf,  inf,  inf,  inf,  inf,  inf,  inf }, // 5
        {   8,    10,   inf,  inf,  inf,  0,    4,    inf,  inf,  inf,  6,    inf,  inf,  inf,  inf,  inf,  inf,  inf,  inf,  inf }, // 6
        {   inf,  4,    8,    inf,  inf,  4,    0,    2,    inf,  inf,  7,    4,    inf,  inf,  inf,  inf,  inf,  inf,  inf,  inf }, // 7
        {   inf,  inf,  3,    inf,  inf,  inf,  2,    0,    7,    inf,  inf,  5,    7,    2,    inf,  inf,  inf,  inf,  inf,  inf }, // 8
        {   inf,  inf,  7,    3,    4,    inf,  inf,  7,    0,    5,    inf,  inf,  inf,  inf,  inf,  inf,  inf,  inf,  inf,  inf }, // 9
        {   inf,  inf,  inf,  inf,  7,    inf,  inf,  inf,   5,   0,    inf,  inf,  inf,  8,    7,    inf,  inf,  inf,  inf,  inf }, // 10
        {   inf,  inf,  inf,  inf,  inf,  6,    7,    inf,  inf,  inf,  0,    6,    inf,  inf,  inf,  3,    inf,  inf,  inf,  inf }, // 11 
        {   inf,  inf,  inf,  inf,  inf,  inf,  4,    5,    inf,  inf,  6,    0,    3,    inf,  inf,  9,    7,    8,    inf,  inf }, // 12 
        {   inf,  inf,  inf,  inf,  inf,  inf,  inf,  7,    inf,  inf,  inf,  3,    0,    5,    inf,  inf,  inf,  5,    4,    inf }, // 13
        {   inf,  inf,  inf,  inf,  inf,  inf,  inf,  2,    4,    8,    inf,  inf,  5,    0,    5,    inf,  inf,  inf,  2,    4   }, // 14 
        {   inf,  inf,  inf,  inf,  inf,  inf,  inf,  inf,  inf,  7,    inf,  inf,  inf,  5,    0,    inf,  inf,  inf,  inf,  3   }, // 15 
        {   inf,  inf,  inf,  inf,  inf,  inf,  inf,  inf,  inf,  inf,  3,    9,    inf,  inf,  inf,  0,    8,    inf,  inf,  inf }, // 16 
        {   inf,  inf,  inf,  inf,  inf,  inf,  inf,  inf,  inf,  inf,  inf,  7,    inf,  inf,  inf,  8,    0,    6,    inf,  inf }, // 17 
        {   inf,  inf,  inf,  inf,  inf,  inf,  inf,  inf,  inf,  inf,  inf,  8,    5,    inf,  inf,  inf,  6,    0,    9,    inf }, // 18 
        {   inf,  inf,  inf,  inf,  inf,  inf,  inf,  inf,  inf,  inf,  inf,  inf,  4,    2,    inf,  inf,  inf,  9,    0,    4   }, // 19
        {   inf,  inf,  inf,  inf,  inf,  inf,  inf,  inf,  inf,  inf,  inf,  inf,  inf,  4,    3,    inf,  inf,  inf,  4,    0   }  // 20 
    };
    
    int U_arr[Work2_ArrLen]; // Таблица кратчайших путей
    int P_arr[Work2_ArrLen]; // Область посещённых вершин

    int start = 0; // 1 - 1 
    int finish = 19; // 20 - 1 

    
    // step 1 
    int cur_p = start;   
    P_arr[cur_p] = 1;
    
    for ( int i = 0; i < Work2_ArrLen; i++ ) 
    { 
        if (i == start)
            { U_arr[i] = 0; }
        else 
            { U_arr[i] = inf; }  
    } 
    // end of step 1 

    while (cur_p != finish) 
    { 
        for ( int i = 0; i < Work2_ArrLen; i++) 
        {
            if ( arr[cur_p][i] != inf ) 
            { 
                U_arr[i] = min_value(U_arr[i], U_arr[cur_p] + arr[cur_p][i]); 
            }
        }
        printf("%i->",cur_p);
        int min_value = inf; 

        for (int i = 0; i < Work2_ArrLen; i++) 
        { 
            if ( P_arr[i] != 1 && U_arr[i] < min_value ) 
            { 
                min_value = U_arr[i];
                cur_p = i; 
            }
        }
        P_arr[cur_p] = 1;
    }
    printf("Answer: %i\n", U_arr[finish]);

    for(int i = 0; i < Work2_ArrLen; i++ ) 
    { 
        printf("%i ",U_arr[i]);
    }
} 

void Work3() 
{ 
    int inf = 2147483647;
    int arr[Work3_ArrLen][Work3_ArrLen] = { 
       //A      B      C      D      E     F
        {inf,   450,   inf,   350,   180,  300}, // A
        {450,   inf,   500,   250,   400,  280}, // B
        {inf,   500,   inf,   270,   360,  300}, // C
        {350,   250,   270,   inf,   450,  inf}, // D
        {180,   400,   360,   450,   inf,  370}, // E
        {300,   280,   300,   inf,   370,  inf}, // F
    };
    int P_arr[Work3_ArrLen]; 
    
    char idx_v_to_word[Work3_ArrLen] = { 'A', 'B', 'C', 'D', 'E', 'F' }; 
    
    int sum = 0; 
    
    int finish = 5; 
    int start = 0; 
    
    
    int cur_point = start; 
    P_arr[cur_point] = 1; 
    
    while ( 1 ) 
    { 
        int next_point; 
        int min = inf; 
        
        printf("(%c,",idx_v_to_word[cur_point]);
        for ( int i = 0; i < Work3_ArrLen; i++ ) 
        { 
            if ( P_arr[i] != 1 &&  arr[cur_point][i] < min )
            { 
                min = arr[cur_point][i]; 
                next_point = i; 
            } 
        } 

        printf("%c) = %i\n", idx_v_to_word[next_point], min); 
        
        P_arr[next_point] = 1; 
        
        cur_point = next_point; 
        sum += min; 
        
        if ( next_point == finish )
        {   
            printf("(%c,%c) = %i\n",idx_v_to_word[cur_point], idx_v_to_word[start], arr[cur_point][start] );
            sum += arr[cur_point][start]; 
            break; 
        } 
    } 
    
    printf("Min price length: %i\n", sum); 
}

void Work4() 
{   
    int M_arr[Work4_MLen];
    for ( int i = 0; i < Work4_MLen; i++) M_arr[i] = 0; 

    int N_W = 23; 
    int M_work[Work4_WLen] = {21, 27, 24, 86, 7, 48, 46, 84, 52, 45, 68, 64, 83, 75, 6, 78, 63, 65, 50, 42, 12, 70, 46};
    int M_summ = 0; 
 
    for ( int i = 0; i < Work4_WLen; i++ ) 
    {
        M_summ += M_work[i];
    }

    printf("Sum of Works: %i\n", M_summ);
    srand(time(0)); 
    while ( M_summ != 0 ) 
    { 
        int min_m; 
        if ( M_arr[0] <= M_arr[1] && M_arr[0] <= M_arr[2] ) min_m = 0; 
        if ( M_arr[1] <= M_arr[0] && M_arr[1] <= M_arr[2] ) min_m = 1; 
        if ( M_arr[2] <= M_arr[0] && M_arr[2] <= M_arr[1] ) min_m = 2;  

        int rand_work = rand() % (22 - 0 + 1);

        M_arr[min_m] += M_work[rand_work]; 
        M_summ = M_summ - M_work[rand_work]; 
        M_work[rand_work] = 0; 

        for ( int i = 0; i < Work4_WLen; i++ ) 
        {
            printf("%i ",M_work[i]); 
        }

        printf("[%i][%i]\n", rand_work,M_summ);
    }

    for ( int i = 0; i < Work4_MLen; i++ ) 
    { 
        printf("%i \n", M_arr[i]);
    }
}

int main()
{ 
    Work3();

} 
