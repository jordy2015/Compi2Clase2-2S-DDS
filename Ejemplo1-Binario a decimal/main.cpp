#include <iostream>
#include <string>
#include "scanner.h"
#include "parser.h"

using namespace std;

int main ()
{
    if(FILE* input = fopen("entrada.txt", "r" )){
       jjrestart(input);//SE PASA LA CADENA DE ENTRADA A FLEX
       jjparse();
    }
}