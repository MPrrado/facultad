/*
 * Pila.cpp
 */
#include <iostream>
#include "Pila.h"

using namespace std;

item * Pila:: reservarMemoria(int dim){
	item *reserva = new item[dim];
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
void Pila ::push(item item){
	if(tope+1 <MAX){
		tope++;
		arreglo[tope] = item;
	}
}

void Pila:: pop(){
	if(tope>=0){
		tope--;
	}
}

item Pila:: top(){
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
	tope = -1;
	MAX = 0;
	delete [] arreglo;
}
