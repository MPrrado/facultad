#include "EventoPersonal.h"

EventoPersonal:: EventoPersonal(string descripcion, Fecha *fechaEvento, int cantidadPersonas, vector<Servicio*> listaServiciosContratados,int cantidadPersonasExtra): Evento(descripcion, fechaEvento, cantidadPersonas, listaServiciosContratados)
{
    this->cantidadPersonasExtra = cantidadPersonasExtra;
}

EventoPersonal:: ~EventoPersonal()
{
}

double EventoPersonal:: GetMonto()
{
    return ((this->GetPrecioTarjeta()*this->cantidadPersona) + ((this->GetPrecioTarjeta()*cantidadPersonasExtra) * (1-this->DESCUENTO_EXTRAS)));
}

void EventoPersonal:: ListarInfo()
{
    Evento:: ListarInfo();
    cout<<"PERSONAS EXTRAS: "<<this->cantidadPersonasExtra<<endl;
    cout<<"--------------------------------------------------------------"<<endl;
}