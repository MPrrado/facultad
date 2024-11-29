#include "Mascota.h"

Mascota :: Mascota(string nombre, Fecha* fecNac, string raza)
{
    this->nombre = nombre;
    this->fecNac = fecNac;
    this->raza = raza;
}

Mascota :: ~Mascota()
{
}

void Mascota :: AltaControl(Fecha* fecha, string descripcion, double monto,Fecha* fecProxContol)
{
    Control* controlNuevo = new Control(fecha,descripcion,monto*(1-this->GetIncremento()),fecProxContol);
    this->controles.push_back(controlNuevo); 
}

double Mascota :: GetMonto(short mes, short anio)
{
    double monto = 0;
    i = this->controles.begin();
    for (i; i < this->controles.end(); i++)
    {
        if(((*i)->GetFechaControl()->getMes() == mes) && ((*i)->GetFechaControl()->getAnio() == anio))
        {
            monto+=(*i)->GetMonto();
        }
    }
    return monto;
}

bool Mascota :: TieneControlPronto()
{
    
}


