#include <stdio.h>


int main(void)
{
    long invis_chars = 0;
    int current_char;
    while ((current_char = getchar()) != EOF)
        if (current_char == ' ' || current_char == '\t' || current_char == '\n')
            invis_chars++;

    printf("%ld\n", invis_chars);
}
