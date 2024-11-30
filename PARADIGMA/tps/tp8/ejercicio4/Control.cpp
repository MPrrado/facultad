#include "Control.h"

double Control :: GetMonto()
{
    return this->monto;
}

Fecha* Control:: GetFechaControl()
{
    return this->fechaControl;
}

Fecha* Control:: GetFecProxControl()
{
    return this->fecProxControl;
}

string Control:: GetDescripcion()
{
   return this->descripcion;
}

void Control :: EscribirInfo()
{
    cout<<"------------------ CONTROL ------------------"<<endl;
    cout<<"Fecha Control: " <<this->fechaControl->toString()<<endl;
    cout<<"Descripcion: " <<this->descripcion<<endl;
    cout<<"Monto: " <<this->monto<<endl;
    cout<<"Fecha Proximo Control: " <<this->fecProxControl->toString()<<endl;
    cout<<"--------------------------------------------------------"<<endl;

}

Control :: Control(Fecha* fechaControl, string descripcion, double monto, Fecha* fecProxControl)
{
    this->fechaControl = fechaControl;
    this->descripcion = descripcion;
    this->monto = monto;
    this->fecProxControl = fecProxControl;
}

Control :: ~Control()
{
    
    
}
