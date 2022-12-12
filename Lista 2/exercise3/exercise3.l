%{
#include <stdio.h>
int zostaw_dokumentacyjne = 0;
%}
%x ZWYKLY DOKUMENTACYJNY LANCUCH
%%
<INITIAL>"//!"[^\n]*(\n?) {if (zostaw_dokumentacyjne) fprintf(yyout, "%s", yytext); else fprintf(yyout, "\n");}
<INITIAL>"///"[^\n]*(\n?) {if (zostaw_dokumentacyjne) fprintf(yyout, "%s", yytext); else fprintf(yyout, "\n");}
<INITIAL>"//"[^\n]*(\n?)  {fprintf(yyout, "\n");}

<INITIAL>"/**" {if (zostaw_dokumentacyjne) fprintf(yyout, "/**"); BEGIN(DOKUMENTACYJNY);}
<INITIAL>"/*!" {if (zostaw_dokumentacyjne) fprintf(yyout, "/*!"); BEGIN(DOKUMENTACYJNY);}
<INITIAL>"/*"  {BEGIN(ZWYKLY);}

<INITIAL>\"    {fprintf(yyout, yytext); BEGIN(LANCUCH);}

<INITIAL>.     {fprintf(yyout, yytext);}

<DOKUMENTACYJNY>"*/"    {if (zostaw_dokumentacyjne) fprintf(yyout, "*/"); BEGIN(INITIAL);}
<DOKUMENTACYJNY>"\n"    {if (zostaw_dokumentacyjne) fprintf(yyout, "\n");}
<DOKUMENTACYJNY>.       {if (zostaw_dokumentacyjne) fprintf(yyout, "%s", yytext);}

<ZWYKLY>"*/"    {BEGIN(INITIAL);}
<ZWYKLY>"\n"    {}
<ZWYKLY>.       {}

<LANCUCH>\\\"   {fprintf(yyout, "%s", yytext);}
<LANCUCH>\"     {fprintf(yyout, yytext); BEGIN(INITIAL);}
<LANCUCH>.      {fprintf(yyout, yytext);}

%%
int yywrap(void){}
int main(int argc, char** argv) 
{
    if (argc == 2 && !strcmp(argv[1], "zostaw")){
        zostaw_dokumentacyjne = 1;
    }
    extern FILE *yyin, *yyout;
    yyin = fopen("a.cpp", "r");
    yyout = fopen("b.cpp", "w");
    yylex(); 
    return 0;
}