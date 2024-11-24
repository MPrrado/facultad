#include "CompraContado.h"

CompraContado::CompraContado(vector<Producto *> listaProductos, Fecha* fechaCompra) : Compra(listaProductos, fechaCompra), DESCUENTO(0.15)
{
}

CompraContado::~CompraContado()
{
    vector<Producto*> :: iterator i;
	i = this->listaProductos.begin();
    for (i; i < this->listaProductos.end(); i++)
    {
        delete (*i);
    }
}

double CompraContado ::calcularMonto()
{
    double monto = this->totalProductos();
    return monto * (1 - this->DESCUENTO);
}

void CompraContado ::escribirInfo()
{
    Compra ::escribirInfo();
    cout << "SubTotal: " << this->totalProductos()<<endl;
    cout << "Total (DESCUENTO CONTADO): " << this->calcularMonto()<<endl;
}