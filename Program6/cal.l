%{
#include "cal.tab.h"
#include <stdlib.h>
%}

%option noyywrap

%%

[0-9]+      {
                yylval = atoi(yytext);
                return NUM;
            }

[ \t]       ;

\n          return '\n';

.           return yytext[0];

%%