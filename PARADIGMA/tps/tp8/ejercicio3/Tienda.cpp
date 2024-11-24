#include "Tienda.h"
#include "CompraCuotas.h"
#include "CompraContado.h"

Tienda::Tienda(string nomb, string dir)
{
	this->nombre = nomb;
	this->direccion = dir;
	
	// COMPLETAR INICIALIZACI�N DE ATRIBUTOS SI ES NECESARIO
}

void Tienda::generarCompra(vector<Producto *> listaProductos, Fecha *fechaCompra)
{
	int tipoCompra;
	cout << "Seleccione tipo de compra: 1 para Contado, 2 para Cuotas: ";
	cin >> tipoCompra;
	Compra *nuevaCompra = nullptr;
	if (tipoCompra == 1)
	{
		nuevaCompra = new CompraContado(listaProductos, fechaCompra);
	}
	else if (tipoCompra == 2)
	{
		int cantidadCuotas;
		std::cout << "Ingrese la cantidad de cuotas (3 o 6): ";
		std::cin >> cantidadCuotas;
		nuevaCompra = new CompraCuotas(listaProductos, fechaCompra, cantidadCuotas);
	}
	if (nuevaCompra != nullptr)
	{
		listaCompras.push_back(nuevaCompra);
	}
}

void Tienda::resumenCompras(int mes, int anio)
{
	cout<<endl;
	cout << "Tienda " << this->nombre << endl;
	cout << "Direccion: " << this->direccion << endl;
	cout << "Resumen compras: " << mes << "/" << anio << endl;
	cout<<"-----------------------------------------------------------------------------------------"<<endl;
	vector<Compra*> :: iterator i;
	i = this->listaCompras.begin();
	for (i; i < listaCompras.end(); i++)
	{
		if((*i)->getFecha().getMes() == mes && (*i)->getFecha().getAnio() == anio)
		{
			(*i)->escribirInfo();
		}
	}
	
	// COMPLETAR MOSTRANDO POR PANTALLA LA INFORMACION DE CADA UNA DE LAS COMPRAS DE LA TIENDA
	// QUE SE HICIERON EN ESE MES/ANIO
}

Tienda::~Tienda()
{
	// SI ES NECESARIO COMPLETAR EL DESTRUCTOR
}
