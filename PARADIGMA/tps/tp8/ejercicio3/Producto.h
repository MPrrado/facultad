#ifndef PRODUCTO_H_
#define PRODUCTO_H_

#include <iostream>
#include "Fecha.h"

using namespace std;

class Producto {
	int codigo;
	string descripcion;
	double precio;

public:
	Producto(int cod, string descr, double precio);
	double getPrecio();
	string resumenProducto();
	virtual ~Producto();
};

#endif /* PRODUCTO_H_ */
