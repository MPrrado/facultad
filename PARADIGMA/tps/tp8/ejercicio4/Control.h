#ifndef CONTROL_H_
#define CONTROL_H_
#include "Fecha.h"

class Control
{
    private:
        Fecha* fechaControl;
        string descripcion;
        double monto;
        Fecha* fecProxControl;
    public:
        Control(Fecha* fechaControl, string descripcion, double monto, Fecha* fecProxControl);
        ~Control();
        double GetMonto();
        Fecha* GetFechaControl();
        Fecha* GetFecProxControl();
        string GetDescripcion();
        void EscribirInfo();
};
#endif 