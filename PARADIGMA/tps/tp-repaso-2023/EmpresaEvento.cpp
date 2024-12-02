#include "EmpresaEvento.h"
EmpresaEvento::EmpresaEvento(string direccion)
{
    this->direccion = direccion;
}

EmpresaEvento:: ~EmpresaEvento()
{
    this->i = this->listaEventos.begin();
    for ( this->i; this->i < this->listaEventos.end(); this->i++)
    {
        (*i)->~Evento();
    }
    
}

void EmpresaEvento::AltaEvento(string descripcion, Fecha *fechaEvento, int cantidadPersona, vector<Servicio *> listaServiciosContratados, int cantidadPersonasExtra)
{
    EventoPersonal *eventoPersonal = new EventoPersonal(descripcion, fechaEvento, cantidadPersona, listaServiciosContratados, cantidadPersonasExtra);
    this->listaEventos.push_back(eventoPersonal);
}

void EmpresaEvento::AltaEvento(string descripcion, Fecha *fechaEvento, int cantidadPersona, vector<Servicio *> listaServiciosContratados, string nombreInstitucion, bool esBenefico)
{
    EventoCorporativo *eventoCorporativo = new EventoCorporativo(descripcion, fechaEvento, cantidadPersona, listaServiciosContratados, nombreInstitucion, esBenefico);
    this->listaEventos.push_back(eventoCorporativo);
}

void EmpresaEvento::ResumenPorMes(short mes)
{
    double monto = 0;
    this->i = this->listaEventos.begin();
    Fecha *fecAct = new Fecha();
    cout << "-------------------------- RESUMEN MES ------------------------------------" << endl;
    for (this->i; this->i < this->listaEventos.end(); this->i++)
    {
        if ((*i)->GetFechaEvento()->getAnio() == fecAct->getAnio() && (*i)->GetFechaEvento()->getMes() == mes)
        {
            cout << "Codigo Evento: " << (*i)->GetCodigoEvento() << endl;
            cout << "Fecha Evento: " << (*i)->GetFechaEvento()->toString() << endl;
            cout << "Cantidad Servicios Contratados: " << (*i)->GetCantidadServicios() << endl;
            cout << "Monto Evento: $" << (*i)->GetMonto() << endl;
            (*i)->ListarInfo();
            monto += (*i)->GetMonto();
            cout << "---------------------------------------------------------------------" << endl;
        }
    }
    cout << "MONTO TOTAL RECAUDADO EN EL MES: " << monto << endl;

    delete fecAct;
}