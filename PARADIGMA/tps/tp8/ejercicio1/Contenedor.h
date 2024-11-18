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
#endif /* CONTENEDOR_H_ */
