#include "Evento.h"

int Evento:: autoincremental = 1;

Evento:: Evento(string descripcion, Fecha *fechaEvento, int cantidadPersona, vector<Servicio*> listaServiciosContratados)
{
    this->codigo = autoincremental;
    this->descripcion = descripcion;
    this->cantidadPersona = cantidadPersona;
    this->fechaEvento = fechaEvento;
    this->listaServicios = listaServiciosContratados;
    autoincremental++;
}
Evento:: ~Evento()
{   
}

double Evento:: GetPrecioTarjeta()
{
    double precioTarjeta = 0;
    this->i = this->listaServicios.begin();
    for (this->i; this->i < this->listaServicios.end(); this->i++)
    {
        precioTarjeta+= (*i)->GetMontoBase();
    }
    return precioTarjeta* (1+this->INCREMENTO_EMPRESA);
}

void Evento:: ListarInfo()
{
    cout<<"------------------------ INFORMACION EVENTO ------------------------"<<endl;
    cout<<"Codigo: "<<this->codigo<<endl;
    cout<<"Descripcion: "<<this->descripcion<<endl;
    cout<<"Fecha Evento: "<<this->fechaEvento->toString()<<endl;
    cout<<"Cantidad Personas: "<<this->cantidadPersona<<endl;

    this->i = this->listaServicios.begin();
    for (this->i; this->i < this->listaServicios.end(); this->i++)
    {
        (*i)->ListarInfo();
    }  
}

Fecha* Evento:: GetFechaEvento()
{
    return this->fechaEvento;
}

int Evento:: GetCantidadServicios()
{
    return this->listaServicios.size();
}

int Evento:: GetCodigoEvento()
{
    return this->codigo;
}