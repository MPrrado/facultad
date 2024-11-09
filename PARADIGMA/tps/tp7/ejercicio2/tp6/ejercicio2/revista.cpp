#include "revista.h"
Fecha Revista :: fecAct;
void Revista :: MostrarInfo()
{
    Lectura :: MostrarInfo();
    cout << "Numero Revista : "<< this->nroRevista<<endl;
    cout << "Volumen: "<< this->volumen<<endl;
    cout << "Tematica: "<< this->tematica<<endl;
}

string Revista :: GetTematica()
{
    return  this->tematica;
}

double Revista :: CalcularPrecioFinal()
{
    double precioFinal = this->precioBase;
    int antiguedad = fecAct.getAnio() - this->anioEdicion;
    if(antiguedad > 5)
    {
        precioFinal *=0.85;
    }
    return precioFinal * 1.21;
}

Revista :: Revista(string titulo, int anioEdicion, double precioBase,int nroRevista, int volumen, string tematica): Lectura(titulo, anioEdicion, precioBase)
{
    this->nroRevista = nroRevista;
    this->volumen = volumen;
    this->tematica = tematica;
}
