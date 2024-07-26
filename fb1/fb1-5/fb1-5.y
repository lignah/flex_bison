// simple calculator

%{
  #include <stdio.h>

  int yylex(void);
  void yyerror(const char* s);
%}  //it should start on new line

/* declare tokens */
%token NUMBER
%token ADD SUB MUL DIV ABS
%token EOL

/* adding a few more rules */
%token OP CP




%%
calclist:
  | calclist exp EOL  { printf("= %d\n", $2); }
  ;

exp: factor  // default $$=$1
  | exp ADD factor { $$= $1 + $3; }
  | exp SUB factor { $$= $1 - $3; }
  ;

factor: term  //  default $$=$1
  | factor MUL term { $$= $1 * $3; }
  | factor DIV term { $$= $1 / $3; }
  ;

term: NUMBER  //  default $$=$1
  | ABS term { $$= $2 >= 0? $2 : - $2; }

  | OP exp CP { $$= $2; }  /* new rule: handle parentheses */
  ;
%%

int main(int argc, char** argv) {
  yyparse();
}

void yyerror(const char* s) {
  fprintf(stderr, "error: %s\n", s);
}
