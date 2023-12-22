#include <stdio.h>


int main(void)
{
    int current_char;
    while ((current_char = getchar()) != EOF) {
        if (current_char == '\t')
            printf("\\t");
        else if (current_char == '\b')
            printf("\\b");
        else if (current_char == '\\')
            printf("\\\\");
        else
            putchar(current_char);
    }
}
