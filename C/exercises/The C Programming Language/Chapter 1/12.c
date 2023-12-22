#include <stdio.h>
#include <stdbool.h>


int main(void)
{
    bool line_missing = false;
    int current_char;
    while ((current_char = getchar()) != EOF) {
        if (current_char == ' ' || current_char == '\n' || current_char == '\t') {
            line_missing = true;
        } else {
            if (line_missing) {
                putchar('\n');
                line_missing = false;
            }
            putchar(current_char);
        }
    }
}
