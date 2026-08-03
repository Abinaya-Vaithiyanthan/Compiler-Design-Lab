%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>

int yylex();
int yyerror(char *s);

int temp = 1;

char *newtemp()
{
    char *t=(char*)malloc(10);
    sprintf(t,"t%d",temp++);
    return t;
}
%}

%union{
char *str;
}

%token <str> ID NUM
%type <str> E

%left '+' '-'
%left '*' '/'

%%

S : ID '=' E
{
    printf("%s = %s\n",$1,$3);
}
;

E : E '+' E
{
    char *t=newtemp();
    printf("%s = %s + %s\n",t,$1,$3);
    $$=t;
}
| E '-' E
{
    char *t=newtemp();
    printf("%s = %s - %s\n",t,$1,$3);
    $$=t;
}
| E '*' E
{
    char *t=newtemp();
    printf("%s = %s * %s\n",t,$1,$3);
    $$=t;
}
| E '/' E
{
    char *t=newtemp();
    printf("%s = %s / %s\n",t,$1,$3);
    $$=t;
}
| '(' E ')'
{
    $$=$2;
}
| ID
{
    $$=$1;
}
| NUM
{
    $$=$1;
}
;

%%

int main()
{
    printf("Enter the expression:\n");
    yyparse();
    return 0;
}

int yyerror(char *s)
{
    printf("Invalid Expression\n");
    return 0;
}