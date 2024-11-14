#include <sstream>
#include "Compra.h"

Compra::Compra(/*COMPLETAR CON LOS PARAMETROS ADECUADOS*/){

	//COMPLETAR INICIALIZACIÓN DE ATRIBUTOS SI ES NECESARIO

}


double Compra::calcularMonto(){

	//MODIFICAR DE ACUERDO AL DISEÑO

	return 0;

};

double totalProductos(){

	double total=0;

	//COMPLETAR CON LA SUMA DE PRECIOS DE LOS PRODUCTOS COMPRADOS

	return total;
}


void Compra::escribirInfo(){
	cout<<"Codigo de compra: "<<this->codigo<<endl;
	cout<<"Fecha "<<this->fechaCompra<<endl;
	cout<<"Productos: "<<endl;
	cout<<"Codigo          Descricion                      Precio"<<endl;

	//COMPLETAR MOSTRANDO POR PANTALLA EL RESUMEN DE
	//CADA UNO DE LOS PRODUCTOS DE LA COMPRA

}


Fecha Compra::getFecha(){
	return this->fechaCompra;
}

Compra::~Compra() {
	//SI ES NECESARIO COMPLETAR EL DESTRUCTOR
}
