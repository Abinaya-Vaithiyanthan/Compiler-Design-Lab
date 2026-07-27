%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *s);
%}

%define api.value.type {int}

%token NUM

%left '+' '-'
%left '*' '/'
%right UMINUS

%%

input
    : expr '\n'
      {
          printf("Answer: %d\n", $1);
      }
    ;

expr
    : expr '+' expr   { $$ = $1 + $3; }
    | expr '-' expr   { $$ = $1 - $3; }
    | expr '*' expr   { $$ = $1 * $3; }
    | expr '/' expr   { $$ = $1 / $3; }
    | '(' expr ')'    { $$ = $2; }
    | '-' expr %prec UMINUS { $$ = -$2; }
    | NUM             { $$ = $1; }
    ;

%%

int main()
{
    printf("Enter the expression:\n");
    yyparse();
    return 0;
}

void yyerror(const char *s)
{
    printf("Syntax Error\n");
}