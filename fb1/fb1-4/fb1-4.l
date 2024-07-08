/* Example 1-4. Calculator scanner fb1-4.l
 * recognize tokens for the calculator and print them out
 */

%{
    enum yytokentype {
	NUMBER= 258,
	ADD= 259,
	SUB= 260,
	MUL= 261,
	DIV= 262,
	ABS= 263,
	EOL= 264
    };
    int yylval;
%}

%%
"+"	{ return ADD; }
"-"	{ return SUB; }
"*"	{ return MUL; }
"/"	{ return DIV; }
"|"	{ return ABS; }
[0-9]+	{ yylval= atoi(yytext); return NUMBER; }
\12	{ return EOL; }
[ \t]	{ /* ignore whitespace */ }
.	{ printf("mystery character %c\12", *yytext); }
%%

int main(int argc, char** argv) {
    int token1;

    while(token1= yylex()) {
        printf("%d", token1);
	if(token1== NUMBER) printf(" = %d\12", yylval);
	else printf("\12");
    }
}
