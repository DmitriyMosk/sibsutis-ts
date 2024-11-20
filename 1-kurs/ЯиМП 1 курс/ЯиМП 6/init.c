#include <stdio.h> 

void Work1(int N) 
{ 
    int save = N; 
    int sum = 0; 
    while(N != 0) 
    { 
        int d = N % 10; 
        
        sum += d; 
        
        N /= 10; 
    } 
    
    printf("Sum digits %i = %i\n",save,sum);  
} 

char english_alph[26] = { 'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'};

int count_letter(char *str, char letter, int len)
{  
    int count = 0;
    for(int i = 0; i < len; i++)
    {
        if (str[i] == letter)
        {
            count++;
        }
    }

    return count;
} 

int min_array(int *arr, int len)
{
    int min = 2147483647;

    for(int i = 0; i < len; i++) 
    { 
        if ( arr[i] < min ) min = arr[i];
    }

    return min;
}

int main() 
{ 
    char str[26] = "Apple juice is incredible"; 

    for(int i = 0; i < 26; i++)
    { 
        printf("Count %c = %i\n", english_alph[i], count_letter(str, english_alph[i],26));
    }

    int matrix[5][5] = 
    {
        {1, 2, 4, 10, 12},
        {35, 12, 643, 34, 35}, 
        {78,23,24,62, 27},
        {91, 42, 19, 20, 12},
        {9, 2, 6, 3, 5}
    }; 

    for(int i = 0; i < 5; i++)
    {
        printf("Arr[%i] min element: %i\n",i,min_array(matrix[i],5));
    }
} 
