#include "venta.h"

int Venta :: autoincremental = 0;

Fecha Venta:: GetFechaVenta()
{
    return *this->fechaVenta;
}

void Venta:: MostarDatos()
{
    cout<<endl;
    cout<<endl;
    cout<<endl;
    cout<<"------------------- INFORMACION DE LA VENTA -------------------"<<endl;
    vector<Lectura*> :: iterator i;
    i = this->articulosVendidos.begin();
    cout<<endl;
    cout<<"------- ARTICULOS ------"<<endl;
    cout<<endl;
    for (i; i < this->articulosVendidos.end(); i++)
    {
        (*i)->MostrarInfo();
    }
}

double Venta:: CalcularTotal()
{
    double total = 0;
    vector<Lectura*> :: iterator i;
    i = this->articulosVendidos.begin();
    for (i; i < this->articulosVendidos.end(); i++)
    {
        total += (*i)->GetPrecioVenta();
    }
    return total;
}

Venta :: Venta(vector<Lectura*> listaArticuloVenta)
{
    autoincremental++;
    this->codigoVenta = autoincremental;
    this->fechaVenta = new Fecha();
    this->articulosVendidos = listaArticuloVenta;
}

Venta :: ~Venta()
{
    delete this->fechaVenta;
}
