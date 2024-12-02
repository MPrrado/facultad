#ifndef EVENTOPERSONAL_H_
#define EVENTOPERSONAL_H_
#include "Evento.h"

class EventoPersonal: public Evento
{
    private:
        const double DESCUENTO_EXTRAS = 0.4;
        int cantidadPersonasExtra;

    public:
        EventoPersonal(string descripcion, Fecha *fechaEvento, int cantidadPersona, vector<Servicio*> listaServiciosContratados, int cantidadPersonasExtra);
        ~EventoPersonal();
        double GetMonto();
        void ListarInfo();
};

#endif