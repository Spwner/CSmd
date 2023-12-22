#include <stdio.h>
#define INSIDE_WORD 1
#define OUTSIDE_WORD 0


int main(void)
{
    long word_count = 0, line_count = 0, char_count = 0;
    int current_char;
    int char_status = OUTSIDE_WORD;
    while ((current_char = getchar()) != EOF) {
        char_count++;

        if (current_char == '\n')
            line_count++;

        if (current_char == ' ' || current_char == '\n' || current_char == '\t') {
            char_status = OUTSIDE_WORD;
        } else if (char_status == OUTSIDE_WORD) {
            word_count++;
            char_status = INSIDE_WORD;
        }
    }

    printf("Word count: %ld; Line count: %ld; Character count: %ld.\n", word_count, line_count, char_count);
}
