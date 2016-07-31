%{
#include "scanner.h"//se importa el header del analisis sintactico
#include <iostream> //libreria para imprimir en cosola de C
#include <string.h>
#include <stdio.h>
#include <unistd.h>

extern int columna; //columna actual donde se encuentra el parser (analisis lexico) lo maneja BISON
extern char *jjtext; //lexema actual donde esta el parser (analisis lexico) lo maneja BISON

int jjerror(const char* mens){
    std::cout <<"Error Sintactico en:" <<" "<<jjtext<< " Linea: "<<jjlineno<<" Columna: "<< columna<<", Informe: "<<std::endl;
    columna=0;
    return 0;
}

%}

//error-verbose si se especifica la opcion los errores sintacticos son especificados por BISON
%error-verbose

%union{ 	
//se especifican los tipos de valores para los no terminales y lo terminales
char TEXT [256];
int operador;
}


//TERMINALES DE TIPO TEXT, SON STRINGS
%token<TEXT> cero
%token<TEXT> uno


//NO TERMINALES DE TIPO VAL, POSEEN ATRIBUTOS INT VALOR, Y QSTRING TEXTO
%type<operador> S1
%type<operador> S2
%type<operador> S3

//Asociatividad
//%left mas menos

%%

S1 : S2 { std::cout<<"decimal:"<<$1<<std::endl;};

S2 : S2 S3 { $$=$1*2+$2;};
	|S3 { $$=$1; };

S3 : cero{ $$=0; };
	|uno{$$=1;};
%%


