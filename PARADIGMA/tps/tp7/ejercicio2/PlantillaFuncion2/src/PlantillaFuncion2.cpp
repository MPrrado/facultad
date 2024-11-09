//============================================================================
// Name        : PlantillaFuncion.cpp
// Author      : CW
// Version     :
// Copyright   : Your copyright notice
// Description : Hello World in C++, Ansi-style
//============================================================================

#include <iostream>
#include "Cuenta.h"
const int  MAX =5;

using namespace std;

//Plantilla de Función Pertenece
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
//Función Sobrecargada Pertenece
bool Pertenece(char *arre, int MAX, char item ){
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

int main() {
	//Tipo INT
	int arreInt[MAX] = {1,2,3,4,5};
	int itemInt=7;
	if(Pertenece(arreInt, MAX, itemInt))
		cout << "El item entero \"" <<itemInt << "\" se encuentra en el arreglo" << endl;
	else
		cout << "El item entero \"" <<itemInt << "\" NO se encuentra en el arreglo" << endl;
	cout << "--------------------------------------------------------------------------------" << endl;



	//Tipo CHAR
	char arreChar[MAX]={'a', 'b', 'c', 'd', 'e'};
	char itemChar='g';

	//if(Pertenece<char>(arreChar, MAX, itemChar))
	if(Pertenece(arreChar, MAX, itemChar))
		cout << "El item char \"" <<itemChar << "\" se encuentra en el arreglo" << endl;
	else
		cout << "El item char \"" <<itemChar << "\" NO se encuentra en el arreglo" << endl;
	cout << "--------------------------------------------------------------------------------" << endl;


	//Tipo STRING
	string arreString[MAX]={ "uno", "dos","tres","cuatro","cinco"};
	string itemString="cinco";
	if(Pertenece(arreString, MAX, itemString))
		cout << "El item string \"" <<itemString << "\" se encuentra en el arreglo" << endl;
	else
		cout << "El item string \"" <<itemString << "\" NO se encuentra en el arreglo" << endl;
	cout << "--------------------------------------------------------------------------------" << endl;


	//Tipo  CUENTA
	Cuenta c1(100,0),c2(101,100),c3(102,200),c4(103,300),c5(104,400);
	Cuenta cuentas[MAX]={c1,c2,c3,c4,c5};
	Cuenta itemCuenta(105,400);
	if(Pertenece(cuentas, MAX, itemCuenta))
		cout << "El item cuenta:\n" <<itemCuenta << " se encuentra en el arreglo" << endl;
	else
		cout << "El item cuenta:\n" <<itemCuenta << " NO se encuentra en el arreglo" << endl;
	cout << "--------------------------------------------------------------------------------" << endl;

	return 0;

}


