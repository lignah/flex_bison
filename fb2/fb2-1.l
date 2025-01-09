/* example 2-1, word count and reading one file
 * even more like unix wc
 */
 
%option noyywrap
%{
int chars = 0;
int words = 0;
int lines = 0;  
%}

%%
[a-zA-Z]+   { words++; chars += strlen(yytext); }
\n          { chars++; lines++; }
.           { chars++; }
%%

int main(int argc, char **argv) {
  if (argc > 1) {
    if (!(yyin = fopen(argv[1], "r"))) {
      perror(argv[1]);
      return 1;
    }
  }

  yylex();
  printf("%8d%8d%8d\n", lines, words, chars);
  if (yyin) fclose(yyin);

  return 0;
}

/* `yyin`is global variable of file pointer type
 * by default, `yyin` points to `stdin`,
 * but it can be reassigned to `file stream`
 */