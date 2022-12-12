%{
#include <stdio.h>
%}

%x ZWYKLY LANCUCH1 LANCUCH2
%%
<INITIAL>"#"[^\n]*(\n?)  {fprintf(yyout, "\n");}
<INITIAL>\"              {fprintf(yyout, yytext); BEGIN(LANCUCH1);}
<INITIAL>\'              {fprintf(yyout, yytext); BEGIN(LANCUCH2);}

<ZWYKLY>"\n"             {}

<LANCUCH1>\"             {fprintf(yyout, yytext); BEGIN(INITIAL);}
<LANCUCH2>\'             {fprintf(yyout, yytext); BEGIN(INITIAL);}

%%
int yywrap(void){}
int main() {
    extern FILE *yyin, *yyout;
    yyin = fopen("a.py", "r");
    yyout = fopen("b.py", "w");
    yylex(); 
    return 0;
}


