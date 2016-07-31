%{
#include "scanner.h"//se importa el header del analisis sintactico
#include <iostream> //libreria para imprimir en cosola de C
#include <string.h>
#include <stdio.h>
#include <unistd.h>

extern int columna; //columna actual donde se encuentra el parser (analisis lexico) lo maneja BISON
extern char *yytext; //lexema actual donde esta el parser (analisis lexico) lo maneja BISON

int yyerror(const char* mens){
    std::cout <<"Error Sintactico en:" <<" "<<yytext<< " Linea: "<<yylineno<<" Columna: "<< columna<<", Informe: "<<std::endl;
    columna=0;
    return 0;
}

struct Operador{
//ESTRUCTURA LA CUAL CONTENDRA LOS TIPOS DE LOS NO TERMINALES PA223RA HEREDAR VALORES
std::string Cadena;
int MiValor;
int precedencia;
};


%}
//error-verbose si se especifica la opcion los errores sintacticos son especificados por BISON
%error-verbose

%union{
//se especifican los tipos de valores para los no terminales y lo terminales
char TEXT [256];
struct Operador * Concat;
}



//TERMINALES DE TIPO TEXT, SON STRINGS
%token<TEXT> mas
%token<TEXT> menos
%token<TEXT> por
%token<TEXT> numero
%token<TEXT> divi
%token<TEXT> Id


//NO TERMINALES DE TIPO VAL, POSEEN ATRIBUTOS INT VALOR, Y QSTRING TEXTO
%type<Concat> S1 
%type<Concat>  S2

//Asociatividad
%right menos
%left mas 



%%

S1 : S2 { std::cout<<$1->Cadena<<std::endl; };

S2 : mas S2 S2 {
		$$=new Operador(); $$->Cadena=$2->Cadena+"+"+$3->Cadena;  
		$$->precedencia=1;
	}
	|menos S2 S2 {
		$$=new Operador(); $$->Cadena=$2->Cadena+"-"+$3->Cadena;  
		$$->precedencia=1;
	}
	|por S2 S2 {
		if($2->precedencia==1)
			$2->Cadena="("+$2->Cadena+")";	
		if($3->precedencia==1)
			$3->Cadena="("+$3->Cadena+")";	
		$$=new Operador(); $$->Cadena=$2->Cadena+"*"+$3->Cadena; 
		$$->precedencia=2;
	} 
	|numero {$$=new Operador(); $$->Cadena=$1; $$->precedencia=3;};
%%