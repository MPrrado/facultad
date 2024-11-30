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
    Control* controlNuevo = new Control(fecha,descripcion,monto*(1+this->GetIncremento()),fecProxContol);
    this->controles.push_back(controlNuevo); 
}

double Mascota :: GetMonto(short mes, short anio)
{
    double monto = 0;
    this->i = this->controles.begin();
    for (this->i; this->i < this->controles.end(); this->i++)
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
    this->i = this->controles.begin();
    *(this->i) = this->controles.back();
    Fecha *fecAct = new Fecha;
    Fecha *fechaProxControl = (*i)->GetFecProxControl();
    int diff =  *fechaProxControl - *fecAct;
    delete fecAct;
    return(diff < 5);
}

void Mascota :: ListarInformacion()
{
    cout<<"-------------------------- INFORMACION MASCOTA --------------------------"<<endl;
    cout<<"Nombre: "<<this->nombre<<endl;
    cout<<"Fecha Nacimiento: "<<this->fecNac->toString()<<endl;
    cout<<"Raza: "<<this->raza<<endl;
    this->i = this->controles.begin();
    for (i ; i < this->controles.end(); i++)
    {
        (*i)->EscribirInfo();
    }
    if(this->TieneControlPronto())
    {
        cout<<"SU MASCOTA TIENE CONTROL PRONTO!!!!!"<<endl;
    }
    
}

string Mascota:: GetNombre()
{
    return this->nombre;
}


