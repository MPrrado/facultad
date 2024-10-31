//============================================================================
// Name        : HerenciaConstDest.cpp
// Author      : 
// Version     :
// Copyright   : Your copyright notice
// Description : Hello World in C++, Ansi-style
//============================================================================

#include <iostream>
#include "ClaseDerivada1.h"
using namespace std;

int main() {
	cout<<endl<<"----------------------------------------------------------------------------"<<endl;
	cout<<"Se crea objeto de ClaseDerivada1, con constructor por defecto"<<endl;
	ClaseDerivada1 objetoD1;
	cout<<endl <<"objetoD1 creado con valores por defecto"<<endl;
	objetoD1.print();
	cout<<endl<<"----------------------------------------------------------------------------"<<endl;
	cout<<endl<<"Se crea objeto de ClaseDerivada1, con constructor sobrecargado"<<endl;
	ClaseDerivada1 otroObjetoD1(" Creado con parametros",777,'*');
	cout<<endl <<"otroObjetoD1 creado con parametros"<<endl;
	otroObjetoD1.print();
	cout<<endl<<"----------------------------------------------------------------------------"<<endl;

	cout<<endl;
	return 0;
}
