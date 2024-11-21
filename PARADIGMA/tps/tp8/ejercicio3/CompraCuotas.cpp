#include "CompraCuotas.h"
const double CompraCuotas :: INTERES3CUOTAS = 0.1;
const double CompraCuotas :: INTERES6CUOTAS = 0.2;

CompraCuotas::CompraCuotas(vector<Producto*> listaProductos, Fecha* fechaCompra, int cantidadCuotas): Compra(listaProductos, fechaCompra), cantidadCuotas(cantidadCuotas)
{
}

CompraCuotas::~CompraCuotas()
{
}

double CompraCuotas :: calcularMonto()
{
    double monto = this->totalProductos();
    if(this->cantidadCuotas == 3)
    {
        monto*=(1-INTERES3CUOTAS);
    }
    else
    {
        if(this->cantidadCuotas == 6)
        {
            monto *= (1-INTERES6CUOTAS);
        }
    }
    return monto;
}

void CompraCuotas :: escribirInfo()
{
    Compra :: escribirInfo();
    cout<<"Total: "<<this->totalProductos()<<endl;
    cout<<"Cuotas: "<<this->cantidadCuotas<<endl;
    cout<<"Total (CON INTERES)"<<this->calcularMonto()<<endl;
}