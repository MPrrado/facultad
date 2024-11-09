#include "Lectura.h"
int Lectura :: codigoAutoincremental = 0;

int Lectura :: GetCodigo()
{
    return this->codigo;
}

void Lectura:: MostrarInfo()
{
    cout << "---------------------- INFORMACION PRODUCTO ----------------------"<<endl;
    cout<<"Codigo: "<<this->codigo<<endl;
    cout<<"Titulo: "<<this->titulo<<endl;
    cout<<"Año Edicion: "<<this->anioEdicion<<endl;
    cout<<"Precio Base: "<<this->precioBase<<endl;
}

double Lectura :: GetPrecioVenta()
{
    return CalcularPrecioFinal();
}

Lectura :: Lectura(string titulo, int anioEdicion, double precioBase)
{
    codigoAutoincremental++;
    this->codigo = codigoAutoincremental;
    this->titulo = titulo;
    this->anioEdicion = anioEdicion;
    this->precioBase = precioBase;
}
