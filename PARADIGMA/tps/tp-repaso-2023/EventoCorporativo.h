#ifndef EVENTOCORPORATIVO_H_
#define EVENTOCORPORATIVO_H_
#include "Evento.h"
class EventoCorporativo : public Evento
{
    private:
        const double DESCUENTO_BENEFICO = 0.15;
        string nombreInstitucion;
        bool esEventoBenefico;
    public:
        EventoCorporativo(string descripcion, Fecha *fechaEvento, int cantidadPersona, vector<Servicio*> listaServiciosContratados, string nombreInstitucion, bool esBenefico);
        ~EventoCorporativo();
        double GetMonto();
        void ListarInfo();
};

#endif