#include <stdio.h>

int i = 4;
int j;

void main(void) {
    j = getchar();
    if (i==j) 
        i = i + 2;
    else
        j = j - 1;
    printf("%d", i);
    printf("%d", j);
}