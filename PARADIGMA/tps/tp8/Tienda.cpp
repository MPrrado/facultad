#include "Tienda.h"

Tienda::Tienda(string nomb, string dir) {
	this->nombre=nomb;
	this->direccion=dir;


	//COMPLETAR INICIALIZACIÓN DE ATRIBUTOS SI ES NECESARIO

}

void Tienda::generarCompra(/*COMPLETAR CON LOS PARAMETROS ADECUADOS*/){

	//COMPLETAR DE ACUERDO A LOS PARAMETROS RECIBIDOS

}


void Tienda::resumenCompras(int mes, int anio){

	cout<<"Tienda "<<this->nombre<<endl;
	cout<<"Direccion: "<<this->direccion<<endl;
	cout<<"Resumen compras: "<<mes<<"/"<<anio<<endl;

	//COMPLETAR MOSTRANDO POR PANTALLA LA INFORMACION DE CADA UNA DE LAS COMPRAS DE LA TIENDA
	//QUE SE HICIERON EN ESE MES/ANIO


}

Tienda::~Tienda() {
	//SI ES NECESARIO COMPLETAR EL DESTRUCTOR
}



