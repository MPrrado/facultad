#include <sstream>
#include "Compra.h"

int Compra :: autoIncremental = 1;

Compra::Compra(vector<Producto*> listaProductos, Fecha* fechaCompra){

	//COMPLETAR INICIALIZACI�N DE ATRIBUTOS SI ES NECESARIO
	this->codigo = autoIncremental;
	this->listaProductos = listaProductos;
	this->fechaCompra = fechaCompra;
	autoIncremental++;
}


double Compra :: totalProductos(){

	double total=0;

	//COMPLETAR CON LA SUMA DE PRECIOS DE LOS PRODUCTOS COMPRADOS
	vector<Producto*> :: iterator i;
	i = this->listaProductos.begin();
	for (i; i < this->listaProductos.end() ; i++)
	{
		total += (*i)->getPrecio();
	}
	return total;
}


void Compra::escribirInfo(){
	cout<<"Codigo de compra: "<<this->codigo<<endl;
	cout<<"Fecha "<<this->fechaCompra->toString()<<endl;
	cout<<"Productos: "<<endl;
	cout<<"Codigo          Descripcion                      Precio"<<endl;
	vector<Producto*> :: iterator i;
	i = this->listaProductos.begin();
	for (i; i < this->listaProductos.end(); i++)
	{
		cout<<(*i)->resumenProducto()<<endl;
	}
	cout<<"TOTAL COMPRA: $"<<this->calcularMonto()<<endl;
	
	
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
