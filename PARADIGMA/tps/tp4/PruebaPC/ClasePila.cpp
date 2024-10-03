//============================================================================
// Name        : ClasePila.cpp
// Author      : 
// Version     :
// Copyright   : Your copyright notice
// Description : Hello World in C++, Ansi-style
//============================================================================

#include <iostream>
#include "Pila.h"

using namespace std;

void cargarPila(Pila &P);
istream& operator>>(istream & salida, Pila& P);

int main() {
	Pila P, Q;
	P.PV(5);
	Q.PV(8);

	cargarPila(P);
	cargarPila(Q);

	Q.pop();

	cout<<"Tope de P: "<<P.top()<< endl;

	if(P.sonIguales(Q))
		cout<<"Las pilas son iguales"<<endl;
	else
		cout<<"Las pilas son distintas"<<endl;
	return 0;
}


istream& operator>>(istream & salida, Pila& P){

	int cant;
	item elemento;
	cout << "Ingrese la cantidad de items: " <<endl;
	salida>> cant;
	if(cant <=0)
		cant=10;
	cout << "Ingrese los items de la Pila: " <<endl;
	while(cant>0){
		salida >> elemento;
		P.push(elemento);
		cant--;
	}
	return salida;
}




void cargarPila(Pila &P){
	int cant;
	item elemento;
	cout << "Ingrese la cantidad de items: " <<endl;
	cin >> cant;
	if(cant <=0)
		cant=10;
	cout << "Ingrese los items de la Pila: " <<endl;
	while(cant>0){
		cin >> elemento;
		P.push(elemento);
		cant--;
	}
}


