/*
Square root with Recursive Newton-Raphson Method by Caio Madeira
*/

#include<stdio.h>
#include<math.h>

int sqrt_nr(int x, int i);

int sqrt_nr(int x, int i) {
    if (i == 0) return 1; // 1,^i=0. Caso base necessario, caso contrario: sinal SIGFPE (Floating Point Exception)
    return (sqrt_nr(x, i-1)+(x/sqrt_nr(x,i-1)))/2;
}

int valide_result(int x, int r) {
    if (sqrt(x) == r)
        return 1;
    return 0;
}

int main(void)
{
    // caso bom
    int x = 100;
    int i = 5;

    // // caso ruim
    // int x = 100;
    // int i = 3;

    int r = sqrt_nr(x, i);

    // o resultado deve ser 10, pois raiz_quadrada de 100 = 10
    printf("sqrt_nr(%d, %d) = %d\n", x, i, r);
    if (valide_result(x, r) == 1) 
        printf("resultado convergiu adequadamente.\n");
    else
        printf("resultado NAO convergiu adequadamente.\n");

    return 0;
}