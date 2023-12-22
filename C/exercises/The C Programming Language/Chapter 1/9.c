#include <stdio.h>
#include <stdbool.h>


int main(void)
{
    bool blank_missing = false;
    int current_char;
    while ((current_char = getchar()) != EOF) {
        if (current_char == ' ') {
            blank_missing = true;
        } else {
            if (blank_missing) {
                putchar(' ');
                blank_missing = false;
            }
            putchar(current_char);
        }
    }
}
