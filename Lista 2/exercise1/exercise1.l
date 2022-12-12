%{
#include <stdio.h>
int lines = 0;
int words = 0;
%}
%%
^[[:space:]]+		{ fprintf(yyout, ""); }
[[:space:]]+$     { fprintf(yyout, ""); }
[ \t]+				{ fprintf(yyout, " "); ++words; }
[ \n]+				{ fprintf(yyout, "\n"); ++lines; ++words; }
.                 { fprintf(yyout, "%s", yytext); }
%%
int yywrap(void){}
int main() 
{
   extern FILE *yyin, *yyout;
   yyin = fopen("l2z1a.txt", "r");
   yyout = fopen("a.txt", "w");
   yylex();
   printf("Number of words: %d \n", words);
   printf("Number of lines: %d \n", lines);
   return 0;
}