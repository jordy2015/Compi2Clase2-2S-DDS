%option noyywrap
%{
#include "parser.h"//analisis sintactico
#include <iostream>
int columna=0;
int ids=0;
%}



%%
"0"             { columna=columna+strlen(jjlval.TEXT); strcpy(jjlval.TEXT, jjtext); return cero; }
"1"             { columna=columna+strlen(jjlval.TEXT); strcpy(jjlval.TEXT, jjtext); return uno; }
["\f"|"\r"|"\t"|"\v"] {columna++;}
["\n"] {ids+=columna; columna=1;jjlineno++;}
[[:blank:]]     {/*nada*/}

. {std::cout <<jjtext<<" Error Lexico,"<< " Linea   "<< jjlineno<<std::endl;}
%%
