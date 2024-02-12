### 1-1
*Run the `"hello, world"` program on your system. Experiment with leaving out parts of the program, to see what error messages you get.*

```c
#include <stdio.h>


printf("hello, world\n");
```
**error:** expected declaration specifiers or **'...'** before string constant
```c
#include <stdio.h>


int main(void)
    printf("hello, world\n");
```
**error:** expected declaration specifiers before **'printf'**
**error:** expected **'{'** at end of input
```c
int main(void)
{
    printf("hello, world\n");
}
```
**warning:** implicit declaration of function **'printf'**
**warning:** imcompatible implicit declaration of built-in fuction **'printf'**
```c
#include <stdio.h>


main(void)
{
    printf("hello, world\n");
}
```
**warning:** return type defaults to **'int'**
```c
#include <stdio.h>


int main(void)
{
    printf("hello, world\n");
}
```
No warnings or errors.


### 1-2
*Experiment to find out what happens `printf`'s argument string contains `\c` where `c` is some character not listed above.*

```c
#include <stdio.h>


int main(void)
{
    printf("hello, \world\n");
}
```
**warning:** unknown escape sequence: '\w'


### 1-3
*Modify the temperature conversion program to print a heading above the table.*

```c
#include <stdio.h>


int main(void)
{
    float fahr, celsius;
    int lower, upper, step;

    lower = 0;
    upper = 200;
    step = 20;

    printf("Fahr. Celsius\n");

    fahr = lower;
    while (fahr <= upper) {
        celsius = (5.0/9.0)*(fahr - 32.0);
        printf("%4.0f %7.1f\n", fahr, celsius);
        fahr += step;
    }
}
```


### 1-4
*Write a program to print the corresponding Celsius to Fahrenheit table.*

```c
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
```


### 1-5
*Modify the temperature conversion program to print the table in reverse order, that is, from 300 degrees to 0.*

```c
#include <stdio.h>


int main(void)
{
    for (int fahr = 300; fahr >= 0; fahr -= 20)
        printf("%3d %6.1f\n", fahr, (5.0/9.0)*(fahr - 32));
}
```


### 1-6
*Verify that the expression `getchar() != EOF` is 0 or 1.*

```c
#include <stdio.h>


int main(void)
{
    printf("%d\n", getchar() != EOF);
}
```
Guilty as charged.


### 1-7
*Write a program to print the value of `EOF`.*

```c
#include <stdio.h>


int main(void)
{
    printf("%d\n", EOF);
}
```
-1


### 1-8
*Write a program to count blanks, tabs, and newlines.*

```c
#include <stdio.h>


int main(void)
{
    long ws = 0;

    int c;
    while ((c = getchar()) != EOF)
        if (c == ' ' || c == '\t' || c == '\n')
            ++ws;

    printf("%ld\n", ws);
}
```


### 1-9
*Write a program to copy its input to its output, replacing each string of one or more blanks by a single blank.*

```c
#include <stdio.h>
#include <stdbool.h>


int main(void)
{
    bool blank_missing = false;

    int c;
    while ((c = getchar()) != EOF) {
        if (c == ' ') {
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
```


### 1-10
*Write a program to copy its input to its output, replacing each tab by `\t`, each backspace by `\b`, and each backslacsh by `\\`. This makes tabs and backspaces visible in an unambiguous way.

```c
#include <stdio.h>


int main(void)
{
    int c;
    while ((c = getchar()) != EOF) {
        if (c == '\t')
            printf("\\t");
        else if (c == '\b')
            printf("\\b");
        else if (c == '\\')
            printf("\\\\");
        else
            putchar(c);
    }
}
```


### 1-11
*How would you test the word count program? What kinds of input are most likely to uncover bugs if there are any?*

```c
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
```
I would test it by feeding in strings of text whose word, line and chracter count is already known.
Input that is very long or has a lot of white-space is most likely to uncover bugs.


### 1-12
*Write a program that prints its input one word per line.*

```c
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
```


### 1-13
*Write a program to print a histogram of lengths of words in its input. It is eady to draw the histogram with the bars horizontal; a vertical orientation is more challneging*

```c
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

            putchar('#');
        }
    }
}
```


### 1-14
*Write a program to print a histogram of the frequencies of different characters in its input.*

```c
```


### 1-15
```c
```
