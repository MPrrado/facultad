//============================================================================
// Name        : Herencia2.cpp
// Author      : CW
// Version     :
// Copyright   : Your copyright notice
// Description : Hello World in C++, Ansi-style
//============================================================================

#include <iostream>
#include "Base.h"
#include "Derivada.h"

using namespace std;

int main() {

	//Polimorfismo Estatico
	cout<<"Polimorfismo Estático"<<endl;
	Base oBase;
	oBase.escribir();

	Derivada oDerivada;
	oDerivada.escribir();
	cout<<"---------------------------------------"<<endl;

	//Polimorfismo Dinamico
	cout<<endl<<"Polimorfismo Dinámico"<<endl;
	Base *ptrBase;
	ptrBase = &oBase;
	ptrBase->escribir();

	ptrBase = &oDerivada;
	ptrBase->escribir();


	cout<<"---------------------------------------"<<endl;
	cout<<endl<<endl<<"Invocación indirecta al destructor"<<endl;
	ptrBase = new Derivada;
	delete ptrBase;


	cout<<endl<<"Fin del main"<<endl;
	cout<<"---------------------------------------"<<endl;

	return 0;
}
