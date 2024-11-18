#include "IteradorInverso.h"
IteradorInverso :: IteradorInverso(Contenedor &c): IteradorGeneralizacion(c, c.capacidad()-1)
{
}
IteradorInverso :: ~IteradorInverso()
{   
}

bool IteradorInverso :: HayElementos()
{
    return posicionIterador >= 0;
}

void IteradorInverso :: Avanzar()
{
    if(HayElementos())
    {
        this->posicionIterador--;
    }else
    {
        cout<<"ERROR NO HAY MAS ELEMENTOS PARA ITERAR"<<endl;
    }
}
int IteradorInverso :: GetDatoContenedor()
{
        return contenedor.arreglo[this->posicionIterador];
}
