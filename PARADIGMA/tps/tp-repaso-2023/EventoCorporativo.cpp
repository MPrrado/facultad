#include "EventoCorporativo.h"

EventoCorporativo:: EventoCorporativo(string descripcion, Fecha *fechaEvento, int cantidadPersona, vector<Servicio*> listaServiciosContratados, string nombreInstitucion, bool esBenefico): Evento(descripcion, fechaEvento, cantidadPersona, listaServiciosContratados)
{
    this->nombreInstitucion = nombreInstitucion;
    this->esEventoBenefico = esBenefico;
}

EventoCorporativo:: ~EventoCorporativo()
{

}

double EventoCorporativo:: GetMonto()
{
    double monto = 0;
    if(this->cantidadPersona < 100 )
    {
        monto = this->GetPrecioTarjeta() * 100;
    }else
    {
        monto = this->GetPrecioTarjeta() * this->cantidadPersona;
    }
    if(this->esEventoBenefico)
    {
        monto*=(1-this->DESCUENTO_BENEFICO);
    }
    return monto;
}

void EventoCorporativo:: ListarInfo()
{
    Evento::ListarInfo();
    cout<<"Nombre Institucion:"<<this->nombreInstitucion<<endl;
    if(this->esEventoBenefico)
    {
        cout<<"ES EVENTO A BENEFICIO"<<endl;
    }
    cout<<"--------------------------------------------------------"<<endl;
}