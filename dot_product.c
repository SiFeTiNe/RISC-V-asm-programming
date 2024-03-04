#include <stdio.h>

int a[5] = {1, 2, 3, 4, 5};
int b[5] = {6, 7, 8, 9, 10};

int main() {
    int i, sop = 0;
    
    for (i = 0; i < 5; i++) {
        sop += a[i] * b[i];
    }
    
    printf("The dot product is: %d\n", sop);
    return 0;
}