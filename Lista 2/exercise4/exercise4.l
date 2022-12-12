%{
#include <stdio.h>
#include <vector>
#include <math.h>

std::vector<int> stos;
bool wystapil_blad = false;
void liczba(int x) {
    if (wystapil_blad)
        return; 
    stos.push_back(x);
}
void op(char o) {
    if (wystapil_blad)
        return;
    if(stos.size() < 2){
        printf("Błąd: za mała liczba argumentów\n");
        wystapil_blad = true;
        return;
    }
    int b = stos.back();
    stos.pop_back();
    int a = stos.back();
    stos.pop_back();
    switch (o) {
        case '+':
            stos.push_back(a+b);
            break;
        case '-':
            stos.push_back(a-b);
            break;
        case '*':
            stos.push_back(a*b);
            break;
        case '/':
            if(b != 0)
                stos.push_back(a/b);
            else {
                printf("Błąd: Dzielenie przez zero!\n");
                wystapil_blad = true;
            }
            break;
        case '%':
            if(b != 0)
                stos.push_back(a%b);
            else {
                printf("Błąd: Dzielenie przez zero!\n");
                wystapil_blad = true;
            }
            break;
        case '^':
            stos.push_back(pow(a, b));
            break;
    }
}

void nowa_linia() {
    if (wystapil_blad == false) {
        if (stos.size() == 1) {
            printf("= %d\n", stos.back());
        }
        else {
            printf("Błąd: za mała liczba argumentów\n");
        }
    }
    wystapil_blad = false;
    stos.clear();
}

void zly_symbol(char c) {
    if (wystapil_blad)
        return;
    printf("Błąd: zły symbol %c\n", c);
    wystapil_blad = true;
}
%}
%option noyywrap
OPERATOR  [-+*/^%]
NUMBER    -?[0-9]+
NEWLINE   \n
%%
{NUMBER}    {liczba(atoi(yytext));}
{OPERATOR}  {op(yytext[0]);}
{NEWLINE}   {nowa_linia();}
[ \t]       {}
.           {zly_symbol(yytext[0]);}

%%
int main() 
{
   yylex(); 
   return 0;
}