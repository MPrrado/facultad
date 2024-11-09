/*
 * Pila.h
 *
 *  Created on: 20/11/2014
 *      Author: Graciela
 */

#include "PilaGenerica.h"

#ifndef PILAINT_H_
#define PILAINT_H_

using namespace std;

template <>
class Pila<int>{
	int tope;
	int *arreglo;
	int MAX;

public:
	Pila(int =10);
	Pila(const Pila &);

	bool push(int item);
	bool pop();
	int top();
	bool esPilavacia();
	void escribir();
	~Pila();
};

Pila<int>::Pila(int dim)
{
	cout << endl<<" Se crea una PILA INT " << endl;
	MAX = dim >0 ? dim : 10;
	tope=-1;
	arreglo = new int[MAX];

}

Pila<int>::	Pila(const Pila<int> &p)
{
	tope=p.tope;
	MAX = p.MAX;
	arreglo = new int[MAX];

	for(int i=0; i<tope;i++ )
	{
		arreglo[i]=p.arreglo[i];
	}
}

bool Pila<int>::push(int item){
	bool resultado=  false;
	if(tope+1 <MAX){
		tope++;
		arreglo[tope] = item;
		resultado =true;
	}
	return resultado;
}

bool Pila<int>:: pop(){
	bool resultado=false;
	if(tope>=0){
		tope--;
		resultado = true;
	}
	return resultado;
}

int Pila<int>:: top(){
	if(!esPilavacia())
		return arreglo[tope];
	else
		return -999;
}

bool Pila<int>:: esPilavacia(){
	return tope==-1;
}

void Pila<int>::escribir(){
	cout << endl<<" PILA INT: " << endl;
	cout << endl<<" PILA : " << endl;
	for(int i=tope; i>=0;i-- )
	{
		cout << arreglo[i]<<endl;
	}
}

Pila<int>::~Pila()
{
	delete [] arreglo;
}
#endif /* PILA_H_ */

