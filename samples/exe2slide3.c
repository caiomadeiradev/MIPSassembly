#include<stdio.h>
#include<stdlib.h>

int func(int a) {
    int b; // $t0
    int c; // $t1

    b = 0;
    c = 0;

    while()
    {
        if (c < a) {
            b = b + c;
            c = c + 2;
        } else { break; }
    }
    return b + 0;
}

void main(void)
{
    func(5);
}