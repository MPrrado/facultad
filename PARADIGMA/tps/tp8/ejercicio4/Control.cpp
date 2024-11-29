#include "Control.h"

double Control :: GetMonto()
{
    return this->monto;
}

Fecha* Control:: GetFechaControl()
{
    this->fechaControl;
}

Fecha* Control:: GetFecProxControl()
{
    this->fecProxControl;
}

string Control:: GetDescripcion()
{
    this->descripcion;
}

Control :: Control(Fecha* fechaControl, string descripcion, double monto, Fecha* fecProxControl)
{
    this->fechaControl = fechaControl;
    this->descripcion = descripcion;
    this->monto = monto;
    this->fechaControl = fecProxControl;
}

Control :: ~Control()
{
    
}
