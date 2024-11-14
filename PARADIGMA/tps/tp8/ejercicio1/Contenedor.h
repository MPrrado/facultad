/*
 * CONTENEDOR.h
 *
 */

#ifndef CONTENEDOR_H_
#define CONTENEDOR_H_

#include <iostream>
using namespace std;

class Contenedor{
	const int indefinido;
	int *arreglo;
	int MAX;
	int* reservarMemoria(unsigned int tama);
public:
		Contenedor(unsigned int dim, int indef);
		bool insertarElemento(int valor, int posicion);
		int  elemento(int posicion);
		bool eliminarElemento(int posicion);
		void escribir();
		int capacidad();
		~Contenedor();
		friend class IteradorInverso;
		friend class IteradorPar;

};

int* Contenedor::reservarMemoria(unsigned int tama){
	int *reserva = new int[tama];
	if(reserva==NULL){
		cout<<"Problema: no se pudo realizar la reserva";
	}
	return reserva;
}
Contenedor::Contenedor(unsigned int dim, int indef):indefinido(indef){
	this->MAX = dim;
	this->arreglo = reservarMemoria(this->MAX);
	if (this->arreglo ==NULL)
		this->MAX = 0;
	else
		for(int i=0;i<this->MAX;i++)
			this->arreglo[i]=this->indefinido;
}

bool Contenedor::insertarElemento(int valor, int posicion)
{
    bool resultado=  false;
	if(0<=posicion && posicion< this->MAX){
		this->arreglo[posicion] = valor;
		resultado =true;
	}
	return resultado;
}

int  Contenedor::elemento(int posicion){
	if(0<=posicion && posicion<this->MAX)
		return this->arreglo[posicion];
	else
		return this->indefinido;
}

bool Contenedor::eliminarElemento(int posicion){
	bool resultado = false;
	if(0<=posicion && posicion<this->MAX){
		this->arreglo[posicion]=this->indefinido;
		resultado = true;
	}
	return resultado;
}

int Contenedor::capacidad(){
	return this->MAX;
}
Contenedor::~Contenedor(){
	this->MAX = 0;
	delete [] this->arreglo;
};


#endif /* CONTENEDOR_H_ */
