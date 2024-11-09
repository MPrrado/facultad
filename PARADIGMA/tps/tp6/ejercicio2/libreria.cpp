#include "libreria.h"
#include "libro.h"
#include "revista.h"

void Libreria :: CrearVenta(vector<Lectura*> listaArticulosVendidos)
{
    Venta *ventaNueva = new Venta(listaArticulosVendidos);
    this->listaVentas.push_back(ventaNueva);
}

void Libreria :: CargarArticulo(Lectura *articuloNuevo)
{
     this->stockArticulos.push_back(articuloNuevo);
}

void Libreria :: ListarInfoVentaSegunFecha(Fecha* fecha)
{
    vector<Venta*>:: iterator i;
    i = this->listaVentas.begin();
    for (i ; i < this->listaVentas.end(); i++)
    {
        if((*fecha) ==(*i)->GetFechaVenta() )
        {
            (*i)->MostarDatos();
        }
    }
}

Libreria :: Libreria()
{
    this->cantidadVentas = 0;
}

Libreria :: ~Libreria()
{
    vector<Venta*> :: iterator i;
    i = this->listaVentas.begin();
    for (i; i < this->listaVentas.end(); i++)
    {
        delete (*i);
    }
}