/*
 * Pila.h
 */

#ifndef PILA_H_
#define PILA_H_
#include <iostream>

using namespace std;
typedef int item;
const int indefinido=-999;

class Pila{
	int tope;
	item *arreglo;
	int MAX;
	item* reservarMemoria(int tama);

 public:
	void PV(int dim = 10);

	bool push(int item);
	int  top();
	bool pop();
	bool esPilavacia();
	bool pertenece(item k);
	bool sonIguales(Pila &Q);
	void escribir();

	~Pila();
};

#endif  //PILA_H_






