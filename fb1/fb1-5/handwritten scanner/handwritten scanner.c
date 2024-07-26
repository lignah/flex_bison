#include <stdio.h>
#include <ctype.h>

#define NUMBER 256
#define ADD '+'
#define SUB '-'
#define MUL '*'
#define DIV '/'
#define ABS '|'
#define OP '('
#define CP ')'
#define EOL '\n'

int custom_yylex();
void custom_yyerror(const char* s);

FILE* yyin = NULL;
int yylval;
static int seeneof = 0;




int main(int argc, char** argv) {
    yyin = stdin;
    int token;
    while ((token = custom_yylex()) != 0) {
        if (token == NUMBER) {
            printf("token: number: %d\n", yylval);
        }
        else {
            printf("token: %c\n", token);
        }
    }
    return 0;
}

int custom_yylex(void) {
    if (!yyin) yyin = stdin;
    if (seeneof) return 0;

    while (1) {
        int c = getc(yyin);
        if (isdigit(c)) {
            int i = c - '0';
            while (isdigit(c = getc(yyin)))
                i = (10 * i) + (c - '0');
            yylval = i;
            if (c == EOF) seeneof = 1;
            else ungetc(c, yyin);
            return NUMBER;
        }
        switch (c) {
        case '+': return ADD;
        case '-': return SUB;
        case '*': return MUL;
        case '/': {
            int next = getc(yyin);
            if (next == '/') {
                while ((next = getc(yyin)) != '\n' && next != EOF);
                break; // ignore comments
            }
            else {
                if (next == EOF) seeneof = 1;   // end of file
                else ungetc(next, yyin);
                return DIV;
            }
        }
        case '|': return ABS;
        case '(': return OP;
        case ')': return CP;
        case '\n': return EOL;
        case ' ': case '\t': break; // ignored characters
        case EOF: return 0;
        default: custom_yyerror("unknown character");
        }
    }
}

void custom_yyerror(const char* s) {
    fprintf(stderr, "error: %s\n", s);
}
/* 7 - (3 * 4) / -5        // some comments...
 * token: number: 7
 * token: -
 * token: (
 * token: number: 3
 * token: *
 * token: number: 4
 * token: )
 * token: /
 * token: -
 * token: number: 5
*/