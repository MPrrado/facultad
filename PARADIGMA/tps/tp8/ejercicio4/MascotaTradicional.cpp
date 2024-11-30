#include "MascotaTradicional.h"

double MascotaTradicional :: GetIncremento()
{
    return 0;
}

MascotaTradicional:: MascotaTradicional(string nombre, Fecha* fecNac, string raza): Mascota(nombre,fecNac,raza)
{

}

MascotaTradicional:: ~MascotaTradicional()
{
    this->i = this->controles.begin();
    for (this->i; this->i < this->controles.end(); this->i++)
    {
        (*i)->~Control();
    }
}
