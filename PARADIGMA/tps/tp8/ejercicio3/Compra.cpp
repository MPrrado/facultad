#include <sstream>
#include "Compra.h"

int Compra :: autoIncremental = 0;

Compra::Compra(vector<Producto*> listaProductos, Fecha* fechaCompra){

	//COMPLETAR INICIALIZACI�N DE ATRIBUTOS SI ES NECESARIO
	this->codigo = autoIncremental++;
	this->listaProductos = listaProductos;
	this->fechaCompra = fechaCompra;
	this->i = listaProductos.begin();
}


double Compra :: totalProductos(){

	double total=0;

	//COMPLETAR CON LA SUMA DE PRECIOS DE LOS PRODUCTOS COMPRADOS

	for (i; i < this->listaProductos.end() ; i++)
	{
		total += (*i)->getPrecio();
	}
	return total;
}


void Compra::escribirInfo(){
	cout<<"Codigo de compra: "<<this->codigo<<endl;
	cout<<"Fecha "<<this->fechaCompra<<endl;
	cout<<"Productos: "<<endl;
	cout<<"Codigo          Descricion                      Precio"<<endl;
	for ( i; i < this->listaProductos.end(); i++)
	{
		(*i)->resumenProducto();
	}
	
	//COMPLETAR MOSTRANDO POR PANTALLA EL RESUMEN DE
	//CADA UNO DE LOS PRODUCTOS DE LA COMPRA

}


Fecha Compra::getFecha(){
	return *this->fechaCompra;
}

Compra::~Compra() {
	//SI ES NECESARIO COMPLETAR EL DESTRUCTOR
	delete this->fechaCompra;
}
