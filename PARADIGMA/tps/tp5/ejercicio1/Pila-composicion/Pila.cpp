/*
 * Pila.cpp
 */
#include <iostream>
#include "Pila.h"

using namespace std;
// long int Pila :: dni = 44658689;
// int Pila :: codigo = 123;
// double Pila :: saldo = 5000000;
Item * Pila:: reservarMemoria(int dim){
	Item *reserva = new Item[dim];
	if(reserva==NULL){
		cout<<"Problema: no se pudo realizar la reserva"; 
	}
	return reserva;
}
Pila::Pila(int dim){
	MAX = dim >0 ? dim : 10;
	tope=-1;
	arreglo = reservarMemoria(MAX);
}
void Pila ::push(int numero,  long int dniTitular, double saldo){
	Cuenta *nuevoItem = new Cuenta(numero,dniTitular,saldo);
	if(tope+1 <MAX){
		tope++;
		arreglo[tope]= nuevoItem;
	}
}

void Pila:: pop(){
	if(tope>=0){
		delete(arreglo[tope]);
		tope--;
	}
}

Item Pila:: top(){
	if(!esPilavacia())
		return arreglo[tope];
	else
		return indefinido;
}

bool Pila:: esPilavacia(){
	return tope==-1;
}

void Pila::escribir(){
	cout << endl<<" PILA INT: (implementaci�n Pila de int)" << endl;
	for(int i=tope; i>=0;i-- ){
		cout <<"     "<< arreglo[i]<<endl;
	}
}

Pila::~Pila(){
	for (int i = 0; i < tope; i++)
	{
		arreglo[i]->~Cuenta();
	}
	tope = -1;
	MAX = 0;
	
	delete [] arreglo;

}
