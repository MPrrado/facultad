/*
 * CONTENEDOR.h
 *
 */

#ifndef CONTENEDOR_H_
#define CONTENEDOR_H_

#include <iostream>
using namespace std;
template <class X>
class IteradorGeneralizacion;

template <class X>
class Contenedor{
	const X indefinido;
	X *arreglo;
	int MAX;
	X* reservarMemoria(unsigned int tama);
public:
		Contenedor(unsigned int dim, X indef);
		bool insertarElemento(X valor, int posicion);
		X  elemento(int posicion);
		bool eliminarElemento(int posicion);
		void escribir();
		int capacidad();
		~Contenedor();
		friend class IteradorGeneralizacion<X>;
};


template <class X>
X* Contenedor<X>::reservarMemoria(unsigned int tama){
	int *reserva = new int[tama];
	if(reserva==NULL){
		cout<<"Problema: no se pudo realizar la reserva";
	}
	return reserva;
}
template <class X>
Contenedor<X>::Contenedor(unsigned int dim, X indef):indefinido(indef){
	this->MAX = dim;
	this->arreglo = reservarMemoria(this->MAX);
	if (this->arreglo ==NULL)
		this->MAX = 0;
	else
		for(int i=0;i<this->MAX;i++)
			this->arreglo[i]=this->indefinido;
}
template <class X>
bool Contenedor<X>::insertarElemento(X valor, int posicion)
{
    bool resultado=  false;
	if(0<=posicion && posicion< this->MAX){
		this->arreglo[posicion] = valor;
		resultado =true;
	}
	return resultado;
}
template <class X>
X Contenedor<X>::elemento(int posicion){
	if(0<=posicion && posicion<this->MAX)
		return this->arreglo[posicion];
	else
		return this->indefinido;
}
template <class X>
bool Contenedor<X>::eliminarElemento(int posicion){
	bool resultado = false;
	if(0<=posicion && posicion<this->MAX){
		this->arreglo[posicion]=this->indefinido;
		resultado = true;
	}
	return resultado;
}
template <class X>
int Contenedor<X>::capacidad(){
	return this->MAX;
}
template <class X>
Contenedor<X>::~Contenedor(){
	this->MAX = 0;
	delete [] this->arreglo;
};
#endif /* CONTENEDOR_H_ */
