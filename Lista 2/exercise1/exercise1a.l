%{
      #include <stdbool.h>
      int linecount = 0; 
      int wordcount = 0;
      bool did_word = false;
%}

WS      [ \t]+
WORD    [^ \t\n]+

%%

\n          { 
      if(did_word){ECHO; linecount++;}
      did_word = false;
}
^{WS}
{WS}$
{WS}        {printf(" ");}
{WORD}      {ECHO; wordcount++; did_word = true;}

%%
  
int yywrap(){}
int main(){
      yylex();
      return 0;
}