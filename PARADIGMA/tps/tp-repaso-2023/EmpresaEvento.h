#ifndef EMPRESAEVENTO_H_
#define EMPRESAEVENTO_H_
#include "Evento.h"
#include "EventoPersonal.h"
#include "EventoCorporativo.h"
class EmpresaEvento
{
    private:
        string direccion;
        vector<Evento*> listaEventos;
        vector<Evento*>:: iterator i;
    public:
        void AltaEvento(string descripcion, Fecha *fechaEvento, int cantidadPersona, vector<Servicio*> listaServiciosContratados, int cantidadPersonasExtra);
        void AltaEvento(string descripcion, Fecha *fechaEvento, int cantidadPersona, vector<Servicio*> listaServiciosContratados, string nombreInstitucion, bool esBenefico);
        void ResumenPorMes(short mes);
        EmpresaEvento(string direccion);
        ~EmpresaEvento();
};

#endif