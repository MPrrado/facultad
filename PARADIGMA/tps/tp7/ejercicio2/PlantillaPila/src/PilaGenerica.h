/*
 * Pila.h
 *
 *  Created on: 20/11/2014
 *      Author: Graciela
 */

#ifndef PILAGENERICA_H_
#define PILAGENERICA_H_
using namespace std;

template <class X>
class Pila{
	int tope;
	X *arreglo;
	int MAX;

public:
	Pila(int =10);
	Pila(const Pila<X> &);

	bool push(X);
	bool pop();
	X top();
	bool esPilavacia();
	void escribir();

	~Pila();
};

template <class X>
Pila<X>::Pila(int dim)
{
	MAX = dim >0 ? dim : 10;
	tope=-1;
	arreglo = new X[MAX];
}

template <class X>
Pila<X>::	Pila(const Pila<X> &p)
{
	tope=p.tope;
	MAX = p.MAX;
	arreglo = new X[MAX];
	for(int i=0; i<tope;i++ )
	{
		arreglo[i]=p.arreglo[i];
	}
}

template <class X>
bool Pila<X>::push(X item){
	bool resultado=  false;
	if(tope+1 <MAX){
		tope++;
		arreglo[tope] = item;
		resultado =true;
	}
	return resultado;
}

template <class X>
bool Pila<X>:: pop(){
	bool resultado=false;
	if(tope>=0){
		tope--;
		resultado = true;
	}
	return resultado;
}

template <class X>
X Pila<X>:: top(){
	if(!esPilavacia())
		return arreglo[tope];
	else
		return 0;
}
template <class X>
bool Pila<X>:: esPilavacia(){
	return tope==-1;
}

template <class X>
void Pila<X>::escribir(){
	cout << endl<<" PILA GENERICA: " << endl;
	cout << endl<<" PILA : " << endl;
	for(int i=tope; i>=0;i-- )
	{
		cout << arreglo[i]<<endl;
	}
}

template <class X>
Pila<X>::~Pila()
{
	delete [] arreglo;
}

#endif /* PILA_H_ */


