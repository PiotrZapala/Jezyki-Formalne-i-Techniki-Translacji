%{
#include <stdio.h>

int num_words = 0;
int num_lines = 1;

%}

%%

^[ \t]+\n			;
^\n					;
^[ \t]+/.		    ;
[ \t]+				;
[ \t]+/.			printf(" ");
[^ \t\n]+		    ++num_words; ECHO;
\n                  ++num_lines; ECHO;

%%

int main()
{
	yylex();
	fprintf(stderr, "Number of lines = %d\nNumber of words = %d\n", num_lines, num_words);
}