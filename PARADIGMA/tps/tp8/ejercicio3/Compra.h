#ifndef COMPRA_H_
#define COMPRA_H_

#include <iostream>
#include "Producto.h"
#include <vector>
using namespace std;

class Compra {

protected:
	static int autoIncremental;
	int codigo;
	Fecha* fechaCompra;
	vector<Producto*> listaProductos;
	//COMPLETAR ATRIBUTOS

	double totalProductos();

public:
	Compra(vector<Producto*> listaProductos, Fecha* fechaCompra);
	virtual double calcularMonto() = 0; //MODIFICAR DE ACUERDO AL DISE�O
	void escribirInfo();
	Fecha getFecha();
	virtual ~Compra();
};

#endif 
