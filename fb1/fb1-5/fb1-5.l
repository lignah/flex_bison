%{
  #include "fb1-5.tab.h"
%}

/* the order of rule definitions is important */
%%
"("		{ return OP; }
")"		{ return CP; }
"//".*		{ /* ignore comments */ }
[0-9]+		{ yylval= atoi(yytext); return NUMBER; }
"+"		{ return ADD; }
"-"		{ return SUB; }
"*"		{ return MUL; }
"/"		{ return DIV; }
"abs"		{ return ABS; }
\n		{ return EOL; }
[ \t]		{ /* ignore whitespace */ }
.		{ /* ignore other characters */ }
%%


int yywrap() {
  return 1;
}
