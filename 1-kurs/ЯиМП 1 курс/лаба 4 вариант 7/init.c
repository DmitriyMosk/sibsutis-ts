#include <stdio.h> 
#include <math.h> 
#include <stdlib.h> 
#include <time.h>

void Work1() 
{ 
    int N; 
    printf("Insert size of array: "); scanf("%i",&N);

    int *arr = malloc(N * sizeof(int));

    float summ = 0; 

    for ( int i = 0; i < N; i++)
    { 
        arr[i] = pow(i,2) + 1; 

        summ += arr[i]; 
    }
    printf("Average: %f", summ / N);
} 

void Work2() 
{
    int N; 
    printf("Insert size of array: "); scanf("%i",&N);

    int *arr = malloc(N * sizeof(int));

    srand(time(NULL));

    int MAX = 10; 
    int MIN = 2;  
    
    int MAX_VALUE = MIN; 
    int MIN_VALUE = MAX; 

    printf("######################################\n");
    printf("Arr out: ");
    int MAX_LEN_UP = 0; 
    int MAX_LEN_COUNT = 0; 
    int MAX_LEN_START_INDEX; 
    int MAX_LEN_START_INDEX_SAVE; 
    for ( int i = 0; i < N; i++ )
    { 
        arr[i] = rand() % (MAX - MIN + 1) + MIN;
        printf("%i ",arr[i]); 
        // point (a);
        if ( arr[i] > MAX_VALUE ) MAX_VALUE = arr[i]; 
        if ( arr[i] < MIN_VALUE ) MIN_VALUE = arr[i]; 

        //point (г); 
        if ( arr[(i > 0) ? i - 1 : i] < arr[i] ) 
        { 
            if ( MAX_LEN_COUNT == 0 ) MAX_LEN_START_INDEX = (i > 0) ? i - 1 : i; 
        
            MAX_LEN_COUNT++;
        }
        else 
        {   if ( MAX_LEN_COUNT > MAX_LEN_UP ) 
            { 
                MAX_LEN_UP = MAX_LEN_COUNT; 
                MAX_LEN_START_INDEX_SAVE = MAX_LEN_START_INDEX; 
            } 

            MAX_LEN_START_INDEX = 0; 
            MAX_LEN_COUNT = 0;
        }
    }
    printf("\n");
    printf("Max value: %i\n", MAX_VALUE); 
    printf("Min value: %i\n", MIN_VALUE); 
    printf("Min value index(es): ");
    // point (б);
    for ( int i = 0; i < N; i++ ) 
    { 
        if ( MIN_VALUE == arr[i] ) printf("%i ", i);
    }
    printf("\n"); 
    // point (в); 
    int freq; 
    int count = 0; 
    int MAX_COUNT = 0; 
    int MAX_COUNT_VALUE = 0;

    for ( int i = 0; i < N; i++ ) 
    {   
        freq = arr[i]; 
        for ( int k = 0; k < N; k++ ) 
        { 
            if(freq == arr[k]) count++;
        }
        if ( count > MAX_COUNT ) 
        {
            MAX_COUNT = count; 
            MAX_COUNT_VALUE = freq; 
        }
    }
    printf("Frequent element: %i\n",MAX_COUNT_VALUE); 
    printf("Increasing sequence: "); 
    for ( int i = MAX_LEN_START_INDEX_SAVE; i <= MAX_LEN_START_INDEX_SAVE + MAX_LEN_UP; i++) 
    { 
        printf("%i ",arr[i]); 
    }
    printf("\n");
    printf("######################################\n");
}

void Work3() 
{ 
    int N; 
    printf("Insert size of array: "); scanf("%i",&N);

    int *arr = malloc(N * sizeof(int));

    printf("######################################\n");
    printf("Arr: ");
    
    srand(time(0)); 
    for ( int i = 0; i < N; i++)
    {
        arr[i] = rand() % ( 30 + 20 + 1 ) - 20; // [-20; 30]
        printf("%i ",arr[i]);
    }
    printf("\n");

    printf("Arr edit(a): "); 
    //point (a);
    int copy = arr[0];
    for ( int i = 0; i < N; i++ ) arr[i] = arr[i+1];
    arr[N-1] = copy;
    for ( int i = 0; i < N; i++) printf("%i ", arr[i]);
    printf("\n");

    // point(б); 
    int N_edit = 0; 
    for ( int i = 0; i < N; i++)
    {
        for ( int k = 0; k < N - i - 1; k++) // in bubble sort 
        { 
            if ( arr[k] < 0 ) 
            { 
                copy = arr[k];
                arr[k] = arr[k+1]; 
                arr[k+1] = copy;
            }
        }
        if ( arr[i] >= 0 ) N_edit++;
    }
    //for ( int i = 0; i < N; i++) printf("%i ", arr[i]);
    //printf("\n");

    N = N_edit; 
    arr = (int*) realloc(arr, N * sizeof(int)); 
    
    printf("Arr compress(b): ");
    for ( int i = 0; i < N; i++) printf("%i ", arr[i]);
    printf("\n");

    int *arr_2 = malloc(N * sizeof(int)); 
    int i,k; 
    printf("Arr two(c): ");
    for ( i = 0, k = 0; i < N; i++) 
    {
        if ( arr[i] <= i ) {
            arr_2[k] = arr[i]; 
            printf("%i ", arr[k]);
        }
        k++;
    }

}

int main() 
{ 
    int number; 
    printf("Insert number of work: "); scanf("%i", &number); 

    switch (number)
    {
        case 1:
            Work1();
            break;
        case 2:
            Work2();
            break;
        case 3:
            Work3(); 
            break;
        default:
            printf("AHAHAHAHAHHAHAHAHHAHA");
            exit(0); 
            break;
    }
    return 0; 
}