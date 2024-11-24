#ifndef TIENDA_H_
#define TIENDA_H_

#include <iostream>
#include "Compra.h"
#include <vector>
class Tienda {
	string nombre;
	string direccion;
	vector<Compra*> listaCompras;
	//COMPLETAR ATRIBUTOS

public:
	Tienda(string nomb, string dir);
	void generarCompra(vector<Producto*> listaProductos, Fecha* fechaCompra);
	void resumenCompras(int mes, int anio);
	virtual ~Tienda();
};

#endif /* TIENDA_H_ */
