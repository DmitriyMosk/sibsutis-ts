#include <stdio.h> 
#include <stdlib.h> 
#include <math.h> 
#include <time.h>

/////
void NumberTranslation(int n, int arg, int *summ) 
{   
    if ( arg == 10 ) *summ = n;
    if( n != 0 ) 
    { 
        NumberTranslation(n / arg, arg, summ);
        *summ = *summ*10 + n % arg; 
    }
}

/////
void Work1() 
{ 
    const int N = 7; 
    
    if ( N % 2 == 0 ) exit(0);
    
    int arr[N][N]; 
    
    int Ax,Ay;
    int Bx,By; 
    int Cx,Cy; 
    int Dx,Dy; 
    /////////////////////////////
    Ax = 0;      Ay = N / 2; 
    Bx = N / 2;  By = N - 1; 
    Cx = N - 1;  Cy = N / 2; 
    Dx = N / 2;  Dy = 0; 

    printf("A(%i,%i) B(%i,%i) C(%i,%i) D(%i,%i)\n\n",Ax,Ay,Bx,By,Cx,Cy,Dx,Dy);

    for ( int x = 0; x < N; x++) 
    { 
        for ( int y = 0; y < N; y++)
        {
            int line1 = ( x - Ax ) * ( By - Ay ) - ( y - Ay ) * ( Bx - Ax ); // A -> B 
            int line2 = ( x - Cx ) * ( By - Cy ) - ( y - Cy ) * ( Bx - Cx ); // C -> B  
            int line3 = ( x - Cx ) * ( Dy - Cy ) - ( y - Cy ) * ( Dx - Cx ); // C -> D 
            int line4 = ( x - Dx ) * ( Ay - Dy ) - ( y - Dy ) * ( Ax - Dx ); // D -> A 

            arr[x][y] = ( line1 >= 0 && line2 <= 0 && line3 >= 0 && line4 >= 0 ) ? 1 : 0;       

            printf("%i    ",arr[x][y]);
        }
        printf("\n\n");
    }       
} 

void Work2() 
{ 
    printf("START\n");
    //int N,M; 
    //printf("Insert size NxM of array: "); scanf("%i %i", &N, &M); 

    //srand(time(0)); 

    //int **Arr = (int **)malloc(N*sizeof(int *));
    //for(int i = 0; i < N; i++) {
    //    Arr[i] = (int *)malloc(M*sizeof(int));
    //}

    const int N = 3; 
    const int M = 3; 

    int Arr[3][3] = { {2, 3, 2}, {1, 1, 2}, {1, 1, 2} };

    for ( int i = 0; i < M; i++) 
    {
        for ( int j = 0; j < N; j++ )
        { 
            printf("%i    ",Arr[i][j]);
        }
        printf("\n\n");
    }

    int duplicate_find = 0;  
    int duplicate_count = 0;

    int _arr_string = 0; 
    int _arr_column = 0; 
    
    int _arr_string_next = 1;
    while ( duplicate_find == 0 )
    {   
        //printf("Arr[%i][%i] ~ Arr[%i][%i]\n",_arr_string,_arr_column,_arr_string + _arr_string_next,_arr_column );

        if ( Arr[_arr_string][_arr_column] == Arr[_arr_string + _arr_string_next][_arr_column] ) 
        {   
            duplicate_count++; 
        }

        _arr_column++;

        if ( duplicate_count == N )
        {   
            duplicate_find = _arr_string + _arr_string_next; 
            break; 
        }

        if ( _arr_column == M ) { 
            _arr_column = 0;
            _arr_string_next++; 
            duplicate_count = 0;
        }

        if ( _arr_string_next == N ) 
        {
            _arr_string_next = 1; 
            _arr_string++;
        }
    } 
    
    for ( int i = 0; i < M; i++) 
    {
        Arr[duplicate_find][i] = 0;
    }

    printf("Output: \n");
    for ( int i = 0; i < M; i++) 
    {
        for ( int j = 0; j < N; j++ )
        {   
            printf("%i    ",Arr[i][j]);
        }
        printf("\n\n");
    }
}

//////////////////////////////////////////////////////////

void Work3() 
{ 
    #define Work3_N 3

    int a_Arr[Work3_N][Work3_N];
    int b_Arr[Work3_N][Work3_N];
    int c_Arr[Work3_N][Work3_N];

    srand(time(0));

    for ( int i = 0; i < Work3_N; i++ )
    {
        for ( int j = 0; j < Work3_N; j++ )
        {
            a_Arr[i][j] = rand() % 10 - 3;
            b_Arr[i][j] = rand() % 3 + 4;
        }
    }

    printf("Start: \nA:\n");
    for ( int i = 0; i < Work3_N; i++) 
    {
        for ( int j = 0; j < Work3_N; j++ )
        { 
            printf("%i    ",a_Arr[i][j]);
        }
        printf("\n\n");
    }

    printf("B:\n");
    for ( int i = 0; i < Work3_N; i++) 
    {
        for ( int j = 0; j < Work3_N; j++ )
        { 
            printf("%i    ",b_Arr[i][j]);
        }
        printf("\n\n");
    }

    printf("Output: \n"); 
    int summ; 
    for ( int i = 0; i < Work3_N; i++) 
    {   
        for ( int j = 0; j < Work3_N; j++ )
        {   
            summ = 0;
            for ( int k = 0; k < Work3_N; k++ )
            {
                summ += a_Arr[i][k] * b_Arr[k][j];
                //printf("C[%i][%i] += a_Arr[%i][%i]*b_Arr[%i][%i]\n", i,j,i,j+k,i+k,j);
            }
            if ( i == j ) { summ -= 3; }
            printf("%i    ",summ);
        }
        printf("\n\n");
    }
}

void Work4() 
{ 
    #define Work4_N 3

    if ( Work4_N > 10 || Work4_N <= 1 ) exit(0);

    int Arr[Work4_N][Work4_N];

    int summ; 
    //printf("%i\n",summ);
    // ох, мля

    for ( int i = 0; i < Work4_N; i++ )
    {
        Arr[i][0] = i;
        for ( int j = 0; j < Work4_N; j++ )
        {   
            if ( i == 0 ) 
            {
                Arr[i][j] = j;
            } 
            else 
            { 
                
                if ( j != 0 ) {
                    summ = 0;
                    NumberTranslation(i*j, Work4_N, &summ);
                    Arr[i][j] = summ;
                } 
        
                
                
            }
            
            

            printf("%i\t",Arr[i][j]);
        }
        printf("\n\n");
    }
}

void Work5() 
{ 
    #define Work5_N 6
    
    srand(time(0)); 
    
    int Arr[Work5_N][Work5_N]; 
    
    printf("Input: \n"); 
    for ( int i = 0; i < Work5_N; i++ ) 
    { 
        for ( int j = 0; j < Work5_N; j++ ) 
        { 
            Arr[i][j] = rand() % 10 + 3;
            printf("%i\t",Arr[i][j]); 
        } 
        printf("\n\n");
    } 
    printf("\n");
    for ( int i = 0; i < Work5_N; i++ ) 
    { 
        for ( int j = 0; j < Work5_N; j++ ) 
        { 
            if ( i > j  ) 
            { 
                Arr[i][j] = 0; 
                printf("[%i]\t",Arr[i][j]); 
            } 
            else printf("%i\t",Arr[i][j]); 
        } 
        printf("\n\n");
    } 
} 

int main() 
{   
    //Work1();
    //Work2();
    //Work3();
    //Work4();
    Work5();
    return 0;
} 
 
