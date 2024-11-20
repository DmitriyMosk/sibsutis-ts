#include <stdio.h> 
#include <stdlib.h> 
#include <time.h> 
#include <math.h> 

///////////////////////////////////////////////////////////////////////////
int *GenRandIntArray(int size, int upper, int lower) { 
    
    int *arr = malloc(size * sizeof(int));     
    
    for ( int i = 0; i < size; i++ ) 
    {   
        int seed = i + time(0) + ( ( arr[i] != 0 ) ? arr[i] << 2 : 10);
        srand(seed); 
        arr[i] = rand() % ( upper - lower + 1 ) + lower; 
    }
        

    return arr;
}

void SortArray(int *arr, int size) 
{ 
    for ( int i = 0; i < size; i++ ) 
    { 
        for ( int j = 0; j < size - 1; j++ ) 
        { 
            if ( arr[j] > arr[j + 1] ) 
            { 
                int swipe = arr[j];
                arr[j] = arr[j + 1]; 
                arr[j + 1] = swipe; 
                
            } 
        } 
    } 
    
} 

void PrintArray(int *arr, int size) 
{ 
    for ( int i = 0; i < size; i++ ) printf("a[%i] = %i\n",i, arr[i]);

    printf("\n");
} 
///////////////////////////////////////////////////////////////////////////

int count_iter = 0; 

int BinarySearch(int *arr, int size, int searchElement)
{ 
    int low, high, middle; 
    low = 0; high = size - 1; 
    
    while ( low <= high ) 
    { 
        middle = (low + high) / 2; 
        if ( searchElement < arr[middle] ) 
        { 
            high = middle - 1; 
        }
        else if ( searchElement > arr[middle] ) 
        { 
            low = middle + 1; 
        }
        else return middle; 
        count_iter++;
    }

    return -1;
} 

int PredictionSearch(int *arr, int size, int searchElement) 
{   
    int min = arr[0]; int max = arr[size-1]; 
    
    int predictIndex = (searchElement - min)*(size-1)/(max-min); 
    
    if ( arr[predictIndex] != searchElement ) 
    { 
        if ( arr[predictIndex - 1] == searchElement ) 
        { 
            predictIndex -= 1;
        }  
        else if ( arr[predictIndex + 1] == searchElement ) 
        { 
            predictIndex += 1;
        }
        else predictIndex = -1;
    } 

    return predictIndex; 
}


/*
For Ferma test
*/
int Evklid(int a, int b){
	if(b==0)
		return a;
	return Evklid(b, a%b);
}

long int pow_fast(int a, int b) 
{
    long int out = 1;     
    while(b > 0) 
    { 
        if ( b % 2 == 1 ) 
            out *= a; 
        out *= out; 
        b /= 2; 
    }
    return out; 
} 

int TestFerma(int n) 
{ 
    if ( n == 2 ) return 1; 
    srand(time(NULL));
    for ( int i = 1; i <= 100; i++) 
    {   
        int a = (rand() % (n - 2)) + 2;
        if ( ( Evklid(a, n) != 1 ) && ( pow_fast(a, n-1) != 1 ) )
            return 0; 
    }
    return 1; 
}
//////////////////////////////////////////////////////////////////////////////////

int TestMode(int size, char method) 
{ 
    srand(count_iter);

    int *arr = GenRandIntArray(size, 100, 10); 
    SortArray(arr, size);

    int randSearchElement = arr[rand() % ( size - 0 )]; 

    int idx; 
    if ( method == 'p' ) 
    { 
        idx = PredictionSearch(arr, size, randSearchElement);
    }
    else 
    { 
        idx = BinarySearch(arr, size, randSearchElement);
    }

    if ( idx == -1 ) 
    { 
        printf("Search output: nil element %i\n", randSearchElement);
        PrintArray(arr, size); 
    }
        
        
}

////////////////////////////////////////////////////////////////////////////////////

int main() 
{ 
    int N; 
    printf("Insert number N: "); scanf("%i",&N); 

/*
    int *arr = GenRandIntArray(N, 100, 10); 
    //PrintArray(arr, N);
    SortArray(arr, N);
    PrintArray(arr, N); 
    //////////////////////////////////////
    
    int IsTestMode; 
    printf("Enable test mode? 1/0 (Y/N): "); scanf("%i", &IsTestMode); 

    char searchMethod; 
    printf("Insert b/p to select the search method(b - Binary, p - prediction): "); scanf(" %c", &searchMethod); 

    if ( IsTestMode == 1 ) 
    { 
    
        for ( int k = 0; k <= 10; k++) 
        {    
            TestMode(N, searchMethod);
        }

        printf("Count iteration: %i",count_iter);
    }
    else 
    { 
        int search; 
        printf("Insert search value: "); scanf("%i", &search); 

        int idx = -1; 
        switch (searchMethod)
        {
        case 'b':
            idx = BinarySearch(arr, N, search); 
            break;
        case 'p':
            idx = PredictionSearch(arr, N, search);
            break;
        default:
            printf("\nUnknown search method.\n");
            break;
        }

        if ( idx != -1 ) 
            printf("Search output: element index %i", idx);
        else    
            printf("Search output: nil element");
    }
*/
    if ( TestFerma(N) == 1 ) 
    { 
        printf("Number %i is prime\n", N); 
    }
    else 
    { 
        printf("Number %i isn`t prime\n", N);
    }
} 
