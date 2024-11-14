#ifndef COMPRA_H_
#define COMPRA_H_

#include <iostream>
#include "Producto.h"

using namespace std;

class Compra {

protected:
	int codigo;
	Fecha fechaCompra;

	//COMPLETAR ATRIBUTOS

	double totalProductos();

public:
	Compra(/*COMPLETAR CON LOS PARAMETROS ADECUADOS*/);

	double calcularMonto(); //MODIFICAR DE ACUERDO AL DISEÑO
	void escribirInfo();
	Fecha getFecha();
	virtual ~Compra();
};

#endif /* COMPRA_H_ */
