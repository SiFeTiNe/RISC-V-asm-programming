#include <stdio.h>

int arr1[10];
int arr2[10];

int main()
{

    int size=10, i, sum1 = 0, sum2 = 0;
    
    for(i = 0; i < size; i++)
        arr1[i] = i + 1;

    for(i = 0; i < size; i++)
        arr2[i] = 2*i;
          
    for(i = 0; i < size; i++) {
        sum1 = sum1 + arr1[i];
        sum2 = sum2 + arr2[i];
    }

    printf("%d\n", sum1);
    printf("%d\n", sum2);
    
    return 0;
}
