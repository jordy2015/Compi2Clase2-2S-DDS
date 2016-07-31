#include <iostream>
#include <string>
#include "scanner.h"
#include "parser.h"

using namespace std;

int main ()
{
    if(FILE* input = fopen("entrada.txt", "r" )){
       yyrestart(input);//SE PASA LA CADENA DE ENTRADA A FLEX
       yyparse();
    }
}