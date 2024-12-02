#include "Servicio.h"

int Servicio:: autoincremental = 1;

Servicio:: Servicio(string descripcion, double montoBase)
{
    this->codigo = autoincremental;
    this->descripcion = descripcion;
    this->montoBase = montoBase;
    autoincremental++;
}

Servicio:: ~Servicio()
{
}

double Servicio:: GetMontoBase()
{
    return this->montoBase;
}

void Servicio:: ListarInfo()
{
    cout<<"---------------- INFORMACION SERVICIO ----------------"<<endl;
    cout<<"Codigo: "<<this->codigo<<endl;
    cout<<"Descripcion: "<<this->descripcion<<endl;
    cout<<"Monto Base: $"<<this->montoBase<<endl;
    cout<<"---------------------------------------------------------"<<endl;
}