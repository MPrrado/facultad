#ifndef TIENDA_H_
#define TIENDA_H_

#include <iostream>
#include "Compra.h"

class Tienda {
	string nombre;
	string direccion;

	//COMPLETAR ATRIBUTOS

public:
	Tienda(string nomb, string dir);
	void generarCompra(/*COMPLETAR CON LOS PARAMETROS ADECUADOS*/);
	void resumenCompras(int mes, int anio);
	virtual ~Tienda();
};

#endif /* TIENDA_H_ */
