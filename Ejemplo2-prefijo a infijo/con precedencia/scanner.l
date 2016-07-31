%option noyywrap
%{
#include "parser.h"//analisis sintactico
#include <iostream>
int columna=0;
int ids=0;
%}

letra [a-zñA-ZÑ_]
escaper ("@n"|"@t"|"@r"|"@\\")
digito [0-9]
Numero {digito}+
iden {letra}+({letra}|{digito}|"_")*
caracter "\'"({letra}|{escaper})"\'"     

%%
[+]             { columna=columna+strlen(yylval.TEXT); strcpy(yylval.TEXT, yytext); return mas; }
[-]             { columna=columna+strlen(yylval.TEXT); strcpy(yylval.TEXT, yytext); return menos; }
"*"             { columna=columna+strlen(yylval.TEXT); strcpy(yylval.TEXT, yytext); return por; }
"/"             { columna=columna+strlen(yylval.TEXT); strcpy(yylval.TEXT, yytext); return divi; }
{iden}          { columna=columna+strlen(yylval.TEXT); strcpy(yylval.TEXT, yytext); return Id; }
{Numero}        { columna=columna+strlen(yylval.TEXT); strcpy(yylval.TEXT, yytext); return numero; }

["\f"|"\r"|"\t"|"\v"] {columna++;}
["\n"] {ids+=columna; columna=1;yylineno++;}
[[:blank:]]     {/*ingo*/}

.  {std::cout <<yytext<<" Error Lexico,"<< " Linea   "<< yylineno<<std::endl;}
%%
