/*
 * Pila.cpp
 */
#include <iostream>
#include "Pila.h"

using namespace std;

item * Pila:: reservarMemoria(int dim){
	item *reserva = new item[dim];
	if(reserva==NULL){
		cout<<"Problema: no se pudo realizar la reserva"; //de memoria solicitada"<<endl;
	}
	return reserva;
}
void Pila::PV(int dim){
	MAX = dim >0 ? dim : 10;
	tope=-1;
	arreglo = reservarMemoria(MAX);
}

bool Pila ::push(int item){
	bool resultado=  false;
	if(tope+1 <MAX){
		tope++;
		arreglo[tope] = item;
		resultado =true;
	}
	return resultado;
}

bool Pila:: pop(){
	bool resultado=false;
	if(tope>=0){
		tope--;
		resultado = true;
	}
	return resultado;
}

int Pila:: top(){
	if(!esPilavacia())
		return arreglo[tope];
	else
		return indefinido;
}

bool Pila:: esPilavacia(){
	return tope==-1;
}

void Pila::escribir(){
	cout << endl<<" PILA INT: (implementación Pila de int)" << endl;
	for(int i=tope; i>=0;i-- ){
		cout <<"     "<< arreglo[i]<<endl;
	}
}

bool Pila::pertenece(item k){
	int i=tope;
	while(i>=0 && arreglo[i]!=k)
		i--;
	return i>=0;

}
bool Pila::sonIguales(Pila &Q){
	bool resultado=true;
	if (tope!=Q.tope)
		resultado=false;
	else{
		int i=0;
		while(i<=tope && resultado){
			if(arreglo[i]!=Q.arreglo[i])
				resultado=false;
			i++;
		}
	}
	return resultado;
}


Pila::~Pila(){
	tope = -1;
	MAX = 0;
	delete [] arreglo;
}
