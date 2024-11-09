//============================================================================
// Name        : PlantillaFuncion.cpp
// Author      : CW
// Version     :
// Copyright   : Your copyright notice
// Description : Hello World in C++, Ansi-style
//============================================================================

#include <iostream>
#include "Cuenta.h"

#include "Fecha.h"
const int  MAX =5;

using namespace std;

template<class T>
bool operator !=(T x, T y){
	return !(x==y);
};


//Observaciones:
//1. La palabra template encabeza tanto la declaración
//   como la definición de la función/clase genérica.

//2. Encerrada entre los símbolos < y > va una lista, separada
//   por comas, de tipos de parámetros formales.
//   Esta lista, que NO puede estar vacía, se denomina
//   "lista de parámetros formales de la plantilla".

//3.Cada parámetro formal consta de la palabra reservada class
//  seguida de un identificador que NO puede estar repetido
//  en la lista de parámetros





template <class X >
bool Pertenece(X *arreglo, int MAX, X item);

int main() {

	int arreInt[] = {1,2, 3,4,5};
	char arreChar[] = {'a', 'e', 'i', 'o', 'u'};

	if(Pertenece(arreInt, MAX, 4))
		cout << "Pertenece" << endl;
	else
		cout << "NO Pertenece" << endl;


	if(Pertenece(arreChar, MAX, 'z'))
			cout << "Pertenece" << endl;
		else
			cout << "NO Pertenece" << endl;


/*
//-----------------------------------------------
	Cuenta c1(100,0),c2(c1);
	cout << endl ;
	if(c1!=c2)
		cout << "Cuentas diferentes" << endl;
	else
		cout << "Cuentas iguales" << endl;
//-----------------------------------------------
	Fecha f1, f2(2,7,1979);
	cout << endl ;
	if(f1!=f2)
			cout << "Fechas diferentes" << endl;
		else
			cout << "Fechas iguales" << endl;
//-----------------------------------------------
	*/
	return 0;

}
//Función Plantilla Pertenece
template <class X >
bool Pertenece(X *arreglo, int MAX, X item){
	int i=0;
	bool encontrado=false;
	while(!encontrado && i<MAX){
			cout <<endl<< "arreglo["<<i<<"]:"<<arreglo[i]<<endl;
			if (item==arreglo[i])
				encontrado = true;
			i++;
	}
	cout <<endl<< "Funcion Plantilla Pertenece "<<endl;

	return encontrado;
}


//Función Sobrecargada Pertenece en arreglo char
bool Pertenece(char *arre, int MAX, char item ){
	int i=0;
	bool encontrado=false;
	while(!encontrado && i<MAX){
		cout <<endl<< "arreglo["<<i<<"]:"<<arre[i]<<endl;
		if (arre[i]==item)
				encontrado = true;
		i++;
	}
	return encontrado;
}

/*
//Función Sobrecargada Pertenece en arreglo int
bool Pertenece(int *arre, int MAX, int item ){
	int i=0;
	bool encontrado=false;
	while(!encontrado && i<MAX){
		cout <<endl<< "arreglo["<<i<<"]:"<<arre[i]<<endl;
		if (arre[i]==item)
				encontrado = true;
		i++;
	}
	cout <<endl<< "Funcion Pertenece Sobrecargada"<<endl;

	return encontrado;
}
*/

