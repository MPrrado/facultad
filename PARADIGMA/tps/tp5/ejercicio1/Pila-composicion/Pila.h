/*
 * Pila.h
 */

#ifndef PILA_H_
#define PILA_H_
#include <iostream>
#include "cuenta.cpp"
using namespace std;
typedef Cuenta* Item;

const Item indefinido=nullptr;

class Pila{
	int tope;
	Item *arreglo;
	int MAX;
	Item* reservarMemoria(int tama);

 public:
	Pila(int dim = 10);

	void push(int numero,  long int dniTitular, double saldo);
	Item  top();
	void pop();
	bool esPilavacia();
	void escribir();

	~Pila();
};

#endif  //PILA_H_






