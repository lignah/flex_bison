/* recognize tokens for the calculator and print them out */
%%
"+"	{ printf("plus\12"); }
"-"	{ printf("minus\12"); }
"*"	{ printf("times\12"); }
"/"	{ printf("divide\12"); }
"|"	{ printf("abs\12"); }
[0-9]+	{ printf("number %s\12", yytext); }
\n	{ printf("newline\12"); }
[ \t]	{ }
.	{ printf("mystery character %s\12", yytext); }
%%
