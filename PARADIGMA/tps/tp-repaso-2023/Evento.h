#ifndef EVENTO_H_
#define EVENTO_H_
#include "Servicio.h"
#include "Fecha.h"
#include <vector>
class Evento
{
    protected:
        const double INCREMENTO_EMPRESA = 0.1;
        static int autoincremental;
        int codigo;
        string descripcion;
        Fecha* fechaEvento;
        int cantidadPersona;
        vector<Servicio*> listaServicios;
        vector<Servicio*> :: iterator i;
    public:
        Evento(string descripcion, Fecha *fechaEvento, int cantidadPersona, vector<Servicio*> listaServiciosContratados);
        virtual ~Evento();
        virtual double GetMonto() = 0;
        virtual void ListarInfo();
        Fecha* GetFechaEvento();
        int GetCantidadServicios();
        int GetCodigoEvento();
    protected:
        double GetPrecioTarjeta();
};

#endif