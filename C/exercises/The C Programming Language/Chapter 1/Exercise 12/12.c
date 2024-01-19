#include <stdio.h>
#include <stdbool.h>


int main(void)
{
    bool word_was_found = false;
    bool new_line_needed = false;

    int current_char;
    while ((current_char = getchar()) != EOF) {
        if (current_char == '\n') {
            if (word_was_found)
                putchar('\n');

            word_was_found = false;
            new_line_needed = false;
        } else if (current_char == ' ' || current_char == '\t') {
            if (word_was_found)
                new_line_needed = true;
        } else {
            if (!word_was_found)
                word_was_found = true;

            if (new_line_needed) {
                putchar('\n');
                new_line_needed = false;
            }

            putchar(current_char);
        }
    }
}
