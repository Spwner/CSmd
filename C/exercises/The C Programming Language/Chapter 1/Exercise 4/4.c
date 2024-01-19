#include <stdio.h>


int main(void)
{
    float fahr, celsius;
    int lower, upper, step;

    lower = 0;
    upper = 200;
    step = 20;

    printf("Celsius Fahr.\n");

    celsius = lower;
    while (celsius <= upper) {
        fahr = (9.0/5.0)*celsius + 32.0;
        printf("%5.0f %7.1f\n", celsius, fahr);
        celsius += step;
    }
}
