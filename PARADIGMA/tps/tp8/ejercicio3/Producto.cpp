#include <sstream>
#include "Producto.h"

Producto::Producto(int cod, string descr, double precio) {
	this->codigo = cod;
	this->descripcion = descr;
	this->precio = precio;
}

double Producto::getPrecio(){
	return this->precio;
}

string Producto::resumenProducto(){
	stringstream flujo;
	flujo << this->codigo <<" --------------- "<< this->descripcion <<" --------------- $"<< this->precio<<endl;
	return string(flujo.str());
}

Producto::~Producto() {
}

