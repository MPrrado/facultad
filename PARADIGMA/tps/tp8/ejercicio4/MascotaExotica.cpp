#include "MascotaExotica.h"

double MascotaExotica :: GetIncremento()
{
    return 0.1;
}

void MascotaExotica:: ListarInformacion()
{
    cout<<endl<<endl<<"MASCOTA EXOTICA!!"<<endl;
    Mascota::ListarInformacion();
    cout<<"Descripcion: "<<this->descripcion<<endl; 
}

MascotaExotica :: MascotaExotica(string nombre, Fecha* fecNac, string raza,string descripcion) : Mascota(nombre, fecNac, raza)
{
    this->descripcion = descripcion;
}

MascotaExotica :: ~MascotaExotica()
{
    this->i = this->controles.begin();
    for (this->i; this->i < this->controles.end(); this->i++)
    {
        (*i)->~Control();
    }
    
}